<?php

namespace App\Controller;

use App\Entity\Image;
use App\Entity\Trick;
use App\Entity\Comment;
use App\Entity\Video;
use App\Form\TrickType;
use App\Form\CommentType;
use App\Service\ImageUploader;
use App\Service\SlugGenerator;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;

#[Route('/trick')]
class TrickController extends AbstractController
{
    #[Route('/new', name: 'app_trick_new', methods: ['GET', 'POST'])]
    public function new(Request $request, EntityManagerInterface $entityManager, ImageUploader $imageUploader, SlugGenerator $slugGenerator): Response
    {
        $trick = new Trick();
        $form = $this->createForm(TrickType::class, $trick);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            /** @var UploadedFile $primaryImageData */
            $primaryImageData = $form->get('primary_image')->getData();
            $primaryImage = new Image();
            $imageName = $imageUploader->upload($primaryImageData);
            $primaryImage->setName($imageName);
            $trick->setPrimaryImage($primaryImage);
            $entityManager->persist($primaryImage);

            $parentImagesForm = $form->get('images');

            foreach ($parentImagesForm as $imageForm) {
                $image = $imageForm->getData();
                $imageData = $imageForm->get('name')->getData();
                $imageName = $imageUploader->upload($imageData);
                $image->setName($imageName);
                $trick->addImage($image);
                $entityManager->persist($image);
            }

            $videoNames = $form->get('videos')->getData();
            foreach ($videoNames as $videoName) {
                $video = new Video();
                $video->setLink($videoName);
                $trick->addVideo($video);
                $entityManager->persist($video);
            }

            $trick->setAuthor($this->getUser());
            $trick->setSlug($slugGenerator->generateSlug($trick->getName()));
            $entityManager->persist($trick);

            $entityManager->flush();
            $this->addFlash('success', 'Le figure a bien été ajoutée !');
            return $this->redirectToRoute('app_home', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('trick/new.html.twig', [
            'trick' => $trick,
            'form' => $form,
        ]);
    }

    #[Route('/{slug}', name: 'app_trick_show', methods: ['GET', 'POST'])]
    public function show(Trick $trick, Request $request, EntityManagerInterface $entityManager): Response
    {
        $form = $this->createForm(CommentType::class);

        if ($request->isMethod('POST')) {
            $this->denyAccessUnlessGranted('IS_AUTHENTICATED');

            $comment = new Comment();
            $form = $this->createForm(CommentType::class, $comment);
            $form->handleRequest($request);

            if ($form->isSubmitted() && $form->isValid()) {
                $comment->setAuthor($this->getUser());
                $comment->setTrick($trick);

                try {
                    $entityManager->persist($comment);
                    $entityManager->flush();
                    $this->addFlash('success', 'Le commentaire a bien été ajouté !');
                } catch (\Throwable $th) {
                    $this->addFlash('danger', 'Le commentaire n\'a pas pu être ajouté :( ');
                }
            }
        }

        return $this->render('trick/show.html.twig', [
            'trick' => $trick,
            'form' => $form,
        ]);
    }

    #[Route('/{id}/edit', name: 'app_trick_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Trick $trick, EntityManagerInterface $entityManager, ImageUploader $imageUploader): Response
    {
        $form = $this->createForm(TrickType::class, $trick);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            /** @var UploadedFile $primaryImageData */
            $primaryImageData = $form->get('primary_image')->getData();
            if ($primaryImageData) {
                $primaryImage = $trick->getPrimaryImage();
                $imageName = $imageUploader->upload($primaryImageData);
                $primaryImage->setName($imageName);
                $trick->setPrimaryImage($primaryImage);
            }

            $parentImagesForm = $form->get('images');
            foreach ($parentImagesForm as $imageForm) {
                $image = $imageForm->getData();
                $imageData = $imageForm->get('name')->getData();
                $imageName = $imageUploader->upload($imageData);
                $image->setName($imageName);
                $trick->addImage($image);
                $entityManager->persist($image);
            }

            $entityManager->flush();
            $this->addFlash('success', sprintf(
                'La figure %s a bien été modifiée',
                $trick->getName(),
            ));

            return $this->redirectToRoute('app_home', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('trick/edit.html.twig', [
            'trick' => $trick,
            'form' => $form,
        ]);
    }

    #[Route('/delete/image/{id}', name: 'app_trick_delete_image')]
    public function removeImage(Image $image, EntityManagerInterface $entityManager): JsonResponse
    {
        try {
            $entityManager->remove($image);
            $entityManager->flush();
        } catch (\Throwable $th) {
            throw $th;
        }

        return $this->json([
             'success' => true,
        ]);

    }

    #[Route('/delete/{id}', name: 'app_trick_delete', methods: ['POST'])]
    public function delete(Request $request, Trick $trick, EntityManagerInterface $entityManager): Response
    {
        if ($this->isCsrfTokenValid('delete' . $trick->getId(), $request->request->get('_token'))) {
            $entityManager->remove($trick);
            $entityManager->flush();
        }

        return $this->redirectToRoute('app_home', [], Response::HTTP_SEE_OTHER);
    }
}

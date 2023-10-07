<?php

namespace App\Controller;

use App\Repository\TrickRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class HomeController extends AbstractController
{
    #[Route('/', name: 'app_home')]
    public function index(TrickRepository $trickRepository, Request $request): Response
    {
        $page = $request->query->getInt('page', 1);
        $itemsPerPage = 15;
        $offset = ($page - 1) * $itemsPerPage;

        $queryBuilder = $trickRepository->createQueryBuilder('t');
        $queryBuilder
            ->setFirstResult($offset)
            ->setMaxResults($itemsPerPage);

        $tricks = $queryBuilder->getQuery()->getResult();

        $totalItems = $trickRepository->createQueryBuilder('t')->select('COUNT(t.id)')->getQuery()->getSingleScalarResult();
        $totalPages = ceil($totalItems / $itemsPerPage);

        return $this->render('home/index.html.twig', [
            'tricks' => $tricks,
            'page' => $page,
            'totalPages' => $totalPages,
        ]);
    }
}

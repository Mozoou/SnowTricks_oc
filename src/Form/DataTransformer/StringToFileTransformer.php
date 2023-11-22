<?php

namespace App\Form\DataTransformer;

use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Form\DataTransformerInterface;
use Symfony\Component\Form\Exception\TransformationFailedException;
use Symfony\Component\HttpFoundation\File\File;

class StringToFileTransformer implements DataTransformerInterface
{
    public function __construct(
        private string $imageDirectory,
        private EntityManagerInterface $em,
    ) {
    }

    /**
     * Transforms an string (imageName) to a Symfony\Component\HttpFoundation\File\File
     *
     * @param  string|null $imageName
     *
     * @throws TransformationFailedException
     * @return null|File
     */
    public function transform($imageName): ?File
    {
        if (null === $imageName) {
            return null;
        }

        try {
            $filePath = realpath($this->imageDirectory.'/'.$imageName);
            $file = new File($filePath);
            return $file;
        } catch (\Throwable $th) {
            //TODO: mettre un event sur TransformationFailedException (delete l'entité correspondante).
            throw new TransformationFailedException(
                sprintf(
                    'L\'image : %s est inexistante',
                    $imageName
                )
            );
        }
    }

    /**
     * Return the file as it is
     *
     * @param  File $file
     *
     * @return File
     */
    public function reverseTransform($file): File
    {
        return $file;
    }
}

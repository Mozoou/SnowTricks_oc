<?php

namespace App\Twig;

use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use Twig\Extension\AbstractExtension;
use Twig\TwigFunction;

class AppExtension extends AbstractExtension
{
    public function __construct(private ParameterBagInterface $parameterBag)
    {
        $this->parameterBag = $parameterBag;
    }

    public function getFunctions()
    {
        return [
            new TwigFunction('image_exists', [$this, 'imageExists']),
        ];
    }

    public function ImageExists(string $fileName): bool
    {
        return file_exists($this->parameterBag->get('kernel.project_dir').'/public/uploads/images/'.$fileName);
    }
}

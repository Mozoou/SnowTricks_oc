<?php

namespace App\Form;

use App\Entity\Image;
use App\Form\DataTransformer\StringToFileTransformer;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\FileType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Validator\Constraints as Assert;

class ImageType extends AbstractType
{
    public function __construct(
        private StringToFileTransformer $transformer,
    ) {
    }

    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('name', FileType::class, [
                'label' => false,
                'required' => false,
                'help' => 'Les images ne doivent pas dépasser 3 MB',
                'constraints' => [
                    new Assert\Image(maxSize: '3M')
                ],
                'data_class' => null
            ])
        ;
        $builder->get('name')
            ->addModelTransformer($this->transformer);
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Image::class,
        ]);
    }
}

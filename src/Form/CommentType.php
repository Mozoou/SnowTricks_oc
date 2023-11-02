<?php

namespace App\Form;

use App\Entity\Comment;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class CommentType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('content', TextareaType::class, [
                'label' => false,
                'row_attr' => [
                    'class' => 'flex-grow-1 me-2',
                ]
            ])
            ->add('submit', SubmitType::class, [
                'label' => 'Ajouter un commentaire',
                'row_attr' => [
                    'class' => 'd-grid gap-2 my-2 d-md-block md-align-self-center',
                ]
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Comment::class,
            'attr' => [
                'class' => 'd-md-flex justify-content-between w-100',
            ]
        ]);
    }
}

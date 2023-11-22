<?php

namespace App\DataFixtures;

use App\Entity\Category;
use App\Entity\Image;
use App\Entity\Trick;
use App\Entity\User;
use App\Service\SlugGenerator;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;

class AppFixtures extends Fixture
{
    public function __construct(
        private UserPasswordHasherInterface $userPasswordHasherInterface,
        private SlugGenerator $slugGenerator,
    ) {
    }

    public function load(ObjectManager $manager): void
    {
        $admin = new User();
        $admin->setEmail('admin@example.com');
        $admin->setUsername('Administrateur');
        $hashedPassword = $this->userPasswordHasherInterface->hashPassword(
            $admin,
            'admin'
        );
        $admin->setPassword($hashedPassword);
        $manager->persist($admin);

        $users = [];
        for ($i = 0; $i < 4; $i++) {
            $user = new User();
            $user->setEmail('user' . $i . '@example.com');
            $user->setUsername('User' . $i);
            $hashedPassword = $this->userPasswordHasherInterface->hashPassword(
                $user,
                'user'
            );
            $user->setPassword($hashedPassword);
            $users[] = $user;
            $manager->persist($user);
        }

        $tricks = [
            'Ollie' => 'Saut en faisant pression sur la queue de la planche pour décoller.',
            'Nollie' => 'Saut en utilisant la partie avant de la planche pour décoller.',
            'Frontside 180' => 'Demi-tour dans le sens des aiguilles d\'une montre (rider régulier) ou inverse (goofy).',
            'Backside 180' => 'Demi-tour dans le sens inverse des aiguilles d\'une montre (rider régulier) ou des aiguilles d\'une montre (goofy).',
            'Indy Grab' => 'Attraper la carre de la planche entre les pieds avec la main avant.',
            'Method Grab' => 'Saisir la planche tout en la tirant vers le haut avec la main arrière en position aérienne.',
            'Tail Grab' => 'Saisir la partie arrière (la queue) de la planche avec la main arrière.',
            'Nose Grab' => 'Saisir la partie avant (le nez) de la planche avec la main avant.',
            '540°' => 'Effectuer un tour complet de 540 degrés dans les airs.',
            'Double Cork' => 'Deux rotations horizontales avec deux flips en l\'air.',
        ];

        $categories = [];
        for ($i = 0; $i < 3; $i++) {
            $categorie = new Category();
            $categorie->setName('Categorie ' . $i);
            $categories[] = $categorie;

            $manager->persist($categorie);
        }

        foreach ($tricks as $name => $description) {
            $trick = new Trick();
            $trick->setName($name);
            $trick->setSlug($this->slugGenerator->generateSlug($name));
            $trick->setDescription($description);
            $trick->setCategory($categories[rand(0, 2)]);
            $trick->setCreatedAt(new \DateTimeImmutable());
            $trick->setUpdatedAt(new \DateTimeImmutable());
            $trick->setAuthor($users[rand(0, 3)]);

            $image = new Image();
            $image->setName('default.jpg');
            $manager->persist($image);

            $trick->setPrimaryImage($image);
            $manager->persist($trick);
        }

        $manager->flush();
    }
}

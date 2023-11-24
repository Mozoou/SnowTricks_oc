-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 24, 2023 at 06:03 AM
-- Server version: 8.0.35-0ubuntu0.22.04.1
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `snowtricks`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`) VALUES
(1, 'Categorie 0'),
(2, 'Categorie 1'),
(3, 'Categorie 2');

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

CREATE TABLE `comment` (
  `id` int NOT NULL,
  `author_id` int NOT NULL,
  `trick_id` int NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comment`
--

INSERT INTO `comment` (`id`, `author_id`, `trick_id`, `created_at`, `content`) VALUES
(1, 1, 17, '2023-11-22 22:19:31', 'Wow quelle figure !');

-- --------------------------------------------------------

--
-- Table structure for table `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20231006093539', '2023-11-17 12:01:45', 277),
('DoctrineMigrations\\Version20231006094818', '2023-11-17 12:01:46', 18),
('DoctrineMigrations\\Version20231007093259', '2023-11-17 12:01:46', 171),
('DoctrineMigrations\\Version20231007094229', '2023-11-17 12:01:46', 47),
('DoctrineMigrations\\Version20231007133818', '2023-11-17 12:01:46', 176),
('DoctrineMigrations\\Version20231009183135', '2023-11-17 12:01:46', 84),
('DoctrineMigrations\\Version20231013210003', '2023-11-17 12:01:46', 16),
('DoctrineMigrations\\Version20231022101516', '2023-11-17 12:01:46', 147),
('DoctrineMigrations\\Version20231119193009', '2023-11-19 19:30:24', 86);

-- --------------------------------------------------------

--
-- Table structure for table `image`
--

CREATE TABLE `image` (
  `id` int NOT NULL,
  `trick_id` int DEFAULT NULL,
  `name` varchar(400) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `image`
--

INSERT INTO `image` (`id`, `trick_id`, `name`) VALUES
(1, NULL, 'default.jpg'),
(2, NULL, 'default.jpg'),
(3, NULL, 'default.jpg'),
(4, NULL, 'default.jpg'),
(5, NULL, 'default.jpg'),
(6, NULL, 'default.jpg'),
(7, NULL, 'default.jpg'),
(8, NULL, 'default.jpg'),
(9, NULL, 'default.jpg'),
(10, NULL, 'default.jpg'),
(30, NULL, 'avatar-65576223912a8.png'),
(41, 17, 'avatar-655a2786c7e36.png');

-- --------------------------------------------------------

--
-- Table structure for table `messenger_messages`
--

CREATE TABLE `messenger_messages` (
  `id` bigint NOT NULL,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reset_password_request`
--

CREATE TABLE `reset_password_request` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `selector` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hashed_token` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `requested_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `expires_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reset_password_request`
--

INSERT INTO `reset_password_request` (`id`, `user_id`, `selector`, `hashed_token`, `requested_at`, `expires_at`) VALUES
(4, 1, 'N3tOlrbGedGQQkOcOIZf', 'WUy/LZp/d8XFlW0PbZMu5bYWqiX6bFtCpMKuHtxAKio=', '2023-11-19 20:27:47', '2023-11-19 21:27:47');

-- --------------------------------------------------------

--
-- Table structure for table `trick`
--

CREATE TABLE `trick` (
  `id` int NOT NULL,
  `category_id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `author_id` int NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `updated_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `primary_image_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `trick`
--

INSERT INTO `trick` (`id`, `category_id`, `name`, `description`, `author_id`, `created_at`, `updated_at`, `slug`, `primary_image_id`) VALUES
(1, 1, 'Ollie', 'Saut en faisant pression sur la queue de la planche pour décoller.', 3, '2023-11-17 12:01:52', '2023-11-17 12:01:52', 'ollie', 1),
(2, 3, 'Nollie', 'Saut en utilisant la partie avant de la planche pour décoller.', 2, '2023-11-17 12:01:52', '2023-11-17 12:01:52', 'nollie', 2),
(3, 1, 'Frontside 180', 'Demi-tour dans le sens des aiguilles d\'une montre (rider régulier) ou inverse (goofy).', 4, '2023-11-17 12:01:52', '2023-11-17 12:01:52', 'frontside-180', 3),
(4, 1, 'Backside 180', 'Demi-tour dans le sens inverse des aiguilles d\'une montre (rider régulier) ou des aiguilles d\'une montre (goofy).', 5, '2023-11-17 12:01:52', '2023-11-17 12:01:52', 'backside-180', 4),
(5, 1, 'Indy Grab', 'Attraper la carre de la planche entre les pieds avec la main avant.', 5, '2023-11-17 12:01:52', '2023-11-17 12:01:52', 'indy-grab', 5),
(6, 3, 'Method Grab', 'Saisir la planche tout en la tirant vers le haut avec la main arrière en position aérienne.', 3, '2023-11-17 12:01:52', '2023-11-17 12:01:52', 'method-grab', 6),
(7, 1, 'Tail Grab', 'Saisir la partie arrière (la queue) de la planche avec la main arrière.', 3, '2023-11-17 12:01:52', '2023-11-17 12:01:52', 'tail-grab', 7),
(8, 3, 'Nose Grab', 'Saisir la partie avant (le nez) de la planche avec la main avant.', 4, '2023-11-17 12:01:52', '2023-11-17 12:01:52', 'nose-grab', 8),
(9, 1, '540°', 'Effectuer un tour complet de 540 degrés dans les airs.', 5, '2023-11-17 12:01:52', '2023-11-17 12:01:52', '540-', 9),
(10, 1, 'Double Cork', 'Deux rotations horizontales avec deux flips en l\'air.', 3, '2023-11-17 12:01:52', '2023-11-17 12:01:52', 'double-cork', 10),
(17, 1, 'Une nouvelle figure acrobatique', 'test', 1, '2023-11-17 12:52:51', '2023-11-19 19:18:58', 'une-nouvelle-figure-acrobatique-du-tonerre-', 30);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int NOT NULL,
  `image_id` int DEFAULT NULL,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_verified` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `image_id`, `email`, `roles`, `password`, `username`, `is_verified`) VALUES
(1, NULL, 'admin@example.com', '[]', '$2y$13$qeIOBWDmYpvT0YrVlBBe8eI8cU.nBNVLuut.Tso5psapotn0KH6CO', 'Administrateur', 0),
(2, NULL, 'user0@example.com', '[]', '$2y$13$Bq6u.70obmkNfMbraQsv..1CpdK/TOb2i8984fYWDk5s3qa.T1wfS', 'User0', 0),
(3, NULL, 'user1@example.com', '[]', '$2y$13$kG7YQKe6SlFiGWUNsSPinuJLbHkbgQBvhLRuS4GRmkDTFL9cJV8Z.', 'User1', 0),
(4, NULL, 'user2@example.com', '[]', '$2y$13$K1nSXEsa4s84OF0wfK0hw.gmrNxAJbD9GdO3K40lK0o7QICM5NzV.', 'User2', 0),
(5, NULL, 'user3@example.com', '[]', '$2y$13$iZ/nybPs3M0fqU.t0QfagOHK8dczYTmr.Rs/eeZc08Kvu3AfMAGoq', 'User3', 0);

-- --------------------------------------------------------

--
-- Table structure for table `video`
--

CREATE TABLE `video` (
  `id` int NOT NULL,
  `trick_id` int NOT NULL,
  `link` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `video`
--

INSERT INTO `video` (`id`, `trick_id`, `link`) VALUES
(1, 17, 'https://www.youtube.com/embed/EzGPmg4fFL8?si=_7tLvYmllOR_q_vw'),
(2, 17, 'https://www.youtube.com/embed/EzGPmg4fFL8?si=_7tLvYmllOR_q_vw');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_9474526CF675F31B` (`author_id`),
  ADD KEY `IDX_9474526CB281BE2E` (`trick_id`);

--
-- Indexes for table `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Indexes for table `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_C53D045FB281BE2E` (`trick_id`);

--
-- Indexes for table `messenger_messages`
--
ALTER TABLE `messenger_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  ADD KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  ADD KEY `IDX_75EA56E016BA31DB` (`delivered_at`);

--
-- Indexes for table `reset_password_request`
--
ALTER TABLE `reset_password_request`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_7CE748AA76ED395` (`user_id`);

--
-- Indexes for table `trick`
--
ALTER TABLE `trick`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_D8F0A91E1CDA489C` (`primary_image_id`),
  ADD KEY `IDX_D8F0A91E12469DE2` (`category_id`),
  ADD KEY `IDX_D8F0A91EF675F31B` (`author_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`),
  ADD UNIQUE KEY `UNIQ_8D93D649F85E0677` (`username`),
  ADD UNIQUE KEY `UNIQ_8D93D6493DA5256D` (`image_id`);

--
-- Indexes for table `video`
--
ALTER TABLE `video`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_7CC7DA2CB281BE2E` (`trick_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `comment`
--
ALTER TABLE `comment`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `image`
--
ALTER TABLE `image`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `messenger_messages`
--
ALTER TABLE `messenger_messages`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reset_password_request`
--
ALTER TABLE `reset_password_request`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `trick`
--
ALTER TABLE `trick`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `video`
--
ALTER TABLE `video`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `FK_9474526CB281BE2E` FOREIGN KEY (`trick_id`) REFERENCES `trick` (`id`),
  ADD CONSTRAINT `FK_9474526CF675F31B` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `image`
--
ALTER TABLE `image`
  ADD CONSTRAINT `FK_C53D045FB281BE2E` FOREIGN KEY (`trick_id`) REFERENCES `trick` (`id`);

--
-- Constraints for table `reset_password_request`
--
ALTER TABLE `reset_password_request`
  ADD CONSTRAINT `FK_7CE748AA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `trick`
--
ALTER TABLE `trick`
  ADD CONSTRAINT `FK_D8F0A91E12469DE2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  ADD CONSTRAINT `FK_D8F0A91E1CDA489C` FOREIGN KEY (`primary_image_id`) REFERENCES `image` (`id`),
  ADD CONSTRAINT `FK_D8F0A91EF675F31B` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `FK_8D93D6493DA5256D` FOREIGN KEY (`image_id`) REFERENCES `image` (`id`);

--
-- Constraints for table `video`
--
ALTER TABLE `video`
  ADD CONSTRAINT `FK_7CC7DA2CB281BE2E` FOREIGN KEY (`trick_id`) REFERENCES `trick` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 28, 2024 at 07:29 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tech_blog`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`) VALUES
(1, 'Programming', NULL),
(2, 'Digital Marketing', NULL),
(3, 'Content Creation', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `title` varchar(100) NOT NULL,
  `content` text DEFAULT NULL,
  `code` text DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT current_timestamp(),
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `category_id`, `title`, `content`, `code`, `image`, `created_on`, `user_id`) VALUES
(1, 1, 'Why Programming', 'test', NULL, '433830402_1542877546283116_8309783587398537584_n.jpg', '2024-07-14 04:48:36', 14),
(2, 1, 'Why Programming', 'test', NULL, '433830402_1542877546283116_8309783587398537584_n.jpg', '2024-07-14 04:55:19', 14),
(3, 3, 'Test', 'tsts', NULL, '', '2024-07-15 18:03:46', 14),
(4, 3, 'Hello World', 'Hello twst', NULL, '', '2024-07-26 09:13:35', 14),
(5, 1, 'Here are 5 things I wish I knew when I started', 'Hello, dear Dev.to community. I need to get some things off my chest, so here I am, hoping to share something useful with young IT professionals. Over my career, I’ve gone through freelancing, internships, corporate jobs, career changes, and even launching my own SaaS (a story for another time…). I’ve made countless mistakes and learned some painful lessons. Here are 5 important things I wish I had known 10 years ago.', NULL, 'error.png', '2024-07-26 10:12:01', 14),
(6, 2, 'Become a Better Java Developer: 19 Tips for Staying Ahead in 2024', 'Recently I reached out to one of my fellow Java developers who is very experienced and has been working in the industry forever and asked for his thoughts about the observability improvements in JDK 21 and Spring Boot 3.2 and if he has already migrated from 17 to 21 and to Spring Boot 3.2.\r\n\r\nThis is the reply I got from him:', NULL, 'vector-shopping-online-banner.jpg', '2024-07-26 11:07:38', 14),
(7, 3, 'Spring & Spring Boot Interview Guide', '1. Loose Coupling vs Tight Coupling\r\nTight Coupling\r\n\r\nTight coupling refers to a situation where components in a system are highly dependent on each other. This means that a change in one component often necessitates changes in other components. Tight coupling can lead to systems that are hard to maintain, test, and extend because the interconnectedness means that altering one part of the system has wide-ranging effects.', NULL, 'vector-shopping-online-banner.jpg', '2024-07-26 11:20:10', 14);

-- --------------------------------------------------------

--
-- Table structure for table `post_likes`
--

CREATE TABLE `post_likes` (
  `id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `post_likes`
--

INSERT INTO `post_likes` (`id`, `post_id`, `user_id`) VALUES
(1, 7, 14),
(3, 7, 14),
(4, 7, 14),
(5, 7, 14),
(6, 6, 14),
(7, 1, 14),
(8, 7, 14),
(9, 7, 14),
(10, 7, 14),
(11, 7, 14),
(12, 7, 14),
(13, 7, 14),
(14, 7, 14),
(15, 7, 14),
(16, 7, 14),
(17, 7, 14),
(18, 7, 14),
(19, 7, 14),
(20, 7, 14),
(21, 7, 14),
(22, 6, 14),
(23, 6, 14),
(24, 6, 14),
(25, 6, 14),
(26, 4, 14),
(27, 6, 14),
(28, 4, 14),
(29, 5, 14),
(30, 5, 14),
(31, 3, 14),
(32, 1, 14),
(33, 1, 14),
(34, 1, 14),
(35, 1, 14),
(36, 1, 14),
(37, 1, 14),
(38, 1, 14);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `about` varchar(500) NOT NULL,
  `reg_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `profile_picture` varchar(100) DEFAULT 'default.jpg'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `email`, `password`, `gender`, `about`, `reg_date`, `profile_picture`) VALUES
(14, 'Abu Talib', 'abutalib715@gmail.com', '1234', 'male', 'I am a backend developer.', '2024-07-11 18:33:20', 'Screenshot_1.png'),
(15, 'Mainul Hasan', 'skynet@mail.co', '1234', 'male', '', '2024-07-12 09:15:46', 'default.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `posts_categories_FK` (`category_id`),
  ADD KEY `posts_user_FK` (`user_id`);

--
-- Indexes for table `post_likes`
--
ALTER TABLE `post_likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_likes_posts_FK` (`post_id`),
  ADD KEY `post_likes_user_FK` (`user_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `post_likes`
--
ALTER TABLE `post_likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_categories_FK` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `posts_user_FK` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `post_likes`
--
ALTER TABLE `post_likes`
  ADD CONSTRAINT `post_likes_posts_FK` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`),
  ADD CONSTRAINT `post_likes_user_FK` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

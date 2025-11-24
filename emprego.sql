-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 24, 2025 at 01:49 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `emprego`
--

-- --------------------------------------------------------

--
-- Table structure for table `applications`
--

CREATE TABLE `applications` (
  `id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(300) NOT NULL,
  `email` varchar(300) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `education` varchar(1000) NOT NULL,
  `experience` varchar(1000) NOT NULL,
  `feedback` varchar(600) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `applications`
--

INSERT INTO `applications` (`id`, `job_id`, `user_id`, `name`, `email`, `phone`, `education`, `experience`, `feedback`, `created_at`) VALUES
(1, 1, 7, 'Emanuel Mainardes Guerke', 'emanuel@gmail.com', '43999639428', 'dsdssd ssddssdsd dssdsdsd sdsddsds', 'sddsds ssdsdsd ssdsd dsssdsd', 'aprovado bla bla bla bla bla', '2025-11-22 14:59:02'),
(2, 1, 2, 'Silva silveiro silverino', 'silverino@gmail.com', '45999649878', 'formação adassaddasdsa aadsdsadsa asasaasas', 'experiencia sddsdsasdadas adsdasdsadas dasdasdsa', 'aprovado sóqnao', '2025-11-22 16:19:57'),
(3, 4, 7, 'Emanuel mainardes ', 'emanuelgfdss@gmail.com', '439997433', 'dssdsddss dsdssdsd', 'saassasa sasasasaffd', NULL, '2025-11-22 17:40:33'),
(4, 5, 7, 'emanuel guerke', 'edsss@gmail.com', '443434343', 'sddsdsdssd dsdsdsd dssdsdsdsdsddssdsd', 'sasasa ssasasa sssassasa sasasasaassdd', NULL, '2025-11-23 03:02:37'),
(5, 5, 7, 'nomenbbn  nnbbbn', 'email@gmail.com', '439996428', 'hjhhjhj hjjhjhjhj hhhjjh', 'hjhjhhj hhhjhj hjhjhjh', NULL, '2025-11-23 04:06:30');

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE `companies` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `business` varchar(150) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `street` varchar(150) NOT NULL,
  `number` varchar(8) NOT NULL,
  `city` varchar(150) NOT NULL,
  `state` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(150) NOT NULL,
  `role` varchar(20) NOT NULL DEFAULT 'company',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`id`, `name`, `business`, `username`, `password`, `street`, `number`, `city`, `state`, `phone`, `email`, `role`, `created_at`) VALUES
(2, 'magazine', 'loja', 'magazine', '1234', 'dsadasdas', '34', 'adssdasadsad', 'paranazao', '43999639428', 'magazineluiza@gmail.com', 'company', '2025-10-19 03:24:10'),
(3, 'mercado', 'mercado', 'mercado', '1234', 'terra', '3233', 'passas', 'paraná', '43998376-634234', 'kkkk@gmail.com', 'company', '2025-11-03 13:44:51'),
(5, 'impresa di testi', 'testis', 'vhuggler', 'vhuggler', 'coronel', '', 'Pronta Gossa', 'Pr', '15996626628', 'vhuggler@hotmail.com', 'company', '2025-11-03 22:00:40'),
(7, 'ANDRE EMPRESA1', 'Tecnologia', 'andreemp3', 'andreemp3', 'Rua teste', '123', 'Castro', 'PR', '42999999999', 'andreempresa@gmail.com', 'company', '2025-11-10 18:26:59'),
(8, 'ANDRE EMPRESA', 'Tecnologia', 'andreemp4', 'andreemp4', 'Rua teste', '123', 'Castro', 'PR', '42999999999', 'andreempresa@gmail.com', 'company', '2025-11-10 18:27:14');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `title` varchar(150) NOT NULL,
  `area` varchar(150) NOT NULL,
  `description` text NOT NULL,
  `state` varchar(100) NOT NULL,
  `city` varchar(150) NOT NULL,
  `salary` decimal(12,2) DEFAULT NULL,
  `contact_email` varchar(150) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `company_id`, `title`, `area`, `description`, `state`, `city`, `salary`, `contact_email`, `created_at`) VALUES
(1, 2, 'Administrador geralzao', 'Administração', 'administrator de empresa com experiencia', 'sp', 'Barretos', 5555.00, 'magazineluiza@gmail.com', '2025-11-22 14:33:09'),
(3, 2, 'desenvolvedor', 'Tecnologia da Informação', 'formado em bcc ou analise', 'sp', 'são paulo', 73628.00, 'magazineluiza@gmail.com', '2025-11-22 16:14:55'),
(4, 2, 'vendedor', 'Comercial', 'sdad adadada', 'pr', 'curitiba', 3223.00, 'magazineluiza@gmail.com', '2025-11-22 16:59:06'),
(5, 2, 'dsd', 'Outros', 'dsddddsdd ddsdsds dsdsdsd', 'mg', 'mssa', 3223.00, 'magazineluiza@gmail.com', '2025-11-22 16:59:38');

-- --------------------------------------------------------

--
-- Table structure for table `token_usuarios`
--

CREATE TABLE `token_usuarios` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_usuario` char(36) DEFAULT NULL,
  `token` varchar(300) NOT NULL,
  `expiraem` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `revogado` tinyint(1) DEFAULT 0,
  `criacao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `token_usuarios`
--

INSERT INTO `token_usuarios` (`id`, `id_usuario`, `token`, `expiraem`, `revogado`, `criacao`) VALUES
(57, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NTg1ODU4NjB9.-55RrBdVRWhJzZ9lgQZwsbVguxe-Wn9lVPifB1It6CI', '2025-09-22 00:14:16', 1, '2025-09-22 00:04:20'),
(58, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NTkzNjk4ODR9.Z738Dxe9zozMZL7iqeCnQkL1SSth84w8ri3e1CRa6Gc', '2025-10-01 01:51:38', 1, '2025-10-01 01:51:24'),
(59, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJuZWtvIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NTkzNzAwMDB9.SPOQvFurcLImJpI4Zif04PVyYkQKzUTCW590RVyVxjY', '2025-10-02 01:53:20', 0, '2025-10-01 01:53:20'),
(60, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJuZWtvIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NTkzNzA2NTl9.NbsUM348XAtINWkGcGBrCeFYCkeRpzPYUB_mV5uWpbU', '2025-10-01 02:06:44', 1, '2025-10-01 02:04:19'),
(61, '3', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIzIiwidXNlcm5hbWUiOiJqYWlybyIsInJvbGUiOiJ1c2VyIiwiZXhwIjoxNzU5MzcwOTIzfQ._p3bBzRjaZ4oUINA5oK77r8qyEhHb9ZhPFE9Xy6_Ix0', '2025-10-01 02:22:32', 1, '2025-10-01 02:08:43'),
(62, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NTkzNzE3ODF9.KgnUTt9Vt3tiQLaaoqjRB7caDEufWC-4mCsYYNFiy1I', '2025-10-01 02:28:20', 1, '2025-10-01 02:23:01'),
(63, '3', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIzIiwidXNlcm5hbWUiOiJqYWlybyIsInJvbGUiOiJ1c2VyIiwiZXhwIjoxNzU5MzczMDAyfQ.KryZJZNXUQEqf1Jd-o6ya13K4VVFYr5YKI_PP4JhHPU', '2025-10-01 02:44:55', 1, '2025-10-01 02:43:22'),
(64, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NTkzNzMxNjB9.U36kFRRRpn109KGi5CbThQ5vs3o0iQxM5Q1JZfMB7u4', '2025-10-01 02:51:35', 1, '2025-10-01 02:46:00'),
(65, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NTkzNzM1MDh9.WWkNR-S3rA5GwPbEPNjWM9rxdwWukH4RfrC0zghzNsc', '2025-10-13 18:44:14', 1, '2025-10-01 02:51:48'),
(66, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NTk5NzE2Mzh9.ihKkv5w45zZzddbqzY_1-Llnh9DZp2eR0AOTHkYshHc', '2025-10-08 01:01:21', 1, '2025-10-08 01:00:38'),
(67, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NTk5NzI3Nzd9.T6QV5qc1wJJke56gvk_w8aafN3eMoAToeHCVu5dWTLs', '2025-10-08 01:19:40', 1, '2025-10-08 01:19:37'),
(68, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NTk5NzI4ODB9.hTQgUpw5--s0woedv5y3Z-UxgWfTtg_Z75qQo07FcC4', '2025-10-13 18:44:14', 1, '2025-10-08 01:21:20'),
(69, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NTk5NzMwMjF9.IJI3emjDMYrkZm9GFdvuWe5sZoQ6vpeUSU0rm4bgpV4', '2025-10-13 18:44:14', 1, '2025-10-08 01:23:41'),
(70, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NTk5NzM3Nzd9.fWY6CnSxnfy9YX7S5z63QPmjQ61Ub9WhYfeEHLSloGw', '2025-10-08 01:45:12', 1, '2025-10-08 01:36:17'),
(71, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NTk5NzQzMTh9.2f8PqanuvdhB4-jjdrU9l75HtUFKpeXheJqrjSsvR6k', '2025-10-13 18:44:14', 1, '2025-10-08 01:45:18'),
(72, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjAyMDI5NDF9.CTu4gtJRehb0Ms5vqYtCZQeIjmdgTIIbt0m2r54IGr0', '2025-10-13 18:44:14', 1, '2025-10-10 17:15:42'),
(73, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjAyMDU4MjR9.UsQ0LpbVtv7GhB2dNUkL6rtbjZr5up7svcPvOrwhHvg', '2025-10-13 18:44:14', 1, '2025-10-10 18:03:44'),
(74, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjAyODY5ODl9.mSM04NYvPJ_nRzwjIu6tXyz0l8u87eXqOlUSIJ7WuGY', '2025-10-11 16:36:38', 1, '2025-10-11 16:36:29'),
(75, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjAyODc1Mjh9.qQqJP_gd563xTAsdZqfp891C9DHuxVMBLtDRjQNEgRM', '2025-10-13 18:44:14', 1, '2025-10-11 16:45:28'),
(76, '6', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2IiwidXNlcm5hbWUiOiJ2aHVnZ2xlciIsInJvbGUiOiJ1c2VyIiwiZXhwIjoxNzYwMjg5MDQzfQ.AI2LI0TlEvjoAT284I_y-SnP-Y4q3gMagt3cGatntCU', '2025-10-11 17:14:49', 1, '2025-10-11 17:10:43'),
(77, '6', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2IiwidXNlcm5hbWUiOiJ2aHVnZ2xlciIsInJvbGUiOiJ1c2VyIiwiZXhwIjoxNzYwMjg5MzAxfQ.pJL7vRYXykUV223FIX7ZXZRReDouTi36oxkxtPO5L8A', '2025-10-11 17:21:08', 1, '2025-10-11 17:15:01'),
(78, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA0MDI1Mzd9.t3IfGaAaMHi9pCJcu3Ce2oS7Cm9kQruYxI1fpqGt160', '2025-10-13 18:44:14', 1, '2025-10-13 00:42:17'),
(79, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA0NjcyMzN9.NxrAO01fHB_4lHtllL6Wt3tplVq1B48fQBhMMPIPccc', '2025-10-13 18:42:58', 1, '2025-10-13 18:40:33'),
(80, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA0Njc0Mzh9.gNFM-fjO7-HgQ9b18gIYe4iEETzPaCBl2uU8IIE68BY', '2025-10-13 18:44:14', 1, '2025-10-13 18:43:58'),
(81, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA0Njc1NTl9.aTz_bJtsX7nGfxgVHmO9Fg7NZAMxRpvHT6niR807Kvg', '2025-10-14 18:45:59', 0, '2025-10-13 18:45:59'),
(82, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA5Mjc3NDd9.btXEF3Cj1F3FpP6C0wEi8mCsNz9aXk7IC8yuDEiHzCQ', '2025-10-19 02:35:54', 1, '2025-10-19 02:35:47'),
(83, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJhbWVyaWNhbmFzIiwicm9sZSI6ImNvbXBhbnkiLCJleHAiOjE3NjA5Mjc4MjZ9.SaL6-kvbSjqRuqrc_AVlfxhdmjokVKUOGAjtv87x68Q', '2025-10-27 19:49:52', 1, '2025-10-19 02:37:06'),
(84, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJhbWVyaWNhbmFzIiwicm9sZSI6ImNvbXBhbnkiLCJlbnRpdHkiOiJjb21wYW55IiwiZXhwIjoxNzYwOTI4NzgyfQ.CUx_uUQ07ecwOd7XWMUdqtkdguFXOmkoNt2k5ASo7go', '2025-10-27 19:49:52', 1, '2025-10-19 02:53:02'),
(85, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA5MjkxMDZ9.3uCaWRjFuBjJGdL6PMa3ZIoHxW6G8yiNMLlO6hIs4sg', '2025-10-19 03:00:20', 1, '2025-10-19 02:58:26'),
(86, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJhbWVyaWNhbmFzIiwicm9sZSI6ImNvbXBhbnkiLCJleHAiOjE3NjA5MjkyMjV9.0gRA44AC_7LJyO4R9shapbWGwKxF1u6jWJAsEQOe2oo', '2025-10-19 03:08:58', 1, '2025-10-19 03:00:25'),
(87, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA5Mjk3NDN9.c2AvOpXf-RS8Ue9t9yJBHflHfjZhSmx6kC4Aa2rU1Tg', '2025-10-20 03:09:03', 0, '2025-10-19 03:09:03'),
(88, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJhbWVyaWNhbmFzIiwicm9sZSI6ImNvbXBhbnkiLCJleHAiOjE3NjA5Mjk4MTd9.xkkLUBhZB_cTrNAxU5Q4DrEzFFoKfcACzh86rnWFFhU', '2025-10-19 03:10:33', 1, '2025-10-19 03:10:17'),
(89, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJhbWVyaWNhbmFzIiwicm9sZSI6ImNvbXBhbnkiLCJleHAiOjE3NjA5Mjk4NDF9.mT4SxwvJ4zHZgj7Ye6pMdkFruMYnGqni1TZN0gvgA_Y', '2025-10-19 03:17:02', 1, '2025-10-19 03:10:41'),
(90, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJhbWVyaWNhbmFzIiwicm9sZSI6ImNvbXBhbnkiLCJleHAiOjE3NjA5MzAyMjh9.Ql6-qvCcQ_3PAHhztsL0EUjL51wgem0n3bfMbJH9MDk', '2025-10-19 03:23:15', 1, '2025-10-19 03:17:08'),
(91, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYwOTMwNjU3fQ.953LL6eo29iHO9XyplSAtevhKHwoS00DjtfATLeaY28', '2025-10-20 03:24:17', 0, '2025-10-19 03:24:17'),
(92, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA5MzEyMDB9.bZSMQPMYrHXjHZhjEbAHMp0MacmCauftCrmrJNctT_M', '2025-10-20 03:33:20', 0, '2025-10-19 03:33:20'),
(93, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJhbWVyaWNhbmFzIiwicm9sZSI6ImNvbXBhbnkiLCJleHAiOjE3NjA5MzIwNTB9.CxRbs-nwCgzsUUcEQCqxHh9zNo-_HnBybImyiiV5qjk', '2025-10-19 03:51:07', 1, '2025-10-19 03:47:30'),
(94, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA5MzIyNzF9.E2y0c3eod6JSnNAeLobokfS5LBVU3G3i2lrXvDi-ZH8', '2025-10-19 03:52:56', 1, '2025-10-19 03:51:11'),
(95, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYwOTMyMzgyfQ.0-d01eYlQE6yUWJj20pDctOgQf1VgvrQqCrtOXA9pZA', '2025-10-20 03:53:02', 0, '2025-10-19 03:53:02'),
(96, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjE2ODA4NTd9.jdUNoNS92JOaPD4Z9Ubkh5xSiGOzblvMuJXU7jNn_Do', '2025-10-27 19:48:36', 1, '2025-10-27 19:47:37'),
(97, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJhbWVyaWNhbmFzIiwicm9sZSI6ImNvbXBhbnkiLCJleHAiOjE3NjE2ODA5MjV9.NysAX90EWhtfapoTCpRRR-3iNu5hj-b_Rnk-j4uZtDo', '2025-10-27 19:49:52', 1, '2025-10-27 19:48:45'),
(98, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYxNjgxMDI3fQ.ippyijOTgaCiatEAJt9wDSECoIxDsK4ry26q7beGHjQ', '2025-10-27 19:50:35', 1, '2025-10-27 19:50:27'),
(99, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYyMDI1Njc0fQ.ENJxlXADZK2zAa-GsqqB6gDUvxwCv5zhgZzRgoQYZSs', '2025-10-31 19:55:10', 1, '2025-10-31 19:34:34'),
(100, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjIwMjY5MTZ9.LJOaAoviGKCSvUFV48m4QgUfo80FE9ny9DdmhsNQJJc', '2025-11-01 19:55:16', 0, '2025-10-31 19:55:16'),
(101, '3', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIzIiwidXNlcm5hbWUiOiJtZXJjYWRvIiwicm9sZSI6ImNvbXBhbnkiLCJleHAiOjE3NjIyNjM5MDV9.woQlLUSPnxpSLnlqZy1QR9qC5HsrKZ9UQgWB-ojZ8EY', '2025-11-03 13:47:59', 1, '2025-11-03 13:45:05'),
(102, '3', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIzIiwidXNlcm5hbWUiOiJtZXJjYWRvIiwicm9sZSI6ImNvbXBhbnkiLCJleHAiOjE3NjIyNjQwOTJ9.8ve8Y3aiZ3fLoeMkeR1oEYKGGr4PvttCdkubj4WMak0', '2025-11-04 13:48:12', 0, '2025-11-03 13:48:12'),
(103, '4', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0IiwidXNlcm5hbWUiOiJ2aHVnZ2xlcmMiLCJyb2xlIjoiY29tcGFueSIsImV4cCI6MTc2MjI5MzIzNH0.6Hs5qxiJ87C7nI45hv5gvAVWs5Mi2BLUyX14nWv9m2E', '2025-11-03 21:54:52', 1, '2025-11-03 21:53:54'),
(104, '4', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0IiwidXNlcm5hbWUiOiJ2aHVnZ2xlcmMiLCJyb2xlIjoiY29tcGFueSIsImV4cCI6MTc2MjI5MzMyNn0.l_KnJAF2EuZsgvWJA_Pn3xDqqdSGXQPFZKE9kVe59xo', '2025-11-03 21:55:34', 1, '2025-11-03 21:55:26'),
(105, '5', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI1IiwidXNlcm5hbWUiOiJ2aHVnZ2xlciIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYyMjkzNjYzfQ.K-vWr-r2sZXMKuoLfwk_VNp5yij2UW5heN3ckcJwaJ4', '2025-11-03 22:01:08', 1, '2025-11-03 22:01:03'),
(106, '5', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI1IiwidXNlcm5hbWUiOiJ2aHVnZ2xlciIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYyMjk2MjgwfQ.NmB37NAMy6d200LOe1M8Ihv_6nupYisJDIRM2vnlacU', '2025-11-04 22:44:40', 0, '2025-11-03 22:44:40'),
(107, '6', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2IiwidXNlcm5hbWUiOiJhbmRyZWVtcCIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYyODg1Mjk4fQ.AjU2kg3MCEy9ZS2FoCHfoGcI-BgiiRqFIiD24o3ZBF8', '2025-11-10 18:23:00', 1, '2025-11-10 18:21:38'),
(108, '6', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2IiwidXNlcm5hbWUiOiJhbmRyZWVtcCIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYyODg1MzkzfQ.mLZwAZKVpVfoP3kFRa-XPEDLPvSFMn6DhJeAhx15A1I', '2025-11-10 18:23:18', 1, '2025-11-10 18:23:13'),
(109, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJhbmRyZWVtcDMiLCJyb2xlIjoiY29tcGFueSIsImV4cCI6MTc2Mjg4NTY0NH0.aIiiJOiKlK-QG0XbENDjHNrR5YZquYnctYIJE0b8YRY', '2025-11-10 18:32:33', 1, '2025-11-10 18:27:24'),
(110, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYyODg4MTYyfQ.jz0UBApMSEbF4VKVSJyOM5vjBvjuTCEZxoTgGatrc2c', '2025-11-11 19:09:22', 0, '2025-11-10 19:09:22'),
(111, '9', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI5IiwidXNlcm5hbWUiOiJlbXByZXNhIiwicm9sZSI6ImNvbXBhbnkiLCJleHAiOjE3NjI4OTc2MTZ9.QmQvaVemwsEbN_JCp7FTISPsEfd8kYZTYhTsmg8KW30', '2025-11-10 21:49:05', 1, '2025-11-10 21:46:56'),
(112, '10', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMCIsInVzZXJuYW1lIjoiYW5kcmV0ZXN0ZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYyODk4NzQ3fQ.bed3cuu5XBtKuKtyamVUQvZF9oA_Ce8fjoM0Zfd8Q54', '2025-11-10 22:06:45', 1, '2025-11-10 22:05:47'),
(113, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYzODQ1MDk1fQ.YsRNIu1xswNzlBLDV2fS_8mRIop6YKObzcIHiDFgo5U', '2025-11-21 21:02:17', 1, '2025-11-21 20:58:15'),
(114, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYzOTA4MzA4fQ.uP578MsxADuTaxyfhh2TjGE6dgZ5e72ABz6UDkH8lBQ', '2025-11-23 14:31:48', 0, '2025-11-22 14:31:48'),
(115, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjM5MDg0NDV9.t676e0VaeUUIjpSCzB9bqZDWD36LRjg9spxJS88dGnE', '2025-11-22 14:34:41', 1, '2025-11-22 14:34:05'),
(116, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYzOTA4NDk4fQ.p6rcTELY73ANLkW4yLGDY7L3OrBYPecKCv5xk4c0RKc', '2025-11-23 14:34:58', 0, '2025-11-22 14:34:58'),
(117, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYzOTA5NTM4fQ.Euu4YKO55ST-Jlq2uUlHWXd9kvk7cSzURRK4BG5_inU', '2025-11-23 14:52:18', 0, '2025-11-22 14:52:18'),
(118, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYzOTA5NzI3fQ.rJZW02m7pNyrOicRRPde2EzHqIMCjPT_4rL_PrCNQGk', '2025-11-22 14:57:24', 1, '2025-11-22 14:55:27'),
(119, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjM5MDk4NTB9.cV5WtMN90FSGMgSPjgNpH73zVPZlz3W5SFRiPzXoaW0', '2025-11-23 14:57:30', 0, '2025-11-22 14:57:30'),
(120, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYzOTA5OTYyfQ.6fPCCQ6APbXC4DmKUfsT3a8_xqWCvUlJ8aXiQinMnRY', '2025-11-22 15:55:33', 1, '2025-11-22 14:59:22'),
(121, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjM5MTMzMzl9.JZ5EPdSnTSGJmJKg2mjZOYUjQ0b-aMTQXbsgPGBAP-I', '2025-11-22 16:13:05', 1, '2025-11-22 15:55:39'),
(122, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJuZWtvIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjM5MTQzOTF9.1cHk7f3xy5rauPvlR2vBHVmvHhQSvNWaqxbwVCRfYyQ', '2025-11-22 16:13:36', 1, '2025-11-22 16:13:11'),
(123, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYzOTE0NDIxfQ.GLsg95x4swVsLb7kOZHpdFrAiU9H24V9nTlje8nfGhg', '2025-11-22 16:17:01', 1, '2025-11-22 16:13:41'),
(124, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJuZWtvIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjM5MTQ2MzF9.-bqtI_TFRuViW1LswYaH9Nfjq0vT8h5J8Xs2VPXAT4w', '2025-11-23 16:17:11', 0, '2025-11-22 16:17:11'),
(125, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYzOTE0ODE4fQ.k68uG-wu9PTdDavSGL9dkgXGEzizgTbE5MUBaRbz6lc', '2025-11-22 16:38:24', 1, '2025-11-22 16:20:18'),
(126, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjM5MTU5MTV9.W7hj8-LE7LNLHDW3JmhfjPJq-yEN8yivTolUOV_JXmM', '2025-11-22 16:41:15', 1, '2025-11-22 16:38:35'),
(127, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYzOTE2MDgwfQ.xvhhjgYxxsqzgH5A1xQ6xXlLO54pxgnh08G9pBsfJSY', '2025-11-22 17:08:01', 1, '2025-11-22 16:41:20'),
(128, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjM5MTc2ODh9.zzSZk_P7ce3P7IlwPXeP6-QxAK_Hjfy7SbxEOnPnGw0', '2025-11-23 17:08:08', 0, '2025-11-22 17:08:08'),
(129, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjM5MTk0Mjd9.90HZsD2Qsw8QZeIW_lx9GF3gagN7PFC2wX3mL1B2G_o', '2025-11-22 17:42:41', 1, '2025-11-22 17:37:07'),
(130, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJuZWtvIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjM5MTk3NzB9.shMmwWakefq_K-Wvb9WmJln6nxV8SH7dKyPaO5o1NCA', '2025-11-23 17:42:50', 0, '2025-11-22 17:42:50'),
(131, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjM5MzY4OTh9.28i5_DA-QwIjD2eu2pfYtwq_SPRHkCFj4qynr6iTrCg', '2025-11-23 22:28:18', 0, '2025-11-22 22:28:18'),
(132, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYzOTUxNjY0fQ.1nqQDCFhmCQWGMk2DRcBQmfAjzrxrm7r4_IQcj3n5H4', '2025-11-23 02:49:25', 1, '2025-11-23 02:34:24'),
(133, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYzOTUyNTc1fQ.UqTbVrFdoWZ6whKAkGpsInBa1zUnH9-kieJ7PhCbaiQ', '2025-11-23 02:50:05', 1, '2025-11-23 02:49:35'),
(134, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjM5NTI2MjN9.2CT1zg6n_MAfn_zHJigJysJJlv1OYu21IxJ-KetFb-o', '2025-11-23 02:57:47', 1, '2025-11-23 02:50:23'),
(135, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYzOTUzMDc0fQ.zBAZ-vJA72bLEzQQJNnfX4S52kN5BLJ_m5trlIF9D1U', '2025-11-23 03:01:35', 1, '2025-11-23 02:57:54'),
(136, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjM5NTMzMDN9.pfSK1s3tETKmCkBau3GOHLJAZPKnMfqJpX4eml3fHFw', '2025-11-24 03:01:43', 0, '2025-11-23 03:01:43'),
(137, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzY0MDI5NDQyfQ.WqvNMo9oue3Ket8UhZGC3fCvRfUZxMAKxXsDcqr1qtE', '2025-11-25 00:10:42', 0, '2025-11-24 00:10:42');

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `nome` varchar(300) NOT NULL,
  `usuario` varchar(300) NOT NULL,
  `senha` varchar(300) NOT NULL,
  `email` varchar(300) DEFAULT NULL,
  `telefone` varchar(300) DEFAULT NULL,
  `role` varchar(20) DEFAULT 'user',
  `experience` varchar(1000) DEFAULT NULL,
  `education` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`id`, `nome`, `usuario`, `senha`, `email`, `telefone`, `role`, `experience`, `education`) VALUES
(7, 'EMANUEL', 'emanuel', '12345', 'emanuelguerke@gmail.com', '43999639428', 'user', 'experiencia dasdasdassddasdas ddasdasdasdas dsa', 'formação dsdasdasdas sddsadasdasdas'),
(2, 'EMANUEL', 'neko', '1234', NULL, NULL, 'user', '', ''),
(5, 'TESTANDOCADASTRO', 'testando', '1234', '111111111@gmail.com', '11111111111', 'user', 'sdaaaaaaaaaaaaaaaaaasd sdasdadsadsasd asdasddasasddas dasasddasdasdas dadsdasdasdasdasda sdasasdadsdasdasdas dasadsdasdasdasdas', 'sdaaaaaaaaaaaaaaaaaasd sdasdadsadsasd asdasddasasddas dasasddasdasdas dadsdasdasdasdasda sdasasdadsdasdasdas dasadsdasdasdasdas'),
(4, 'TESTE', 'teste', '1234', 'ema@gmail.com', '43999639428', 'user', 'dsdsdsdsdsdsdsdsdsdsdsdssssssssssssssssss  ddsdsdsdsds sd sddsdsdsdssd ds dsdsdsssssssssssssssssssssssss sddssddsdsdssd', 'dsdsdsdsdsdsdsdsdsdsdsdssssssssssssssssss  ddsdsdsdsds sd sddsdsdsdssd ds dsdsdsssssssssssssssssssssssss sddssddsdsdssd');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `applications`
--
ALTER TABLE `applications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `job_idx` (`job_id`);

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company_idx` (`company_id`);

--
-- Indexes for table `token_usuarios`
--
ALTER TABLE `token_usuarios`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`usuario`),
  ADD UNIQUE KEY `id` (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `applications`
--
ALTER TABLE `applications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `companies`
--
ALTER TABLE `companies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `token_usuarios`
--
ALTER TABLE `token_usuarios`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=138;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `applications`
--
ALTER TABLE `applications`
  ADD CONSTRAINT `fk_applications_job` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `jobs`
--
ALTER TABLE `jobs`
  ADD CONSTRAINT `fk_jobs_company` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

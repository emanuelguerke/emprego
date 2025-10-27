-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 27/10/2025 às 20:23
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `emprego`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `companies`
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
-- Despejando dados para a tabela `companies`
--

INSERT INTO `companies` (`id`, `name`, `business`, `username`, `password`, `street`, `number`, `city`, `state`, `phone`, `email`, `role`, `created_at`) VALUES
(1, 'Americanas', 'Varejo', 'americanas', '1234', 'dsasddas', '123', 'adssdasadsad', 'parana', '43999639428', 'americanas@gmail.com', 'company', '2025-10-19 02:36:42'),
(2, 'magazine', 'loja', 'magazine', '1234', 'dsadasdas', '34', 'adssdasadsad', 'parana', '43999639428', 'magazineluiza@gmail.com', 'company', '2025-10-19 03:24:10');

-- --------------------------------------------------------

--
-- Estrutura para tabela `token_usuarios`
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
-- Despejando dados para a tabela `token_usuarios`
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
(83, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJhbWVyaWNhbmFzIiwicm9sZSI6ImNvbXBhbnkiLCJleHAiOjE3NjA5Mjc4MjZ9.SaL6-kvbSjqRuqrc_AVlfxhdmjokVKUOGAjtv87x68Q', '2025-10-20 02:37:06', 0, '2025-10-19 02:37:06'),
(84, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJhbWVyaWNhbmFzIiwicm9sZSI6ImNvbXBhbnkiLCJlbnRpdHkiOiJjb21wYW55IiwiZXhwIjoxNzYwOTI4NzgyfQ.CUx_uUQ07ecwOd7XWMUdqtkdguFXOmkoNt2k5ASo7go', '2025-10-20 02:53:02', 0, '2025-10-19 02:53:02'),
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
(95, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYwOTMyMzgyfQ.0-d01eYlQE6yUWJj20pDctOgQf1VgvrQqCrtOXA9pZA', '2025-10-20 03:53:02', 0, '2025-10-19 03:53:02');

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuario`
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
-- Despejando dados para a tabela `usuario`
--

INSERT INTO `usuario` (`id`, `nome`, `usuario`, `senha`, `email`, `telefone`, `role`, `experience`, `education`) VALUES
(7, 'EMANUEL', 'emanuel', '1234', 'emanuelguerke@gmail.com', '43999639428', 'user', 'experiencia dasdasdassddasdas ddasdasdasdas dsa', 'formação dsdasdasdas sddsadasdasdas'),
(2, 'EMANUEL', 'neko', '1234', NULL, NULL, 'user', '', ''),
(5, 'TESTANDOCADASTRO', 'testando', '1234', '111111111@gmail.com', '11111111111', 'user', 'sdaaaaaaaaaaaaaaaaaasd sdasdadsadsasd asdasddasasddas dasasddasdasdas dadsdasdasdasdasda sdasasdadsdasdasdas dasadsdasdasdasdas', 'sdaaaaaaaaaaaaaaaaaasd sdasdadsadsasd asdasddasasddas dasasddasdasdas dadsdasdasdasdasda sdasasdadsdasdasdas dasadsdasdasdasdas'),
(4, 'TESTE', 'teste', '1234', 'ema@gmail.com', '43999639428', 'user', 'dsdsdsdsdsdsdsdsdsdsdsdssssssssssssssssss  ddsdsdsdsds sd sddsdsdsdssd ds dsdsdsssssssssssssssssssssssss sddssddsdsdssd', 'dsdsdsdsdsdsdsdsdsdsdsdssssssssssssssssss  ddsdsdsdsds sd sddsdsdsdssd ds dsdsdsssssssssssssssssssssssss sddssddsdsdssd');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Índices de tabela `token_usuarios`
--
ALTER TABLE `token_usuarios`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`usuario`),
  ADD UNIQUE KEY `id` (`id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `companies`
--
ALTER TABLE `companies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `token_usuarios`
--
ALTER TABLE `token_usuarios`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT de tabela `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

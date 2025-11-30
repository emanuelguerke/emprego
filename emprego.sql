-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 30/11/2025 às 22:24
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
-- Estrutura para tabela `applications`
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
-- Despejando dados para a tabela `applications`
--

INSERT INTO `applications` (`id`, `job_id`, `user_id`, `name`, `email`, `phone`, `education`, `experience`, `feedback`, `created_at`) VALUES
(3, 4, 7, 'Emanuel mainardes ', 'emanuelgfdss@gmail.com', '439997433', 'dssdsddss dsdssdsd', 'saassasa sasasasaffd', 'bbbbbbbbbbbbbbbbbbbbbbbccccccccccccccccccccddddddddddddddddddd', '2025-11-22 17:40:33'),
(6, 6, 7, 'emanu', NULL, NULL, 'SAASSA ASaSASAS ASaSAS ', 'sasASAs ASasAS aasSasASA ', 'papapap apapapsapsadadpsaddpa ddsdsaddsaddsaddasddasddsad', '2025-11-24 19:50:41'),
(7, 7, 7, 'ssdsdsds', NULL, NULL, 'dssddssd dsdsdssd sddssddsdsssdsds', 'sddsdsdsds dsdsdsdssd sddsdsdsds', NULL, '2025-11-24 20:08:48'),
(13, 14, 9, 'usuario', NULL, NULL, 'usuario candidatura formação', 'usuario candidatura experiencia', NULL, '2025-11-30 21:20:58'),
(14, 15, 9, 'usuario', NULL, NULL, 'usuario candidatura formação', 'usuario candidatura experiencia', 'mandando feedback', '2025-11-30 21:21:18');

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
(2, 'magazine', 'loja', 'magazine', '1234', 'dsadasdas', '34', 'adssdasadsad', 'paranazao', '43999639428', 'magazineluiza@gmail.com', 'company', '2025-10-19 03:24:10'),
(3, 'mercado', 'mercado', 'mercado', '1234', 'terra', '3233', 'passas', 'paraná', '43998376-634234', 'kkkk@gmail.com', 'company', '2025-11-03 13:44:51'),
(5, 'impresa di testi', 'testis', 'vhuggler', 'vhuggler', 'coronel', '', 'Pronta Gossa', 'Pr', '15996626628', 'vhuggler@hotmail.com', 'company', '2025-11-03 22:00:40'),
(13, 'empresa', 'varejo', 'empresa', 'empresa', 'afonço celso', '54', 'ponta grossa', 'pr', '44999657436', 'empresa@gmail.com', 'company', '2025-11-30 21:15:36');

-- --------------------------------------------------------

--
-- Estrutura para tabela `jobs`
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
-- Despejando dados para a tabela `jobs`
--

INSERT INTO `jobs` (`id`, `company_id`, `title`, `area`, `description`, `state`, `city`, `salary`, `contact_email`, `created_at`) VALUES
(3, 2, 'desenvolvedor', 'Tecnologia da Informação', 'formado em bcc ou analise', 'sp', 'são paulo', 73628.00, 'magazineluiza@gmail.com', '2025-11-22 16:14:55'),
(4, 2, 'vendedor', 'Comercial', 'sdad adadada', 'pr', 'curitiba', 3223.00, 'magazineluiza@gmail.com', '2025-11-22 16:59:06'),
(6, 3, 'Engenheiro civil', 'Construção Civil', 'Vaga para construir blabla bla bla bla bla', 'sp', 'cajamar', 1342.00, 'kkkk@gmail.com', '2025-11-24 01:14:14'),
(7, 3, 'sdsdsds', 'Outros', 'dsdsdsds dsdasddasads asddasddsaadsa', 'pr', 'ponta grossa', 43342.00, 'kkkk@gmail.com', '2025-11-24 01:28:44'),
(8, 2, 'vaga magazine magazudo', 'Atendimento ao Cliente', 'atender o cliente do magazudo', 'pr', 'arapoti', 1444.23, 'magazineluiza@gmail.com', '2025-11-24 22:32:39'),
(13, 13, 'vaga empresa teste', 'Outros', 'vaga empresa teste', 'pr', 'curitiba', 4434.00, 'empresa@gmail.com', '2025-11-30 21:18:19'),
(14, 13, 'vaga empresa teste com candidato', 'Outros', 'vaga empresa teste com candidato', 'pr', 'ponta grossa', 4345.00, 'empresa@gmail.com', '2025-11-30 21:18:59'),
(15, 13, 'vaga empresa teste com candidato e feedback', 'Outros', 'vaga empresa teste com candidato e feedback', 'pr', 'castro', 6090.00, 'empresa@gmail.com', '2025-11-30 21:19:33');

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
(83, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJhbWVyaWNhbmFzIiwicm9sZSI6ImNvbXBhbnkiLCJleHAiOjE3NjA5Mjc4MjZ9.SaL6-kvbSjqRuqrc_AVlfxhdmjokVKUOGAjtv87x68Q', '2025-10-27 19:49:52', 1, '2025-10-19 02:37:06'),
(84, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJhbWVyaWNhbmFzIiwicm9sZSI6ImNvbXBhbnkiLCJlbnRpdHkiOiJjb21wYW55IiwiZXhwIjoxNzYwOTI4NzgyfQ.CUx_uUQ07ecwOd7XWMUdqtkdguFXOmkoNt2k5ASo7go', '2025-10-27 19:49:52', 1, '2025-10-19 02:53:02'),
(86, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJhbWVyaWNhbmFzIiwicm9sZSI6ImNvbXBhbnkiLCJleHAiOjE3NjA5MjkyMjV9.0gRA44AC_7LJyO4R9shapbWGwKxF1u6jWJAsEQOe2oo', '2025-10-19 03:08:58', 1, '2025-10-19 03:00:25'),
(88, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJhbWVyaWNhbmFzIiwicm9sZSI6ImNvbXBhbnkiLCJleHAiOjE3NjA5Mjk4MTd9.xkkLUBhZB_cTrNAxU5Q4DrEzFFoKfcACzh86rnWFFhU', '2025-10-19 03:10:33', 1, '2025-10-19 03:10:17'),
(89, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJhbWVyaWNhbmFzIiwicm9sZSI6ImNvbXBhbnkiLCJleHAiOjE3NjA5Mjk4NDF9.mT4SxwvJ4zHZgj7Ye6pMdkFruMYnGqni1TZN0gvgA_Y', '2025-10-19 03:17:02', 1, '2025-10-19 03:10:41'),
(90, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJhbWVyaWNhbmFzIiwicm9sZSI6ImNvbXBhbnkiLCJleHAiOjE3NjA5MzAyMjh9.Ql6-qvCcQ_3PAHhztsL0EUjL51wgem0n3bfMbJH9MDk', '2025-10-19 03:23:15', 1, '2025-10-19 03:17:08'),
(91, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYwOTMwNjU3fQ.953LL6eo29iHO9XyplSAtevhKHwoS00DjtfATLeaY28', '2025-10-20 03:24:17', 0, '2025-10-19 03:24:17'),
(93, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJhbWVyaWNhbmFzIiwicm9sZSI6ImNvbXBhbnkiLCJleHAiOjE3NjA5MzIwNTB9.CxRbs-nwCgzsUUcEQCqxHh9zNo-_HnBybImyiiV5qjk', '2025-10-19 03:51:07', 1, '2025-10-19 03:47:30'),
(95, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYwOTMyMzgyfQ.0-d01eYlQE6yUWJj20pDctOgQf1VgvrQqCrtOXA9pZA', '2025-10-20 03:53:02', 0, '2025-10-19 03:53:02'),
(97, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJhbWVyaWNhbmFzIiwicm9sZSI6ImNvbXBhbnkiLCJleHAiOjE3NjE2ODA5MjV9.NysAX90EWhtfapoTCpRRR-3iNu5hj-b_Rnk-j4uZtDo', '2025-10-27 19:49:52', 1, '2025-10-27 19:48:45'),
(98, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYxNjgxMDI3fQ.ippyijOTgaCiatEAJt9wDSECoIxDsK4ry26q7beGHjQ', '2025-10-27 19:50:35', 1, '2025-10-27 19:50:27'),
(99, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYyMDI1Njc0fQ.ENJxlXADZK2zAa-GsqqB6gDUvxwCv5zhgZzRgoQYZSs', '2025-10-31 19:55:10', 1, '2025-10-31 19:34:34'),
(101, '3', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIzIiwidXNlcm5hbWUiOiJtZXJjYWRvIiwicm9sZSI6ImNvbXBhbnkiLCJleHAiOjE3NjIyNjM5MDV9.woQlLUSPnxpSLnlqZy1QR9qC5HsrKZ9UQgWB-ojZ8EY', '2025-11-03 13:47:59', 1, '2025-11-03 13:45:05'),
(102, '3', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIzIiwidXNlcm5hbWUiOiJtZXJjYWRvIiwicm9sZSI6ImNvbXBhbnkiLCJleHAiOjE3NjIyNjQwOTJ9.8ve8Y3aiZ3fLoeMkeR1oEYKGGr4PvttCdkubj4WMak0', '2025-11-04 13:48:12', 0, '2025-11-03 13:48:12'),
(103, '4', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0IiwidXNlcm5hbWUiOiJ2aHVnZ2xlcmMiLCJyb2xlIjoiY29tcGFueSIsImV4cCI6MTc2MjI5MzIzNH0.6Hs5qxiJ87C7nI45hv5gvAVWs5Mi2BLUyX14nWv9m2E', '2025-11-03 21:54:52', 1, '2025-11-03 21:53:54'),
(104, '4', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0IiwidXNlcm5hbWUiOiJ2aHVnZ2xlcmMiLCJyb2xlIjoiY29tcGFueSIsImV4cCI6MTc2MjI5MzMyNn0.l_KnJAF2EuZsgvWJA_Pn3xDqqdSGXQPFZKE9kVe59xo', '2025-11-03 21:55:34', 1, '2025-11-03 21:55:26'),
(105, '5', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI1IiwidXNlcm5hbWUiOiJ2aHVnZ2xlciIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYyMjkzNjYzfQ.K-vWr-r2sZXMKuoLfwk_VNp5yij2UW5heN3ckcJwaJ4', '2025-11-03 22:01:08', 1, '2025-11-03 22:01:03'),
(106, '5', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI1IiwidXNlcm5hbWUiOiJ2aHVnZ2xlciIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYyMjk2MjgwfQ.NmB37NAMy6d200LOe1M8Ihv_6nupYisJDIRM2vnlacU', '2025-11-04 22:44:40', 0, '2025-11-03 22:44:40'),
(107, '6', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2IiwidXNlcm5hbWUiOiJhbmRyZWVtcCIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYyODg1Mjk4fQ.AjU2kg3MCEy9ZS2FoCHfoGcI-BgiiRqFIiD24o3ZBF8', '2025-11-10 18:23:00', 1, '2025-11-10 18:21:38'),
(108, '6', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2IiwidXNlcm5hbWUiOiJhbmRyZWVtcCIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYyODg1MzkzfQ.mLZwAZKVpVfoP3kFRa-XPEDLPvSFMn6DhJeAhx15A1I', '2025-11-10 18:23:18', 1, '2025-11-10 18:23:13'),
(110, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYyODg4MTYyfQ.jz0UBApMSEbF4VKVSJyOM5vjBvjuTCEZxoTgGatrc2c', '2025-11-11 19:09:22', 0, '2025-11-10 19:09:22'),
(111, '9', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI5IiwidXNlcm5hbWUiOiJlbXByZXNhIiwicm9sZSI6ImNvbXBhbnkiLCJleHAiOjE3NjI4OTc2MTZ9.QmQvaVemwsEbN_JCp7FTISPsEfd8kYZTYhTsmg8KW30', '2025-11-10 21:49:05', 1, '2025-11-10 21:46:56'),
(112, '10', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMCIsInVzZXJuYW1lIjoiYW5kcmV0ZXN0ZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYyODk4NzQ3fQ.bed3cuu5XBtKuKtyamVUQvZF9oA_Ce8fjoM0Zfd8Q54', '2025-11-10 22:06:45', 1, '2025-11-10 22:05:47'),
(113, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYzODQ1MDk1fQ.YsRNIu1xswNzlBLDV2fS_8mRIop6YKObzcIHiDFgo5U', '2025-11-21 21:02:17', 1, '2025-11-21 20:58:15'),
(114, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYzOTA4MzA4fQ.uP578MsxADuTaxyfhh2TjGE6dgZ5e72ABz6UDkH8lBQ', '2025-11-23 14:31:48', 0, '2025-11-22 14:31:48'),
(116, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYzOTA4NDk4fQ.p6rcTELY73ANLkW4yLGDY7L3OrBYPecKCv5xk4c0RKc', '2025-11-23 14:34:58', 0, '2025-11-22 14:34:58'),
(117, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYzOTA5NTM4fQ.Euu4YKO55ST-Jlq2uUlHWXd9kvk7cSzURRK4BG5_inU', '2025-11-23 14:52:18', 0, '2025-11-22 14:52:18'),
(118, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYzOTA5NzI3fQ.rJZW02m7pNyrOicRRPde2EzHqIMCjPT_4rL_PrCNQGk', '2025-11-22 14:57:24', 1, '2025-11-22 14:55:27'),
(120, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYzOTA5OTYyfQ.6fPCCQ6APbXC4DmKUfsT3a8_xqWCvUlJ8aXiQinMnRY', '2025-11-22 15:55:33', 1, '2025-11-22 14:59:22'),
(122, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJuZWtvIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjM5MTQzOTF9.1cHk7f3xy5rauPvlR2vBHVmvHhQSvNWaqxbwVCRfYyQ', '2025-11-22 16:13:36', 1, '2025-11-22 16:13:11'),
(123, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYzOTE0NDIxfQ.GLsg95x4swVsLb7kOZHpdFrAiU9H24V9nTlje8nfGhg', '2025-11-22 16:17:01', 1, '2025-11-22 16:13:41'),
(124, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJuZWtvIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjM5MTQ2MzF9.-bqtI_TFRuViW1LswYaH9Nfjq0vT8h5J8Xs2VPXAT4w', '2025-11-23 16:17:11', 0, '2025-11-22 16:17:11'),
(125, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYzOTE0ODE4fQ.k68uG-wu9PTdDavSGL9dkgXGEzizgTbE5MUBaRbz6lc', '2025-11-22 16:38:24', 1, '2025-11-22 16:20:18'),
(127, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYzOTE2MDgwfQ.xvhhjgYxxsqzgH5A1xQ6xXlLO54pxgnh08G9pBsfJSY', '2025-11-22 17:08:01', 1, '2025-11-22 16:41:20'),
(130, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJuZWtvIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjM5MTk3NzB9.shMmwWakefq_K-Wvb9WmJln6nxV8SH7dKyPaO5o1NCA', '2025-11-23 17:42:50', 0, '2025-11-22 17:42:50'),
(132, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYzOTUxNjY0fQ.1nqQDCFhmCQWGMk2DRcBQmfAjzrxrm7r4_IQcj3n5H4', '2025-11-23 02:49:25', 1, '2025-11-23 02:34:24'),
(133, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYzOTUyNTc1fQ.UqTbVrFdoWZ6whKAkGpsInBa1zUnH9-kieJ7PhCbaiQ', '2025-11-23 02:50:05', 1, '2025-11-23 02:49:35'),
(135, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzYzOTUzMDc0fQ.zBAZ-vJA72bLEzQQJNnfX4S52kN5BLJ_m5trlIF9D1U', '2025-11-23 03:01:35', 1, '2025-11-23 02:57:54'),
(137, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzY0MDI5NDQyfQ.WqvNMo9oue3Ket8UhZGC3fCvRfUZxMAKxXsDcqr1qtE', '2025-11-25 00:10:42', 0, '2025-11-24 00:10:42'),
(140, '3', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIzIiwidXNlcm5hbWUiOiJtZXJjYWRvIiwicm9sZSI6ImNvbXBhbnkiLCJleHAiOjE3NjQwMzMxOTR9.p750FErxkVarP1N-ZN9ROq6YmwpuPai83Rv6IL9H8U8', '2025-11-24 01:39:44', 1, '2025-11-24 01:13:14'),
(141, '3', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIzIiwidXNlcm5hbWUiOiJtZXJjYWRvIiwicm9sZSI6ImNvbXBhbnkiLCJleHAiOjE3NjQwMzM5NTF9.XoWIB_dKcF8ROfuBoMrJl6PkXm4GmSClVOfUyxbdfQY', '2025-11-24 01:37:46', 1, '2025-11-24 01:25:51'),
(142, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjQwOTc2MDJ9.J2w1Zxi_h0hvzB6U33mbSWn2zHPzrwNbMyRDfK92XLI', '2025-11-24 19:13:20', 1, '2025-11-24 19:06:42'),
(143, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjQwOTgwNzR9.QkOTqas8S_w3qYaJzlZC3L5Mtvdw_sfWC4RQ9_Dn_Gc', '2025-11-24 20:10:15', 1, '2025-11-24 19:14:34'),
(144, '3', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIzIiwidXNlcm5hbWUiOiJtZXJjYWRvIiwicm9sZSI6ImNvbXBhbnkiLCJleHAiOjE3NjQxMDA1NjZ9.ZOJTyKZl1EjsRuLGwLibF9EQN5zU3KxARnE58-84mKY', '2025-11-24 22:04:22', 1, '2025-11-24 19:56:06'),
(145, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjQxMDE1OTh9.2QkIa6GwnX7UGpHN43M_HNNVfS4pUME-IHzk09UVVic', '2025-11-24 21:43:27', 1, '2025-11-24 20:13:18'),
(146, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzY0MTA3MDE0fQ.7ymH0OWw4xSU8c-JuA8rRYztKVC7GK8b_c_1jkLgJ10', '2025-11-24 23:46:33', 1, '2025-11-24 21:43:34'),
(147, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjQxMDgyNjh9.HzqZAV6uYKTtztC0tR1qEf_fitWhG62v9-gm_3Yzytw', '2025-11-24 22:24:47', 1, '2025-11-24 22:04:28'),
(148, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzY0MTA5NDkyfQ.c1FS8ZLgbVoNiq6gQGnRO33daD-rItqNVZi6kOdF5Uk', '2025-11-25 22:24:52', 0, '2025-11-24 22:24:52'),
(149, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJuZWtvIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjQxMTQ0MTR9.EaMvID1lLzPFk96yoIX_Fj2udlpZtT4Xea1jaZiKrb8', '2025-11-24 23:50:09', 1, '2025-11-24 23:46:54'),
(150, '3', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIzIiwidXNlcm5hbWUiOiJtZXJjYWRvIiwicm9sZSI6ImNvbXBhbnkiLCJleHAiOjE3NjQxMTQ2MTh9.XIuGSm1Mh5ZJDHod10oFfArlk1UwMmEQKHsimaCZa8U', '2025-11-24 23:51:29', 1, '2025-11-24 23:50:18'),
(151, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjQxMTQ2OTZ9.soxnlQ_JXIc-cC59I2BOFoZH3YSL8sR8_0oP_4t9lpU', '2025-11-24 23:54:05', 1, '2025-11-24 23:51:36'),
(152, '3', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIzIiwidXNlcm5hbWUiOiJtZXJjYWRvIiwicm9sZSI6ImNvbXBhbnkiLCJleHAiOjE3NjQxMTQ4NTB9.nU36_YatFPNoqvXQhx_raC1KOrRk_G-N7YthxYY1IL0', '2025-11-25 23:54:10', 0, '2025-11-24 23:54:10'),
(153, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzY0MjEyMjgzfQ.1t2h53fkVdAgwsFbV-amf6nB59Ie6ET0mTSyvWC0y44', '2025-11-26 03:46:37', 1, '2025-11-26 02:58:03'),
(154, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjQyMTUyOTN9.cpmsZH2Hunm89DQyMZVMMhmtDMGfy8tR2dFb2NBnjJU', '2025-11-27 03:48:13', 0, '2025-11-26 03:48:13'),
(155, '11', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMSIsInVzZXJuYW1lIjoiZW1wcmVzYSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzY0MjY1NjI2fQ.5L20vXt92OtQd5S5kKFiVnxBzAcGfYlC_4Kn6DquFVc', '2025-11-26 17:47:26', 1, '2025-11-26 17:47:06'),
(156, '12', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMiIsInVzZXJuYW1lIjoiZW1wcmVzYSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzY0MjY1NzQ4fQ.fAVbGETepmMOGtMdDx7swqXVJav5OwBZXVu0KIxh_kA', '2025-11-26 18:01:56', 1, '2025-11-26 17:49:08'),
(157, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjQ1NDA4Mzd9.yVH6I460PLioJrQctqqmkZGgIWVtJkJTTcFFUILBTpM', '2025-11-29 22:14:31', 1, '2025-11-29 22:13:57'),
(158, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzY0NTQwODc2fQ.BvHWkztAh6fV3NZ-i2CEY8ekHbbd4eLJC_2b4no6JQw', '2025-11-29 22:14:47', 1, '2025-11-29 22:14:36'),
(159, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjQ1NDA4OTJ9.r6UIov_YQBLoWvTgevOB4caxs513Omw7NGAhjJZlkk0', '2025-11-30 22:14:52', 0, '2025-11-29 22:14:52'),
(160, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzY0NTQ0MDA1fQ.uH_ftGIDBsUAtBwT1-1H2ZdzJAKS9rdUB43pcHN7nsk', '2025-11-29 23:10:29', 1, '2025-11-29 23:06:45'),
(161, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjQ1NDQyNTZ9.JpJJrCM_dJM9hXOZclQUmp53lDCl5CFPM9Xr8WDLCPo', '2025-11-29 23:13:39', 1, '2025-11-29 23:10:56'),
(162, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzY0NTQ0NDI0fQ.rL_3gq49kQtqmb3DiYXs387Lks2sOG-d8qELKnWrhyo', '2025-11-29 23:14:28', 1, '2025-11-29 23:13:44'),
(163, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjQ1NDQ0ODV9.UVGxh3QvCskM9zhNPsbC2Tte0zPE9bqpvm6oWC2THMM', '2025-11-29 23:32:51', 1, '2025-11-29 23:14:45'),
(164, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjQ1NDU1ODJ9.Bh6b0xMtNwjfZgR5F_07Gfb0XHShXMbI_oGy87_Y_1M', '2025-11-29 23:33:26', 1, '2025-11-29 23:33:02'),
(165, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzY0NTQ1NjE1fQ.HdQ5lnFWHyR1iSu7KEcJOjnsE-TZbfZXXpjqz8WZgd0', '2025-11-29 23:33:54', 1, '2025-11-29 23:33:35'),
(166, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjQ1NDU2Mzl9.sbCQpT1_i_mLAd4KSnyxi8h_nEb0RyQtcmPpY4hPd-M', '2025-11-29 23:34:54', 1, '2025-11-29 23:33:59'),
(167, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzY0NTQ1Njk5fQ.7bV-o-O5g1p0sO0p73bz0Akpc5IFtTOQ2zSTWyCNiag', '2025-11-29 23:35:37', 1, '2025-11-29 23:34:59'),
(168, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjQ1NDU3NDZ9.dT6JcNwCs4tajinXDS1k2OKrQo0ZUpqRPPghoxp2804', '2025-11-30 00:20:36', 1, '2025-11-29 23:35:46'),
(169, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjQ1NDYwMDR9.MNik8UYnOkOmSkube8FtewEKGWM6mzVHwiHru6gIAfw', '2025-11-29 23:40:36', 1, '2025-11-29 23:40:04'),
(170, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzY0NTQ2MDQxfQ.DhBRDL1C9EYIJdnVkuW2PiXC3m6TlCkH0hy91Gt8FaY', '2025-11-29 23:41:14', 1, '2025-11-29 23:40:41'),
(171, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjQ1NDYwODB9.riVIUPrHfejB9QxcIghNRoCox0T9D-AAYBmjYQnDK_I', '2025-11-29 23:42:14', 1, '2025-11-29 23:41:20'),
(172, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzY0NTQ2MTM5fQ.tKNcSk3w3tYyslKFMXTv53CBwpVL_C-m6jqpYHYEMO4', '2025-11-29 23:42:36', 1, '2025-11-29 23:42:19'),
(173, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjQ1NDYxNjN9.jqWVLWiOnYQgvVDclFreQ9gB1eqShyBtW3SMelJWrRE', '2025-11-29 23:49:57', 1, '2025-11-29 23:42:43'),
(174, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzY0NTQ2NjAyfQ.nPpqPZD6s9bKALRW30QeSYu3qUJdOXCbK9L1TURIWVY', '2025-11-29 23:50:46', 1, '2025-11-29 23:50:02'),
(175, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjQ1NDY2NTJ9.kT0AX-EnTjed6jZa_1pt9u-HsG8wBnqEOxB2mNINCSQ', '2025-11-30 00:35:43', 1, '2025-11-29 23:50:52'),
(176, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjQ1NDg0NDJ9.gL6DSSpz2Jq2f-wl2mIPvEWTqo-ArvHm9k2dWHWipPk', '2025-11-30 00:22:11', 1, '2025-11-30 00:20:42'),
(177, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzY0NTQ4NTM2fQ.NMV9mfsqtC4Dn795zZ3sDXq5qrT0MpGLFz3ivdQS6dk', '2025-11-30 00:22:39', 1, '2025-11-30 00:22:16'),
(178, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjQ1NDg1NjZ9.dQSVOImgr66g6ykzFWkRd8ZBw4izQ7NxoZ_cOn84kxE', '2025-11-30 00:23:50', 1, '2025-11-30 00:22:46'),
(179, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzY0NTQ4NjM1fQ.aWv8j0vlS8UsM2QkwIJHiY5i7KzyhYxnC2QbDKNvHJE', '2025-11-30 00:24:40', 1, '2025-11-30 00:23:55'),
(180, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjQ1NDg2ODV9.YKGD7PJXtvRKHK91QP9KuD2s4dN0oQ9VnRBE7BdCmQE', '2025-11-30 00:26:50', 1, '2025-11-30 00:24:45'),
(181, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzY0NTQ4ODE5fQ.QifZDKu5jcqIAYrrgdBfwB-pG1tMmBNOdBRhrx-9jzw', '2025-11-30 00:29:55', 1, '2025-11-30 00:26:59'),
(182, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjQ1NDkwMDF9.2zCSq3PLmT9WoAuGwA3XzxFy2sUzj699W0T4W5ISi40', '2025-11-30 00:41:03', 1, '2025-11-30 00:30:01'),
(183, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzY0NTQ5MzQ4fQ.KFVqyEm36zkGYLdskbTp35VrFLXlvopKlhm2v0wZCOs', '2025-12-01 00:35:48', 0, '2025-11-30 00:35:48'),
(184, '2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwidXNlcm5hbWUiOiJtYWdhemluZSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzY0NTQ5NjcyfQ.QcNB1vvYmkrRahokjxd5YPJUQalQVpPa0580CwNHCwo', '2025-12-01 00:41:12', 0, '2025-11-30 00:41:12'),
(185, '8', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI4IiwidXNlcm5hbWUiOiJ0ZXN0ZSIsInJvbGUiOiJ1c2VyIiwiZXhwIjoxNzY0NjIzNjMxfQ.Q5cRIKcnbwHpBD0paqEvQLuGsJvWZhYGJndcgP4ITBk', '2025-11-30 21:14:00', 1, '2025-11-30 21:13:51'),
(186, '13', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMyIsInVzZXJuYW1lIjoiZW1wcmVzYSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzY0NjIzODM0fQ.r9tCw06-olvsvNexeYTA3zgM3NzW5S1L_nNO7vZFhSA', '2025-11-30 21:19:42', 1, '2025-11-30 21:17:14'),
(187, '9', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI5IiwidXNlcm5hbWUiOiJ1c3VhcmlvIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjQ2MjQwMjh9.hLXSFuE-0DId2CCxMaaN0FGqgAfZ2lKylXlvn8OMSZ0', '2025-11-30 21:21:24', 1, '2025-11-30 21:20:28'),
(188, '13', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMyIsInVzZXJuYW1lIjoiZW1wcmVzYSIsInJvbGUiOiJjb21wYW55IiwiZXhwIjoxNzY0NjI0MDk1fQ.H7tFtUWUZ-0pmW9ptU8VpgYNE6H5FKcKBmj2SftlIec', '2025-11-30 21:22:59', 1, '2025-11-30 21:21:35'),
(189, '9', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI5IiwidXNlcm5hbWUiOiJ1c3VhcmlvIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjQ2MjQxODh9.4cDyOH9iciUcPeXGXXQ7bzmvnEf19vW9jui93GzyQPg', '2025-11-30 21:23:43', 1, '2025-11-30 21:23:08');

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
(7, 'EMANUEL', 'emanuel', '12345', 'emanuelguerke@gmail.com', '43999639428', 'user', 'experiencia dasdasdassddasdas ddasdasdasdas dsa', 'formação dsdasdasdas sddsadasdasdas'),
(2, 'EMANUEL', 'neko', '1234', NULL, NULL, 'user', '', ''),
(5, 'TESTANDOCADASTRO', 'testando', '1234', '111111111@gmail.com', '11111111111', 'user', 'sdaaaaaaaaaaaaaaaaaasd sdasdadsadsasd asdasddasasddas dasasddasdasdas dadsdasdasdasdasda sdasasdadsdasdasdas dasadsdasdasdasdas', 'sdaaaaaaaaaaaaaaaaaasd sdasdadsadsasd asdasddasasddas dasasddasdasdas dadsdasdasdasdasda sdasasdadsdasdasdas dasadsdasdasdasdas'),
(8, 'TESTE', 'teste', 'teste', NULL, NULL, 'user', NULL, NULL),
(9, 'USUARIO', 'usuario', 'usuario', NULL, NULL, 'user', NULL, NULL);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `applications`
--
ALTER TABLE `applications`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `job_idx` (`job_id`,`user_id`) USING BTREE;

--
-- Índices de tabela `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Índices de tabela `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company_idx` (`company_id`);

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
-- AUTO_INCREMENT de tabela `applications`
--
ALTER TABLE `applications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de tabela `companies`
--
ALTER TABLE `companies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de tabela `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de tabela `token_usuarios`
--
ALTER TABLE `token_usuarios`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=190;

--
-- AUTO_INCREMENT de tabela `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `applications`
--
ALTER TABLE `applications`
  ADD CONSTRAINT `fk_applications_job` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `jobs`
--
ALTER TABLE `jobs`
  ADD CONSTRAINT `fk_jobs_company` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

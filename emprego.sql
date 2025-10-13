-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 13/10/2025 às 20:44
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
(80, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA0Njc0Mzh9.gNFM-fjO7-HgQ9b18gIYe4iEETzPaCBl2uU8IIE68BY', '2025-10-13 18:44:14', 1, '2025-10-13 18:43:58');

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
(2, 'EMANUEL', 'neko', '1234', NULL, NULL, 'user', '', ''),
(5, 'TESTANDOCADASTRO', 'testando', '1234', '111111111@gmail.com', '11111111111', 'user', 'sdaaaaaaaaaaaaaaaaaasd sdasdadsadsasd asdasddasasddas dasasddasdasdas dadsdasdasdasdasda sdasasdadsdasdasdas dasadsdasdasdasdas', 'sdaaaaaaaaaaaaaaaaaasd sdasdadsadsasd asdasddasasddas dasasddasdasdas dadsdasdasdasdasda sdasasdadsdasdasdas dasadsdasdasdasdas'),
(4, 'TESTE', 'teste', '1234', 'ema@gmail.com', '43999639428', 'user', 'dsdsdsdsdsdsdsdsdsdsdsdssssssssssssssssss  ddsdsdsdsds sd sddsdsdsdssd ds dsdsdsssssssssssssssssssssssss sddssddsdsdssd', 'dsdsdsdsdsdsdsdsdsdsdsdssssssssssssssssss  ddsdsdsdsds sd sddsdsdsdssd ds dsdsdsssssssssssssssssssssssss sddssddsdsdssd');

--
-- Índices para tabelas despejadas
--

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
-- AUTO_INCREMENT de tabela `token_usuarios`
--
ALTER TABLE `token_usuarios`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT de tabela `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

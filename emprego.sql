-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 19, 2025 at 09:31 PM
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
(65, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NTkzNzM1MDh9.WWkNR-S3rA5GwPbEPNjWM9rxdwWukH4RfrC0zghzNsc', '2025-10-14 15:53:44', 1, '2025-10-01 02:51:48'),
(66, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NTk5NzE2Mzh9.ihKkv5w45zZzddbqzY_1-Llnh9DZp2eR0AOTHkYshHc', '2025-10-08 01:01:21', 1, '2025-10-08 01:00:38'),
(67, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NTk5NzI3Nzd9.T6QV5qc1wJJke56gvk_w8aafN3eMoAToeHCVu5dWTLs', '2025-10-08 01:19:40', 1, '2025-10-08 01:19:37'),
(68, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NTk5NzI4ODB9.hTQgUpw5--s0woedv5y3Z-UxgWfTtg_Z75qQo07FcC4', '2025-10-14 15:53:44', 1, '2025-10-08 01:21:20'),
(69, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NTk5NzMwMjF9.IJI3emjDMYrkZm9GFdvuWe5sZoQ6vpeUSU0rm4bgpV4', '2025-10-14 15:53:44', 1, '2025-10-08 01:23:41'),
(70, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NTk5NzM3Nzd9.fWY6CnSxnfy9YX7S5z63QPmjQ61Ub9WhYfeEHLSloGw', '2025-10-08 01:45:12', 1, '2025-10-08 01:36:17'),
(71, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NTk5NzQzMTh9.2f8PqanuvdhB4-jjdrU9l75HtUFKpeXheJqrjSsvR6k', '2025-10-14 15:53:44', 1, '2025-10-08 01:45:18'),
(72, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjAyMDI5NDF9.CTu4gtJRehb0Ms5vqYtCZQeIjmdgTIIbt0m2r54IGr0', '2025-10-14 15:53:44', 1, '2025-10-10 17:15:42'),
(73, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjAyMDU4MjR9.UsQ0LpbVtv7GhB2dNUkL6rtbjZr5up7svcPvOrwhHvg', '2025-10-14 15:53:44', 1, '2025-10-10 18:03:44'),
(74, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA0Nzc2NzZ9.ySBlzVgInnmHPOR7uHHMDcjsLWxMUXUQtB26DpZbXrk', '2025-10-13 21:35:35', 1, '2025-10-13 21:34:36'),
(75, '4', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0IiwidXNlcm5hbWUiOiJiYXJiYXJhIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA0ODE1NTZ9.T3q9r2Tmi704dyYCWWOPRotwjlXaV9c5nm3oqIzW-BU', '2025-10-14 22:39:16', 0, '2025-10-13 22:39:16'),
(76, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA1NDI3NTl9._oSgnTn6EGX0SEl0itZm9m7Ks7opt0Sr9ixO9Abwh3M', '2025-10-14 15:42:22', 1, '2025-10-14 15:39:20'),
(77, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA1NDMxMzl9.ULHq63nQJTCKkNd8JUXe0QshBWWc-HHUMIpGFwl5_1M', '2025-10-14 15:52:36', 1, '2025-10-14 15:45:39'),
(78, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA1NDMxNzd9.QRRZ_vWFmrxDWU8EkngviA9FTFfT4stGnE4O31YGCjQ', '2025-10-14 15:53:44', 1, '2025-10-14 15:46:17'),
(79, '1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA1NDM1ODl9.0EjVWHsk614eVNvHxomCmXhgecUvcgfD83ei0DYc5tg', '2025-10-14 15:53:44', 1, '2025-10-14 15:53:09'),
(80, '4', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0IiwidXNlcm5hbWUiOiJiYXJiYXJhIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA1NjUyMzh9.-FtXQwXszyRkYyK3lUPllrQLW74J3imCMHLH7gCZLsY', '2025-10-15 21:53:58', 0, '2025-10-14 21:53:58'),
(81, '4', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0IiwidXNlcm5hbWUiOiJiYXJiYXJhIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA1NjY1OTJ9.VakiowlgqVUXXBdgBAkPjEvqDzvosLUlChJjAnoRbvc', '2025-10-15 22:16:32', 0, '2025-10-14 22:16:32'),
(82, '6', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2IiwidXNlcm5hbWUiOiJ2aHVnZ2xlciIsInJvbGUiOiJ1c2VyIiwiZXhwIjoxNzYwNjUxNjkwfQ.qD4a378VJ1hWvh8cxG6bW_biMSwMVAabVk-rWB0OXBU', '2025-10-15 22:00:32', 1, '2025-10-15 21:54:50'),
(83, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJ2aHVnZ2xlciIsInJvbGUiOiJ1c2VyIiwiZXhwIjoxNzYwNjUyNDQ2fQ.qo_wrGzA-4A4P0SMTLLCzzhadFyvHiG2BD2SInFl4ZY', '2025-10-15 22:07:32', 1, '2025-10-15 22:07:26'),
(84, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJ2aHVnZ2xlciIsInJvbGUiOiJ1c2VyIiwiZXhwIjoxNzYwNjUyNDg5fQ.rswpf7hY5uq5Zufq-kfiIRMKW4Kzrtn1MTy3g0PLMNw', '2025-10-15 22:08:17', 1, '2025-10-15 22:08:09'),
(85, '8', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI4IiwidXNlcm5hbWUiOiJmcGFjaGxhIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA2NTM3NTh9.yBgTPrWQWWPx53MG7S6ZQy2seYTKbruFSEYTEmW1phQ', '2025-10-15 22:30:05', 1, '2025-10-15 22:29:18'),
(86, '8', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI4IiwidXNlcm5hbWUiOiJmcGFjaGxhIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA2NTM3NTh9.yBgTPrWQWWPx53MG7S6ZQy2seYTKbruFSEYTEmW1phQ', '2025-10-15 22:30:05', 1, '2025-10-15 22:29:18'),
(87, '8', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI4IiwidXNlcm5hbWUiOiJmcGFjaGxhIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA2NTM4MjJ9.Db4TOZsqnF1itV0inLK2uLgp1UstuTLyex_cJYY7N0g', '2025-10-15 22:30:30', 1, '2025-10-15 22:30:22'),
(88, '8', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI4IiwidXNlcm5hbWUiOiJmcGFjaGxhIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA2NTM4MjN9.InU20r-yhrc-dGO5GPx8ESxtpFQ-Izi4shl-TstMgwg', '2025-10-15 22:30:30', 1, '2025-10-15 22:30:23'),
(89, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJ2aHVnZ2xlciIsInJvbGUiOiJ1c2VyIiwiZXhwIjoxNzYwNjU2MDAxfQ.jAeECRLgXnbWHjswNMys4VTEiOD0BL_nahtcacQutfs', '2025-10-16 23:06:41', 0, '2025-10-15 23:06:41'),
(90, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwidXNlcm5hbWUiOiJ2aHVnZ2xlciIsInJvbGUiOiJ1c2VyIiwiZXhwIjoxNzYwNjU2MjI0fQ.jYjACp95N0QqDHdNIGgOqCwjZ9dzwLdOYMEzwLumqNc', '2025-10-16 23:10:24', 0, '2025-10-15 23:10:24'),
(91, '5', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI1IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA3MTI0NDV9.CNwsdZi8INzMkQhjNQ6_kQ3-9gqFYCliKSzxjFUI8qA', '2025-10-17 14:47:25', 0, '2025-10-16 14:47:25'),
(92, '5', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI1IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA3MTI2MzN9.f3nAvPTYwHg--taXoM8itmDERaEIfo-QEBA8sQXp3Ko', '2025-10-16 14:53:20', 1, '2025-10-16 14:50:33'),
(93, '5', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI1IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA3MTgzOTZ9.zA3KObmDE4H6ARPlzl1X51YL2jqzxOTckyBrnMWrPes', '2025-10-16 16:34:28', 1, '2025-10-16 16:26:36'),
(94, '5', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI1IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA3MTg5NDJ9.t5m8zx9R58GCUV0qYWOwvBZ5BnlSh2umyHIxlkV_2OU', '2025-10-17 16:35:42', 0, '2025-10-16 16:35:42'),
(95, '10', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMCIsInVzZXJuYW1lIjoiYmF0bWFuIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA4MjY3NTR9.S6jp4zAkjaVCNYknGNGfbhyhrPsYDE7DzrlmKg4NXJ8', '2025-10-17 22:37:22', 1, '2025-10-17 22:32:34'),
(96, '10', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMCIsInVzZXJuYW1lIjoiYmF0bWFuIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA4MjcwMTZ9.q6vt4IzQh9DmBe_Wd86zx75O4ithTwWfZEfF9yqLVHc', '2025-10-17 22:36:59', 1, '2025-10-17 22:36:56'),
(97, '10', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMCIsInVzZXJuYW1lIjoiYmF0bWFuIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA4MjcwMzh9.7kZMXpGPttLfSrc-H6hB1NXyxChKa2ZgleO7dvu2y5c', '2025-10-17 22:37:22', 1, '2025-10-17 22:37:18'),
(98, '11', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMSIsInVzZXJuYW1lIjoiYW5kcmUiLCJyb2xlIjoidXNlciIsImV4cCI6MTc2MDg5OTg4MH0.QP5maC0u7QoGh_0CuLNByI8qPeQeKCrM5LQEHpYjPjY', '2025-10-18 18:52:10', 1, '2025-10-18 18:51:20'),
(99, '11', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMSIsInVzZXJuYW1lIjoiYW5kcmUiLCJyb2xlIjoidXNlciIsImV4cCI6MTc2MDg5OTkzNX0.Gz8qlj_LpnPP5MtcboVTVuzzJXkiaGahvUImix15LaA', '2025-10-18 18:52:22', 1, '2025-10-18 18:52:15'),
(100, '5', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI1IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA5MDA1MzV9.Jz3j5Jf37q4ShQzLbbTYC1CNEI45_JN9H3TdEY0Z8hA', '2025-10-18 19:03:26', 1, '2025-10-18 19:02:15'),
(101, '5', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI1IiwidXNlcm5hbWUiOiJlbWFudWVsIiwicm9sZSI6InVzZXIiLCJleHAiOjE3NjA5ODU0NTh9.pwsKYxKnisSdce0Mm1bPwZi2D-G4ezePhIQo6F2d0pM', '2025-10-20 18:37:38', 0, '2025-10-19 18:37:38');

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
(4, 'BARBARA', 'barbara', '1234', NULL, NULL, 'user', 'sddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd   dssssd', NULL),
(5, 'EMANUEL 565665', 'emanuel', '1234', NULL, NULL, 'user', NULL, NULL),
(9, 'EMANUEL2', 'emanuel2', '1234', NULL, NULL, 'user', NULL, NULL),
(2, 'EMANUEL', 'neko', '1234', NULL, NULL, 'user', '', ''),
(7, 'VITOR HUGGLER', 'vhuggler', 'vhuggler', 'vhuggler@hotmail.com', '15996626628', 'user', 'Alguma experiência ai com alguma coisa, mas eu não sei o que', 'Nenhuma. Sanidade foi pro inferno há algumas eras\r\n');

--
-- Indexes for dumped tables
--

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
-- AUTO_INCREMENT for table `token_usuarios`
--
ALTER TABLE `token_usuarios`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 18, 2025 at 07:47 AM
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
-- Database: `quailtymed`
--

-- --------------------------------------------------------

--
-- Table structure for table `assets`
--

CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `asset_type_id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `asset_tag` varchar(50) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `serial_no` varchar(100) DEFAULT NULL,
  `location` varchar(200) DEFAULT NULL,
  `vendor` varchar(150) DEFAULT NULL,
  `installation_date` date DEFAULT NULL,
  `warranty_end` date DEFAULT NULL,
  `next_calibration_date` date DEFAULT NULL,
  `status` enum('active','inactive','maintenance','decommissioned') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `assets`
--

INSERT INTO `assets` (`id`, `asset_type_id`, `name`, `asset_tag`, `model`, `serial_no`, `location`, `vendor`, `installation_date`, `warranty_end`, `next_calibration_date`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Main Transformer Unit 1', 'TRF-001', 'TX-1000', 'TX123456', 'Electrical Room A', 'PowerTech Solutions', '2023-01-15', NULL, '2024-01-15', 'active', '2025-09-13 11:56:08', '2025-09-13 11:56:08'),
(2, 2, 'Emergency Generator 1', 'DG-001', 'DG-500KVA', 'DG789012', 'Generator Room', 'GenPower Ltd', '2023-02-01', NULL, '2024-02-01', 'active', '2025-09-13 11:56:08', '2025-09-13 11:56:08'),
(3, 6, 'X-Ray Machine ICU', 'XR-001', 'XR-Pro-2000', 'XR345678', 'ICU Department', 'MedEquip Inc', '2023-03-10', NULL, '2024-03-10', 'active', '2025-09-13 11:56:08', '2025-09-13 11:56:08'),
(4, 13, 'PC Monitor', 'GDHRI/GF/MONI/01', 'lenovo', '60BDAAR6WWV90ZZK6', 'FRONT OFFICE', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(5, 13, 'PC Monitor', 'GDHRI/GF/MONI/02', 'AOC', 'AOC1TF2L0952040', 'FRONT OFFICE', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(6, 13, 'PC Monitor', 'GDHRI/GF/MONI/03', 'lenovo', 'VIDYB4', 'FRONT OFFICE', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(7, 13, 'PC Monitor', 'GDHRI/GF/MONI/04', 'AOC', 'AOC1TF2L0951134', 'FRONT OFFICE', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(8, 13, 'PC Monitor', 'GDHRI/GF/MONI/05', 'ViewSonic', 'W2V2334422655', 'FRONT OFFICE', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(9, 13, 'PC Monitor', 'GDHRI/GF/MONI/06', 'HP', 'CNC9530018', 'FRONT OFFICE', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(10, 13, 'PC Monitor', 'GDHRI/GF/MONI/07', 'lenovo', 'V3260J6Y', 'FRONT OFFICE', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(11, 13, 'PC Monitor', 'GDHRI/1FR/MONI/08', 'HP', 'CNC7501704', '1ST FLOOR D/C', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(12, 13, 'PC Monitor', 'GDHRI/1FR/MONI/09', 'HP', 'CNC7501740', '1ST FLOOR D/C', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(13, 13, 'PC Monitor', 'GDHRI/1FR/MONI/10', 'HP', 'CNC7501729', '1ST FLOOR D/C', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(14, 13, 'PC Monitor', 'GDHRI/1FR/MONI/11', 'Dell', 'CN-0M355H-64180-866-07DL', 'OPD', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(15, 13, 'PC Monitor', 'GDHRI/1FR/MONI/12', 'LG', '610ND2C6E687', 'LAB', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(16, 13, 'PC Monitor', 'GDHRI/1FR/MONI/13', 'LG', '309THPF011707', 'MALE WARD', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(17, 13, 'PC Monitor', 'GDHRI/1FR/MONI/14', 'HP', 'CNC9530014', 'FEMALE WARD', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(18, 13, 'PC Monitor', 'GDHRI/2FR/MONI/15', 'HP', 'CNC7501736', '2ND FLOOR', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(19, 13, 'PC Monitor', 'GDHRI/2FR/MONI/16', 'HP', 'CNC7501716', '2ND FLOOR', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(20, 13, 'PC Monitor', 'GDHRI/2FR/MONI/17', 'HP', 'CNC7501739', '2ND FLOOR', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(21, 13, 'PC Monitor', 'GDHRI/2FR/MONI/18', 'LG', '309THPF012001', 'N.S. ROOM', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(22, 13, 'PC Monitor', 'GDHRI/2FR/MONI/19', 'AOC', 'AOC1TF2L0951912', 'N.S. ROOM', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(23, 13, 'PC Monitor', 'GDHRI/2FR/MONI/20', 'Dell', 'CN-0M355H-64180-866-07CL', 'N.S. ROOM', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(24, 13, 'PC Monitor', 'GDHRI/2FR/MONI/21', 'LG', '309THPF011928', 'N.S. ROOM', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(25, 13, 'PC Monitor', 'GDHRI/2FR/MONI/22', 'LG', '309THPF011993', 'N.S. ROOM', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(26, 13, 'PC Monitor', 'GDHRI/2FR/MONI/23', 'AOC', 'AOC1TF2L0951791', 'O.T', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(27, 13, 'PC Monitor', 'GDHRI/2FR/MONI/24', 'HP', 'CNC7501708', 'GASTRO', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(28, 13, 'PC Monitor', 'GDHRI/2FR/MONI/25', 'HP', 'CNC7501705', 'GASTRO', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(29, 13, 'PC Monitor', 'GDHRI/2FR/MONI/26', 'HP', 'CNC7501707', 'GASTRO', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(30, 13, 'PC Monitor', 'GDHRI/2FR/MONI/27', 'HP', 'CNC7501721', 'GASTRO', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(31, 13, 'PC Monitor', 'GDHRI/2FR/MONI/28', 'HP', 'CNC7501712', 'GASTRO', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(32, 13, 'PC Monitor', 'GDHRI/2FR/MONI/29', 'HP', 'CNC7501711', 'GASTRO', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(33, 13, 'PC Monitor', 'GDHRI/2FR/MONI/30', 'HP', 'CNC7501717', 'GASTRO', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(34, 13, 'PC Monitor', 'GDHRI/2FR/MONI/31', 'HP', 'CNC7501713', 'GASTRO', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(35, 13, 'PC Monitor', 'GDHRI/2FR/MONI/32', 'HP', 'CNC7501715', 'GASTRO', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(36, 13, 'PC Monitor', 'GDHRI/2FR/MONI/33', 'HP', 'CNC7501726', 'GASTRO', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(37, 13, 'PC Monitor', 'GDHRI/2FR/MONI/34', 'HP', 'CNC7501725', 'GASTRO', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(38, 13, 'PC Monitor', 'GDHRI/2FR/MONI/35', 'HP', 'CNC7501732', 'GASTRO', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(39, 13, 'PC Monitor', 'GDHRI/2FR/MONI/36', 'HP', 'CNC7501722', 'GASTRO', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(40, 13, 'PC Monitor', 'GDHRI/2FR/MONI/37', 'HP', 'CNC7501720', 'GASTRO', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(41, 13, 'PC Monitor', 'GDHRI/2FR/MONI/38', 'HP', 'CNC7501714', 'GASTRO', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(42, 13, 'PC Monitor', 'GDHRI/2FR/MONI/39', 'HP', 'CNC7501727', 'GASTRO', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(43, 13, 'PC Monitor', 'GDHRI/2FR/MONI/40', 'HP', 'CNC7501718', 'GASTRO', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(44, 13, 'PC Monitor', 'GDHRI/2FR/MONI/41', 'HP', 'CNC7501719', 'GASTRO', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(45, 13, 'PC Monitor', 'GDHRI/2FR/MONI/42', 'HP', 'CNC7501733', 'GASTRO', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(46, 13, 'PC Monitor', 'GDHRI/2FR/MONI/43', 'HP', 'CNC7501702', 'GASTRO', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(47, 13, 'PC Monitor', 'GDHRI/2FR/MONI/44', 'HP', 'CNC7501728', 'GASTRO', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(48, 13, 'PC Monitor', 'GDHRI/2FR/MONI/45', 'HP', 'CNC7501701', 'GASTRO', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(49, 13, 'PC Monitor', 'GDHRI/2FR/MONI/46', 'HP', 'CNC7501703', 'GASTRO', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(50, 13, 'PC Monitor', 'GDHRI/2FR/MONI/47', 'HP', 'CNC7501706', 'GASTRO', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(51, 13, 'PC Monitor', 'GDHRI/2FR/MONI/48', 'HP', 'CNC7501734', 'GASTRO', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(52, 13, 'PC Monitor', 'GDHRI/2FR/MONI/49', 'HP', 'CNC7501731', 'GASTRO', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(53, 13, 'PC Monitor', 'GDHRI/2FR/MONI/50', 'HP', 'CNC7501738', 'GASTRO', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(54, 13, 'PC Monitor', 'GDHRI/2FR/MONI/51', 'HP', 'CNC7501737', 'GASTRO', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(55, 13, 'PC Monitor', 'GDHRI/2FR/MONI/52', NULL, NULL, 'GASTRO', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(56, 13, 'PC Monitor', 'GDHRI/3FR/MONI/53', 'ViewSonic', 'W2V234422618', 'N.S. ROOM', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(57, 13, 'PC Monitor', 'GDHRI/3FR/MONI/54', 'ViewSonic', 'XBG2416A3382', 'CRITICAL CARE', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(58, 13, 'PC Monitor', 'GDHRI/3FR/MONI/55', 'LG', '309THPF013288', 'ICU EXT', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(59, 13, 'PC Monitor', 'GDHRI/3FR/MONI/56', 'LG', '309THPF013288', 'ICU MAIN', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15'),
(60, 13, 'PC Monitor', 'GDHRI/3FR/MONI/57', 'LAPCARE', 'LB36262595', 'MRD', 'GDHRI Store', '2025-09-01', NULL, '2025-09-10', 'active', '2025-09-15 10:37:15', '2025-09-15 10:37:15');

-- --------------------------------------------------------

--
-- Table structure for table `asset_types`
--

CREATE TABLE `asset_types` (
  `id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `asset_types`
--

INSERT INTO `asset_types` (`id`, `department_id`, `name`, `description`, `created_at`) VALUES
(1, 1, 'Transformer', 'Electrical transformers and power equipment', '2025-09-13 11:56:08'),
(2, 1, 'Diesel Generator', 'Backup power generation systems', '2025-09-13 11:56:08'),
(3, 1, 'Electric', 'General electrical equipment and panels', '2025-09-13 11:56:08'),
(4, 1, 'Medical Gas', 'Medical gas pipeline and equipment', '2025-09-13 11:56:08'),
(5, 1, 'AC', 'Air conditioning and HVAC systems', '2025-09-13 11:56:08'),
(6, 2, 'X-Ray Machine', 'Radiographic imaging equipment', '2025-09-13 11:56:08'),
(7, 2, 'CT Scanner', 'Computed tomography scanners', '2025-09-13 11:56:08'),
(8, 2, 'MRI', 'Magnetic resonance imaging equipment', '2025-09-13 11:56:08'),
(9, 3, 'Analyzer', 'Laboratory analyzers and testing equipment', '2025-09-13 11:56:08'),
(10, 3, 'Centrifuge', 'Laboratory centrifuge equipment', '2025-09-13 11:56:08'),
(11, 4, 'Ventilator', 'Mechanical ventilation equipment', '2025-09-13 11:56:08'),
(12, 4, 'Monitor', 'Patient monitoring systems', '2025-09-13 11:56:08'),
(13, 7, 'PC Monitor', 'LED Monitor', '2025-09-13 11:56:08');

-- --------------------------------------------------------

--
-- Table structure for table `attachments`
--

CREATE TABLE `attachments` (
  `id` int(11) NOT NULL,
  `entity_type` varchar(50) NOT NULL,
  `entity_id` int(11) NOT NULL,
  `original_filename` varchar(255) NOT NULL,
  `stored_filename` varchar(255) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `mime_type` varchar(100) DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL,
  `uploaded_by` int(11) NOT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attachments`
--

INSERT INTO `attachments` (`id`, `entity_type`, `entity_id`, `original_filename`, `stored_filename`, `file_path`, `mime_type`, `file_size`, `uploaded_by`, `uploaded_at`) VALUES
(1, 'checklist_item', 17, 'Regarding CA2 Exam.pdf', 'upload_68c7a112406b99.83639914.pdf', 'uploads/upload_68c7a112406b99.83639914.pdf', 'application/pdf', 114504, 1, '2025-09-15 05:16:02'),
(2, 'checklist_item', 133, '📑 Minor Project Proposal.docx', 'upload_68cb99137cc4a7.04289213.docx', 'uploads/upload_68cb99137cc4a7.04289213.docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 16287, 1, '2025-09-18 05:30:59');

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `entity_type` varchar(50) DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `meta_json` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `user_id`, `action`, `entity_type`, `entity_id`, `meta_json`, `ip_address`, `user_agent`, `created_at`) VALUES
(1, 1, 'login', 'user', 1, '[]', '::1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-13 13:27:22'),
(2, 1, 'create_checklist', 'checklist', 1, '{\"asset_id\":1,\"document_type_id\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-13 13:27:52'),
(3, 1, 'update_checklist_item', 'checklist_item', 1, '{\"checklist_id\":1,\"result\":\"pass\",\"ncr_created\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-13 13:27:57'),
(4, 1, 'create_ncr', 'ncr', 1, '{\"ncr_number\":\"NCR-2025-0001\",\"checklist_item_id\":2}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-13 13:28:05'),
(5, 1, 'update_checklist_item', 'checklist_item', 2, '{\"checklist_id\":1,\"result\":\"fail\",\"ncr_created\":true}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-13 13:28:05'),
(6, 1, 'update_checklist_item', 'checklist_item', 3, '{\"checklist_id\":1,\"result\":\"pass\",\"ncr_created\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-13 13:28:10'),
(7, 1, 'update_checklist_item', 'checklist_item', 4, '{\"checklist_id\":1,\"result\":\"pass\",\"ncr_created\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-13 13:28:14'),
(8, 1, 'update_checklist_item', 'checklist_item', 4, '{\"checklist_id\":1,\"result\":\"na\",\"ncr_created\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-13 13:28:22'),
(9, 1, 'create_checklist', 'checklist', 2, '{\"asset_id\":1,\"document_type_id\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-13 13:29:08'),
(10, 1, 'update_checklist_item', 'checklist_item', 5, '{\"checklist_id\":2,\"result\":\"pass\",\"ncr_created\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-13 13:29:16'),
(11, 1, 'update_checklist_item', 'checklist_item', 5, '{\"checklist_id\":2,\"result\":\"pass\",\"ncr_created\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-13 13:29:27'),
(12, 1, 'update_checklist_item', 'checklist_item', 6, '{\"checklist_id\":2,\"result\":\"pass\",\"ncr_created\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-13 13:29:35'),
(13, 1, 'update_checklist_item', 'checklist_item', 6, '{\"checklist_id\":2,\"result\":\"pass\",\"ncr_created\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-13 13:29:40'),
(14, 1, 'update_checklist_item', 'checklist_item', 7, '{\"checklist_id\":2,\"result\":\"pass\",\"ncr_created\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-13 13:29:45'),
(15, 1, 'update_checklist_item', 'checklist_item', 8, '{\"checklist_id\":2,\"result\":\"na\",\"ncr_created\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-13 13:29:49'),
(16, 1, 'update_checklist_item', 'checklist_item', 8, '{\"checklist_id\":2,\"result\":\"na\",\"ncr_created\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-13 13:29:54'),
(17, 1, 'update_checklist_item', 'checklist_item', 8, '{\"checklist_id\":2,\"result\":\"na\",\"ncr_created\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-13 13:29:56'),
(18, 1, 'login', 'user', 1, '[]', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 04:54:29'),
(19, 1, 'create_checklist', 'checklist', 3, '{\"asset_id\":1,\"document_type_id\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 04:55:10'),
(20, 1, 'update_checklist_item', 'checklist_item', 9, '{\"checklist_id\":3,\"result\":\"pass\",\"ncr_created\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 04:55:12'),
(21, 1, 'create_ncr', 'ncr', 2, '{\"ncr_number\":\"NCR-2025-0002\",\"checklist_item_id\":10}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 04:56:16'),
(22, 1, 'update_checklist_item', 'checklist_item', 10, '{\"checklist_id\":3,\"result\":\"fail\",\"ncr_created\":true}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 04:56:16'),
(23, 1, 'update_checklist_item', 'checklist_item', 12, '{\"checklist_id\":3,\"result\":\"pass\",\"ncr_created\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 04:57:02'),
(24, 1, 'create_checklist', 'checklist', 4, '{\"asset_id\":1,\"document_type_id\":3}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 04:59:43'),
(25, 1, 'create_checklist', 'checklist', 5, '{\"asset_id\":1,\"document_type_id\":2}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 05:15:40'),
(26, 1, 'file_upload', 'attachment', 1, '{\"entity_type\":\"checklist_item\",\"entity_id\":17,\"filename\":\"Regarding CA2 Exam.pdf\",\"size\":114504}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 05:16:02'),
(27, 1, 'logout', 'user', 1, '[]', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 05:21:04'),
(28, 2, 'login', 'user', 2, '[]', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 05:21:10'),
(29, 2, 'create_checklist', 'checklist', 6, '{\"asset_id\":1,\"document_type_id\":4}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 05:21:23'),
(30, 2, 'create_checklist', 'checklist', 7, '{\"asset_id\":1,\"document_type_id\":3}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 05:21:36'),
(31, 1, 'login', 'user', 1, '[]', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 07:03:16'),
(32, 1, 'login', 'user', 1, '[]', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 10:37:47'),
(33, 1, 'create_checklist', 'checklist', 8, '{\"asset_id\":1,\"document_type_id\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 10:37:54'),
(34, 1, 'create_checklist', 'checklist', 9, '{\"asset_id\":1,\"document_type_id\":1}', '::1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-15 10:43:33'),
(35, 1, 'create_checklist', 'checklist', 10, '{\"asset_id\":1,\"document_type_id\":3}', '::1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-15 10:43:38'),
(36, 1, 'logout', 'user', 1, '[]', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 11:41:24'),
(37, 1, 'login', 'user', 1, '[]', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 11:41:39'),
(38, 1, 'create_checklist', 'checklist', 11, '{\"asset_id\":1,\"document_type_id\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 11:42:20'),
(39, 1, 'login', 'user', 1, '[]', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 13:55:17'),
(40, 1, 'create_checklist', 'checklist', 12, '{\"asset_id\":1,\"document_type_id\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 13:55:58'),
(41, 1, 'update_checklist_item', 'checklist_item', 45, '{\"checklist_id\":12,\"result\":\"pass\",\"ncr_created\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 13:56:07'),
(42, 1, 'logout', 'user', 1, '[]', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 13:59:00'),
(43, 2, 'login', 'user', 2, '[]', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 13:59:54'),
(44, 1, 'login', 'user', 1, '[]', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 15:47:37'),
(45, 1, 'login', 'user', 1, '[]', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 15:50:09'),
(46, 1, 'create_checklist', 'checklist', 13, '{\"asset_id\":1,\"document_type_id\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 15:50:48'),
(47, 1, 'create_checklist', 'checklist', 14, '{\"asset_id\":1,\"document_type_id\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 15:53:10'),
(48, 1, 'bulk_update_checklist', 'checklist', 14, '[]', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 15:53:23'),
(49, 1, 'create_checklist', 'checklist', 15, '{\"asset_id\":1,\"document_type_id\":4}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 15:53:31'),
(50, 1, 'bulk_update_checklist', 'checklist', 15, '[]', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 15:53:49'),
(51, 1, 'create_checklist', 'checklist', 16, '{\"asset_id\":1,\"document_type_id\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 15:56:53'),
(52, 1, 'login', 'user', 1, '[]', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-15 16:05:54'),
(53, 1, 'login', 'user', 1, '[]', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-15 16:07:08'),
(54, 1, 'create_checklist', 'checklist', 17, '{\"asset_id\":1,\"document_type_id\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-15 16:08:15'),
(55, 1, 'create_checklist', 'checklist', 18, '{\"asset_id\":1,\"document_type_id\":3}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-15 16:17:25'),
(56, 1, 'login', 'user', 1, '[]', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-16 06:39:14'),
(57, 1, 'create_checklist', 'checklist', 19, '{\"asset_id\":1,\"document_type_id\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-16 06:39:37'),
(58, 1, 'login', 'user', 1, '[]', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-16 06:41:42'),
(59, 1, 'create_checklist', 'checklist', 20, '{\"asset_id\":1,\"document_type_id\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-16 07:08:16'),
(60, 1, 'create_checklist', 'checklist', 21, '{\"asset_id\":1,\"document_type_id\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-16 07:20:02'),
(61, 1, 'login', 'user', 1, '[]', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-16 07:20:27'),
(62, 1, 'create_checklist', 'checklist', 22, '{\"asset_id\":4,\"document_type_id\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-16 07:20:42'),
(63, 1, 'create_checklist', 'checklist', 23, '{\"asset_id\":10,\"document_type_id\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-16 07:21:01'),
(64, 1, 'create_checklist', 'checklist', 24, '{\"asset_id\":4,\"document_type_id\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-16 07:21:26'),
(65, 1, 'create_checklist', 'checklist', 25, '{\"asset_id\":1,\"document_type_id\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-16 07:21:35'),
(66, 1, 'create_checklist', 'checklist', 26, '{\"asset_id\":4,\"document_type_id\":3}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-16 07:21:49'),
(67, 1, 'create_checklist', 'checklist', 27, '{\"asset_id\":4,\"document_type_id\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-16 07:22:27'),
(68, 1, 'bulk_update_checklist', 'checklist', 27, '[]', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-16 07:22:41'),
(69, 1, 'create_checklist', 'checklist', 28, '{\"asset_id\":1,\"document_type_id\":1}', '::1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-16 07:25:18'),
(70, 1, 'create_checklist', 'checklist', 29, '{\"asset_id\":1,\"document_type_id\":1}', '::1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-16 07:26:21'),
(71, 1, 'create_checklist', 'checklist', 30, '{\"asset_id\":1,\"document_type_id\":1}', '::1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-16 07:27:29'),
(72, 1, 'create_checklist', 'checklist', 31, '{\"asset_id\":4,\"document_type_id\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-16 07:28:23'),
(73, 1, 'bulk_update_checklist', 'checklist', 31, '[]', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-16 08:19:23'),
(74, 1, 'login', 'user', 1, '[]', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-18 05:26:12'),
(75, 1, 'create_checklist', 'checklist', 32, '{\"asset_id\":4,\"document_type_id\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-18 05:26:20'),
(76, 1, 'create_checklist', 'checklist', 33, '{\"asset_id\":4,\"document_type_id\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-18 05:28:29'),
(77, 1, 'create_checklist', 'checklist', 34, '{\"asset_id\":4,\"document_type_id\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-18 05:30:45'),
(78, 1, 'file_upload', 'attachment', 2, '{\"entity_type\":\"checklist_item\",\"entity_id\":133,\"filename\":\"\\ud83d\\udcd1 Minor Project Proposal.docx\",\"size\":16287}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-18 05:30:59'),
(79, 1, 'bulk_update_checklist', 'checklist', 34, '[]', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-18 05:31:11'),
(80, 1, 'create_checklist', 'checklist', 35, '{\"asset_id\":4,\"document_type_id\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-18 05:38:02');

-- --------------------------------------------------------

--
-- Table structure for table `checklists`
--

CREATE TABLE `checklists` (
  `id` int(11) NOT NULL,
  `asset_id` int(11) NOT NULL,
  `document_type_id` int(11) NOT NULL,
  `checklist_name` varchar(200) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `assigned_to` int(11) DEFAULT NULL,
  `status` enum('draft','in_progress','completed','signed_off','expired') NOT NULL DEFAULT 'draft',
  `due_date` date DEFAULT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `signed_off_by` int(11) DEFAULT NULL,
  `signed_off_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `checklists`
--

INSERT INTO `checklists` (`id`, `asset_id`, `document_type_id`, `checklist_name`, `created_by`, `assigned_to`, `status`, `due_date`, `completed_at`, `signed_off_by`, `signed_off_at`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Daily Checklist - 9/13/2025', 1, 1, 'in_progress', '2025-09-14', NULL, NULL, NULL, '2025-09-13 13:27:52', '2025-09-13 13:27:57'),
(2, 1, 1, 'Daily Checklist - 9/13/2025', 1, 1, 'in_progress', '2025-09-14', NULL, NULL, NULL, '2025-09-13 13:29:08', '2025-09-13 13:29:16'),
(3, 1, 1, 'Daily Checklist - 9/15/2025', 1, 1, 'in_progress', '2025-09-16', NULL, NULL, NULL, '2025-09-15 04:55:10', '2025-09-15 04:55:12'),
(4, 1, 3, 'Calibration - 9/15/2025', 1, 1, 'draft', '2025-09-16', NULL, NULL, NULL, '2025-09-15 04:59:43', '2025-09-15 04:59:43'),
(5, 1, 2, 'Preventive Maintenance - 9/15/2025', 1, 1, 'draft', '2025-09-16', NULL, NULL, NULL, '2025-09-15 05:15:40', '2025-09-15 05:15:40'),
(6, 1, 4, 'Breakdown Maintenance - 9/15/2025', 2, 2, 'draft', '2025-09-16', NULL, NULL, NULL, '2025-09-15 05:21:23', '2025-09-15 05:21:23'),
(7, 1, 3, 'Calibration - 9/15/2025', 2, 2, 'draft', '2025-09-16', NULL, NULL, NULL, '2025-09-15 05:21:36', '2025-09-15 05:21:36'),
(8, 1, 1, 'Daily Checklist - 9/15/2025', 1, 1, 'draft', '2025-09-16', NULL, NULL, NULL, '2025-09-15 10:37:54', '2025-09-15 10:37:54'),
(9, 1, 1, 'Daily Checklist - 9/15/2025', 1, 1, 'draft', '2025-09-16', NULL, NULL, NULL, '2025-09-15 10:43:33', '2025-09-15 10:43:33'),
(10, 1, 3, 'Calibration - 9/15/2025', 1, 1, 'draft', '2025-09-16', NULL, NULL, NULL, '2025-09-15 10:43:38', '2025-09-15 10:43:38'),
(11, 1, 1, 'Daily Checklist - 9/15/2025', 1, 1, 'draft', '2025-09-16', NULL, NULL, NULL, '2025-09-15 11:42:20', '2025-09-15 11:42:20'),
(12, 1, 1, 'Daily Checklist - 9/15/2025', 1, 1, 'in_progress', '2025-09-16', NULL, NULL, NULL, '2025-09-15 13:55:58', '2025-09-15 13:56:07'),
(13, 1, 1, 'Daily Checklist - 9/15/2025', 1, 1, 'draft', '2025-09-16', NULL, NULL, NULL, '2025-09-15 15:50:48', '2025-09-15 15:50:48'),
(14, 1, 1, 'Daily Checklist - 9/15/2025', 1, 1, 'in_progress', '2025-09-16', NULL, NULL, NULL, '2025-09-15 15:53:10', '2025-09-15 15:53:23'),
(15, 1, 4, 'Breakdown Maintenance - 9/15/2025', 1, 1, 'completed', '2025-09-16', '2025-09-15 15:53:49', NULL, NULL, '2025-09-15 15:53:31', '2025-09-15 15:53:49'),
(16, 1, 1, 'Daily Checklist - 9/15/2025', 1, 1, 'draft', '2025-09-16', NULL, NULL, NULL, '2025-09-15 15:56:53', '2025-09-15 15:56:53'),
(17, 1, 1, 'Daily Checklist - 15/9/2025', 1, 1, 'draft', '2025-09-16', NULL, NULL, NULL, '2025-09-15 16:08:15', '2025-09-15 16:08:15'),
(18, 1, 3, 'Calibration - 15/9/2025', 1, 1, 'draft', '2025-09-16', NULL, NULL, NULL, '2025-09-15 16:17:25', '2025-09-15 16:17:25'),
(19, 1, 1, 'Daily Checklist - 16/9/2025', 1, 1, 'draft', '2025-09-17', NULL, NULL, NULL, '2025-09-16 06:39:37', '2025-09-16 06:39:37'),
(20, 1, 1, 'Daily Checklist - 9/16/2025', 1, 1, 'draft', '2025-09-17', NULL, NULL, NULL, '2025-09-16 07:08:16', '2025-09-16 07:08:16'),
(21, 1, 1, 'Daily Checklist - 9/16/2025', 1, 1, 'draft', '2025-09-17', NULL, NULL, NULL, '2025-09-16 07:20:02', '2025-09-16 07:20:02'),
(22, 4, 1, 'Daily Checklist - 16/9/2025', 1, 1, 'draft', '2025-09-17', NULL, NULL, NULL, '2025-09-16 07:20:42', '2025-09-16 07:20:42'),
(23, 10, 1, 'Daily Checklist - 16/9/2025', 1, 1, 'draft', '2025-09-17', NULL, NULL, NULL, '2025-09-16 07:21:01', '2025-09-16 07:21:01'),
(24, 4, 1, 'Daily Checklist - 16/9/2025', 1, 1, 'draft', '2025-09-17', NULL, NULL, NULL, '2025-09-16 07:21:26', '2025-09-16 07:21:26'),
(25, 1, 1, 'Daily Checklist - 16/9/2025', 1, 1, 'draft', '2025-09-17', NULL, NULL, NULL, '2025-09-16 07:21:35', '2025-09-16 07:21:35'),
(26, 4, 3, 'Calibration - 16/9/2025', 1, 1, 'draft', '2025-09-17', NULL, NULL, NULL, '2025-09-16 07:21:49', '2025-09-16 07:21:49'),
(27, 4, 1, 'Daily Checklist - 16/9/2025', 1, 1, 'in_progress', '2025-09-17', NULL, NULL, NULL, '2025-09-16 07:22:27', '2025-09-16 07:22:41'),
(28, 1, 1, 'Daily Checklist - 9/16/2025', 1, 1, 'draft', '2025-09-17', NULL, NULL, NULL, '2025-09-16 07:25:18', '2025-09-16 07:25:18'),
(29, 1, 1, 'Daily Checklist - 9/16/2025', 1, 1, 'draft', '2025-09-17', NULL, NULL, NULL, '2025-09-16 07:26:21', '2025-09-16 07:26:21'),
(30, 1, 1, 'Daily Checklist - 9/16/2025', 1, 1, 'draft', '2025-09-17', NULL, NULL, NULL, '2025-09-16 07:27:29', '2025-09-16 07:27:29'),
(31, 4, 1, 'Daily Checklist - 16/9/2025', 1, 1, 'in_progress', '2025-09-17', NULL, NULL, NULL, '2025-09-16 07:28:23', '2025-09-16 08:19:23'),
(32, 4, 1, 'Daily Checklist - 9/18/2025', 1, 1, 'draft', '2025-09-19', NULL, NULL, NULL, '2025-09-18 05:26:20', '2025-09-18 05:26:20'),
(33, 4, 1, 'Daily Checklist - 9/18/2025', 1, 1, 'draft', '2025-09-19', NULL, NULL, NULL, '2025-09-18 05:28:29', '2025-09-18 05:28:29'),
(34, 4, 1, 'Daily Checklist - 9/18/2025', 1, 1, 'in_progress', '2025-09-19', NULL, NULL, NULL, '2025-09-18 05:30:45', '2025-09-18 05:31:11'),
(35, 4, 1, 'Daily Checklist - 9/18/2025', 1, 1, 'draft', '2025-09-19', NULL, NULL, NULL, '2025-09-18 05:38:02', '2025-09-18 05:38:02');

-- --------------------------------------------------------

--
-- Table structure for table `checklist_items`
--

CREATE TABLE `checklist_items` (
  `id` int(11) NOT NULL,
  `checklist_id` int(11) NOT NULL,
  `standard_id` int(11) DEFAULT NULL,
  `question` text NOT NULL,
  `result` enum('pass','fail','na','pending') DEFAULT 'pending',
  `remarks` text DEFAULT NULL,
  `attached_file` varchar(255) DEFAULT NULL,
  `checked_by` int(11) DEFAULT NULL,
  `checked_at` timestamp NULL DEFAULT NULL,
  `order_index` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `checklist_items`
--

INSERT INTO `checklist_items` (`id`, `checklist_id`, `standard_id`, `question`, `result`, `remarks`, `attached_file`, `checked_by`, `checked_at`, `order_index`) VALUES
(1, 1, 4, 'Equipment is clean and free from damage', 'pass', '', NULL, 1, '2025-09-13 13:27:57', 1),
(2, 1, 2, 'All safety devices are functioning properly', 'fail', '', NULL, 1, '2025-09-13 13:28:04', 2),
(3, 1, 4, 'Operating parameters are within specified ranges', 'pass', '', NULL, 1, '2025-09-13 13:28:10', 3),
(4, 1, 1, 'Log books are properly maintained', 'na', '', NULL, 1, '2025-09-13 13:28:22', 4),
(5, 2, 4, 'Equipment is clean and free from damage', 'pass', 'cleaning done', NULL, 1, '2025-09-13 13:29:27', 1),
(6, 2, 2, 'All safety devices are functioning properly', 'pass', 'yes', NULL, 1, '2025-09-13 13:29:40', 2),
(7, 2, 4, 'Operating parameters are within specified ranges', 'pass', '', NULL, 1, '2025-09-13 13:29:45', 3),
(8, 2, 1, 'Log books are properly maintained', 'na', 'not found', NULL, 1, '2025-09-13 13:29:56', 4),
(9, 3, 4, 'Equipment is clean and free from damage', 'pass', '', NULL, 1, '2025-09-15 04:55:12', 1),
(10, 3, 2, 'All safety devices are functioning properly', 'fail', '', NULL, 1, '2025-09-15 04:56:16', 2),
(11, 3, 4, 'Operating parameters are within specified ranges', 'pending', NULL, NULL, NULL, NULL, 3),
(12, 3, 1, 'Log books are properly maintained', 'pass', '', NULL, 1, '2025-09-15 04:57:02', 4),
(13, 4, 4, 'Calibration standards are traceable', 'pending', NULL, NULL, NULL, NULL, 1),
(14, 4, 4, 'Equipment accuracy is within tolerance', 'pending', NULL, NULL, NULL, NULL, 2),
(15, 4, 4, 'Calibration certificate issued', 'pending', NULL, NULL, NULL, NULL, 3),
(16, 4, 1, 'Next calibration date scheduled', 'pending', NULL, NULL, NULL, NULL, 4),
(17, 5, 4, 'Equipment maintenance schedule is followed', 'pending', NULL, 'uploads/upload_68c7a112406b99.83639914.pdf', NULL, NULL, 1),
(18, 5, 4, 'All components inspected and cleaned', 'pending', NULL, NULL, NULL, NULL, 2),
(19, 5, 2, 'Safety systems tested and verified', 'pending', NULL, NULL, NULL, NULL, 3),
(20, 5, 1, 'Maintenance records updated', 'pending', NULL, NULL, NULL, NULL, 4),
(21, 6, 4, 'Equipment is clean and free from damage', 'pending', NULL, NULL, NULL, NULL, 1),
(22, 6, 2, 'All safety devices are functioning properly', 'pending', NULL, NULL, NULL, NULL, 2),
(23, 6, 4, 'Operating parameters are within specified ranges', 'pending', NULL, NULL, NULL, NULL, 3),
(24, 6, 1, 'Log books are properly maintained', 'pending', NULL, NULL, NULL, NULL, 4),
(25, 7, 4, 'Calibration standards are traceable', 'pending', NULL, NULL, NULL, NULL, 1),
(26, 7, 4, 'Equipment accuracy is within tolerance', 'pending', NULL, NULL, NULL, NULL, 2),
(27, 7, 4, 'Calibration certificate issued', 'pending', NULL, NULL, NULL, NULL, 3),
(28, 7, 1, 'Next calibration date scheduled', 'pending', NULL, NULL, NULL, NULL, 4),
(29, 8, 4, 'Equipment is clean and free from damage', 'pending', NULL, NULL, NULL, NULL, 1),
(30, 8, 2, 'All safety devices are functioning properly', 'pending', NULL, NULL, NULL, NULL, 2),
(31, 8, 4, 'Operating parameters are within specified ranges', 'pending', NULL, NULL, NULL, NULL, 3),
(32, 8, 1, 'Log books are properly maintained', 'pending', NULL, NULL, NULL, NULL, 4),
(33, 9, 4, 'Equipment is clean and free from damage', 'pending', NULL, NULL, NULL, NULL, 1),
(34, 9, 2, 'All safety devices are functioning properly', 'pending', NULL, NULL, NULL, NULL, 2),
(35, 9, 4, 'Operating parameters are within specified ranges', 'pending', NULL, NULL, NULL, NULL, 3),
(36, 9, 1, 'Log books are properly maintained', 'pending', NULL, NULL, NULL, NULL, 4),
(37, 10, 4, 'Calibration standards are traceable', 'pending', NULL, NULL, NULL, NULL, 1),
(38, 10, 4, 'Equipment accuracy is within tolerance', 'pending', NULL, NULL, NULL, NULL, 2),
(39, 10, 4, 'Calibration certificate issued', 'pending', NULL, NULL, NULL, NULL, 3),
(40, 10, 1, 'Next calibration date scheduled', 'pending', NULL, NULL, NULL, NULL, 4),
(41, 11, 4, 'Equipment is clean and free from damage', 'pending', NULL, NULL, NULL, NULL, 1),
(42, 11, 2, 'All safety devices are functioning properly', 'pending', NULL, NULL, NULL, NULL, 2),
(43, 11, 4, 'Operating parameters are within specified ranges', 'pending', NULL, NULL, NULL, NULL, 3),
(44, 11, 1, 'Log books are properly maintained', 'pending', NULL, NULL, NULL, NULL, 4),
(45, 12, 4, 'Equipment is clean and free from damage', 'pass', '', NULL, 1, '2025-09-15 13:56:07', 1),
(46, 12, 2, 'All safety devices are functioning properly', 'pending', NULL, NULL, NULL, NULL, 2),
(47, 12, 4, 'Operating parameters are within specified ranges', 'pending', NULL, NULL, NULL, NULL, 3),
(48, 12, 1, 'Log books are properly maintained', 'pending', NULL, NULL, NULL, NULL, 4),
(49, 13, 4, 'Equipment is clean and free from damage', 'pending', NULL, NULL, NULL, NULL, 1),
(50, 13, 2, 'All safety devices are functioning properly', 'pending', NULL, NULL, NULL, NULL, 2),
(51, 13, 4, 'Operating parameters are within specified ranges', 'pending', NULL, NULL, NULL, NULL, 3),
(52, 13, 1, 'Log books are properly maintained', 'pending', NULL, NULL, NULL, NULL, 4),
(53, 14, 4, 'Equipment is clean and free from damage', 'pass', '', NULL, 1, '2025-09-15 15:53:23', 1),
(54, 14, 2, 'All safety devices are functioning properly', 'fail', '', NULL, 1, '2025-09-15 15:53:23', 2),
(55, 14, 4, 'Operating parameters are within specified ranges', 'pending', '', NULL, 1, '2025-09-15 15:53:23', 3),
(56, 14, 1, 'Log books are properly maintained', 'fail', '', NULL, 1, '2025-09-15 15:53:23', 4),
(57, 15, 4, 'Equipment is clean and free from damage', 'fail', '', NULL, 1, '2025-09-15 15:53:49', 1),
(58, 15, 2, 'All safety devices are functioning properly', 'fail', '', NULL, 1, '2025-09-15 15:53:49', 2),
(59, 15, 4, 'Operating parameters are within specified ranges', 'pass', '', NULL, 1, '2025-09-15 15:53:49', 3),
(60, 15, 1, 'Log books are properly maintained', 'pass', '', NULL, 1, '2025-09-15 15:53:49', 4),
(61, 16, 4, 'Equipment is clean and free from damage', 'pending', NULL, NULL, NULL, NULL, 1),
(62, 16, 2, 'All safety devices are functioning properly', 'pending', NULL, NULL, NULL, NULL, 2),
(63, 16, 4, 'Operating parameters are within specified ranges', 'pending', NULL, NULL, NULL, NULL, 3),
(64, 16, 1, 'Log books are properly maintained', 'pending', NULL, NULL, NULL, NULL, 4),
(65, 17, 4, 'Equipment is clean and free from damage', 'pending', NULL, NULL, NULL, NULL, 1),
(66, 17, 2, 'All safety devices are functioning properly', 'pending', NULL, NULL, NULL, NULL, 2),
(67, 17, 4, 'Operating parameters are within specified ranges', 'pending', NULL, NULL, NULL, NULL, 3),
(68, 17, 1, 'Log books are properly maintained', 'pending', NULL, NULL, NULL, NULL, 4),
(69, 18, 4, 'Calibration standards are traceable', 'pending', NULL, NULL, NULL, NULL, 1),
(70, 18, 4, 'Equipment accuracy is within tolerance', 'pending', NULL, NULL, NULL, NULL, 2),
(71, 18, 4, 'Calibration certificate issued', 'pending', NULL, NULL, NULL, NULL, 3),
(72, 18, 1, 'Next calibration date scheduled', 'pending', NULL, NULL, NULL, NULL, 4),
(73, 19, 4, 'Equipment is clean and free from damage', 'pending', NULL, NULL, NULL, NULL, 1),
(74, 19, 2, 'All safety devices are functioning properly', 'pending', NULL, NULL, NULL, NULL, 2),
(75, 19, 4, 'Operating parameters are within specified ranges', 'pending', NULL, NULL, NULL, NULL, 3),
(76, 19, 1, 'Log books are properly maintained', 'pending', NULL, NULL, NULL, NULL, 4),
(77, 20, 4, 'Equipment is clean and free from damage', 'pending', NULL, NULL, NULL, NULL, 1),
(78, 20, 2, 'All safety devices are functioning properly', 'pending', NULL, NULL, NULL, NULL, 2),
(79, 20, 4, 'Operating parameters are within specified ranges', 'pending', NULL, NULL, NULL, NULL, 3),
(80, 20, 1, 'Log books are properly maintained', 'pending', NULL, NULL, NULL, NULL, 4),
(81, 21, 4, 'Equipment is clean and free from damage', 'pending', NULL, NULL, NULL, NULL, 1),
(82, 21, 2, 'All safety devices are functioning properly', 'pending', NULL, NULL, NULL, NULL, 2),
(83, 21, 4, 'Operating parameters are within specified ranges', 'pending', NULL, NULL, NULL, NULL, 3),
(84, 21, 1, 'Log books are properly maintained', 'pending', NULL, NULL, NULL, NULL, 4),
(85, 22, 4, 'Equipment is clean and free from damage', 'pending', NULL, NULL, NULL, NULL, 1),
(86, 22, 2, 'All safety devices are functioning properly', 'pending', NULL, NULL, NULL, NULL, 2),
(87, 22, 4, 'Operating parameters are within specified ranges', 'pending', NULL, NULL, NULL, NULL, 3),
(88, 22, 1, 'Log books are properly maintained', 'pending', NULL, NULL, NULL, NULL, 4),
(89, 23, 4, 'Equipment is clean and free from damage', 'pending', NULL, NULL, NULL, NULL, 1),
(90, 23, 2, 'All safety devices are functioning properly', 'pending', NULL, NULL, NULL, NULL, 2),
(91, 23, 4, 'Operating parameters are within specified ranges', 'pending', NULL, NULL, NULL, NULL, 3),
(92, 23, 1, 'Log books are properly maintained', 'pending', NULL, NULL, NULL, NULL, 4),
(93, 24, 4, 'Equipment is clean and free from damage', 'pending', NULL, NULL, NULL, NULL, 1),
(94, 24, 2, 'All safety devices are functioning properly', 'pending', NULL, NULL, NULL, NULL, 2),
(95, 24, 4, 'Operating parameters are within specified ranges', 'pending', NULL, NULL, NULL, NULL, 3),
(96, 24, 1, 'Log books are properly maintained', 'pending', NULL, NULL, NULL, NULL, 4),
(97, 25, 4, 'Equipment is clean and free from damage', 'pending', NULL, NULL, NULL, NULL, 1),
(98, 25, 2, 'All safety devices are functioning properly', 'pending', NULL, NULL, NULL, NULL, 2),
(99, 25, 4, 'Operating parameters are within specified ranges', 'pending', NULL, NULL, NULL, NULL, 3),
(100, 25, 1, 'Log books are properly maintained', 'pending', NULL, NULL, NULL, NULL, 4),
(101, 26, 4, 'Calibration standards are traceable', 'pending', NULL, NULL, NULL, NULL, 1),
(102, 26, 4, 'Equipment accuracy is within tolerance', 'pending', NULL, NULL, NULL, NULL, 2),
(103, 26, 4, 'Calibration certificate issued', 'pending', NULL, NULL, NULL, NULL, 3),
(104, 26, 1, 'Next calibration date scheduled', 'pending', NULL, NULL, NULL, NULL, 4),
(105, 27, 4, 'Equipment is clean and free from damage', 'pending', '', NULL, 1, '2025-09-16 07:22:41', 1),
(106, 27, 2, 'All safety devices are functioning properly', 'pending', '', NULL, 1, '2025-09-16 07:22:41', 2),
(107, 27, 4, 'Operating parameters are within specified ranges', 'pending', '', NULL, 1, '2025-09-16 07:22:41', 3),
(108, 27, 1, 'Log books are properly maintained', 'pending', '', NULL, 1, '2025-09-16 07:22:41', 4),
(109, 28, 4, 'Equipment is clean and free from damage', 'pending', NULL, NULL, NULL, NULL, 1),
(110, 28, 2, 'All safety devices are functioning properly', 'pending', NULL, NULL, NULL, NULL, 2),
(111, 28, 4, 'Operating parameters are within specified ranges', 'pending', NULL, NULL, NULL, NULL, 3),
(112, 28, 1, 'Log books are properly maintained', 'pending', NULL, NULL, NULL, NULL, 4),
(113, 29, 4, 'Equipment is clean and free from damage', 'pending', NULL, NULL, NULL, NULL, 1),
(114, 29, 2, 'All safety devices are functioning properly', 'pending', NULL, NULL, NULL, NULL, 2),
(115, 29, 4, 'Operating parameters are within specified ranges', 'pending', NULL, NULL, NULL, NULL, 3),
(116, 29, 1, 'Log books are properly maintained', 'pending', NULL, NULL, NULL, NULL, 4),
(117, 30, 4, 'Equipment is clean and free from damage', 'pending', NULL, NULL, NULL, NULL, 1),
(118, 30, 2, 'All safety devices are functioning properly', 'pending', NULL, NULL, NULL, NULL, 2),
(119, 30, 4, 'Operating parameters are within specified ranges', 'pending', NULL, NULL, NULL, NULL, 3),
(120, 30, 1, 'Log books are properly maintained', 'pending', NULL, NULL, NULL, NULL, 4),
(121, 31, 4, 'Equipment is clean and free from damage', 'pending', '', NULL, 1, '2025-09-16 08:19:23', 1),
(122, 31, 2, 'All safety devices are functioning properly', 'pending', '', NULL, 1, '2025-09-16 08:19:23', 2),
(123, 31, 4, 'Operating parameters are within specified ranges', 'pending', '', NULL, 1, '2025-09-16 08:19:23', 3),
(124, 31, 1, 'Log books are properly maintained', 'pending', '', NULL, 1, '2025-09-16 08:19:23', 4),
(125, 32, 4, 'Equipment is clean and free from damage', 'pending', NULL, NULL, NULL, NULL, 1),
(126, 32, 2, 'All safety devices are functioning properly', 'pending', NULL, NULL, NULL, NULL, 2),
(127, 32, 4, 'Operating parameters are within specified ranges', 'pending', NULL, NULL, NULL, NULL, 3),
(128, 32, 1, 'Log books are properly maintained', 'pending', NULL, NULL, NULL, NULL, 4),
(129, 33, 4, 'Equipment is clean and free from damage', 'pending', NULL, NULL, NULL, NULL, 1),
(130, 33, 2, 'All safety devices are functioning properly', 'pending', NULL, NULL, NULL, NULL, 2),
(131, 33, 4, 'Operating parameters are within specified ranges', 'pending', NULL, NULL, NULL, NULL, 3),
(132, 33, 1, 'Log books are properly maintained', 'pending', NULL, NULL, NULL, NULL, 4),
(133, 34, 4, 'Equipment is clean and free from damage', 'pending', '', 'uploads/upload_68cb99137cc4a7.04289213.docx', 1, '2025-09-18 05:31:11', 1),
(134, 34, 2, 'All safety devices are functioning properly', 'pending', '', NULL, 1, '2025-09-18 05:31:11', 2),
(135, 34, 4, 'Operating parameters are within specified ranges', 'pending', '', NULL, 1, '2025-09-18 05:31:11', 3),
(136, 34, 1, 'Log books are properly maintained', 'pending', '', NULL, 1, '2025-09-18 05:31:11', 4),
(137, 35, 4, 'Equipment is clean and free from damage', 'pending', NULL, NULL, NULL, NULL, 1),
(138, 35, 2, 'All safety devices are functioning properly', 'pending', NULL, NULL, NULL, NULL, 2),
(139, 35, 4, 'Operating parameters are within specified ranges', 'pending', NULL, NULL, NULL, NULL, 3),
(140, 35, 1, 'Log books are properly maintained', 'pending', NULL, NULL, NULL, NULL, 4);

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `head_user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `name`, `description`, `head_user_id`, `created_at`) VALUES
(1, 'Maintenance', 'Hospital maintenance department responsible for equipment upkeep', NULL, '2025-09-13 11:56:08'),
(2, 'Radiology', 'Medical imaging and diagnostic equipment', NULL, '2025-09-13 11:56:08'),
(3, 'Laboratory', 'Clinical laboratory and testing equipment', NULL, '2025-09-13 11:56:08'),
(4, 'ICU', 'Intensive Care Unit equipment and monitoring', NULL, '2025-09-13 11:56:08'),
(5, 'OT', 'Operation Theatre equipment and systems', NULL, '2025-09-13 11:56:08'),
(6, 'Pharmacy', 'Pharmaceutical storage and dispensing equipment', NULL, '2025-09-13 11:56:08'),
(7, 'IT', 'Information technology (IT) To manage all the Data.', 1, '2025-09-13 11:56:08');

-- --------------------------------------------------------

--
-- Table structure for table `document_types`
--

CREATE TABLE `document_types` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `requires_signature` tinyint(1) NOT NULL DEFAULT 1,
  `validity_days` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `document_types`
--

INSERT INTO `document_types` (`id`, `name`, `description`, `requires_signature`, `validity_days`, `created_at`) VALUES
(1, 'Daily Checklist', 'Daily equipment inspection and verification', 1, 1, '2025-09-13 11:56:08'),
(2, 'Preventive Maintenance', 'Scheduled maintenance activities', 1, 30, '2025-09-13 11:56:08'),
(3, 'Calibration', 'Equipment calibration and verification', 1, 365, '2025-09-13 11:56:08'),
(4, 'Breakdown Maintenance', 'Corrective maintenance for equipment failures', 1, NULL, '2025-09-13 11:56:08');

-- --------------------------------------------------------

--
-- Table structure for table `maintenance_schedules`
--

CREATE TABLE `maintenance_schedules` (
  `id` int(11) NOT NULL,
  `asset_id` int(11) NOT NULL,
  `document_type_id` int(11) NOT NULL,
  `frequency` enum('daily','weekly','monthly','quarterly','yearly') NOT NULL,
  `frequency_value` int(11) NOT NULL DEFAULT 1,
  `next_due` date NOT NULL,
  `last_done` date DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ncrs`
--

CREATE TABLE `ncrs` (
  `id` int(11) NOT NULL,
  `ncr_number` varchar(50) NOT NULL,
  `checklist_item_id` int(11) DEFAULT NULL,
  `asset_id` int(11) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `description` text NOT NULL,
  `root_cause` text DEFAULT NULL,
  `corrective_action` text DEFAULT NULL,
  `preventive_action` text DEFAULT NULL,
  `raised_by` int(11) NOT NULL,
  `assigned_to` int(11) DEFAULT NULL,
  `status` enum('open','in_progress','completed','verified','closed') NOT NULL DEFAULT 'open',
  `severity` enum('low','medium','high','critical') NOT NULL DEFAULT 'medium',
  `due_date` date DEFAULT NULL,
  `completed_date` date DEFAULT NULL,
  `evidence` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ncrs`
--

INSERT INTO `ncrs` (`id`, `ncr_number`, `checklist_item_id`, `asset_id`, `department_id`, `description`, `root_cause`, `corrective_action`, `preventive_action`, `raised_by`, `assigned_to`, `status`, `severity`, `due_date`, `completed_date`, `evidence`, `created_at`, `updated_at`) VALUES
(1, 'NCR-2025-0001', 2, 1, 1, 'Non-compliance identified during checklist: All safety devices are functioning properly. Details: ', NULL, NULL, NULL, 1, NULL, 'open', 'medium', '2025-09-20', NULL, NULL, '2025-09-13 13:28:05', '2025-09-13 13:28:05'),
(2, 'NCR-2025-0002', 10, 1, 1, 'Non-compliance identified during checklist: All safety devices are functioning properly. Details: ', NULL, NULL, NULL, 1, NULL, 'open', 'medium', '2025-09-22', NULL, NULL, '2025-09-15 04:56:16', '2025-09-15 04:56:16');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `type` varchar(50) NOT NULL,
  `title` varchar(200) NOT NULL,
  `message` text DEFAULT NULL,
  `entity_type` varchar(50) DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `standards`
--

CREATE TABLE `standards` (
  `id` int(11) NOT NULL,
  `source` enum('NABH','JCI') NOT NULL,
  `clause_id` varchar(50) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `standards`
--

INSERT INTO `standards` (`id`, `source`, `clause_id`, `title`, `description`, `category`, `created_at`) VALUES
(1, 'NABH', 'FMS.1', 'Facility Management and Safety Program', 'The organization establishes and implements a program to provide a safe, functional, supportive, and effective environment for patients, families, staff, and visitors.', 'Facility Management', '2025-09-13 11:56:08'),
(2, 'NABH', 'FMS.2', 'Safety and Security Plan', 'The organization plans and implements a program to provide security for persons and protection of property from loss or damage.', 'Safety', '2025-09-13 11:56:08'),
(3, 'NABH', 'FMS.3', 'Fire Safety Program', 'The organization establishes and implements a fire safety program to protect individuals and property from fire and smoke.', 'Fire Safety', '2025-09-13 11:56:08'),
(4, 'NABH', 'FMS.4', 'Medical Equipment Management', 'The organization establishes and implements a program for inspection, testing, and maintenance of medical equipment.', 'Equipment Management', '2025-09-13 11:56:08'),
(5, 'NABH', 'FMS.5', 'Utility Systems Management', 'The organization establishes and implements a program for inspection, testing, and maintenance of utility systems.', 'Utilities', '2025-09-13 11:56:08'),
(6, 'JCI', 'FMS.01.01.01', 'Leadership Oversight', 'Hospital leaders establish oversight for the facility management and safety program.', 'Leadership', '2025-09-13 11:56:08'),
(7, 'JCI', 'FMS.02.01.01', 'Safety Management Plan', 'The hospital has a safety management plan that addresses safety and security risks throughout the hospital.', 'Safety Management', '2025-09-13 11:56:08'),
(8, 'JCI', 'FMS.03.01.01', 'Fire Safety Plan', 'The hospital has a fire safety plan that addresses fire prevention, early detection, suppression, and safe evacuation.', 'Fire Safety', '2025-09-13 11:56:08'),
(9, 'JCI', 'FMS.04.01.01', 'Equipment Management Program', 'There is an equipment management program throughout the hospital.', 'Equipment', '2025-09-13 11:56:08'),
(10, 'JCI', 'FMS.05.01.01', 'Utility Systems Program', 'There is a utility systems management program throughout the hospital.', 'Utilities', '2025-09-13 11:56:08');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('superadmin','admin','auditor','dept_manager','technician','viewer') NOT NULL DEFAULT 'viewer',
  `department_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password_hash`, `role`, `department_id`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'System Administrator', 'admin@quailtymed.com', '$2y$10$130qM8gExcMLOp.1juN5WOhZC6oB2d3AVxFSvczdcUShen/LfNz82', 'superadmin', 1, 1, '2025-09-13 11:56:08', '2025-09-15 07:03:00'),
(2, 'Harsh Kumar', 'biomed@quailtymed.com', '$2y$10$gliNZINyySVH6MGfTFYaqO5kP0iTWXn.RinWckAFAF5/nkSdr60Hq', 'technician', 1, 1, '2025-09-13 11:56:08', '2025-09-13 13:27:14'),
(3, 'Mayukh Mondal', 'it@quailtymed.com', '$2y$10$VM.SRRgbzAXil5kL7wFcD.00U8smIDExv/y4g01U9bjb8SU0.Ov/6', 'superadmin', 7, 1, '2025-09-13 11:56:08', '2025-09-15 07:00:32');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assets`
--
ALTER TABLE `assets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `asset_tag` (`asset_tag`),
  ADD UNIQUE KEY `idx_asset_tag` (`asset_tag`),
  ADD KEY `idx_assets_type` (`asset_type_id`),
  ADD KEY `idx_assets_calibration` (`next_calibration_date`),
  ADD KEY `idx_assets_status` (`status`);

--
-- Indexes for table `asset_types`
--
ALTER TABLE `asset_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_asset_types_dept` (`department_id`),
  ADD KEY `idx_asset_types_name` (`name`);

--
-- Indexes for table `attachments`
--
ALTER TABLE `attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_attachments_entity` (`entity_type`,`entity_id`),
  ADD KEY `idx_attachments_uploaded_by` (`uploaded_by`);

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_audit_user` (`user_id`),
  ADD KEY `idx_audit_action` (`action`),
  ADD KEY `idx_audit_entity` (`entity_type`,`entity_id`),
  ADD KEY `idx_audit_created` (`created_at`);

--
-- Indexes for table `checklists`
--
ALTER TABLE `checklists`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_checklists_asset` (`asset_id`),
  ADD KEY `idx_checklists_doc_type` (`document_type_id`),
  ADD KEY `idx_checklists_status` (`status`),
  ADD KEY `idx_checklists_due_date` (`due_date`),
  ADD KEY `idx_checklists_created_by` (`created_by`),
  ADD KEY `fk_checklists_assigned_to` (`assigned_to`),
  ADD KEY `fk_checklists_signed_off_by` (`signed_off_by`);

--
-- Indexes for table `checklist_items`
--
ALTER TABLE `checklist_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_checklist_items_checklist` (`checklist_id`),
  ADD KEY `idx_checklist_items_standard` (`standard_id`),
  ADD KEY `idx_checklist_items_result` (`result`),
  ADD KEY `idx_checklist_items_order` (`order_index`),
  ADD KEY `fk_checklist_items_checked_by` (`checked_by`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_dept_name` (`name`),
  ADD KEY `idx_dept_head` (`head_user_id`);

--
-- Indexes for table `document_types`
--
ALTER TABLE `document_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_doc_types_name` (`name`);

--
-- Indexes for table `maintenance_schedules`
--
ALTER TABLE `maintenance_schedules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_maintenance_asset` (`asset_id`),
  ADD KEY `idx_maintenance_next_due` (`next_due`),
  ADD KEY `idx_maintenance_active` (`is_active`),
  ADD KEY `fk_maintenance_document_type` (`document_type_id`);

--
-- Indexes for table `ncrs`
--
ALTER TABLE `ncrs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ncr_number` (`ncr_number`),
  ADD UNIQUE KEY `idx_ncr_number` (`ncr_number`),
  ADD KEY `idx_ncrs_checklist_item` (`checklist_item_id`),
  ADD KEY `idx_ncrs_asset` (`asset_id`),
  ADD KEY `idx_ncrs_status` (`status`),
  ADD KEY `idx_ncrs_severity` (`severity`),
  ADD KEY `idx_ncrs_due_date` (`due_date`),
  ADD KEY `fk_ncrs_department` (`department_id`),
  ADD KEY `fk_ncrs_raised_by` (`raised_by`),
  ADD KEY `fk_ncrs_assigned_to` (`assigned_to`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_notifications_user` (`user_id`),
  ADD KEY `idx_notifications_type` (`type`),
  ADD KEY `idx_notifications_read` (`is_read`);

--
-- Indexes for table `standards`
--
ALTER TABLE `standards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_standards_source` (`source`),
  ADD KEY `idx_standards_clause` (`clause_id`),
  ADD KEY `idx_standards_category` (`category`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_users_email` (`email`),
  ADD KEY `idx_users_role` (`role`),
  ADD KEY `idx_users_department` (`department_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assets`
--
ALTER TABLE `assets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `asset_types`
--
ALTER TABLE `asset_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `attachments`
--
ALTER TABLE `attachments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `checklists`
--
ALTER TABLE `checklists`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `checklist_items`
--
ALTER TABLE `checklist_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=141;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `document_types`
--
ALTER TABLE `document_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `maintenance_schedules`
--
ALTER TABLE `maintenance_schedules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ncrs`
--
ALTER TABLE `ncrs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `standards`
--
ALTER TABLE `standards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assets`
--
ALTER TABLE `assets`
  ADD CONSTRAINT `fk_assets_asset_type` FOREIGN KEY (`asset_type_id`) REFERENCES `asset_types` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `asset_types`
--
ALTER TABLE `asset_types`
  ADD CONSTRAINT `fk_asset_types_department` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `attachments`
--
ALTER TABLE `attachments`
  ADD CONSTRAINT `fk_attachments_uploaded_by` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `fk_audit_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `checklists`
--
ALTER TABLE `checklists`
  ADD CONSTRAINT `fk_checklists_asset` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_checklists_assigned_to` FOREIGN KEY (`assigned_to`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_checklists_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_checklists_document_type` FOREIGN KEY (`document_type_id`) REFERENCES `document_types` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_checklists_signed_off_by` FOREIGN KEY (`signed_off_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `checklist_items`
--
ALTER TABLE `checklist_items`
  ADD CONSTRAINT `fk_checklist_items_checked_by` FOREIGN KEY (`checked_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_checklist_items_checklist` FOREIGN KEY (`checklist_id`) REFERENCES `checklists` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_checklist_items_standard` FOREIGN KEY (`standard_id`) REFERENCES `standards` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `departments`
--
ALTER TABLE `departments`
  ADD CONSTRAINT `fk_departments_head` FOREIGN KEY (`head_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `maintenance_schedules`
--
ALTER TABLE `maintenance_schedules`
  ADD CONSTRAINT `fk_maintenance_asset` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_maintenance_document_type` FOREIGN KEY (`document_type_id`) REFERENCES `document_types` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ncrs`
--
ALTER TABLE `ncrs`
  ADD CONSTRAINT `fk_ncrs_asset` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_ncrs_assigned_to` FOREIGN KEY (`assigned_to`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_ncrs_checklist_item` FOREIGN KEY (`checklist_item_id`) REFERENCES `checklist_items` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_ncrs_department` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_ncrs_raised_by` FOREIGN KEY (`raised_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `fk_notifications_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_department` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

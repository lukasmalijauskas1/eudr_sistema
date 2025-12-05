-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 05, 2025 at 01:41 PM
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
-- Database: `eudr_sistema`
--

-- --------------------------------------------------------

--
-- Table structure for table `ataskaita`
--

CREATE TABLE `ataskaita` (
  `ID` int(11) NOT NULL,
  `SukurimoData` datetime NOT NULL,
  `PDFNuoroda` varchar(255) NOT NULL,
  `ProduktasID` int(11) NOT NULL,
  `VartotojasID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ataskaita`
--

INSERT INTO `ataskaita` (`ID`, `SukurimoData`, `PDFNuoroda`, `ProduktasID`, `VartotojasID`) VALUES
(1, '2025-11-23 01:02:21', 'ataskaitos/ataskaita_1763852541_11.pdf', 11, 2),
(2, '2025-11-23 01:02:26', 'ataskaitos/ataskaita_1763852546_12.pdf', 12, 2),
(3, '2025-11-23 01:02:31', 'ataskaitos/ataskaita_1763852551_13.pdf', 13, 2),
(4, '2025-11-23 01:02:54', 'ataskaitos/ataskaita_1763852574_11.pdf', 11, 2),
(5, '2025-11-23 01:02:58', 'ataskaitos/ataskaita_1763852578_11.pdf', 11, 2),
(6, '2025-11-23 01:03:01', 'ataskaitos/ataskaita_1763852580_11.pdf', 11, 2),
(7, '2025-11-23 01:03:03', 'ataskaitos/ataskaita_1763852583_11.pdf', 11, 2),
(8, '2025-11-23 01:04:15', 'ataskaitos/ataskaita_1763852655_26.pdf', 26, 2),
(9, '2025-11-23 01:04:20', 'ataskaitos/ataskaita_1763852660_13.pdf', 13, 2),
(12, '2025-11-23 01:24:52', 'ataskaitos/ataskaita_1763853892_37.pdf', 37, 2),
(13, '2025-11-23 01:24:56', 'ataskaitos/ataskaita_1763853896_26.pdf', 26, 2),
(14, '2025-11-23 01:25:03', 'ataskaitos/ataskaita_1763853903_52.pdf', 52, 2),
(15, '2025-11-23 01:25:07', 'ataskaitos/ataskaita_1763853907_39.pdf', 39, 2),
(16, '2025-11-23 01:25:45', 'ataskaitos/ataskaita_1763853945_51.pdf', 51, 2),
(17, '2025-11-23 01:25:52', 'ataskaitos/ataskaita_1763853952_38.pdf', 38, 2),
(18, '2025-11-23 01:28:00', 'ataskaitos/ataskaita_1763854080_11.pdf', 11, 2),
(19, '2025-11-23 01:30:07', 'ataskaitos/ataskaita_1763854207_12.pdf', 12, 2),
(20, '2025-11-23 01:30:11', 'ataskaitos/ataskaita_1763854211_13.pdf', 13, 2),
(21, '2025-11-23 01:34:42', 'ataskaitos/ataskaita_1763854482_13.pdf', 13, 2),
(22, '2025-11-23 01:35:51', 'ataskaitos/ataskaita_1763854551_26.pdf', 26, 2),
(23, '2025-11-23 01:35:58', 'ataskaitos/ataskaita_1763854558_13.pdf', 13, 2),
(24, '2025-11-23 01:36:02', 'ataskaitos/ataskaita_1763854562_12.pdf', 12, 2),
(25, '2025-11-23 01:36:12', 'ataskaitos/ataskaita_1763854572_13.pdf', 13, 2),
(26, '2025-11-23 01:36:16', 'ataskaitos/ataskaita_1763854576_11.pdf', 11, 2),
(27, '2025-12-01 16:24:20', 'ataskaitos/ataskaita_1764599059_96.pdf', 96, 2),
(28, '2025-12-01 16:24:25', 'ataskaitos/ataskaita_1764599064_98.pdf', 98, 2),
(29, '2025-12-01 16:24:28', 'ataskaitos/ataskaita_1764599068_96.pdf', 96, 2),
(30, '2025-12-01 16:24:34', 'ataskaitos/ataskaita_1764599074_86.pdf', 86, 2),
(31, '2025-12-01 16:24:37', 'ataskaitos/ataskaita_1764599077_9.pdf', 9, 2),
(32, '2025-12-01 16:24:41', 'ataskaitos/ataskaita_1764599081_22.pdf', 22, 2),
(33, '2025-12-01 16:24:46', 'ataskaitos/ataskaita_1764599086_24.pdf', 24, 2),
(34, '2025-12-01 16:25:00', 'ataskaitos/ataskaita_1764599100_38.pdf', 38, 2),
(35, '2025-12-01 16:25:05', 'ataskaitos/ataskaita_1764599105_99.pdf', 99, 2),
(36, '2025-12-01 16:25:11', 'ataskaitos/ataskaita_1764599111_91.pdf', 91, 2),
(37, '2025-12-01 16:25:18', 'ataskaitos/ataskaita_1764599118_87.pdf', 87, 2),
(38, '2025-12-01 16:25:29', 'ataskaitos/ataskaita_1764599129_78.pdf', 78, 2),
(39, '2025-12-01 16:25:37', 'ataskaitos/ataskaita_1764599137_51.pdf', 51, 2),
(40, '2025-12-01 16:25:47', 'ataskaitos/ataskaita_1764599147_16.pdf', 16, 2),
(41, '2025-12-01 16:25:49', 'ataskaitos/ataskaita_1764599149_3.pdf', 3, 2),
(42, '2025-12-01 16:25:52', 'ataskaitos/ataskaita_1764599152_12.pdf', 12, 2),
(43, '2025-12-01 16:47:00', 'ataskaitos/ataskaita_1764600420_16.pdf', 16, 2),
(44, '2025-12-01 16:47:04', 'ataskaitos/ataskaita_1764600424_16.pdf', 16, 2),
(45, '2025-12-01 16:47:09', 'ataskaitos/ataskaita_1764600429_25.pdf', 25, 2),
(46, '2025-12-01 16:47:12', 'ataskaitos/ataskaita_1764600432_12.pdf', 12, 2);

-- --------------------------------------------------------

--
-- Table structure for table `atitiktiespatikra`
--

CREATE TABLE `atitiktiespatikra` (
  `ID` int(11) NOT NULL,
  `Statusas` enum('Atitinka','Neatitinka','Nežinoma') NOT NULL,
  `Data` date NOT NULL,
  `Komentarai` text DEFAULT NULL,
  `ProduktasID` int(11) NOT NULL,
  `VartotojasID` int(11) NOT NULL,
  `AB` decimal(5,2) NOT NULL,
  `Breakdown` text DEFAULT NULL,
  `ModelVersion` varchar(20) DEFAULT NULL,
  `ModelConfig` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `atitiktiespatikra`
--

INSERT INTO `atitiktiespatikra` (`ID`, `Statusas`, `Data`, `Komentarai`, `ProduktasID`, `VartotojasID`, `AB`, `Breakdown`, `ModelVersion`, `ModelConfig`) VALUES
(1, 'Neatitinka', '2025-11-23', 'Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo', 11, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: Legality documents\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"OK\",\"contrib\":0}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(2, 'Nežinoma', '2025-11-23', 'Reikalinga papildoma informacija / rizikos mažinimas (11 str.).', 12, 2, 49.33, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: Legality documents\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: Complete documentation\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"Evidence: DocsComplete\",\"value\":1,\"weight\":0.3,\"contrib\":0.3},{\"rule\":\"Evidence: Geolocation\",\"value\":1,\"weight\":0.2,\"contrib\":0.2},{\"rule\":\"Evidence: SupplierDeclaration\",\"value\":1,\"weight\":0.1,\"contrib\":0.1},{\"rule\":\"Evidence: Certifications\",\"value\":0.4,\"weight\":0.15,\"contrib\":0.06},{\"rule\":\"Evidence: TraceabilityDepth\",\"value\":0.3333333333333333,\"weight\":0.1,\"contrib\":0.03333333333333333},{\"rule\":\"Evidence: ExternalVerification\",\"value\":0,\"weight\":0.15,\"contrib\":0},{\"rule\":\"Penalty: IndigenousClaims\",\"value\":0,\"contrib\":0},{\"rule\":\"Penalty: SanctionsRisk\",\"value\":0,\"contrib\":0},{\"rule\":\"Penalty: SupplyChainComplexity\",\"value\":\"med\",\"contrib\":-5},{\"rule\":\"Penalty: MixingRisk\",\"value\":\"med\",\"contrib\":-5},{\"rule\":\"Penalty: DocReliability\",\"value\":\"med\",\"contrib\":-5},{\"rule\":\"Penalty: LocalEnforcement\",\"value\":\"med\",\"contrib\":-5}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(3, 'Atitinka', '2025-11-23', 'Due-diligence pakankamas.', 13, 2, 100.00, '[{\"rule\":\"GATE: Polygon for >4 ha\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: Legality documents\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: Complete documentation\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"Evidence: DocsComplete\",\"value\":1,\"weight\":0.3,\"contrib\":0.3},{\"rule\":\"Evidence: Geolocation\",\"value\":1,\"weight\":0.2,\"contrib\":0.2},{\"rule\":\"Evidence: SupplierDeclaration\",\"value\":1,\"weight\":0.1,\"contrib\":0.1},{\"rule\":\"Evidence: Certifications\",\"value\":1,\"weight\":0.15,\"contrib\":0.15},{\"rule\":\"Evidence: TraceabilityDepth\",\"value\":1,\"weight\":0.1,\"contrib\":0.1},{\"rule\":\"Evidence: ExternalVerification\",\"value\":1,\"weight\":0.15,\"contrib\":0.15},{\"rule\":\"Penalty: IndigenousClaims\",\"value\":0,\"contrib\":0},{\"rule\":\"Penalty: SanctionsRisk\",\"value\":0,\"contrib\":0},{\"rule\":\"Penalty: SupplyChainComplexity\",\"value\":\"low\",\"contrib\":0},{\"rule\":\"Penalty: MixingRisk\",\"value\":\"low\",\"contrib\":0},{\"rule\":\"Penalty: DocReliability\",\"value\":\"high\",\"contrib\":0},{\"rule\":\"Penalty: LocalEnforcement\",\"value\":\"high\",\"contrib\":0}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(4, 'Neatitinka', '2025-11-23', 'Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo', 11, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: Legality documents\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"OK\",\"contrib\":0}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(5, 'Neatitinka', '2025-11-23', 'Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo', 11, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: Legality documents\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"OK\",\"contrib\":0}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(6, 'Neatitinka', '2025-11-23', 'Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo', 11, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: Legality documents\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"OK\",\"contrib\":0}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(7, 'Neatitinka', '2025-11-23', 'Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo', 11, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: Legality documents\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"OK\",\"contrib\":0}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(8, 'Neatitinka', '2025-11-23', '≤4 ha be platumos/ilgumos; Trūksta teisėtumo dokumentų; Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo; Dokumentų paketas nepilnas', 26, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Legality documents\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"FAIL\",\"contrib\":1}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(9, 'Atitinka', '2025-11-23', 'Due-diligence pakankamas.', 13, 2, 100.00, '[{\"rule\":\"GATE: Polygon for >4 ha\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: Legality documents\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: Complete documentation\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"Evidence: DocsComplete\",\"value\":1,\"weight\":0.3,\"contrib\":0.3},{\"rule\":\"Evidence: Geolocation\",\"value\":1,\"weight\":0.2,\"contrib\":0.2},{\"rule\":\"Evidence: SupplierDeclaration\",\"value\":1,\"weight\":0.1,\"contrib\":0.1},{\"rule\":\"Evidence: Certifications\",\"value\":1,\"weight\":0.15,\"contrib\":0.15},{\"rule\":\"Evidence: TraceabilityDepth\",\"value\":1,\"weight\":0.1,\"contrib\":0.1},{\"rule\":\"Evidence: ExternalVerification\",\"value\":1,\"weight\":0.15,\"contrib\":0.15},{\"rule\":\"Penalty: IndigenousClaims\",\"value\":0,\"contrib\":0},{\"rule\":\"Penalty: SanctionsRisk\",\"value\":0,\"contrib\":0},{\"rule\":\"Penalty: SupplyChainComplexity\",\"value\":\"low\",\"contrib\":0},{\"rule\":\"Penalty: MixingRisk\",\"value\":\"low\",\"contrib\":0},{\"rule\":\"Penalty: DocReliability\",\"value\":\"high\",\"contrib\":0},{\"rule\":\"Penalty: LocalEnforcement\",\"value\":\"high\",\"contrib\":0}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(12, 'Neatitinka', '2025-11-23', '≤4 ha be platumos/ilgumos; Trūksta teisėtumo dokumentų; Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo; Dokumentų paketas nepilnas', 37, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Legality documents\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"FAIL\",\"contrib\":1}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(13, 'Neatitinka', '2025-11-23', '≤4 ha be platumos/ilgumos; Trūksta teisėtumo dokumentų; Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo; Dokumentų paketas nepilnas', 26, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Legality documents\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"FAIL\",\"contrib\":1}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(14, 'Neatitinka', '2025-11-23', '≤4 ha be platumos/ilgumos; Trūksta teisėtumo dokumentų; Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo; Dokumentų paketas nepilnas', 52, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Legality documents\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"FAIL\",\"contrib\":1}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(15, 'Neatitinka', '2025-11-23', '≤4 ha be platumos/ilgumos; Trūksta teisėtumo dokumentų; Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo; Dokumentų paketas nepilnas', 39, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Legality documents\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"FAIL\",\"contrib\":1}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(16, 'Neatitinka', '2025-11-23', '≤4 ha be platumos/ilgumos; Trūksta teisėtumo dokumentų; Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo; Dokumentų paketas nepilnas', 51, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Legality documents\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"FAIL\",\"contrib\":1}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(17, 'Neatitinka', '2025-11-23', '≤4 ha be platumos/ilgumos; Trūksta teisėtumo dokumentų; Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo; Dokumentų paketas nepilnas', 38, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Legality documents\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"FAIL\",\"contrib\":1}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(18, 'Neatitinka', '2025-11-23', 'Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo', 11, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: Legality documents\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"OK\",\"contrib\":0}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(19, 'Nežinoma', '2025-11-23', 'Reikalinga papildoma informacija / rizikos mažinimas (11 str.).', 12, 2, 49.33, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: Legality documents\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: Complete documentation\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"Evidence: DocsComplete\",\"value\":1,\"weight\":0.3,\"contrib\":0.3},{\"rule\":\"Evidence: Geolocation\",\"value\":1,\"weight\":0.2,\"contrib\":0.2},{\"rule\":\"Evidence: SupplierDeclaration\",\"value\":1,\"weight\":0.1,\"contrib\":0.1},{\"rule\":\"Evidence: Certifications\",\"value\":0.4,\"weight\":0.15,\"contrib\":0.06},{\"rule\":\"Evidence: TraceabilityDepth\",\"value\":0.3333333333333333,\"weight\":0.1,\"contrib\":0.03333333333333333},{\"rule\":\"Evidence: ExternalVerification\",\"value\":0,\"weight\":0.15,\"contrib\":0},{\"rule\":\"Penalty: IndigenousClaims\",\"value\":0,\"contrib\":0},{\"rule\":\"Penalty: SanctionsRisk\",\"value\":0,\"contrib\":0},{\"rule\":\"Penalty: SupplyChainComplexity\",\"value\":\"med\",\"contrib\":-5},{\"rule\":\"Penalty: MixingRisk\",\"value\":\"med\",\"contrib\":-5},{\"rule\":\"Penalty: DocReliability\",\"value\":\"med\",\"contrib\":-5},{\"rule\":\"Penalty: LocalEnforcement\",\"value\":\"med\",\"contrib\":-5}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(20, 'Atitinka', '2025-11-23', 'Due-diligence pakankamas.', 13, 2, 100.00, '[{\"rule\":\"GATE: Polygon for >4 ha\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: Legality documents\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: Complete documentation\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"Evidence: DocsComplete\",\"value\":1,\"weight\":0.3,\"contrib\":0.3},{\"rule\":\"Evidence: Geolocation\",\"value\":1,\"weight\":0.2,\"contrib\":0.2},{\"rule\":\"Evidence: SupplierDeclaration\",\"value\":1,\"weight\":0.1,\"contrib\":0.1},{\"rule\":\"Evidence: Certifications\",\"value\":1,\"weight\":0.15,\"contrib\":0.15},{\"rule\":\"Evidence: TraceabilityDepth\",\"value\":1,\"weight\":0.1,\"contrib\":0.1},{\"rule\":\"Evidence: ExternalVerification\",\"value\":1,\"weight\":0.15,\"contrib\":0.15},{\"rule\":\"Penalty: IndigenousClaims\",\"value\":0,\"contrib\":0},{\"rule\":\"Penalty: SanctionsRisk\",\"value\":0,\"contrib\":0},{\"rule\":\"Penalty: SupplyChainComplexity\",\"value\":\"low\",\"contrib\":0},{\"rule\":\"Penalty: MixingRisk\",\"value\":\"low\",\"contrib\":0},{\"rule\":\"Penalty: DocReliability\",\"value\":\"high\",\"contrib\":0},{\"rule\":\"Penalty: LocalEnforcement\",\"value\":\"high\",\"contrib\":0}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(21, 'Atitinka', '2025-11-23', 'Due-diligence pakankamas.', 13, 2, 100.00, '[{\"rule\":\"GATE: Polygon for >4 ha\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: Legality documents\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: Complete documentation\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"Evidence: DocsComplete\",\"value\":1,\"weight\":0.3,\"contrib\":0.3},{\"rule\":\"Evidence: Geolocation\",\"value\":1,\"weight\":0.2,\"contrib\":0.2},{\"rule\":\"Evidence: SupplierDeclaration\",\"value\":1,\"weight\":0.1,\"contrib\":0.1},{\"rule\":\"Evidence: Certifications\",\"value\":1,\"weight\":0.15,\"contrib\":0.15},{\"rule\":\"Evidence: TraceabilityDepth\",\"value\":1,\"weight\":0.1,\"contrib\":0.1},{\"rule\":\"Evidence: ExternalVerification\",\"value\":1,\"weight\":0.15,\"contrib\":0.15},{\"rule\":\"Penalty: IndigenousClaims\",\"value\":0,\"contrib\":0},{\"rule\":\"Penalty: SanctionsRisk\",\"value\":0,\"contrib\":0},{\"rule\":\"Penalty: SupplyChainComplexity\",\"value\":\"low\",\"contrib\":0},{\"rule\":\"Penalty: MixingRisk\",\"value\":\"low\",\"contrib\":0},{\"rule\":\"Penalty: DocReliability\",\"value\":\"high\",\"contrib\":0},{\"rule\":\"Penalty: LocalEnforcement\",\"value\":\"high\",\"contrib\":0}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(22, 'Neatitinka', '2025-11-23', '≤4 ha be platumos/ilgumos; Trūksta teisėtumo dokumentų; Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo; Dokumentų paketas nepilnas', 26, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Legality documents\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"FAIL\",\"contrib\":1}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(23, 'Atitinka', '2025-11-23', 'Due-diligence pakankamas.', 13, 2, 100.00, '[{\"rule\":\"GATE: Polygon for >4 ha\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: Legality documents\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: Complete documentation\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"Evidence: DocsComplete\",\"value\":1,\"weight\":0.3,\"contrib\":0.3},{\"rule\":\"Evidence: Geolocation\",\"value\":1,\"weight\":0.2,\"contrib\":0.2},{\"rule\":\"Evidence: SupplierDeclaration\",\"value\":1,\"weight\":0.1,\"contrib\":0.1},{\"rule\":\"Evidence: Certifications\",\"value\":1,\"weight\":0.15,\"contrib\":0.15},{\"rule\":\"Evidence: TraceabilityDepth\",\"value\":1,\"weight\":0.1,\"contrib\":0.1},{\"rule\":\"Evidence: ExternalVerification\",\"value\":1,\"weight\":0.15,\"contrib\":0.15},{\"rule\":\"Penalty: IndigenousClaims\",\"value\":0,\"contrib\":0},{\"rule\":\"Penalty: SanctionsRisk\",\"value\":0,\"contrib\":0},{\"rule\":\"Penalty: SupplyChainComplexity\",\"value\":\"low\",\"contrib\":0},{\"rule\":\"Penalty: MixingRisk\",\"value\":\"low\",\"contrib\":0},{\"rule\":\"Penalty: DocReliability\",\"value\":\"high\",\"contrib\":0},{\"rule\":\"Penalty: LocalEnforcement\",\"value\":\"high\",\"contrib\":0}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(24, 'Nežinoma', '2025-11-23', 'Reikalinga papildoma informacija / rizikos mažinimas (11 str.).', 12, 2, 49.33, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: Legality documents\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: Complete documentation\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"Evidence: DocsComplete\",\"value\":1,\"weight\":0.3,\"contrib\":0.3},{\"rule\":\"Evidence: Geolocation\",\"value\":1,\"weight\":0.2,\"contrib\":0.2},{\"rule\":\"Evidence: SupplierDeclaration\",\"value\":1,\"weight\":0.1,\"contrib\":0.1},{\"rule\":\"Evidence: Certifications\",\"value\":0.4,\"weight\":0.15,\"contrib\":0.06},{\"rule\":\"Evidence: TraceabilityDepth\",\"value\":0.3333333333333333,\"weight\":0.1,\"contrib\":0.03333333333333333},{\"rule\":\"Evidence: ExternalVerification\",\"value\":0,\"weight\":0.15,\"contrib\":0},{\"rule\":\"Penalty: IndigenousClaims\",\"value\":0,\"contrib\":0},{\"rule\":\"Penalty: SanctionsRisk\",\"value\":0,\"contrib\":0},{\"rule\":\"Penalty: SupplyChainComplexity\",\"value\":\"med\",\"contrib\":-5},{\"rule\":\"Penalty: MixingRisk\",\"value\":\"med\",\"contrib\":-5},{\"rule\":\"Penalty: DocReliability\",\"value\":\"med\",\"contrib\":-5},{\"rule\":\"Penalty: LocalEnforcement\",\"value\":\"med\",\"contrib\":-5}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(25, 'Atitinka', '2025-11-23', 'Due-diligence pakankamas.', 13, 2, 100.00, '[{\"rule\":\"GATE: Polygon for >4 ha\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: Legality documents\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: Complete documentation\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"Evidence: DocsComplete\",\"value\":1,\"weight\":0.3,\"contrib\":0.3},{\"rule\":\"Evidence: Geolocation\",\"value\":1,\"weight\":0.2,\"contrib\":0.2},{\"rule\":\"Evidence: SupplierDeclaration\",\"value\":1,\"weight\":0.1,\"contrib\":0.1},{\"rule\":\"Evidence: Certifications\",\"value\":1,\"weight\":0.15,\"contrib\":0.15},{\"rule\":\"Evidence: TraceabilityDepth\",\"value\":1,\"weight\":0.1,\"contrib\":0.1},{\"rule\":\"Evidence: ExternalVerification\",\"value\":1,\"weight\":0.15,\"contrib\":0.15},{\"rule\":\"Penalty: IndigenousClaims\",\"value\":0,\"contrib\":0},{\"rule\":\"Penalty: SanctionsRisk\",\"value\":0,\"contrib\":0},{\"rule\":\"Penalty: SupplyChainComplexity\",\"value\":\"low\",\"contrib\":0},{\"rule\":\"Penalty: MixingRisk\",\"value\":\"low\",\"contrib\":0},{\"rule\":\"Penalty: DocReliability\",\"value\":\"high\",\"contrib\":0},{\"rule\":\"Penalty: LocalEnforcement\",\"value\":\"high\",\"contrib\":0}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(26, 'Neatitinka', '2025-11-23', 'Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo', 11, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: Legality documents\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"OK\",\"contrib\":0}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(27, 'Neatitinka', '2025-12-01', '≤4 ha be platumos/ilgumos; Trūksta teisėtumo dokumentų; Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo; Dokumentų paketas nepilnas', 96, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Legality documents\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"FAIL\",\"contrib\":1}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(28, 'Neatitinka', '2025-12-01', '≤4 ha be platumos/ilgumos; Trūksta teisėtumo dokumentų; Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo; Dokumentų paketas nepilnas', 98, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Legality documents\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"FAIL\",\"contrib\":1}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(29, 'Neatitinka', '2025-12-01', '≤4 ha be platumos/ilgumos; Trūksta teisėtumo dokumentų; Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo; Dokumentų paketas nepilnas', 96, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Legality documents\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"FAIL\",\"contrib\":1}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(30, 'Neatitinka', '2025-12-01', '≤4 ha be platumos/ilgumos; Trūksta teisėtumo dokumentų; Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo; Dokumentų paketas nepilnas', 86, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Legality documents\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"FAIL\",\"contrib\":1}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(31, 'Neatitinka', '2025-12-01', '≤4 ha be platumos/ilgumos; Trūksta teisėtumo dokumentų; Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo; Dokumentų paketas nepilnas', 9, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Legality documents\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"FAIL\",\"contrib\":1}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(32, 'Neatitinka', '2025-12-01', '≤4 ha be platumos/ilgumos; Trūksta teisėtumo dokumentų; Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo; Dokumentų paketas nepilnas', 22, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Legality documents\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"FAIL\",\"contrib\":1}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(33, 'Neatitinka', '2025-12-01', '≤4 ha be platumos/ilgumos; Trūksta teisėtumo dokumentų; Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo; Dokumentų paketas nepilnas', 24, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Legality documents\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"FAIL\",\"contrib\":1}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(34, 'Neatitinka', '2025-12-01', '≤4 ha be platumos/ilgumos; Trūksta teisėtumo dokumentų; Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo; Dokumentų paketas nepilnas', 38, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Legality documents\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"FAIL\",\"contrib\":1}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(35, 'Neatitinka', '2025-12-01', '≤4 ha be platumos/ilgumos; Trūksta teisėtumo dokumentų; Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo; Dokumentų paketas nepilnas', 99, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Legality documents\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"FAIL\",\"contrib\":1}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(36, 'Neatitinka', '2025-12-01', '≤4 ha be platumos/ilgumos; Trūksta teisėtumo dokumentų; Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo; Dokumentų paketas nepilnas', 91, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Legality documents\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"FAIL\",\"contrib\":1}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(37, 'Neatitinka', '2025-12-01', '≤4 ha be platumos/ilgumos; Trūksta teisėtumo dokumentų; Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo; Dokumentų paketas nepilnas', 87, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Legality documents\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"FAIL\",\"contrib\":1}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(38, 'Neatitinka', '2025-12-01', '≤4 ha be platumos/ilgumos; Trūksta teisėtumo dokumentų; Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo; Dokumentų paketas nepilnas', 78, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Legality documents\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"FAIL\",\"contrib\":1}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(39, 'Neatitinka', '2025-12-01', '≤4 ha be platumos/ilgumos; Trūksta teisėtumo dokumentų; Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo; Dokumentų paketas nepilnas', 51, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Legality documents\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"FAIL\",\"contrib\":1}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(40, 'Neatitinka', '2025-12-01', '≤4 ha be platumos/ilgumos; Trūksta teisėtumo dokumentų; Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo; Dokumentų paketas nepilnas', 16, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Legality documents\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"FAIL\",\"contrib\":1}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(41, 'Neatitinka', '2025-12-01', '≤4 ha be platumos/ilgumos; Trūksta teisėtumo dokumentų; Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo; Dokumentų paketas nepilnas', 3, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Legality documents\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"FAIL\",\"contrib\":1}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(42, 'Nežinoma', '2025-12-01', 'Reikalinga papildoma informacija / rizikos mažinimas (11 str.).', 12, 2, 49.33, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: Legality documents\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: Complete documentation\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"Evidence: DocsComplete\",\"value\":1,\"weight\":0.3,\"contrib\":0.3},{\"rule\":\"Evidence: Geolocation\",\"value\":1,\"weight\":0.2,\"contrib\":0.2},{\"rule\":\"Evidence: SupplierDeclaration\",\"value\":1,\"weight\":0.1,\"contrib\":0.1},{\"rule\":\"Evidence: Certifications\",\"value\":0.4,\"weight\":0.15,\"contrib\":0.06},{\"rule\":\"Evidence: TraceabilityDepth\",\"value\":0.3333333333333333,\"weight\":0.1,\"contrib\":0.03333333333333333},{\"rule\":\"Evidence: ExternalVerification\",\"value\":0,\"weight\":0.15,\"contrib\":0},{\"rule\":\"Penalty: IndigenousClaims\",\"value\":0,\"contrib\":0},{\"rule\":\"Penalty: SanctionsRisk\",\"value\":0,\"contrib\":0},{\"rule\":\"Penalty: SupplyChainComplexity\",\"value\":\"med\",\"contrib\":-5},{\"rule\":\"Penalty: MixingRisk\",\"value\":\"med\",\"contrib\":-5},{\"rule\":\"Penalty: DocReliability\",\"value\":\"med\",\"contrib\":-5},{\"rule\":\"Penalty: LocalEnforcement\",\"value\":\"med\",\"contrib\":-5}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(43, 'Neatitinka', '2025-12-01', '≤4 ha be platumos/ilgumos; Trūksta teisėtumo dokumentų; Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo; Dokumentų paketas nepilnas', 16, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Legality documents\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"FAIL\",\"contrib\":1}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(44, 'Neatitinka', '2025-12-01', '≤4 ha be platumos/ilgumos; Trūksta teisėtumo dokumentų; Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo; Dokumentų paketas nepilnas', 16, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Legality documents\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"FAIL\",\"contrib\":1}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(45, 'Neatitinka', '2025-12-01', '≤4 ha be platumos/ilgumos; Trūksta teisėtumo dokumentų; Neįrodyta, kad po 2020-12-31 nebuvo miškų naikinimo; Dokumentų paketas nepilnas', 25, 2, 0.00, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Legality documents\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"FAIL\",\"contrib\":1},{\"rule\":\"GATE: Complete documentation\",\"value\":\"FAIL\",\"contrib\":1}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}'),
(46, 'Nežinoma', '2025-12-01', 'Reikalinga papildoma informacija / rizikos mažinimas (11 str.).', 12, 2, 49.33, '[{\"rule\":\"GATE: Lat/Lng for ≤4 ha\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: Legality documents\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: No deforestation after 2020-12-31\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"GATE: Complete documentation\",\"value\":\"OK\",\"contrib\":0},{\"rule\":\"Evidence: DocsComplete\",\"value\":1,\"weight\":0.3,\"contrib\":0.3},{\"rule\":\"Evidence: Geolocation\",\"value\":1,\"weight\":0.2,\"contrib\":0.2},{\"rule\":\"Evidence: SupplierDeclaration\",\"value\":1,\"weight\":0.1,\"contrib\":0.1},{\"rule\":\"Evidence: Certifications\",\"value\":0.4,\"weight\":0.15,\"contrib\":0.06},{\"rule\":\"Evidence: TraceabilityDepth\",\"value\":0.3333333333333333,\"weight\":0.1,\"contrib\":0.03333333333333333},{\"rule\":\"Evidence: ExternalVerification\",\"value\":0,\"weight\":0.15,\"contrib\":0},{\"rule\":\"Penalty: IndigenousClaims\",\"value\":0,\"contrib\":0},{\"rule\":\"Penalty: SanctionsRisk\",\"value\":0,\"contrib\":0},{\"rule\":\"Penalty: SupplyChainComplexity\",\"value\":\"med\",\"contrib\":-5},{\"rule\":\"Penalty: MixingRisk\",\"value\":\"med\",\"contrib\":-5},{\"rule\":\"Penalty: DocReliability\",\"value\":\"med\",\"contrib\":-5},{\"rule\":\"Penalty: LocalEnforcement\",\"value\":\"med\",\"contrib\":-5}]', 'v2.0', '{\"version\":\"v2.0\",\"weights\":{\"docs\":0.3,\"geo\":0.2,\"decl\":0.1,\"cert\":0.15,\"trace\":0.1,\"ext\":0.15},\"cutoffs\":{\"ok\":85,\"review\":25},\"notes\":\"Gates + evidence score − Article 10 penalties\"}');

-- --------------------------------------------------------

--
-- Table structure for table `dd_statement`
--

CREATE TABLE `dd_statement` (
  `ID` int(11) NOT NULL,
  `ProduktasID` int(11) NOT NULL,
  `VartotojasID` int(11) NOT NULL,
  `JSONPayload` longtext DEFAULT NULL,
  `PDFNuoroda` varchar(255) DEFAULT NULL,
  `SukurimoData` datetime NOT NULL,
  `Status` enum('Prepared','Submitted') DEFAULT 'Prepared',
  `ModelVersion` varchar(20) DEFAULT NULL,
  `ModelConfig` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `dd_statement`
--

INSERT INTO `dd_statement` (`ID`, `ProduktasID`, `VartotojasID`, `JSONPayload`, `PDFNuoroda`, `SukurimoData`, `Status`, `ModelVersion`, `ModelConfig`) VALUES
(1, 13, 2, '{\n    \"product\": {\n        \"id\": 13,\n        \"name\": \"Sertifikuotos medienos lentos\",\n        \"category\": \"Mediena\",\n        \"country\": \"SE\",\n        \"harvest_date\": \"2024-03-20\"\n    },\n    \"supplier\": {\n        \"id\": 3,\n        \"name\": \"GreenWood Ltd.\"\n    },\n    \"geolocation\": {\n        \"area_ha\": \"10.00\",\n        \"lat\": null,\n        \"lng\": null,\n        \"polygon_geojson_present\": true\n    },\n    \"evidence\": {\n        \"geo_provided\": true,\n        \"legal_docs\": true,\n        \"deforestation_verified\": true,\n        \"docs_complete\": true,\n        \"supplier_declaration\": true,\n        \"external_verification\": true,\n        \"traceability_depth\": 3,\n        \"cert_score_0_10\": 10\n    },\n    \"art10_factors\": {\n        \"indigenous_claims\": false,\n        \"sanctions_risk\": false,\n        \"supply_chain_complexity\": \"low\",\n        \"mixing_risk\": \"low\",\n        \"doc_reliability\": \"high\",\n        \"local_enforcement\": \"high\"\n    },\n    \"latest_check\": {\n        \"ab\": \"100.00\",\n        \"status\": \"Atitinka\"\n    },\n    \"model\": {\n        \"version\": \"v2.0\",\n        \"cutoffs\": {\n            \"ok\": 85,\n            \"review\": 25\n        }\n    },\n    \"prepared_by_user\": 2,\n    \"prepared_at\": \"2025-11-23T00:02:35+01:00\"\n}', 'ataskaitos/dds_1_13.pdf', '2025-11-23 01:02:35', 'Prepared', 'v2.0', '{\"version\":\"v2.0\",\"cutoffs\":{\"ok\":85,\"review\":25}}'),
(2, 12, 2, '{\n    \"product\": {\n        \"id\": 12,\n        \"name\": \"Kavos pupelės iš mišrios tiekimo grandinės\",\n        \"category\": \"Kava\",\n        \"country\": \"LT\",\n        \"harvest_date\": \"2023-06-10\"\n    },\n    \"supplier\": {\n        \"id\": 3,\n        \"name\": \"GreenWood Ltd.\"\n    },\n    \"geolocation\": {\n        \"area_ha\": \"3.00\",\n        \"lat\": \"-5.123456\",\n        \"lng\": \"-40.654321\",\n        \"polygon_geojson_present\": false\n    },\n    \"evidence\": {\n        \"geo_provided\": true,\n        \"legal_docs\": true,\n        \"deforestation_verified\": true,\n        \"docs_complete\": true,\n        \"supplier_declaration\": true,\n        \"external_verification\": false,\n        \"traceability_depth\": 1,\n        \"cert_score_0_10\": 4\n    },\n    \"art10_factors\": {\n        \"indigenous_claims\": false,\n        \"sanctions_risk\": false,\n        \"supply_chain_complexity\": \"med\",\n        \"mixing_risk\": \"med\",\n        \"doc_reliability\": \"med\",\n        \"local_enforcement\": \"med\"\n    },\n    \"latest_check\": {\n        \"ab\": \"49.33\",\n        \"status\": \"Nežinoma\"\n    },\n    \"model\": {\n        \"version\": \"v2.0\",\n        \"cutoffs\": {\n            \"ok\": 85,\n            \"review\": 25\n        }\n    },\n    \"prepared_by_user\": 2,\n    \"prepared_at\": \"2025-11-23T00:02:36+01:00\"\n}', 'ataskaitos/dds_2_12.pdf', '2025-11-23 01:02:36', 'Prepared', 'v2.0', '{\"version\":\"v2.0\",\"cutoffs\":{\"ok\":85,\"review\":25}}'),
(3, 11, 2, '{\n    \"product\": {\n        \"id\": 11,\n        \"name\": \"Sojų rupiniai be deforestacijos įrodymų\",\n        \"category\": \"Soja\",\n        \"country\": \"BR\",\n        \"harvest_date\": \"2023-09-15\"\n    },\n    \"supplier\": {\n        \"id\": 3,\n        \"name\": \"GreenWood Ltd.\"\n    },\n    \"geolocation\": {\n        \"area_ha\": \"3.50\",\n        \"lat\": \"-10.000000\",\n        \"lng\": \"-55.000000\",\n        \"polygon_geojson_present\": false\n    },\n    \"evidence\": {\n        \"geo_provided\": true,\n        \"legal_docs\": true,\n        \"deforestation_verified\": false,\n        \"docs_complete\": true,\n        \"supplier_declaration\": true,\n        \"external_verification\": false,\n        \"traceability_depth\": 2,\n        \"cert_score_0_10\": 7\n    },\n    \"art10_factors\": {\n        \"indigenous_claims\": false,\n        \"sanctions_risk\": false,\n        \"supply_chain_complexity\": \"med\",\n        \"mixing_risk\": \"med\",\n        \"doc_reliability\": \"med\",\n        \"local_enforcement\": \"med\"\n    },\n    \"latest_check\": {\n        \"ab\": \"0.00\",\n        \"status\": \"Neatitinka\"\n    },\n    \"model\": {\n        \"version\": \"v2.0\",\n        \"cutoffs\": {\n            \"ok\": 85,\n            \"review\": 25\n        }\n    },\n    \"prepared_by_user\": 2,\n    \"prepared_at\": \"2025-11-23T00:02:38+01:00\"\n}', 'ataskaitos/dds_3_11.pdf', '2025-11-23 01:02:38', 'Prepared', 'v2.0', '{\"version\":\"v2.0\",\"cutoffs\":{\"ok\":85,\"review\":25}}'),
(4, 11, 2, '{\n    \"product\": {\n        \"id\": 11,\n        \"name\": \"Sojų rupiniai be deforestacijos įrodymų\",\n        \"category\": \"Soja\",\n        \"country\": \"BR\",\n        \"harvest_date\": \"2023-09-15\"\n    },\n    \"supplier\": {\n        \"id\": 3,\n        \"name\": \"GreenWood Ltd.\"\n    },\n    \"geolocation\": {\n        \"area_ha\": \"3.50\",\n        \"lat\": \"-10.000000\",\n        \"lng\": \"-55.000000\",\n        \"polygon_geojson_present\": false\n    },\n    \"evidence\": {\n        \"geo_provided\": true,\n        \"legal_docs\": true,\n        \"deforestation_verified\": false,\n        \"docs_complete\": true,\n        \"supplier_declaration\": true,\n        \"external_verification\": false,\n        \"traceability_depth\": 2,\n        \"cert_score_0_10\": 7\n    },\n    \"art10_factors\": {\n        \"indigenous_claims\": false,\n        \"sanctions_risk\": false,\n        \"supply_chain_complexity\": \"med\",\n        \"mixing_risk\": \"med\",\n        \"doc_reliability\": \"med\",\n        \"local_enforcement\": \"med\"\n    },\n    \"latest_check\": {\n        \"ab\": \"0.00\",\n        \"status\": \"Neatitinka\"\n    },\n    \"model\": {\n        \"version\": \"v2.0\",\n        \"cutoffs\": {\n            \"ok\": 85,\n            \"review\": 25\n        }\n    },\n    \"prepared_by_user\": 2,\n    \"prepared_at\": \"2025-11-23T00:03:08+01:00\"\n}', 'ataskaitos/dds_4_11.pdf', '2025-11-23 01:03:08', 'Prepared', 'v2.0', '{\"version\":\"v2.0\",\"cutoffs\":{\"ok\":85,\"review\":25}}'),
(5, 12, 2, '{\n    \"product\": {\n        \"id\": 12,\n        \"name\": \"Kavos pupelės iš mišrios tiekimo grandinės\",\n        \"category\": \"Kava\",\n        \"country\": \"LT\",\n        \"harvest_date\": \"2023-06-10\"\n    },\n    \"supplier\": {\n        \"id\": 3,\n        \"name\": \"GreenWood Ltd.\"\n    },\n    \"geolocation\": {\n        \"area_ha\": \"3.00\",\n        \"lat\": \"-5.123456\",\n        \"lng\": \"-40.654321\",\n        \"polygon_geojson_present\": false\n    },\n    \"evidence\": {\n        \"geo_provided\": true,\n        \"legal_docs\": true,\n        \"deforestation_verified\": true,\n        \"docs_complete\": true,\n        \"supplier_declaration\": true,\n        \"external_verification\": false,\n        \"traceability_depth\": 1,\n        \"cert_score_0_10\": 4\n    },\n    \"art10_factors\": {\n        \"indigenous_claims\": false,\n        \"sanctions_risk\": false,\n        \"supply_chain_complexity\": \"med\",\n        \"mixing_risk\": \"med\",\n        \"doc_reliability\": \"med\",\n        \"local_enforcement\": \"med\"\n    },\n    \"latest_check\": {\n        \"ab\": \"49.33\",\n        \"status\": \"Nežinoma\"\n    },\n    \"model\": {\n        \"version\": \"v2.0\",\n        \"cutoffs\": {\n            \"ok\": 85,\n            \"review\": 25\n        }\n    },\n    \"prepared_by_user\": 2,\n    \"prepared_at\": \"2025-11-23T00:03:10+01:00\"\n}', 'ataskaitos/dds_5_12.pdf', '2025-11-23 01:03:10', 'Prepared', 'v2.0', '{\"version\":\"v2.0\",\"cutoffs\":{\"ok\":85,\"review\":25}}'),
(6, 11, 2, '{\n    \"product\": {\n        \"id\": 11,\n        \"name\": \"Sojų rupiniai be deforestacijos įrodymų\",\n        \"category\": \"Soja\",\n        \"country\": \"BR\",\n        \"harvest_date\": \"2023-09-15\"\n    },\n    \"supplier\": {\n        \"id\": 3,\n        \"name\": \"GreenWood Ltd.\"\n    },\n    \"geolocation\": {\n        \"area_ha\": \"3.50\",\n        \"lat\": \"-10.000000\",\n        \"lng\": \"-55.000000\",\n        \"polygon_geojson_present\": false\n    },\n    \"evidence\": {\n        \"geo_provided\": true,\n        \"legal_docs\": true,\n        \"deforestation_verified\": false,\n        \"docs_complete\": true,\n        \"supplier_declaration\": true,\n        \"external_verification\": false,\n        \"traceability_depth\": 2,\n        \"cert_score_0_10\": 7\n    },\n    \"art10_factors\": {\n        \"indigenous_claims\": false,\n        \"sanctions_risk\": false,\n        \"supply_chain_complexity\": \"med\",\n        \"mixing_risk\": \"med\",\n        \"doc_reliability\": \"med\",\n        \"local_enforcement\": \"med\"\n    },\n    \"latest_check\": {\n        \"ab\": \"0.00\",\n        \"status\": \"Neatitinka\"\n    },\n    \"model\": {\n        \"version\": \"v2.0\",\n        \"cutoffs\": {\n            \"ok\": 85,\n            \"review\": 25\n        }\n    },\n    \"prepared_by_user\": 2,\n    \"prepared_at\": \"2025-11-23T00:03:14+01:00\"\n}', 'ataskaitos/dds_6_11.pdf', '2025-11-23 01:03:14', 'Prepared', 'v2.0', '{\"version\":\"v2.0\",\"cutoffs\":{\"ok\":85,\"review\":25}}'),
(7, 11, 2, '{\n    \"product\": {\n        \"id\": 11,\n        \"name\": \"Sojų rupiniai be deforestacijos įrodymų\",\n        \"category\": \"Soja\",\n        \"country\": \"BR\",\n        \"harvest_date\": \"2023-09-15\"\n    },\n    \"supplier\": {\n        \"id\": 3,\n        \"name\": \"GreenWood Ltd.\"\n    },\n    \"geolocation\": {\n        \"area_ha\": \"3.50\",\n        \"lat\": \"-10.000000\",\n        \"lng\": \"-55.000000\",\n        \"polygon_geojson_present\": false\n    },\n    \"evidence\": {\n        \"geo_provided\": true,\n        \"legal_docs\": true,\n        \"deforestation_verified\": false,\n        \"docs_complete\": true,\n        \"supplier_declaration\": true,\n        \"external_verification\": false,\n        \"traceability_depth\": 2,\n        \"cert_score_0_10\": 7\n    },\n    \"art10_factors\": {\n        \"indigenous_claims\": false,\n        \"sanctions_risk\": false,\n        \"supply_chain_complexity\": \"med\",\n        \"mixing_risk\": \"med\",\n        \"doc_reliability\": \"med\",\n        \"local_enforcement\": \"med\"\n    },\n    \"latest_check\": {\n        \"ab\": \"0.00\",\n        \"status\": \"Neatitinka\"\n    },\n    \"model\": {\n        \"version\": \"v2.0\",\n        \"cutoffs\": {\n            \"ok\": 85,\n            \"review\": 25\n        }\n    },\n    \"prepared_by_user\": 2,\n    \"prepared_at\": \"2025-11-23T00:03:16+01:00\"\n}', 'ataskaitos/dds_7_11.pdf', '2025-11-23 01:03:16', 'Prepared', 'v2.0', '{\"version\":\"v2.0\",\"cutoffs\":{\"ok\":85,\"review\":25}}'),
(8, 13, 2, '{\n    \"product\": {\n        \"id\": 13,\n        \"name\": \"Sertifikuotos medienos lentos\",\n        \"category\": \"Mediena\",\n        \"country\": \"SE\",\n        \"harvest_date\": \"2024-03-20\"\n    },\n    \"supplier\": {\n        \"id\": 3,\n        \"name\": \"GreenWood Ltd.\"\n    },\n    \"geolocation\": {\n        \"area_ha\": \"10.00\",\n        \"lat\": null,\n        \"lng\": null,\n        \"polygon_geojson_present\": true\n    },\n    \"evidence\": {\n        \"geo_provided\": true,\n        \"legal_docs\": true,\n        \"deforestation_verified\": true,\n        \"docs_complete\": true,\n        \"supplier_declaration\": true,\n        \"external_verification\": true,\n        \"traceability_depth\": 3,\n        \"cert_score_0_10\": 10\n    },\n    \"art10_factors\": {\n        \"indigenous_claims\": false,\n        \"sanctions_risk\": false,\n        \"supply_chain_complexity\": \"low\",\n        \"mixing_risk\": \"low\",\n        \"doc_reliability\": \"high\",\n        \"local_enforcement\": \"high\"\n    },\n    \"latest_check\": {\n        \"ab\": \"100.00\",\n        \"status\": \"Atitinka\"\n    },\n    \"model\": {\n        \"version\": \"v2.0\",\n        \"cutoffs\": {\n            \"ok\": 85,\n            \"review\": 25\n        }\n    },\n    \"prepared_by_user\": 2,\n    \"prepared_at\": \"2025-11-23T00:04:41+01:00\"\n}', 'ataskaitos/dds_8_13.pdf', '2025-11-23 01:04:41', 'Prepared', 'v2.0', '{\"version\":\"v2.0\",\"cutoffs\":{\"ok\":85,\"review\":25}}'),
(9, 13, 2, '{\n    \"product\": {\n        \"id\": 13,\n        \"name\": \"Sertifikuotos medienos lentos\",\n        \"category\": \"Mediena\",\n        \"country\": \"SE\",\n        \"harvest_date\": \"2024-03-20\"\n    },\n    \"supplier\": {\n        \"id\": 3,\n        \"name\": \"GreenWood Ltd.\"\n    },\n    \"geolocation\": {\n        \"area_ha\": \"10.00\",\n        \"lat\": null,\n        \"lng\": null,\n        \"polygon_geojson_present\": true\n    },\n    \"evidence\": {\n        \"geo_provided\": true,\n        \"legal_docs\": true,\n        \"deforestation_verified\": true,\n        \"docs_complete\": true,\n        \"supplier_declaration\": true,\n        \"external_verification\": true,\n        \"traceability_depth\": 3,\n        \"cert_score_0_10\": 10\n    },\n    \"art10_factors\": {\n        \"indigenous_claims\": false,\n        \"sanctions_risk\": false,\n        \"supply_chain_complexity\": \"low\",\n        \"mixing_risk\": \"low\",\n        \"doc_reliability\": \"high\",\n        \"local_enforcement\": \"high\"\n    },\n    \"latest_check\": {\n        \"ab\": \"100.00\",\n        \"status\": \"Atitinka\"\n    },\n    \"model\": {\n        \"version\": \"v2.0\",\n        \"cutoffs\": {\n            \"ok\": 85,\n            \"review\": 25\n        }\n    },\n    \"prepared_by_user\": 2,\n    \"prepared_at\": \"2025-11-23T00:36:19+01:00\"\n}', 'ataskaitos/dds_9_13.pdf', '2025-11-23 01:36:19', 'Prepared', 'v2.0', '{\"version\":\"v2.0\",\"cutoffs\":{\"ok\":85,\"review\":25}}'),
(10, 12, 2, '{\n    \"product\": {\n        \"id\": 12,\n        \"name\": \"Kavos pupelės\",\n        \"category\": \"Kava\",\n        \"country\": \"LT\",\n        \"harvest_date\": \"2023-06-10\"\n    },\n    \"supplier\": {\n        \"id\": 3,\n        \"name\": \"GreenWood Ltd.\"\n    },\n    \"geolocation\": {\n        \"area_ha\": \"3.00\",\n        \"lat\": \"-5.123456\",\n        \"lng\": \"-40.654321\",\n        \"polygon_geojson_present\": false\n    },\n    \"evidence\": {\n        \"geo_provided\": true,\n        \"legal_docs\": true,\n        \"deforestation_verified\": true,\n        \"docs_complete\": true,\n        \"supplier_declaration\": true,\n        \"external_verification\": false,\n        \"traceability_depth\": 1,\n        \"cert_score_0_10\": 4\n    },\n    \"art10_factors\": {\n        \"indigenous_claims\": false,\n        \"sanctions_risk\": false,\n        \"supply_chain_complexity\": \"med\",\n        \"mixing_risk\": \"med\",\n        \"doc_reliability\": \"med\",\n        \"local_enforcement\": \"med\"\n    },\n    \"latest_check\": {\n        \"ab\": \"49.33\",\n        \"status\": \"Nežinoma\"\n    },\n    \"model\": {\n        \"version\": \"v2.0\",\n        \"cutoffs\": {\n            \"ok\": 85,\n            \"review\": 25\n        }\n    },\n    \"prepared_by_user\": 2,\n    \"prepared_at\": \"2025-12-01T15:47:15+01:00\"\n}', 'ataskaitos/dds_10_12.pdf', '2025-12-01 16:47:15', 'Prepared', 'v2.0', '{\"version\":\"v2.0\",\"cutoffs\":{\"ok\":85,\"review\":25}}');

-- --------------------------------------------------------

--
-- Table structure for table `kategoriju_sarasas`
--

CREATE TABLE `kategoriju_sarasas` (
  `Kategorija` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kategoriju_sarasas`
--

INSERT INTO `kategoriju_sarasas` (`Kategorija`) VALUES
('Alyvpalmių aliejus'),
('Galvijai'),
('Kakava'),
('Kaučiukas'),
('Kava'),
('Mediena'),
('Soja');

-- --------------------------------------------------------

--
-- Table structure for table `produktas`
--

CREATE TABLE `produktas` (
  `ID` int(11) NOT NULL,
  `Pavadinimas` varchar(255) NOT NULL,
  `Salis` char(2) NOT NULL,
  `Latitude` decimal(9,6) DEFAULT NULL,
  `Longitude` decimal(9,6) DEFAULT NULL,
  `AreaHa` decimal(8,2) DEFAULT NULL,
  `PlotGeoJSON` longtext DEFAULT NULL,
  `TiekejasID` int(11) NOT NULL,
  `Kategorija` varchar(100) NOT NULL,
  `LegalDocsProvided` tinyint(1) DEFAULT NULL,
  `DeforestationVerified` tinyint(1) DEFAULT NULL,
  `ExternalVerification` tinyint(1) DEFAULT NULL,
  `IndigenousClaims` tinyint(1) DEFAULT NULL,
  `SanctionsRisk` tinyint(1) DEFAULT NULL,
  `SupplyChainComplexity` enum('low','med','high') DEFAULT NULL,
  `MixingRisk` enum('low','med','high') DEFAULT NULL,
  `DocReliability` enum('low','med','high') DEFAULT NULL,
  `LocalEnforcement` enum('low','med','high') DEFAULT NULL,
  `HarvestDate` date DEFAULT NULL,
  `GeoProvided` tinyint(1) DEFAULT NULL,
  `DocsComplete` tinyint(1) DEFAULT NULL,
  `SupplierDeclaration` tinyint(1) DEFAULT NULL,
  `TraceabilityDepth` tinyint(1) DEFAULT NULL,
  `CertScore` tinyint(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `produktas`
--

INSERT INTO `produktas` (`ID`, `Pavadinimas`, `Salis`, `Latitude`, `Longitude`, `AreaHa`, `PlotGeoJSON`, `TiekejasID`, `Kategorija`, `LegalDocsProvided`, `DeforestationVerified`, `ExternalVerification`, `IndigenousClaims`, `SanctionsRisk`, `SupplyChainComplexity`, `MixingRisk`, `DocReliability`, `LocalEnforcement`, `HarvestDate`, `GeoProvided`, `DocsComplete`, `SupplierDeclaration`, `TraceabilityDepth`, `CertScore`) VALUES
(3, 'Kavos pupelės', 'AE', NULL, NULL, NULL, NULL, 3, 'Kava', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 'Vištiena', 'BB', NULL, NULL, NULL, NULL, 3, 'Galvijai', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 'Sojų pupelės C', 'AL', NULL, NULL, NULL, NULL, 3, 'Soja', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(9, 'Sojų rupiniai', 'AM', NULL, NULL, NULL, NULL, 3, 'Kaučiukas', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10, 'Vištiena', 'AD', NULL, NULL, NULL, NULL, 3, 'Galvijai', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11, 'Sojų rupiniai', 'BR', -10.000000, -55.000000, 3.50, NULL, 3, 'Soja', 1, 0, 0, 0, 0, 'med', 'med', 'med', 'med', '2023-09-15', 1, 1, 1, 2, 7),
(12, 'Kavos pupelės', 'LT', -5.123456, -40.654321, 3.00, NULL, 3, 'Kava', 1, 1, 0, 0, 0, 'med', 'med', 'med', 'med', '2023-06-10', 1, 1, 1, 1, 4),
(13, 'medienos lentos', 'SE', NULL, NULL, 10.00, '{\r\n  \"type\": \"Polygon\",\r\n  \"coordinates\": [\r\n    [\r\n      [106.810000, -6.200000],\r\n      [106.820000, -6.200000],\r\n      [106.820000, -6.210000],\r\n      [106.810000, -6.210000],\r\n      [106.810000, -6.200000]\r\n    ]\r\n  ]\r\n}\r\n', 3, 'Mediena', 1, 1, 1, 0, 0, 'low', 'low', 'high', 'high', '2024-03-20', 1, 1, 1, 3, 10),
(14, 'Vištiena', 'AD', NULL, NULL, NULL, NULL, 3, 'Alyvpalmių aliejus', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(15, 'kIAULIENOS MESa', 'AG', NULL, NULL, NULL, NULL, 3, 'Galvijai', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(16, 'Kavos pupelės', 'AE', NULL, NULL, NULL, NULL, 3, 'Kava', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(17, 'Vištiena', 'BB', NULL, NULL, NULL, NULL, 3, 'Galvijai', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(18, 'krepsynyo kamuolys', 'AS', NULL, NULL, NULL, NULL, 3, 'Kaučiukas', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(19, 'Sojų pupelės C', 'AL', NULL, NULL, NULL, NULL, 3, 'Soja', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(20, 'aodsfdaf', 'AT', NULL, NULL, NULL, NULL, 3, 'Alyvpalmių aliejus', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(21, 'afs', 'AG', NULL, NULL, NULL, NULL, 3, 'Kakava', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(22, 'Sojų rupiniai', 'AM', NULL, NULL, NULL, NULL, 3, 'Kaučiukas', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(23, 'Vištiena', 'AD', NULL, NULL, NULL, NULL, 3, 'Galvijai', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(24, 'Sojų rupiniai', 'BR', NULL, NULL, NULL, NULL, 3, 'Soja', 0, 0, 0, 0, 0, 'med', 'med', 'med', 'med', NULL, 0, 0, 0, 0, 0),
(25, 'Kavos pupelės', 'LT', NULL, NULL, NULL, NULL, 3, 'Kava', 0, 0, 0, 0, 0, 'med', 'med', 'med', 'med', NULL, 0, 0, 0, 0, 0),
(26, 'medienos lentos', 'SE', NULL, NULL, NULL, NULL, 3, 'Mediena', 0, 0, 0, 0, 0, 'med', 'med', 'med', 'med', NULL, 0, 0, 0, 0, 0),
(27, 'Vištiena', 'AD', NULL, NULL, NULL, NULL, 3, 'Alyvpalmių aliejus', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(28, 'kIAULIENOS MESa', 'AG', NULL, NULL, NULL, NULL, 3, 'Galvijai', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(29, 'Kavos pupelės', 'AE', NULL, NULL, NULL, NULL, 3, 'Kava', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(30, 'Vištiena', 'BB', NULL, NULL, NULL, NULL, 3, 'Galvijai', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(31, 'krepsynyo kamuolys', 'AS', NULL, NULL, NULL, NULL, 3, 'Kaučiukas', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(32, 'Sojų pupelės C', 'AL', NULL, NULL, NULL, NULL, 3, 'Soja', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(33, 'aodsfdaf', 'AT', NULL, NULL, NULL, NULL, 3, 'Alyvpalmių aliejus', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(34, 'afs', 'AG', NULL, NULL, NULL, NULL, 3, 'Kakava', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(35, 'Sojų rupiniai', 'AM', NULL, NULL, NULL, NULL, 3, 'Kaučiukas', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(36, 'Vištiena', 'AD', NULL, NULL, NULL, NULL, 3, 'Galvijai', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(37, 'Sojų rupiniai', 'BR', NULL, NULL, NULL, NULL, 3, 'Soja', 0, 0, 0, 0, 0, 'med', 'med', 'med', 'med', NULL, 0, 0, 0, 0, 0),
(38, 'Kavos pupelės', 'LT', NULL, NULL, NULL, NULL, 3, 'Kava', 0, 0, 0, 0, 0, 'med', 'med', 'med', 'med', NULL, 0, 0, 0, 0, 0),
(39, 'medienos lentos', 'SE', NULL, NULL, NULL, NULL, 3, 'Mediena', 0, 0, 0, 0, 0, 'med', 'med', 'med', 'med', NULL, 0, 0, 0, 0, 0),
(40, 'Vištiena', 'AD', NULL, NULL, NULL, NULL, 3, 'Alyvpalmių aliejus', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(41, 'kIAULIENOS MESa', 'AG', NULL, NULL, NULL, NULL, 3, 'Galvijai', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 'Kavos pupelės', 'AE', NULL, NULL, NULL, NULL, 3, 'Kava', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(43, 'Vištiena', 'BB', NULL, NULL, NULL, NULL, 3, 'Galvijai', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(45, 'Sojų pupelės C', 'AL', NULL, NULL, NULL, NULL, 3, 'Soja', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(46, 'aodsfdaf', 'AT', NULL, NULL, NULL, NULL, 3, 'Alyvpalmių aliejus', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(47, 'afs', 'AG', NULL, NULL, NULL, NULL, 3, 'Kakava', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(48, 'Sojų rupiniai', 'AM', NULL, NULL, NULL, NULL, 3, 'Kaučiukas', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(49, 'Vištiena', 'AD', NULL, NULL, NULL, NULL, 3, 'Galvijai', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(50, 'Sojų rupiniai', 'BR', NULL, NULL, NULL, NULL, 3, 'Soja', 0, 0, 0, 0, 0, 'med', 'med', 'med', 'med', NULL, 0, 0, 0, 0, 0),
(51, 'Kavos pupelės', 'LT', NULL, NULL, NULL, NULL, 3, 'Kava', 0, 0, 0, 0, 0, 'med', 'med', 'med', 'med', NULL, 0, 0, 0, 0, 0),
(52, 'Medienos lentos', 'SE', NULL, NULL, NULL, NULL, 3, 'Mediena', 0, 0, 0, 0, 0, 'med', 'med', 'med', 'med', NULL, 0, 0, 0, 0, 0),
(53, 'Vištiena', 'AD', NULL, NULL, NULL, NULL, 3, 'Alyvpalmių aliejus', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(54, 'kIAULIENOS MESa', 'AG', NULL, NULL, NULL, NULL, 3, 'Galvijai', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(55, 'Kavos pupelės', 'AE', NULL, NULL, NULL, NULL, 3, 'Kava', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(56, 'Vištiena', 'BB', NULL, NULL, NULL, NULL, 3, 'Galvijai', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(57, 'Sojų pupelės C', 'AL', NULL, NULL, NULL, NULL, 3, 'Soja', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(58, 'Sojų rupiniai', 'AM', NULL, NULL, NULL, NULL, 3, 'Kaučiukas', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(59, 'Vištiena', 'AD', NULL, NULL, NULL, NULL, 3, 'Galvijai', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(60, 'Sojų rupiniai', 'BR', NULL, NULL, NULL, NULL, 3, 'Soja', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(61, 'Kavos pupelės', 'LT', NULL, NULL, NULL, NULL, 3, 'Kava', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(62, 'medienos lentos', 'SE', NULL, NULL, NULL, NULL, 3, 'Mediena', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(63, 'Vištiena', 'AD', NULL, NULL, NULL, NULL, 3, 'Alyvpalmių aliejus', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(64, 'kIAULIENOS MESa', 'AG', NULL, NULL, NULL, NULL, 3, 'Galvijai', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(65, 'Kavos pupelės', 'AE', NULL, NULL, NULL, NULL, 3, 'Kava', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(66, 'Vištiena', 'BB', NULL, NULL, NULL, NULL, 3, 'Galvijai', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(67, 'krepsynyo kamuolys', 'AS', NULL, NULL, NULL, NULL, 3, 'Kaučiukas', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(68, 'Sojų pupelės C', 'AL', NULL, NULL, NULL, NULL, 3, 'Soja', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(69, 'aodsfdaf', 'AT', NULL, NULL, NULL, NULL, 3, 'Alyvpalmių aliejus', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(70, 'afs', 'AG', NULL, NULL, NULL, NULL, 3, 'Kakava', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(71, 'Sojų rupiniai', 'AM', NULL, NULL, NULL, NULL, 3, 'Kaučiukas', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(72, 'Vištiena', 'AD', NULL, NULL, NULL, NULL, 3, 'Galvijai', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(73, 'Sojų rupiniai', 'BR', NULL, NULL, NULL, NULL, 3, 'Soja', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(74, 'Kavos pupelės', 'LT', NULL, NULL, NULL, NULL, 3, 'Kava', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(75, 'medienos lentos', 'SE', NULL, NULL, NULL, NULL, 3, 'Mediena', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(76, 'Vištiena', 'AD', NULL, NULL, NULL, NULL, 3, 'Alyvpalmių aliejus', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(77, 'kIAULIENOS MESa', 'AG', NULL, NULL, NULL, NULL, 3, 'Galvijai', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(78, 'Kavos pupelės', 'AE', NULL, NULL, NULL, NULL, 3, 'Kava', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(79, 'Vištiena', 'BB', NULL, NULL, NULL, NULL, 3, 'Galvijai', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(80, 'krepsynyo kamuolys', 'AS', NULL, NULL, NULL, NULL, 3, 'Kaučiukas', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(81, 'Sojų pupelės C', 'AL', NULL, NULL, NULL, NULL, 3, 'Soja', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(82, 'aodsfdaf', 'AT', NULL, NULL, NULL, NULL, 3, 'Alyvpalmių aliejus', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(83, 'afs', 'AG', NULL, NULL, NULL, NULL, 3, 'Kakava', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(84, 'Sojų rupiniai', 'AM', NULL, NULL, NULL, NULL, 3, 'Kaučiukas', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(85, 'Vištiena', 'AD', NULL, NULL, NULL, NULL, 3, 'Galvijai', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(86, 'Sojų rupiniai', 'BR', NULL, NULL, NULL, NULL, 3, 'Soja', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(87, 'Kavos pupelės', 'LT', NULL, NULL, NULL, NULL, 3, 'Kava', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(88, 'medienos lentos', 'SE', NULL, NULL, NULL, NULL, 3, 'Mediena', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(89, 'Vištiena', 'AD', NULL, NULL, NULL, NULL, 3, 'Alyvpalmių aliejus', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(90, 'kIAULIENOS MESa', 'AG', NULL, NULL, NULL, NULL, 3, 'Galvijai', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(91, 'Kavos pupelės', 'AE', NULL, NULL, NULL, NULL, 3, 'Kava', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(92, 'Vištiena', 'BB', NULL, NULL, NULL, NULL, 3, 'Galvijai', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(93, 'Sojų pupelės C', 'AL', NULL, NULL, NULL, NULL, 3, 'Soja', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(94, 'aodsfdaf', 'AT', NULL, NULL, NULL, NULL, 3, 'Alyvpalmių aliejus', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(95, 'afs', 'AG', NULL, NULL, NULL, NULL, 3, 'Kakava', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(96, 'Sojų rupiniai', 'AM', NULL, NULL, NULL, NULL, 3, 'Kaučiukas', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(97, 'Vištiena', 'AD', NULL, NULL, NULL, NULL, 3, 'Galvijai', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(98, 'Sojų rupiniai', 'BR', NULL, NULL, NULL, NULL, 3, 'Soja', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(99, 'Kavos pupelės', 'LT', NULL, NULL, NULL, NULL, 3, 'Kava', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(100, 'Medienos lentos', 'SE', NULL, NULL, NULL, NULL, 3, 'Mediena', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `saliu_sarasas`
--

CREATE TABLE `saliu_sarasas` (
  `salis` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `saliu_sarasas`
--

INSERT INTO `saliu_sarasas` (`salis`) VALUES
('AD'),
('AE'),
('AF'),
('AG'),
('AI'),
('AL'),
('AM'),
('AO'),
('AQ'),
('AR'),
('AS'),
('AT'),
('AU'),
('AW'),
('AX'),
('AZ'),
('BA'),
('BB'),
('BD'),
('BE'),
('BF'),
('BG'),
('BH'),
('BI'),
('BJ'),
('BL'),
('BM'),
('BN'),
('BO'),
('BQ'),
('BR'),
('BS'),
('BT'),
('BV'),
('BW'),
('BY'),
('BZ'),
('CA'),
('CC'),
('CD'),
('CF'),
('CG'),
('CH'),
('CI'),
('CK'),
('CL'),
('CM'),
('CN'),
('CO'),
('CR'),
('CU'),
('CV'),
('CW'),
('CX'),
('CY'),
('CZ'),
('DE'),
('DJ'),
('DK'),
('DM'),
('DO'),
('DZ'),
('EC'),
('EE'),
('EG'),
('EH'),
('ER'),
('ES'),
('ET'),
('FI'),
('FJ'),
('FK'),
('FM'),
('FO'),
('FR'),
('GA'),
('GB'),
('GD'),
('GE'),
('GF'),
('GG'),
('GH'),
('GI'),
('GL'),
('GM'),
('GN'),
('GP'),
('GQ'),
('GR'),
('GS'),
('GT'),
('GU'),
('GW'),
('GY'),
('HK'),
('HM'),
('HN'),
('HR'),
('HT'),
('HU'),
('ID'),
('IE'),
('IL'),
('IM'),
('IN'),
('IO'),
('IQ'),
('IR'),
('IS'),
('IT'),
('JE'),
('JM'),
('JO'),
('JP'),
('KE'),
('KG'),
('KH'),
('KI'),
('KM'),
('KN'),
('KP'),
('KR'),
('KW'),
('KY'),
('KZ'),
('LA'),
('LB'),
('LC'),
('LI'),
('LK'),
('LR'),
('LS'),
('LT'),
('LU'),
('LV'),
('LY'),
('MA'),
('MC'),
('MD'),
('ME'),
('MF'),
('MG'),
('MH'),
('MK'),
('ML'),
('MM'),
('MN'),
('MO'),
('MP'),
('MQ'),
('MR'),
('MS'),
('MT'),
('MU'),
('MV'),
('MW'),
('MX'),
('MY'),
('MZ'),
('NA'),
('NC'),
('NE'),
('NF'),
('NG'),
('NI'),
('NL'),
('NO'),
('NP'),
('NR'),
('NU'),
('NZ'),
('OM'),
('PA'),
('PE'),
('PF'),
('PG'),
('PH'),
('PK'),
('PL'),
('PM'),
('PN'),
('PR'),
('PS'),
('PT'),
('PW'),
('PY'),
('QA'),
('RE'),
('RO'),
('RS'),
('RU'),
('RW'),
('SA'),
('SB'),
('SC'),
('SD'),
('SE'),
('SG'),
('SH'),
('SI'),
('SJ'),
('SK'),
('SL'),
('SM'),
('SN'),
('SO'),
('SR'),
('SS'),
('ST'),
('SV'),
('SX'),
('SY'),
('SZ'),
('TC'),
('TD'),
('TF'),
('TG'),
('TH'),
('TJ'),
('TK'),
('TL'),
('TM'),
('TN'),
('TO'),
('TR'),
('TT'),
('TV'),
('TW'),
('TZ'),
('UA'),
('UG'),
('UM'),
('US'),
('UY'),
('UZ'),
('VA'),
('VC'),
('VE'),
('VG'),
('VI'),
('VN'),
('VU'),
('WF'),
('WS'),
('YE'),
('YT'),
('ZA'),
('ZM'),
('ZW');

-- --------------------------------------------------------

--
-- Table structure for table `tiekejas`
--

CREATE TABLE `tiekejas` (
  `ID` int(11) NOT NULL,
  `Pavadinimas` varchar(255) NOT NULL,
  `Adresas` varchar(255) NOT NULL,
  `Kontaktai` varchar(255) NOT NULL,
  `Slaptazodis` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tiekejas`
--

INSERT INTO `tiekejas` (`ID`, `Pavadinimas`, `Adresas`, `Kontaktai`, `Slaptazodis`) VALUES
(1, 'EcoTrade UAB', 'Miško g. 10, Vilnius', 'kontaktai@ecotrade.lt', '$2y$10$QtD5zG5GKft/sBFEVnfHDepxhTyjDUrwbuJmpkaUtkzGMvzE5cYNm'),
(3, 'GreenWood Ltd.', 'Medžių al. 5, Kaunas', 'info@greenwood.lt', '$2y$10$eekZzze7t.d.CBAXgh3IfeGacqSKwkTIgjmKMQ2RiVG6BcZxcA8Hq');

-- --------------------------------------------------------

--
-- Table structure for table `vartotojas`
--

CREATE TABLE `vartotojas` (
  `ID` int(11) NOT NULL,
  `Vardas` varchar(100) NOT NULL,
  `El_pastas` varchar(255) NOT NULL,
  `Slaptazodis` varchar(255) NOT NULL,
  `Role` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vartotojas`
--

INSERT INTO `vartotojas` (`ID`, `Vardas`, `El_pastas`, `Slaptazodis`, `Role`) VALUES
(1, 'Sistemos administratorius', 'admin@eudr.local', '$2y$10$VMpxRXvaK.lqjXzI9bgVwOdU3rgZcbUK7WuynuvEfMGlXc76axDNG', 'admin'),
(2, 'Agnė Vaitkutė', 'agne@example.com', '$2y$10$lW0eKKMnMWoSZ85soeekle0ydoZ4UBESVEDjUewzwUb169/V6MF92', 'naudotojas'),
(6, 'Marius Marius', 'marius@example.com', '$2y$10$6Bq4PjK6RzrE51UtniplnOeTwexn9Ce2mNGTqtKzmBUgQETofcqUi', 'inspektorius');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ataskaita`
--
ALTER TABLE `ataskaita`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `idx_ataskaita_produktas` (`ProduktasID`),
  ADD KEY `idx_ataskaita_vartotojas` (`VartotojasID`);

--
-- Indexes for table `atitiktiespatikra`
--
ALTER TABLE `atitiktiespatikra`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `idx_atitiktis_produktas` (`ProduktasID`),
  ADD KEY `idx_atitiktis_vartotojas` (`VartotojasID`);

--
-- Indexes for table `dd_statement`
--
ALTER TABLE `dd_statement`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `idx_dds_produktas` (`ProduktasID`),
  ADD KEY `idx_dds_vartotojas` (`VartotojasID`);

--
-- Indexes for table `kategoriju_sarasas`
--
ALTER TABLE `kategoriju_sarasas`
  ADD PRIMARY KEY (`Kategorija`);

--
-- Indexes for table `produktas`
--
ALTER TABLE `produktas`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `idx_produktas_tiekejas` (`TiekejasID`),
  ADD KEY `idx_produktas_salis` (`Salis`),
  ADD KEY `idx_produktas_kategorija` (`Kategorija`);

--
-- Indexes for table `saliu_sarasas`
--
ALTER TABLE `saliu_sarasas`
  ADD PRIMARY KEY (`salis`);

--
-- Indexes for table `tiekejas`
--
ALTER TABLE `tiekejas`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `uq_tiekejas_kontaktai` (`Kontaktai`);

--
-- Indexes for table `vartotojas`
--
ALTER TABLE `vartotojas`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `uq_vartotojas_email` (`El_pastas`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ataskaita`
--
ALTER TABLE `ataskaita`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `atitiktiespatikra`
--
ALTER TABLE `atitiktiespatikra`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `dd_statement`
--
ALTER TABLE `dd_statement`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `produktas`
--
ALTER TABLE `produktas`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `tiekejas`
--
ALTER TABLE `tiekejas`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `vartotojas`
--
ALTER TABLE `vartotojas`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ataskaita`
--
ALTER TABLE `ataskaita`
  ADD CONSTRAINT `fk_ataskaita_produktas` FOREIGN KEY (`ProduktasID`) REFERENCES `produktas` (`ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ataskaita_vartotojas` FOREIGN KEY (`VartotojasID`) REFERENCES `vartotojas` (`ID`) ON UPDATE CASCADE;

--
-- Constraints for table `atitiktiespatikra`
--
ALTER TABLE `atitiktiespatikra`
  ADD CONSTRAINT `fk_atitiktis_produktas` FOREIGN KEY (`ProduktasID`) REFERENCES `produktas` (`ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_atitiktis_vartotojas` FOREIGN KEY (`VartotojasID`) REFERENCES `vartotojas` (`ID`) ON UPDATE CASCADE;

--
-- Constraints for table `dd_statement`
--
ALTER TABLE `dd_statement`
  ADD CONSTRAINT `fk_dds_produktas` FOREIGN KEY (`ProduktasID`) REFERENCES `produktas` (`ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_dds_vartotojas` FOREIGN KEY (`VartotojasID`) REFERENCES `vartotojas` (`ID`) ON UPDATE CASCADE;

--
-- Constraints for table `produktas`
--
ALTER TABLE `produktas`
  ADD CONSTRAINT `fk_produktas_kategorija` FOREIGN KEY (`Kategorija`) REFERENCES `kategoriju_sarasas` (`Kategorija`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_produktas_salis` FOREIGN KEY (`Salis`) REFERENCES `saliu_sarasas` (`salis`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_produktas_tiekejas` FOREIGN KEY (`TiekejasID`) REFERENCES `tiekejas` (`ID`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

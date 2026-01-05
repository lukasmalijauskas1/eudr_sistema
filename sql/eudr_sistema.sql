-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 05, 2026 at 02:03 PM
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
  `Slaptazodis` varchar(255) NOT NULL,
  `twofa_enabled` tinyint(1) NOT NULL DEFAULT 1,
  `twofa_secret` varchar(64) DEFAULT NULL,
  `twofa_confirmed` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vartotojas`
--

CREATE TABLE `vartotojas` (
  `ID` int(11) NOT NULL,
  `Vardas` varchar(100) NOT NULL,
  `El_pastas` varchar(255) NOT NULL,
  `Slaptazodis` varchar(255) NOT NULL,
  `Role` varchar(50) NOT NULL,
  `twofa_enabled` tinyint(1) NOT NULL DEFAULT 1,
  `twofa_secret` varchar(64) DEFAULT NULL,
  `twofa_confirmed` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vartotojas`
--

INSERT INTO `vartotojas` (`ID`, `Vardas`, `El_pastas`, `Slaptazodis`, `Role`, `twofa_enabled`, `twofa_secret`, `twofa_confirmed`) VALUES
(1, 'Sistemos administratorius', 'admin@eudr.local', '$2y$10$VMpxRXvaK.lqjXzI9bgVwOdU3rgZcbUK7WuynuvEfMGlXc76axDNG', 'admin', 1, 'EPIC5LDLJKROQO3OYXNMBRZY4WIT7XIB', 1);

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
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `atitiktiespatikra`
--
ALTER TABLE `atitiktiespatikra`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `dd_statement`
--
ALTER TABLE `dd_statement`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `produktas`
--
ALTER TABLE `produktas`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=197;

--
-- AUTO_INCREMENT for table `tiekejas`
--
ALTER TABLE `tiekejas`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `vartotojas`
--
ALTER TABLE `vartotojas`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

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

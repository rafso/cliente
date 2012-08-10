-- phpMyAdmin SQL Dump
-- version 3.4.9
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tempo de Geração: 18/03/2012 às 15h11min
-- Versão do Servidor: 5.1.61
-- Versão do PHP: 5.2.9

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Banco de Dados: `tescom_doli322`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_accountingaccount`
--

CREATE TABLE IF NOT EXISTS `llx_accountingaccount` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_pcg_version` varchar(12) NOT NULL,
  `pcg_type` varchar(20) NOT NULL,
  `pcg_subtype` varchar(20) NOT NULL,
  `account_number` varchar(20) NOT NULL,
  `account_parent` varchar(20) DEFAULT NULL,
  `label` varchar(128) NOT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_accountingaccount_fk_pcg_version` (`fk_pcg_version`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=103 ;

--
-- Extraindo dados da tabela `llx_accountingaccount`
--

INSERT INTO `llx_accountingaccount` (`rowid`, `fk_pcg_version`, `pcg_type`, `pcg_subtype`, `account_number`, `account_parent`, `label`) VALUES
(1, 'PCG99-ABREGE', 'CAPIT', 'CAPITAL', '101', '1', 'Capital'),
(2, 'PCG99-ABREGE', 'CAPIT', 'XXXXXX', '105', '1', 'Ecarts de réévaluation'),
(3, 'PCG99-ABREGE', 'CAPIT', 'XXXXXX', '1061', '1', 'Réserve légale'),
(4, 'PCG99-ABREGE', 'CAPIT', 'XXXXXX', '1063', '1', 'Réserves statutaires ou contractuelles'),
(5, 'PCG99-ABREGE', 'CAPIT', 'XXXXXX', '1064', '1', 'Réserves réglementées'),
(6, 'PCG99-ABREGE', 'CAPIT', 'XXXXXX', '1068', '1', 'Autres réserves'),
(7, 'PCG99-ABREGE', 'CAPIT', 'XXXXXX', '108', '1', 'Compte de l''exploitant'),
(8, 'PCG99-ABREGE', 'CAPIT', 'XXXXXX', '12', '1', 'Résultat de l''exercice'),
(9, 'PCG99-ABREGE', 'CAPIT', 'XXXXXX', '145', '1', 'Amortissements dérogatoires'),
(10, 'PCG99-ABREGE', 'CAPIT', 'XXXXXX', '146', '1', 'Provision spéciale de réévaluation'),
(11, 'PCG99-ABREGE', 'CAPIT', 'XXXXXX', '147', '1', 'Plus-values réinvesties'),
(12, 'PCG99-ABREGE', 'CAPIT', 'XXXXXX', '148', '1', 'Autres provisions réglementées'),
(13, 'PCG99-ABREGE', 'CAPIT', 'XXXXXX', '15', '1', 'Provisions pour risques et charges'),
(14, 'PCG99-ABREGE', 'CAPIT', 'XXXXXX', '16', '1', 'Emprunts et dettes assimilees'),
(15, 'PCG99-ABREGE', 'IMMO', 'XXXXXX', '20', '2', 'Immobilisations incorporelles'),
(16, 'PCG99-ABREGE', 'IMMO', 'XXXXXX', '201', '20', 'Frais d''établissement'),
(17, 'PCG99-ABREGE', 'IMMO', 'XXXXXX', '206', '20', 'Droit au bail'),
(18, 'PCG99-ABREGE', 'IMMO', 'XXXXXX', '207', '20', 'Fonds commercial'),
(19, 'PCG99-ABREGE', 'IMMO', 'XXXXXX', '208', '20', 'Autres immobilisations incorporelles'),
(20, 'PCG99-ABREGE', 'IMMO', 'XXXXXX', '21', '2', 'Immobilisations corporelles'),
(21, 'PCG99-ABREGE', 'IMMO', 'XXXXXX', '23', '2', 'Immobilisations en cours'),
(22, 'PCG99-ABREGE', 'IMMO', 'XXXXXX', '27', '2', 'Autres immobilisations financieres'),
(23, 'PCG99-ABREGE', 'IMMO', 'XXXXXX', '280', '2', 'Amortissements des immobilisations incorporelles'),
(24, 'PCG99-ABREGE', 'IMMO', 'XXXXXX', '281', '2', 'Amortissements des immobilisations corporelles'),
(25, 'PCG99-ABREGE', 'IMMO', 'XXXXXX', '290', '2', 'Provisions pour dépréciation des immobilisations incorporelles'),
(26, 'PCG99-ABREGE', 'IMMO', 'XXXXXX', '291', '2', 'Provisions pour dépréciation des immobilisations corporelles'),
(27, 'PCG99-ABREGE', 'IMMO', 'XXXXXX', '297', '2', 'Provisions pour dépréciation des autres immobilisations financières'),
(28, 'PCG99-ABREGE', 'STOCK', 'XXXXXX', '31', '3', 'Matieres premières'),
(29, 'PCG99-ABREGE', 'STOCK', 'XXXXXX', '32', '3', 'Autres approvisionnements'),
(30, 'PCG99-ABREGE', 'STOCK', 'XXXXXX', '33', '3', 'En-cours de production de biens'),
(31, 'PCG99-ABREGE', 'STOCK', 'XXXXXX', '34', '3', 'En-cours de production de services'),
(32, 'PCG99-ABREGE', 'STOCK', 'XXXXXX', '35', '3', 'Stocks de produits'),
(33, 'PCG99-ABREGE', 'STOCK', 'XXXXXX', '37', '3', 'Stocks de marchandises'),
(34, 'PCG99-ABREGE', 'STOCK', 'XXXXXX', '391', '3', 'Provisions pour dépréciation des matières premières'),
(35, 'PCG99-ABREGE', 'STOCK', 'XXXXXX', '392', '3', 'Provisions pour dépréciation des autres approvisionnements'),
(36, 'PCG99-ABREGE', 'STOCK', 'XXXXXX', '393', '3', 'Provisions pour dépréciation des en-cours de production de biens'),
(37, 'PCG99-ABREGE', 'STOCK', 'XXXXXX', '394', '3', 'Provisions pour dépréciation des en-cours de production de services'),
(38, 'PCG99-ABREGE', 'STOCK', 'XXXXXX', '395', '3', 'Provisions pour dépréciation des stocks de produits'),
(39, 'PCG99-ABREGE', 'STOCK', 'XXXXXX', '397', '3', 'Provisions pour dépréciation des stocks de marchandises'),
(40, 'PCG99-ABREGE', 'TIERS', 'SUPPLIER', '400', '4', 'Fournisseurs et Comptes rattachés'),
(41, 'PCG99-ABREGE', 'TIERS', 'XXXXXX', '409', '4', 'Fournisseurs débiteurs'),
(42, 'PCG99-ABREGE', 'TIERS', 'CUSTOMER', '410', '4', 'Clients et Comptes rattachés'),
(43, 'PCG99-ABREGE', 'TIERS', 'XXXXXX', '419', '4', 'Clients créditeurs'),
(44, 'PCG99-ABREGE', 'TIERS', 'XXXXXX', '421', '4', 'Personnel'),
(45, 'PCG99-ABREGE', 'TIERS', 'XXXXXX', '428', '4', 'Personnel'),
(46, 'PCG99-ABREGE', 'TIERS', 'XXXXXX', '43', '4', 'Sécurité sociale et autres organismes sociaux'),
(47, 'PCG99-ABREGE', 'TIERS', 'XXXXXX', '444', '4', 'Etat - impôts sur bénéfice'),
(48, 'PCG99-ABREGE', 'TIERS', 'XXXXXX', '445', '4', 'Etat - Taxes sur chiffre affaire'),
(49, 'PCG99-ABREGE', 'TIERS', 'XXXXXX', '447', '4', 'Autres impôts, taxes et versements assimilés'),
(50, 'PCG99-ABREGE', 'TIERS', 'XXXXXX', '45', '4', 'Groupe et associes'),
(51, 'PCG99-ABREGE', 'TIERS', 'XXXXXX', '455', '45', 'Associés'),
(52, 'PCG99-ABREGE', 'TIERS', 'XXXXXX', '46', '4', 'Débiteurs divers et créditeurs divers'),
(53, 'PCG99-ABREGE', 'TIERS', 'XXXXXX', '47', '4', 'Comptes transitoires ou d''attente'),
(54, 'PCG99-ABREGE', 'TIERS', 'XXXXXX', '481', '4', 'Charges à répartir sur plusieurs exercices'),
(55, 'PCG99-ABREGE', 'TIERS', 'XXXXXX', '486', '4', 'Charges constatées d''avance'),
(56, 'PCG99-ABREGE', 'TIERS', 'XXXXXX', '487', '4', 'Produits constatés d''avance'),
(57, 'PCG99-ABREGE', 'TIERS', 'XXXXXX', '491', '4', 'Provisions pour dépréciation des comptes de clients'),
(58, 'PCG99-ABREGE', 'TIERS', 'XXXXXX', '496', '4', 'Provisions pour dépréciation des comptes de débiteurs divers'),
(59, 'PCG99-ABREGE', 'FINAN', 'XXXXXX', '50', '5', 'Valeurs mobilières de placement'),
(60, 'PCG99-ABREGE', 'FINAN', 'BANK', '51', '5', 'Banques, établissements financiers et assimilés'),
(61, 'PCG99-ABREGE', 'FINAN', 'CASH', '53', '5', 'Caisse'),
(62, 'PCG99-ABREGE', 'FINAN', 'XXXXXX', '54', '5', 'Régies d''avance et accréditifs'),
(63, 'PCG99-ABREGE', 'FINAN', 'XXXXXX', '58', '5', 'Virements internes'),
(64, 'PCG99-ABREGE', 'FINAN', 'XXXXXX', '590', '5', 'Provisions pour dépréciation des valeurs mobilières de placement'),
(65, 'PCG99-ABREGE', 'CHARGE', 'PRODUCT', '60', '6', 'Achats'),
(66, 'PCG99-ABREGE', 'CHARGE', 'XXXXXX', '603', '60', 'Variations des stocks'),
(67, 'PCG99-ABREGE', 'CHARGE', 'SERVICE', '61', '6', 'Services extérieurs'),
(68, 'PCG99-ABREGE', 'CHARGE', 'XXXXXX', '62', '6', 'Autres services extérieurs'),
(69, 'PCG99-ABREGE', 'CHARGE', 'XXXXXX', '63', '6', 'Impôts, taxes et versements assimiles'),
(70, 'PCG99-ABREGE', 'CHARGE', 'XXXXXX', '641', '6', 'Rémunérations du personnel'),
(71, 'PCG99-ABREGE', 'CHARGE', 'XXXXXX', '644', '6', 'Rémunération du travail de l''exploitant'),
(72, 'PCG99-ABREGE', 'CHARGE', 'SOCIAL', '645', '6', 'Charges de sécurité sociale et de prévoyance'),
(73, 'PCG99-ABREGE', 'CHARGE', 'XXXXXX', '646', '6', 'Cotisations sociales personnelles de l''exploitant'),
(74, 'PCG99-ABREGE', 'CHARGE', 'XXXXXX', '65', '6', 'Autres charges de gestion courante'),
(75, 'PCG99-ABREGE', 'CHARGE', 'XXXXXX', '66', '6', 'Charges financières'),
(76, 'PCG99-ABREGE', 'CHARGE', 'XXXXXX', '67', '6', 'Charges exceptionnelles'),
(77, 'PCG99-ABREGE', 'CHARGE', 'XXXXXX', '681', '6', 'Dotations aux amortissements et aux provisions'),
(78, 'PCG99-ABREGE', 'CHARGE', 'XXXXXX', '686', '6', 'Dotations aux amortissements et aux provisions'),
(79, 'PCG99-ABREGE', 'CHARGE', 'XXXXXX', '687', '6', 'Dotations aux amortissements et aux provisions'),
(80, 'PCG99-ABREGE', 'CHARGE', 'XXXXXX', '691', '6', 'Participation des salariés aux résultats'),
(81, 'PCG99-ABREGE', 'CHARGE', 'XXXXXX', '695', '6', 'Impôts sur les bénéfices'),
(82, 'PCG99-ABREGE', 'CHARGE', 'XXXXXX', '697', '6', 'Imposition forfaitaire annuelle des sociétés'),
(83, 'PCG99-ABREGE', 'CHARGE', 'XXXXXX', '699', '6', 'Produits'),
(84, 'PCG99-ABREGE', 'PROD', 'PRODUCT', '701', '7', 'Ventes de produits finis'),
(85, 'PCG99-ABREGE', 'PROD', 'SERVICE', '706', '7', 'Prestations de services'),
(86, 'PCG99-ABREGE', 'PROD', 'PRODUCT', '707', '7', 'Ventes de marchandises'),
(87, 'PCG99-ABREGE', 'PROD', 'PRODUCT', '708', '7', 'Produits des activités annexes'),
(88, 'PCG99-ABREGE', 'PROD', 'XXXXXX', '709', '7', 'Rabais, remises et ristournes accordés par l''entreprise'),
(89, 'PCG99-ABREGE', 'PROD', 'XXXXXX', '713', '7', 'Variation des stocks'),
(90, 'PCG99-ABREGE', 'PROD', 'XXXXXX', '72', '7', 'Production immobilisée'),
(91, 'PCG99-ABREGE', 'PROD', 'XXXXXX', '73', '7', 'Produits nets partiels sur opérations à long terme'),
(92, 'PCG99-ABREGE', 'PROD', 'XXXXXX', '74', '7', 'Subventions d''exploitation'),
(93, 'PCG99-ABREGE', 'PROD', 'XXXXXX', '75', '7', 'Autres produits de gestion courante'),
(94, 'PCG99-ABREGE', 'PROD', 'XXXXXX', '753', '75', 'Jetons de présence et rémunérations d''administrateurs, gérants,...'),
(95, 'PCG99-ABREGE', 'PROD', 'XXXXXX', '754', '75', 'Ristournes perçues des coopératives'),
(96, 'PCG99-ABREGE', 'PROD', 'XXXXXX', '755', '75', 'Quotes-parts de résultat sur opérations faites en commun'),
(97, 'PCG99-ABREGE', 'PROD', 'XXXXXX', '76', '7', 'Produits financiers'),
(98, 'PCG99-ABREGE', 'PROD', 'XXXXXX', '77', '7', 'Produits exceptionnels'),
(99, 'PCG99-ABREGE', 'PROD', 'XXXXXX', '781', '7', 'Reprises sur amortissements et provisions'),
(100, 'PCG99-ABREGE', 'PROD', 'XXXXXX', '786', '7', 'Reprises sur provisions pour risques'),
(101, 'PCG99-ABREGE', 'PROD', 'XXXXXX', '787', '7', 'Reprises sur provisions'),
(102, 'PCG99-ABREGE', 'PROD', 'XXXXXX', '79', '7', 'Transferts de charges');

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_accountingdebcred`
--

CREATE TABLE IF NOT EXISTS `llx_accountingdebcred` (
  `fk_transaction` int(11) NOT NULL,
  `account_number` varchar(20) NOT NULL,
  `amount` double NOT NULL,
  `direction` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_accountingsystem`
--

CREATE TABLE IF NOT EXISTS `llx_accountingsystem` (
  `pcg_version` varchar(12) NOT NULL,
  `fk_pays` int(11) NOT NULL,
  `label` varchar(128) NOT NULL,
  `datec` varchar(12) NOT NULL,
  `fk_author` varchar(20) DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` smallint(6) DEFAULT '0',
  PRIMARY KEY (`pcg_version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `llx_accountingsystem`
--

INSERT INTO `llx_accountingsystem` (`pcg_version`, `fk_pays`, `label`, `datec`, `fk_author`, `tms`, `active`) VALUES
('PCG99-ABREGE', 1, 'The simple accountancy french plan', '2012-02-09', NULL, '2012-02-09 19:35:17', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_accountingtransaction`
--

CREATE TABLE IF NOT EXISTS `llx_accountingtransaction` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(128) NOT NULL,
  `datec` date NOT NULL,
  `fk_author` varchar(20) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_source` int(11) NOT NULL,
  `sourcetype` varchar(16) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_actioncomm`
--

CREATE TABLE IF NOT EXISTS `llx_actioncomm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `datep` datetime DEFAULT NULL,
  `datep2` datetime DEFAULT NULL,
  `datea` datetime DEFAULT NULL,
  `datea2` datetime DEFAULT NULL,
  `fk_action` int(11) DEFAULT NULL,
  `label` varchar(128) NOT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_mod` int(11) DEFAULT NULL,
  `fk_project` int(11) DEFAULT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `fk_contact` int(11) DEFAULT NULL,
  `fk_parent` int(11) NOT NULL DEFAULT '0',
  `fk_user_action` int(11) DEFAULT NULL,
  `fk_user_done` int(11) DEFAULT NULL,
  `priority` smallint(6) DEFAULT NULL,
  `fulldayevent` smallint(6) NOT NULL DEFAULT '0',
  `punctual` smallint(6) NOT NULL DEFAULT '1',
  `percent` smallint(6) NOT NULL DEFAULT '0',
  `location` varchar(128) DEFAULT NULL,
  `durationp` double DEFAULT NULL,
  `durationa` double DEFAULT NULL,
  `note` text,
  `fk_element` int(11) DEFAULT NULL,
  `elementtype` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_actioncomm_datea` (`datea`),
  KEY `idx_actioncomm_fk_soc` (`fk_soc`),
  KEY `idx_actioncomm_fk_contact` (`fk_contact`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Extraindo dados da tabela `llx_actioncomm`
--

INSERT INTO `llx_actioncomm` (`id`, `entity`, `datep`, `datep2`, `datea`, `datea2`, `fk_action`, `label`, `datec`, `tms`, `fk_user_author`, `fk_user_mod`, `fk_project`, `fk_soc`, `fk_contact`, `fk_parent`, `fk_user_action`, `fk_user_done`, `priority`, `fulldayevent`, `punctual`, `percent`, `location`, `durationp`, `durationa`, `note`, `fk_element`, `elementtype`) VALUES
(1, 1, '2012-02-09 21:05:18', '2012-02-09 21:05:18', NULL, NULL, 50, 'Empresa TESTE TESTE (TESTE) inserida em Dolibarr', '2012-02-09 21:05:18', '2012-02-09 23:05:18', 1, NULL, NULL, 1, NULL, 0, NULL, 1, 0, 0, 1, -1, '', NULL, NULL, 'Empresa TESTE TESTE (TESTE) inserida em Dolibarr\nAutor: rafso', 1, 'societe'),
(2, 1, '2012-02-09 21:26:14', '2012-02-09 21:26:14', NULL, NULL, 50, 'orçamento 000001-2012-02-09-001 validado em Dolibarr', '2012-02-09 21:26:14', '2012-02-09 23:26:14', 1, NULL, NULL, 1, NULL, 0, NULL, 1, 0, 0, 1, -1, '', NULL, NULL, 'orçamento 000001-2012-02-09-001 validado em Dolibarr\nAutor: rafso', 1, 'propal'),
(3, 1, '2012-02-09 21:52:40', '2012-02-09 21:52:40', NULL, NULL, 50, 'orçamento 000001-2012-02-09-001 validado em Dolibarr', '2012-02-09 21:52:40', '2012-02-09 23:52:40', 1, NULL, NULL, 1, NULL, 0, NULL, 1, 0, 0, 1, -1, '', NULL, NULL, 'orçamento 000001-2012-02-09-001 validado em Dolibarr\nAutor: rafso', 1, 'propal'),
(4, 1, '2012-02-09 21:57:34', '2012-02-09 21:57:34', NULL, NULL, 4, 'Envio Orçamento por Correio', '2012-02-09 21:57:34', '2012-02-09 23:57:34', 1, NULL, NULL, 1, NULL, 0, NULL, 1, 0, 0, 1, -1, '', NULL, NULL, 'Mail enviado por SuperAdmin <> Para rafsopd@gmail.com.\nAssunto do e-mail: Enviar Orçamento 000001-2012-02-09-001\nTexto utilizado no corpo da mensagem:\nAnexo segue proposta solicitada de codigo000001-2012-02-09-001\r\n\r\nCordialmente', 1, 'propal'),
(5, 1, '2012-02-12 09:03:47', '2012-02-12 09:03:47', NULL, NULL, 50, 'orçamento 000001-2012-02-09-001 validado em Dolibarr', '2012-02-12 09:03:47', '2012-02-12 11:03:47', 1, NULL, NULL, 1, NULL, 0, NULL, 1, 0, 0, 1, -1, '', NULL, NULL, 'orçamento 000001-2012-02-09-001 validado em Dolibarr\nAutor: rafso', 1, 'propal');

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_adherent`
--

CREATE TABLE IF NOT EXISTS `llx_adherent` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref_ext` varchar(30) DEFAULT NULL,
  `civilite` varchar(6) DEFAULT NULL,
  `nom` varchar(50) DEFAULT NULL,
  `prenom` varchar(50) DEFAULT NULL,
  `login` varchar(50) DEFAULT NULL,
  `pass` varchar(50) DEFAULT NULL,
  `fk_adherent_type` int(11) NOT NULL,
  `morphy` varchar(3) NOT NULL,
  `societe` varchar(50) DEFAULT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `adresse` text,
  `cp` varchar(30) DEFAULT NULL,
  `ville` varchar(50) DEFAULT NULL,
  `fk_departement` int(11) DEFAULT NULL,
  `pays` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `phone_perso` varchar(30) DEFAULT NULL,
  `phone_mobile` varchar(30) DEFAULT NULL,
  `naiss` date DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `statut` smallint(6) NOT NULL DEFAULT '0',
  `public` smallint(6) NOT NULL DEFAULT '0',
  `datefin` datetime DEFAULT NULL,
  `note` text,
  `datevalid` datetime DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_mod` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_adherent_login` (`login`,`entity`),
  UNIQUE KEY `uk_adherent_fk_soc` (`fk_soc`),
  KEY `idx_adherent_fk_adherent_type` (`fk_adherent_type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Extraindo dados da tabela `llx_adherent`
--

INSERT INTO `llx_adherent` (`rowid`, `entity`, `ref_ext`, `civilite`, `nom`, `prenom`, `login`, `pass`, `fk_adherent_type`, `morphy`, `societe`, `fk_soc`, `adresse`, `cp`, `ville`, `fk_departement`, `pays`, `email`, `phone`, `phone_perso`, `phone_mobile`, `naiss`, `photo`, `statut`, `public`, `datefin`, `note`, `datevalid`, `datec`, `tms`, `fk_user_author`, `fk_user_mod`, `fk_user_valid`, `import_key`) VALUES
(1, 1, NULL, 'MR', 'Kurtão', 'Wallner', 'kurt', 'kurt', 1, 'phy', 'Wallner engenharia', NULL, 'Teste', '30430430', NULL, 583, 25, 'email@kurt.com.br', '9999999999999', '999999999999999999', '999999999999', '2012-02-09', 'Logo16.jpg', 1, 0, NULL, NULL, '2012-02-09 20:53:07', '2012-02-09 20:52:24', '2012-02-09 22:54:35', 1, 1, 1, NULL),
(2, 1, NULL, 'MR', 'TESTE', 'TESTE', 'CLIENTE1', '6dg2b40c', 2, 'mor', 'TESTE', 1, 'TESTE', NULL, NULL, 583, 25, '', NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, '2012-02-09 21:05:03', '2012-02-09 21:04:48', '2012-02-09 23:21:28', 1, 1, 1, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_adherent_extrafields`
--

CREATE TABLE IF NOT EXISTS `llx_adherent_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_adherent_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_adherent_type`
--

CREATE TABLE IF NOT EXISTS `llx_adherent_type` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `statut` smallint(6) NOT NULL DEFAULT '0',
  `libelle` varchar(50) NOT NULL,
  `cotisation` varchar(3) NOT NULL DEFAULT 'yes',
  `vote` varchar(3) NOT NULL DEFAULT 'yes',
  `note` text,
  `mail_valid` text,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_adherent_type_libelle` (`libelle`,`entity`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Extraindo dados da tabela `llx_adherent_type`
--

INSERT INTO `llx_adherent_type` (`rowid`, `entity`, `tms`, `statut`, `libelle`, `cotisation`, `vote`, `note`, `mail_valid`) VALUES
(1, 1, '2012-02-09 22:50:29', 1, 'Funcionário', '1', '0', 'Funcionário da empresa', ''),
(2, 1, '2012-02-09 22:50:42', 1, 'Cliente', '1', '0', 'Cliente', ''),
(3, 1, '2012-02-09 22:50:58', 1, 'Fornecedor', '1', '0', 'Fornecedor', '');

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_bank`
--

CREATE TABLE IF NOT EXISTS `llx_bank` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `datec` datetime DEFAULT NULL,
  `datev` date DEFAULT NULL,
  `dateo` date DEFAULT NULL,
  `amount` double(24,8) NOT NULL DEFAULT '0.00000000',
  `label` varchar(255) DEFAULT NULL,
  `fk_account` int(11) DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_rappro` int(11) DEFAULT NULL,
  `fk_type` varchar(6) DEFAULT NULL,
  `num_releve` varchar(50) DEFAULT NULL,
  `num_chq` varchar(50) DEFAULT NULL,
  `rappro` tinyint(4) DEFAULT '0',
  `note` text,
  `fk_bordereau` int(11) DEFAULT '0',
  `banque` varchar(255) DEFAULT NULL,
  `emetteur` varchar(255) DEFAULT NULL,
  `author` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_bank_datev` (`datev`),
  KEY `idx_bank_dateo` (`dateo`),
  KEY `idx_bank_fk_account` (`fk_account`),
  KEY `idx_bank_rappro` (`rappro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_bank_account`
--

CREATE TABLE IF NOT EXISTS `llx_bank_account` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ref` varchar(12) NOT NULL,
  `label` varchar(30) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `bank` varchar(60) DEFAULT NULL,
  `code_banque` varchar(7) DEFAULT NULL,
  `code_guichet` varchar(6) DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL,
  `cle_rib` varchar(5) DEFAULT NULL,
  `bic` varchar(11) DEFAULT NULL,
  `iban_prefix` varchar(34) DEFAULT NULL,
  `country_iban` varchar(2) DEFAULT NULL,
  `cle_iban` varchar(2) DEFAULT NULL,
  `domiciliation` varchar(255) DEFAULT NULL,
  `fk_departement` int(11) DEFAULT NULL,
  `fk_pays` int(11) NOT NULL,
  `proprio` varchar(60) DEFAULT NULL,
  `adresse_proprio` varchar(255) DEFAULT NULL,
  `courant` smallint(6) NOT NULL DEFAULT '0',
  `clos` smallint(6) NOT NULL DEFAULT '0',
  `rappro` smallint(6) DEFAULT '1',
  `url` varchar(128) DEFAULT NULL,
  `account_number` varchar(8) DEFAULT NULL,
  `currency_code` varchar(3) NOT NULL,
  `min_allowed` int(11) DEFAULT '0',
  `min_desired` int(11) DEFAULT '0',
  `comment` text,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_bank_account_label` (`label`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_bank_categ`
--

CREATE TABLE IF NOT EXISTS `llx_bank_categ` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_bank_class`
--

CREATE TABLE IF NOT EXISTS `llx_bank_class` (
  `lineid` int(11) NOT NULL,
  `fk_categ` int(11) NOT NULL,
  UNIQUE KEY `uk_bank_class_lineid` (`lineid`,`fk_categ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_bank_url`
--

CREATE TABLE IF NOT EXISTS `llx_bank_url` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_bank` int(11) DEFAULT NULL,
  `url_id` int(11) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `type` varchar(20) NOT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_bank_url` (`fk_bank`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_bookmark`
--

CREATE TABLE IF NOT EXISTS `llx_bookmark` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_soc` int(11) DEFAULT NULL,
  `fk_user` int(11) NOT NULL,
  `dateb` datetime DEFAULT NULL,
  `url` varchar(128) NOT NULL,
  `target` varchar(16) DEFAULT NULL,
  `title` varchar(64) DEFAULT NULL,
  `favicon` varchar(24) DEFAULT NULL,
  `position` int(11) DEFAULT '0',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_bookmark_url` (`fk_user`,`url`),
  UNIQUE KEY `uk_bookmark_title` (`fk_user`,`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_bordereau_cheque`
--

CREATE TABLE IF NOT EXISTS `llx_bordereau_cheque` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `datec` datetime NOT NULL,
  `date_bordereau` date DEFAULT NULL,
  `number` varchar(16) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `amount` double(24,8) NOT NULL,
  `nbcheque` smallint(6) NOT NULL,
  `fk_bank_account` int(11) DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `note` text,
  `statut` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_bordereau_cheque` (`number`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_boxes`
--

CREATE TABLE IF NOT EXISTS `llx_boxes` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `box_id` int(11) NOT NULL,
  `position` smallint(6) NOT NULL,
  `box_order` varchar(3) NOT NULL,
  `fk_user` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_boxes` (`box_id`,`position`,`fk_user`),
  KEY `idx_boxes_boxid` (`box_id`),
  KEY `idx_boxes_fk_user` (`fk_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_boxes_def`
--

CREATE TABLE IF NOT EXISTS `llx_boxes_def` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `file` varchar(200) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `note` varchar(130) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_boxes_def` (`file`,`entity`,`note`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=25 ;

--
-- Extraindo dados da tabela `llx_boxes_def`
--

INSERT INTO `llx_boxes_def` (`rowid`, `file`, `entity`, `tms`, `note`) VALUES
(1, 'box_clients.php', 1, '2012-02-09 22:02:53', NULL),
(2, 'box_prospect.php', 1, '2012-02-09 22:02:53', NULL),
(3, 'box_contacts.php', 1, '2012-02-09 22:02:53', NULL),
(4, 'box_propales.php', 1, '2012-02-09 22:03:06', NULL),
(6, 'box_contracts.php', 1, '2012-02-09 22:05:23', NULL),
(7, 'box_services_vendus.php', 1, '2012-02-09 22:05:23', NULL),
(8, 'box_commandes.php', 1, '2012-02-09 22:05:34', NULL),
(15, 'box_members.php', 1, '2012-02-09 22:22:32', NULL),
(16, 'box_fournisseurs.php', 1, '2012-02-09 22:22:37', NULL),
(17, 'box_factures_fourn_imp.php', 1, '2012-02-09 22:22:37', NULL),
(18, 'box_factures_fourn.php', 1, '2012-02-09 22:22:37', NULL),
(19, 'box_actions.php', 1, '2012-02-09 22:25:45', NULL),
(21, 'box_comptes.php', 1, '2012-02-12 11:15:57', NULL),
(22, 'box_factures_imp.php', 1, '2012-02-12 11:15:58', NULL),
(23, 'box_factures.php', 1, '2012-02-12 11:15:58', NULL),
(24, 'box_produits.php', 1, '2012-02-12 11:15:58', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_categorie`
--

CREATE TABLE IF NOT EXISTS `llx_categorie` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) DEFAULT NULL,
  `type` tinyint(4) NOT NULL DEFAULT '1',
  `entity` int(11) NOT NULL DEFAULT '1',
  `description` text,
  `fk_soc` int(11) DEFAULT NULL,
  `visible` tinyint(4) NOT NULL DEFAULT '1',
  `import_key` varchar(14) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_categorie_ref` (`label`,`type`,`entity`),
  KEY `idx_categorie_type` (`type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Extraindo dados da tabela `llx_categorie`
--

INSERT INTO `llx_categorie` (`rowid`, `label`, `type`, `entity`, `description`, `fk_soc`, `visible`, `import_key`) VALUES
(1, 'Jateamento', 0, 1, 'Produtos e servi&ccedil;os referente ao jateamento', NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_categorie_association`
--

CREATE TABLE IF NOT EXISTS `llx_categorie_association` (
  `fk_categorie_mere` int(11) NOT NULL,
  `fk_categorie_fille` int(11) NOT NULL,
  UNIQUE KEY `uk_categorie_association` (`fk_categorie_mere`,`fk_categorie_fille`),
  UNIQUE KEY `uk_categorie_association_fk_categorie_fille` (`fk_categorie_fille`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_categorie_fournisseur`
--

CREATE TABLE IF NOT EXISTS `llx_categorie_fournisseur` (
  `fk_categorie` int(11) NOT NULL,
  `fk_societe` int(11) NOT NULL,
  UNIQUE KEY `fk_categorie` (`fk_categorie`,`fk_societe`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_categorie_member`
--

CREATE TABLE IF NOT EXISTS `llx_categorie_member` (
  `fk_categorie` int(11) NOT NULL,
  `fk_member` int(11) NOT NULL,
  PRIMARY KEY (`fk_categorie`,`fk_member`),
  KEY `idx_categorie_member_fk_categorie` (`fk_categorie`),
  KEY `idx_categorie_member_fk_member` (`fk_member`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_categorie_product`
--

CREATE TABLE IF NOT EXISTS `llx_categorie_product` (
  `fk_categorie` int(11) NOT NULL,
  `fk_product` int(11) NOT NULL,
  PRIMARY KEY (`fk_categorie`,`fk_product`),
  KEY `idx_categorie_product_fk_categorie` (`fk_categorie`),
  KEY `idx_categorie_product_fk_product` (`fk_product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `llx_categorie_product`
--

INSERT INTO `llx_categorie_product` (`fk_categorie`, `fk_product`) VALUES
(1, 1),
(1, 3),
(1, 4);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_categorie_societe`
--

CREATE TABLE IF NOT EXISTS `llx_categorie_societe` (
  `fk_categorie` int(11) NOT NULL,
  `fk_societe` int(11) NOT NULL,
  PRIMARY KEY (`fk_categorie`,`fk_societe`),
  KEY `idx_categorie_societe_fk_categorie` (`fk_categorie`),
  KEY `idx_categorie_societe_fk_societe` (`fk_societe`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_chargesociales`
--

CREATE TABLE IF NOT EXISTS `llx_chargesociales` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `date_ech` datetime NOT NULL,
  `libelle` varchar(80) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `fk_type` int(11) NOT NULL,
  `amount` double NOT NULL DEFAULT '0',
  `paye` smallint(6) NOT NULL DEFAULT '0',
  `periode` date DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_commande`
--

CREATE TABLE IF NOT EXISTS `llx_commande` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(30) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref_ext` varchar(50) DEFAULT NULL,
  `ref_int` varchar(50) DEFAULT NULL,
  `ref_client` varchar(50) DEFAULT NULL,
  `fk_soc` int(11) NOT NULL,
  `fk_projet` int(11) DEFAULT '0',
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `date_creation` datetime DEFAULT NULL,
  `date_valid` datetime DEFAULT NULL,
  `date_cloture` datetime DEFAULT NULL,
  `date_commande` date DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_user_cloture` int(11) DEFAULT NULL,
  `source` smallint(6) DEFAULT NULL,
  `fk_statut` smallint(6) DEFAULT '0',
  `amount_ht` double DEFAULT '0',
  `remise_percent` double DEFAULT '0',
  `remise_absolue` double DEFAULT '0',
  `remise` double DEFAULT '0',
  `tva` double(24,8) DEFAULT '0.00000000',
  `localtax1` double(24,8) DEFAULT '0.00000000',
  `localtax2` double(24,8) DEFAULT '0.00000000',
  `total_ht` double(24,8) DEFAULT '0.00000000',
  `total_ttc` double(24,8) DEFAULT '0.00000000',
  `note` text,
  `note_public` text,
  `model_pdf` varchar(255) DEFAULT NULL,
  `facture` tinyint(4) DEFAULT '0',
  `fk_cond_reglement` int(11) DEFAULT NULL,
  `fk_mode_reglement` int(11) DEFAULT NULL,
  `date_livraison` date DEFAULT NULL,
  `fk_availability` int(11) DEFAULT NULL,
  `fk_demand_reason` int(11) DEFAULT NULL,
  `fk_adresse_livraison` int(11) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_commande_ref` (`ref`,`entity`),
  KEY `idx_commande_fk_soc` (`fk_soc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_commandedet`
--

CREATE TABLE IF NOT EXISTS `llx_commandedet` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_commande` int(11) NOT NULL,
  `fk_parent_line` int(11) DEFAULT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `description` text,
  `tva_tx` double(6,3) DEFAULT NULL,
  `localtax1_tx` double(6,3) DEFAULT NULL,
  `localtax2_tx` double(6,3) DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `remise_percent` double DEFAULT '0',
  `remise` double DEFAULT '0',
  `fk_remise_except` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `subprice` double(24,8) DEFAULT '0.00000000',
  `total_ht` double(24,8) DEFAULT '0.00000000',
  `total_tva` double(24,8) DEFAULT '0.00000000',
  `total_localtax1` double(24,8) DEFAULT '0.00000000',
  `total_localtax2` double(24,8) DEFAULT '0.00000000',
  `total_ttc` double(24,8) DEFAULT '0.00000000',
  `product_type` int(11) DEFAULT '0',
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `info_bits` int(11) DEFAULT '0',
  `marge_tx` double(6,3) DEFAULT '0.000',
  `marque_tx` double(6,3) DEFAULT '0.000',
  `special_code` int(10) unsigned DEFAULT '0',
  `rang` int(11) DEFAULT '0',
  `import_key` varchar(14) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_commandedet_fk_commande` (`fk_commande`),
  KEY `idx_commandedet_fk_product` (`fk_product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_commande_fournisseur`
--

CREATE TABLE IF NOT EXISTS `llx_commande_fournisseur` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(30) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref_ext` varchar(30) DEFAULT NULL,
  `ref_supplier` varchar(30) DEFAULT NULL,
  `fk_soc` int(11) NOT NULL,
  `fk_projet` int(11) DEFAULT '0',
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `date_creation` datetime DEFAULT NULL,
  `date_valid` datetime DEFAULT NULL,
  `date_cloture` datetime DEFAULT NULL,
  `date_commande` date DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_user_cloture` int(11) DEFAULT NULL,
  `source` smallint(6) NOT NULL,
  `fk_statut` smallint(6) DEFAULT '0',
  `amount_ht` double DEFAULT '0',
  `remise_percent` double DEFAULT '0',
  `remise` double DEFAULT '0',
  `tva` double(24,8) DEFAULT '0.00000000',
  `localtax1` double(24,8) DEFAULT '0.00000000',
  `localtax2` double(24,8) DEFAULT '0.00000000',
  `total_ht` double(24,8) DEFAULT '0.00000000',
  `total_ttc` double(24,8) DEFAULT '0.00000000',
  `note` text,
  `note_public` text,
  `model_pdf` varchar(255) DEFAULT NULL,
  `fk_cond_reglement` int(11) DEFAULT NULL,
  `fk_mode_reglement` int(11) DEFAULT NULL,
  `fk_methode_commande` int(11) DEFAULT '0',
  `import_key` varchar(14) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_commande_fournisseur_ref` (`ref`,`fk_soc`,`entity`),
  KEY `idx_commande_fournisseur_fk_soc` (`fk_soc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_commande_fournisseurdet`
--

CREATE TABLE IF NOT EXISTS `llx_commande_fournisseurdet` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_commande` int(11) NOT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `ref` varchar(50) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `description` text,
  `tva_tx` double(6,3) DEFAULT '0.000',
  `localtax1_tx` double(6,3) DEFAULT '0.000',
  `localtax2_tx` double(6,3) DEFAULT '0.000',
  `qty` double DEFAULT NULL,
  `remise_percent` double DEFAULT '0',
  `remise` double DEFAULT '0',
  `subprice` double(24,8) DEFAULT '0.00000000',
  `total_ht` double(24,8) DEFAULT '0.00000000',
  `total_tva` double(24,8) DEFAULT '0.00000000',
  `total_localtax1` double(24,8) DEFAULT '0.00000000',
  `total_localtax2` double(24,8) DEFAULT '0.00000000',
  `total_ttc` double(24,8) DEFAULT '0.00000000',
  `product_type` int(11) DEFAULT '0',
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `info_bits` int(11) DEFAULT '0',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_commande_fournisseur_dispatch`
--

CREATE TABLE IF NOT EXISTS `llx_commande_fournisseur_dispatch` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_commande` int(11) DEFAULT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `qty` float DEFAULT NULL,
  `fk_entrepot` int(11) DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_commande_fournisseur_dispatch_fk_commande` (`fk_commande`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_commande_fournisseur_log`
--

CREATE TABLE IF NOT EXISTS `llx_commande_fournisseur_log` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datelog` datetime NOT NULL,
  `fk_commande` int(11) NOT NULL,
  `fk_statut` smallint(6) NOT NULL,
  `fk_user` int(11) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_compta`
--

CREATE TABLE IF NOT EXISTS `llx_compta` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `datec` datetime DEFAULT NULL,
  `datev` date DEFAULT NULL,
  `amount` double NOT NULL DEFAULT '0',
  `label` varchar(255) DEFAULT NULL,
  `fk_compta_account` int(11) DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `valid` tinyint(4) DEFAULT '0',
  `note` text,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_compta_account`
--

CREATE TABLE IF NOT EXISTS `llx_compta_account` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `datec` datetime DEFAULT NULL,
  `number` varchar(12) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `note` text,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_compta_compte_generaux`
--

CREATE TABLE IF NOT EXISTS `llx_compta_compte_generaux` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `date_creation` datetime DEFAULT NULL,
  `numero` varchar(50) DEFAULT NULL,
  `intitule` varchar(255) DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `note` text,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `numero` (`numero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_const`
--

CREATE TABLE IF NOT EXISTS `llx_const` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `value` text NOT NULL,
  `type` varchar(6) DEFAULT NULL,
  `visible` tinyint(4) NOT NULL DEFAULT '1',
  `note` text,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_const` (`name`,`entity`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=260 ;

--
-- Extraindo dados da tabela `llx_const`
--

INSERT INTO `llx_const` (`rowid`, `name`, `entity`, `value`, `type`, `visible`, `note`, `tms`) VALUES
(2, 'MAIN_FEATURES_LEVEL', 0, '0', 'chaine', 1, 'Level of features to show (0=stable only, 1=stable+experimental, 2=stable+experimental+development', '2012-02-09 19:35:17'),
(3, 'SYSLOG_FILE', 0, 'DOL_DATA_ROOT/dolibarr.log', 'chaine', 0, 'Directory where to write log file', '2012-02-09 19:35:17'),
(4, 'SYSLOG_LEVEL', 0, '7', 'chaine', 0, 'Level of debug info to show', '2012-02-09 19:35:17'),
(5, 'MAIN_MAIL_SMTP_SERVER', 0, '', 'chaine', 0, 'Host or ip address for SMTP server', '2012-02-09 19:35:17'),
(6, 'MAIN_MAIL_SMTP_PORT', 0, '', 'chaine', 0, 'Port for SMTP server', '2012-02-09 19:35:17'),
(7, 'MAIN_UPLOAD_DOC', 0, '2048', 'chaine', 0, 'Max size for file upload (0 means no upload allowed)', '2012-02-09 19:35:17'),
(9, 'MAIN_MAIL_EMAIL_FROM', 1, 'dolibarr-robot@domain.com', 'chaine', 0, 'EMail emetteur pour les emails automatiques Dolibarr', '2012-02-09 19:35:17'),
(10, 'MAIN_SIZE_LISTE_LIMIT', 0, '25', 'chaine', 0, 'Longueur maximum des listes', '2012-02-09 19:35:17'),
(11, 'MAIN_SHOW_WORKBOARD', 0, '1', 'yesno', 0, 'Affichage tableau de bord de travail Dolibarr', '2012-02-09 19:35:17'),
(12, 'MAIN_MENU_STANDARD', 1, 'eldy_backoffice.php', 'chaine', 0, 'Module de gestion de la barre de menu pour utilisateurs internes', '2012-02-09 19:35:17'),
(13, 'MAIN_MENUFRONT_STANDARD', 1, 'eldy_frontoffice.php', 'chaine', 0, 'Module de gestion de la barre de menu pour utilisateurs externes', '2012-02-09 19:35:17'),
(14, 'MAIN_MENU_SMARTPHONE', 1, 'eldy_backoffice.php', 'chaine', 0, 'Module de gestion de la barre de menu smartphone pour utilisateurs internes', '2012-02-09 19:35:17'),
(15, 'MAIN_MENUFRONT_SMARTPHONE', 1, 'eldy_frontoffice.php', 'chaine', 0, 'Module de gestion de la barre de menu smartphone pour utilisateurs externes', '2012-02-09 19:35:17'),
(17, 'MAIN_DELAY_ACTIONS_TODO', 1, '7', 'chaine', 0, 'Tolérance de retard avant alerte (en jours) sur actions planifiées non réalisées', '2012-02-09 19:35:17'),
(18, 'MAIN_DELAY_ORDERS_TO_PROCESS', 1, '2', 'chaine', 0, 'Tolérance de retard avant alerte (en jours) sur commandes clients non traitées', '2012-02-09 19:35:17'),
(19, 'MAIN_DELAY_SUPPLIER_ORDERS_TO_PROCESS', 1, '7', 'chaine', 0, 'Tolérance de retard avant alerte (en jours) sur commandes fournisseurs non traitées', '2012-02-09 19:35:17'),
(20, 'MAIN_DELAY_PROPALS_TO_CLOSE', 1, '31', 'chaine', 0, 'Tolérance de retard avant alerte (en jours) sur propales à cloturer', '2012-02-09 19:35:17'),
(21, 'MAIN_DELAY_PROPALS_TO_BILL', 1, '7', 'chaine', 0, 'Tolérance de retard avant alerte (en jours) sur propales non facturées', '2012-02-09 19:35:17'),
(22, 'MAIN_DELAY_CUSTOMER_BILLS_UNPAYED', 1, '31', 'chaine', 0, 'Tolérance de retard avant alerte (en jours) sur factures client impayées', '2012-02-09 19:35:17'),
(23, 'MAIN_DELAY_SUPPLIER_BILLS_TO_PAY', 1, '2', 'chaine', 0, 'Tolérance de retard avant alerte (en jours) sur factures fournisseur impayées', '2012-02-09 19:35:17'),
(24, 'MAIN_DELAY_NOT_ACTIVATED_SERVICES', 1, '0', 'chaine', 0, 'Tolérance de retard avant alerte (en jours) sur services à activer', '2012-02-09 19:35:17'),
(25, 'MAIN_DELAY_RUNNING_SERVICES', 1, '0', 'chaine', 0, 'Tolérance de retard avant alerte (en jours) sur services expirés', '2012-02-09 19:35:17'),
(26, 'MAIN_DELAY_MEMBERS', 1, '31', 'chaine', 0, 'Tolérance de retard avant alerte (en jours) sur cotisations adhérent en retard', '2012-02-09 19:35:17'),
(27, 'MAIN_DELAY_TRANSACTIONS_TO_CONCILIATE', 1, '62', 'chaine', 0, 'Tolérance de retard avant alerte (en jours) sur rapprochements bancaires à faire', '2012-02-09 19:35:17'),
(28, 'SOCIETE_NOLIST_COURRIER', 0, '1', 'yesno', 0, 'Liste les fichiers du repertoire courrier', '2012-02-09 19:35:17'),
(31, 'MAILING_EMAIL_FROM', 1, 'dolibarr@domain.com', 'chaine', 0, 'EMail emmetteur pour les envois d emailings', '2012-02-09 19:35:17'),
(32, 'MAIN_MODULE_USER', 0, '1', NULL, 0, NULL, '2012-02-09 19:35:17'),
(33, 'MAIN_VERSION_LAST_INSTALL', 0, '3.1.0', 'chaine', 0, 'Dolibarr version when install', '2012-02-09 19:35:17'),
(55, 'MAIN_UPLOAD_DOC', 1, '5048', 'chaine', 0, '', '2012-02-09 21:49:37'),
(56, 'DATABASE_PWD_ENCRYPTED', 1, '1', 'chaine', 0, '', '2012-02-09 21:50:45'),
(57, 'MAIN_LOGEVENTS_USER_LOGIN', 1, '1', 'chaine', 0, '', '2012-02-09 21:51:25'),
(58, 'MAIN_LOGEVENTS_USER_LOGIN_FAILED', 1, '1', 'chaine', 0, '', '2012-02-09 21:51:25'),
(59, 'MAIN_LOGEVENTS_USER_MODIFY', 1, '1', 'chaine', 0, '', '2012-02-09 21:51:25'),
(60, 'MAIN_DISABLE_METEO', 1, '0', 'chaine', 0, '', '2012-02-09 21:53:09'),
(79, 'MAIN_LANG_DEFAULT', 1, 'auto', 'chaine', 0, '', '2012-02-09 21:59:31'),
(80, 'MAIN_MULTILANGS', 1, '0', 'chaine', 0, '', '2012-02-09 21:59:31'),
(81, 'MAIN_SIZE_LISTE_LIMIT', 1, '25', 'chaine', 0, '', '2012-02-09 21:59:31'),
(82, 'MAIN_DISABLE_JAVASCRIPT', 1, '0', 'chaine', 0, '', '2012-02-09 21:59:31'),
(83, 'MAIN_START_WEEK', 1, '1', 'chaine', 0, '', '2012-02-09 21:59:31'),
(84, 'MAIN_SHOW_LOGO', 1, '1', 'chaine', 0, '', '2012-02-09 21:59:31'),
(85, 'MAIN_FIRSTNAME_NAME_POSITION', 1, '0', 'chaine', 0, '', '2012-02-09 21:59:31'),
(86, 'MAIN_THEME', 1, 'cameleo', 'chaine', 0, '', '2012-02-09 21:59:31'),
(87, 'MAIN_SEARCHFORM_CONTACT', 1, '1', 'chaine', 0, '', '2012-02-09 21:59:31'),
(88, 'MAIN_SEARCHFORM_SOCIETE', 1, '1', 'chaine', 0, '', '2012-02-09 21:59:31'),
(89, 'MAIN_SEARCHFORM_PRODUITSERVICE', 1, '1', 'chaine', 0, '', '2012-02-09 21:59:31'),
(90, 'MAIN_SEARCHFORM_ADHERENT', 1, '0', 'chaine', 0, '', '2012-02-09 21:59:31'),
(91, 'MAIN_HELPCENTER_DISABLELINK', 0, '0', 'chaine', 0, '', '2012-02-09 21:59:31'),
(92, 'MAIN_HELP_DISABLELINK', 0, '0', 'chaine', 0, '', '2012-02-09 21:59:31'),
(93, 'MAIN_PROFID1_IN_ADDRESS', 1, '0', 'chaine', 0, '', '2012-02-09 21:59:31'),
(94, 'MAIN_PROFID2_IN_ADDRESS', 1, '0', 'chaine', 0, '', '2012-02-09 21:59:31'),
(95, 'MAIN_PROFID3_IN_ADDRESS', 1, '0', 'chaine', 0, '', '2012-02-09 21:59:31'),
(96, 'MAIN_PROFID4_IN_ADDRESS', 1, '0', 'chaine', 0, '', '2012-02-09 21:59:31'),
(102, 'MAIN_INFO_SOCIETE_LOGO', 1, 'logo_wallner_engenharia2.png', 'chaine', 0, '', '2012-02-09 22:00:44'),
(103, 'MAIN_INFO_SOCIETE_LOGO_SMALL', 1, 'logo_wallner_engenharia2_small.png', 'chaine', 0, '', '2012-02-09 22:00:44'),
(104, 'MAIN_INFO_SOCIETE_LOGO_MINI', 1, 'logo_wallner_engenharia2_mini.png', 'chaine', 0, '', '2012-02-09 22:00:44'),
(109, 'MAIN_INFO_SOCIETE_PAYS', 1, '25:PT:Brasil', 'chaine', 0, '', '2012-02-09 22:00:57'),
(110, 'MAIN_INFO_SOCIETE_NOM', 1, 'Engenharia Wallner', 'chaine', 0, '', '2012-02-09 22:00:57'),
(111, 'MAIN_INFO_SOCIETE_ADRESSE', 1, 'Teste', 'chaine', 0, '', '2012-02-09 22:00:57'),
(112, 'MAIN_INFO_SOCIETE_DEPARTEMENT', 1, '583', 'chaine', 0, '', '2012-02-09 22:00:57'),
(113, 'MAIN_MONNAIE', 1, 'BRL', 'chaine', 0, '', '2012-02-09 22:00:57'),
(114, 'MAIN_INFO_CAPITAL', 1, '1', 'chaine', 0, '', '2012-02-09 22:00:57'),
(115, 'MAIN_INFO_SOCIETE_FORME_JURIDIQUE', 1, '2000', 'chaine', 0, '', '2012-02-09 22:00:57'),
(116, 'SOCIETE_FISCAL_MONTH_START', 1, '1', 'chaine', 0, '', '2012-02-09 22:00:57'),
(117, 'FACTURE_TVAOPTION', 1, 'reel', 'chaine', 0, '', '2012-02-09 22:00:57'),
(119, 'COMPANY_ADDON_PDF_ODT_PATH', 1, 'DOL_DATA_ROOT/doctemplates/thirdparties', 'chaine', 0, NULL, '2012-02-09 22:02:53'),
(120, 'MAIN_MODULE_PROPALE', 1, '1', NULL, 0, NULL, '2012-02-09 22:03:06'),
(121, 'PROPALE_ADDON_PDF', 1, 'azur', 'chaine', 0, 'Nom du gestionnaire de generation des propales en PDF', '2012-02-09 22:03:06'),
(126, 'COMMANDE_ADDON_PDF', 1, 'einstein', 'chaine', 0, 'Nom du gestionnaire de generation des commandes en PDF', '2012-02-09 22:05:19'),
(127, 'COMMANDE_ADDON', 1, 'mod_commande_marbre', 'chaine', 0, 'Nom du gestionnaire de numerotation des commandes', '2012-02-09 22:05:19'),
(129, 'MAIN_MODULE_CONTRAT', 1, '1', NULL, 0, NULL, '2012-02-09 22:05:23'),
(130, 'CONTRACT_ADDON', 1, 'mod_contract_serpis', 'chaine', 0, 'Nom du gestionnaire de numerotation des contrats', '2012-02-09 22:05:23'),
(131, 'MAIN_MODULE_SERVICE', 1, '1', NULL, 0, NULL, '2012-02-09 22:05:23'),
(133, 'FICHEINTER_ADDON_PDF', 1, 'soleil', 'chaine', 0, NULL, '2012-02-09 22:05:29'),
(134, 'FICHEINTER_ADDON', 1, 'pacific', 'chaine', 0, NULL, '2012-02-09 22:05:29'),
(136, 'MAIN_MODULE_EXPEDITION', 1, '1', NULL, 0, NULL, '2012-02-09 22:05:34'),
(137, 'EXPEDITION_ADDON_PDF', 1, 'rouget', 'chaine', 0, 'Nom du gestionnaire de generation des bons expeditions en PDF', '2012-02-09 22:05:34'),
(138, 'EXPEDITION_ADDON', 1, 'elevement', 'chaine', 0, 'Nom du gestionnaire du type d''expedition', '2012-02-09 22:05:34'),
(139, 'LIVRAISON_ADDON_PDF', 1, 'typhon', 'chaine', 0, 'Nom du gestionnaire de generation des bons de reception en PDF', '2012-02-09 22:05:34'),
(140, 'LIVRAISON_ADDON', 1, 'mod_livraison_jade', 'chaine', 0, 'Nom du gestionnaire de numerotation des bons de reception', '2012-02-09 22:05:34'),
(141, 'EXPEDITION_ADDON_NUMBER', 1, 'mod_expedition_safor', 'chaine', 0, 'Nom du gestionnaire de numerotation des expeditions', '2012-02-09 22:05:34'),
(142, 'MAIN_MODULE_COMMANDE', 1, '1', NULL, 0, NULL, '2012-02-09 22:05:34'),
(144, 'COMPANY_ELEPHANT_MASK_CUSTOMER', 1, '{000000}', 'chaine', 0, '', '2012-02-09 22:06:52'),
(145, 'COMPANY_ELEPHANT_MASK_SUPPLIER', 1, '{000000}', 'chaine', 0, '', '2012-02-09 22:06:52'),
(146, 'SOCIETE_CODECLIENT_ADDON', 1, 'mod_codeclient_elephant', 'chaine', 0, '', '2012-02-09 22:06:56'),
(148, 'SOCIETE_CODECOMPTA_ADDON', 1, 'mod_codecompta_panicum', 'chaine', 0, '', '2012-02-09 22:07:48'),
(150, 'PROPALE_SAPHIR_MASK', 1, '{cccccc}-{yyyy}-{mm}-{dd}-{000}', 'chaine', 0, '', '2012-02-09 22:12:33'),
(151, 'PROPALE_ADDON', 1, 'mod_propale_saphir', 'chaine', 0, '', '2012-02-09 22:12:40'),
(154, 'MAIN_SUBMODULE_EXPEDITION', 1, '1', 'chaine', 0, '', '2012-02-09 22:20:05'),
(156, 'MAIN_MODULE_COMPTABILITE', 1, '1', NULL, 0, NULL, '2012-02-09 22:21:05'),
(158, 'FACTURE_ADDON_PDF', 1, 'crabe', 'chaine', 0, NULL, '2012-02-09 22:21:05'),
(159, 'FACTURE_ADDON', 1, 'terre', 'chaine', 0, NULL, '2012-02-09 22:21:05'),
(160, 'FACTURE_ADDON_PDF_ODT_PATH', 1, 'DOL_DATA_ROOT/doctemplates/invoices', 'chaine', 0, NULL, '2012-02-09 22:21:05'),
(163, 'MAIN_MODULE_TAX', 1, '1', NULL, 0, NULL, '2012-02-09 22:21:43'),
(164, 'MAIN_MODULE_PRELEVEMENT', 1, '1', NULL, 0, NULL, '2012-02-09 22:21:50'),
(168, 'MAIN_MODULE_DEPLACEMENT', 1, '1', NULL, 0, NULL, '2012-02-09 22:21:57'),
(169, 'MAIN_MODULE_ADHERENT', 1, '1', NULL, 0, NULL, '2012-02-09 22:22:32'),
(170, 'ADHERENT_MAIL_RESIL', 1, 'Votre adhésion vient d''être résiliée.\r\nNous espérons vous revoir très bientôt', 'texte', 0, 'Mail de résiliation', '2012-02-09 22:22:32'),
(171, 'ADHERENT_MAIL_VALID', 1, 'Votre adhésion vient d''être validée. \r\nVoici le rappel de vos coordonnées (toute information erronée entrainera la non validation de votre inscription) :\r\n\r\n%INFOS%\r\n\r\n', 'texte', 0, 'Mail de validation', '2012-02-09 22:22:32'),
(172, 'ADHERENT_MAIL_VALID_SUBJECT', 1, 'Votre adhésion a été validée', 'chaine', 0, 'Sujet du mail de validation', '2012-02-09 22:22:32'),
(173, 'ADHERENT_MAIL_RESIL_SUBJECT', 1, 'Résiliation de votre adhésion', 'chaine', 0, 'Sujet du mail de résiliation', '2012-02-09 22:22:32'),
(174, 'ADHERENT_MAILMAN_UNSUB_URL', 1, 'http://lists.domain.com/cgi-bin/mailman/admin/%LISTE%/members?adminpw=%MAILMAN_ADMINPW%&user=%EMAIL%', 'chaine', 0, 'Url de désinscription aux listes mailman', '2012-02-09 22:22:32'),
(175, 'ADHERENT_MAILMAN_URL', 1, 'http://lists.domain.com/cgi-bin/mailman/admin/%LISTE%/members?adminpw=%MAILMAN_ADMINPW%&send_welcome_msg_to_this_batch=1&subscribees=%EMAIL%', 'chaine', 0, 'Url pour les inscriptions mailman', '2012-02-09 22:22:32'),
(176, 'ADHERENT_MAILMAN_LISTS', 1, '', 'chaine', 0, 'Mailing-list to subscribe new members to', '2012-02-09 22:22:32'),
(177, 'ADHERENT_USE_SPIP_AUTO', 1, '', 'yesno', 0, 'Utilisation de SPIP automatiquement', '2012-02-09 22:22:32'),
(178, 'ADHERENT_SPIP_USER', 1, '', 'chaine', 0, 'Utilisateur de connexion à la base spip', '2012-02-09 22:22:32'),
(179, 'ADHERENT_SPIP_PASS', 1, '', 'chaine', 0, 'Mot de passe de connexion à la base spip', '2012-02-09 22:22:32'),
(180, 'ADHERENT_SPIP_SERVEUR', 1, '', 'chaine', 0, 'serveur spip', '2012-02-09 22:22:32'),
(181, 'ADHERENT_SPIP_DB', 1, '', 'chaine', 0, 'db spip', '2012-02-09 22:22:32'),
(182, 'ADHERENT_MAIL_FROM', 1, '', 'chaine', 0, 'From des mails', '2012-02-09 22:22:32'),
(183, 'ADHERENT_MAIL_COTIS', 1, 'Bonjour %PRENOM%,\r\nCet email confirme que votre cotisation a été reçue\r\net enregistrée', 'texte', 0, 'Mail de validation de cotisation', '2012-02-09 22:22:32'),
(184, 'ADHERENT_MAIL_COTIS_SUBJECT', 1, 'Reçu de votre cotisation', 'chaine', 0, 'Sujet du mail de validation de cotisation', '2012-02-09 22:22:32'),
(185, 'ADHERENT_CARD_HEADER_TEXT', 1, '%ANNEE%', 'chaine', 0, 'Texte imprimé sur le haut de la carte adhérent', '2012-02-09 22:22:32'),
(186, 'ADHERENT_CARD_FOOTER_TEXT', 1, 'Association AZERTY', 'chaine', 0, 'Texte imprimé sur le bas de la carte adhérent', '2012-02-09 22:22:32'),
(188, 'ADHERENT_MAILMAN_ADMINPW', 1, '', 'chaine', 0, 'Mot de passe Admin des liste mailman', '2012-02-09 22:22:32'),
(189, 'ADHERENT_BANK_USE_AUTO', 1, '', 'yesno', 0, 'Insertion automatique des cotisations dans le compte banquaire', '2012-02-09 22:22:32'),
(190, 'ADHERENT_BANK_ACCOUNT', 1, '', 'chaine', 0, 'ID du Compte banquaire utilise', '2012-02-09 22:22:32'),
(191, 'ADHERENT_BANK_CATEGORIE', 1, '', 'chaine', 0, 'ID de la catégorie banquaire des cotisations', '2012-02-09 22:22:32'),
(192, 'ADHERENT_ETIQUETTE_TYPE', 1, 'L7163', 'chaine', 0, 'Type d''étiquette (pour impression de planche d''étiquettes)', '2012-02-09 22:22:32'),
(193, 'MAIN_MODULE_FOURNISSEUR', 1, '1', NULL, 0, NULL, '2012-02-09 22:22:37'),
(194, 'COMMANDE_SUPPLIER_ADDON_PDF', 1, 'muscadet', 'chaine', 0, NULL, '2012-02-09 22:22:37'),
(195, 'COMMANDE_SUPPLIER_ADDON', 1, 'mod_commande_fournisseur_muguet', 'chaine', 0, NULL, '2012-02-09 22:22:37'),
(196, 'INVOICE_SUPPLIER_ADDON_PDF', 1, 'canelle', 'chaine', 0, NULL, '2012-02-09 22:22:37'),
(199, 'ADHERENT_CARD_TEXT_RIGHT', 1, 'Texto que pode ser colocado no cartao do membro', '', 0, '', '2012-02-09 22:24:08'),
(200, 'ADHERENT_CARD_TEXT', 1, '%NOM% %PRENOM%\r\nCódigo: %ID%\r\n%EMAIL%\r\n%PAYS%', '', 0, 'Texte imprimé sur la carte adhérent', '2012-02-09 22:24:32'),
(201, 'MAIN_MODULE_AGENDA', 1, '1', NULL, 0, NULL, '2012-02-09 22:25:45'),
(202, 'MAIN_AGENDA_ACTIONAUTO_COMPANY_CREATE', 1, '1', 'chaine', 0, NULL, '2012-02-09 22:25:45'),
(203, 'MAIN_AGENDA_ACTIONAUTO_CONTRACT_VALIDATE', 1, '1', 'chaine', 0, NULL, '2012-02-09 22:25:45'),
(204, 'MAIN_AGENDA_ACTIONAUTO_PROPAL_VALIDATE', 1, '1', 'chaine', 0, NULL, '2012-02-09 22:25:45'),
(205, 'MAIN_AGENDA_ACTIONAUTO_PROPAL_SENTBYMAIL', 1, '1', 'chaine', 0, NULL, '2012-02-09 22:25:45'),
(206, 'MAIN_AGENDA_ACTIONAUTO_ORDER_VALIDATE', 1, '1', 'chaine', 0, NULL, '2012-02-09 22:25:45'),
(207, 'MAIN_AGENDA_ACTIONAUTO_ORDER_SENTBYMAIL', 1, '1', 'chaine', 0, NULL, '2012-02-09 22:25:45'),
(208, 'MAIN_AGENDA_ACTIONAUTO_BILL_VALIDATE', 1, '1', 'chaine', 0, NULL, '2012-02-09 22:25:45'),
(209, 'MAIN_AGENDA_ACTIONAUTO_BILL_PAYED', 1, '1', 'chaine', 0, NULL, '2012-02-09 22:25:45'),
(210, 'MAIN_AGENDA_ACTIONAUTO_BILL_CANCEL', 1, '1', 'chaine', 0, NULL, '2012-02-09 22:25:45'),
(211, 'MAIN_AGENDA_ACTIONAUTO_BILL_SENTBYMAIL', 1, '1', 'chaine', 0, NULL, '2012-02-09 22:25:45'),
(212, 'MAIN_AGENDA_ACTIONAUTO_ORDER_SUPPLIER_VALIDATE', 1, '1', 'chaine', 0, NULL, '2012-02-09 22:25:45'),
(213, 'MAIN_AGENDA_ACTIONAUTO_BILL_SUPPLIER_VALIDATE', 1, '1', 'chaine', 0, NULL, '2012-02-09 22:25:45'),
(214, 'MAIN_AGENDA_ACTIONAUTO_SHIPPING_VALIDATE', 1, '1', 'chaine', 0, NULL, '2012-02-09 22:25:45'),
(215, 'MAIN_AGENDA_ACTIONAUTO_SHIPPING_SENTBYMAIL', 1, '1', 'chaine', 0, NULL, '2012-02-09 22:25:45'),
(216, 'MAIN_MODULE_PROJET', 1, '1', NULL, 0, NULL, '2012-02-09 22:25:49'),
(217, 'PROJECT_ADDON_PDF', 1, 'baleine', 'chaine', 0, 'Nom du gestionnaire de generation des projets en PDF', '2012-02-09 22:25:49'),
(218, 'PROJECT_ADDON', 1, 'mod_project_simple', 'chaine', 0, 'Nom du gestionnaire de numerotation des projets', '2012-02-09 22:25:49'),
(219, 'MAIN_MODULE_SYSLOG', 0, '1', NULL, 0, NULL, '2012-02-09 22:27:34'),
(220, 'MAIN_MODULE_CATEGORIE', 1, '1', NULL, 0, NULL, '2012-02-09 22:28:01'),
(221, 'MAIN_MODULE_FCKEDITOR', 1, '1', NULL, 0, NULL, '2012-02-09 22:28:04'),
(222, 'FCKEDITOR_ENABLE_USER', 1, '1', 'yesno', 0, 'Activation fckeditor sur notes utilisateurs', '2012-02-09 22:28:04'),
(223, 'FCKEDITOR_ENABLE_SOCIETE', 1, '1', 'yesno', 0, 'Activation fckeditor sur notes societe', '2012-02-09 22:28:04'),
(224, 'FCKEDITOR_ENABLE_PRODUCTDESC', 1, '1', 'yesno', 0, 'Activation fckeditor sur notes produits', '2012-02-09 22:28:04'),
(225, 'FCKEDITOR_ENABLE_MEMBER', 1, '1', 'yesno', 0, 'Activation fckeditor sur notes adherent', '2012-02-09 22:28:04'),
(226, 'FCKEDITOR_ENABLE_MAILING', 1, '1', 'yesno', 0, 'Activation fckeditor sur emailing', '2012-02-09 22:28:04'),
(227, 'MAIN_MODULE_WORKFLOW', 1, '1', NULL, 0, NULL, '2012-02-09 22:28:46'),
(228, 'MAIN_MODULE_WORKFLOW_TRIGGERS', 1, '1', 'chaine', 0, NULL, '2012-02-09 22:28:46'),
(229, 'WORKFLOW_PROPAL_AUTOCREATE_ORDER', 1, '1', 'chaine', 0, '', '2012-02-09 22:29:04'),
(230, 'MAIN_MODULE_NOTIFICATION', 1, '1', NULL, 0, NULL, '2012-02-09 22:30:03'),
(231, 'MAIN_MENU_HIDE_UNAUTHORIZED', 1, '1', 'chaine', 0, '', '2012-02-09 22:35:36'),
(236, 'PRODUIT_SOUSPRODUITS', 1, '1', 'chaine', 0, '', '2012-02-09 23:37:29'),
(237, 'PRODUIT_MULTIPRICES', 1, '0', 'chaine', 0, '', '2012-02-12 11:13:54'),
(238, 'PRODUIT_MULTIPRICES_LIMIT', 1, '5', 'chaine', 0, '', '2012-02-12 11:13:54'),
(239, 'PRODUIT_DESC_IN_FORM', 1, '1', 'chaine', 0, '', '2012-02-12 11:14:43'),
(240, 'MAIN_MODULE_CASHDESK', 1, '1', NULL, 0, NULL, '2012-02-12 11:15:57'),
(241, 'MAIN_MODULE_BANQUE', 1, '1', NULL, 0, NULL, '2012-02-12 11:15:57'),
(242, 'MAIN_MODULE_FACTURE', 1, '1', NULL, 0, NULL, '2012-02-12 11:15:58'),
(244, 'MAIN_MODULE_PRODUCT', 1, '1', NULL, 0, NULL, '2012-02-12 11:15:58'),
(245, 'PROPALE_VALIDITY_DURATION', 1, '20', 'chaine', 0, '', '2012-02-12 11:16:45'),
(246, 'PROPALE_FREE_TEXT', 1, 'Texto que pode ser adicionado no orçamento, irá aparecer aqui.\r\nOrçamento válido por 20 dias.', 'chaine', 0, '', '2012-02-12 11:16:51'),
(249, 'MAIN_MODULE_COMPOSITION_NEEDSMARTY', 0, '1', 'chaine', 0, 'Need smarty', '2012-02-12 11:42:42'),
(257, 'MAIN_MODULE_COMPOSITION', 1, '1', NULL, 0, NULL, '2012-02-12 12:53:20'),
(258, 'MAIN_MODULE_COMPOSITION_TABS_0', 1, 'product:ComposedProducts:@composition:/composition/show_composition.php?id=__ID__', 'chaine', 0, NULL, '2012-02-12 12:53:20'),
(259, 'MAIN_MODULE_SOCIETE', 1, '1', NULL, 0, NULL, '2012-02-12 12:53:20');

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_contrat`
--

CREATE TABLE IF NOT EXISTS `llx_contrat` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(30) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datec` datetime DEFAULT NULL,
  `date_contrat` datetime DEFAULT NULL,
  `statut` smallint(6) DEFAULT '0',
  `mise_en_service` datetime DEFAULT NULL,
  `fin_validite` datetime DEFAULT NULL,
  `date_cloture` datetime DEFAULT NULL,
  `fk_soc` int(11) NOT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `fk_commercial_signature` int(11) NOT NULL,
  `fk_commercial_suivi` int(11) NOT NULL,
  `fk_user_author` int(11) NOT NULL DEFAULT '0',
  `fk_user_mise_en_service` int(11) DEFAULT NULL,
  `fk_user_cloture` int(11) DEFAULT NULL,
  `note` text,
  `note_public` text,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_contrat_ref` (`ref`,`entity`),
  KEY `idx_contrat_fk_soc` (`fk_soc`),
  KEY `idx_contrat_fk_user_author` (`fk_user_author`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_contratdet`
--

CREATE TABLE IF NOT EXISTS `llx_contratdet` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_contrat` int(11) NOT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `statut` smallint(6) DEFAULT '0',
  `label` text,
  `description` text,
  `fk_remise_except` int(11) DEFAULT NULL,
  `date_commande` datetime DEFAULT NULL,
  `date_ouverture_prevue` datetime DEFAULT NULL,
  `date_ouverture` datetime DEFAULT NULL,
  `date_fin_validite` datetime DEFAULT NULL,
  `date_cloture` datetime DEFAULT NULL,
  `tva_tx` double(6,3) DEFAULT '0.000',
  `localtax1_tx` double(6,3) DEFAULT '0.000',
  `localtax2_tx` double(6,3) DEFAULT '0.000',
  `qty` double NOT NULL,
  `remise_percent` double DEFAULT '0',
  `subprice` double(24,8) DEFAULT '0.00000000',
  `price_ht` double DEFAULT NULL,
  `remise` double DEFAULT '0',
  `total_ht` double(24,8) DEFAULT '0.00000000',
  `total_tva` double(24,8) DEFAULT '0.00000000',
  `total_localtax1` double(24,8) DEFAULT '0.00000000',
  `total_localtax2` double(24,8) DEFAULT '0.00000000',
  `total_ttc` double(24,8) DEFAULT '0.00000000',
  `info_bits` int(11) DEFAULT '0',
  `fk_user_author` int(11) NOT NULL DEFAULT '0',
  `fk_user_ouverture` int(11) DEFAULT NULL,
  `fk_user_cloture` int(11) DEFAULT NULL,
  `commentaire` text,
  PRIMARY KEY (`rowid`),
  KEY `idx_contratdet_fk_contrat` (`fk_contrat`),
  KEY `idx_contratdet_fk_product` (`fk_product`),
  KEY `idx_contratdet_date_ouverture_prevue` (`date_ouverture_prevue`),
  KEY `idx_contratdet_date_ouverture` (`date_ouverture`),
  KEY `idx_contratdet_date_fin_validite` (`date_fin_validite`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_contratdet_log`
--

CREATE TABLE IF NOT EXISTS `llx_contratdet_log` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_contratdet` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `statut` smallint(6) NOT NULL,
  `fk_user_author` int(11) NOT NULL,
  `commentaire` text,
  PRIMARY KEY (`rowid`),
  KEY `idx_contratdet_log_fk_contratdet` (`fk_contratdet`),
  KEY `idx_contratdet_log_date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_cotisation`
--

CREATE TABLE IF NOT EXISTS `llx_cotisation` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datec` datetime DEFAULT NULL,
  `fk_adherent` int(11) DEFAULT NULL,
  `dateadh` datetime DEFAULT NULL,
  `datef` date DEFAULT NULL,
  `cotisation` double DEFAULT NULL,
  `fk_bank` int(11) DEFAULT NULL,
  `note` text,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_cotisation` (`fk_adherent`,`dateadh`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_c_actioncomm`
--

CREATE TABLE IF NOT EXISTS `llx_c_actioncomm` (
  `id` int(11) NOT NULL,
  `code` varchar(12) NOT NULL,
  `type` varchar(10) NOT NULL DEFAULT 'system',
  `libelle` varchar(48) NOT NULL,
  `module` varchar(16) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `todo` tinyint(4) DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `llx_c_actioncomm`
--

INSERT INTO `llx_c_actioncomm` (`id`, `code`, `type`, `libelle`, `module`, `active`, `todo`, `position`) VALUES
(1, 'AC_TEL', 'system', 'Phone call', NULL, 1, NULL, 2),
(2, 'AC_FAX', 'system', 'Send Fax', NULL, 1, NULL, 3),
(3, 'AC_PROP', 'system', 'Send commercial proposal by email', 'propal', 1, NULL, 10),
(4, 'AC_EMAIL', 'system', 'Send Email', NULL, 1, NULL, 4),
(5, 'AC_RDV', 'system', 'Rendez-vous', NULL, 1, NULL, 1),
(8, 'AC_COM', 'system', 'Send customer order by email', 'order', 1, NULL, 8),
(9, 'AC_FAC', 'system', 'Send customer invoice by email', 'invoice', 1, NULL, 6),
(10, 'AC_SHIP', 'system', 'Send shipping by email', 'shipping', 1, NULL, 11),
(30, 'AC_SUP_ORD', 'system', 'Send supplier order by email', 'order_supplier', 1, NULL, 9),
(31, 'AC_SUP_INV', 'system', 'Send supplier invoice by email', 'invoice_supplier', 1, NULL, 7),
(50, 'AC_OTH', 'system', 'Other', NULL, 1, NULL, 5);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_c_action_trigger`
--

CREATE TABLE IF NOT EXISTS `llx_c_action_trigger` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(32) NOT NULL,
  `label` varchar(128) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `elementtype` varchar(16) NOT NULL,
  `rang` int(11) DEFAULT '0',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_action_trigger_code` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=28 ;

--
-- Extraindo dados da tabela `llx_c_action_trigger`
--

INSERT INTO `llx_c_action_trigger` (`rowid`, `code`, `label`, `description`, `elementtype`, `rang`) VALUES
(1, 'FICHEINTER_VALIDATE', 'Intervention validated', 'Executed when a intervention is validated', 'ficheinter', 18),
(2, 'BILL_VALIDATE', 'Customer invoice validated', 'Executed when a customer invoice is approved', 'facture', 6),
(3, 'ORDER_SUPPLIER_APPROVE', 'Supplier order request approved', 'Executed when a supplier order is approved', 'order_supplier', 11),
(4, 'ORDER_SUPPLIER_REFUSE', 'Supplier order request refused', 'Executed when a supplier order is refused', 'order_supplier', 12),
(5, 'ORDER_VALIDATE', 'Customer order validate', 'Executed when a customer order is validated', 'commande', 4),
(6, 'PROPAL_VALIDATE', 'Customer proposal validated', 'Executed when a commercial proposal is validated', 'propal', 2),
(7, 'WITHDRAW_TRANSMIT', 'Withdraw command transmitted', 'Executed when a withdrawal command is transmited', 'withdraw', 25),
(8, 'WITHDRAW_CREDIT', 'Withdraw credited', 'Executed when a withdrawal is credited', 'withdraw', 26),
(9, 'WITHDRAW_EMIT', 'Withdraw emit', 'Executed when a withdrawal is emited', 'withdraw', 27),
(10, 'COMPANY_CREATE', 'Third party created', 'Executed when a third party is created', 'societe', 1),
(11, 'CONTRACT_VALIDATE', 'Contract validated', 'Executed when a contract is validated', 'contrat', 17),
(12, 'PROPAL_SENTBYMAIL', 'Commercial proposal sent by mail', 'Executed when a commercial proposal is sent by mail', 'propal', 3),
(13, 'ORDER_SENTBYMAIL', 'Customer order sent by mail', 'Executed when a customer order is sent by mail ', 'commande', 5),
(14, 'BILL_PAYED', 'Customer invoice payed', 'Executed when a customer invoice is payed', 'facture', 7),
(15, 'BILL_CANCEL', 'Customer invoice canceled', 'Executed when a customer invoice is conceled', 'facture', 8),
(16, 'BILL_SENTBYMAIL', 'Customer invoice sent by mail', 'Executed when a customer invoice is sent by mail', 'facture', 9),
(17, 'ORDER_SUPPLIER_VALIDATE', 'Supplier order validated', 'Executed when a supplier order is validated', 'order_supplier', 10),
(18, 'ORDER_SUPPLIER_SENTBYMAIL', 'Supplier order sent by mail', 'Executed when a supplier order is sent by mail', 'order_supplier', 13),
(19, 'BILL_SUPPLIER_VALIDATE', 'Supplier invoice validated', 'Executed when a supplier invoice is validated', 'invoice_supplier', 14),
(20, 'BILL_SUPPLIER_PAYED', 'Supplier invoice payed', 'Executed when a supplier invoice is payed', 'invoice_supplier', 15),
(21, 'BILL_SUPPLIER_SENTBYMAIL', 'Supplier invoice sent by mail', 'Executed when a supplier invoice is sent by mail', 'invoice_supplier', 16),
(22, 'SHIPPING_VALIDATE', 'Shipping validated', 'Executed when a shipping is validated', 'shipping', 19),
(23, 'SHIPPING_SENTBYMAIL', 'Shipping sent by mail', 'Executed when a shipping is sent by mail', 'shipping', 20),
(24, 'MEMBER_VALIDATE', 'Member validated', 'Executed when a member is validated', 'member', 21),
(25, 'MEMBER_SUBSCRIPTION', 'Member subscribed', 'Executed when a member is subscribed', 'member', 22),
(26, 'MEMBER_RESILIATE', 'Member resiliated', 'Executed when a member is resiliated', 'member', 23),
(27, 'MEMBER_DELETE', 'Member deleted', 'Executed when a member is deleted', 'member', 24);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_c_availability`
--

CREATE TABLE IF NOT EXISTS `llx_c_availability` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(30) NOT NULL,
  `label` varchar(60) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_c_availability` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Extraindo dados da tabela `llx_c_availability`
--

INSERT INTO `llx_c_availability` (`rowid`, `code`, `label`, `active`) VALUES
(1, 'AV_NOW', 'Immediate', 1),
(2, 'AV_1W', '1 week', 1),
(3, 'AV_2W', '2 weeks', 1),
(4, 'AV_3W', '3 weeks', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_c_barcode_type`
--

CREATE TABLE IF NOT EXISTS `llx_c_barcode_type` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(16) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `libelle` varchar(50) NOT NULL,
  `coder` varchar(16) NOT NULL,
  `example` varchar(16) NOT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Extraindo dados da tabela `llx_c_barcode_type`
--

INSERT INTO `llx_c_barcode_type` (`rowid`, `code`, `entity`, `libelle`, `coder`, `example`) VALUES
(1, 'EAN8', 1, 'EAN8', '0', '1234567'),
(2, 'EAN13', 1, 'EAN13', '0', '123456789012'),
(3, 'UPC', 1, 'UPC', '0', '123456789012'),
(4, 'ISBN', 1, 'ISBN', '0', '123456789'),
(5, 'C39', 1, 'Code 39', '0', '1234567890'),
(6, 'C128', 1, 'Code 128', '0', 'ABCD1234567890');

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_c_chargesociales`
--

CREATE TABLE IF NOT EXISTS `llx_c_chargesociales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(80) DEFAULT NULL,
  `deductible` smallint(6) NOT NULL DEFAULT '0',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `code` varchar(12) NOT NULL,
  `fk_pays` int(11) NOT NULL DEFAULT '1',
  `module` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=231 ;

--
-- Extraindo dados da tabela `llx_c_chargesociales`
--

INSERT INTO `llx_c_chargesociales` (`id`, `libelle`, `deductible`, `active`, `code`, `fk_pays`, `module`) VALUES
(1, 'Allocations familiales', 1, 1, 'TAXFAM', 1, NULL),
(2, 'CSG Deductible', 1, 1, 'TAXCSGD', 1, NULL),
(3, 'CSG/CRDS NON Deductible', 0, 1, 'TAXCSGND', 1, NULL),
(10, 'Taxe apprentissage', 0, 1, 'TAXAPP', 1, NULL),
(11, 'Taxe professionnelle', 0, 1, 'TAXPRO', 1, NULL),
(20, 'Impots locaux/fonciers', 0, 1, 'TAXFON', 1, NULL),
(25, 'Impots revenus', 0, 1, 'TAXREV', 1, NULL),
(30, 'Assurance Sante', 0, 1, 'TAXSECU', 1, NULL),
(40, 'Mutuelle', 0, 1, 'TAXMUT', 1, NULL),
(50, 'Assurance vieillesse', 0, 1, 'TAXRET', 1, NULL),
(60, 'Assurance Chomage', 0, 1, 'TAXCHOM', 1, NULL),
(201, 'ONSS', 1, 1, 'TAXBEONSS', 2, NULL),
(210, 'Precompte professionnel', 1, 1, 'TAXBEPREPRO', 2, NULL),
(220, 'Prime d''existence', 1, 1, 'TAXBEPRIEXI', 2, NULL),
(230, 'Precompte immobilier', 1, 1, 'TAXBEPREIMMO', 2, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_c_civilite`
--

CREATE TABLE IF NOT EXISTS `llx_c_civilite` (
  `rowid` int(11) NOT NULL,
  `code` varchar(6) NOT NULL,
  `civilite` varchar(50) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `module` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `llx_c_civilite`
--

INSERT INTO `llx_c_civilite` (`rowid`, `code`, `civilite`, `active`, `module`) VALUES
(1, 'MME', 'Madame', 1, NULL),
(3, 'MR', 'Monsieur', 1, NULL),
(5, 'MLE', 'Mademoiselle', 1, NULL),
(7, 'MTRE', 'Maître', 1, NULL),
(8, 'DR', 'Docteur', 1, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_c_currencies`
--

CREATE TABLE IF NOT EXISTS `llx_c_currencies` (
  `code` varchar(2) NOT NULL,
  `code_iso` varchar(3) NOT NULL,
  `label` varchar(64) DEFAULT NULL,
  `labelsing` varchar(64) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`code`),
  UNIQUE KEY `uk_c_currencies_code_iso` (`code_iso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `llx_c_currencies`
--

INSERT INTO `llx_c_currencies` (`code`, `code_iso`, `label`, `labelsing`, `active`) VALUES
('AD', 'AUD', 'Dollars australiens', NULL, 1),
('AE', 'AED', 'Arabes emirats dirham', NULL, 1),
('BD', 'BBD', 'Barbadian or Bajan Dollar', NULL, 1),
('BT', 'THB', 'Bath thailandais', NULL, 1),
('CD', 'DKK', 'Couronnes dannoises', NULL, 1),
('CF', 'XAF', 'Francs cfa beac', NULL, 1),
('CN', 'NOK', 'Couronnes norvegiennes', NULL, 1),
('CS', 'SEK', 'Couronnes suedoises', NULL, 1),
('CZ', 'CZK', 'Couronnes tcheques', NULL, 1),
('DA', 'DZD', 'Dinar algérien', NULL, 1),
('DC', 'CAD', 'Dollars canadiens', NULL, 1),
('DH', 'MAD', 'Dirham', NULL, 1),
('DR', 'GRD', 'Drachme (grece)', NULL, 1),
('DS', 'SGD', 'Dollars singapour', NULL, 1),
('DU', 'USD', 'Dollars us', NULL, 1),
('EC', 'XEU', 'Ecus', NULL, 1),
('EG', 'EGP', 'Livre egyptienne', NULL, 1),
('ES', 'PTE', 'Escudos', NULL, 0),
('EU', 'EUR', 'Euros', NULL, 1),
('FB', 'BEF', 'Francs belges', NULL, 0),
('FF', 'FRF', 'Francs francais', NULL, 0),
('FH', 'HUF', 'Forint hongrois', NULL, 1),
('FL', 'LUF', 'Francs luxembourgeois', NULL, 0),
('FO', 'NLG', 'Florins', NULL, 1),
('FS', 'CHF', 'Francs suisses', NULL, 1),
('HK', 'HKD', 'Dollars hong kong', NULL, 1),
('ID', 'IDR', 'Rupiahs d''indonesie', NULL, 1),
('IN', 'INR', 'Roupie indienne', NULL, 1),
('KR', 'KRW', 'Won coree du sud', NULL, 1),
('LH', 'HNL', 'Lempiras', NULL, 1),
('LI', 'IEP', 'Livres irlandaises', NULL, 1),
('LK', 'LKR', 'Roupies sri lanka', NULL, 1),
('LR', 'ITL', 'Lires', NULL, 0),
('LS', 'GBP', 'Livres sterling', NULL, 1),
('LT', 'LTL', 'Litas', NULL, 1),
('MA', 'DEM', 'Deutsch mark', NULL, 0),
('MF', 'FIM', 'Mark finlandais', NULL, 1),
('MR', 'MRO', 'Ouguiya Mauritanien', NULL, 1),
('MU', 'MUR', 'Roupies mauritiennes', NULL, 1),
('MX', 'MXP', 'Pesos Mexicans', NULL, 1),
('NZ', 'NZD', 'Dollar neo-zelandais', NULL, 1),
('PA', 'ARP', 'Pesos argentins', NULL, 1),
('PC', 'CLP', 'Pesos chilien', NULL, 1),
('PE', 'ESP', 'Pesete', NULL, 1),
('PL', 'PLN', 'Zlotys polonais', NULL, 1),
('RB', 'BRL', 'Real bresilien', NULL, 1),
('RU', 'SUR', 'Rouble', NULL, 1),
('SA', 'ATS', 'Shiliing autrichiens', NULL, 1),
('SK', 'SKK', 'Couronnes slovaques', NULL, 1),
('SR', 'SAR', 'Saudi riyal', NULL, 1),
('TD', 'TND', 'Dinar tunisien', NULL, 1),
('TR', 'TRL', 'Livre turque', NULL, 1),
('TW', 'TWD', 'Dollar taiwanais', NULL, 1),
('YC', 'CNY', 'Yuang chinois', NULL, 1),
('YE', 'JPY', 'Yens', NULL, 1),
('ZA', 'ZAR', 'Rand africa', NULL, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_c_departements`
--

CREATE TABLE IF NOT EXISTS `llx_c_departements` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code_departement` varchar(6) NOT NULL,
  `fk_region` int(11) DEFAULT NULL,
  `cheflieu` varchar(50) DEFAULT NULL,
  `tncc` int(11) DEFAULT NULL,
  `ncc` varchar(50) DEFAULT NULL,
  `nom` varchar(50) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_departements` (`code_departement`,`fk_region`),
  KEY `idx_departements_fk_region` (`fk_region`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=584 ;

--
-- Extraindo dados da tabela `llx_c_departements`
--

INSERT INTO `llx_c_departements` (`rowid`, `code_departement`, `fk_region`, `cheflieu`, `tncc`, `ncc`, `nom`, `active`) VALUES
(1, '0', 0, '0', 0, '-', '-', 1),
(2, '01', 82, '01053', 5, 'AIN', 'Ain', 1),
(3, '02', 22, '02408', 5, 'AISNE', 'Aisne', 1),
(4, '03', 83, '03190', 5, 'ALLIER', 'Allier', 1),
(5, '04', 93, '04070', 4, 'ALPES-DE-HAUTE-PROVENCE', 'Alpes-de-Haute-Provence', 1),
(6, '05', 93, '05061', 4, 'HAUTES-ALPES', 'Hautes-Alpes', 1),
(7, '06', 93, '06088', 4, 'ALPES-MARITIMES', 'Alpes-Maritimes', 1),
(8, '07', 82, '07186', 5, 'ARDECHE', 'Ardèche', 1),
(9, '08', 21, '08105', 4, 'ARDENNES', 'Ardennes', 1),
(10, '09', 73, '09122', 5, 'ARIEGE', 'Ariège', 1),
(11, '10', 21, '10387', 5, 'AUBE', 'Aube', 1),
(12, '11', 91, '11069', 5, 'AUDE', 'Aude', 1),
(13, '12', 73, '12202', 5, 'AVEYRON', 'Aveyron', 1),
(14, '13', 93, '13055', 4, 'BOUCHES-DU-RHONE', 'Bouches-du-Rhône', 1),
(15, '14', 25, '14118', 2, 'CALVADOS', 'Calvados', 1),
(16, '15', 83, '15014', 2, 'CANTAL', 'Cantal', 1),
(17, '16', 54, '16015', 3, 'CHARENTE', 'Charente', 1),
(18, '17', 54, '17300', 3, 'CHARENTE-MARITIME', 'Charente-Maritime', 1),
(19, '18', 24, '18033', 2, 'CHER', 'Cher', 1),
(20, '19', 74, '19272', 3, 'CORREZE', 'Corrèze', 1),
(21, '2A', 94, '2A004', 3, 'CORSE-DU-SUD', 'Corse-du-Sud', 1),
(22, '2B', 94, '2B033', 3, 'HAUTE-CORSE', 'Haute-Corse', 1),
(23, '21', 26, '21231', 3, 'COTE-D''OR', 'Côte-d''Or', 1),
(24, '22', 53, '22278', 4, 'COTES-D''ARMOR', 'Côtes-d''Armor', 1),
(25, '23', 74, '23096', 3, 'CREUSE', 'Creuse', 1),
(26, '24', 72, '24322', 3, 'DORDOGNE', 'Dordogne', 1),
(27, '25', 43, '25056', 2, 'DOUBS', 'Doubs', 1),
(28, '26', 82, '26362', 3, 'DROME', 'Drôme', 1),
(29, '27', 23, '27229', 5, 'EURE', 'Eure', 1),
(30, '28', 24, '28085', 1, 'EURE-ET-LOIR', 'Eure-et-Loir', 1),
(31, '29', 53, '29232', 2, 'FINISTERE', 'Finistère', 1),
(32, '30', 91, '30189', 2, 'GARD', 'Gard', 1),
(33, '31', 73, '31555', 3, 'HAUTE-GARONNE', 'Haute-Garonne', 1),
(34, '32', 73, '32013', 2, 'GERS', 'Gers', 1),
(35, '33', 72, '33063', 3, 'GIRONDE', 'Gironde', 1),
(36, '34', 91, '34172', 5, 'HERAULT', 'Hérault', 1),
(37, '35', 53, '35238', 1, 'ILLE-ET-VILAINE', 'Ille-et-Vilaine', 1),
(38, '36', 24, '36044', 5, 'INDRE', 'Indre', 1),
(39, '37', 24, '37261', 1, 'INDRE-ET-LOIRE', 'Indre-et-Loire', 1),
(40, '38', 82, '38185', 5, 'ISERE', 'Isère', 1),
(41, '39', 43, '39300', 2, 'JURA', 'Jura', 1),
(42, '40', 72, '40192', 4, 'LANDES', 'Landes', 1),
(43, '41', 24, '41018', 0, 'LOIR-ET-CHER', 'Loir-et-Cher', 1),
(44, '42', 82, '42218', 3, 'LOIRE', 'Loire', 1),
(45, '43', 83, '43157', 3, 'HAUTE-LOIRE', 'Haute-Loire', 1),
(46, '44', 52, '44109', 3, 'LOIRE-ATLANTIQUE', 'Loire-Atlantique', 1),
(47, '45', 24, '45234', 2, 'LOIRET', 'Loiret', 1),
(48, '46', 73, '46042', 2, 'LOT', 'Lot', 1),
(49, '47', 72, '47001', 0, 'LOT-ET-GARONNE', 'Lot-et-Garonne', 1),
(50, '48', 91, '48095', 3, 'LOZERE', 'Lozère', 1),
(51, '49', 52, '49007', 0, 'MAINE-ET-LOIRE', 'Maine-et-Loire', 1),
(52, '50', 25, '50502', 3, 'MANCHE', 'Manche', 1),
(53, '51', 21, '51108', 3, 'MARNE', 'Marne', 1),
(54, '52', 21, '52121', 3, 'HAUTE-MARNE', 'Haute-Marne', 1),
(55, '53', 52, '53130', 3, 'MAYENNE', 'Mayenne', 1),
(56, '54', 41, '54395', 0, 'MEURTHE-ET-MOSELLE', 'Meurthe-et-Moselle', 1),
(57, '55', 41, '55029', 3, 'MEUSE', 'Meuse', 1),
(58, '56', 53, '56260', 2, 'MORBIHAN', 'Morbihan', 1),
(59, '57', 41, '57463', 3, 'MOSELLE', 'Moselle', 1),
(60, '58', 26, '58194', 3, 'NIEVRE', 'Nièvre', 1),
(61, '59', 31, '59350', 2, 'NORD', 'Nord', 1),
(62, '60', 22, '60057', 5, 'OISE', 'Oise', 1),
(63, '61', 25, '61001', 5, 'ORNE', 'Orne', 1),
(64, '62', 31, '62041', 2, 'PAS-DE-CALAIS', 'Pas-de-Calais', 1),
(65, '63', 83, '63113', 2, 'PUY-DE-DOME', 'Puy-de-Dôme', 1),
(66, '64', 72, '64445', 4, 'PYRENEES-ATLANTIQUES', 'Pyrénées-Atlantiques', 1),
(67, '65', 73, '65440', 4, 'HAUTES-PYRENEES', 'Hautes-Pyrénées', 1),
(68, '66', 91, '66136', 4, 'PYRENEES-ORIENTALES', 'Pyrénées-Orientales', 1),
(69, '67', 42, '67482', 2, 'BAS-RHIN', 'Bas-Rhin', 1),
(70, '68', 42, '68066', 2, 'HAUT-RHIN', 'Haut-Rhin', 1),
(71, '69', 82, '69123', 2, 'RHONE', 'Rhône', 1),
(72, '70', 43, '70550', 3, 'HAUTE-SAONE', 'Haute-Saône', 1),
(73, '71', 26, '71270', 0, 'SAONE-ET-LOIRE', 'Saône-et-Loire', 1),
(74, '72', 52, '72181', 3, 'SARTHE', 'Sarthe', 1),
(75, '73', 82, '73065', 3, 'SAVOIE', 'Savoie', 1),
(76, '74', 82, '74010', 3, 'HAUTE-SAVOIE', 'Haute-Savoie', 1),
(77, '75', 11, '75056', 0, 'PARIS', 'Paris', 1),
(78, '76', 23, '76540', 3, 'SEINE-MARITIME', 'Seine-Maritime', 1),
(79, '77', 11, '77288', 0, 'SEINE-ET-MARNE', 'Seine-et-Marne', 1),
(80, '78', 11, '78646', 4, 'YVELINES', 'Yvelines', 1),
(81, '79', 54, '79191', 4, 'DEUX-SEVRES', 'Deux-Sèvres', 1),
(82, '80', 22, '80021', 3, 'SOMME', 'Somme', 1),
(83, '81', 73, '81004', 2, 'TARN', 'Tarn', 1),
(84, '82', 73, '82121', 0, 'TARN-ET-GARONNE', 'Tarn-et-Garonne', 1),
(85, '83', 93, '83137', 2, 'VAR', 'Var', 1),
(86, '84', 93, '84007', 0, 'VAUCLUSE', 'Vaucluse', 1),
(87, '85', 52, '85191', 3, 'VENDEE', 'Vendée', 1),
(88, '86', 54, '86194', 3, 'VIENNE', 'Vienne', 1),
(89, '87', 74, '87085', 3, 'HAUTE-VIENNE', 'Haute-Vienne', 1),
(90, '88', 41, '88160', 4, 'VOSGES', 'Vosges', 1),
(91, '89', 26, '89024', 5, 'YONNE', 'Yonne', 1),
(92, '90', 43, '90010', 0, 'TERRITOIRE DE BELFORT', 'Territoire de Belfort', 1),
(93, '91', 11, '91228', 5, 'ESSONNE', 'Essonne', 1),
(94, '92', 11, '92050', 4, 'HAUTS-DE-SEINE', 'Hauts-de-Seine', 1),
(95, '93', 11, '93008', 3, 'SEINE-SAINT-DENIS', 'Seine-Saint-Denis', 1),
(96, '94', 11, '94028', 2, 'VAL-DE-MARNE', 'Val-de-Marne', 1),
(97, '95', 11, '95500', 2, 'VAL-D''OISE', 'Val-d''Oise', 1),
(98, '971', 1, '97105', 3, 'GUADELOUPE', 'Guadeloupe', 1),
(99, '972', 2, '97209', 3, 'MARTINIQUE', 'Martinique', 1),
(100, '973', 3, '97302', 3, 'GUYANE', 'Guyane', 1),
(101, '974', 4, '97411', 3, 'REUNION', 'Réunion', 1),
(102, '01', 201, '', 1, 'ANVERS', 'Anvers', 1),
(103, '02', 203, '', 3, 'BRUXELLES-CAPITALE', 'Bruxelles-Capitale', 1),
(104, '03', 202, '', 2, 'BRABANT-WALLON', 'Brabant-Wallon', 1),
(105, '04', 201, '', 1, 'BRABANT-FLAMAND', 'Brabant-Flamand', 1),
(106, '05', 201, '', 1, 'FLANDRE-OCCIDENTALE', 'Flandre-Occidentale', 1),
(107, '06', 201, '', 1, 'FLANDRE-ORIENTALE', 'Flandre-Orientale', 1),
(108, '07', 202, '', 2, 'HAINAUT', 'Hainaut', 1),
(109, '08', 201, '', 2, 'LIEGE', 'Liège', 1),
(110, '09', 202, '', 1, 'LIMBOURG', 'Limbourg', 1),
(111, '10', 202, '', 2, 'LUXEMBOURG', 'Luxembourg', 1),
(112, '11', 201, '', 2, 'NAMUR', 'Namur', 1),
(113, 'AG', 315, NULL, NULL, NULL, 'AGRIGENTO', 1),
(114, 'AL', 312, NULL, NULL, NULL, 'ALESSANDRIA', 1),
(115, 'AN', 310, NULL, NULL, NULL, 'ANCONA', 1),
(116, 'AO', 319, NULL, NULL, NULL, 'AOSTA', 1),
(117, 'AR', 316, NULL, NULL, NULL, 'AREZZO', 1),
(118, 'AP', 310, NULL, NULL, NULL, 'ASCOLI PICENO', 1),
(119, 'AT', 312, NULL, NULL, NULL, 'ASTI', 1),
(120, 'AV', 304, NULL, NULL, NULL, 'AVELLINO', 1),
(121, 'BA', 313, NULL, NULL, NULL, 'BARI', 1),
(122, 'BT', 313, NULL, NULL, NULL, 'BARLETTA-ANDRIA-TRANI', 1),
(123, 'BL', 320, NULL, NULL, NULL, 'BELLUNO', 1),
(124, 'BN', 304, NULL, NULL, NULL, 'BENEVENTO', 1),
(125, 'BG', 309, NULL, NULL, NULL, 'BERGAMO', 1),
(126, 'BI', 312, NULL, NULL, NULL, 'BIELLA', 1),
(127, 'BO', 305, NULL, NULL, NULL, 'BOLOGNA', 1),
(128, 'BZ', 317, NULL, NULL, NULL, 'BOLZANO', 1),
(129, 'BS', 309, NULL, NULL, NULL, 'BRESCIA', 1),
(130, 'BR', 313, NULL, NULL, NULL, 'BRINDISI', 1),
(131, 'CA', 314, NULL, NULL, NULL, 'CAGLIARI', 1),
(132, 'CL', 315, NULL, NULL, NULL, 'CALTANISSETTA', 1),
(133, 'CB', 311, NULL, NULL, NULL, 'CAMPOBASSO', 1),
(134, 'CI', 314, NULL, NULL, NULL, 'CARBONIA-IGLESIAS', 1),
(135, 'CE', 304, NULL, NULL, NULL, 'CASERTA', 1),
(136, 'CT', 315, NULL, NULL, NULL, 'CATANIA', 1),
(137, 'CZ', 303, NULL, NULL, NULL, 'CATANZARO', 1),
(138, 'CH', 301, NULL, NULL, NULL, 'CHIETI', 1),
(139, 'CO', 309, NULL, NULL, NULL, 'COMO', 1),
(140, 'CS', 303, NULL, NULL, NULL, 'COSENZA', 1),
(141, 'CR', 309, NULL, NULL, NULL, 'CREMONA', 1),
(142, 'KR', 303, NULL, NULL, NULL, 'CROTONE', 1),
(143, 'CN', 312, NULL, NULL, NULL, 'CUNEO', 1),
(144, 'EN', 315, NULL, NULL, NULL, 'ENNA', 1),
(145, 'FM', 310, NULL, NULL, NULL, 'FERMO', 1),
(146, 'FE', 305, NULL, NULL, NULL, 'FERRARA', 1),
(147, 'FI', 316, NULL, NULL, NULL, 'FIRENZE', 1),
(148, 'FG', 313, NULL, NULL, NULL, 'FOGGIA', 1),
(149, 'FC', 305, NULL, NULL, NULL, 'FORLI-CESENA', 1),
(150, 'FR', 307, NULL, NULL, NULL, 'FROSINONE', 1),
(151, 'GE', 308, NULL, NULL, NULL, 'GENOVA', 1),
(152, 'GO', 306, NULL, NULL, NULL, 'GORIZIA', 1),
(153, 'GR', 316, NULL, NULL, NULL, 'GROSSETO', 1),
(154, 'IM', 308, NULL, NULL, NULL, 'IMPERIA', 1),
(155, 'IS', 311, NULL, NULL, NULL, 'ISERNIA', 1),
(156, 'SP', 308, NULL, NULL, NULL, 'LA SPEZIA', 1),
(157, 'AQ', 301, NULL, NULL, NULL, 'L AQUILA', 1),
(158, 'LT', 307, NULL, NULL, NULL, 'LATINA', 1),
(159, 'LE', 313, NULL, NULL, NULL, 'LECCE', 1),
(160, 'LC', 309, NULL, NULL, NULL, 'LECCO', 1),
(161, 'LI', 314, NULL, NULL, NULL, 'LIVORNO', 1),
(162, 'LO', 309, NULL, NULL, NULL, 'LODI', 1),
(163, 'LU', 316, NULL, NULL, NULL, 'LUCCA', 1),
(164, 'MC', 310, NULL, NULL, NULL, 'MACERATA', 1),
(165, 'MN', 309, NULL, NULL, NULL, 'MANTOVA', 1),
(166, 'MS', 316, NULL, NULL, NULL, 'MASSA-CARRARA', 1),
(167, 'MT', 302, NULL, NULL, NULL, 'MATERA', 1),
(168, 'VS', 314, NULL, NULL, NULL, 'MEDIO CAMPIDANO', 1),
(169, 'ME', 315, NULL, NULL, NULL, 'MESSINA', 1),
(170, 'MI', 309, NULL, NULL, NULL, 'MILANO', 1),
(171, 'MB', 309, NULL, NULL, NULL, 'MONZA e BRIANZA', 1),
(172, 'MO', 305, NULL, NULL, NULL, 'MODENA', 1),
(173, 'NA', 304, NULL, NULL, NULL, 'NAPOLI', 1),
(174, 'NO', 312, NULL, NULL, NULL, 'NOVARA', 1),
(175, 'NU', 314, NULL, NULL, NULL, 'NUORO', 1),
(176, 'OG', 314, NULL, NULL, NULL, 'OGLIASTRA', 1),
(177, 'OT', 314, NULL, NULL, NULL, 'OLBIA-TEMPIO', 1),
(178, 'OR', 314, NULL, NULL, NULL, 'ORISTANO', 1),
(179, 'PD', 320, NULL, NULL, NULL, 'PADOVA', 1),
(180, 'PA', 315, NULL, NULL, NULL, 'PALERMO', 1),
(181, 'PR', 305, NULL, NULL, NULL, 'PARMA', 1),
(182, 'PV', 309, NULL, NULL, NULL, 'PAVIA', 1),
(183, 'PG', 318, NULL, NULL, NULL, 'PERUGIA', 1),
(184, 'PU', 310, NULL, NULL, NULL, 'PESARO e URBINO', 1),
(185, 'PE', 301, NULL, NULL, NULL, 'PESCARA', 1),
(186, 'PC', 305, NULL, NULL, NULL, 'PIACENZA', 1),
(187, 'PI', 316, NULL, NULL, NULL, 'PISA', 1),
(188, 'PT', 316, NULL, NULL, NULL, 'PISTOIA', 1),
(189, 'PN', 306, NULL, NULL, NULL, 'PORDENONE', 1),
(190, 'PZ', 302, NULL, NULL, NULL, 'POTENZA', 1),
(191, 'PO', 316, NULL, NULL, NULL, 'PRATO', 1),
(192, 'RG', 315, NULL, NULL, NULL, 'RAGUSA', 1),
(193, 'RA', 305, NULL, NULL, NULL, 'RAVENNA', 1),
(194, 'RC', 303, NULL, NULL, NULL, 'REGGIO CALABRIA', 1),
(195, 'RE', 305, NULL, NULL, NULL, 'REGGIO NELL EMILIA', 1),
(196, 'RI', 307, NULL, NULL, NULL, 'RIETI', 1),
(197, 'RN', 305, NULL, NULL, NULL, 'RIMINI', 1),
(198, 'RM', 307, NULL, NULL, NULL, 'ROMA', 1),
(199, 'RO', 320, NULL, NULL, NULL, 'ROVIGO', 1),
(200, 'SA', 304, NULL, NULL, NULL, 'SALERNO', 1),
(201, 'SS', 314, NULL, NULL, NULL, 'SASSARI', 1),
(202, 'SV', 308, NULL, NULL, NULL, 'SAVONA', 1),
(203, 'SI', 316, NULL, NULL, NULL, 'SIENA', 1),
(204, 'SR', 315, NULL, NULL, NULL, 'SIRACUSA', 1),
(205, 'SO', 309, NULL, NULL, NULL, 'SONDRIO', 1),
(206, 'TA', 313, NULL, NULL, NULL, 'TARANTO', 1),
(207, 'TE', 301, NULL, NULL, NULL, 'TERAMO', 1),
(208, 'TR', 318, NULL, NULL, NULL, 'TERNI', 1),
(209, 'TO', 312, NULL, NULL, NULL, 'TORINO', 1),
(210, 'TP', 315, NULL, NULL, NULL, 'TRAPANI', 1),
(211, 'TN', 317, NULL, NULL, NULL, 'TRENTO', 1),
(212, 'TV', 320, NULL, NULL, NULL, 'TREVISO', 1),
(213, 'TS', 306, NULL, NULL, NULL, 'TRIESTE', 1),
(214, 'UD', 306, NULL, NULL, NULL, 'UDINE', 1),
(215, 'VA', 309, NULL, NULL, NULL, 'VARESE', 1),
(216, 'VE', 320, NULL, NULL, NULL, 'VENEZIA', 1),
(217, 'VB', 312, NULL, NULL, NULL, 'VERBANO-CUSIO-OSSOLA', 1),
(218, 'VC', 312, NULL, NULL, NULL, 'VERCELLI', 1),
(219, 'VR', 320, NULL, NULL, NULL, 'VERONA', 1),
(220, 'VV', 303, NULL, NULL, NULL, 'VIBO VALENTIA', 1),
(221, 'VI', 320, NULL, NULL, NULL, 'VICENZA', 1),
(222, 'VT', 307, NULL, NULL, NULL, 'VITERBO', 1),
(223, 'NSW', 2801, '', 1, '', 'New South Wales', 1),
(224, 'VIC', 2801, '', 1, '', 'Victoria', 1),
(225, 'QLD', 2801, '', 1, '', 'Queensland', 1),
(226, 'SA', 2801, '', 1, '', 'South Australia', 1),
(227, 'ACT', 2801, '', 1, '', 'Australia Capital Territory', 1),
(228, 'TAS', 2801, '', 1, '', 'Tasmania', 1),
(229, 'WA', 2801, '', 1, '', 'Western Australia', 1),
(230, 'NT', 2801, '', 1, '', 'Northern Territory', 1),
(231, '01', 419, '', 19, 'PAIS VASCO', 'País Vasco', 1),
(232, '02', 404, '', 4, 'ALBACETE', 'Albacete', 1),
(233, '03', 411, '', 11, 'ALICANTE', 'Alicante', 1),
(234, '04', 401, '', 1, 'ALMERIA', 'Almería', 1),
(235, '05', 403, '', 3, 'AVILA', 'Avila', 1),
(236, '06', 412, '', 12, 'BADAJOZ', 'Badajoz', 1),
(237, '07', 414, '', 14, 'ISLAS BALEARES', 'Islas Baleares', 1),
(238, '08', 406, '', 6, 'BARCELONA', 'Barcelona', 1),
(239, '09', 403, '', 8, 'BURGOS', 'Burgos', 1),
(240, '10', 412, '', 12, 'CACERES', 'Cáceres', 1),
(241, '11', 401, '', 1, 'CADIz', 'Cádiz', 1),
(242, '12', 411, '', 11, 'CASTELLON', 'Castellón', 1),
(243, '13', 404, '', 4, 'CIUDAD REAL', 'Ciudad Real', 1),
(244, '14', 401, '', 1, 'CORDOBA', 'Córdoba', 1),
(245, '15', 413, '', 13, 'LA CORUÑA', 'La Coruña', 1),
(246, '16', 404, '', 4, 'CUENCA', 'Cuenca', 1),
(247, '17', 406, '', 6, 'GERONA', 'Gerona', 1),
(248, '18', 401, '', 1, 'GRANADA', 'Granada', 1),
(249, '19', 404, '', 4, 'GUADALAJARA', 'Guadalajara', 1),
(250, '20', 419, '', 19, 'GUIPUZCOA', 'Guipúzcoa', 1),
(251, '21', 401, '', 1, 'HUELVA', 'Huelva', 1),
(252, '22', 402, '', 2, 'HUESCA', 'Huesca', 1),
(253, '23', 401, '', 1, 'JAEN', 'Jaén', 1),
(254, '24', 403, '', 3, 'LEON', 'León', 1),
(255, '25', 406, '', 6, 'LERIDA', 'Lérida', 1),
(256, '26', 415, '', 15, 'LA RIOJA', 'La Rioja', 1),
(257, '27', 413, '', 13, 'LUGO', 'Lugo', 1),
(258, '28', 416, '', 16, 'MADRID', 'Madrid', 1),
(259, '29', 401, '', 1, 'MALAGA', 'Málaga', 1),
(260, '30', 417, '', 17, 'MURCIA', 'Murcia', 1),
(261, '31', 408, '', 8, 'NAVARRA', 'Navarra', 1),
(262, '32', 413, '', 13, 'ORENSE', 'Orense', 1),
(263, '33', 418, '', 18, 'ASTURIAS', 'Asturias', 1),
(264, '34', 403, '', 3, 'PALENCIA', 'Palencia', 1),
(265, '35', 405, '', 5, 'LAS PALMAS', 'Las Palmas', 1),
(266, '36', 413, '', 13, 'PONTEVEDRA', 'Pontevedra', 1),
(267, '37', 403, '', 3, 'SALAMANCA', 'Salamanca', 1),
(268, '38', 405, '', 5, 'STA. CRUZ DE TENERIFE', 'Sta. Cruz de Tenerife', 1),
(269, '39', 410, '', 10, 'CANTABRIA', 'Cantabria', 1),
(270, '40', 403, '', 3, 'SEGOVIA', 'Segovia', 1),
(271, '41', 401, '', 1, 'SEVILLA', 'Sevilla', 1),
(272, '42', 403, '', 3, 'SORIA', 'Soria', 1),
(273, '43', 406, '', 6, 'TARRAGONA', 'Tarragona', 1),
(274, '44', 402, '', 2, 'TERUEL', 'Teruel', 1),
(275, '45', 404, '', 5, 'TOLEDO', 'Toledo', 1),
(276, '46', 411, '', 11, 'VALENCIA', 'Valencia', 1),
(277, '47', 403, '', 3, 'VALLADOLID', 'Valladolid', 1),
(278, '48', 419, '', 19, 'VIZCAYA', 'Vizcaya', 1),
(279, '49', 403, '', 3, 'ZAMORA', 'Zamora', 1),
(280, '50', 402, '', 1, 'ZARAGOZA', 'Zaragoza', 1),
(281, '51', 407, '', 7, 'CEUTA', 'Ceuta', 1),
(282, '52', 409, '', 9, 'MELILLA', 'Melilla', 1),
(283, '53', 420, '', 20, 'OTROS', 'Otros', 1),
(284, 'AG', 601, NULL, NULL, 'ARGOVIE', 'Argovie', 1),
(285, 'AI', 601, NULL, NULL, 'APPENZELL RHODES INTERIEURES', 'Appenzell Rhodes intérieures', 1),
(286, 'AR', 601, NULL, NULL, 'APPENZELL RHODES EXTERIEURES', 'Appenzell Rhodes extérieures', 1),
(287, 'BE', 601, NULL, NULL, 'BERNE', 'Berne', 1),
(288, 'BL', 601, NULL, NULL, 'BALE CAMPAGNE', 'Bâle Campagne', 1),
(289, 'BS', 601, NULL, NULL, 'BALE VILLE', 'Bâle Ville', 1),
(290, 'FR', 601, NULL, NULL, 'FRIBOURG', 'Fribourg', 1),
(291, 'GE', 601, NULL, NULL, 'GENEVE', 'Genève', 1),
(292, 'GL', 601, NULL, NULL, 'GLARIS', 'Glaris', 1),
(293, 'GR', 601, NULL, NULL, 'GRISONS', 'Grisons', 1),
(294, 'JU', 601, NULL, NULL, 'JURA', 'Jura', 1),
(295, 'LU', 601, NULL, NULL, 'LUCERNE', 'Lucerne', 1),
(296, 'NE', 601, NULL, NULL, 'NEUCHATEL', 'Neuchâtel', 1),
(297, 'NW', 601, NULL, NULL, 'NIDWALD', 'Nidwald', 1),
(298, 'OW', 601, NULL, NULL, 'OBWALD', 'Obwald', 1),
(299, 'SG', 601, NULL, NULL, 'SAINT-GALL', 'Saint-Gall', 1),
(300, 'SH', 601, NULL, NULL, 'SCHAFFHOUSE', 'Schaffhouse', 1),
(301, 'SO', 601, NULL, NULL, 'SOLEURE', 'Soleure', 1),
(302, 'SZ', 601, NULL, NULL, 'SCHWYZ', 'Schwyz', 1),
(303, 'TG', 601, NULL, NULL, 'THURGOVIE', 'Thurgovie', 1),
(304, 'TI', 601, NULL, NULL, 'TESSIN', 'Tessin', 1),
(305, 'UR', 601, NULL, NULL, 'URI', 'Uri', 1),
(306, 'VD', 601, NULL, NULL, 'VAUD', 'Vaud', 1),
(307, 'VS', 601, NULL, NULL, 'VALAIS', 'Valais', 1),
(308, 'ZG', 601, NULL, NULL, 'ZUG', 'Zug', 1),
(309, 'ZH', 601, NULL, NULL, 'ZURICH', 'Zürich', 1),
(310, 'AL', 1101, '', 0, 'ALABAMA', 'Alabama', 1),
(311, 'AK', 1101, '', 0, 'ALASKA', 'Alaska', 1),
(312, 'AZ', 1101, '', 0, 'ARIZONA', 'Arizona', 1),
(313, 'AR', 1101, '', 0, 'ARKANSAS', 'Arkansas', 1),
(314, 'CA', 1101, '', 0, 'CALIFORNIA', 'California', 1),
(315, 'CO', 1101, '', 0, 'COLORADO', 'Colorado', 1),
(316, 'CT', 1101, '', 0, 'CONNECTICUT', 'Connecticut', 1),
(317, 'DE', 1101, '', 0, 'DELAWARE', 'Delaware', 1),
(318, 'FL', 1101, '', 0, 'FLORIDA', 'Florida', 1),
(319, 'GA', 1101, '', 0, 'GEORGIA', 'Georgia', 1),
(320, 'HI', 1101, '', 0, 'HAWAII', 'Hawaii', 1),
(321, 'ID', 1101, '', 0, 'IDAHO', 'Idaho', 1),
(322, 'IL', 1101, '', 0, 'ILLINOIS', 'Illinois', 1),
(323, 'IN', 1101, '', 0, 'INDIANA', 'Indiana', 1),
(324, 'IA', 1101, '', 0, 'IOWA', 'Iowa', 1),
(325, 'KS', 1101, '', 0, 'KANSAS', 'Kansas', 1),
(326, 'KY', 1101, '', 0, 'KENTUCKY', 'Kentucky', 1),
(327, 'LA', 1101, '', 0, 'LOUISIANA', 'Louisiana', 1),
(328, 'ME', 1101, '', 0, 'MAINE', 'Maine', 1),
(329, 'MD', 1101, '', 0, 'MARYLAND', 'Maryland', 1),
(330, 'MA', 1101, '', 0, 'MASSACHUSSETTS', 'Massachusetts', 1),
(331, 'MI', 1101, '', 0, 'MICHIGAN', 'Michigan', 1),
(332, 'MN', 1101, '', 0, 'MINNESOTA', 'Minnesota', 1),
(333, 'MS', 1101, '', 0, 'MISSISSIPPI', 'Mississippi', 1),
(334, 'MO', 1101, '', 0, 'MISSOURI', 'Missouri', 1),
(335, 'MT', 1101, '', 0, 'MONTANA', 'Montana', 1),
(336, 'NE', 1101, '', 0, 'NEBRASKA', 'Nebraska', 1),
(337, 'NV', 1101, '', 0, 'NEVADA', 'Nevada', 1),
(338, 'NH', 1101, '', 0, 'NEW HAMPSHIRE', 'New Hampshire', 1),
(339, 'NJ', 1101, '', 0, 'NEW JERSEY', 'New Jersey', 1),
(340, 'NM', 1101, '', 0, 'NEW MEXICO', 'New Mexico', 1),
(341, 'NY', 1101, '', 0, 'NEW YORK', 'New York', 1),
(342, 'NC', 1101, '', 0, 'NORTH CAROLINA', 'North Carolina', 1),
(343, 'ND', 1101, '', 0, 'NORTH DAKOTA', 'North Dakota', 1),
(344, 'OH', 1101, '', 0, 'OHIO', 'Ohio', 1),
(345, 'OK', 1101, '', 0, 'OKLAHOMA', 'Oklahoma', 1),
(346, 'OR', 1101, '', 0, 'OREGON', 'Oregon', 1),
(347, 'PA', 1101, '', 0, 'PENNSYLVANIA', 'Pennsylvania', 1),
(348, 'RI', 1101, '', 0, 'RHODE ISLAND', 'Rhode Island', 1),
(349, 'SC', 1101, '', 0, 'SOUTH CAROLINA', 'South Carolina', 1),
(350, 'SD', 1101, '', 0, 'SOUTH DAKOTA', 'South Dakota', 1),
(351, 'TN', 1101, '', 0, 'TENNESSEE', 'Tennessee', 1),
(352, 'TX', 1101, '', 0, 'TEXAS', 'Texas', 1),
(353, 'UT', 1101, '', 0, 'UTAH', 'Utah', 1),
(354, 'VT', 1101, '', 0, 'VERMONT', 'Vermont', 1),
(355, 'VA', 1101, '', 0, 'VIRGINIA', 'Virginia', 1),
(356, 'WA', 1101, '', 0, 'WASHINGTON', 'Washington', 1),
(357, 'WV', 1101, '', 0, 'WEST VIRGINIA', 'West Virginia', 1),
(358, 'WI', 1101, '', 0, 'WISCONSIN', 'Wisconsin', 1),
(359, 'WY', 1101, '', 0, 'WYOMING', 'Wyoming', 1),
(360, 'SS', 8601, NULL, NULL, NULL, 'San Salvador', 1),
(361, 'SA', 8603, NULL, NULL, NULL, 'Santa Ana', 1),
(362, 'AH', 8603, NULL, NULL, NULL, 'Ahuachapan', 1),
(363, 'SO', 8603, NULL, NULL, NULL, 'Sonsonate', 1),
(364, 'US', 8602, NULL, NULL, NULL, 'Usulutan', 1),
(365, 'SM', 8602, NULL, NULL, NULL, 'San Miguel', 1),
(366, 'MO', 8602, NULL, NULL, NULL, 'Morazan', 1),
(367, 'LU', 8602, NULL, NULL, NULL, 'La Union', 1),
(368, 'LL', 8601, NULL, NULL, NULL, 'La Libertad', 1),
(369, 'CH', 8601, NULL, NULL, NULL, 'Chalatenango', 1),
(370, 'CA', 8601, NULL, NULL, NULL, 'Cabañas', 1),
(371, 'LP', 8601, NULL, NULL, NULL, 'La Paz', 1),
(372, 'SV', 8601, NULL, NULL, NULL, 'San Vicente', 1),
(373, 'CU', 8601, NULL, NULL, NULL, 'Cuscatlan', 1),
(374, '2301', 2301, '', 0, 'CATAMARCA', 'Catamarca', 1),
(375, '2302', 2301, '', 0, 'YUJUY', 'Yujuy', 1),
(376, '2303', 2301, '', 0, 'TUCAMAN', 'Tucamán', 1),
(377, '2304', 2301, '', 0, 'SANTIAGO DEL ESTERO', 'Santiago del Estero', 1),
(378, '2305', 2301, '', 0, 'SALTA', 'Salta', 1),
(379, '2306', 2302, '', 0, 'CHACO', 'Chaco', 1),
(380, '2307', 2302, '', 0, 'CORRIENTES', 'Corrientes', 1),
(381, '2308', 2302, '', 0, 'ENTRE RIOS', 'Entre Ríos', 1),
(382, '2309', 2302, '', 0, 'FORMOSA MISIONES', 'Formosa Misiones', 1),
(383, '2310', 2302, '', 0, 'SANTA FE', 'Santa Fe', 1),
(384, '2311', 2303, '', 0, 'LA RIOJA', 'La Rioja', 1),
(385, '2312', 2303, '', 0, 'MENDOZA', 'Mendoza', 1),
(386, '2313', 2303, '', 0, 'SAN JUAN', 'San Juan', 1),
(387, '2314', 2303, '', 0, 'SAN LUIS', 'San Luis', 1),
(388, '2315', 2304, '', 0, 'CORDOBA', 'Córdoba', 1),
(389, '2316', 2304, '', 0, 'BUENOS AIRES', 'Buenos Aires', 1),
(390, '2317', 2304, '', 0, 'CABA', 'Caba', 1),
(391, '2318', 2305, '', 0, 'LA PAMPA', 'La Pampa', 1),
(392, '2319', 2305, '', 0, 'NEUQUEN', 'Neuquén', 1),
(393, '2320', 2305, '', 0, 'RIO NEGRO', 'Río Negro', 1),
(394, '2321', 2305, '', 0, 'CHUBUT', 'Chubut', 1),
(395, '2322', 2305, '', 0, 'SANTA CRUZ', 'Santa Cruz', 1),
(396, '2323', 2305, '', 0, 'TIERRA DEL FUEGO', 'Tierra del Fuego', 1),
(397, '2324', 2305, '', 0, 'ISLAS MALVINAS', 'Islas Malvinas', 1),
(398, '2325', 2305, '', 0, 'ANTARTIDA', 'Antártida', 1),
(399, '151', 6715, '', 0, '151', 'Arica', 1),
(400, '152', 6715, '', 0, '152', 'Parinacota', 1),
(401, '011', 6701, '', 0, '011', 'Iquique', 1),
(402, '014', 6701, '', 0, '014', 'Tamarugal', 1),
(403, '021', 6702, '', 0, '021', 'Antofagasa', 1),
(404, '022', 6702, '', 0, '022', 'El Loa', 1),
(405, '023', 6702, '', 0, '023', 'Tocopilla', 1),
(406, '031', 6703, '', 0, '031', 'Copiapó', 1),
(407, '032', 6703, '', 0, '032', 'Chañaral', 1),
(408, '033', 6703, '', 0, '033', 'Huasco', 1),
(409, '041', 6704, '', 0, '041', 'Elqui', 1),
(410, '042', 6704, '', 0, '042', 'Choapa', 1),
(411, '043', 6704, '', 0, '043', 'Limarí', 1),
(412, '051', 6705, '', 0, '051', 'Valparaíso', 1),
(413, '052', 6705, '', 0, '052', 'Isla de Pascua', 1),
(414, '053', 6705, '', 0, '053', 'Los Andes', 1),
(415, '054', 6705, '', 0, '054', 'Petorca', 1),
(416, '055', 6705, '', 0, '055', 'Quillota', 1),
(417, '056', 6705, '', 0, '056', 'San Antonio', 1),
(418, '057', 6705, '', 0, '057', 'San Felipe de Aconcagua', 1),
(419, '058', 6705, '', 0, '058', 'Marga Marga', 1),
(420, '061', 6706, '', 0, '061', 'Cachapoal', 1),
(421, '062', 6706, '', 0, '062', 'Cardenal Caro', 1),
(422, '063', 6706, '', 0, '063', 'Colchagua', 1),
(423, '071', 6707, '', 0, '071', 'Talca', 1),
(424, '072', 6707, '', 0, '072', 'Cauquenes', 1),
(425, '073', 6707, '', 0, '073', 'Curicó', 1),
(426, '074', 6707, '', 0, '074', 'Linares', 1),
(427, '081', 6708, '', 0, '081', 'Concepción', 1),
(428, '082', 6708, '', 0, '082', 'Arauco', 1),
(429, '083', 6708, '', 0, '083', 'Biobío', 1),
(430, '084', 6708, '', 0, '084', 'Ñuble', 1),
(431, '091', 6709, '', 0, '091', 'Cautín', 1),
(432, '092', 6709, '', 0, '092', 'Malleco', 1),
(433, '141', 6714, '', 0, '141', 'Valdivia', 1),
(434, '142', 6714, '', 0, '142', 'Ranco', 1),
(435, '101', 6710, '', 0, '101', 'Llanquihue', 1),
(436, '102', 6710, '', 0, '102', 'Chiloé', 1),
(437, '103', 6710, '', 0, '103', 'Osorno', 1),
(438, '104', 6710, '', 0, '104', 'Palena', 1),
(439, '111', 6711, '', 0, '111', 'Coihaique', 1),
(440, '112', 6711, '', 0, '112', 'Aisén', 1),
(441, '113', 6711, '', 0, '113', 'Capitán Prat', 1),
(442, '114', 6711, '', 0, '114', 'General Carrera', 1),
(443, '121', 6712, '', 0, '121', 'Magallanes', 1),
(444, '122', 6712, '', 0, '122', 'Antártica Chilena', 1),
(445, '123', 6712, '', 0, '123', 'Tierra del Fuego', 1),
(446, '124', 6712, '', 0, '124', 'Última Esperanza', 1),
(447, '131', 6713, '', 0, '131', 'Santiago', 1),
(448, '132', 6713, '', 0, '132', 'Cordillera', 1),
(449, '133', 6713, '', 0, '133', 'Chacabuco', 1),
(450, '134', 6713, '', 0, '134', 'Maipo', 1),
(451, '135', 6713, '', 0, '135', 'Melipilla', 1),
(452, '136', 6713, '', 0, '136', 'Talagante', 1),
(453, 'AN', 11701, NULL, 0, 'AN', 'Andaman & Nicobar', 1),
(454, 'AP', 11701, NULL, 0, 'AP', 'Andhra Pradesh', 1),
(455, 'AR', 11701, NULL, 0, 'AR', 'Arunachal Pradesh', 1),
(456, 'AS', 11701, NULL, 0, 'AS', 'Assam', 1),
(457, 'BR', 11701, NULL, 0, 'BR', 'Bihar', 1),
(458, 'CG', 11701, NULL, 0, 'CG', 'Chattisgarh', 1),
(459, 'CH', 11701, NULL, 0, 'CH', 'Chandigarh', 1),
(460, 'DD', 11701, NULL, 0, 'DD', 'Daman & Diu', 1),
(461, 'DL', 11701, NULL, 0, 'DL', 'Delhi', 1),
(462, 'DN', 11701, NULL, 0, 'DN', 'Dadra and Nagar Haveli', 1),
(463, 'GA', 11701, NULL, 0, 'GA', 'Goa', 1),
(464, 'GJ', 11701, NULL, 0, 'GJ', 'Gujarat', 1),
(465, 'HP', 11701, NULL, 0, 'HP', 'Himachal Pradesh', 1),
(466, 'HR', 11701, NULL, 0, 'HR', 'Haryana', 1),
(467, 'JH', 11701, NULL, 0, 'JH', 'Jharkhand', 1),
(468, 'JK', 11701, NULL, 0, 'JK', 'Jammu & Kashmir', 1),
(469, 'KA', 11701, NULL, 0, 'KA', 'Karnataka', 1),
(470, 'KL', 11701, NULL, 0, 'KL', 'Kerala', 1),
(471, 'LD', 11701, NULL, 0, 'LD', 'Lakshadweep', 1),
(472, 'MH', 11701, NULL, 0, 'MH', 'Maharashtra', 1),
(473, 'ML', 11701, NULL, 0, 'ML', 'Meghalaya', 1),
(474, 'MN', 11701, NULL, 0, 'MN', 'Manipur', 1),
(475, 'MP', 11701, NULL, 0, 'MP', 'Madhya Pradesh', 1),
(476, 'MZ', 11701, NULL, 0, 'MZ', 'Mizoram', 1),
(477, 'NL', 11701, NULL, 0, 'NL', 'Nagaland', 1),
(478, 'OR', 11701, NULL, 0, 'OR', 'Orissa', 1),
(479, 'PB', 11701, NULL, 0, 'PB', 'Punjab', 1),
(480, 'PY', 11701, NULL, 0, 'PY', 'Puducherry', 1),
(481, 'RJ', 11701, NULL, 0, 'RJ', 'Rajasthan', 1),
(482, 'SK', 11701, NULL, 0, 'SK', 'Sikkim', 1),
(483, 'TN', 11701, NULL, 0, 'TN', 'Tamil Nadu', 1),
(484, 'TR', 11701, NULL, 0, 'TR', 'Tripura', 1),
(485, 'UL', 11701, NULL, 0, 'UL', 'Uttarakhand', 1),
(486, 'UP', 11701, NULL, 0, 'UP', 'Uttar Pradesh', 1),
(487, 'WB', 11701, NULL, 0, 'WB', 'West Bengal', 1),
(488, 'DIF', 15401, '', 0, 'DIF', 'Distrito Federal', 1),
(489, 'AGS', 15401, '', 0, 'AGS', 'Aguascalientes', 1),
(490, 'BCN', 15401, '', 0, 'BCN', 'Baja California Norte', 1),
(491, 'BCS', 15401, '', 0, 'BCS', 'Baja California Sur', 1),
(492, 'CAM', 15401, '', 0, 'CAM', 'Campeche', 1),
(493, 'CHP', 15401, '', 0, 'CHP', 'Chiapas', 1),
(494, 'CHI', 15401, '', 0, 'CHI', 'Chihuahua', 1),
(495, 'COA', 15401, '', 0, 'COA', 'Coahuila', 1),
(496, 'COL', 15401, '', 0, 'COL', 'Colima', 1),
(497, 'DUR', 15401, '', 0, 'DUR', 'Durango', 1),
(498, 'GTO', 15401, '', 0, 'GTO', 'Guanajuato', 1),
(499, 'GRO', 15401, '', 0, 'GRO', 'Guerrero', 1),
(500, 'HGO', 15401, '', 0, 'HGO', 'Hidalgo', 1),
(501, 'JAL', 15401, '', 0, 'JAL', 'Jalisco', 1),
(502, 'MEX', 15401, '', 0, 'MEX', 'México', 1),
(503, 'MIC', 15401, '', 0, 'MIC', 'Michoacán de Ocampo', 1),
(504, 'MOR', 15401, '', 0, 'MOR', 'Morelos', 1),
(505, 'NAY', 15401, '', 0, 'NAY', 'Nayarit', 1),
(506, 'NLE', 15401, '', 0, 'NLE', 'Nuevo León', 1),
(507, 'OAX', 15401, '', 0, 'OAX', 'Oaxaca', 1),
(508, 'PUE', 15401, '', 0, 'PUE', 'Puebla', 1),
(509, 'QRO', 15401, '', 0, 'QRO', 'Querétaro', 1),
(510, 'ROO', 15401, '', 0, 'ROO', 'Quintana Roo', 1),
(511, 'SLP', 15401, '', 0, 'SLP', 'San Luis Potosí', 1),
(512, 'SIN', 15401, '', 0, 'SIN', 'Sinaloa', 1),
(513, 'SON', 15401, '', 0, 'SON', 'Sonora', 1),
(514, 'TAB', 15401, '', 0, 'TAB', 'Tabasco', 1),
(515, 'TAM', 15401, '', 0, 'TAM', 'Tamaulipas', 1),
(516, 'TLX', 15401, '', 0, 'TLX', 'Tlaxcala', 1),
(517, 'VER', 15401, '', 0, 'VER', 'Veracruz', 1),
(518, 'YUC', 15401, '', 0, 'YUC', 'Yucatán', 1),
(519, 'ZAC', 15401, '', 0, 'ZAC', 'Zacatecas', 1),
(520, 'ANT', 7001, '', 0, 'ANT', 'Antioquia', 1),
(521, 'BOL', 7001, '', 0, 'BOL', 'Bolívar', 1),
(522, 'BOY', 7001, '', 0, 'BOY', 'Boyacá', 1),
(523, 'CAL', 7001, '', 0, 'CAL', 'Caldas', 1),
(524, 'CAU', 7001, '', 0, 'CAU', 'Cauca', 1),
(525, 'CUN', 7001, '', 0, 'CUN', 'Cundinamarca', 1),
(526, 'HUI', 7001, '', 0, 'HUI', 'Huila', 1),
(527, 'LAG', 7001, '', 0, 'LAG', 'La Guajira', 1),
(528, 'MET', 7001, '', 0, 'MET', 'Meta', 1),
(529, 'NAR', 7001, '', 0, 'NAR', 'Nariño', 1),
(530, 'NDS', 7001, '', 0, 'NDS', 'Norte de Santander', 1),
(531, 'SAN', 7001, '', 0, 'SAN', 'Santander', 1),
(532, 'SUC', 7001, '', 0, 'SUC', 'Sucre', 1),
(533, 'TOL', 7001, '', 0, 'TOL', 'Tolima', 1),
(534, 'VAC', 7001, '', 0, 'VAC', 'Valle del Cauca', 1),
(535, 'RIS', 7001, '', 0, 'RIS', 'Risalda', 1),
(536, 'ATL', 7001, '', 0, 'ATL', 'Atlántico', 1),
(537, 'COR', 7001, '', 0, 'COR', 'Córdoba', 1),
(538, 'SAP', 7001, '', 0, 'SAP', 'San Andrés, Providencia y Santa Catalina', 1),
(539, 'ARA', 7001, '', 0, 'ARA', 'Arauca', 1),
(540, 'CAS', 7001, '', 0, 'CAS', 'Casanare', 1),
(541, 'AMA', 7001, '', 0, 'AMA', 'Amazonas', 1),
(542, 'CAQ', 7001, '', 0, 'CAQ', 'Caquetá', 1),
(543, 'CHO', 7001, '', 0, 'CHO', 'Chocó', 1),
(544, 'GUA', 7001, '', 0, 'GUA', 'Guainía', 1),
(545, 'GUV', 7001, '', 0, 'GUV', 'Guaviare', 1),
(546, 'PUT', 7001, '', 0, 'PUT', 'Putumayo', 1),
(547, 'QUI', 7001, '', 0, 'QUI', 'Quindío', 1),
(548, 'VAU', 7001, '', 0, 'VAU', 'Vaupés', 1),
(549, 'BOG', 7001, '', 0, 'BOG', 'Bogotá', 1),
(550, 'VID', 7001, '', 0, 'VID', 'Vichada', 1),
(551, 'CES', 7001, '', 0, 'CES', 'Cesar', 1),
(552, 'MAG', 7001, '', 0, 'MAG', 'Magdalena', 1),
(553, 'AT', 11401, '', 0, 'AT', 'Atlántida', 1),
(554, 'CH', 11401, '', 0, 'CH', 'Choluteca', 1),
(555, 'CL', 11401, '', 0, 'CL', 'Colón', 1),
(556, 'CM', 11401, '', 0, 'CM', 'Comayagua', 1),
(557, 'CO', 11401, '', 0, 'CO', 'Copán', 1),
(558, 'CR', 11401, '', 0, 'CR', 'Cortés', 1),
(559, 'EP', 11401, '', 0, 'EP', 'El Paraíso', 1),
(560, 'FM', 11401, '', 0, 'FM', 'Francisco Morazán', 1),
(561, 'GD', 11401, '', 0, 'GD', 'Gracias a Dios', 1),
(562, 'IN', 11401, '', 0, 'IN', 'Intibucá', 1),
(563, 'IB', 11401, '', 0, 'IB', 'Islas de la Bahía', 1),
(564, 'LP', 11401, '', 0, 'LP', 'La Paz', 1),
(565, 'LM', 11401, '', 0, 'LM', 'Lempira', 1),
(566, 'OC', 11401, '', 0, 'OC', 'Ocotepeque', 1),
(567, 'OL', 11401, '', 0, 'OL', 'Olancho', 1),
(568, 'SB', 11401, '', 0, 'SB', 'Santa Bárbara', 1),
(569, 'VL', 11401, '', 0, 'VL', 'Valle', 1),
(570, 'YO', 11401, '', 0, 'YO', 'Yoro', 1),
(571, 'DC', 11401, '', 0, 'DC', 'Distrito Central', 1),
(572, 'CC', 4601, 'Oistins', 0, 'CC', 'Christ Church', 1),
(573, 'SA', 4601, 'Greenland', 0, 'SA', 'Saint Andrew', 1),
(574, 'SG', 4601, 'Bulkeley', 0, 'SG', 'Saint George', 1),
(575, 'JA', 4601, 'Holetown', 0, 'JA', 'Saint James', 1),
(576, 'SJ', 4601, 'Four Roads', 0, 'SJ', 'Saint John', 1),
(577, 'SB', 4601, 'Bathsheba', 0, 'SB', 'Saint Joseph', 1),
(578, 'SL', 4601, 'Crab Hill', 0, 'SL', 'Saint Lucy', 1),
(579, 'SM', 4601, 'Bridgetown', 0, 'SM', 'Saint Michael', 1),
(580, 'SP', 4601, 'Speightstown', 0, 'SP', 'Saint Peter', 1),
(581, 'SC', 4601, 'Crane', 0, 'SC', 'Saint Philip', 1),
(582, 'ST', 4601, 'Hillaby', 0, 'ST', 'Saint Thomas', 1),
(583, '1000', 1000, NULL, NULL, NULL, 'Belo Horizonte', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_c_ecotaxe`
--

CREATE TABLE IF NOT EXISTS `llx_c_ecotaxe` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(64) NOT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `price` double(24,8) DEFAULT NULL,
  `organization` varchar(255) DEFAULT NULL,
  `fk_pays` int(11) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_c_ecotaxe` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=39 ;

--
-- Extraindo dados da tabela `llx_c_ecotaxe`
--

INSERT INTO `llx_c_ecotaxe` (`rowid`, `code`, `libelle`, `price`, `organization`, `fk_pays`, `active`) VALUES
(1, 'ER-A-A', 'Materiels electriques < 0,2kg', 0.01000000, 'ERP', 1, 1),
(2, 'ER-A-B', 'Materiels electriques >= 0,2 kg et < 0,5 kg', 0.03000000, 'ERP', 1, 1),
(3, 'ER-A-C', 'Materiels electriques >= 0,5 kg et < 1 kg', 0.04000000, 'ERP', 1, 1),
(4, 'ER-A-D', 'Materiels electriques >= 1 kg et < 2 kg', 0.13000000, 'ERP', 1, 1),
(5, 'ER-A-E', 'Materiels electriques >= 2 kg et < 4kg', 0.21000000, 'ERP', 1, 1),
(6, 'ER-A-F', 'Materiels electriques >= 4 kg et < 8 kg', 0.42000000, 'ERP', 1, 1),
(7, 'ER-A-G', 'Materiels electriques >= 8 kg et < 15 kg', 0.84000000, 'ERP', 1, 1),
(8, 'ER-A-H', 'Materiels electriques >= 15 kg et < 20 kg', 1.25000000, 'ERP', 1, 1),
(9, 'ER-A-I', 'Materiels electriques >= 20 kg et < 30 kg', 1.88000000, 'ERP', 1, 1),
(10, 'ER-A-J', 'Materiels electriques >= 30 kg', 3.34000000, 'ERP', 1, 1),
(11, 'ER-M-1', 'TV, Moniteurs < 9kg', 0.84000000, 'ERP', 1, 1),
(12, 'ER-M-2', 'TV, Moniteurs >= 9kg et < 15kg', 1.67000000, 'ERP', 1, 1),
(13, 'ER-M-3', 'TV, Moniteurs >= 15kg et < 30kg', 3.34000000, 'ERP', 1, 1),
(14, 'ER-M-4', 'TV, Moniteurs >= 30 kg', 6.69000000, 'ERP', 1, 1),
(15, 'EC-A-A', 'Materiels electriques  0,2 kg max', 0.00840000, 'Ecologic', 1, 1),
(16, 'EC-A-B', 'Materiels electriques 0,21 kg min - 0,50 kg max', 0.02500000, 'Ecologic', 1, 1),
(17, 'EC-A-C', 'Materiels electriques  0,51 kg min - 1 kg max', 0.04000000, 'Ecologic', 1, 1),
(18, 'EC-A-D', 'Materiels electriques  1,01 kg min - 2,5 kg max', 0.13000000, 'Ecologic', 1, 1),
(19, 'EC-A-E', 'Materiels electriques  2,51 kg min - 4 kg max', 0.21000000, 'Ecologic', 1, 1),
(20, 'EC-A-F', 'Materiels electriques 4,01 kg min - 8 kg max', 0.42000000, 'Ecologic', 1, 1),
(21, 'EC-A-G', 'Materiels electriques  8,01 kg min - 12 kg max', 0.63000000, 'Ecologic', 1, 1),
(22, 'EC-A-H', 'Materiels electriques 12,01 kg min - 20 kg max', 1.05000000, 'Ecologic', 1, 1),
(23, 'EC-A-I', 'Materiels electriques  20,01 kg min', 1.88000000, 'Ecologic', 1, 1),
(24, 'EC-M-1', 'TV, Moniteurs 9 kg max', 0.84000000, 'Ecologic', 1, 1),
(25, 'EC-M-2', 'TV, Moniteurs 9,01 kg min - 18 kg max', 1.67000000, 'Ecologic', 1, 1),
(26, 'EC-M-3', 'TV, Moniteurs 18,01 kg min - 36 kg max', 3.34000000, 'Ecologic', 1, 1),
(27, 'EC-M-4', 'TV, Moniteurs 36,01 kg min', 6.69000000, 'Ecologic', 1, 1),
(28, 'ES-M-1', 'TV, Moniteurs <= 20 pouces', 0.84000000, 'Eco-systemes', 1, 1),
(29, 'ES-M-2', 'TV, Moniteurs > 20 pouces et <= 32 pouces', 3.34000000, 'Eco-systemes', 1, 1),
(30, 'ES-M-3', 'TV, Moniteurs > 32 pouces et autres grands ecrans', 6.69000000, 'Eco-systemes', 1, 1),
(31, 'ES-A-A', 'Ordinateur fixe, Audio home systems (HIFI), elements hifi separes', 0.84000000, 'Eco-systemes', 1, 1),
(32, 'ES-A-B', 'Ordinateur portable, CD-RCR, VCR, lecteurs et enregistreurs DVD, instruments de musique et caisses de resonance, haut parleurs...', 0.25000000, 'Eco-systemes', 1, 1),
(33, 'ES-A-C', 'Imprimante, photocopieur, telecopieur', 0.42000000, 'Eco-systemes', 1, 1),
(34, 'ES-A-D', 'Accessoires, clavier, souris, PDA, imprimante photo, appareil photo, gps, telephone, repondeur, telephone sans fil, modem, telecommande, casque, camescope, baladeur mp3, radio portable, radio K7 et CD portable, radio reveil', 0.08400000, 'Eco-systemes', 1, 1),
(35, 'ES-A-E', 'GSM', 0.00840000, 'Eco-systemes', 1, 1),
(36, 'ES-A-F', 'Jouets et equipements de loisirs et de sports < 0,5 kg', 0.04200000, 'Eco-systemes', 1, 1),
(37, 'ES-A-G', 'Jouets et equipements de loisirs et de sports > 0,5 kg', 0.17000000, 'Eco-systemes', 1, 1),
(38, 'ES-A-H', 'Jouets et equipements de loisirs et de sports > 10 kg', 1.25000000, 'Eco-systemes', 1, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_c_effectif`
--

CREATE TABLE IF NOT EXISTS `llx_c_effectif` (
  `id` int(11) NOT NULL,
  `code` varchar(12) NOT NULL,
  `libelle` varchar(30) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `module` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `llx_c_effectif`
--

INSERT INTO `llx_c_effectif` (`id`, `code`, `libelle`, `active`, `module`) VALUES
(0, 'EF0', '-', 1, NULL),
(1, 'EF1-5', '1 - 5', 1, NULL),
(2, 'EF6-10', '6 - 10', 1, NULL),
(3, 'EF11-50', '11 - 50', 1, NULL),
(4, 'EF51-100', '51 - 100', 1, NULL),
(5, 'EF100-500', '100 - 500', 1, NULL),
(6, 'EF500-', '> 500', 1, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_c_field_list`
--

CREATE TABLE IF NOT EXISTS `llx_c_field_list` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `element` varchar(64) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `name` varchar(32) NOT NULL,
  `alias` varchar(32) NOT NULL,
  `title` varchar(32) NOT NULL,
  `align` varchar(6) DEFAULT 'left',
  `sort` tinyint(4) NOT NULL DEFAULT '1',
  `search` tinyint(4) NOT NULL DEFAULT '0',
  `enabled` varchar(255) DEFAULT '1',
  `rang` int(11) DEFAULT '0',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_c_forme_juridique`
--

CREATE TABLE IF NOT EXISTS `llx_c_forme_juridique` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` int(11) NOT NULL,
  `fk_pays` int(11) NOT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `isvatexempted` tinyint(4) NOT NULL DEFAULT '0',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `module` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_c_forme_juridique` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=151 ;

--
-- Extraindo dados da tabela `llx_c_forme_juridique`
--

INSERT INTO `llx_c_forme_juridique` (`rowid`, `code`, `fk_pays`, `libelle`, `isvatexempted`, `active`, `module`) VALUES
(1, 0, 0, '-', 0, 1, NULL),
(2, 2301, 23, 'Monotributista', 0, 1, NULL),
(3, 2302, 23, 'Sociedad Civil', 0, 1, NULL),
(4, 2303, 23, 'Sociedades Comerciales', 0, 1, NULL),
(5, 2304, 23, 'Sociedades de Hecho', 0, 1, NULL),
(6, 2305, 23, 'Sociedades Irregulares', 0, 1, NULL),
(7, 2306, 23, 'Sociedad Colectiva', 0, 1, NULL),
(8, 2307, 23, 'Sociedad en Comandita Simple', 0, 1, NULL),
(9, 2308, 23, 'Sociedad de Capital e Industria', 0, 1, NULL),
(10, 2309, 23, 'Sociedad Accidental o en participación', 0, 1, NULL),
(11, 2310, 23, 'Sociedad de Responsabilidad Limitada', 0, 1, NULL),
(12, 2311, 23, 'Sociedad Anónima', 0, 1, NULL),
(13, 2312, 23, 'Sociedad Anónima con Participación Estatal Mayoritaria', 0, 1, NULL),
(14, 2313, 23, 'Sociedad en Comandita por Acciones (arts. 315 a 324, LSC)', 0, 1, NULL),
(15, 11, 1, 'Artisan Commerçant (EI)', 0, 1, NULL),
(16, 12, 1, 'Commerçant (EI)', 0, 1, NULL),
(17, 13, 1, 'Artisan (EI)', 0, 1, NULL),
(18, 14, 1, 'Officier public ou ministériel', 0, 1, NULL),
(19, 15, 1, 'Profession libérale (EI)', 0, 1, NULL),
(20, 16, 1, 'Exploitant agricole', 0, 1, NULL),
(21, 17, 1, 'Agent commercial', 0, 1, NULL),
(22, 18, 1, 'Associé Gérant de société', 0, 1, NULL),
(23, 19, 1, 'Personne physique', 0, 1, NULL),
(24, 21, 1, 'Indivision', 0, 1, NULL),
(25, 22, 1, 'Société créée de fait', 0, 1, NULL),
(26, 23, 1, 'Société en participation', 0, 1, NULL),
(27, 27, 1, 'Paroisse hors zone concordataire', 0, 1, NULL),
(28, 29, 1, 'Groupement de droit privé non doté de la personnalité morale', 0, 1, NULL),
(29, 31, 1, 'Personne morale de droit étranger, immatriculée au RCS', 0, 1, NULL),
(30, 32, 1, 'Personne morale de droit étranger, non immatriculée au RCS', 0, 1, NULL),
(31, 35, 1, 'Régime auto-entrepreneur', 0, 1, NULL),
(32, 41, 1, 'Établissement public ou régie à caractère industriel ou commercial', 0, 1, NULL),
(33, 51, 1, 'Société coopérative commerciale particulière', 0, 1, NULL),
(34, 52, 1, 'Société en nom collectif', 0, 1, NULL),
(35, 53, 1, 'Société en commandite', 0, 1, NULL),
(36, 54, 1, 'Société à responsabilité limitée (SARL)', 0, 1, NULL),
(37, 55, 1, 'Société anonyme à conseil d administration', 0, 1, NULL),
(38, 56, 1, 'Société anonyme à directoire', 0, 1, NULL),
(39, 57, 1, 'Société par actions simplifiée', 0, 1, NULL),
(40, 58, 1, 'Entreprise Unipersonnelle à Responsabilité Limitée (EURL)', 0, 1, NULL),
(41, 61, 1, 'Caisse d''épargne et de prévoyance', 0, 1, NULL),
(42, 62, 1, 'Groupement d''intérêt économique (GIE)', 0, 1, NULL),
(43, 63, 1, 'Société coopérative agricole', 0, 1, NULL),
(44, 64, 1, 'Société non commerciale d assurances', 0, 1, NULL),
(45, 65, 1, 'Société civile', 0, 1, NULL),
(46, 69, 1, 'Personnes de droit privé inscrites au RCS', 0, 1, NULL),
(47, 71, 1, 'Administration de l état', 0, 1, NULL),
(48, 72, 1, 'Collectivité territoriale', 0, 1, NULL),
(49, 73, 1, 'Établissement public administratif', 0, 1, NULL),
(50, 74, 1, 'Personne morale de droit public administratif', 0, 1, NULL),
(51, 81, 1, 'Organisme gérant régime de protection social à adhésion obligatoire', 0, 1, NULL),
(52, 82, 1, 'Organisme mutualiste', 0, 1, NULL),
(53, 83, 1, 'Comité d entreprise', 0, 1, NULL),
(54, 84, 1, 'Organisme professionnel', 0, 1, NULL),
(55, 85, 1, 'Organisme de retraite à adhésion non obligatoire', 0, 1, NULL),
(56, 91, 1, 'Syndicat de propriétaires', 0, 1, NULL),
(57, 92, 1, 'Association loi 1901 ou assimilé', 0, 1, NULL),
(58, 93, 1, 'Fondation', 0, 1, NULL),
(59, 99, 1, 'Personne morale de droit privé', 0, 1, NULL),
(60, 200, 2, 'Indépendant', 0, 1, NULL),
(61, 201, 2, 'SPRL - Société à responsabilité limitée', 0, 1, NULL),
(62, 202, 2, 'SA   - Société Anonyme', 0, 1, NULL),
(63, 203, 2, 'SCRL - Société coopérative à responsabilité limitée', 0, 1, NULL),
(64, 204, 2, 'ASBL - Association sans but Lucratif', 0, 1, NULL),
(65, 205, 2, 'SCRI - Société coopérative à responsabilité illimitée', 0, 1, NULL),
(66, 206, 2, 'SCS  - Société en commandite simple', 0, 1, NULL),
(67, 207, 2, 'SCA  - Société en commandite par action', 0, 1, NULL),
(68, 208, 2, 'SNC  - Société en nom collectif', 0, 1, NULL),
(69, 209, 2, 'GIE  - Groupement d intérêt économique', 0, 1, NULL),
(70, 210, 2, 'GEIE - Groupement européen d intérêt économique', 0, 1, NULL),
(71, 500, 5, 'Limited liability corporation (GmbH)', 0, 1, NULL),
(72, 501, 5, 'Stock corporation (AG)', 0, 1, NULL),
(73, 502, 5, 'Partnerships general or limited (GmbH & CO. KG)', 0, 1, NULL),
(74, 503, 5, 'Sole proprietor / Private business', 0, 1, NULL),
(75, 301, 3, 'Società semplice', 0, 1, NULL),
(76, 302, 3, 'Società in nome collettivo s.n.c.', 0, 1, NULL),
(77, 303, 3, 'Società in accomandita semplice s.a.s.', 0, 1, NULL),
(78, 304, 3, 'Società per azioni s.p.a.', 0, 1, NULL),
(79, 305, 3, 'Società a responsabilità limitata s.r.l.', 0, 1, NULL),
(80, 306, 3, 'Società in accomandita per azioni s.a.p.a.', 0, 1, NULL),
(81, 307, 3, 'Società cooperativa', 0, 1, NULL),
(82, 308, 3, 'Società consortile', 0, 1, NULL),
(83, 309, 3, 'Società europea', 0, 1, NULL),
(84, 310, 3, 'Società cooperativa europea', 0, 1, NULL),
(85, 311, 3, 'Società unipersonale', 0, 1, NULL),
(86, 312, 3, 'Società di professionisti', 0, 1, NULL),
(87, 313, 3, 'Società di fatto', 0, 1, NULL),
(88, 314, 3, 'Società occulta', 0, 1, NULL),
(89, 315, 3, 'Società apparente', 0, 1, NULL),
(90, 316, 3, 'Impresa individuale ', 0, 1, NULL),
(91, 317, 3, 'Impresa coniugale', 0, 1, NULL),
(92, 318, 3, 'Impresa familiare', 0, 1, NULL),
(93, 600, 6, 'Raison Individuelle', 0, 1, NULL),
(94, 601, 6, 'Société Simple', 0, 1, NULL),
(95, 602, 6, 'Société en nom collectif', 0, 1, NULL),
(96, 603, 6, 'Société en commandite', 0, 1, NULL),
(97, 604, 6, 'Société anonyme (SA)', 0, 1, NULL),
(98, 605, 6, 'Société en commandite par actions', 0, 1, NULL),
(99, 606, 6, 'Société à responsabilité limitée (SARL)', 0, 1, NULL),
(100, 607, 6, 'Société coopérative', 0, 1, NULL),
(101, 608, 6, 'Association', 0, 1, NULL),
(102, 609, 6, 'Fondation', 0, 1, NULL),
(103, 700, 7, 'Sole Trader', 0, 1, NULL),
(104, 701, 7, 'Partnership', 0, 1, NULL),
(105, 702, 7, 'Private Limited Company by shares (LTD)', 0, 1, NULL),
(106, 703, 7, 'Public Limited Company', 0, 1, NULL),
(107, 704, 7, 'Workers Cooperative', 0, 1, NULL),
(108, 705, 7, 'Limited Liability Partnership', 0, 1, NULL),
(109, 706, 7, 'Franchise', 0, 1, NULL),
(110, 1000, 10, 'Société à responsabilité limitée (SARL)', 0, 1, NULL),
(111, 1001, 10, 'Société en Nom Collectif (SNC)', 0, 1, NULL),
(112, 1002, 10, 'Société en Commandite Simple (SCS)', 0, 1, NULL),
(113, 1003, 10, 'société en participation', 0, 1, NULL),
(114, 1004, 10, 'Société Anonyme (SA)', 0, 1, NULL),
(115, 1005, 10, 'Société Unipersonnelle à Responsabilité Limitée (SUARL)', 0, 1, NULL),
(116, 1006, 10, 'Groupement d''intérêt économique (GEI)', 0, 1, NULL),
(117, 1007, 10, 'Groupe de sociétés', 0, 1, NULL),
(118, 401, 4, 'Empresario Individual', 0, 1, NULL),
(119, 402, 4, 'Comunidad de Bienes', 0, 1, NULL),
(120, 403, 4, 'Sociedad Civil', 0, 1, NULL),
(121, 404, 4, 'Sociedad Colectiva', 0, 1, NULL),
(122, 405, 4, 'Sociedad Limitada', 0, 1, NULL),
(123, 406, 4, 'Sociedad Anónima', 0, 1, NULL),
(124, 407, 4, 'Sociedad Comandataria por Acciones', 0, 1, NULL),
(125, 408, 4, 'Sociedad Comandataria Simple', 0, 1, NULL),
(126, 409, 4, 'Sociedad Laboral', 0, 1, NULL),
(127, 410, 4, 'Sociedad Cooperativa', 0, 1, NULL),
(128, 411, 4, 'Sociedad de Garantía Recíproca', 0, 1, NULL),
(129, 412, 4, 'Entidad de Capital-Riesgo', 0, 1, NULL),
(130, 413, 4, 'Agrupación de Interés Económico', 0, 1, NULL),
(131, 414, 4, 'Sociedad de Inversión Mobiliaria', 0, 1, NULL),
(132, 415, 4, 'Agrupación sin Ánimo de Lucro', 0, 1, NULL),
(133, 15201, 152, 'Mauritius Private Company Limited By Shares', 0, 1, NULL),
(134, 15202, 152, 'Mauritius Company Limited By Guarantee', 0, 1, NULL),
(135, 15203, 152, 'Mauritius Public Company Limited By Shares', 0, 1, NULL),
(136, 15204, 152, 'Mauritius Foreign Company', 0, 1, NULL),
(137, 15205, 152, 'Mauritius GBC1 (Offshore Company)', 0, 1, NULL),
(138, 15206, 152, 'Mauritius GBC2 (International Company)', 0, 1, NULL),
(139, 15207, 152, 'Mauritius General Partnership', 0, 1, NULL),
(140, 15208, 152, 'Mauritius Limited Partnership', 0, 1, NULL),
(141, 15209, 152, 'Mauritius Sole Proprietorship', 0, 1, NULL),
(142, 15210, 152, 'Mauritius Trusts', 0, 1, NULL),
(143, 15401, 154, 'Sociedad en nombre colectivo', 0, 1, NULL),
(144, 15402, 154, 'Sociedad en comandita simple', 0, 1, NULL),
(145, 15403, 154, 'Sociedad de responsabilidad limitada', 0, 1, NULL),
(146, 15404, 154, 'Sociedad anónima', 0, 1, NULL),
(147, 15405, 154, 'Sociedad en comandita por acciones', 0, 1, NULL),
(148, 15406, 154, 'Sociedad cooperativa', 0, 1, NULL),
(150, 2000, 25, 'Empresa tipo 1', 0, 1, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_c_input_method`
--

CREATE TABLE IF NOT EXISTS `llx_c_input_method` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(30) DEFAULT NULL,
  `libelle` varchar(60) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `module` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_c_input_method` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Extraindo dados da tabela `llx_c_input_method`
--

INSERT INTO `llx_c_input_method` (`rowid`, `code`, `libelle`, `active`, `module`) VALUES
(1, 'OrderByMail', 'Courrier', 1, NULL),
(2, 'OrderByFax', 'Fax', 1, NULL),
(3, 'OrderByEMail', 'EMail', 1, NULL),
(4, 'OrderByPhone', 'Téléphone', 1, NULL),
(5, 'OrderByWWW', 'En ligne', 1, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_c_input_reason`
--

CREATE TABLE IF NOT EXISTS `llx_c_input_reason` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(30) DEFAULT NULL,
  `label` varchar(60) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `module` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_c_input_reason` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Extraindo dados da tabela `llx_c_input_reason`
--

INSERT INTO `llx_c_input_reason` (`rowid`, `code`, `label`, `active`, `module`) VALUES
(1, 'SRC_INTE', 'Web site', 1, NULL),
(2, 'SRC_CAMP_MAIL', 'Mailing campaign', 1, NULL),
(3, 'SRC_CAMP_PHO', 'Phone campaign', 1, NULL),
(4, 'SRC_CAMP_FAX', 'Fax campaign', 1, NULL),
(5, 'SRC_COMM', 'Commercial contact', 1, NULL),
(6, 'SRC_SHOP', 'Shop contact', 1, NULL),
(7, 'SRC_CAMP_EMAIL', 'EMailing campaign', 1, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_c_paiement`
--

CREATE TABLE IF NOT EXISTS `llx_c_paiement` (
  `id` int(11) NOT NULL,
  `code` varchar(6) NOT NULL,
  `libelle` varchar(30) DEFAULT NULL,
  `type` smallint(6) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `module` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `llx_c_paiement`
--

INSERT INTO `llx_c_paiement` (`id`, `code`, `libelle`, `type`, `active`, `module`) VALUES
(0, '', '-', 3, 1, NULL),
(1, 'TIP', 'TIP', 2, 1, NULL),
(2, 'VIR', 'Virement', 2, 1, NULL),
(3, 'PRE', 'Prélèvement', 2, 1, NULL),
(4, 'LIQ', 'Espèces', 2, 1, NULL),
(5, 'VAD', 'Paiement en ligne', 2, 0, NULL),
(6, 'CB', 'Carte Bancaire', 2, 1, NULL),
(7, 'CHQ', 'Chèque', 2, 1, NULL),
(8, 'TRA', 'Traite', 2, 0, NULL),
(9, 'LCR', 'LCR', 2, 0, NULL),
(10, 'FAC', 'Factor', 2, 0, NULL),
(11, 'PRO', 'Proforma', 2, 0, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_c_paper_format`
--

CREATE TABLE IF NOT EXISTS `llx_c_paper_format` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(16) NOT NULL,
  `label` varchar(50) NOT NULL,
  `width` float(6,2) DEFAULT '0.00',
  `height` float(6,2) DEFAULT '0.00',
  `unit` varchar(5) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `module` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=226 ;

--
-- Extraindo dados da tabela `llx_c_paper_format`
--

INSERT INTO `llx_c_paper_format` (`rowid`, `code`, `label`, `width`, `height`, `unit`, `active`, `module`) VALUES
(1, 'EU4A0', 'Format 4A0', 1682.00, 2378.00, 'mm', 1, NULL),
(2, 'EU2A0', 'Format 2A0', 1189.00, 1682.00, 'mm', 1, NULL),
(3, 'EUA0', 'Format A0', 840.00, 1189.00, 'mm', 1, NULL),
(4, 'EUA1', 'Format A1', 594.00, 840.00, 'mm', 1, NULL),
(5, 'EUA2', 'Format A2', 420.00, 594.00, 'mm', 1, NULL),
(6, 'EUA3', 'Format A3', 297.00, 420.00, 'mm', 1, NULL),
(7, 'EUA4', 'Format A4', 210.00, 297.00, 'mm', 1, NULL),
(8, 'EUA5', 'Format A5', 148.00, 210.00, 'mm', 1, NULL),
(9, 'EUA6', 'Format A6', 105.00, 148.00, 'mm', 1, NULL),
(100, 'USLetter', 'Format Letter (A)', 216.00, 279.00, 'mm', 1, NULL),
(105, 'USLegal', 'Format Legal', 216.00, 356.00, 'mm', 1, NULL),
(110, 'USExecutive', 'Format Executive', 190.00, 254.00, 'mm', 1, NULL),
(115, 'USLedger', 'Format Ledger/Tabloid (B)', 279.00, 432.00, 'mm', 1, NULL),
(200, 'CAP1', 'Format Canadian P1', 560.00, 860.00, 'mm', 1, NULL),
(205, 'CAP2', 'Format Canadian P2', 430.00, 560.00, 'mm', 1, NULL),
(210, 'CAP3', 'Format Canadian P3', 280.00, 430.00, 'mm', 1, NULL),
(215, 'CAP4', 'Format Canadian P4', 215.00, 280.00, 'mm', 1, NULL),
(220, 'CAP5', 'Format Canadian P5', 140.00, 215.00, 'mm', 1, NULL),
(225, 'CAP6', 'Format Canadian P6', 107.00, 140.00, 'mm', 1, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_c_payment_term`
--

CREATE TABLE IF NOT EXISTS `llx_c_payment_term` (
  `rowid` int(11) NOT NULL,
  `code` varchar(16) DEFAULT NULL,
  `sortorder` smallint(6) DEFAULT NULL,
  `active` tinyint(4) DEFAULT '1',
  `libelle` varchar(255) DEFAULT NULL,
  `libelle_facture` text,
  `fdm` tinyint(4) DEFAULT NULL,
  `nbjour` smallint(6) DEFAULT NULL,
  `decalage` smallint(6) DEFAULT NULL,
  `module` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `llx_c_payment_term`
--

INSERT INTO `llx_c_payment_term` (`rowid`, `code`, `sortorder`, `active`, `libelle`, `libelle_facture`, `fdm`, `nbjour`, `decalage`, `module`) VALUES
(1, 'RECEP', 1, 1, 'A réception', 'Réception de facture', 0, 0, NULL, NULL),
(2, '30D', 2, 1, '30 jours', 'Réglement à 30 jours', 0, 30, NULL, NULL),
(3, '30DENDMONTH', 3, 1, '30 jours fin de mois', 'Réglement à 30 jours fin de mois', 1, 30, NULL, NULL),
(4, '60D', 4, 1, '60 jours', 'Réglement à 60 jours', 0, 60, NULL, NULL),
(5, '60DENDMONTH', 5, 1, '60 jours fin de mois', 'Réglement à 60 jours fin de mois', 1, 60, NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_c_pays`
--

CREATE TABLE IF NOT EXISTS `llx_c_pays` (
  `rowid` int(11) NOT NULL,
  `code` varchar(2) NOT NULL,
  `code_iso` varchar(3) DEFAULT NULL,
  `libelle` varchar(50) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `idx_c_pays_code` (`code`),
  UNIQUE KEY `idx_c_pays_libelle` (`libelle`),
  UNIQUE KEY `idx_c_pays_code_iso` (`code_iso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `llx_c_pays`
--

INSERT INTO `llx_c_pays` (`rowid`, `code`, `code_iso`, `libelle`, `active`) VALUES
(0, '', NULL, '-', 1),
(1, 'FR', NULL, 'France', 1),
(2, 'BE', NULL, 'Belgium', 1),
(3, 'IT', NULL, 'Italy', 1),
(4, 'ES', NULL, 'Spain', 1),
(5, 'DE', NULL, 'Germany', 1),
(6, 'CH', NULL, 'Suisse', 1),
(7, 'GB', NULL, 'United Kingdom', 1),
(8, 'IE', NULL, 'Irland', 1),
(9, 'CN', NULL, 'China', 1),
(10, 'TN', NULL, 'Tunisie', 1),
(11, 'US', NULL, 'United States', 1),
(12, 'MA', NULL, 'Maroc', 1),
(13, 'DZ', NULL, 'Algérie', 1),
(14, 'CA', NULL, 'Canada', 1),
(15, 'TG', NULL, 'Togo', 1),
(16, 'GA', NULL, 'Gabon', 1),
(17, 'NL', NULL, 'Nerderland', 1),
(18, 'HU', NULL, 'Hongrie', 1),
(19, 'RU', NULL, 'Russia', 1),
(20, 'SE', NULL, 'Sweden', 1),
(21, 'CI', NULL, 'Côte d''Ivoire', 1),
(22, 'SN', NULL, 'Sénégal', 1),
(23, 'AR', NULL, 'Argentine', 1),
(24, 'CM', NULL, 'Cameroun', 1),
(25, 'PT', NULL, 'Portugal', 1),
(26, 'SA', NULL, 'Arabie Saoudite', 1),
(27, 'MC', NULL, 'Monaco', 1),
(28, 'AU', NULL, 'Australia', 1),
(29, 'SG', NULL, 'Singapour', 1),
(30, 'AF', NULL, 'Afghanistan', 1),
(31, 'AX', NULL, 'Iles Aland', 1),
(32, 'AL', NULL, 'Albanie', 1),
(33, 'AS', NULL, 'Samoa américaines', 1),
(34, 'AD', NULL, 'Andorre', 1),
(35, 'AO', NULL, 'Angola', 1),
(36, 'AI', NULL, 'Anguilla', 1),
(37, 'AQ', NULL, 'Antarctique', 1),
(38, 'AG', NULL, 'Antigua-et-Barbuda', 1),
(39, 'AM', NULL, 'Arménie', 1),
(40, 'AW', NULL, 'Aruba', 1),
(41, 'AT', NULL, 'Autriche', 1),
(42, 'AZ', NULL, 'Azerbaïdjan', 1),
(43, 'BS', NULL, 'Bahamas', 1),
(44, 'BH', NULL, 'Bahreïn', 1),
(45, 'BD', NULL, 'Bangladesh', 1),
(46, 'BB', NULL, 'Barbade', 1),
(47, 'BY', NULL, 'Biélorussie', 1),
(48, 'BZ', NULL, 'Belize', 1),
(49, 'BJ', NULL, 'Bénin', 1),
(50, 'BM', NULL, 'Bermudes', 1),
(51, 'BT', NULL, 'Bhoutan', 1),
(52, 'BO', NULL, 'Bolivie', 1),
(53, 'BA', NULL, 'Bosnie-Herzégovine', 1),
(54, 'BW', NULL, 'Botswana', 1),
(55, 'BV', NULL, 'Ile Bouvet', 1),
(56, 'BR', NULL, 'Brésil', 1),
(57, 'IO', NULL, 'Territoire britannique de l''Océan Indien', 1),
(58, 'BN', NULL, 'Brunei', 1),
(59, 'BG', NULL, 'Bulgarie', 1),
(60, 'BF', NULL, 'Burkina Faso', 1),
(61, 'BI', NULL, 'Burundi', 1),
(62, 'KH', NULL, 'Cambodge', 1),
(63, 'CV', NULL, 'Cap-Vert', 1),
(64, 'KY', NULL, 'Iles Cayman', 1),
(65, 'CF', NULL, 'République centrafricaine', 1),
(66, 'TD', NULL, 'Tchad', 1),
(67, 'CL', NULL, 'Chili', 1),
(68, 'CX', NULL, 'Ile Christmas', 1),
(69, 'CC', NULL, 'Iles des Cocos (Keeling)', 1),
(70, 'CO', NULL, 'Colombie', 1),
(71, 'KM', NULL, 'Comores', 1),
(72, 'CG', NULL, 'Congo', 1),
(73, 'CD', NULL, 'République démocratique du Congo', 1),
(74, 'CK', NULL, 'Iles Cook', 1),
(75, 'CR', NULL, 'Costa Rica', 1),
(76, 'HR', NULL, 'Croatie', 1),
(77, 'CU', NULL, 'Cuba', 1),
(78, 'CY', NULL, 'Chypre', 1),
(79, 'CZ', NULL, 'République Tchèque', 1),
(80, 'DK', NULL, 'Danemark', 1),
(81, 'DJ', NULL, 'Djibouti', 1),
(82, 'DM', NULL, 'Dominique', 1),
(83, 'DO', NULL, 'République Dominicaine', 1),
(84, 'EC', NULL, 'Equateur', 1),
(85, 'EG', NULL, 'Egypte', 1),
(86, 'SV', NULL, 'Salvador', 1),
(87, 'GQ', NULL, 'Guinée Equatoriale', 1),
(88, 'ER', NULL, 'Erythrée', 1),
(89, 'EE', NULL, 'Estonie', 1),
(90, 'ET', NULL, 'Ethiopie', 1),
(91, 'FK', NULL, 'Iles Falkland', 1),
(92, 'FO', NULL, 'Iles Féroé', 1),
(93, 'FJ', NULL, 'Iles Fidji', 1),
(94, 'FI', NULL, 'Finlande', 1),
(95, 'GF', NULL, 'Guyane française', 1),
(96, 'PF', NULL, 'Polynésie française', 1),
(97, 'TF', NULL, 'Terres australes françaises', 1),
(98, 'GM', NULL, 'Gambie', 1),
(99, 'GE', NULL, 'Géorgie', 1),
(100, 'GH', NULL, 'Ghana', 1),
(101, 'GI', NULL, 'Gibraltar', 1),
(102, 'GR', NULL, 'Grèce', 1),
(103, 'GL', NULL, 'Groenland', 1),
(104, 'GD', NULL, 'Grenade', 1),
(106, 'GU', NULL, 'Guam', 1),
(107, 'GT', NULL, 'Guatemala', 1),
(108, 'GN', NULL, 'Guinée', 1),
(109, 'GW', NULL, 'Guinée-Bissao', 1),
(111, 'HT', NULL, 'Haiti', 1),
(112, 'HM', NULL, 'Iles Heard et McDonald', 1),
(113, 'VA', NULL, 'Saint-Siège (Vatican)', 1),
(114, 'HN', NULL, 'Honduras', 1),
(115, 'HK', NULL, 'Hong Kong', 1),
(116, 'IS', NULL, 'Islande', 1),
(117, 'IN', NULL, 'India', 1),
(118, 'ID', NULL, 'Indonésie', 1),
(119, 'IR', NULL, 'Iran', 1),
(120, 'IQ', NULL, 'Iraq', 1),
(121, 'IL', NULL, 'Israel', 1),
(122, 'JM', NULL, 'Jamaïque', 1),
(123, 'JP', NULL, 'Japon', 1),
(124, 'JO', NULL, 'Jordanie', 1),
(125, 'KZ', NULL, 'Kazakhstan', 1),
(126, 'KE', NULL, 'Kenya', 1),
(127, 'KI', NULL, 'Kiribati', 1),
(128, 'KP', NULL, 'Corée du Nord', 1),
(129, 'KR', NULL, 'Corée du Sud', 1),
(130, 'KW', NULL, 'Koweït', 1),
(131, 'KG', NULL, 'Kirghizistan', 1),
(132, 'LA', NULL, 'Laos', 1),
(133, 'LV', NULL, 'Lettonie', 1),
(134, 'LB', NULL, 'Liban', 1),
(135, 'LS', NULL, 'Lesotho', 1),
(136, 'LR', NULL, 'Liberia', 1),
(137, 'LY', NULL, 'Libye', 1),
(138, 'LI', NULL, 'Liechtenstein', 1),
(139, 'LT', NULL, 'Lituanie', 1),
(140, 'LU', NULL, 'Luxembourg', 1),
(141, 'MO', NULL, 'Macao', 1),
(142, 'MK', NULL, 'ex-République yougoslave de Macédoine', 1),
(143, 'MG', NULL, 'Madagascar', 1),
(144, 'MW', NULL, 'Malawi', 1),
(145, 'MY', NULL, 'Malaisie', 1),
(146, 'MV', NULL, 'Maldives', 1),
(147, 'ML', NULL, 'Mali', 1),
(148, 'MT', NULL, 'Malte', 1),
(149, 'MH', NULL, 'Iles Marshall', 1),
(151, 'MR', NULL, 'Mauritanie', 1),
(152, 'MU', NULL, 'Maurice', 1),
(153, 'YT', NULL, 'Mayotte', 1),
(154, 'MX', NULL, 'Mexique', 1),
(155, 'FM', NULL, 'Micronésie', 1),
(156, 'MD', NULL, 'Moldavie', 1),
(157, 'MN', NULL, 'Mongolie', 1),
(158, 'MS', NULL, 'Monserrat', 1),
(159, 'MZ', NULL, 'Mozambique', 1),
(160, 'MM', NULL, 'Birmanie (Myanmar)', 1),
(161, 'NA', NULL, 'Namibie', 1),
(162, 'NR', NULL, 'Nauru', 1),
(163, 'NP', NULL, 'Népal', 1),
(164, 'AN', NULL, 'Antilles néerlandaises', 1),
(165, 'NC', NULL, 'Nouvelle-Calédonie', 1),
(166, 'NZ', NULL, 'Nouvelle-Zélande', 1),
(167, 'NI', NULL, 'Nicaragua', 1),
(168, 'NE', NULL, 'Niger', 1),
(169, 'NG', NULL, 'Nigeria', 1),
(170, 'NU', NULL, 'Nioué', 1),
(171, 'NF', NULL, 'Ile Norfolk', 1),
(172, 'MP', NULL, 'Mariannes du Nord', 1),
(173, 'NO', NULL, 'Norvège', 1),
(174, 'OM', NULL, 'Oman', 1),
(175, 'PK', NULL, 'Pakistan', 1),
(176, 'PW', NULL, 'Palaos', 1),
(177, 'PS', NULL, 'Territoire Palestinien Occupé', 1),
(178, 'PA', NULL, 'Panama', 1),
(179, 'PG', NULL, 'Papouasie-Nouvelle-Guinée', 1),
(180, 'PY', NULL, 'Paraguay', 1),
(181, 'PE', NULL, 'Pérou', 1),
(182, 'PH', NULL, 'Philippines', 1),
(183, 'PN', NULL, 'Iles Pitcairn', 1),
(184, 'PL', NULL, 'Pologne', 1),
(185, 'PR', NULL, 'Porto Rico', 1),
(186, 'QA', NULL, 'Qatar', 1),
(188, 'RO', NULL, 'Roumanie', 1),
(189, 'RW', NULL, 'Rwanda', 1),
(190, 'SH', NULL, 'Sainte-Hélène', 1),
(191, 'KN', NULL, 'Saint-Christophe-et-Niévès', 1),
(192, 'LC', NULL, 'Sainte-Lucie', 1),
(193, 'PM', NULL, 'Saint-Pierre-et-Miquelon', 1),
(194, 'VC', NULL, 'Saint-Vincent-et-les-Grenadines', 1),
(195, 'WS', NULL, 'Samoa', 1),
(196, 'SM', NULL, 'Saint-Marin', 1),
(197, 'ST', NULL, 'Sao Tomé-et-Principe', 1),
(198, 'RS', NULL, 'Serbie', 1),
(199, 'SC', NULL, 'Seychelles', 1),
(200, 'SL', NULL, 'Sierra Leone', 1),
(201, 'SK', NULL, 'Slovaquie', 1),
(202, 'SI', NULL, 'Slovénie', 1),
(203, 'SB', NULL, 'Iles Salomon', 1),
(204, 'SO', NULL, 'Somalie', 1),
(205, 'ZA', NULL, 'Afrique du Sud', 1),
(206, 'GS', NULL, 'Iles Géorgie du Sud et Sandwich du Sud', 1),
(207, 'LK', NULL, 'Sri Lanka', 1),
(208, 'SD', NULL, 'Soudan', 1),
(209, 'SR', NULL, 'Suriname', 1),
(210, 'SJ', NULL, 'Iles Svalbard et Jan Mayen', 1),
(211, 'SZ', NULL, 'Swaziland', 1),
(212, 'SY', NULL, 'Syrie', 1),
(213, 'TW', NULL, 'Taïwan', 1),
(214, 'TJ', NULL, 'Tadjikistan', 1),
(215, 'TZ', NULL, 'Tanzanie', 1),
(216, 'TH', NULL, 'Thaïlande', 1),
(217, 'TL', NULL, 'Timor Oriental', 1),
(218, 'TK', NULL, 'Tokélaou', 1),
(219, 'TO', NULL, 'Tonga', 1),
(220, 'TT', NULL, 'Trinité-et-Tobago', 1),
(221, 'TR', NULL, 'Turquie', 1),
(222, 'TM', NULL, 'Turkménistan', 1),
(223, 'TC', NULL, 'Iles Turks-et-Caicos', 1),
(224, 'TV', NULL, 'Tuvalu', 1),
(225, 'UG', NULL, 'Ouganda', 1),
(226, 'UA', NULL, 'Ukraine', 1),
(227, 'AE', NULL, 'Émirats arabes unis', 1),
(228, 'UM', NULL, 'Iles mineures éloignées des États-Unis', 1),
(229, 'UY', NULL, 'Uruguay', 1),
(230, 'UZ', NULL, 'Ouzbékistan', 1),
(231, 'VU', NULL, 'Vanuatu', 1),
(232, 'VE', NULL, 'Vénézuela', 1),
(233, 'VN', NULL, 'Viêt Nam', 1),
(234, 'VG', NULL, 'Iles Vierges britanniques', 1),
(235, 'VI', NULL, 'Iles Vierges américaines', 1),
(236, 'WF', NULL, 'Wallis-et-Futuna', 1),
(237, 'EH', NULL, 'Sahara occidental', 1),
(238, 'YE', NULL, 'Yémen', 1),
(239, 'ZM', NULL, 'Zambie', 1),
(240, 'ZW', NULL, 'Zimbabwe', 1),
(241, 'GG', NULL, 'Guernesey', 1),
(242, 'IM', NULL, 'Ile de Man', 1),
(243, 'JE', NULL, 'Jersey', 1),
(244, 'ME', NULL, 'Monténégro', 1),
(245, 'BL', NULL, 'Saint-Barthélemy', 1),
(246, 'MF', NULL, 'Saint-Martin', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_c_propalst`
--

CREATE TABLE IF NOT EXISTS `llx_c_propalst` (
  `id` smallint(6) NOT NULL,
  `code` varchar(12) NOT NULL,
  `label` varchar(30) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `llx_c_propalst`
--

INSERT INTO `llx_c_propalst` (`id`, `code`, `label`, `active`) VALUES
(0, 'PR_DRAFT', 'Brouillon', 1),
(1, 'PR_OPEN', 'Ouverte', 1),
(2, 'PR_SIGNED', 'Signée', 1),
(3, 'PR_NOTSIGNED', 'Non Signée', 1),
(4, 'PR_FAC', 'Facturée', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_c_prospectlevel`
--

CREATE TABLE IF NOT EXISTS `llx_c_prospectlevel` (
  `code` varchar(12) NOT NULL,
  `label` varchar(30) DEFAULT NULL,
  `sortorder` smallint(6) DEFAULT NULL,
  `active` smallint(6) NOT NULL DEFAULT '1',
  `module` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `llx_c_prospectlevel`
--

INSERT INTO `llx_c_prospectlevel` (`code`, `label`, `sortorder`, `active`, `module`) VALUES
('PL_HIGH', 'High', 4, 1, NULL),
('PL_LOW', 'Low', 2, 1, NULL),
('PL_MEDIUM', 'Medium', 3, 1, NULL),
('PL_NONE', 'None', 1, 1, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_c_regions`
--

CREATE TABLE IF NOT EXISTS `llx_c_regions` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code_region` int(11) NOT NULL,
  `fk_pays` int(11) NOT NULL,
  `cheflieu` varchar(50) DEFAULT NULL,
  `tncc` int(11) DEFAULT NULL,
  `nom` varchar(50) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `code_region` (`code_region`),
  KEY `idx_c_regions_fk_pays` (`fk_pays`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=15404 ;

--
-- Extraindo dados da tabela `llx_c_regions`
--

INSERT INTO `llx_c_regions` (`rowid`, `code_region`, `fk_pays`, `cheflieu`, `tncc`, `nom`, `active`) VALUES
(1, 0, 0, '0', 0, '-', 1),
(101, 1, 1, '97105', 3, 'Guadeloupe', 1),
(102, 2, 1, '97209', 3, 'Martinique', 1),
(103, 3, 1, '97302', 3, 'Guyane', 1),
(104, 4, 1, '97411', 3, 'Réunion', 1),
(105, 11, 1, '75056', 1, 'Île-de-France', 1),
(106, 21, 1, '51108', 0, 'Champagne-Ardenne', 1),
(107, 22, 1, '80021', 0, 'Picardie', 1),
(108, 23, 1, '76540', 0, 'Haute-Normandie', 1),
(109, 24, 1, '45234', 2, 'Centre', 1),
(110, 25, 1, '14118', 0, 'Basse-Normandie', 1),
(111, 26, 1, '21231', 0, 'Bourgogne', 1),
(112, 31, 1, '59350', 2, 'Nord-Pas-de-Calais', 1),
(113, 41, 1, '57463', 0, 'Lorraine', 1),
(114, 42, 1, '67482', 1, 'Alsace', 1),
(115, 43, 1, '25056', 0, 'Franche-Comté', 1),
(116, 52, 1, '44109', 4, 'Pays de la Loire', 1),
(117, 53, 1, '35238', 0, 'Bretagne', 1),
(118, 54, 1, '86194', 2, 'Poitou-Charentes', 1),
(119, 72, 1, '33063', 1, 'Aquitaine', 1),
(120, 73, 1, '31555', 0, 'Midi-Pyrénées', 1),
(121, 74, 1, '87085', 2, 'Limousin', 1),
(122, 82, 1, '69123', 2, 'Rhône-Alpes', 1),
(123, 83, 1, '63113', 1, 'Auvergne', 1),
(124, 91, 1, '34172', 2, 'Languedoc-Roussillon', 1),
(125, 93, 1, '13055', 0, 'Provence-Alpes-Côte d''Azur', 1),
(126, 94, 1, '2A004', 0, 'Corse', 1),
(201, 201, 2, '', 1, 'Flandre', 1),
(202, 202, 2, '', 2, 'Wallonie', 1),
(203, 203, 2, '', 3, 'Bruxelles-Capitale', 1),
(301, 301, 3, NULL, 1, 'Abruzzo', 1),
(302, 302, 3, NULL, 1, 'Basilicata', 1),
(303, 303, 3, NULL, 1, 'Calabria', 1),
(304, 304, 3, NULL, 1, 'Campania', 1),
(305, 305, 3, NULL, 1, 'Emilia-Romagna', 1),
(306, 306, 3, NULL, 1, 'Friuli-Venezia Giulia', 1),
(307, 307, 3, NULL, 1, 'Lazio', 1),
(308, 308, 3, NULL, 1, 'Liguria', 1),
(309, 309, 3, NULL, 1, 'Lombardia', 1),
(310, 310, 3, NULL, 1, 'Marche', 1),
(311, 311, 3, NULL, 1, 'Molise', 1),
(312, 312, 3, NULL, 1, 'Piemonte', 1),
(313, 313, 3, NULL, 1, 'Puglia', 1),
(314, 314, 3, NULL, 1, 'Sardegna', 1),
(315, 315, 3, NULL, 1, 'Sicilia', 1),
(316, 316, 3, NULL, 1, 'Toscana', 1),
(317, 317, 3, NULL, 1, 'Trentino-Alto Adige', 1),
(318, 318, 3, NULL, 1, 'Umbria', 1),
(319, 319, 3, NULL, 1, 'Valle d Aosta', 1),
(320, 320, 3, NULL, 1, 'Veneto', 1),
(401, 401, 4, '', 0, 'Andalucia', 1),
(402, 402, 4, '', 0, 'Aragón', 1),
(403, 403, 4, '', 0, 'Castilla y León', 1),
(404, 404, 4, '', 0, 'Castilla la Mancha', 1),
(405, 405, 4, '', 0, 'Canarias', 1),
(406, 406, 4, '', 0, 'Cataluña', 1),
(407, 407, 4, '', 0, 'Comunidad de Ceuta', 1),
(408, 408, 4, '', 0, 'Comunidad Foral de Navarra', 1),
(409, 409, 4, '', 0, 'Comunidad de Melilla', 1),
(410, 410, 4, '', 0, 'Cantabria', 1),
(411, 411, 4, '', 0, 'Comunidad Valenciana', 1),
(412, 412, 4, '', 0, 'Extemadura', 1),
(413, 413, 4, '', 0, 'Galicia', 1),
(414, 414, 4, '', 0, 'Islas Baleares', 1),
(415, 415, 4, '', 0, 'La Rioja', 1),
(416, 416, 4, '', 0, 'Comunidad de Madrid', 1),
(417, 417, 4, '', 0, 'Región de Murcia', 1),
(418, 418, 4, '', 0, 'Principado de Asturias', 1),
(419, 419, 4, '', 0, 'Pais Vasco', 1),
(420, 420, 4, '', 0, 'Otros', 1),
(601, 601, 6, '', 1, 'Cantons', 1),
(1001, 1001, 10, '', 0, 'Ariana', 1),
(1002, 1002, 10, '', 0, 'Béja', 1),
(1003, 1003, 10, '', 0, 'Ben Arous', 1),
(1004, 1004, 10, '', 0, 'Bizerte', 1),
(1005, 1005, 10, '', 0, 'Gabès', 1),
(1006, 1006, 10, '', 0, 'Gafsa', 1),
(1007, 1007, 10, '', 0, 'Jendouba', 1),
(1008, 1008, 10, '', 0, 'Kairouan', 1),
(1009, 1009, 10, '', 0, 'Kasserine', 1),
(1010, 1010, 10, '', 0, 'Kébili', 1),
(1011, 1011, 10, '', 0, 'La Manouba', 1),
(1012, 1012, 10, '', 0, 'Le Kef', 1),
(1013, 1013, 10, '', 0, 'Mahdia', 1),
(1014, 1014, 10, '', 0, 'Médenine', 1),
(1015, 1015, 10, '', 0, 'Monastir', 1),
(1016, 1016, 10, '', 0, 'Nabeul', 1),
(1017, 1017, 10, '', 0, 'Sfax', 1),
(1018, 1018, 10, '', 0, 'Sidi Bouzid', 1),
(1019, 1019, 10, '', 0, 'Siliana', 1),
(1020, 1020, 10, '', 0, 'Sousse', 1),
(1021, 1021, 10, '', 0, 'Tataouine', 1),
(1022, 1022, 10, '', 0, 'Tozeur', 1),
(1023, 1023, 10, '', 0, 'Tunis', 1),
(1024, 1024, 10, '', 0, 'Zaghouan', 1),
(1101, 1101, 11, '', 0, 'United-States', 1),
(2301, 2301, 23, '', 0, 'Norte', 1),
(2302, 2302, 23, '', 0, 'Litoral', 1),
(2303, 2303, 23, '', 0, 'Cuyana', 1),
(2304, 2304, 23, '', 0, 'Central', 1),
(2305, 2305, 23, '', 0, 'Patagonia', 1),
(2801, 2801, 28, '', 0, 'Australia', 1),
(4601, 4601, 46, '', 0, 'Barbados', 1),
(6701, 6701, 67, NULL, NULL, 'Tarapacá', 1),
(6702, 6702, 67, NULL, NULL, 'Antofagasta', 1),
(6703, 6703, 67, NULL, NULL, 'Atacama', 1),
(6704, 6704, 67, NULL, NULL, 'Coquimbo', 1),
(6705, 6705, 67, NULL, NULL, 'Valparaíso', 1),
(6706, 6706, 67, NULL, NULL, 'General Bernardo O Higgins', 1),
(6707, 6707, 67, NULL, NULL, 'Maule', 1),
(6708, 6708, 67, NULL, NULL, 'Biobío', 1),
(6709, 6709, 67, NULL, NULL, 'Raucanía', 1),
(6710, 6710, 67, NULL, NULL, 'Los Lagos', 1),
(6711, 6711, 67, NULL, NULL, 'Aysén General Carlos Ibáñez del Campo', 1),
(6712, 6712, 67, NULL, NULL, 'Magallanes y Antártica Chilena', 1),
(6713, 6713, 67, NULL, NULL, 'Metropolitana de Santiago', 1),
(6714, 6714, 67, NULL, NULL, 'Los Ríos', 1),
(6715, 6715, 67, NULL, NULL, 'Arica y Parinacota', 1),
(7001, 7001, 70, '', 0, 'Colombie', 1),
(8601, 8601, 86, NULL, NULL, 'Central', 1),
(8602, 8602, 86, NULL, NULL, 'Oriental', 1),
(8603, 8603, 86, NULL, NULL, 'Occidental', 1),
(11401, 11401, 114, '', 0, 'Honduras', 1),
(11701, 11701, 117, '', 0, 'India', 1),
(15201, 15201, 152, '', 0, 'Rivière Noire', 1),
(15202, 15202, 152, '', 0, 'Flacq', 1),
(15203, 15203, 152, '', 0, 'Grand Port', 1),
(15204, 15204, 152, '', 0, 'Moka', 1),
(15205, 15205, 152, '', 0, 'Pamplemousses', 1),
(15206, 15206, 152, '', 0, 'Plaines Wilhems', 1),
(15207, 15207, 152, '', 0, 'Port-Louis', 1),
(15208, 15208, 152, '', 0, 'Rivière du Rempart', 1),
(15209, 15209, 152, '', 0, 'Savanne', 1),
(15210, 15210, 152, '', 0, 'Rodrigues', 1),
(15211, 15211, 152, '', 0, 'Les îles Agaléga', 1),
(15212, 15212, 152, '', 0, 'Les écueils des Cargados Carajos', 1),
(15401, 15401, 154, '', 0, 'Mexique', 1),
(15403, 1000, 25, NULL, NULL, 'MG', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_c_shipment_mode`
--

CREATE TABLE IF NOT EXISTS `llx_c_shipment_mode` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `code` varchar(30) NOT NULL,
  `libelle` varchar(50) NOT NULL,
  `description` text,
  `active` tinyint(4) DEFAULT '0',
  `module` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `llx_c_shipment_mode`
--

INSERT INTO `llx_c_shipment_mode` (`rowid`, `tms`, `code`, `libelle`, `description`, `active`, `module`) VALUES
(1, '2012-02-09 19:35:17', 'CATCH', 'Catch', 'Catch by client', 1, NULL),
(2, '2012-02-09 19:35:17', 'TRANS', 'Transporter', 'Generic transporter', 1, NULL),
(3, '2012-02-09 19:35:17', 'COLSUI', 'Colissimo Suivi', 'Colissimo Suivi', 0, NULL),
(4, '2012-02-09 19:35:17', 'LETTREMAX', 'Lettre Max', 'Courrier Suivi et Lettre Max', 0, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_c_stcomm`
--

CREATE TABLE IF NOT EXISTS `llx_c_stcomm` (
  `id` int(11) NOT NULL,
  `code` varchar(12) NOT NULL,
  `libelle` varchar(30) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `llx_c_stcomm`
--

INSERT INTO `llx_c_stcomm` (`id`, `code`, `libelle`, `active`) VALUES
(-1, 'ST_NO', 'Ne pas contacter', 1),
(0, 'ST_NEVER', 'Jamais contacté', 1),
(1, 'ST_TODO', 'A contacter', 1),
(2, 'ST_PEND', 'Contact en cours', 1),
(3, 'ST_DONE', 'Contactée', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_c_tva`
--

CREATE TABLE IF NOT EXISTS `llx_c_tva` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_pays` int(11) NOT NULL,
  `taux` double NOT NULL,
  `localtax1` double NOT NULL DEFAULT '0',
  `localtax2` double NOT NULL DEFAULT '0',
  `recuperableonly` int(11) NOT NULL DEFAULT '0',
  `note` varchar(128) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `accountancy_code` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2463 ;

--
-- Extraindo dados da tabela `llx_c_tva`
--

INSERT INTO `llx_c_tva` (`rowid`, `fk_pays`, `taux`, `localtax1`, `localtax2`, `recuperableonly`, `note`, `active`, `accountancy_code`) VALUES
(11, 1, 19.6, 0, 0, 0, 'VAT standard rate (France hors DOM-TOM)', 1, NULL),
(12, 1, 8.5, 0, 0, 0, 'VAT standard rate (DOM sauf Guyane et Saint-Martin)', 0, NULL),
(13, 1, 8.5, 0, 0, 1, 'VAT standard rate (DOM sauf Guyane et Saint-Martin), non perçu par le vendeur mais récupérable par acheteur', 0, NULL),
(14, 1, 5.5, 0, 0, 0, 'VAT reduced rate (France hors DOM-TOM)', 1, NULL),
(15, 1, 0, 0, 0, 0, 'VAT Rate 0 ou non applicable', 1, NULL),
(16, 1, 2.1, 0, 0, 0, 'VAT super-reduced rate', 1, NULL),
(17, 1, 7, 0, 0, 0, 'VAT reduced rate', 1, NULL),
(21, 2, 21, 0, 0, 0, 'VAT standard rate', 1, NULL),
(22, 2, 6, 0, 0, 0, 'VAT reduced rate', 1, NULL),
(23, 2, 0, 0, 0, 0, 'VAT Rate 0 ou non applicable', 1, NULL),
(24, 2, 12, 0, 0, 0, 'VAT reduced rate', 1, NULL),
(31, 3, 21, 0, 0, 0, 'VAT standard rate', 1, NULL),
(32, 3, 10, 0, 0, 0, 'VAT reduced rate', 1, NULL),
(33, 3, 4, 0, 0, 0, 'VAT super-reduced rate', 1, NULL),
(34, 3, 0, 0, 0, 0, 'VAT Rate 0', 1, NULL),
(41, 4, 18, 4, 0, 0, 'VAT standard rate', 1, NULL),
(42, 4, 8, 1, 0, 0, 'VAT reduced rate', 1, NULL),
(43, 4, 4, 0.5, 0, 0, 'VAT super-reduced rate', 1, NULL),
(44, 4, 0, 0, 0, 0, 'VAT Rate 0', 1, NULL),
(51, 5, 19, 0, 0, 0, 'VAT standard rate', 1, NULL),
(52, 5, 7, 0, 0, 0, 'VAT reduced rate', 1, NULL),
(53, 5, 0, 0, 0, 0, 'VAT Rate 0', 1, NULL),
(61, 6, 7.6, 0, 0, 0, 'VAT standard rate', 1, NULL),
(62, 6, 3.6, 0, 0, 0, 'VAT reduced rate', 1, NULL),
(63, 6, 2.4, 0, 0, 0, 'VAT super-reduced rate', 1, NULL),
(64, 6, 0, 0, 0, 0, 'VAT Rate 0', 1, NULL),
(71, 7, 20, 0, 0, 0, 'VAT standard rate', 1, NULL),
(72, 7, 17.5, 0, 0, 0, 'VAT standard rate before 2011', 1, NULL),
(73, 7, 5, 0, 0, 0, 'VAT reduced rate', 1, NULL),
(74, 7, 0, 0, 0, 0, 'VAT Rate 0', 1, NULL),
(91, 9, 17, 0, 0, 0, 'VAT standard rate', 1, NULL),
(92, 9, 13, 0, 0, 0, 'VAT reduced rate 0', 1, NULL),
(93, 9, 3, 0, 0, 0, 'VAT super reduced rate 0', 1, NULL),
(94, 9, 0, 0, 0, 0, 'VAT Rate 0', 1, NULL),
(101, 10, 6, 0, 0, 0, 'VAT 6%', 1, NULL),
(102, 10, 12, 0, 0, 0, 'VAT 12%', 1, NULL),
(103, 10, 18, 0, 0, 0, 'VAT 18%', 1, NULL),
(104, 10, 7.5, 0, 0, 0, 'VAT 6% Majoré à 25% (7.5%)', 1, NULL),
(105, 10, 15, 0, 0, 0, 'VAT 12% Majoré à 25% (15%)', 1, NULL),
(106, 10, 22.5, 0, 0, 0, 'VAT 18% Majoré à 25% (22.5%)', 1, NULL),
(107, 10, 0, 0, 0, 0, 'VAT Rate 0', 1, NULL),
(111, 11, 0, 0, 0, 0, 'No Sales Tax', 1, NULL),
(112, 11, 4, 0, 0, 0, 'Sales Tax 4%', 1, NULL),
(113, 11, 6, 0, 0, 0, 'Sales Tax 6%', 1, NULL),
(121, 12, 20, 0, 0, 0, 'VAT standard rate', 1, NULL),
(122, 12, 14, 0, 0, 0, 'VAT reduced rate', 1, NULL),
(123, 12, 10, 0, 0, 0, 'VAT reduced rate', 1, NULL),
(124, 12, 7, 0, 0, 0, 'VAT super-reduced rate', 1, NULL),
(125, 12, 0, 0, 0, 0, 'VAT Rate 0', 1, NULL),
(141, 14, 7, 0, 0, 0, 'VAT standard rate', 1, NULL),
(142, 14, 0, 0, 0, 0, 'VAT Rate 0', 1, NULL),
(171, 17, 19, 0, 0, 0, 'VAT standard rate', 1, NULL),
(172, 17, 6, 0, 0, 0, 'VAT reduced rate', 1, NULL),
(173, 17, 0, 0, 0, 0, 'VAT Rate 0', 1, NULL),
(201, 20, 25, 0, 0, 0, 'VAT standard rate', 1, NULL),
(202, 20, 12, 0, 0, 0, 'VAT reduced rate', 1, NULL),
(203, 20, 6, 0, 0, 0, 'VAT super-reduced rate', 1, NULL),
(204, 20, 0, 0, 0, 0, 'VAT Rate 0', 1, NULL),
(231, 23, 21, 0, 0, 0, 'IVA standard rate', 1, NULL),
(232, 23, 10.5, 0, 0, 0, 'IVA reduced rate', 1, NULL),
(233, 23, 0, 0, 0, 0, 'IVA Rate 0', 1, NULL),
(251, 25, 20, 0, 0, 0, 'VAT standard rate', 1, NULL),
(252, 25, 12, 0, 0, 0, 'VAT reduced rate', 1, NULL),
(253, 25, 0, 0, 0, 0, 'VAT Rate 0', 1, NULL),
(254, 25, 5, 0, 0, 0, 'VAT reduced rate', 1, NULL),
(281, 28, 10, 0, 0, 0, 'VAT standard rate', 1, NULL),
(282, 28, 0, 0, 0, 0, 'VAT Rate 0', 1, NULL),
(411, 41, 20, 0, 0, 0, 'VAT standard rate', 1, NULL),
(412, 41, 10, 0, 0, 0, 'VAT reduced rate', 1, NULL),
(413, 41, 0, 0, 0, 0, 'VAT Rate 0', 1, NULL),
(461, 46, 0, 0, 0, 0, 'No VAT', 1, NULL),
(462, 46, 15, 0, 0, 0, 'VAT 15%', 1, NULL),
(463, 46, 7.5, 0, 0, 0, 'VAT 7.5%', 1, NULL),
(591, 59, 20, 0, 0, 0, 'VAT standard rate', 1, NULL),
(592, 59, 7, 0, 0, 0, 'VAT reduced rate', 1, NULL),
(593, 59, 0, 0, 0, 0, 'VAT Rate 0', 1, NULL),
(671, 67, 19, 0, 0, 0, 'VAT standard rate', 1, NULL),
(672, 67, 0, 0, 0, 0, 'VAT Rate 0', 1, NULL),
(801, 80, 25, 0, 0, 0, 'VAT standard rate', 1, NULL),
(802, 80, 0, 0, 0, 0, 'VAT Rate 0', 1, NULL),
(861, 86, 13, 0, 0, 0, 'IVA 13', 1, NULL),
(862, 86, 0, 0, 0, 0, 'SIN IVA', 1, NULL),
(1141, 114, 0, 0, 0, 0, 'No ISV', 1, NULL),
(1142, 114, 12, 0, 0, 0, 'ISV 12%', 1, NULL),
(1161, 116, 25.5, 0, 0, 0, 'VAT standard rate', 1, NULL),
(1162, 116, 7, 0, 0, 0, 'VAT reduced rate', 1, NULL),
(1163, 116, 0, 0, 0, 0, 'VAT rate 0', 1, NULL),
(1171, 117, 12.5, 0, 0, 0, 'VAT standard rate', 1, NULL),
(1172, 117, 4, 0, 0, 0, 'VAT reduced rate', 1, NULL),
(1173, 117, 1, 0, 0, 0, 'VAT super-reduced rate', 1, NULL),
(1174, 117, 0, 0, 0, 0, 'VAT Rate 0', 1, NULL),
(1231, 123, 0, 0, 0, 0, 'VAT Rate 0', 1, NULL),
(1232, 123, 5, 0, 0, 0, 'VAT Rate 5', 1, NULL),
(1401, 140, 15, 0, 0, 0, 'VAT standard rate', 1, NULL),
(1402, 140, 12, 0, 0, 0, 'VAT reduced rate', 1, NULL),
(1403, 140, 6, 0, 0, 0, 'VAT reduced rate', 1, NULL),
(1404, 140, 3, 0, 0, 0, 'VAT super-reduced rate', 1, NULL),
(1405, 140, 0, 0, 0, 0, 'VAT Rate 0', 1, NULL),
(1521, 152, 0, 0, 0, 0, 'VAT Rate 0', 1, NULL),
(1522, 152, 15, 0, 0, 0, 'VAT Rate 15', 1, NULL),
(1541, 154, 0, 0, 0, 0, 'No VAT', 1, NULL),
(1542, 154, 16, 0, 0, 0, 'VAT 16%', 1, NULL),
(1543, 154, 10, 0, 0, 0, 'VAT Frontero', 1, NULL),
(1662, 166, 15, 0, 0, 0, 'VAT standard rate', 1, NULL),
(1663, 166, 0, 0, 0, 0, 'VAT Rate 0', 1, NULL),
(1731, 173, 25, 0, 0, 0, 'VAT standard rate', 1, NULL),
(1732, 173, 14, 0, 0, 0, 'VAT reduced rate', 1, NULL),
(1733, 173, 8, 0, 0, 0, 'VAT reduced rate', 1, NULL),
(1734, 173, 0, 0, 0, 0, 'VAT Rate 0', 1, NULL),
(1841, 184, 20, 0, 0, 0, 'VAT standard rate', 1, NULL),
(1842, 184, 7, 0, 0, 0, 'VAT reduced rate', 1, NULL),
(1843, 184, 3, 0, 0, 0, 'VAT reduced rate', 1, NULL),
(1844, 184, 0, 0, 0, 0, 'VAT Rate 0', 1, NULL),
(1881, 188, 24, 0, 0, 0, 'VAT standard rate', 1, NULL),
(1882, 188, 9, 0, 0, 0, 'VAT reduced rate', 1, NULL),
(1883, 188, 0, 0, 0, 0, 'VAT Rate 0', 1, NULL),
(1884, 188, 5, 0, 0, 0, 'VAT reduced rate', 1, NULL),
(1931, 193, 0, 0, 0, 0, 'No VAT in SPM', 1, NULL),
(2011, 201, 19, 0, 0, 0, 'VAT standard rate', 1, NULL),
(2012, 201, 10, 0, 0, 0, 'VAT reduced rate', 1, NULL),
(2013, 201, 0, 0, 0, 0, 'VAT Rate 0', 1, NULL),
(2021, 202, 20, 0, 0, 0, 'VAT standard rate', 1, NULL),
(2022, 202, 8.5, 0, 0, 0, 'VAT reduced rate', 1, NULL),
(2023, 202, 0, 0, 0, 0, 'VAT Rate 0', 1, NULL),
(2461, 246, 0, 0, 0, 0, 'VAT Rate 0', 1, NULL),
(2462, 25, 18, 0, 0, 0, 'ICMS MG', 1, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_c_typent`
--

CREATE TABLE IF NOT EXISTS `llx_c_typent` (
  `id` int(11) NOT NULL,
  `code` varchar(12) NOT NULL,
  `libelle` varchar(30) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `module` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `llx_c_typent`
--

INSERT INTO `llx_c_typent` (`id`, `code`, `libelle`, `active`, `module`) VALUES
(0, 'TE_UNKNOWN', '-', 1, NULL),
(1, 'TE_STARTUP', 'Start-up', 0, NULL),
(2, 'TE_GROUP', 'Grand groupe', 1, NULL),
(3, 'TE_MEDIUM', 'PME/PMI', 1, NULL),
(4, 'TE_SMALL', 'TPE', 1, NULL),
(5, 'TE_ADMIN', 'Administration', 1, NULL),
(6, 'TE_WHOLE', 'Grossiste', 0, NULL),
(7, 'TE_RETAIL', 'Revendeur', 0, NULL),
(8, 'TE_PRIVATE', 'Particulier', 1, NULL),
(100, 'TE_OTHER', 'Autres', 1, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_c_type_contact`
--

CREATE TABLE IF NOT EXISTS `llx_c_type_contact` (
  `rowid` int(11) NOT NULL,
  `element` varchar(30) NOT NULL,
  `source` varchar(8) NOT NULL DEFAULT 'external',
  `code` varchar(16) NOT NULL,
  `libelle` varchar(64) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `module` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `idx_c_type_contact_uk` (`element`,`source`,`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `llx_c_type_contact`
--

INSERT INTO `llx_c_type_contact` (`rowid`, `element`, `source`, `code`, `libelle`, `active`, `module`) VALUES
(10, 'contrat', 'internal', 'SALESREPSIGN', 'Commercial signataire du contrat', 1, NULL),
(11, 'contrat', 'internal', 'SALESREPFOLL', 'Commercial suivi du contrat', 1, NULL),
(20, 'contrat', 'external', 'BILLING', 'Contact client facturation contrat', 1, NULL),
(21, 'contrat', 'external', 'CUSTOMER', 'Contact client suivi contrat', 1, NULL),
(22, 'contrat', 'external', 'SALESREPSIGN', 'Contact client signataire contrat', 1, NULL),
(31, 'propal', 'internal', 'SALESREPFOLL', 'Commercial à l''origine de la propale', 1, NULL),
(40, 'propal', 'external', 'BILLING', 'Contact client facturation propale', 1, NULL),
(41, 'propal', 'external', 'CUSTOMER', 'Contact client suivi propale', 1, NULL),
(50, 'facture', 'internal', 'SALESREPFOLL', 'Responsable suivi du paiement', 1, NULL),
(60, 'facture', 'external', 'BILLING', 'Contact client facturation', 1, NULL),
(61, 'facture', 'external', 'SHIPPING', 'Contact client livraison', 1, NULL),
(62, 'facture', 'external', 'SERVICE', 'Contact client prestation', 1, NULL),
(70, 'invoice_supplier', 'internal', 'SALESREPFOLL', 'Responsable suivi du paiement', 1, NULL),
(71, 'invoice_supplier', 'external', 'BILLING', 'Contact fournisseur facturation', 1, NULL),
(72, 'invoice_supplier', 'external', 'SHIPPING', 'Contact fournisseur livraison', 1, NULL),
(73, 'invoice_supplier', 'external', 'SERVICE', 'Contact fournisseur prestation', 1, NULL),
(91, 'commande', 'internal', 'SALESREPFOLL', 'Responsable suivi de la commande', 1, NULL),
(100, 'commande', 'external', 'BILLING', 'Contact client facturation commande', 1, NULL),
(101, 'commande', 'external', 'CUSTOMER', 'Contact client suivi commande', 1, NULL),
(102, 'commande', 'external', 'SHIPPING', 'Contact client livraison commande', 1, NULL),
(120, 'fichinter', 'internal', 'INTERREPFOLL', 'Responsable suivi de l''intervention', 1, NULL),
(121, 'fichinter', 'internal', 'INTERVENING', 'Intervenant', 1, NULL),
(130, 'fichinter', 'external', 'BILLING', 'Contact client facturation intervention', 1, NULL),
(131, 'fichinter', 'external', 'CUSTOMER', 'Contact client suivi de l''intervention', 1, NULL),
(140, 'order_supplier', 'internal', 'SALESREPFOLL', 'Responsable suivi de la commande', 1, NULL),
(141, 'order_supplier', 'internal', 'SHIPPING', 'Responsable réception de la commande', 1, NULL),
(142, 'order_supplier', 'external', 'BILLING', 'Contact fournisseur facturation commande', 1, NULL),
(143, 'order_supplier', 'external', 'CUSTOMER', 'Contact fournisseur suivi commande', 1, NULL),
(145, 'order_supplier', 'external', 'SHIPPING', 'Contact fournisseur livraison commande', 1, NULL),
(160, 'project', 'internal', 'PROJECTLEADER', 'Chef de Projet', 1, NULL),
(161, 'project', 'internal', 'CONTRIBUTOR', 'Intervenant', 1, NULL),
(170, 'project', 'external', 'PROJECTLEADER', 'Chef de Projet', 1, NULL),
(171, 'project', 'external', 'CONTRIBUTOR', 'Intervenant', 1, NULL),
(180, 'project_task', 'internal', 'TASKEXECUTIVE', 'Responsable', 1, NULL),
(181, 'project_task', 'internal', 'CONTRIBUTOR', 'Intervenant', 1, NULL),
(190, 'project_task', 'external', 'TASKEXECUTIVE', 'Responsable', 1, NULL),
(191, 'project_task', 'external', 'CONTRIBUTOR', 'Intervenant', 1, NULL),
(1501, 'Composition_entries', 'external', 'CUSTOMER', 'Contact client suivi document', 1, NULL),
(1502, 'Composition_entries', 'internal', 'AUTHOR', 'Redacteur document', 1, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_c_type_fees`
--

CREATE TABLE IF NOT EXISTS `llx_c_type_fees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(12) NOT NULL,
  `libelle` varchar(30) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `module` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Extraindo dados da tabela `llx_c_type_fees`
--

INSERT INTO `llx_c_type_fees` (`id`, `code`, `libelle`, `active`, `module`) VALUES
(1, 'TF_OTHER', 'Other', 1, NULL),
(2, 'TF_TRIP', 'Trip', 1, NULL),
(3, 'TF_LUNCH', 'Lunch', 1, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_c_ziptown`
--

CREATE TABLE IF NOT EXISTS `llx_c_ziptown` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(5) DEFAULT NULL,
  `fk_county` int(11) DEFAULT NULL,
  `fk_pays` int(11) NOT NULL DEFAULT '0',
  `zip` varchar(10) NOT NULL,
  `town` varchar(255) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_ziptown_fk_pays` (`zip`,`town`,`fk_pays`),
  KEY `idx_c_ziptown_fk_county` (`fk_county`),
  KEY `idx_c_ziptown_fk_pays` (`fk_pays`),
  KEY `idx_c_ziptown_zip` (`zip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_deplacement`
--

CREATE TABLE IF NOT EXISTS `llx_deplacement` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(30) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `datec` datetime NOT NULL,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `dated` datetime DEFAULT NULL,
  `fk_user` int(11) NOT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `type` varchar(12) NOT NULL,
  `fk_statut` int(11) NOT NULL DEFAULT '1',
  `km` double DEFAULT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `fk_projet` int(11) DEFAULT '0',
  `note` text,
  `note_public` text,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_document`
--

CREATE TABLE IF NOT EXISTS `llx_document` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_extension` varchar(5) NOT NULL,
  `date_generation` datetime DEFAULT NULL,
  `fk_owner` int(11) DEFAULT NULL,
  `fk_group` int(11) DEFAULT NULL,
  `permissions` char(9) DEFAULT 'rw-rw-rw',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_document_generator`
--

CREATE TABLE IF NOT EXISTS `llx_document_generator` (
  `rowid` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `classfile` varchar(255) NOT NULL,
  `class` varchar(255) NOT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_document_model`
--

CREATE TABLE IF NOT EXISTS `llx_document_model` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `type` varchar(20) NOT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_document_model` (`nom`,`type`,`entity`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- Extraindo dados da tabela `llx_document_model`
--

INSERT INTO `llx_document_model` (`rowid`, `nom`, `entity`, `type`, `libelle`, `description`) VALUES
(1, 'azur', 1, 'propal', NULL, NULL),
(3, 'soleil', 1, 'ficheinter', NULL, NULL),
(4, 'rouget', 1, 'shipping', NULL, NULL),
(5, 'elevement', 1, 'delivery', NULL, NULL),
(6, 'einstein', 1, 'order', NULL, NULL),
(9, 'muscadet', 1, 'order_supplier', NULL, NULL),
(10, 'baleine', 1, 'project', NULL, NULL),
(11, 'crabe', 1, 'invoice', NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_dolibarr_modules`
--

CREATE TABLE IF NOT EXISTS `llx_dolibarr_modules` (
  `numero` int(11) NOT NULL DEFAULT '0',
  `entity` int(11) NOT NULL DEFAULT '1',
  `active` tinyint(4) NOT NULL DEFAULT '0',
  `active_date` datetime NOT NULL,
  `active_version` varchar(25) NOT NULL,
  PRIMARY KEY (`numero`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `llx_dolibarr_modules`
--

INSERT INTO `llx_dolibarr_modules` (`numero`, `entity`, `active`, `active_date`, `active_version`) VALUES
(0, 1, 1, '2012-02-09 19:35:17', 'dolibarr'),
(1, 1, 1, '2012-02-12 10:53:20', 'dolibarr'),
(10, 1, 1, '2012-02-09 20:21:05', 'dolibarr'),
(20, 1, 1, '2012-02-09 20:03:06', 'dolibarr'),
(25, 1, 1, '2012-02-09 20:05:34', 'dolibarr'),
(30, 1, 1, '2012-02-12 09:15:58', 'dolibarr'),
(40, 1, 1, '2012-02-09 20:22:37', 'dolibarr'),
(42, 1, 1, '2012-02-09 20:27:34', 'dolibarr'),
(50, 1, 1, '2012-02-12 09:15:58', 'dolibarr'),
(53, 1, 1, '2012-02-09 20:05:23', 'dolibarr'),
(54, 1, 1, '2012-02-09 20:05:23', 'dolibarr'),
(57, 1, 1, '2012-02-09 20:21:50', 'dolibarr'),
(75, 1, 1, '2012-02-09 20:21:57', 'dolibarr'),
(80, 1, 1, '2012-02-09 20:05:34', 'dolibarr'),
(85, 1, 1, '2012-02-12 09:15:57', 'dolibarr'),
(310, 1, 1, '2012-02-09 20:22:32', 'dolibarr'),
(400, 1, 1, '2012-02-09 20:25:49', 'dolibarr'),
(500, 1, 1, '2012-02-09 20:21:43', 'dolibarr'),
(600, 1, 1, '2012-02-09 20:30:03', 'dolibarr'),
(1500, 1, 1, '2012-02-12 10:53:20', '1.0'),
(1780, 1, 1, '2012-02-09 20:28:01', 'dolibarr'),
(2000, 1, 1, '2012-02-09 20:28:04', 'dolibarr'),
(2400, 1, 1, '2012-02-09 20:25:45', 'dolibarr'),
(6000, 1, 1, '2012-02-09 20:28:46', 'dolibarr'),
(50100, 1, 1, '2012-02-12 09:15:57', 'dolibarr');

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_domain`
--

CREATE TABLE IF NOT EXISTS `llx_domain` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `datec` datetime DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `note` text,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_don`
--

CREATE TABLE IF NOT EXISTS `llx_don` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(30) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_statut` smallint(6) NOT NULL DEFAULT '0',
  `datec` datetime DEFAULT NULL,
  `datedon` datetime DEFAULT NULL,
  `amount` double DEFAULT '0',
  `fk_paiement` int(11) DEFAULT NULL,
  `prenom` varchar(50) DEFAULT NULL,
  `nom` varchar(50) DEFAULT NULL,
  `societe` varchar(50) DEFAULT NULL,
  `adresse` text,
  `cp` varchar(30) DEFAULT NULL,
  `ville` varchar(50) DEFAULT NULL,
  `pays` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(24) DEFAULT NULL,
  `phone_mobile` varchar(24) DEFAULT NULL,
  `public` smallint(6) NOT NULL DEFAULT '1',
  `fk_don_projet` int(11) DEFAULT NULL,
  `fk_user_author` int(11) NOT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `note` text,
  `note_public` text,
  `model_pdf` varchar(255) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_ecm_directories`
--

CREATE TABLE IF NOT EXISTS `llx_ecm_directories` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(32) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `fk_parent` int(11) DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `cachenbofdoc` int(11) NOT NULL DEFAULT '0',
  `date_c` datetime DEFAULT NULL,
  `date_m` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user_c` int(11) DEFAULT NULL,
  `fk_user_m` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `idx_ecm_directories` (`label`,`fk_parent`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_ecm_documents`
--

CREATE TABLE IF NOT EXISTS `llx_ecm_documents` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(16) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `filename` varchar(255) NOT NULL,
  `filesize` int(11) NOT NULL,
  `filemime` varchar(32) NOT NULL,
  `fullpath_dol` varchar(255) NOT NULL,
  `fullpath_orig` varchar(255) NOT NULL,
  `description` text,
  `manualkeyword` text,
  `fk_create` int(11) NOT NULL,
  `fk_update` int(11) DEFAULT NULL,
  `date_c` datetime NOT NULL,
  `date_u` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_directory` int(11) DEFAULT NULL,
  `fk_status` smallint(6) DEFAULT '0',
  `private` smallint(6) DEFAULT '0',
  `crc` varchar(32) NOT NULL DEFAULT '',
  `cryptkey` varchar(50) NOT NULL DEFAULT '',
  `cipher` varchar(50) NOT NULL DEFAULT 'twofish',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `idx_ecm_documents` (`fullpath_dol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_element_contact`
--

CREATE TABLE IF NOT EXISTS `llx_element_contact` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `datecreate` datetime DEFAULT NULL,
  `statut` smallint(6) DEFAULT '5',
  `element_id` int(11) NOT NULL,
  `fk_c_type_contact` int(11) NOT NULL,
  `fk_socpeople` int(11) NOT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `idx_element_contact_idx1` (`element_id`,`fk_c_type_contact`,`fk_socpeople`),
  KEY `fk_element_contact_fk_c_type_contact` (`fk_c_type_contact`),
  KEY `idx_element_contact_fk_socpeople` (`fk_socpeople`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Extraindo dados da tabela `llx_element_contact`
--

INSERT INTO `llx_element_contact` (`rowid`, `datecreate`, `statut`, `element_id`, `fk_c_type_contact`, `fk_socpeople`) VALUES
(1, '2012-02-09 20:44:27', 4, 1, 160, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_element_element`
--

CREATE TABLE IF NOT EXISTS `llx_element_element` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_source` int(11) NOT NULL,
  `sourcetype` varchar(32) NOT NULL,
  `fk_target` int(11) NOT NULL,
  `targettype` varchar(32) NOT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `idx_element_element_idx1` (`fk_source`,`sourcetype`,`fk_target`,`targettype`),
  KEY `idx_element_element_fk_target` (`fk_target`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_element_lock`
--

CREATE TABLE IF NOT EXISTS `llx_element_lock` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_element` int(11) NOT NULL,
  `elementtype` varchar(16) NOT NULL,
  `datel` datetime DEFAULT NULL,
  `datem` datetime DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_entrepot`
--

CREATE TABLE IF NOT EXISTS `llx_entrepot` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `label` varchar(255) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `description` text,
  `lieu` varchar(64) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `cp` varchar(10) DEFAULT NULL,
  `ville` varchar(50) DEFAULT NULL,
  `fk_departement` int(11) DEFAULT NULL,
  `fk_pays` int(11) DEFAULT '0',
  `statut` tinyint(4) DEFAULT '1',
  `valo_pmp` float(12,4) DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_entrepot_label` (`label`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_events`
--

CREATE TABLE IF NOT EXISTS `llx_events` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `type` varchar(32) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `dateevent` datetime DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `description` varchar(250) NOT NULL,
  `ip` varchar(32) NOT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `fk_object` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_events_dateevent` (`dateevent`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Extraindo dados da tabela `llx_events`
--

INSERT INTO `llx_events` (`rowid`, `tms`, `type`, `entity`, `dateevent`, `fk_user`, `description`, `ip`, `user_agent`, `fk_object`) VALUES
(1, '2012-02-09 22:54:35', 'USER_MODIFY', 1, '2012-02-09 20:54:35', 1, 'Usuário kurt Modificado', '200.150.49.186', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.77 Safari/535.7', NULL),
(2, '2012-02-09 23:58:17', 'USER_LOGIN', 1, '2012-02-09 21:58:17', 2, '(UserLogged,kurt)', '200.150.49.186', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.77 Safari/535.7', NULL),
(3, '2012-02-09 23:59:01', 'USER_LOGIN', 1, '2012-02-09 21:59:01', 1, '(UserLogged,rafso)', '200.150.49.186', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.77 Safari/535.7', NULL),
(4, '2012-02-10 00:18:37', 'USER_LOGIN', 1, '2012-02-09 22:18:37', 2, '(UserLogged,kurt)', '200.150.49.186', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.77 Safari/535.7', NULL),
(5, '2012-02-10 09:56:04', 'USER_LOGIN', 1, '2012-02-10 07:56:04', 2, '(UserLogged,kurt)', '201.17.159.71', 'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)', NULL),
(6, '2012-02-10 12:07:28', 'USER_LOGIN', 1, '2012-02-10 10:07:28', 2, '(UserLogged,kurt)', '201.17.159.71', 'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; WOW64; Trident/4.0; GTB7.2; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; InfoPath.3; .NET CLR 1.1.4322)', NULL),
(7, '2012-02-12 10:56:25', 'USER_LOGIN', 1, '2012-02-12 08:56:25', 1, '(UserLogged,rafso)', '200.150.49.186', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.77 Safari/535.7', NULL),
(8, '2012-02-13 01:53:46', 'USER_LOGIN', 1, '2012-02-12 23:53:46', 1, '(UserLogged,rafso)', '200.150.49.186', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.77 Safari/535.7', NULL),
(9, '2012-02-13 02:04:25', 'USER_LOGIN', 1, '2012-02-13 00:04:25', 1, '(UserLogged,rafso)', '200.150.49.186', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.77 Safari/535.7', NULL),
(10, '2012-02-27 20:30:48', 'USER_LOGIN', 1, '2012-02-27 17:30:48', 2, '(UserLogged,kurt)', '201.80.113.76', 'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_expedition`
--

CREATE TABLE IF NOT EXISTS `llx_expedition` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ref` varchar(30) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `fk_soc` int(11) NOT NULL,
  `ref_ext` varchar(30) DEFAULT NULL,
  `ref_int` varchar(30) DEFAULT NULL,
  `ref_customer` varchar(30) DEFAULT NULL,
  `date_creation` datetime DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `date_valid` datetime DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `date_expedition` datetime DEFAULT NULL,
  `date_delivery` datetime DEFAULT NULL,
  `fk_address` int(11) DEFAULT NULL,
  `fk_expedition_methode` int(11) DEFAULT NULL,
  `tracking_number` varchar(50) DEFAULT NULL,
  `fk_statut` smallint(6) DEFAULT '0',
  `height` int(11) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `size_units` int(11) DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `weight_units` int(11) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `note` text,
  `model_pdf` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `idx_expedition_uk_ref` (`ref`,`entity`),
  KEY `idx_expedition_fk_soc` (`fk_soc`),
  KEY `idx_expedition_fk_user_author` (`fk_user_author`),
  KEY `idx_expedition_fk_user_valid` (`fk_user_valid`),
  KEY `idx_expedition_fk_expedition_methode` (`fk_expedition_methode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_expeditiondet`
--

CREATE TABLE IF NOT EXISTS `llx_expeditiondet` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_expedition` int(11) NOT NULL,
  `fk_origin_line` int(11) DEFAULT NULL,
  `fk_entrepot` int(11) DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `rang` int(11) DEFAULT '0',
  PRIMARY KEY (`rowid`),
  KEY `idx_expeditiondet_fk_expedition` (`fk_expedition`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_export_compta`
--

CREATE TABLE IF NOT EXISTS `llx_export_compta` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(12) NOT NULL,
  `date_export` datetime NOT NULL,
  `fk_user` int(11) NOT NULL,
  `note` text,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_export_model`
--

CREATE TABLE IF NOT EXISTS `llx_export_model` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_user` int(11) NOT NULL DEFAULT '0',
  `label` varchar(50) NOT NULL,
  `type` varchar(20) NOT NULL,
  `field` text NOT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_export_model` (`label`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_extrafields`
--

CREATE TABLE IF NOT EXISTS `llx_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `elementtype` varchar(64) NOT NULL DEFAULT 'member',
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `label` varchar(255) NOT NULL,
  `type` varchar(8) DEFAULT NULL,
  `size` int(11) DEFAULT '0',
  `pos` int(11) DEFAULT '0',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_extrafields_name` (`name`,`entity`,`elementtype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_facture`
--

CREATE TABLE IF NOT EXISTS `llx_facture` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `facnumber` varchar(30) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref_ext` varchar(50) DEFAULT NULL,
  `ref_int` varchar(50) DEFAULT NULL,
  `ref_client` varchar(50) DEFAULT NULL,
  `type` smallint(6) NOT NULL DEFAULT '0',
  `increment` varchar(10) DEFAULT NULL,
  `fk_soc` int(11) NOT NULL,
  `datec` datetime DEFAULT NULL,
  `datef` date DEFAULT NULL,
  `date_valid` date DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `paye` smallint(6) NOT NULL DEFAULT '0',
  `amount` double(24,8) NOT NULL DEFAULT '0.00000000',
  `remise_percent` double DEFAULT '0',
  `remise_absolue` double DEFAULT '0',
  `remise` double DEFAULT '0',
  `close_code` varchar(16) DEFAULT NULL,
  `close_note` varchar(128) DEFAULT NULL,
  `tva` double(24,8) DEFAULT '0.00000000',
  `localtax1` double(24,8) DEFAULT '0.00000000',
  `localtax2` double(24,8) DEFAULT '0.00000000',
  `total` double(24,8) DEFAULT '0.00000000',
  `total_ttc` double(24,8) DEFAULT '0.00000000',
  `fk_statut` smallint(6) NOT NULL DEFAULT '0',
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_facture_source` int(11) DEFAULT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `fk_cond_reglement` int(11) NOT NULL DEFAULT '1',
  `fk_mode_reglement` int(11) DEFAULT NULL,
  `date_lim_reglement` date DEFAULT NULL,
  `note` text,
  `note_public` text,
  `model_pdf` varchar(255) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `idx_facture_uk_facnumber` (`facnumber`,`entity`),
  KEY `idx_facture_fk_soc` (`fk_soc`),
  KEY `idx_facture_fk_user_author` (`fk_user_author`),
  KEY `idx_facture_fk_user_valid` (`fk_user_valid`),
  KEY `idx_facture_fk_facture_source` (`fk_facture_source`),
  KEY `idx_facture_fk_projet` (`fk_projet`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_facturedet`
--

CREATE TABLE IF NOT EXISTS `llx_facturedet` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_facture` int(11) NOT NULL,
  `fk_parent_line` int(11) DEFAULT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `description` text,
  `tva_tx` double(6,3) DEFAULT NULL,
  `localtax1_tx` double(6,3) DEFAULT '0.000',
  `localtax2_tx` double(6,3) DEFAULT '0.000',
  `qty` double DEFAULT NULL,
  `remise_percent` double DEFAULT '0',
  `remise` double DEFAULT '0',
  `fk_remise_except` int(11) DEFAULT NULL,
  `subprice` double(24,8) DEFAULT NULL,
  `price` double(24,8) DEFAULT NULL,
  `total_ht` double(24,8) DEFAULT NULL,
  `total_tva` double(24,8) DEFAULT NULL,
  `total_localtax1` double(24,8) DEFAULT '0.00000000',
  `total_localtax2` double(24,8) DEFAULT '0.00000000',
  `total_ttc` double(24,8) DEFAULT NULL,
  `product_type` int(11) DEFAULT '0',
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `info_bits` int(11) DEFAULT '0',
  `fk_code_ventilation` int(11) NOT NULL DEFAULT '0',
  `fk_export_compta` int(11) NOT NULL DEFAULT '0',
  `special_code` int(10) unsigned DEFAULT '0',
  `rang` int(11) DEFAULT '0',
  `import_key` varchar(14) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_fk_remise_except` (`fk_remise_except`,`fk_facture`),
  KEY `idx_facturedet_fk_facture` (`fk_facture`),
  KEY `idx_facturedet_fk_product` (`fk_product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_facturedet_rec`
--

CREATE TABLE IF NOT EXISTS `llx_facturedet_rec` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_facture` int(11) NOT NULL,
  `fk_parent_line` int(11) DEFAULT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `product_type` int(11) DEFAULT '0',
  `description` text,
  `tva_tx` double(6,3) DEFAULT '19.600',
  `localtax1_tx` double(6,3) DEFAULT '0.000',
  `localtax2_tx` double(6,3) DEFAULT '0.000',
  `qty` double DEFAULT NULL,
  `remise_percent` double DEFAULT '0',
  `remise` double DEFAULT '0',
  `subprice` double(24,8) DEFAULT NULL,
  `price` double(24,8) DEFAULT NULL,
  `total_ht` double(24,8) DEFAULT NULL,
  `total_tva` double(24,8) DEFAULT NULL,
  `total_localtax1` double(24,8) DEFAULT '0.00000000',
  `total_localtax2` double(24,8) DEFAULT '0.00000000',
  `total_ttc` double(24,8) DEFAULT NULL,
  `special_code` int(10) unsigned DEFAULT '0',
  `rang` int(11) DEFAULT '0',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_facture_fourn`
--

CREATE TABLE IF NOT EXISTS `llx_facture_fourn` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `facnumber` varchar(50) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref_ext` varchar(30) DEFAULT NULL,
  `type` smallint(6) NOT NULL DEFAULT '0',
  `fk_soc` int(11) NOT NULL,
  `datec` datetime DEFAULT NULL,
  `datef` date DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `libelle` varchar(255) DEFAULT NULL,
  `paye` smallint(6) NOT NULL DEFAULT '0',
  `amount` double(24,8) NOT NULL DEFAULT '0.00000000',
  `remise` double(24,8) DEFAULT '0.00000000',
  `close_code` varchar(16) DEFAULT NULL,
  `close_note` varchar(128) DEFAULT NULL,
  `tva` double(24,8) DEFAULT '0.00000000',
  `localtax1` double(24,8) DEFAULT '0.00000000',
  `localtax2` double(24,8) DEFAULT '0.00000000',
  `total` double(24,8) DEFAULT '0.00000000',
  `total_ht` double(24,8) DEFAULT '0.00000000',
  `total_tva` double(24,8) DEFAULT '0.00000000',
  `total_ttc` double(24,8) DEFAULT '0.00000000',
  `fk_statut` smallint(6) NOT NULL DEFAULT '0',
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_facture_source` int(11) DEFAULT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `fk_cond_reglement` int(11) NOT NULL DEFAULT '1',
  `date_lim_reglement` date DEFAULT NULL,
  `note` text,
  `note_public` text,
  `model_pdf` varchar(255) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_facture_fourn_ref` (`facnumber`,`fk_soc`,`entity`),
  KEY `idx_facture_fourn_date_lim_reglement` (`date_lim_reglement`),
  KEY `idx_facture_fourn_fk_soc` (`fk_soc`),
  KEY `idx_facture_fourn_fk_user_author` (`fk_user_author`),
  KEY `idx_facture_fourn_fk_user_valid` (`fk_user_valid`),
  KEY `idx_facture_fourn_fk_projet` (`fk_projet`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_facture_fourn_det`
--

CREATE TABLE IF NOT EXISTS `llx_facture_fourn_det` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_facture_fourn` int(11) NOT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `ref` varchar(50) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `description` text,
  `pu_ht` double(24,8) DEFAULT NULL,
  `pu_ttc` double(24,8) DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `tva_tx` double(6,3) DEFAULT NULL,
  `localtax1_tx` double(6,3) DEFAULT '0.000',
  `localtax2_tx` double(6,3) DEFAULT '0.000',
  `total_ht` double(24,8) DEFAULT NULL,
  `tva` double(24,8) DEFAULT NULL,
  `total_localtax1` double(24,8) DEFAULT '0.00000000',
  `total_localtax2` double(24,8) DEFAULT '0.00000000',
  `total_ttc` double(24,8) DEFAULT NULL,
  `product_type` int(11) DEFAULT '0',
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_facture_fourn_det_fk_facture` (`fk_facture_fourn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_facture_rec`
--

CREATE TABLE IF NOT EXISTS `llx_facture_rec` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `titre` varchar(50) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `fk_soc` int(11) NOT NULL,
  `datec` datetime DEFAULT NULL,
  `amount` double(24,8) NOT NULL DEFAULT '0.00000000',
  `remise` double DEFAULT '0',
  `remise_percent` double DEFAULT '0',
  `remise_absolue` double DEFAULT '0',
  `tva` double(24,8) DEFAULT '0.00000000',
  `localtax1` double(24,8) DEFAULT '0.00000000',
  `localtax2` double(24,8) DEFAULT '0.00000000',
  `total` double(24,8) DEFAULT '0.00000000',
  `total_ttc` double(24,8) DEFAULT '0.00000000',
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `fk_cond_reglement` int(11) DEFAULT '0',
  `fk_mode_reglement` int(11) DEFAULT '0',
  `date_lim_reglement` date DEFAULT NULL,
  `note` text,
  `note_public` text,
  `frequency` int(11) DEFAULT NULL,
  `unit_frequency` varchar(2) DEFAULT 'd',
  `date_when` datetime DEFAULT NULL,
  `date_last_gen` datetime DEFAULT NULL,
  `nb_gen_done` int(11) DEFAULT NULL,
  `nb_gen_max` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `idx_facture_rec_uk_titre` (`titre`,`entity`),
  KEY `idx_facture_rec_fk_soc` (`fk_soc`),
  KEY `idx_facture_rec_fk_user_author` (`fk_user_author`),
  KEY `idx_facture_rec_fk_projet` (`fk_projet`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_fichinter`
--

CREATE TABLE IF NOT EXISTS `llx_fichinter` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_soc` int(11) NOT NULL,
  `fk_projet` int(11) DEFAULT '0',
  `fk_contrat` int(11) DEFAULT '0',
  `ref` varchar(30) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datec` datetime DEFAULT NULL,
  `date_valid` datetime DEFAULT NULL,
  `datei` date DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_statut` smallint(6) DEFAULT '0',
  `duree` double DEFAULT NULL,
  `description` text,
  `note_private` text,
  `note_public` text,
  `model_pdf` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_fichinter_ref` (`ref`,`entity`),
  KEY `idx_fichinter_fk_soc` (`fk_soc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_fichinterdet`
--

CREATE TABLE IF NOT EXISTS `llx_fichinterdet` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_fichinter` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `description` text,
  `duree` int(11) DEFAULT NULL,
  `rang` int(11) DEFAULT '0',
  PRIMARY KEY (`rowid`),
  KEY `idx_fichinterdet_fk_fichinter` (`fk_fichinter`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_import_model`
--

CREATE TABLE IF NOT EXISTS `llx_import_model` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_user` int(11) NOT NULL DEFAULT '0',
  `label` varchar(50) NOT NULL,
  `type` varchar(20) NOT NULL,
  `field` text NOT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_import_model` (`label`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_livraison`
--

CREATE TABLE IF NOT EXISTS `llx_livraison` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ref` varchar(30) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `fk_soc` int(11) NOT NULL,
  `ref_ext` varchar(30) DEFAULT NULL,
  `ref_int` varchar(30) DEFAULT NULL,
  `ref_customer` varchar(30) DEFAULT NULL,
  `date_creation` datetime DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `date_valid` datetime DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `date_delivery` date DEFAULT NULL,
  `fk_address` int(11) DEFAULT NULL,
  `fk_statut` smallint(6) DEFAULT '0',
  `total_ht` double(24,8) DEFAULT '0.00000000',
  `note` text,
  `note_public` text,
  `model_pdf` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `idx_livraison_uk_ref` (`ref`,`entity`),
  KEY `idx_livraison_fk_soc` (`fk_soc`),
  KEY `idx_livraison_fk_user_author` (`fk_user_author`),
  KEY `idx_livraison_fk_user_valid` (`fk_user_valid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_livraisondet`
--

CREATE TABLE IF NOT EXISTS `llx_livraisondet` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_livraison` int(11) DEFAULT NULL,
  `fk_origin_line` int(11) DEFAULT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `description` text,
  `qty` double DEFAULT NULL,
  `subprice` double(24,8) DEFAULT '0.00000000',
  `total_ht` double(24,8) DEFAULT '0.00000000',
  `rang` int(11) DEFAULT '0',
  PRIMARY KEY (`rowid`),
  KEY `idx_livraisondet_fk_expedition` (`fk_livraison`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_mailing`
--

CREATE TABLE IF NOT EXISTS `llx_mailing` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `statut` smallint(6) DEFAULT '0',
  `titre` varchar(60) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `sujet` varchar(60) DEFAULT NULL,
  `body` text,
  `bgcolor` varchar(8) DEFAULT NULL,
  `bgimage` varchar(255) DEFAULT NULL,
  `cible` varchar(60) DEFAULT NULL,
  `nbemail` int(11) DEFAULT NULL,
  `email_from` varchar(160) DEFAULT NULL,
  `email_replyto` varchar(160) DEFAULT NULL,
  `email_errorsto` varchar(160) DEFAULT NULL,
  `tag` varchar(128) DEFAULT NULL,
  `date_creat` datetime DEFAULT NULL,
  `date_valid` datetime DEFAULT NULL,
  `date_appro` datetime DEFAULT NULL,
  `date_envoi` datetime DEFAULT NULL,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_user_appro` int(11) DEFAULT NULL,
  `joined_file1` varchar(255) DEFAULT NULL,
  `joined_file2` varchar(255) DEFAULT NULL,
  `joined_file3` varchar(255) DEFAULT NULL,
  `joined_file4` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_mailing_cibles`
--

CREATE TABLE IF NOT EXISTS `llx_mailing_cibles` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_mailing` int(11) NOT NULL,
  `fk_contact` int(11) NOT NULL,
  `nom` varchar(160) DEFAULT NULL,
  `prenom` varchar(160) DEFAULT NULL,
  `email` varchar(160) NOT NULL,
  `other` varchar(255) DEFAULT NULL,
  `tag` varchar(128) DEFAULT NULL,
  `statut` smallint(6) NOT NULL DEFAULT '0',
  `source_url` varchar(160) DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  `source_type` varchar(16) DEFAULT NULL,
  `date_envoi` datetime DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_mailing_cibles` (`fk_mailing`,`email`),
  KEY `idx_mailing_cibles_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_menu`
--

CREATE TABLE IF NOT EXISTS `llx_menu` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `menu_handler` varchar(16) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `module` varchar(64) DEFAULT NULL,
  `type` varchar(4) NOT NULL,
  `mainmenu` varchar(100) NOT NULL,
  `leftmenu` varchar(100) DEFAULT NULL,
  `fk_menu` int(11) NOT NULL,
  `fk_mainmenu` varchar(16) DEFAULT NULL,
  `fk_leftmenu` varchar(16) DEFAULT NULL,
  `position` int(11) NOT NULL,
  `url` varchar(255) NOT NULL,
  `target` varchar(100) DEFAULT NULL,
  `titre` varchar(255) NOT NULL,
  `langs` varchar(100) DEFAULT NULL,
  `level` smallint(6) DEFAULT NULL,
  `perms` varchar(255) DEFAULT NULL,
  `enabled` varchar(255) DEFAULT '1',
  `usertype` int(11) NOT NULL DEFAULT '0',
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `idx_menu_uk_menu` (`menu_handler`,`fk_menu`,`position`,`url`,`entity`),
  KEY `idx_menu_menuhandler_type` (`menu_handler`,`type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=21 ;

--
-- Extraindo dados da tabela `llx_menu`
--

INSERT INTO `llx_menu` (`rowid`, `menu_handler`, `entity`, `module`, `type`, `mainmenu`, `leftmenu`, `fk_menu`, `fk_mainmenu`, `fk_leftmenu`, `position`, `url`, `target`, `titre`, `langs`, `level`, `perms`, `enabled`, `usertype`, `tms`) VALUES
(6, 'all', 1, 'agenda', 'top', 'agenda', '1', 0, NULL, NULL, 100, '/comm/action/index.php', '', 'Agenda', 'agenda', NULL, '$user->rights->agenda->myactions->read', '$conf->agenda->enabled', 2, '2012-02-09 22:25:45'),
(7, 'all', 1, 'agenda', 'left', 'agenda', '0', 6, NULL, NULL, 100, '/comm/action/index.php?mainmenu=agenda&amp;leftmenu=agenda', '', 'Actions', 'agenda', NULL, '$user->rights->agenda->myactions->read', '$conf->agenda->enabled', 2, '2012-02-09 22:25:45'),
(8, 'all', 1, 'agenda', 'left', 'agenda', '0', 7, NULL, NULL, 101, '/comm/action/fiche.php?mainmenu=agenda&amp;leftmenu=agenda&amp;action=create', '', 'NewAction', 'commercial', NULL, '($user->rights->agenda->myactions->create||$user->rights->agenda->allactions->create)', '$conf->agenda->enabled', 2, '2012-02-09 22:25:45'),
(9, 'all', 1, 'agenda', 'left', 'agenda', '0', 7, NULL, NULL, 102, '/comm/action/index.php?mainmenu=agenda&amp;leftmenu=agenda', '', 'Calendar', 'agenda', NULL, '$user->rights->agenda->myactions->read', '$conf->agenda->enabled', 2, '2012-02-09 22:25:45'),
(10, 'all', 1, 'agenda', 'left', 'agenda', '0', 9, NULL, NULL, 103, '/comm/action/index.php?mainmenu=agenda&amp;leftmenu=agenda&amp;status=todo&amp;filter=mine', '', 'MenuToDoMyActions', 'agenda', NULL, '$user->rights->agenda->myactions->read', '$conf->agenda->enabled', 2, '2012-02-09 22:25:45'),
(11, 'all', 1, 'agenda', 'left', 'agenda', '0', 9, NULL, NULL, 104, '/comm/action/index.php?mainmenu=agenda&amp;leftmenu=agenda&amp;status=done&amp;filter=mine', '', 'MenuDoneMyActions', 'agenda', NULL, '$user->rights->agenda->myactions->read', '$conf->agenda->enabled', 2, '2012-02-09 22:25:45'),
(12, 'all', 1, 'agenda', 'left', 'agenda', '0', 9, NULL, NULL, 105, '/comm/action/index.php?mainmenu=agenda&amp;leftmenu=agenda&amp;status=todo', '', 'MenuToDoActions', 'agenda', NULL, '$user->rights->agenda->allactions->read', '$user->rights->agenda->allactions->read', 2, '2012-02-09 22:25:45'),
(13, 'all', 1, 'agenda', 'left', 'agenda', '0', 9, NULL, NULL, 106, '/comm/action/index.php?mainmenu=agenda&amp;leftmenu=agenda&amp;status=done', '', 'MenuDoneActions', 'agenda', NULL, '$user->rights->agenda->allactions->read', '$user->rights->agenda->allactions->read', 2, '2012-02-09 22:25:45'),
(14, 'all', 1, 'agenda', 'left', 'agenda', '0', 7, NULL, NULL, 112, '/comm/action/listactions.php?mainmenu=agenda&amp;leftmenu=agenda', '', 'List', 'agenda', NULL, '$user->rights->agenda->myactions->read', '$conf->agenda->enabled', 2, '2012-02-09 22:25:45'),
(15, 'all', 1, 'agenda', 'left', 'agenda', '0', 14, NULL, NULL, 113, '/comm/action/listactions.php?mainmenu=agenda&amp;leftmenu=agenda&amp;status=todo&amp;filter=mine', '', 'MenuToDoMyActions', 'agenda', NULL, '$user->rights->agenda->myactions->read', '$conf->agenda->enabled', 2, '2012-02-09 22:25:45'),
(16, 'all', 1, 'agenda', 'left', 'agenda', '0', 14, NULL, NULL, 114, '/comm/action/listactions.php?mainmenu=agenda&amp;leftmenu=agenda&amp;status=done&amp;filter=mine', '', 'MenuDoneMyActions', 'agenda', NULL, '$user->rights->agenda->myactions->read', '$conf->agenda->enabled', 2, '2012-02-09 22:25:45'),
(17, 'all', 1, 'agenda', 'left', 'agenda', '0', 14, NULL, NULL, 115, '/comm/action/listactions.php?mainmenu=agenda&amp;leftmenu=agenda&amp;status=todo', '', 'MenuToDoActions', 'agenda', NULL, '$user->rights->agenda->allactions->read', '$user->rights->agenda->allactions->read', 2, '2012-02-09 22:25:45'),
(18, 'all', 1, 'agenda', 'left', 'agenda', '0', 14, NULL, NULL, 116, '/comm/action/listactions.php?mainmenu=agenda&amp;leftmenu=agenda&amp;status=done', '', 'MenuDoneActions', 'agenda', NULL, '$user->rights->agenda->allactions->read', '$user->rights->agenda->allactions->read', 2, '2012-02-09 22:25:45'),
(19, 'all', 1, 'agenda', 'left', 'agenda', '0', 7, NULL, NULL, 120, '/comm/action/rapport/index.php?mainmenu=agenda&amp;leftmenu=agenda', '', 'Reportings', 'agenda', NULL, '$user->rights->agenda->allactions->read', '$conf->agenda->enabled', 2, '2012-02-09 22:25:45'),
(20, 'all', 1, 'cashdesk', 'top', 'cashdesk', '1', 0, NULL, NULL, 100, '/cashdesk/index.php?user=__LOGIN__', 'pointofsale', 'CashDeskMenu', 'cashdesk', NULL, '$user->rights->cashdesk->use', '$conf->cashdesk->enabled', 0, '2012-02-12 11:15:57');

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_notify`
--

CREATE TABLE IF NOT EXISTS `llx_notify` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `daten` datetime DEFAULT NULL,
  `fk_action` int(11) NOT NULL,
  `fk_contact` int(11) DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `objet_type` varchar(24) NOT NULL,
  `objet_id` int(11) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_notify_def`
--

CREATE TABLE IF NOT EXISTS `llx_notify_def` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datec` date DEFAULT NULL,
  `fk_action` int(11) NOT NULL,
  `fk_soc` int(11) NOT NULL,
  `fk_contact` int(11) DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `type` varchar(16) DEFAULT 'email',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_paiement`
--

CREATE TABLE IF NOT EXISTS `llx_paiement` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datep` datetime DEFAULT NULL,
  `amount` double(24,8) DEFAULT '0.00000000',
  `fk_paiement` int(11) NOT NULL,
  `num_paiement` varchar(50) DEFAULT NULL,
  `note` text,
  `fk_bank` int(11) NOT NULL DEFAULT '0',
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `statut` smallint(6) NOT NULL DEFAULT '0',
  `fk_export_compta` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_paiementcharge`
--

CREATE TABLE IF NOT EXISTS `llx_paiementcharge` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_charge` int(11) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datep` datetime DEFAULT NULL,
  `amount` double DEFAULT '0',
  `fk_typepaiement` int(11) NOT NULL,
  `num_paiement` varchar(50) DEFAULT NULL,
  `note` text,
  `fk_bank` int(11) NOT NULL,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_paiementfourn`
--

CREATE TABLE IF NOT EXISTS `llx_paiementfourn` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datec` datetime DEFAULT NULL,
  `datep` datetime DEFAULT NULL,
  `amount` double DEFAULT '0',
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_paiement` int(11) NOT NULL,
  `num_paiement` varchar(50) DEFAULT NULL,
  `note` text,
  `fk_bank` int(11) NOT NULL,
  `statut` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_paiementfourn_facturefourn`
--

CREATE TABLE IF NOT EXISTS `llx_paiementfourn_facturefourn` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_paiementfourn` int(11) DEFAULT NULL,
  `fk_facturefourn` int(11) DEFAULT NULL,
  `amount` double(24,8) DEFAULT '0.00000000',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_paiementfourn_facturefourn` (`fk_paiementfourn`,`fk_facturefourn`),
  KEY `idx_paiementfourn_facturefourn_fk_facture` (`fk_facturefourn`),
  KEY `idx_paiementfourn_facturefourn_fk_paiement` (`fk_paiementfourn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_paiement_facture`
--

CREATE TABLE IF NOT EXISTS `llx_paiement_facture` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_paiement` int(11) DEFAULT NULL,
  `fk_facture` int(11) DEFAULT NULL,
  `amount` double(24,8) DEFAULT '0.00000000',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_paiement_facture` (`fk_paiement`,`fk_facture`),
  KEY `idx_paiement_facture_fk_facture` (`fk_facture`),
  KEY `idx_paiement_facture_fk_paiement` (`fk_paiement`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_pos_tmp`
--

CREATE TABLE IF NOT EXISTS `llx_pos_tmp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_article` int(11) NOT NULL,
  `qte` double NOT NULL,
  `fk_tva` int(11) NOT NULL,
  `remise_percent` double NOT NULL,
  `remise` double NOT NULL,
  `total_ht` double(24,8) NOT NULL,
  `total_tva` double(24,8) NOT NULL,
  `total_ttc` double(24,8) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_prelevement_bons`
--

CREATE TABLE IF NOT EXISTS `llx_prelevement_bons` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(12) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `datec` datetime DEFAULT NULL,
  `amount` double DEFAULT '0',
  `statut` smallint(6) DEFAULT '0',
  `credite` smallint(6) DEFAULT '0',
  `note` text,
  `date_trans` datetime DEFAULT NULL,
  `method_trans` smallint(6) DEFAULT NULL,
  `fk_user_trans` int(11) DEFAULT NULL,
  `date_credit` datetime DEFAULT NULL,
  `fk_user_credit` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_prelevement_bons_ref` (`ref`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_prelevement_facture`
--

CREATE TABLE IF NOT EXISTS `llx_prelevement_facture` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_facture` int(11) NOT NULL,
  `fk_prelevement_lignes` int(11) NOT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_prelevement_facture_fk_prelevement_lignes` (`fk_prelevement_lignes`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_prelevement_facture_demande`
--

CREATE TABLE IF NOT EXISTS `llx_prelevement_facture_demande` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_facture` int(11) NOT NULL,
  `amount` double NOT NULL,
  `date_demande` datetime NOT NULL,
  `traite` smallint(6) DEFAULT '0',
  `date_traite` datetime DEFAULT NULL,
  `fk_prelevement_bons` int(11) DEFAULT NULL,
  `fk_user_demande` int(11) NOT NULL,
  `code_banque` varchar(7) DEFAULT NULL,
  `code_guichet` varchar(6) DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL,
  `cle_rib` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_prelevement_lignes`
--

CREATE TABLE IF NOT EXISTS `llx_prelevement_lignes` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_prelevement_bons` int(11) DEFAULT NULL,
  `fk_soc` int(11) NOT NULL,
  `statut` smallint(6) DEFAULT '0',
  `client_nom` varchar(255) DEFAULT NULL,
  `amount` double DEFAULT '0',
  `code_banque` varchar(7) DEFAULT NULL,
  `code_guichet` varchar(6) DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL,
  `cle_rib` varchar(5) DEFAULT NULL,
  `note` text,
  PRIMARY KEY (`rowid`),
  KEY `idx_prelevement_lignes_fk_prelevement_bons` (`fk_prelevement_bons`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_prelevement_rejet`
--

CREATE TABLE IF NOT EXISTS `llx_prelevement_rejet` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_prelevement_lignes` int(11) DEFAULT NULL,
  `date_rejet` datetime DEFAULT NULL,
  `motif` int(11) DEFAULT NULL,
  `date_creation` datetime DEFAULT NULL,
  `fk_user_creation` int(11) DEFAULT NULL,
  `note` text,
  `afacturer` tinyint(4) DEFAULT '0',
  `fk_facture` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_product`
--

CREATE TABLE IF NOT EXISTS `llx_product` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(32) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref_ext` varchar(32) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `virtual` tinyint(4) NOT NULL DEFAULT '0',
  `fk_parent` int(11) DEFAULT '0',
  `label` varchar(255) NOT NULL,
  `description` text,
  `note` text,
  `customcode` varchar(32) DEFAULT NULL,
  `fk_country` int(11) DEFAULT NULL,
  `price` double(24,8) DEFAULT '0.00000000',
  `price_ttc` double(24,8) DEFAULT '0.00000000',
  `price_min` double(24,8) DEFAULT '0.00000000',
  `price_min_ttc` double(24,8) DEFAULT '0.00000000',
  `price_base_type` varchar(3) DEFAULT 'HT',
  `tva_tx` double(6,3) DEFAULT NULL,
  `recuperableonly` int(11) NOT NULL DEFAULT '0',
  `localtax1_tx` double(6,3) DEFAULT '0.000',
  `localtax2_tx` double(6,3) DEFAULT '0.000',
  `fk_user_author` int(11) DEFAULT NULL,
  `tosell` tinyint(4) DEFAULT '1',
  `tobuy` tinyint(4) DEFAULT '1',
  `fk_product_type` int(11) DEFAULT '0',
  `duration` varchar(6) DEFAULT NULL,
  `seuil_stock_alerte` int(11) DEFAULT '0',
  `barcode` varchar(255) DEFAULT NULL,
  `fk_barcode_type` int(11) DEFAULT '0',
  `accountancy_code_sell` varchar(15) DEFAULT NULL,
  `accountancy_code_buy` varchar(15) DEFAULT NULL,
  `partnumber` varchar(32) DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `weight_units` tinyint(4) DEFAULT NULL,
  `length` float DEFAULT NULL,
  `length_units` tinyint(4) DEFAULT NULL,
  `surface` float DEFAULT NULL,
  `surface_units` tinyint(4) DEFAULT NULL,
  `volume` float DEFAULT NULL,
  `volume_units` tinyint(4) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `pmp` double(24,8) NOT NULL DEFAULT '0.00000000',
  `canvas` varchar(32) DEFAULT 'default@product',
  `finished` tinyint(4) DEFAULT NULL,
  `hidden` tinyint(4) DEFAULT '0',
  `import_key` varchar(14) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_product_ref` (`ref`,`entity`),
  KEY `idx_product_label` (`label`),
  KEY `idx_product_barcode` (`barcode`),
  KEY `idx_product_import_key` (`import_key`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Extraindo dados da tabela `llx_product`
--

INSERT INTO `llx_product` (`rowid`, `ref`, `entity`, `ref_ext`, `datec`, `tms`, `virtual`, `fk_parent`, `label`, `description`, `note`, `customcode`, `fk_country`, `price`, `price_ttc`, `price_min`, `price_min_ttc`, `price_base_type`, `tva_tx`, `recuperableonly`, `localtax1_tx`, `localtax2_tx`, `fk_user_author`, `tosell`, `tobuy`, `fk_product_type`, `duration`, `seuil_stock_alerte`, `barcode`, `fk_barcode_type`, `accountancy_code_sell`, `accountancy_code_buy`, `partnumber`, `weight`, `weight_units`, `length`, `length_units`, `surface`, `surface_units`, `volume`, `volume_units`, `stock`, `pmp`, `canvas`, `finished`, `hidden`, `import_key`) VALUES
(1, 'Ref', 1, NULL, '2012-02-09 21:27:38', '2012-02-12 11:01:47', 0, 0, 'Instalação de pia', 'instala&ccedil;&atilde;o de pia de marmore at&eacute; 40 cm', '', '', 25, 100.00000000, 100.00000000, 75.00000000, 75.00000000, 'TTC', 0.000, 0, 0.000, 0.000, 1, 1, 1, 1, '4h', NULL, NULL, 0, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.00000000, '', 0, 0, NULL),
(2, 'ref2', 1, NULL, '2012-02-09 21:35:57', '2012-02-09 23:35:57', 0, 0, 'Pedreiro', '', '', '', 25, 70.00000000, 70.00000000, 60.00000000, 60.00000000, 'TTC', 0.000, 0, 0.000, 0.000, 1, 1, 1, 1, 'd', NULL, NULL, 0, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.00000000, '', 0, 0, NULL),
(3, 'ref1', 1, NULL, '2012-02-09 21:41:50', '2012-02-12 11:02:35', 0, 0, 'Tijolo', 'tijolo de barro', '', '', 25, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 'HT', 0.000, 0, 0.000, 0.000, 1, 1, 1, 0, '', NULL, NULL, 0, '', '', NULL, NULL, 0, NULL, 0, 10, 0, NULL, 0, NULL, 0.00000000, '', 0, 0, NULL),
(4, 'ref2d', 1, NULL, '2012-02-09 21:46:16', '2012-02-09 23:46:31', 0, 0, 'Areia fina', 'teste', '', '', 25, 100.00000000, 100.00000000, 100.00000000, 100.00000000, 'HT', 0.000, 0, 0.000, 0.000, 1, 1, 1, 0, '', NULL, NULL, 0, '', '', NULL, NULL, 0, NULL, 0, 1, 0, NULL, 0, NULL, 0.00000000, '', 0, 0, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_product_association`
--

CREATE TABLE IF NOT EXISTS `llx_product_association` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_product_pere` int(11) NOT NULL DEFAULT '0',
  `fk_product_fils` int(11) NOT NULL DEFAULT '0',
  `qty` double DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_product_association` (`fk_product_pere`,`fk_product_fils`),
  KEY `idx_product_association_fils` (`fk_product_fils`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_product_ca`
--

CREATE TABLE IF NOT EXISTS `llx_product_ca` (
  `fk_product` int(11) DEFAULT NULL,
  `date_calcul` datetime DEFAULT NULL,
  `year` smallint(5) unsigned DEFAULT NULL,
  `ca_genere` float DEFAULT NULL,
  UNIQUE KEY `fk_product` (`fk_product`,`year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_product_composition`
--

CREATE TABLE IF NOT EXISTS `llx_product_composition` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_product` int(11) NOT NULL,
  `fk_product_composition` int(11) NOT NULL,
  `qte` int(11) DEFAULT '0',
  `etat_stock` tinyint(4) NOT NULL DEFAULT '0',
  `buying_cost` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rowid`),
  KEY `idx_product_composition_fk_product` (`fk_product`),
  KEY `idx_product_composition_fk_product_composition` (`fk_product_composition`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_product_extrafields`
--

CREATE TABLE IF NOT EXISTS `llx_product_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_product_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_product_fournisseur`
--

CREATE TABLE IF NOT EXISTS `llx_product_fournisseur` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_product` int(11) DEFAULT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `ref_fourn` varchar(30) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `fk_user_author` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_product_fournisseur_ref` (`ref_fourn`,`fk_soc`,`entity`),
  KEY `idx_product_fourn_fk_product` (`fk_product`,`entity`),
  KEY `idx_product_fourn_fk_soc` (`fk_soc`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_product_fournisseur_price`
--

CREATE TABLE IF NOT EXISTS `llx_product_fournisseur_price` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_product_fournisseur` int(11) NOT NULL,
  `price` double(24,8) DEFAULT '0.00000000',
  `quantity` double DEFAULT NULL,
  `unitprice` double(24,8) DEFAULT '0.00000000',
  `fk_user` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_product_fournisseur_price_fk_user` (`fk_user`),
  KEY `idx_product_fournisseur_price_fk_product_fournisseur` (`fk_product_fournisseur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_product_fournisseur_price_log`
--

CREATE TABLE IF NOT EXISTS `llx_product_fournisseur_price_log` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `datec` datetime DEFAULT NULL,
  `fk_product_fournisseur` int(11) NOT NULL,
  `price` double(24,8) DEFAULT '0.00000000',
  `quantity` double DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_product_lang`
--

CREATE TABLE IF NOT EXISTS `llx_product_lang` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_product` int(11) NOT NULL DEFAULT '0',
  `lang` varchar(5) NOT NULL DEFAULT '0',
  `label` varchar(255) NOT NULL,
  `description` text,
  `note` text,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_product_lang` (`fk_product`,`lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_product_price`
--

CREATE TABLE IF NOT EXISTS `llx_product_price` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_product` int(11) NOT NULL,
  `date_price` datetime NOT NULL,
  `price_level` smallint(6) DEFAULT '1',
  `price` double(24,8) DEFAULT NULL,
  `price_ttc` double(24,8) DEFAULT NULL,
  `price_min` double(24,8) DEFAULT NULL,
  `price_min_ttc` double(24,8) DEFAULT NULL,
  `price_base_type` varchar(3) DEFAULT 'HT',
  `tva_tx` double(6,3) NOT NULL,
  `recuperableonly` int(11) NOT NULL DEFAULT '0',
  `localtax1_tx` double(6,3) DEFAULT '0.000',
  `localtax2_tx` double(6,3) DEFAULT '0.000',
  `fk_user_author` int(11) DEFAULT NULL,
  `tosell` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- Extraindo dados da tabela `llx_product_price`
--

INSERT INTO `llx_product_price` (`rowid`, `tms`, `fk_product`, `date_price`, `price_level`, `price`, `price_ttc`, `price_min`, `price_min_ttc`, `price_base_type`, `tva_tx`, `recuperableonly`, `localtax1_tx`, `localtax2_tx`, `fk_user_author`, `tosell`) VALUES
(1, '2012-02-09 23:27:38', 1, '2012-02-09 21:27:38', 1, 84.74576000, 100.00000000, 63.55932000, 75.00000000, 'TTC', 18.000, 0, 0.000, 0.000, 1, 1),
(2, '2012-02-09 23:35:57', 2, '2012-02-09 21:35:57', 1, 70.00000000, 70.00000000, 60.00000000, 60.00000000, 'TTC', 0.000, 0, 0.000, 0.000, 1, 1),
(6, '2012-02-09 23:44:45', 3, '2012-02-09 21:44:45', 2, 120.00000000, 120.00000000, 100.00000000, 100.00000000, 'HT', 0.000, 0, 0.000, 0.000, 1, 1),
(7, '2012-02-09 23:46:16', 4, '2012-02-09 21:46:16', 1, 0.00000000, 0.00000000, 0.00000000, 0.00000000, '', 0.000, 0, 0.000, 0.000, 1, 1),
(8, '2012-02-09 23:46:31', 4, '2012-02-09 21:46:31', 1, 100.00000000, 100.00000000, 100.00000000, 100.00000000, 'HT', 0.000, 0, 0.000, 0.000, 1, 1),
(9, '2012-02-12 11:01:47', 1, '2012-02-12 09:01:47', 1, 100.00000000, 100.00000000, 75.00000000, 75.00000000, 'TTC', 0.000, 0, 0.000, 0.000, 1, 1),
(10, '2012-02-12 11:02:26', 3, '2012-02-12 09:02:26', 1, 120.00000000, 120.00000000, 100.00000000, 100.00000000, 'HT', 0.000, 0, 0.000, 0.000, 1, 1),
(11, '2012-02-12 11:02:35', 3, '2012-02-12 09:02:35', 2, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 'HT', 0.000, 0, 0.000, 0.000, 1, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_product_stock`
--

CREATE TABLE IF NOT EXISTS `llx_product_stock` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_product` int(11) NOT NULL,
  `fk_entrepot` int(11) NOT NULL,
  `reel` double DEFAULT NULL,
  `pmp` double(24,8) NOT NULL DEFAULT '0.00000000',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_product_stock` (`fk_product`,`fk_entrepot`),
  KEY `idx_product_stock_fk_product` (`fk_product`),
  KEY `idx_product_stock_fk_entrepot` (`fk_entrepot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_projet`
--

CREATE TABLE IF NOT EXISTS `llx_projet` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_soc` int(11) DEFAULT NULL,
  `datec` date DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `dateo` date DEFAULT NULL,
  `datee` date DEFAULT NULL,
  `ref` varchar(50) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `title` varchar(255) NOT NULL,
  `description` text,
  `fk_user_creat` int(11) NOT NULL,
  `public` int(11) DEFAULT NULL,
  `fk_statut` smallint(6) NOT NULL DEFAULT '0',
  `note_private` text,
  `note_public` text,
  `model_pdf` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_projet_ref` (`ref`,`entity`),
  KEY `idx_projet_fk_soc` (`fk_soc`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Extraindo dados da tabela `llx_projet`
--

INSERT INTO `llx_projet` (`rowid`, `fk_soc`, `datec`, `tms`, `dateo`, `datee`, `ref`, `entity`, `title`, `description`, `fk_user_creat`, `public`, `fk_statut`, `note_private`, `note_public`, `model_pdf`) VALUES
(1, NULL, '2012-02-09', '2012-02-09 22:45:04', '2012-02-09', '2012-04-20', 'PJ1202-0001', 1, 'Projeto 1', 'Teste', 1, 0, 1, NULL, NULL, 'baleine');

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_projet_task`
--

CREATE TABLE IF NOT EXISTS `llx_projet_task` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_projet` int(11) NOT NULL,
  `fk_task_parent` int(11) NOT NULL DEFAULT '0',
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `dateo` datetime DEFAULT NULL,
  `datee` datetime DEFAULT NULL,
  `datev` datetime DEFAULT NULL,
  `label` varchar(255) NOT NULL,
  `description` text,
  `duration_effective` double NOT NULL DEFAULT '0',
  `progress` int(11) DEFAULT '0',
  `priority` int(11) DEFAULT '0',
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_statut` smallint(6) NOT NULL DEFAULT '0',
  `note_private` text,
  `note_public` text,
  `rang` int(11) DEFAULT '0',
  PRIMARY KEY (`rowid`),
  KEY `idx_projet_task_fk_projet` (`fk_projet`),
  KEY `idx_projet_task_fk_user_creat` (`fk_user_creat`),
  KEY `idx_projet_task_fk_user_valid` (`fk_user_valid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_projet_task_time`
--

CREATE TABLE IF NOT EXISTS `llx_projet_task_time` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_task` int(11) NOT NULL,
  `task_date` date DEFAULT NULL,
  `task_duration` double DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `note` text,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_propal`
--

CREATE TABLE IF NOT EXISTS `llx_propal` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(30) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref_ext` varchar(50) DEFAULT NULL,
  `ref_int` varchar(50) DEFAULT NULL,
  `ref_client` varchar(50) DEFAULT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `fk_projet` int(11) DEFAULT '0',
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datec` datetime DEFAULT NULL,
  `datep` date DEFAULT NULL,
  `fin_validite` datetime DEFAULT NULL,
  `date_valid` datetime DEFAULT NULL,
  `date_cloture` datetime DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_user_cloture` int(11) DEFAULT NULL,
  `fk_statut` smallint(6) NOT NULL DEFAULT '0',
  `price` double DEFAULT '0',
  `remise_percent` double DEFAULT '0',
  `remise_absolue` double DEFAULT '0',
  `remise` double DEFAULT '0',
  `total_ht` double(24,8) DEFAULT '0.00000000',
  `tva` double(24,8) DEFAULT '0.00000000',
  `localtax1` double(24,8) DEFAULT '0.00000000',
  `localtax2` double(24,8) DEFAULT '0.00000000',
  `total` double(24,8) DEFAULT '0.00000000',
  `fk_cond_reglement` int(11) DEFAULT NULL,
  `fk_mode_reglement` int(11) DEFAULT NULL,
  `note` text,
  `note_public` text,
  `model_pdf` varchar(255) DEFAULT NULL,
  `date_livraison` date DEFAULT NULL,
  `fk_availability` int(11) DEFAULT NULL,
  `fk_demand_reason` int(11) DEFAULT NULL,
  `fk_adresse_livraison` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_propal_ref` (`ref`,`entity`),
  KEY `idx_propal_fk_soc` (`fk_soc`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Extraindo dados da tabela `llx_propal`
--

INSERT INTO `llx_propal` (`rowid`, `ref`, `entity`, `ref_ext`, `ref_int`, `ref_client`, `fk_soc`, `fk_projet`, `tms`, `datec`, `datep`, `fin_validite`, `date_valid`, `date_cloture`, `fk_user_author`, `fk_user_valid`, `fk_user_cloture`, `fk_statut`, `price`, `remise_percent`, `remise_absolue`, `remise`, `total_ht`, `tva`, `localtax1`, `localtax2`, `total`, `fk_cond_reglement`, `fk_mode_reglement`, `note`, `note_public`, `model_pdf`, `date_livraison`, `fk_availability`, `fk_demand_reason`, `fk_adresse_livraison`) VALUES
(1, '000001-2012-02-09-001', 1, NULL, NULL, 'tes', 1, 0, '2012-02-12 11:12:47', '2012-02-09 21:25:02', '2012-02-09', '2012-02-24 12:00:00', '2012-02-12 09:03:47', NULL, 1, 1, NULL, 0, 0, NULL, NULL, 0, 100.00000000, 0.00000000, 0.00000000, 0.00000000, 100.00000000, 2, 7, '', '', 'azur', '2012-02-10', 0, 1, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_propaldet`
--

CREATE TABLE IF NOT EXISTS `llx_propaldet` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_propal` int(11) NOT NULL,
  `fk_parent_line` int(11) DEFAULT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `description` text,
  `fk_remise_except` int(11) DEFAULT NULL,
  `tva_tx` double(6,3) DEFAULT '0.000',
  `localtax1_tx` double(6,3) DEFAULT '0.000',
  `localtax2_tx` double(6,3) DEFAULT '0.000',
  `qty` double DEFAULT NULL,
  `remise_percent` double DEFAULT '0',
  `remise` double DEFAULT '0',
  `price` double DEFAULT NULL,
  `subprice` double(24,8) DEFAULT '0.00000000',
  `total_ht` double(24,8) DEFAULT '0.00000000',
  `total_tva` double(24,8) DEFAULT '0.00000000',
  `total_localtax1` double(24,8) DEFAULT '0.00000000',
  `total_localtax2` double(24,8) DEFAULT '0.00000000',
  `total_ttc` double(24,8) DEFAULT '0.00000000',
  `product_type` int(11) DEFAULT '0',
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `info_bits` int(11) DEFAULT '0',
  `pa_ht` double(24,8) DEFAULT '0.00000000',
  `marge_tx` double(6,3) DEFAULT '0.000',
  `marque_tx` double(6,3) DEFAULT '0.000',
  `special_code` int(11) DEFAULT '0',
  `rang` int(11) DEFAULT '0',
  PRIMARY KEY (`rowid`),
  KEY `idx_propaldet_fk_propal` (`fk_propal`),
  KEY `idx_propaldet_fk_product` (`fk_product`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Extraindo dados da tabela `llx_propaldet`
--

INSERT INTO `llx_propaldet` (`rowid`, `fk_propal`, `fk_parent_line`, `fk_product`, `description`, `fk_remise_except`, `tva_tx`, `localtax1_tx`, `localtax2_tx`, `qty`, `remise_percent`, `remise`, `price`, `subprice`, `total_ht`, `total_tva`, `total_localtax1`, `total_localtax2`, `total_ttc`, `product_type`, `date_start`, `date_end`, `info_bits`, `pa_ht`, `marge_tx`, `marque_tx`, `special_code`, `rang`) VALUES
(7, 1, NULL, 1, 'instala&ccedil;&atilde;o de pia de marmore at&eacute; 40 cm', NULL, 0.000, 0.000, 0.000, 1, 0, 0, NULL, 100.00000000, 100.00000000, 0.00000000, 0.00000000, 0.00000000, 100.00000000, 1, NULL, NULL, 0, 0.00000000, NULL, NULL, 0, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_rights_def`
--

CREATE TABLE IF NOT EXISTS `llx_rights_def` (
  `id` int(11) NOT NULL DEFAULT '0',
  `libelle` varchar(255) DEFAULT NULL,
  `module` varchar(64) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `perms` varchar(50) DEFAULT NULL,
  `subperms` varchar(50) DEFAULT NULL,
  `type` varchar(1) DEFAULT NULL,
  `bydefault` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `llx_rights_def`
--

INSERT INTO `llx_rights_def` (`id`, `libelle`, `module`, `entity`, `perms`, `subperms`, `type`, `bydefault`) VALUES
(11, 'Lire les factures', 'facture', 1, 'lire', NULL, 'a', 1),
(12, 'Creer/modifier les factures', 'facture', 1, 'creer', NULL, 'a', 0),
(13, 'Dévalider les factures', 'facture', 1, 'invoice_advance', 'unvalidate', 'a', 0),
(14, 'Valider les factures', 'facture', 1, 'valider', NULL, 'a', 0),
(15, 'Envoyer les factures par mail', 'facture', 1, 'invoice_advance', 'send', 'a', 0),
(16, 'Emettre des paiements sur les factures', 'facture', 1, 'paiement', NULL, 'a', 0),
(19, 'Supprimer les factures', 'facture', 1, 'supprimer', NULL, 'a', 0),
(21, 'Lire les propositions commerciales', 'propale', 1, 'lire', NULL, 'r', 1),
(22, 'Creer/modifier les propositions commerciales', 'propale', 1, 'creer', NULL, 'w', 0),
(24, 'Valider les propositions commerciales', 'propale', 1, 'valider', NULL, 'd', 0),
(25, 'Envoyer les propositions commerciales aux clients', 'propale', 1, 'propal_advance', 'send', 'd', 0),
(26, 'Cloturer les propositions commerciales', 'propale', 1, 'cloturer', NULL, 'd', 0),
(27, 'Supprimer les propositions commerciales', 'propale', 1, 'supprimer', NULL, 'd', 0),
(28, 'Exporter les propositions commerciales et attributs', 'propale', 1, 'export', NULL, 'r', 0),
(31, 'Lire les produits', 'produit', 1, 'lire', NULL, 'r', 1),
(32, 'Creer/modifier les produits', 'produit', 1, 'creer', NULL, 'w', 0),
(34, 'Supprimer les produits', 'produit', 1, 'supprimer', NULL, 'd', 0),
(38, 'Exporter les produits', 'produit', 1, 'export', NULL, 'r', 0),
(41, 'Lire les projets et taches (partagés ou dont je suis contact)', 'projet', 1, 'lire', NULL, 'r', 1),
(42, 'Creer/modifier les projets et taches (partagés ou dont je suis contact)', 'projet', 1, 'creer', NULL, 'w', 0),
(44, 'Supprimer les projets et taches (partagés ou dont je suis contact)', 'projet', 1, 'supprimer', NULL, 'd', 0),
(71, 'Read members'' card', 'adherent', 1, 'lire', NULL, 'r', 1),
(72, 'Create/modify members (need also user module permissions if member linked to a user)', 'adherent', 1, 'creer', NULL, 'w', 0),
(74, 'Remove members', 'adherent', 1, 'supprimer', NULL, 'd', 0),
(75, 'Setup types and attributes of members', 'adherent', 1, 'configurer', NULL, 'w', 0),
(76, 'Export members', 'adherent', 1, 'export', NULL, 'r', 0),
(78, 'Read subscriptions', 'adherent', 1, 'cotisation', 'lire', 'r', 1),
(79, 'Create/modify/remove subscriptions', 'adherent', 1, 'cotisation', 'creer', 'w', 0),
(81, 'Lire les commandes clients', 'commande', 1, 'lire', NULL, 'r', 1),
(82, 'Creer/modifier les commandes clients', 'commande', 1, 'creer', NULL, 'w', 0),
(84, 'Valider les commandes clients', 'commande', 1, 'valider', NULL, 'd', 0),
(86, 'Envoyer les commandes clients', 'commande', 1, 'order_advance', 'send', 'd', 0),
(87, 'Cloturer les commandes clients', 'commande', 1, 'cloturer', NULL, 'd', 0),
(88, 'Annuler les commandes clients', 'commande', 1, 'annuler', NULL, 'd', 0),
(89, 'Supprimer les commandes clients', 'commande', 1, 'supprimer', NULL, 'd', 0),
(91, 'Lire les charges', 'tax', 1, 'charges', 'lire', 'r', 1),
(92, 'Creer/modifier les charges', 'tax', 1, 'charges', 'creer', 'w', 0),
(93, 'Supprimer les charges', 'tax', 1, 'charges', 'supprimer', 'd', 0),
(94, 'Exporter les charges', 'tax', 1, 'charges', 'export', 'r', 0),
(95, 'Lire CA, bilans, resultats', 'compta', 1, 'resultat', 'lire', 'r', 1),
(96, 'Parametrer la ventilation', 'compta', 1, 'ventilation', 'parametrer', 'r', 0),
(97, 'Lire les ventilations de factures', 'compta', 1, 'ventilation', 'lire', 'r', 1),
(98, 'Ventiler les lignes de factures', 'compta', 1, 'ventilation', 'creer', 'r', 0),
(101, 'Lire les expeditions', 'expedition', 1, 'lire', NULL, 'r', 1),
(102, 'Creer modifier les expeditions', 'expedition', 1, 'creer', NULL, 'w', 0),
(104, 'Valider les expeditions', 'expedition', 1, 'valider', NULL, 'd', 0),
(105, 'Envoyer les expeditions aux clients', 'expedition', 1, 'shipping_advance', 'send', 'd', 0),
(109, 'Supprimer les expeditions', 'expedition', 1, 'supprimer', NULL, 'd', 0),
(111, 'Lire les comptes bancaires', 'banque', 1, 'lire', NULL, 'r', 1),
(112, 'Creer/modifier montant/supprimer ecriture bancaire', 'banque', 1, 'modifier', NULL, 'w', 0),
(113, 'Configurer les comptes bancaires (creer, gerer categories)', 'banque', 1, 'configurer', NULL, 'a', 0),
(114, 'Rapprocher les ecritures bancaires', 'banque', 1, 'consolidate', NULL, 'w', 0),
(115, 'Exporter transactions et releves', 'banque', 1, 'export', NULL, 'r', 0),
(116, 'Virements entre comptes', 'banque', 1, 'transfer', NULL, 'w', 0),
(117, 'Gerer les envois de cheques', 'banque', 1, 'cheque', NULL, 'w', 0),
(121, 'Lire les societes', 'societe', 1, 'lire', NULL, 'r', 1),
(122, 'Creer modifier les societes', 'societe', 1, 'creer', NULL, 'w', 0),
(125, 'Supprimer les societes', 'societe', 1, 'supprimer', NULL, 'd', 0),
(126, 'Exporter les societes', 'societe', 1, 'export', NULL, 'r', 0),
(141, 'Lire tous les projets et taches (y compris prives qui ne me sont pas affectes)', 'projet', 1, 'all', 'lire', 'r', 0),
(142, 'Creer/modifier tous les projets et taches (y compris prives qui ne me sont pas affectes)', 'projet', 1, 'all', 'creer', 'w', 0),
(144, 'Supprimer tous les projets et taches (y compris prives qui ne me sont pas affectes)', 'projet', 1, 'all', 'supprimer', 'd', 0),
(151, 'Read withdrawals', 'prelevement', 1, 'bons', 'lire', 'r', 1),
(152, 'Create/modify a withdrawals', 'prelevement', 1, 'bons', 'creer', 'w', 0),
(153, 'Send withdrawals to bank', 'prelevement', 1, 'bons', 'send', 'a', 0),
(154, 'credit/refuse withdrawals', 'prelevement', 1, 'bons', 'credit', 'a', 0),
(161, 'Lire les contrats', 'contrat', 1, 'lire', NULL, 'r', 1),
(162, 'Creer / modifier les contrats', 'contrat', 1, 'creer', NULL, 'w', 0),
(163, 'Activer un service d''un contrat', 'contrat', 1, 'activer', NULL, 'w', 0),
(164, 'Desactiver un service d''un contrat', 'contrat', 1, 'desactiver', NULL, 'w', 0),
(165, 'Supprimer un contrat', 'contrat', 1, 'supprimer', NULL, 'd', 0),
(171, 'Lire les deplacements', 'deplacement', 1, 'lire', NULL, 'r', 1),
(172, 'Creer/modifier les deplacements', 'deplacement', 1, 'creer', NULL, 'w', 0),
(173, 'Supprimer les deplacements', 'deplacement', 1, 'supprimer', NULL, 'd', 0),
(178, 'Exporter les deplacements', 'deplacement', 1, 'export', NULL, 'd', 0),
(241, 'Lire les categories', 'categorie', 1, 'lire', NULL, 'r', 1),
(242, 'Creer/modifier les categories', 'categorie', 1, 'creer', NULL, 'w', 0),
(243, 'Supprimer les categories', 'categorie', 1, 'supprimer', NULL, 'd', 0),
(251, 'Consulter les autres utilisateurs', 'user', 1, 'user', 'lire', 'r', 0),
(252, 'Consulter les permissions des autres utilisateurs', 'user', 1, 'user_advance', 'readperms', 'r', 0),
(253, 'Creer/modifier utilisateurs internes et externes', 'user', 1, 'user', 'creer', 'w', 0),
(254, 'Creer/modifier utilisateurs externes seulement', 'user', 1, 'user_advance', 'write', 'w', 0),
(255, 'Modifier le mot de passe des autres utilisateurs', 'user', 1, 'user', 'password', 'w', 0),
(256, 'Supprimer ou desactiver les autres utilisateurs', 'user', 1, 'user', 'supprimer', 'd', 0),
(262, 'Consulter tous les tiers par utilisateurs internes (sinon uniquement si contact commercial). Non effectif pour utilisateurs externes (tjs limités à eux-meme).', 'societe', 1, 'client', 'voir', 'r', 1),
(281, 'Lire les contacts', 'societe', 1, 'contact', 'lire', 'r', 1),
(282, 'Creer modifier les contacts', 'societe', 1, 'contact', 'creer', 'w', 0),
(283, 'Supprimer les contacts', 'societe', 1, 'contact', 'supprimer', 'd', 0),
(286, 'Exporter les contacts', 'societe', 1, 'contact', 'export', 'd', 0),
(341, 'Consulter ses propres permissions', 'user', 1, 'self_advance', 'readperms', 'r', 1),
(342, 'Creer/modifier ses propres infos utilisateur', 'user', 1, 'self', 'creer', 'w', 1),
(343, 'Modifier son propre mot de passe', 'user', 1, 'self', 'password', 'w', 1),
(344, 'Modifier ses propres permissions', 'user', 1, 'self_advance', 'writeperms', 'w', 1),
(351, 'Consulter les groupes', 'user', 1, 'group_advance', 'read', 'r', 0),
(352, 'Consulter les permissions des groupes', 'user', 1, 'group_advance', 'readperms', 'r', 0),
(353, 'Creer/modifier les groupes et leurs permissions', 'user', 1, 'group_advance', 'write', 'w', 0),
(354, 'Supprimer ou desactiver les groupes', 'user', 1, 'group_advance', 'delete', 'd', 0),
(358, 'Exporter les utilisateurs', 'user', 1, 'user', 'export', 'r', 0),
(531, 'Lire les services', 'service', 1, 'lire', NULL, 'r', 1),
(532, 'Creer/modifier les services', 'service', 1, 'creer', NULL, 'w', 0),
(534, 'Supprimer les services', 'service', 1, 'supprimer', NULL, 'd', 0),
(538, 'Exporter les services', 'service', 1, 'export', NULL, 'r', 0),
(1101, 'Lire les bons de livraison', 'expedition', 1, 'livraison', 'lire', 'r', 1),
(1102, 'Creer modifier les bons de livraison', 'expedition', 1, 'livraison', 'creer', 'w', 0),
(1104, 'Valider les bons de livraison', 'expedition', 1, 'livraison', 'valider', 'd', 0),
(1109, 'Supprimer les bons de livraison', 'expedition', 1, 'livraison', 'supprimer', 'd', 0),
(1181, 'Consulter les fournisseurs', 'fournisseur', 1, 'lire', NULL, 'r', 1),
(1182, 'Consulter les commandes fournisseur', 'fournisseur', 1, 'commande', 'lire', 'r', 1),
(1183, 'Creer une commande fournisseur', 'fournisseur', 1, 'commande', 'creer', 'w', 0),
(1184, 'Valider une commande fournisseur', 'fournisseur', 1, 'commande', 'valider', 'w', 0),
(1185, 'Approuver une commande fournisseur', 'fournisseur', 1, 'commande', 'approuver', 'w', 0),
(1186, 'Commander une commande fournisseur', 'fournisseur', 1, 'commande', 'commander', 'w', 0),
(1187, 'Receptionner une commande fournisseur', 'fournisseur', 1, 'commande', 'receptionner', 'd', 0),
(1188, 'Supprimer une commande fournisseur', 'fournisseur', 1, 'commande', 'supprimer', 'd', 0),
(1231, 'Consulter les factures fournisseur', 'fournisseur', 1, 'facture', 'lire', 'r', 1),
(1232, 'Creer une facture fournisseur', 'fournisseur', 1, 'facture', 'creer', 'w', 0),
(1233, 'Valider une facture fournisseur', 'fournisseur', 1, 'facture', 'valider', 'w', 0),
(1234, 'Supprimer une facture fournisseur', 'fournisseur', 1, 'facture', 'supprimer', 'd', 0),
(1235, 'Envoyer les factures par mail', 'fournisseur', 1, 'supplier_invoice_advance', 'send', 'a', 0),
(1236, 'Exporter les factures fournisseurs, attributs et reglements', 'fournisseur', 1, 'facture', 'export', 'r', 0),
(1321, 'Exporter les factures clients, attributs et reglements', 'facture', 1, 'facture', 'export', 'r', 0),
(1421, 'Exporter les commandes clients et attributs', 'commande', 1, 'commande', 'export', 'r', 0),
(2401, 'Read actions/tasks linked to his account', 'agenda', 1, 'myactions', 'read', 'r', 1),
(2402, 'Create/modify actions/tasks linked to his account', 'agenda', 1, 'myactions', 'create', 'w', 0),
(2403, 'Delete actions/tasks linked to his account', 'agenda', 1, 'myactions', 'delete', 'w', 0),
(2411, 'Read actions/tasks of others', 'agenda', 1, 'allactions', 'read', 'r', 0),
(2412, 'Create/modify actions/tasks of others', 'agenda', 1, 'allactions', 'create', 'w', 0),
(2413, 'Delete actions/tasks of others', 'agenda', 1, 'allactions', 'delete', 'w', 0),
(50101, 'Use point of sale', 'cashdesk', 1, 'use', NULL, 'a', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_societe`
--

CREATE TABLE IF NOT EXISTS `llx_societe` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(60) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref_ext` varchar(60) DEFAULT NULL,
  `ref_int` varchar(60) DEFAULT NULL,
  `statut` tinyint(4) DEFAULT '0',
  `parent` int(11) DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datec` datetime DEFAULT NULL,
  `datea` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `code_client` varchar(15) DEFAULT NULL,
  `code_fournisseur` varchar(15) DEFAULT NULL,
  `code_compta` varchar(15) DEFAULT NULL,
  `code_compta_fournisseur` varchar(15) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `cp` varchar(10) DEFAULT NULL,
  `ville` varchar(50) DEFAULT NULL,
  `fk_departement` int(11) DEFAULT '0',
  `fk_pays` int(11) DEFAULT '0',
  `tel` varchar(20) DEFAULT NULL,
  `fax` varchar(20) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `fk_secteur` int(11) DEFAULT '0',
  `fk_effectif` int(11) DEFAULT '0',
  `fk_typent` int(11) DEFAULT '0',
  `fk_forme_juridique` int(11) DEFAULT '0',
  `fk_currency` int(11) DEFAULT '0',
  `siren` varchar(32) DEFAULT NULL,
  `siret` varchar(32) DEFAULT NULL,
  `ape` varchar(32) DEFAULT NULL,
  `idprof4` varchar(32) DEFAULT NULL,
  `tva_intra` varchar(20) DEFAULT NULL,
  `capital` double DEFAULT NULL,
  `description` text,
  `fk_stcomm` smallint(6) DEFAULT '0',
  `note` text,
  `services` tinyint(4) DEFAULT '0',
  `prefix_comm` varchar(5) DEFAULT NULL,
  `client` tinyint(4) DEFAULT '0',
  `fournisseur` tinyint(4) DEFAULT '0',
  `supplier_account` varchar(32) DEFAULT NULL,
  `fk_prospectlevel` varchar(12) DEFAULT NULL,
  `customer_bad` tinyint(4) DEFAULT '0',
  `customer_rate` double DEFAULT '0',
  `supplier_rate` double DEFAULT '0',
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `remise_client` double DEFAULT '0',
  `mode_reglement` tinyint(4) DEFAULT NULL,
  `cond_reglement` tinyint(4) DEFAULT NULL,
  `tva_assuj` tinyint(4) DEFAULT '1',
  `localtax1_assuj` tinyint(4) DEFAULT '0',
  `localtax2_assuj` tinyint(4) DEFAULT '0',
  `gencod` varchar(255) DEFAULT NULL,
  `price_level` int(11) DEFAULT NULL,
  `default_lang` varchar(6) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `canvas` varchar(32) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_societe_prefix_comm` (`prefix_comm`,`entity`),
  UNIQUE KEY `uk_societe_code_client` (`code_client`,`entity`),
  KEY `idx_societe_user_creat` (`fk_user_creat`),
  KEY `idx_societe_user_modif` (`fk_user_modif`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Extraindo dados da tabela `llx_societe`
--

INSERT INTO `llx_societe` (`rowid`, `nom`, `entity`, `ref_ext`, `ref_int`, `statut`, `parent`, `tms`, `datec`, `datea`, `status`, `code_client`, `code_fournisseur`, `code_compta`, `code_compta_fournisseur`, `address`, `cp`, `ville`, `fk_departement`, `fk_pays`, `tel`, `fax`, `url`, `email`, `fk_secteur`, `fk_effectif`, `fk_typent`, `fk_forme_juridique`, `fk_currency`, `siren`, `siret`, `ape`, `idprof4`, `tva_intra`, `capital`, `description`, `fk_stcomm`, `note`, `services`, `prefix_comm`, `client`, `fournisseur`, `supplier_account`, `fk_prospectlevel`, `customer_bad`, `customer_rate`, `supplier_rate`, `fk_user_creat`, `fk_user_modif`, `remise_client`, `mode_reglement`, `cond_reglement`, `tva_assuj`, `localtax1_assuj`, `localtax2_assuj`, `gencod`, `price_level`, `default_lang`, `logo`, `canvas`, `import_key`) VALUES
(1, 'TESTE TESTE (TESTE)', 1, NULL, NULL, 0, NULL, '2012-02-09 23:54:02', '2012-02-09 21:05:18', '2012-02-09 21:54:02', 1, '000001', NULL, NULL, NULL, 'TESTE', NULL, NULL, 0, 25, '3192536515', NULL, NULL, 'rafsopd@gmail.com', 0, NULL, 0, NULL, 0, '', '', '', '', '', 0, NULL, 0, NULL, 0, NULL, 1, 0, NULL, NULL, 0, 0, 0, 1, 1, 0, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_societe_address`
--

CREATE TABLE IF NOT EXISTS `llx_societe_address` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `label` varchar(30) DEFAULT NULL,
  `fk_soc` int(11) DEFAULT '0',
  `name` varchar(60) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `cp` varchar(10) DEFAULT NULL,
  `ville` varchar(50) DEFAULT NULL,
  `fk_pays` int(11) DEFAULT '0',
  `tel` varchar(20) DEFAULT NULL,
  `fax` varchar(20) DEFAULT NULL,
  `note` text,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_societe_commerciaux`
--

CREATE TABLE IF NOT EXISTS `llx_societe_commerciaux` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_soc` int(11) DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_societe_commerciaux` (`fk_soc`,`fk_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_societe_extrafields`
--

CREATE TABLE IF NOT EXISTS `llx_societe_extrafields` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_object` int(11) NOT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_societe_extrafields` (`fk_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_societe_log`
--

CREATE TABLE IF NOT EXISTS `llx_societe_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datel` datetime DEFAULT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `fk_statut` int(11) DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `author` varchar(30) DEFAULT NULL,
  `label` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_societe_prices`
--

CREATE TABLE IF NOT EXISTS `llx_societe_prices` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_soc` int(11) DEFAULT '0',
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datec` datetime DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `price_level` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_societe_remise`
--

CREATE TABLE IF NOT EXISTS `llx_societe_remise` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_soc` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datec` datetime DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `remise_client` double(6,3) NOT NULL DEFAULT '0.000',
  `note` text,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_societe_remise_except`
--

CREATE TABLE IF NOT EXISTS `llx_societe_remise_except` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_soc` int(11) NOT NULL,
  `datec` datetime DEFAULT NULL,
  `amount_ht` double(24,8) NOT NULL,
  `amount_tva` double(24,8) NOT NULL DEFAULT '0.00000000',
  `amount_ttc` double(24,8) NOT NULL DEFAULT '0.00000000',
  `tva_tx` double(6,3) NOT NULL DEFAULT '0.000',
  `fk_user` int(11) NOT NULL,
  `fk_facture_line` int(11) DEFAULT NULL,
  `fk_facture` int(11) DEFAULT NULL,
  `fk_facture_source` int(11) DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_societe_remise_except_fk_user` (`fk_user`),
  KEY `idx_societe_remise_except_fk_soc` (`fk_soc`),
  KEY `idx_societe_remise_except_fk_facture_line` (`fk_facture_line`),
  KEY `idx_societe_remise_except_fk_facture` (`fk_facture`),
  KEY `idx_societe_remise_except_fk_facture_source` (`fk_facture_source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_societe_rib`
--

CREATE TABLE IF NOT EXISTS `llx_societe_rib` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_soc` int(11) NOT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `label` varchar(30) DEFAULT NULL,
  `bank` varchar(255) DEFAULT NULL,
  `code_banque` varchar(7) DEFAULT NULL,
  `code_guichet` varchar(6) DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL,
  `cle_rib` varchar(5) DEFAULT NULL,
  `bic` varchar(10) DEFAULT NULL,
  `iban_prefix` varchar(34) DEFAULT NULL,
  `domiciliation` varchar(255) DEFAULT NULL,
  `proprio` varchar(60) DEFAULT NULL,
  `adresse_proprio` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_socpeople`
--

CREATE TABLE IF NOT EXISTS `llx_socpeople` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_soc` int(11) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `civilite` varchar(6) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `cp` varchar(25) DEFAULT NULL,
  `ville` varchar(255) DEFAULT NULL,
  `fk_departement` int(11) DEFAULT NULL,
  `fk_pays` int(11) DEFAULT '0',
  `birthday` date DEFAULT NULL,
  `poste` varchar(80) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `phone_perso` varchar(30) DEFAULT NULL,
  `phone_mobile` varchar(30) DEFAULT NULL,
  `fax` varchar(30) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `jabberid` varchar(255) DEFAULT NULL,
  `priv` smallint(6) NOT NULL DEFAULT '0',
  `fk_user_creat` int(11) DEFAULT '0',
  `fk_user_modif` int(11) DEFAULT NULL,
  `note` text,
  `default_lang` varchar(6) DEFAULT NULL,
  `canvas` varchar(32) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_socpeople_fk_soc` (`fk_soc`),
  KEY `idx_socpeople_fk_user_creat` (`fk_user_creat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_stock_mouvement`
--

CREATE TABLE IF NOT EXISTS `llx_stock_mouvement` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datem` datetime DEFAULT NULL,
  `fk_product` int(11) NOT NULL,
  `fk_entrepot` int(11) NOT NULL,
  `value` int(11) DEFAULT NULL,
  `price` float(13,4) DEFAULT '0.0000',
  `type_mouvement` smallint(6) DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `label` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  KEY `idx_stock_mouvement_fk_product` (`fk_product`),
  KEY `idx_stock_mouvement_fk_entrepot` (`fk_entrepot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_texts`
--

CREATE TABLE IF NOT EXISTS `llx_texts` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `module` varchar(32) DEFAULT NULL,
  `typemodele` varchar(32) DEFAULT NULL,
  `sortorder` smallint(6) DEFAULT NULL,
  `private` smallint(6) NOT NULL DEFAULT '0',
  `fk_user` int(11) DEFAULT NULL,
  `title` varchar(128) DEFAULT NULL,
  `filename` varchar(128) DEFAULT NULL,
  `content` text,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_tva`
--

CREATE TABLE IF NOT EXISTS `llx_tva` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datep` date DEFAULT NULL,
  `datev` date DEFAULT NULL,
  `amount` double NOT NULL DEFAULT '0',
  `label` varchar(255) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `note` text,
  `fk_bank` int(11) DEFAULT NULL,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_user`
--

CREATE TABLE IF NOT EXISTS `llx_user` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `ref_ext` varchar(30) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `login` varchar(24) NOT NULL,
  `pass` varchar(32) DEFAULT NULL,
  `pass_crypted` varchar(128) DEFAULT NULL,
  `pass_temp` varchar(32) DEFAULT NULL,
  `civilite` varchar(6) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `office_phone` varchar(20) DEFAULT NULL,
  `office_fax` varchar(20) DEFAULT NULL,
  `user_mobile` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `signature` text,
  `admin` smallint(6) DEFAULT '0',
  `webcal_login` varchar(25) DEFAULT NULL,
  `phenix_login` varchar(25) DEFAULT NULL,
  `phenix_pass` varchar(128) DEFAULT NULL,
  `module_comm` smallint(6) DEFAULT '1',
  `module_compta` smallint(6) DEFAULT '1',
  `fk_societe` int(11) DEFAULT NULL,
  `fk_socpeople` int(11) DEFAULT NULL,
  `fk_member` int(11) DEFAULT NULL,
  `note` text,
  `datelastlogin` datetime DEFAULT NULL,
  `datepreviouslogin` datetime DEFAULT NULL,
  `egroupware_id` int(11) DEFAULT NULL,
  `ldap_sid` varchar(255) DEFAULT NULL,
  `openid` varchar(255) DEFAULT NULL,
  `statut` tinyint(4) DEFAULT '1',
  `photo` varchar(255) DEFAULT NULL,
  `lang` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_user_login` (`login`,`entity`),
  UNIQUE KEY `uk_user_fk_socpeople` (`fk_socpeople`),
  UNIQUE KEY `uk_user_fk_member` (`fk_member`),
  KEY `uk_user_fk_societe` (`fk_societe`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Extraindo dados da tabela `llx_user`
--

INSERT INTO `llx_user` (`rowid`, `entity`, `ref_ext`, `datec`, `tms`, `login`, `pass`, `pass_crypted`, `pass_temp`, `civilite`, `name`, `firstname`, `office_phone`, `office_fax`, `user_mobile`, `email`, `signature`, `admin`, `webcal_login`, `phenix_login`, `phenix_pass`, `module_comm`, `module_compta`, `fk_societe`, `fk_socpeople`, `fk_member`, `note`, `datelastlogin`, `datepreviouslogin`, `egroupware_id`, `ldap_sid`, `openid`, `statut`, `photo`, `lang`) VALUES
(1, 0, NULL, '2012-02-09 19:35:17', '2012-02-09 21:50:45', 'rafso', NULL, '8970e489ab3a72a9e4e3023fd6db8949', NULL, NULL, 'SuperAdmin', '', '', '', '', '', '', 1, '', '', '', 1, 1, NULL, NULL, NULL, '', '2012-02-13 00:04:25', '2012-02-12 23:53:46', NULL, '', NULL, 1, NULL, NULL),
(2, 1, NULL, '2012-02-09 20:53:27', '2012-02-09 22:54:35', 'kurt', NULL, '607bd9e56b03d15a257732e044793ff9', NULL, NULL, 'Kurtão', 'Wallner', '9999999999999', '', '999999999999', 'email@kurt.com.br', '', 0, '', '', '', 1, 1, NULL, NULL, 1, '', '2012-02-27 17:30:48', '2012-02-10 10:07:26', NULL, '', NULL, 1, NULL, NULL),
(3, 1, NULL, '2012-02-09 22:18:17', '2012-02-10 00:18:17', 'teste', NULL, '698dc19d489c4e4db73e28a713eab07b', NULL, NULL, 'Teste', '', '', '', '', '', '', 0, '', '', '', 1, 1, NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_usergroup`
--

CREATE TABLE IF NOT EXISTS `llx_usergroup` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `note` text,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_usergroup_name` (`nom`,`entity`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Extraindo dados da tabela `llx_usergroup`
--

INSERT INTO `llx_usergroup` (`rowid`, `nom`, `entity`, `datec`, `tms`, `note`) VALUES
(1, 'Comercial', 1, '2012-02-09 22:02:02', '2012-02-10 00:02:02', 'Vendedor');

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_usergroup_rights`
--

CREATE TABLE IF NOT EXISTS `llx_usergroup_rights` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_usergroup` int(11) NOT NULL,
  `fk_id` int(11) NOT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `fk_usergroup` (`fk_usergroup`,`fk_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=67 ;

--
-- Extraindo dados da tabela `llx_usergroup_rights`
--

INSERT INTO `llx_usergroup_rights` (`rowid`, `fk_usergroup`, `fk_id`) VALUES
(42, 1, 21),
(43, 1, 22),
(44, 1, 24),
(45, 1, 25),
(46, 1, 26),
(47, 1, 27),
(48, 1, 28),
(38, 1, 31),
(39, 1, 32),
(40, 1, 34),
(41, 1, 38),
(2, 1, 71),
(3, 1, 78),
(11, 1, 81),
(12, 1, 82),
(13, 1, 84),
(14, 1, 86),
(15, 1, 87),
(16, 1, 88),
(17, 1, 89),
(53, 1, 121),
(54, 1, 122),
(55, 1, 125),
(56, 1, 126),
(19, 1, 161),
(20, 1, 162),
(21, 1, 163),
(22, 1, 164),
(23, 1, 165),
(63, 1, 251),
(64, 1, 256),
(57, 1, 262),
(58, 1, 281),
(59, 1, 282),
(60, 1, 283),
(61, 1, 286),
(65, 1, 342),
(66, 1, 343),
(49, 1, 531),
(50, 1, 532),
(51, 1, 534),
(52, 1, 538),
(24, 1, 1181),
(25, 1, 1182),
(26, 1, 1183),
(27, 1, 1184),
(28, 1, 1185),
(29, 1, 1186),
(30, 1, 1187),
(31, 1, 1188),
(32, 1, 1231),
(33, 1, 1232),
(34, 1, 1233),
(35, 1, 1234),
(36, 1, 1235),
(37, 1, 1236),
(18, 1, 1421),
(7, 1, 2401),
(6, 1, 2402),
(8, 1, 2403),
(9, 1, 2411);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_usergroup_user`
--

CREATE TABLE IF NOT EXISTS `llx_usergroup_user` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `entity` int(11) NOT NULL DEFAULT '1',
  `fk_user` int(11) NOT NULL,
  `fk_usergroup` int(11) NOT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_usergroup_user` (`entity`,`fk_user`,`fk_usergroup`),
  KEY `fk_usergroup_user_fk_user` (`fk_user`),
  KEY `fk_usergroup_user_fk_usergroup` (`fk_usergroup`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Extraindo dados da tabela `llx_usergroup_user`
--

INSERT INTO `llx_usergroup_user` (`rowid`, `entity`, `fk_user`, `fk_usergroup`) VALUES
(1, 1, 2, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_user_alert`
--

CREATE TABLE IF NOT EXISTS `llx_user_alert` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT NULL,
  `fk_contact` int(11) DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_user_clicktodial`
--

CREATE TABLE IF NOT EXISTS `llx_user_clicktodial` (
  `fk_user` int(11) NOT NULL,
  `login` varchar(32) DEFAULT NULL,
  `pass` varchar(64) DEFAULT NULL,
  `poste` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`fk_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_user_param`
--

CREATE TABLE IF NOT EXISTS `llx_user_param` (
  `fk_user` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT '1',
  `param` varchar(64) NOT NULL,
  `value` varchar(255) NOT NULL,
  UNIQUE KEY `uk_user_param` (`fk_user`,`param`,`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `llx_user_rights`
--

CREATE TABLE IF NOT EXISTS `llx_user_rights` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_user` int(11) NOT NULL,
  `fk_id` int(11) NOT NULL,
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `uk_user_rights` (`fk_user`,`fk_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=519 ;

--
-- Extraindo dados da tabela `llx_user_rights`
--

INSERT INTO `llx_user_rights` (`rowid`, `fk_user`, `fk_id`) VALUES
(434, 1, 11),
(427, 1, 12),
(428, 1, 13),
(430, 1, 14),
(431, 1, 15),
(433, 1, 16),
(435, 1, 19),
(30, 1, 21),
(22, 1, 22),
(24, 1, 24),
(25, 1, 25),
(27, 1, 26),
(29, 1, 27),
(31, 1, 28),
(457, 1, 31),
(454, 1, 32),
(456, 1, 34),
(458, 1, 38),
(332, 1, 41),
(331, 1, 42),
(333, 1, 44),
(96, 1, 61),
(93, 1, 62),
(95, 1, 64),
(97, 1, 67),
(98, 1, 68),
(275, 1, 71),
(270, 1, 72),
(272, 1, 74),
(276, 1, 75),
(274, 1, 76),
(278, 1, 78),
(279, 1, 79),
(139, 1, 81),
(131, 1, 82),
(133, 1, 84),
(134, 1, 86),
(136, 1, 87),
(138, 1, 88),
(140, 1, 89),
(212, 1, 91),
(209, 1, 92),
(211, 1, 93),
(213, 1, 94),
(162, 1, 95),
(163, 1, 96),
(165, 1, 97),
(166, 1, 98),
(120, 1, 101),
(116, 1, 102),
(118, 1, 104),
(119, 1, 105),
(121, 1, 109),
(423, 1, 111),
(414, 1, 112),
(416, 1, 113),
(418, 1, 114),
(420, 1, 115),
(422, 1, 116),
(424, 1, 117),
(509, 1, 121),
(506, 1, 122),
(508, 1, 125),
(510, 1, 126),
(337, 1, 141),
(336, 1, 142),
(338, 1, 144),
(219, 1, 151),
(216, 1, 152),
(218, 1, 153),
(220, 1, 154),
(82, 1, 161),
(77, 1, 162),
(79, 1, 163),
(81, 1, 164),
(83, 1, 165),
(266, 1, 171),
(263, 1, 172),
(265, 1, 173),
(267, 1, 178),
(342, 1, 241),
(341, 1, 242),
(343, 1, 243),
(511, 1, 262),
(517, 1, 281),
(514, 1, 282),
(516, 1, 283),
(518, 1, 286),
(1, 1, 341),
(2, 1, 342),
(3, 1, 343),
(4, 1, 344),
(89, 1, 531),
(86, 1, 532),
(88, 1, 534),
(90, 1, 538),
(127, 1, 1101),
(124, 1, 1102),
(126, 1, 1104),
(128, 1, 1109),
(280, 1, 1181),
(292, 1, 1182),
(283, 1, 1183),
(285, 1, 1184),
(287, 1, 1185),
(289, 1, 1186),
(291, 1, 1187),
(293, 1, 1188),
(302, 1, 1231),
(296, 1, 1232),
(298, 1, 1233),
(300, 1, 1234),
(301, 1, 1235),
(303, 1, 1236),
(436, 1, 1321),
(141, 1, 1421),
(322, 1, 2401),
(321, 1, 2402),
(323, 1, 2403),
(327, 1, 2411),
(326, 1, 2412),
(328, 1, 2413),
(160, 1, 2501),
(159, 1, 2503),
(161, 1, 2515),
(411, 1, 50101),
(344, 2, 11),
(345, 2, 21),
(346, 2, 41),
(347, 2, 71),
(348, 2, 78),
(349, 2, 81),
(350, 2, 91),
(351, 2, 95),
(352, 2, 97),
(353, 2, 101),
(354, 2, 111),
(355, 2, 121),
(356, 2, 151),
(357, 2, 161),
(358, 2, 171),
(359, 2, 241),
(360, 2, 262),
(361, 2, 281),
(362, 2, 341),
(363, 2, 342),
(364, 2, 343),
(365, 2, 344),
(366, 2, 531),
(367, 2, 1101),
(368, 2, 1181),
(369, 2, 1182),
(370, 2, 1231),
(371, 2, 2401),
(372, 2, 2501),
(373, 2, 2503),
(374, 2, 2515),
(382, 3, 11),
(383, 3, 21),
(384, 3, 31),
(385, 3, 41),
(386, 3, 71),
(387, 3, 78),
(388, 3, 81),
(389, 3, 91),
(390, 3, 95),
(391, 3, 97),
(392, 3, 101),
(393, 3, 111),
(394, 3, 121),
(395, 3, 151),
(396, 3, 161),
(397, 3, 171),
(398, 3, 241),
(399, 3, 262),
(400, 3, 281),
(401, 3, 341),
(402, 3, 342),
(403, 3, 343),
(404, 3, 344),
(405, 3, 531),
(406, 3, 1101),
(407, 3, 1181),
(408, 3, 1182),
(409, 3, 1231),
(410, 3, 2401);

--
-- Restrições para as tabelas dumpadas
--

--
-- Restrições para a tabela `llx_accountingaccount`
--
ALTER TABLE `llx_accountingaccount`
  ADD CONSTRAINT `fk_accountingaccount_fk_pcg_version` FOREIGN KEY (`fk_pcg_version`) REFERENCES `llx_accountingsystem` (`pcg_version`);

--
-- Restrições para a tabela `llx_adherent`
--
ALTER TABLE `llx_adherent`
  ADD CONSTRAINT `adherent_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  ADD CONSTRAINT `fk_adherent_adherent_type` FOREIGN KEY (`fk_adherent_type`) REFERENCES `llx_adherent_type` (`rowid`);

--
-- Restrições para a tabela `llx_boxes`
--
ALTER TABLE `llx_boxes`
  ADD CONSTRAINT `fk_boxes_box_id` FOREIGN KEY (`box_id`) REFERENCES `llx_boxes_def` (`rowid`);

--
-- Restrições para a tabela `llx_categorie_association`
--
ALTER TABLE `llx_categorie_association`
  ADD CONSTRAINT `fk_categorie_asso_fk_categorie_fille` FOREIGN KEY (`fk_categorie_fille`) REFERENCES `llx_categorie` (`rowid`),
  ADD CONSTRAINT `fk_categorie_asso_fk_categorie_mere` FOREIGN KEY (`fk_categorie_mere`) REFERENCES `llx_categorie` (`rowid`);

--
-- Restrições para a tabela `llx_categorie_member`
--
ALTER TABLE `llx_categorie_member`
  ADD CONSTRAINT `fk_categorie_member_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`),
  ADD CONSTRAINT `fk_categorie_member_member_rowid` FOREIGN KEY (`fk_member`) REFERENCES `llx_adherent` (`rowid`);

--
-- Restrições para a tabela `llx_categorie_product`
--
ALTER TABLE `llx_categorie_product`
  ADD CONSTRAINT `fk_categorie_product_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`),
  ADD CONSTRAINT `fk_categorie_product_product_rowid` FOREIGN KEY (`fk_product`) REFERENCES `llx_product` (`rowid`);

--
-- Restrições para a tabela `llx_categorie_societe`
--
ALTER TABLE `llx_categorie_societe`
  ADD CONSTRAINT `fk_categorie_societe_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`),
  ADD CONSTRAINT `fk_categorie_societe_fk_soc` FOREIGN KEY (`fk_societe`) REFERENCES `llx_societe` (`rowid`);

--
-- Restrições para a tabela `llx_commande`
--
ALTER TABLE `llx_commande`
  ADD CONSTRAINT `fk_commande_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`);

--
-- Restrições para a tabela `llx_commandedet`
--
ALTER TABLE `llx_commandedet`
  ADD CONSTRAINT `fk_commandedet_fk_commande` FOREIGN KEY (`fk_commande`) REFERENCES `llx_commande` (`rowid`);

--
-- Restrições para a tabela `llx_commande_fournisseur`
--
ALTER TABLE `llx_commande_fournisseur`
  ADD CONSTRAINT `fk_commande_fournisseur_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`);

--
-- Restrições para a tabela `llx_contrat`
--
ALTER TABLE `llx_contrat`
  ADD CONSTRAINT `fk_contrat_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  ADD CONSTRAINT `fk_contrat_user_author` FOREIGN KEY (`fk_user_author`) REFERENCES `llx_user` (`rowid`);

--
-- Restrições para a tabela `llx_contratdet`
--
ALTER TABLE `llx_contratdet`
  ADD CONSTRAINT `fk_contratdet_fk_contrat` FOREIGN KEY (`fk_contrat`) REFERENCES `llx_contrat` (`rowid`),
  ADD CONSTRAINT `fk_contratdet_fk_product` FOREIGN KEY (`fk_product`) REFERENCES `llx_product` (`rowid`);

--
-- Restrições para a tabela `llx_contratdet_log`
--
ALTER TABLE `llx_contratdet_log`
  ADD CONSTRAINT `fk_contratdet_log_fk_contratdet` FOREIGN KEY (`fk_contratdet`) REFERENCES `llx_contratdet` (`rowid`);

--
-- Restrições para a tabela `llx_c_regions`
--
ALTER TABLE `llx_c_regions`
  ADD CONSTRAINT `fk_c_regions_fk_pays` FOREIGN KEY (`fk_pays`) REFERENCES `llx_c_pays` (`rowid`);

--
-- Restrições para a tabela `llx_c_ziptown`
--
ALTER TABLE `llx_c_ziptown`
  ADD CONSTRAINT `fk_c_ziptown_fk_county` FOREIGN KEY (`fk_county`) REFERENCES `llx_c_departements` (`rowid`),
  ADD CONSTRAINT `fk_c_ziptown_fk_pays` FOREIGN KEY (`fk_pays`) REFERENCES `llx_c_pays` (`rowid`);

--
-- Restrições para a tabela `llx_element_contact`
--
ALTER TABLE `llx_element_contact`
  ADD CONSTRAINT `fk_element_contact_fk_c_type_contact` FOREIGN KEY (`fk_c_type_contact`) REFERENCES `llx_c_type_contact` (`rowid`);

--
-- Restrições para a tabela `llx_expedition`
--
ALTER TABLE `llx_expedition`
  ADD CONSTRAINT `fk_expedition_fk_expedition_methode` FOREIGN KEY (`fk_expedition_methode`) REFERENCES `llx_c_shipment_mode` (`rowid`),
  ADD CONSTRAINT `fk_expedition_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  ADD CONSTRAINT `fk_expedition_fk_user_author` FOREIGN KEY (`fk_user_author`) REFERENCES `llx_user` (`rowid`),
  ADD CONSTRAINT `fk_expedition_fk_user_valid` FOREIGN KEY (`fk_user_valid`) REFERENCES `llx_user` (`rowid`);

--
-- Restrições para a tabela `llx_expeditiondet`
--
ALTER TABLE `llx_expeditiondet`
  ADD CONSTRAINT `fk_expeditiondet_fk_expedition` FOREIGN KEY (`fk_expedition`) REFERENCES `llx_expedition` (`rowid`);

--
-- Restrições para a tabela `llx_facture`
--
ALTER TABLE `llx_facture`
  ADD CONSTRAINT `fk_facture_fk_facture_source` FOREIGN KEY (`fk_facture_source`) REFERENCES `llx_facture` (`rowid`),
  ADD CONSTRAINT `fk_facture_fk_projet` FOREIGN KEY (`fk_projet`) REFERENCES `llx_projet` (`rowid`),
  ADD CONSTRAINT `fk_facture_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  ADD CONSTRAINT `fk_facture_fk_user_author` FOREIGN KEY (`fk_user_author`) REFERENCES `llx_user` (`rowid`),
  ADD CONSTRAINT `fk_facture_fk_user_valid` FOREIGN KEY (`fk_user_valid`) REFERENCES `llx_user` (`rowid`);

--
-- Restrições para a tabela `llx_facturedet`
--
ALTER TABLE `llx_facturedet`
  ADD CONSTRAINT `fk_facturedet_fk_facture` FOREIGN KEY (`fk_facture`) REFERENCES `llx_facture` (`rowid`);

--
-- Restrições para a tabela `llx_facture_fourn`
--
ALTER TABLE `llx_facture_fourn`
  ADD CONSTRAINT `fk_facture_fourn_fk_projet` FOREIGN KEY (`fk_projet`) REFERENCES `llx_projet` (`rowid`),
  ADD CONSTRAINT `fk_facture_fourn_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  ADD CONSTRAINT `fk_facture_fourn_fk_user_author` FOREIGN KEY (`fk_user_author`) REFERENCES `llx_user` (`rowid`),
  ADD CONSTRAINT `fk_facture_fourn_fk_user_valid` FOREIGN KEY (`fk_user_valid`) REFERENCES `llx_user` (`rowid`);

--
-- Restrições para a tabela `llx_facture_fourn_det`
--
ALTER TABLE `llx_facture_fourn_det`
  ADD CONSTRAINT `fk_facture_fourn_det_fk_facture` FOREIGN KEY (`fk_facture_fourn`) REFERENCES `llx_facture_fourn` (`rowid`);

--
-- Restrições para a tabela `llx_facture_rec`
--
ALTER TABLE `llx_facture_rec`
  ADD CONSTRAINT `fk_facture_rec_fk_projet` FOREIGN KEY (`fk_projet`) REFERENCES `llx_projet` (`rowid`),
  ADD CONSTRAINT `fk_facture_rec_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  ADD CONSTRAINT `fk_facture_rec_fk_user_author` FOREIGN KEY (`fk_user_author`) REFERENCES `llx_user` (`rowid`);

--
-- Restrições para a tabela `llx_fichinter`
--
ALTER TABLE `llx_fichinter`
  ADD CONSTRAINT `fk_fichinter_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`);

--
-- Restrições para a tabela `llx_fichinterdet`
--
ALTER TABLE `llx_fichinterdet`
  ADD CONSTRAINT `fk_fichinterdet_fk_fichinter` FOREIGN KEY (`fk_fichinter`) REFERENCES `llx_fichinter` (`rowid`);

--
-- Restrições para a tabela `llx_livraison`
--
ALTER TABLE `llx_livraison`
  ADD CONSTRAINT `fk_livraison_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  ADD CONSTRAINT `fk_livraison_fk_user_author` FOREIGN KEY (`fk_user_author`) REFERENCES `llx_user` (`rowid`),
  ADD CONSTRAINT `fk_livraison_fk_user_valid` FOREIGN KEY (`fk_user_valid`) REFERENCES `llx_user` (`rowid`);

--
-- Restrições para a tabela `llx_livraisondet`
--
ALTER TABLE `llx_livraisondet`
  ADD CONSTRAINT `fk_livraisondet_fk_livraison` FOREIGN KEY (`fk_livraison`) REFERENCES `llx_livraison` (`rowid`);

--
-- Restrições para a tabela `llx_paiement_facture`
--
ALTER TABLE `llx_paiement_facture`
  ADD CONSTRAINT `fk_paiement_facture_fk_facture` FOREIGN KEY (`fk_facture`) REFERENCES `llx_facture` (`rowid`),
  ADD CONSTRAINT `fk_paiement_facture_fk_paiement` FOREIGN KEY (`fk_paiement`) REFERENCES `llx_paiement` (`rowid`);

--
-- Restrições para a tabela `llx_prelevement_facture`
--
ALTER TABLE `llx_prelevement_facture`
  ADD CONSTRAINT `fk_prelevement_facture_fk_prelevement_lignes` FOREIGN KEY (`fk_prelevement_lignes`) REFERENCES `llx_prelevement_lignes` (`rowid`);

--
-- Restrições para a tabela `llx_prelevement_lignes`
--
ALTER TABLE `llx_prelevement_lignes`
  ADD CONSTRAINT `fk_prelevement_lignes_fk_prelevement_bons` FOREIGN KEY (`fk_prelevement_bons`) REFERENCES `llx_prelevement_bons` (`rowid`);

--
-- Restrições para a tabela `llx_product_composition`
--
ALTER TABLE `llx_product_composition`
  ADD CONSTRAINT `idx_product_composition_fk_product` FOREIGN KEY (`fk_product`) REFERENCES `llx_product` (`rowid`),
  ADD CONSTRAINT `idx_product_composition_fk_product_composition` FOREIGN KEY (`fk_product_composition`) REFERENCES `llx_product` (`rowid`);

--
-- Restrições para a tabela `llx_product_fournisseur`
--
ALTER TABLE `llx_product_fournisseur`
  ADD CONSTRAINT `fk_product_fournisseur_fk_product` FOREIGN KEY (`fk_product`) REFERENCES `llx_product` (`rowid`);

--
-- Restrições para a tabela `llx_product_fournisseur_price`
--
ALTER TABLE `llx_product_fournisseur_price`
  ADD CONSTRAINT `fk_product_fournisseur_price_fk_product_fournisseur` FOREIGN KEY (`fk_product_fournisseur`) REFERENCES `llx_product_fournisseur` (`rowid`),
  ADD CONSTRAINT `fk_product_fournisseur_price_fk_user` FOREIGN KEY (`fk_user`) REFERENCES `llx_user` (`rowid`);

--
-- Restrições para a tabela `llx_product_lang`
--
ALTER TABLE `llx_product_lang`
  ADD CONSTRAINT `fk_product_lang_fk_product` FOREIGN KEY (`fk_product`) REFERENCES `llx_product` (`rowid`);

--
-- Restrições para a tabela `llx_projet`
--
ALTER TABLE `llx_projet`
  ADD CONSTRAINT `fk_projet_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`);

--
-- Restrições para a tabela `llx_projet_task`
--
ALTER TABLE `llx_projet_task`
  ADD CONSTRAINT `fk_projet_task_fk_projet` FOREIGN KEY (`fk_projet`) REFERENCES `llx_projet` (`rowid`),
  ADD CONSTRAINT `fk_projet_task_fk_user_creat` FOREIGN KEY (`fk_user_creat`) REFERENCES `llx_user` (`rowid`),
  ADD CONSTRAINT `fk_projet_task_fk_user_valid` FOREIGN KEY (`fk_user_valid`) REFERENCES `llx_user` (`rowid`);

--
-- Restrições para a tabela `llx_propal`
--
ALTER TABLE `llx_propal`
  ADD CONSTRAINT `fk_propal_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`);

--
-- Restrições para a tabela `llx_propaldet`
--
ALTER TABLE `llx_propaldet`
  ADD CONSTRAINT `fk_propaldet_fk_propal` FOREIGN KEY (`fk_propal`) REFERENCES `llx_propal` (`rowid`);

--
-- Restrições para a tabela `llx_societe_remise_except`
--
ALTER TABLE `llx_societe_remise_except`
  ADD CONSTRAINT `fk_societe_remise_fk_facture` FOREIGN KEY (`fk_facture`) REFERENCES `llx_facture` (`rowid`),
  ADD CONSTRAINT `fk_societe_remise_fk_facture_line` FOREIGN KEY (`fk_facture_line`) REFERENCES `llx_facturedet` (`rowid`),
  ADD CONSTRAINT `fk_societe_remise_fk_facture_source` FOREIGN KEY (`fk_facture_source`) REFERENCES `llx_facture` (`rowid`),
  ADD CONSTRAINT `fk_societe_remise_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  ADD CONSTRAINT `fk_societe_remise_fk_user` FOREIGN KEY (`fk_user`) REFERENCES `llx_user` (`rowid`);

--
-- Restrições para a tabela `llx_socpeople`
--
ALTER TABLE `llx_socpeople`
  ADD CONSTRAINT `fk_socpeople_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  ADD CONSTRAINT `fk_socpeople_user_creat_user_rowid` FOREIGN KEY (`fk_user_creat`) REFERENCES `llx_user` (`rowid`);

--
-- Restrições para a tabela `llx_usergroup_rights`
--
ALTER TABLE `llx_usergroup_rights`
  ADD CONSTRAINT `fk_usergroup_rights_fk_usergroup` FOREIGN KEY (`fk_usergroup`) REFERENCES `llx_usergroup` (`rowid`);

--
-- Restrições para a tabela `llx_usergroup_user`
--
ALTER TABLE `llx_usergroup_user`
  ADD CONSTRAINT `fk_usergroup_user_fk_user` FOREIGN KEY (`fk_user`) REFERENCES `llx_user` (`rowid`),
  ADD CONSTRAINT `fk_usergroup_user_fk_usergroup` FOREIGN KEY (`fk_usergroup`) REFERENCES `llx_usergroup` (`rowid`);

--
-- Restrições para a tabela `llx_user_rights`
--
ALTER TABLE `llx_user_rights`
  ADD CONSTRAINT `fk_user_rights_fk_user_user` FOREIGN KEY (`fk_user`) REFERENCES `llx_user` (`rowid`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

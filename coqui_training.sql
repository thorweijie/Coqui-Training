-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.6.5-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for coqui_training
CREATE DATABASE IF NOT EXISTS `coqui_training` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_general_ci */;
USE `coqui_training`;

-- Dumping structure for table coqui_training.test_tokens
CREATE TABLE IF NOT EXISTS `test_tokens` (
  `token_id` int(11) NOT NULL AUTO_INCREMENT,
  `transcript_id` int(11) DEFAULT NULL,
  `token` text COLLATE latin1_general_ci DEFAULT NULL,
  `start_time` float unsigned DEFAULT 0,
  `duration` float unsigned DEFAULT 0,
  PRIMARY KEY (`token_id`) USING BTREE,
  KEY `FK_test_transcriptions_id` (`transcript_id`),
  CONSTRAINT `FK_test_transcriptions_id` FOREIGN KEY (`transcript_id`) REFERENCES `test_transcriptions` (`transcript_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table coqui_training.test_tokens: ~16 rows (approximately)
/*!40000 ALTER TABLE `test_tokens` DISABLE KEYS */;
INSERT INTO `test_tokens` (`token_id`, `transcript_id`, `token`, `start_time`, `duration`) VALUES
	(1, 1, 'experience', 0.68, 0.44),
	(2, 1, 'proves', 1.22, 0.22),
	(3, 1, 'this', 1.5, 0.12),
	(4, 2, 'why', 0.76, 0.12),
	(5, 2, 'should', 0.94, 0.2),
	(6, 2, 'one', 1.26, 0.18),
	(7, 2, 'halt', 1.54, 0.22),
	(8, 2, 'on', 1.98, 0.1),
	(9, 2, 'the', 2.14, 0.14),
	(10, 2, 'way', 2.38, 0.2),
	(11, 3, 'your', 0.72, 0.16),
	(12, 3, 'part', 0.96, 0.28),
	(13, 3, 'is', 1.28, 0.1),
	(14, 3, 'sufficient', 1.44, 0.38),
	(15, 3, 'i', 1.9, 0.1),
	(16, 3, 'said', 2.08, 0.08);
/*!40000 ALTER TABLE `test_tokens` ENABLE KEYS */;

-- Dumping structure for table coqui_training.test_transcriptions
CREATE TABLE IF NOT EXISTS `test_transcriptions` (
  `transcript_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text COLLATE latin1_general_ci DEFAULT NULL,
  `full_transcript` mediumtext COLLATE latin1_general_ci DEFAULT NULL,
  `audio` text COLLATE latin1_general_ci DEFAULT NULL,
  `confidence` float DEFAULT NULL,
  PRIMARY KEY (`transcript_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- Dumping data for table coqui_training.test_transcriptions: ~3 rows (approximately)
/*!40000 ALTER TABLE `test_transcriptions` DISABLE KEYS */;
INSERT INTO `test_transcriptions` (`transcript_id`, `name`, `full_transcript`, `audio`, `confidence`) VALUES
	(1, 'NOV2021-0001', 'experience proves this', '2830-3980-0043.wav', -18.6151),
	(2, 'NOV2021-0002', 'why should one halt on the way', '4507-16021-0012.wav', -28.9719),
	(3, 'NOV2021-0003', 'your part is sufficient i said', '8455-210777-0068.wav', -26.9806);
/*!40000 ALTER TABLE `test_transcriptions` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

-- MySQL dump 10.13  Distrib 5.7.12, for Win32 (AMD64)
--
-- Host: mydbinstance1.com52r4wudge.us-west-2.rds.amazonaws.com    Database: rentals
-- ------------------------------------------------------
-- Server version	5.6.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `rentals`
--

DROP TABLE IF EXISTS `rentals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rentals` (
  `R_Customer_Id` int(11) DEFAULT NULL,
  `R_Vehicle_Id` int(11) DEFAULT NULL,
  `Location` varchar(15) DEFAULT 'Arlington',
  `Daily_Flag` char(1) DEFAULT NULL,
  `D_StDate` date DEFAULT NULL,
  `D_NoofDays` int(11) DEFAULT NULL,
  `D_RtDate` date DEFAULT NULL,
  `D_AmtDue` decimal(10,2) DEFAULT NULL,
  `Weekly_Flag` char(1) DEFAULT NULL,
  `W_StDate` date DEFAULT NULL,
  `W_NoofWeeks` int(11) DEFAULT NULL,
  `W_RtDate` date DEFAULT NULL,
  `W_AmtDue` decimal(10,2) DEFAULT NULL,
  KEY `fvehid01_idx` (`R_Vehicle_Id`),
  KEY `fcustid01` (`R_Customer_Id`),
  CONSTRAINT `fcustid01` FOREIGN KEY (`R_Customer_Id`) REFERENCES `customer` (`Customer_Id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `fvehid01` FOREIGN KEY (`R_Vehicle_Id`) REFERENCES `car` (`Vehicle_Id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rentals`
--

LOCK TABLES `rentals` WRITE;
/*!40000 ALTER TABLE `rentals` DISABLE KEYS */;
INSERT INTO `rentals` VALUES (30,809,'Arlington','N',NULL,NULL,NULL,NULL,'Y','2016-08-07',1,'2016-08-14',125.00),(45,822,'Arlington','Y','2016-08-07',2,'2016-08-09',200.00,'N',NULL,NULL,NULL,NULL),(39,808,'Arlington','Y','2016-08-04',3,'2016-08-07',120.00,'N',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `rentals` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-08-11  3:26:59

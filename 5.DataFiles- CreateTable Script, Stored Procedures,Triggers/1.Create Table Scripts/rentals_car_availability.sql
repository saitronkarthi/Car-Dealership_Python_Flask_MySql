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
-- Table structure for table `car_availability`
--

DROP TABLE IF EXISTS `car_availability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `car_availability` (
  `Vehicle_Id` int(11) DEFAULT NULL,
  `Period_Id` int(11) DEFAULT NULL,
  `Avail_Flag` char(1) DEFAULT NULL,
  KEY `fvehid_idx` (`Vehicle_Id`),
  KEY `fperiodid_idx` (`Period_Id`),
  CONSTRAINT `fperiodid` FOREIGN KEY (`Period_Id`) REFERENCES `car_availability_periods` (`Period_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fvehid` FOREIGN KEY (`Vehicle_Id`) REFERENCES `car` (`Vehicle_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `car_availability`
--

LOCK TABLES `car_availability` WRITE;
/*!40000 ALTER TABLE `car_availability` DISABLE KEYS */;
INSERT INTO `car_availability` VALUES (805,1,'Y'),(805,2,'Y'),(805,3,'Y'),(805,4,'Y'),(805,5,'Y'),(805,6,'Y'),(806,1,'Y'),(806,2,'Y'),(806,3,'Y'),(806,4,'Y'),(806,5,'Y'),(806,6,'Y'),(807,1,'Y'),(807,2,'Y'),(807,3,'Y'),(807,4,'Y'),(807,5,'Y'),(807,6,'Y'),(808,1,'N'),(808,2,'Y'),(808,3,'Y'),(808,4,'Y'),(808,5,'Y'),(808,6,'Y'),(809,1,'N'),(809,2,'Y'),(809,3,'Y'),(809,4,'Y'),(809,5,'Y'),(809,6,'Y'),(810,1,'Y'),(810,2,'Y'),(810,3,'Y'),(810,4,'Y'),(810,5,'Y'),(810,6,'Y'),(811,1,'Y'),(811,2,'Y'),(811,3,'Y'),(811,4,'Y'),(811,5,'Y'),(811,6,'Y'),(812,1,'Y'),(812,2,'Y'),(812,3,'Y'),(812,4,'Y'),(812,5,'Y'),(812,6,'Y'),(813,1,'Y'),(813,2,'Y'),(813,3,'Y'),(813,4,'Y'),(813,5,'Y'),(813,6,'Y'),(814,1,'Y'),(814,2,'Y'),(814,3,'Y'),(814,4,'Y'),(814,5,'Y'),(814,6,'Y'),(815,1,'Y'),(815,2,'Y'),(815,3,'Y'),(815,4,'Y'),(815,5,'Y'),(815,6,'Y'),(816,1,'Y'),(816,2,'Y'),(816,3,'Y'),(816,4,'Y'),(816,5,'Y'),(816,6,'Y'),(817,1,'Y'),(817,2,'Y'),(817,3,'Y'),(817,4,'Y'),(817,5,'Y'),(817,6,'Y'),(818,1,'Y'),(818,2,'Y'),(818,3,'Y'),(818,4,'Y'),(818,5,'Y'),(818,6,'Y'),(819,1,'Y'),(819,2,'Y'),(819,3,'Y'),(819,4,'Y'),(819,5,'Y'),(819,6,'Y'),(820,1,'Y'),(820,2,'Y'),(820,3,'Y'),(820,4,'Y'),(820,5,'Y'),(820,6,'Y'),(821,1,'Y'),(821,2,'Y'),(821,3,'Y'),(821,4,'Y'),(821,5,'Y'),(821,6,'Y'),(822,1,'N'),(822,2,'Y'),(822,3,'Y'),(822,4,'Y'),(822,5,'Y'),(822,6,'Y'),(823,1,'Y'),(823,2,'Y'),(823,3,'Y'),(823,4,'Y'),(823,5,'Y'),(823,6,'Y'),(836,1,'Y'),(836,2,'Y'),(836,3,'Y'),(836,4,'Y'),(836,5,'Y'),(836,6,'Y');
/*!40000 ALTER TABLE `car_availability` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-08-11  3:27:02

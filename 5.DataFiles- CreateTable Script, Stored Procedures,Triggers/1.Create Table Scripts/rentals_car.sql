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
-- Table structure for table `car`
--

DROP TABLE IF EXISTS `car`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `car` (
  `Vehicle_Id` int(11) NOT NULL AUTO_INCREMENT,
  `LicensePlate_No` varchar(45) DEFAULT NULL,
  `Model` varchar(45) DEFAULT NULL,
  `Year` int(11) DEFAULT NULL,
  `Daily_Rate` decimal(10,2) DEFAULT NULL,
  `Weekly_Rate` decimal(10,2) DEFAULT NULL,
  `Car_Type` enum('COMPACT','MEDIUM','LARGE','SUV','TRUCK','VAN') DEFAULT NULL,
  PRIMARY KEY (`Vehicle_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=837 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `car`
--

LOCK TABLES `car` WRITE;
/*!40000 ALTER TABLE `car` DISABLE KEYS */;
INSERT INTO `car` VALUES (805,'GPY6166','Volkswagon Golf',2010,35.00,80.00,'COMPACT'),(806,'MXV1283','Ford Focus',2014,45.00,90.00,'COMPACT'),(807,'DKJ4975','Dodge Dart',2007,30.00,85.00,'COMPACT'),(808,'SKK0389','Honda Accord',2008,40.00,110.00,'MEDIUM'),(809,'AWS6768','Toyota Camry',2013,55.00,125.00,'MEDIUM'),(810,'LAD2235','Hundai Sonata',2012,45.00,115.00,'MEDIUM'),(811,'FGD3798','Mazda 6',2011,39.00,128.00,'MEDIUM'),(812,'CDF3344','Tesla Model S',2016,85.00,265.00,'LARGE'),(813,'SER9879','BMW 7 Series',2012,65.00,230.00,'LARGE'),(814,'KJH6732','Nissan Maxima',2013,70.00,245.00,'LARGE'),(815,'QWE3498','Lexus Ls',2015,73.00,257.00,'LARGE'),(816,'FHS7830','Nissan Rouge',2009,80.00,310.00,'SUV'),(817,'POU6897','Toyota Highlander',2015,88.00,338.00,'SUV'),(818,'LJS2397','Honda CR-V',2013,78.00,325.00,'SUV'),(819,'WIU9749','Nissan Frontier',2007,80.00,377.00,'TRUCK'),(820,'SDK5239','Toyota Tacoma',2012,90.00,410.00,'TRUCK'),(821,'VNB2108','Ford F-150',2005,75.00,394.00,'TRUCK'),(822,'COS3848','Honda Odessy',2012,100.00,400.00,'VAN'),(823,'IUD7879','Toyota sienna',2016,115.00,415.00,'VAN'),(836,'YT759869','Limousine',2000,50.00,180.00,'LARGE');
/*!40000 ALTER TABLE `car` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`karthik`@`%`*/ /*!50003 TRIGGER `rentals`.`car_AFTER_INSERT` AFTER INSERT ON `car` FOR EACH ROW
BEGIN
declare vid int;
SET @vid = (SELECT max(Vehicle_Id) from car);

insert into car_availability(Vehicle_Id,Period_Id,Avail_Flag) values (@vid,1,'Y');
insert into car_availability (Vehicle_Id,Period_Id,Avail_Flag)  values (@vid,2,'Y');
insert into car_availability (Vehicle_Id,Period_Id,Avail_Flag)  values (@vid,3,'Y');
insert into car_availability (Vehicle_Id,Period_Id,Avail_Flag)  values (@vid,4,'Y');
insert into car_availability  (Vehicle_Id,Period_Id,Avail_Flag) values  (@vid,5,'Y');
insert into car_availability  (Vehicle_Id,Period_Id,Avail_Flag) values  (@vid,6,'Y');


END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-08-11  3:26:44

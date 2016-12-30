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
-- Dumping events for database 'rentals'
--

--
-- Dumping routines for database 'rentals'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetAllAvailRentals` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`db1`@`%` PROCEDURE `sp_GetAllAvailRentals`(stdate date, enddate date)
BEGIN
declare stperiodid int;
declare endperiodid int;
set @stperiodid=(select Period_Id from car_availability_periods where stdate between St_Date and End_Date);
set @endperiodid=(select Period_Id from car_availability_periods where enddate between St_Date and End_Date);
select distinct c.LicensePlate_No,c.Car_Type,c.Model,c.Year, 
concat('$',c.Daily_Rate) as Daily_Rate,concat('$',c.Weekly_Rate) as Weekly_Rate
from car c, car_availability ca
where c.Vehicle_Id=ca.Vehicle_Id and 
ca.Avail_Flag='Y' and
ca.Period_Id in (@stperiodid,@endperiodid) order by Car_Type;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetAvailCardet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`db1`@`%` PROCEDURE `sp_GetAvailCardet`(cartype enum('COMPACT','MEDIUM','LARGE','SUV','TRUCK','VAN'),
                                                                renttype char(1), stdate date,daysorweeks int)
BEGIN
declare stperiodid int;
declare endperiodid int;
declare rtdate date;
if(renttype='D') then
begin
set @stperiodid=(select period_id  from car_availability_periods where Stdate between st_Date and End_Date);
set @rtdate=(select DATE_ADD(stdate, INTERVAL daysorweeks DAY));
set @endperiodid=(select period_id from car_availability_periods where @rtdate between st_Date and End_Date);
	select distinct c.Vehicle_Id,replace(c.LicensePlate_No,' ','') as LicensePlate_No,c.car_type,'Daily' as RentalType,replace(c.Model,' ','') as Model,c.Year,c.Daily_Rate,
     stdate, concat (daysorweeks,'','days') as days from
	car c, car_availability a
	where c.Vehicle_Id=a.Vehicle_Id
	and a.Period_Id in (@stperiodid,@endperiodid)
	and a.Avail_Flag='Y'
    and c.car_Type=cartype;
end;
    
 else
 begin
 set @stperiodid=(select period_id  from car_availability_periods where Stdate between st_Date and End_Date);
set @rtdate=(select DATE_ADD(stdate, INTERVAL daysorweeks WEEK));
set @endperiodid=(select period_id from car_availability_periods where @rtdate between st_Date and End_Date);
 	select distinct c.Vehicle_Id,replace(c.LicensePlate_No,' ','') as LicensePlate_No,c.car_type,'Weekly' as RentalType,replace(c.Model,' ','') as Model,c.Year,c.Weekly_Rate,
    stdate, concat (daysorweeks, '', 'week') as weeks from
	car c, car_availability a
	where a.Vehicle_Id=c.Vehicle_Id
	and a.Period_Id in (@stperiodid,@endperiodid) 
	and a.Avail_Flag='Y'
    and c.car_Type=cartype;

   end;              
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetRentals` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`db1`@`%` PROCEDURE `sp_GetRentals`(vehicleid int,custid int, vfrom char(1))
BEGIN
declare stdate date;
declare enddate date;
declare stperiodid int;
declare endperiodid int;
declare dwflag char(1);
if(vehicleid=0) then
begin
if(vfrom='T') then
	   select R_Vehicle_Id, R_Customer_Id,cr.Customer_Name,cr.Customer_DLNo, c.Car_Type as CarType,c.LicensePlate_No,
	'Daily' as RentalType,
	D_StDate as StartDate,concat(D_NoofDays,' ','days') as Period,
	D_RtDate as ReturnDate,concat('$',D_AmtDue) as AmtDue
	from rentals r, customer cr, car c
	where r.R_Vehicle_Id=c.Vehicle_Id and
	r.R_Customer_Id=cr.Customer_Id and
	r.Daily_Flag='Y'
    
	union
	   select R_Vehicle_Id, R_Customer_Id,cr.Customer_Name,cr.Customer_DLNo, c.Car_Type as CarType,c.LicensePlate_No,
	'Weekly' as RentalType,
	W_StDate as StartDate,concat(W_NoofWeeks,' ','weeks') as Period,
	W_RtDate as ReturnDate,concat('$',W_AmtDue) as AmtDue
	from rentals r, customer cr, car c
	where r.R_Vehicle_Id=c.Vehicle_Id and
	r.R_Customer_Id=cr.Customer_Id and
	r.Weekly_Flag='Y'
    order by Customer_Name;
   else
    select R_Vehicle_Id, R_Customer_Id,cr.Customer_Name,cr.Customer_DLNo, c.Car_Type as CarType,c.LicensePlate_No,
	'Daily' as RentalType,
	D_StDate as StartDate,concat(D_NoofDays,' ','days') as Period,
	D_RtDate as ReturnDate,concat('$',D_AmtDue) as AmtDue
	from rentalshistory r, customer cr, car c
	where r.R_Vehicle_Id=c.Vehicle_Id and
	r.R_Customer_Id=cr.Customer_Id and
	r.Daily_Flag='Y'
	union
	   select R_Vehicle_Id, R_Customer_Id,cr.Customer_Name,cr.Customer_DLNo, c.Car_Type as CarType,c.LicensePlate_No,
	'Weekly' as RentalType,
	W_StDate as StartDate,concat(W_NoofWeeks,' ','weeks') as Period,
	W_RtDate as ReturnDate,concat('$',W_AmtDue) as AmtDue
	from rentalshistory r, customer cr, car c
	where r.R_Vehicle_Id=c.Vehicle_Id and
	r.R_Customer_Id=cr.Customer_Id and
	r.Weekly_Flag='Y' order by Customer_Name;
    end if;
end;
else
begin
set @dwflag=(select Daily_Flag from rentals where R_Vehicle_Id=vehicleid and R_Customer_Id=custid);
	if(@dwflag='Y') then
begin
set @stdate=(select D_Stdate from rentals where R_Vehicle_Id=vehicleid and R_Customer_Id=custid);
set @enddate=(select D_Rtdate from rentals where R_Vehicle_Id=vehicleid and R_Customer_Id=custid);
set @stperiodid=(select period_id from car_availability_periods where @stdate between St_Date and End_Date);
set @endperiodid=(select period_id from car_availability_periods where @enddate between St_Date and End_Date);
insert into rentalshistory 
select rentals.* from rentals where R_Vehicle_Id=vehicleid and R_Customer_Id=custid;
delete from rentals where R_Vehicle_Id=vehicleid and R_Customer_Id=custid;
update car_availability set Avail_Flag='Y' where Vehicle_Id=vehicleid and Period_Id in (@stperiodid,@endperiodid);
   select R_Vehicle_Id, R_Customer_Id,cr.Customer_Name,cr.Customer_DLNo, c.Car_Type as CarType,c.LicensePlate_No,
'Daily' as RentalType,
D_StDate as StartDate,concat(D_NoofDays,' ','days') as Period,
D_RtDate as ReturnDate,concat('$',D_AmtDue) as AmtDue
from rentals r, customer cr, car c
where r.R_Vehicle_Id=c.Vehicle_Id and
r.R_Customer_Id=cr.Customer_Id and
r.Daily_Flag='Y'
union
   select R_Vehicle_Id, R_Customer_Id,cr.Customer_Name,cr.Customer_DLNo, c.Car_Type as CarType,c.LicensePlate_No,
'Weekly' as RentalType,
W_StDate as StartDate,concat(W_NoofWeeks,' ','weeks') as Period,
W_RtDate as ReturnDate,concat('$',W_AmtDue) as AmtDue
from rentals r, customer cr, car c
where r.R_Vehicle_Id=c.Vehicle_Id and
r.R_Customer_Id=cr.Customer_Id and
r.Weekly_Flag='Y' order by Customer_Name;
end;
else
begin
set @stdate=(select W_Stdate from rentals where R_Vehicle_Id=vehicleid and R_Customer_Id=custid);
set @enddate=(select W_Rtdate from rentals where R_Vehicle_Id=vehicleid and R_Customer_Id=custid);
set @stperiodid=(select period_id from car_availability_periods where @stdate between St_Date and End_Date);
set @endperiodid=(select period_id from car_availability_periods where @enddate between St_Date and End_Date);
insert into rentalshistory 
select rentals.* from rentals where R_Vehicle_Id=vehicleid and R_Customer_Id=custid;
delete from rentals where R_Vehicle_Id=vehicleid and R_Customer_Id=custid;
update car_availability set Avail_Flag='Y' where Vehicle_Id=vehicleid and Period_Id in (@stperiodid,@endperiodid);
   select R_Vehicle_Id, R_Customer_Id,cr.Customer_Name,cr.Customer_DLNo, c.Car_Type as CarType,c.LicensePlate_No,
'Daily' as RentalType,
D_StDate as StartDate,concat(D_NoofDays,' ','days') as Period,
D_RtDate as ReturnDate,concat('$',D_AmtDue) as AmtDue
from rentals r, customer cr, car c
where r.R_Vehicle_Id=c.Vehicle_Id and
r.R_Customer_Id=cr.Customer_Id and
r.Daily_Flag='Y'
union
   select R_Vehicle_Id, R_Customer_Id,cr.Customer_Name,cr.Customer_DLNo, c.Car_Type as CarType,c.LicensePlate_No,
'Weekly' as RentalType,
W_StDate as StartDate,concat(W_NoofWeeks,' ','weeks') as Period,
W_RtDate as ReturnDate,concat('$',W_AmtDue) as AmtDue
from rentals r, customer cr, car c
where r.R_Vehicle_Id=c.Vehicle_Id and
r.R_Customer_Id=cr.Customer_Id and
r.Weekly_Flag='Y' order by Customer_Name;
end;
end if;
end;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_InsertCar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`db1`@`%` PROCEDURE `sp_InsertCar`(vehicleid int,licenseplateno varchar(45),Model varchar(45), Year int,
                                                                Dailyrate decimal, Weeklyrate decimal, cartype enum('COMPACT','MEDIUM','LARGE','SUV','TRUCK','VAN'))
BEGIN
DECLARE Vid INT;
if(vehicleid=0) then
begin

insert into car(LicensePlate_no, Model, Year,Daily_Rate,Weekly_Rate, car_type) values
					(licenseplateno,Model,Year,Dailyrate,Weeklyrate, cartype);
     
 end;                   
	else
update car set  LicensePlate_no= licenseplateno,Model= Model,Year=Year,Daily_Rate=Dailyrate,
				Weekly_Rate=Weeklyrate,car_type=cartype where Vehicle_id=vehicleid;
                 
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_InsertCustomer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`db1`@`%` PROCEDURE `sp_InsertCustomer`(cid int,cname varchar(45),dlno varchar(25), phone varchar(25))
BEGIN
if(cid=0) then
 insert into customer(Customer_Name,Customer_DlNo,Phone) values (cname,dlno,phone);
 else
 update customer set Customer_Name=cname, Customer_DLNo=dlno, Phone=phone where Customer_Id=cid;
 end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_InsertRentals` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`db1`@`%` PROCEDURE `sp_InsertRentals`(customerid int,vehicleid int,dwflag char(1),stdate date, daysorweeks int)
BEGIN
DECLARE rtdate date;
DECLARE amtdue decimal(10,2);
declare dailyrate decimal(10,2);
declare weeklyrate decimal(10,2);
declare stperiodid int;
declare endperiodid int;
if(dwflag='D') then
begin
set @dailyrate=(select daily_rate from car where Vehicle_Id=vehicleid);
set @rtdate=(select DATE_ADD(stdate, INTERVAL daysorweeks DAY));
set @amtdue=(select @dailyrate*daysorweeks);
insert into rentals(R_Customer_Id,R_Vehicle_Id,Location, Daily_Flag,D_StDate, 
					D_NoofDays,D_RtDate,D_AmtDue,Weekly_Flag)
			values(customerid,vehicleid,'Arlington','Y',stdate,
					daysorweeks,@rtdate,@amtdue,'N');
 
set @stperiodid=(select period_id  from car_availability_periods where stdate between st_Date and End_Date);
set @endperiodid=(select period_id from car_availability_periods where @rtdate between st_Date and End_Date);                 
update car_availability	set Avail_Flag='N' where Period_Id in (@stperiodid,@endperiodid) and Vehicle_Id=vehicleid;
                
   
 end;                   
	else
begin
set @weeklyrate=(select weekly_rate from car where Vehicle_Id=vehicleid);
set @rtdate=(select DATE_ADD(stdate, INTERVAL daysorweeks WEEK));
set @amtdue=(select @weeklyrate*daysorweeks);
insert into rentals(R_Customer_Id,R_Vehicle_Id,Location, Daily_Flag,W_StDate, 
					W_NoofWeeks,W_RtDate,W_AmtDue,Weekly_Flag)
			values(customerid,vehicleid,'Arlington','N',stdate,
					daysorweeks,@rtdate,@amtdue,'Y');
set @stperiodid=(select period_id  from car_availability_periods where stdate between st_Date and End_Date);
set @endperiodid=(select period_id from car_availability_periods where @rtdate between st_Date and End_Date);                 
update car_availability	set Avail_Flag='N' where Period_Id in (@stperiodid,@endperiodid) and Vehicle_Id=vehicleid; 
                     
end;
 
                 
end if;
END ;;
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

-- Dump completed on 2016-08-11  3:27:10

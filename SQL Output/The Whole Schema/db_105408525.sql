CREATE DATABASE  IF NOT EXISTS `db_105408525` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `db_105408525`;
-- MySQL dump 10.13  Distrib 8.0.16, for Win64 (x86_64)
--
-- Host: 192.168.56.101    Database: db_105408525
-- ------------------------------------------------------
-- Server version	5.7.30-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Seat`
--

DROP TABLE IF EXISTS `Seat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Seat` (
  `seat_id` varchar(100) NOT NULL,
  PRIMARY KEY (`seat_id`),
  UNIQUE KEY `Seat_id_UNIQUE` (`seat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Seat`
--

LOCK TABLES `Seat` WRITE;
/*!40000 ALTER TABLE `Seat` DISABLE KEYS */;
INSERT INTO `Seat` VALUES ('10A'),('10B'),('10C'),('10D'),('1A'),('1B'),('1C'),('1D'),('2A'),('2B'),('2C'),('2D'),('3A'),('3B'),('3C'),('3D'),('4A'),('4B'),('4C'),('4D'),('5A'),('5B'),('5C'),('5D'),('6A'),('6B'),('6C'),('6D'),('7A'),('7B'),('7C'),('7D'),('8A'),('8B'),('8C'),('8D'),('9A'),('9B'),('9C'),('9D');
/*!40000 ALTER TABLE `Seat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Station`
--

DROP TABLE IF EXISTS `Station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Station` (
  `station_id` int(11) NOT NULL,
  `station_name` varchar(100) DEFAULT NULL,
  `location_marker` int(11) DEFAULT NULL,
  `time_marker` int(11) DEFAULT NULL,
  PRIMARY KEY (`station_id`),
  UNIQUE KEY `Station_id_UNIQUE` (`station_id`),
  UNIQUE KEY `station_name_UNIQUE` (`station_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Station`
--

LOCK TABLES `Station` WRITE;
/*!40000 ALTER TABLE `Station` DISABLE KEYS */;
INSERT INTO `Station` VALUES (1,'台北',1,0),(2,'桃園',3,20),(3,'新竹',4,30),(4,'台中',8,60),(5,'高雄',15,120);
/*!40000 ALTER TABLE `Station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ticket`
--

DROP TABLE IF EXISTS `Ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Ticket` (
  `ticket_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `train_date` datetime DEFAULT NULL,
  `train_id` int(11) NOT NULL,
  `departure_station` int(11) NOT NULL,
  `arrival_station` int(11) NOT NULL,
  `seat_id` varchar(100) NOT NULL,
  `price` int(11) NOT NULL,
  `book_time` datetime DEFAULT NULL,
  `pay_time` datetime DEFAULT NULL,
  PRIMARY KEY (`ticket_id`,`user_id`,`seat_id`,`departure_station`,`train_id`,`arrival_station`),
  UNIQUE KEY `ticket_id_UNIQUE` (`ticket_id`),
  KEY `ticket_2_user_userID_fk_idx` (`user_id`),
  KEY `ticket_2_seatid_fk_idx` (`seat_id`),
  KEY `departure_station_fk_idx` (`departure_station`,`train_id`),
  KEY `arrival_station_fk_idx` (`arrival_station`),
  CONSTRAINT `arrival_station_fk` FOREIGN KEY (`arrival_station`) REFERENCES `Station` (`station_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `departure_station_fk` FOREIGN KEY (`departure_station`, `train_id`) REFERENCES `Train` (`departure_station`, `train_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ticket_2_seatid_fk` FOREIGN KEY (`seat_id`) REFERENCES `Seat` (`seat_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ticket_2_user_userID_fk` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ticket`
--

LOCK TABLES `Ticket` WRITE;
/*!40000 ALTER TABLE `Ticket` DISABLE KEYS */;
INSERT INTO `Ticket` VALUES (1,1,'2020-06-10 00:00:00',1,1,2,'1D',200,'2020-06-10 07:00:00','2020-06-10 07:15:00'),(2,1,'2020-06-10 00:00:00',1,2,5,'3B',1200,'2020-06-10 07:00:00','2020-06-10 07:15:00'),(3,2,'2020-06-10 00:00:00',2,2,5,'2A',1200,'2020-06-10 07:00:00','2020-06-10 07:15:00'),(4,2,'2020-06-12 00:00:00',2,3,4,'2A',400,'2020-06-11 17:30:00','2020-06-11 17:35:00'),(5,3,'2020-06-13 00:00:00',3,1,5,'3D',1400,'2020-06-12 20:30:00','2020-06-13 07:35:00'),(6,4,'2020-06-13 00:00:00',3,2,3,'4B',100,'2020-06-12 14:30:00','2020-06-12 17:35:00'),(7,5,'2020-06-15 00:00:00',4,5,2,'1A',1200,'2020-06-15 10:22:00',NULL),(8,6,'2020-06-15 00:00:00',4,5,1,'2A',1400,'2020-06-11 17:30:00','2020-06-11 17:35:00'),(9,7,'2020-06-16 00:00:00',5,4,2,'5A',500,'2020-06-12 10:31:00',NULL),(10,7,'2020-06-16 00:00:00',5,4,2,'5B',500,'2020-06-11 10:31:00',NULL),(11,7,'2020-06-16 00:00:00',5,4,2,'5C',500,'2020-06-11 10:31:00','2020-06-11 11:35:00'),(12,8,'2020-06-16 00:00:00',6,3,2,'6C',500,'2020-06-16 10:30:00','2020-06-16 10:36:00');
/*!40000 ALTER TABLE `Ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Train`
--

DROP TABLE IF EXISTS `Train`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Train` (
  `train_id` int(11) NOT NULL,
  `arrival_time` time DEFAULT NULL,
  `departure_time` time DEFAULT NULL,
  `departure_station` int(11) NOT NULL,
  `off_date` datetime DEFAULT NULL,
  `on_date` datetime DEFAULT NULL,
  PRIMARY KEY (`train_id`,`departure_station`),
  KEY `train_2_station_idx` (`departure_station`),
  CONSTRAINT `train_2_station` FOREIGN KEY (`departure_station`) REFERENCES `Station` (`station_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Train`
--

LOCK TABLES `Train` WRITE;
/*!40000 ALTER TABLE `Train` DISABLE KEYS */;
INSERT INTO `Train` VALUES (1,NULL,'07:00:00',1,'2020-06-17 00:00:00','2020-01-01 00:00:00'),(1,'07:20:00','07:22:00',2,'2020-06-17 00:00:00','2020-01-01 00:00:00'),(1,'07:32:00','07:34:00',3,'2020-06-17 00:00:00','2020-01-01 00:00:00'),(1,'08:04:00','08:06:00',4,'2020-06-17 00:00:00','2020-01-01 00:00:00'),(1,'09:06:00',NULL,5,'2020-06-17 00:00:00','2020-01-01 00:00:00'),(2,NULL,'10:00:00',1,'2020-06-30 00:00:00','2020-01-01 00:00:00'),(2,'10:20:00','10:22:00',2,'2020-06-30 00:00:00','2020-01-01 00:00:00'),(2,'10:32:00','10:34:00',3,'2020-06-30 00:00:00','2020-01-01 00:00:00'),(2,'11:04:00',NULL,4,'2020-06-30 00:00:00','2020-01-01 00:00:00'),(3,NULL,'13:00:00',1,NULL,'2020-02-01 00:00:00'),(3,'13:20:00','13:22:00',2,NULL,'2020-02-01 00:00:00'),(3,'13:32:00','13:34:00',3,NULL,'2020-02-01 00:00:00'),(3,'14:04:00','14:06:00',4,NULL,'2020-02-01 00:00:00'),(3,'15:06:00',NULL,5,NULL,'2020-02-01 00:00:00'),(4,'10:06:00',NULL,1,NULL,'2020-02-01 00:00:00'),(4,'09:44:00','09:46:00',2,NULL,'2020-02-01 00:00:00'),(4,'09:32:00','09:34:00',3,NULL,'2020-02-01 00:00:00'),(4,'09:00:00','09:02:00',4,NULL,'2020-02-01 00:00:00'),(4,NULL,'08:00:00',5,NULL,'2020-02-01 00:00:00'),(5,'13:04:00',NULL,1,NULL,'2020-02-01 00:00:00'),(5,'12:42:00','12:44:00',2,NULL,'2020-02-01 00:00:00'),(5,'12:30:00','12:32:00',3,NULL,'2020-02-01 00:00:00'),(5,NULL,'12:00:00',4,NULL,'2020-02-01 00:00:00'),(6,'19:06:00',NULL,1,NULL,'2020-01-01 00:00:00'),(6,'18:44:00','18:46:00',2,NULL,'2020-01-01 00:00:00'),(6,'18:32:00','18:34:00',3,NULL,'2020-01-01 00:00:00'),(6,'18:00:00','18:02:00',4,NULL,'2020-01-01 00:00:00'),(6,NULL,'17:00:00',5,NULL,'2020-01-01 00:00:00');
/*!40000 ALTER TABLE `Train` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `User` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `dob` datetime NOT NULL,
  `salt` char(255) NOT NULL,
  `registerDateTime` datetime NOT NULL,
  `isDelete` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `User_id_UNIQUE` (`user_id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `salt_UNIQUE` (`salt`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,'Marvel_Steve@gmail.com','Steve','Rogers','1918-07-04 00:00:00','63652315D22919A8EC76F58F982EC08A6244474F8082B8E75A1271B3C63948E9','2019-06-06 00:00:00',NULL),(2,'Marvel_Tony@gmail.com','Tony','Stark','1970-05-29 00:00:00','AA52032EAB8CC92F7B77CCE828940F95C2369F18DDF1C6B3A80A8A6195D137FB','2019-06-07 00:00:00',NULL),(3,'Marvel_Thor@gmail.com','Thor','God','1911-01-01 00:00:00','3C567E0EA40F26755BB221C96AB02CC726DE673E85016EC1D949D14E5B16B223','2019-06-08 00:00:00',NULL),(4,'Marvel_Peter@gmail.com','Peter','Parker','2000-08-10 00:00:00','95B79B147E492681F98C749E3AC329C1A975D3F4000FF25D0643D8D55A4E4E2B','2019-06-09 00:00:00',NULL),(5,'Marvel_David @gmail.com','David','Banner','1980-11-22 00:00:00','EB7F11AE33003238D3FF14094E3BC569F077B8F39DF472423FD339CE22B5F050','2019-06-10 00:00:00',NULL),(6,'Marvel_Natasha@gmail.com','Natasha','Romanoff','1984-11-22 00:00:00','5F79D14FB8A43CA9350E781EA1067B14B197D36671182C4C15E9EDBD921791DD','2019-06-11 00:00:00',NULL),(7,'Marvel_Wanda@gmail.com','Wanda','Maximoff','1980-08-02 00:00:00','9C681B6D73E80D3C1F10E06BDEB48914ABE207ADA83405DC14485B6AD060C021','2019-06-12 00:00:00',NULL),(8,'Marvel_Carol@gmail.com','Carol','Danvers','1980-08-01 00:00:00','6C40F0CC5D46DCE7D1A0E1D118E0750A7874087FC7199DDA34D171131002DCA9','2019-06-13 00:00:00',NULL),(9,'Marvel_Stephen@gmail.com','Stephen','Strange','1930-07-01 00:00:00','039FB5567A6B559BE9999BF854BEF1699A14CB912AF431CCF90D9941900D8788','2019-06-14 00:00:00',NULL),(10,'Marvel_Clint@gmail.com','Clint','Barton','1971-01-07 00:00:00','ABC1523C0333408EFF2B8CCF4248A0B2175723EBC65C8D05940B9D434B7A39A2','2019-06-15 00:00:00',NULL);
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserCredential`
--

DROP TABLE IF EXISTS `UserCredential`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `UserCredential` (
  `userCredential` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `hashedPwd` char(255) NOT NULL,
  `createDateTime` datetime NOT NULL,
  `isDelete` int(11) DEFAULT NULL,
  PRIMARY KEY (`userCredential`,`user_id`),
  UNIQUE KEY `HashedPwd_UNIQUE` (`hashedPwd`),
  UNIQUE KEY `User_id_UNIQUE` (`user_id`),
  UNIQUE KEY `userCredential_UNIQUE` (`userCredential`),
  CONSTRAINT `User_2_UserCredential_fk` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserCredential`
--

LOCK TABLES `UserCredential` WRITE;
/*!40000 ALTER TABLE `UserCredential` DISABLE KEYS */;
INSERT INTO `UserCredential` VALUES (1,1,'pfNFnTx50OjhU','2019-06-06 00:00:00',NULL),(2,2,'brpgOmotwsnkA','2019-06-07 00:00:00',NULL),(3,3,'brCHXrfmx/hRs','2019-06-08 00:00:00',NULL),(4,4,'broklWTNGanYM','2019-06-09 00:00:00',NULL),(5,5,'brrQ/CUvMgDMI','2019-06-10 00:00:00',NULL),(6,6,'brCAXrfmx/hRs','2019-06-11 00:00:00',NULL),(7,7,'bretXExZ676DI','2019-06-12 00:00:00',NULL),(8,8,'brhAsn.S9pHfM','2019-06-13 00:00:00',NULL),(9,9,'brv2uIUQT8QN2','2019-06-14 00:00:00',NULL),(10,10,'brtnGNHRCIzXY','2019-06-15 00:00:00',NULL);
/*!40000 ALTER TABLE `UserCredential` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'db_105408525'
--
/*!50003 DROP PROCEDURE IF EXISTS `QueryTicket_forCall` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`105408525`@`192.168.56.1` PROCEDURE `QueryTicket_forCall`(
	in in_dep_time datetime, -- insert date and time ex : "2020/06/22 07:30:00"
	in in_dep_station int,
    in in_arr_station int
)
BEGIN
	set @quot = NULL ;
    drop table if exists `ticketQuery` ;
    
    create temporary table ticketQuery as
	select 	a.train_id, 
			a.departure_station as departure_station,
			b.departure_station as arrival_station,
			timestamp(date(in_dep_time), a.departure_time) as departure_time, 
			timestamp(date(in_dep_time), b.arrival_time) as arrival_time, 
			abs(c.diff) * 100 as price
	from       (select train_id, departure_time,  departure_station from Train
				where departure_station = in_dep_station and 
					  departure_time is not null and
                      current_timestamp() > on_date and
                      (current_timestamp() < off_date or off_date is null)
				order by train_id, arrival_time ) a 
	inner join (select train_id, arrival_time, departure_station from Train
				where departure_station = in_arr_station and 
					  arrival_time is not null and
                      current_timestamp() > on_date and
                      (current_timestamp() < off_date or off_date is null)
				order by train_id, arrival_time ) b
		on a.train_id = b.train_id 
	left join  (select station_id, location_marker - lag_marker as diff
				from (select *,@quot lag_marker, @quot:= location_marker curr_marker
					  from Station where station_id = in_dep_station or station_id = in_arr_station 
                      order by station_id) n
				where station_id = in_arr_station ) c
		on b.departure_station = c.station_id 
		having 	departure_time >= addtime(curtime(), "0 0:30:0") and 
				time(departure_time) >= CAST(in_dep_time as time) and 
				departure_time <= addtime(current_timestamp(), "13 0:0:0") ;
    /* Generate the table with train_id, dep/arr_station, dep/arr_time, price */
       
	if  /* if some seats were booked, then we have to filter which seat is not booked yet and 
		   merge it to the queryTicket table */
		exists (select train_id, train_date, seat_id 
				from db_105408525.Ticket 
				where train_date > current_timestamp() and train_date >= in_dep_time
				order by train_id, seat_id ) then
		
        drop table if exists `seat_tbl` ;
		
		create temporary table seat_tbl as
		select distinct a.train_id, a.seat_id as seat_id
		from		(select distinct(Train.train_id), Seat.seat_id 
					 from db_105408525.Train, db_105408525.Seat                  
					 order by train_id, seat_id) a -- all trains with all seats
		left join 	(select train_id, train_date, seat_id 
					 from db_105408525.Ticket 
					 order by train_id, seat_id) b -- trains and seats that are booked
			on a.train_id = b.train_id  and a.seat_id = b.seat_id
			-- filter the train that will depart in future and the same date to input departure date
        where train_date is null
		order by train_id, seat_id;
		/* Above is to generate the train that seat is not in the ticket  */
		
		/*  Below is to merge the two table above to add seat_id column into ticketQuery table */
		drop table if exists ticketQueryWithSeats ;
		
		create temporary table ticketQueryWithSeats as
		select 	a.train_id, a.departure_station, a.arrival_station, 
				b.seat_id, a.departure_time, a.arrival_time, a.price
		from ticketQuery a
		left join (select distinct * from seat_tbl) b
			on a.train_id = b.train_id
		where seat_id is not null 
		order by train_id, seat_id ; 
    
    else -- no tickets were booked then means every seats are available
		drop table if exists seat_tbl ;
		
		create temporary table seat_tbl as
		select distinct(Train.train_id), Seat.seat_id 
					from db_105408525.Train, db_105408525.Seat 
					order by train_id, seat_id ;

		drop table if exists ticketQueryWithSeats ;
		
		create temporary table ticketQueryWithSeats as
		select 	a.train_id, a.departure_station, a.arrival_station, 
				b.seat_id, a.departure_time, a.arrival_time, a.price
		from ticketQuery a
		left join (select distinct * from seat_tbl) b
			on a.train_id = b.train_id
		where seat_id is not null 
		order by train_id, seat_id ; 
    
    end if ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_BookTicket` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`105408525`@`192.168.56.1` PROCEDURE `sp_BookTicket`(
	in in_userID int,
    in in_email varchar(200),
    in in_train_id int, 
    in in_dep_station int,
    in in_arr_station int, 
    in in_train_date datetime, -- detail time of the train user selected
    out login_message varchar(250),
    out book_message varchar(250),
    out num_row int(10)
    
)
BEGIN
	declare sel_seat_id varchar(100) ;
    declare sel_dep_time varchar(100) ;
    declare sel_price double ;
    
    -- User has to login to book the ticket
    if exists ( select * from User where user_id = in_userID and email =  in_email) then 
		set login_message = (select " User Login succesfully, please start booking tickets" ) ;

		call db_105408525.QueryTicket_forCall(in_train_date, 
										      in_dep_station, 
										      in_arr_station) ;
	
    -- user pick the seat and train from the table generated by the `QueryTicket_forCall` procedure
 
		if exists (select * from ticketQueryWithSeats) then
        
			set sel_seat_id = (	select seat_id from ticketQueryWithSeats 
								where train_id = in_train_id limit 1 ) ;
			set sel_dep_time = (select departure_time from ticketQueryWithSeats 
								where train_id = in_train_id and seat_id = sel_seat_id limit 1 ) ;
			set sel_price = (select price from ticketQueryWithSeats 
							 where train_id = in_train_id and seat_id = sel_seat_id limit 1 ) ;
        
			insert into Ticket 
				values(null, in_userID, sel_dep_time, in_train_id, in_dep_station, in_arr_station, sel_seat_id, sel_price, current_timestamp(), null) ;
        
			drop table if exists `result_set` ;    
		
			create temporary table result_set as
			select * from Ticket 
			where user_id = in_userID and train_id = in_train_id and train_date = sel_dep_time and seat_id = sel_seat_id;
        
			select ticket_id, user_id, train_id, departure_station, arrival_station, seat_id, book_time, train_date
			from result_set ;
        
			set book_message = (select "Ticket Booked Succesfully") ;
            set num_row = (select count(*) from result_set) ;
		
        else 
			set book_message = (select "No Train is available" ) ;
            set num_row = (select 0) ;
        
		end if ;
	else 
		set login_message = (select "User not found") ;
        set book_message = (select "Please login user account for booking tickets" );
        set num_row = (select 0) ;
	
    end if ;
                                     
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_DeleteUserByUserID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`105408525`@`192.168.56.1` PROCEDURE `sp_DeleteUserByUserID`(
	in in_userID int(10),
    out affected_row_num int(100),
    out message varchar(100)
)
BEGIN
	if exists (select * from Ticket 
			   where user_id = in_userID and pay_time is null) then 
               -- User exists and the tickets are not paid
	   set message = (select "Cannot delete user due to unpaid tickets") ;
       set affected_row_num = 0 ;
	 else  
		-- Update User table 
		update User set isDelete = 1 where user_id = in_userID ;
        
        -- Update UserCredential table
		update UserCredential set isDelete = 1 where user_id = in_userID;
        
        set message = (select "User deleted!") ;
        set affected_row_num = (select count(*) from User where user_id = in_userID and isDelete = 1);
	
   end if ;     
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Delete_bookticket` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`105408525`@`192.168.56.1` PROCEDURE `sp_Delete_bookticket`(
	in in_userID int, 
    in in_ticketID int,
    out affected_row_num int(100),
    out message varchar(100)
)
BEGIN

    if exists (	select * from Ticket 
				where user_id = in_userID and ticket_id = in_ticketID and pay_time is null) then
    
		set @before_n = (select count(*) from Ticket 
						 where user_id = in_userID and ticket_id = in_ticketId and pay_time is null ) ;
		delete from Ticket where ticket_id = in_ticketID and user_id = in_userID and pay_time is null ;
        set @after_n = (select count(*) from Ticket
						where user_id = in_userID and ticket_id = in_ticketId and pay_time is null ) ;
                        
		set affected_row_num = @before_n - @after_n ;
        set message = "The selected unpaid ticket has been deleted." ; 
	elseif exists (select * from Ticket 
					where user_id = in_userID and ticket_id = in_ticketID and pay_time is not null) then
		set affected_row_num = 0 ;
        set message = "Tickets were paid, cannot be deleted." ; 
	else 
		set affected_row_num = 0 ;
        set message = "No Tickets were booked or tickets cannot be deleted." ;
        
	end if ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetBookTicketByUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`105408525`@`192.168.56.1` PROCEDURE `sp_GetBookTicketByUser`(
	in in_userID int,
    out num_row int(100)
)
BEGIN
	drop table if exists `result_set` ;
    
	create temporary table result_set as
    select ticket_id, user_id, train_id, seat_id, book_time
    from Ticket
    where user_id = in_userID and pay_time is null;
    
    select * from result_set ;
    
    set num_row = (select count(*) from result_set)  ;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetStation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`105408525`@`192.168.56.1` PROCEDURE `sp_GetStation`(
	out num_of_row int
)
BEGIN
	select station_id as station_id, station_name as station_name 
    from db_105408525.Station 
    order by station_id ;
    
    set num_of_row = (select count(*) from db_105408525.Station) ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_PayTicket` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`105408525`@`192.168.56.1` PROCEDURE `sp_PayTicket`(
	in in_userID int,
    in in_ticketID int,
    out affected_row_num int,
    out message varchar(200)
)
BEGIN
	declare currentTime datetime ;
    declare before_n int ;
    declare after_n int ;
    
    set currentTime = current_timestamp()  ;	
    
	if exists ( -- Tickets that are booked but haven't been paid within 3 days
				select * from Ticket 
				where user_id = in_userID and 
					  in_ticketID and
					  pay_time is null and
					  currentTime >= timestamp(date(addtime(book_time, "2 0:0:0")), "23:59:59")) then 
                      -- payment must be done in 3 days
                      
        -- Count rows before delete               
		set before_n  = (select count(*) 
						 from Ticket 
						 where user_id = in_userID and 
                         ticket_id = in_ticketID and
						 pay_time is null and
						 currentTime >= timestamp(date(addtime(book_time, "2 0:0:0")), "23:59:59")) ;
         
		delete from Ticket 
			where user_id = in_userID and 
				  ticket_id = in_ticketID and
				  pay_time is null and
				  currentTime > timestamp(date(addtime(book_time, "2 0:0:0")), "23:59:59") ;
        -- Count rows after delete           
		set after_n = (select count(*) 
					   from Ticket 
					   where user_id = in_userID and 
                       ticket_id = in_ticketID and
					   pay_time is null and
					   currentTime >= timestamp(date(addtime(book_time, "2 0:0:0")), "23:59:59")); 
        
		set message = (select "Tickets were deleted because of not being paid within three days" ) ;
        set affected_row_num = before_n - after_n ; 
        
	elseif not exists ( -- no unpaid tickets
						 select * from Ticket 
						 where user_id = in_userID and 
                         ticket_id = in_ticketID and
						 pay_time is null and
                         currentTime <= timestamp(date(addtime(book_time, "2 0:0:0")), "23:59:59")) then
		set message = (select "No Tickets need to pay" ) ;
        set affected_row_num  = ( select 0 );
	else 
		update Ticket set pay_time = currentTime 
			where user_id = in_userID and 
				  ticket_id = in_ticketID and
				  pay_time is null;
                  
		set message = (select "Tickets have been paid") ;
        
        set affected_row_num = (select count(*) from Ticket
								where user_id = in_userID and 
								ticket_id = in_ticketID and
								pay_time = currentTime and 
                                departure_time >= addtime(current_time, "0:30:00"));
    end if ;
    
    select	a.ticket_id, a.user_id, a.train_id, 
			a.departure_station, a.arrival_station, 
            a.seat_id, a.book_time, a.train_date as departure_time, 
            timestamp(date(a.train_date), time(b.arrival_time)) as arrival_time, 
            a.price, a.pay_time
    from Ticket a
	left join Train b 
		on 	a.train_id = b.train_id and 
            a.arrival_station = b.departure_station
	where ticket_id = in_ticketID and 
		  user_id = in_userID and 
          departure_time >= addtime(current_time, "0:30:00");
		
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_QueryTicket` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`105408525`@`192.168.56.1` PROCEDURE `sp_QueryTicket`(
	in in_dep_time datetime, -- insert date and time ex : "2020/06/22 07:30:00"
	in in_dep_station int,
    in in_arr_station int,
    out num_row int(10)
)
BEGIN
	set @quot = NULL ;
    drop table if exists `ticketQuery` ;
    
    create temporary table ticketQuery as
	select 	a.train_id, 
			a.departure_station as departure_station,
			b.departure_station as arrival_station,
			timestamp(date(in_dep_time), a.departure_time) as departure_time, 
			timestamp(date(in_dep_time), b.arrival_time) as arrival_time, 
			abs(c.diff) * 100 as price
	from       (select train_id, departure_time,  departure_station from Train
				where departure_station = in_dep_station and 
					  departure_time is not null and
                      current_timestamp() > on_date and
                      (current_timestamp() < off_date or off_date is null)
				order by train_id, arrival_time ) a 
	inner join (select train_id, arrival_time, departure_station from Train
				where departure_station = in_arr_station and 
					  arrival_time is not null and
                      current_timestamp() > on_date and
                      (current_timestamp() < off_date or off_date is null)
				order by train_id, arrival_time ) b
		on a.train_id = b.train_id 
	left join  (select station_id, location_marker - lag_marker as diff
				from (select *,@quot lag_marker, @quot:= location_marker curr_marker
					  from Station where station_id = in_dep_station or station_id = in_arr_station 
                      order by station_id) n
				where station_id = in_arr_station ) c
		on b.departure_station = c.station_id 
		having 	departure_time >= addtime(curtime(), "0 0:30:0") and 
				time(departure_time) >= CAST(in_dep_time as time) and 
				departure_time <= addtime(current_timestamp(), "13 0:0:0") ;
    /* Generate the table with train_id, dep/arr_station, dep/arr_time, price */
       
	if  /* if some seats were booked, then we have to filter which seat is not booked yet and 
		   merge it to the queryTicket table */
		exists (select train_id, train_date, seat_id 
				from db_105408525.Ticket 
				where train_date > current_timestamp() and train_date >= in_dep_time
				order by train_id, seat_id ) then
		
        drop table if exists `seat_tbl` ;
		
		create temporary table seat_tbl as
		select distinct a.train_id, a.seat_id as seat_id
		from		(select distinct(Train.train_id), Seat.seat_id 
					 from db_105408525.Train, db_105408525.Seat                  
					 order by train_id, seat_id) a -- all trains with all seats
		left join 	(select train_id, train_date, seat_id 
					 from db_105408525.Ticket 
					 order by train_id, seat_id) b -- trains and seats that are booked
			on a.train_id = b.train_id  and a.seat_id = b.seat_id
			-- filter the train that will depart in future and the same date to input departure date
        where train_date is null
		order by train_id, seat_id;
		/* Above is to generate the train that seat is not in the ticket  */
		
		/*  Below is to merge the two table above to add seat_id column into ticketQuery table */
		drop table if exists ticketQueryWithSeats ;
		
		create temporary table ticketQueryWithSeats as
		select 	a.train_id, a.departure_station, a.arrival_station, 
				b.seat_id, a.departure_time, a.arrival_time, a.price
		from ticketQuery a
		left join (select distinct * from seat_tbl) b
			on a.train_id = b.train_id
		where seat_id is not null 
		order by train_id, seat_id ; 
    
    else -- no tickets were booked then means every seats are available
		drop table if exists seat_tbl ;
		
		create temporary table seat_tbl as
		select distinct(Train.train_id), Seat.seat_id 
					from db_105408525.Train, db_105408525.Seat 
					order by train_id, seat_id ;

		drop table if exists ticketQueryWithSeats ;
		
		create temporary table ticketQueryWithSeats as
		select 	a.train_id, a.departure_station, a.arrival_station, 
				b.seat_id, a.departure_time, a.arrival_time, a.price
		from ticketQuery a
		left join (select distinct * from seat_tbl) b
			on a.train_id = b.train_id
		where seat_id is not null 
		order by train_id, seat_id ; 
    
    end if ;
    
    drop table if exists `result_set` ;
    
    create temporary table result_set as 
    select distinct train_id, departure_station, arrival_station,
					departure_time, arrival_time, price 
	from ticketQueryWithSeats 
    where date(departure_time) = date(in_dep_time) ;
    
    select * from result_set ;
    
	set num_row = (	select count(*) from result_set) ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_QueryTicketWithSeatManagement` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`105408525`@`192.168.56.1` PROCEDURE `sp_QueryTicketWithSeatManagement`(
	in in_dep_time datetime,
    in in_dep_station int,
    in in_arr_station int,
    out num_row int(100)
)
BEGIN
	set @quot = NULL ;
	drop table if exists `ticketQuery` ;
	
	create temporary table ticketQuery as
	select 	a.train_id, 
			a.departure_station as departure_station,
			b.departure_station as arrival_station,
			timestamp(date(in_dep_time), a.departure_time) as departure_time, 
			timestamp(date(in_dep_time), b.arrival_time) as arrival_time, 
			abs(c.diff) * 100 as price
	from       (select train_id, departure_time,  departure_station from Train
				where departure_station = in_dep_station and 
					  departure_time is not null and
					  current_timestamp() > on_date and
					  (current_timestamp() < off_date or off_date is null)
				order by train_id, arrival_time ) a 
	inner join (select train_id, arrival_time, departure_station from Train
				where departure_station = in_arr_station and 
					  arrival_time is not null and
					  current_timestamp() > on_date and
					  (current_timestamp() < off_date or off_date is null)
				order by train_id, arrival_time ) b
		on a.train_id = b.train_id 
	left join  (select station_id, location_marker - lag_marker as diff
				from (select *,@quot lag_marker, @quot:= location_marker curr_marker
					  from Station where station_id = in_dep_station or station_id = in_arr_station 
					  order by station_id) n
				where station_id = in_arr_station ) c
		on b.departure_station = c.station_id 
	having 		departure_time >= addtime(curtime(), "0 0:30:0") and 
				time(departure_time) >= CAST(in_dep_time as time) and 
		 		departure_time <= addtime(current_timestamp(), "13 0:0:0") ;
	/* Generate the table with train_id, dep/arr_station, dep/arr_time, price */
	   
	if  in_dep_station > in_arr_station then -- go north
        
		if  exists ( -- Tickets are booked
					select train_id, train_date, seat_id 
					from db_105408525.Ticket 
					where 	train_date >= current_timestamp() and 
							train_date >= in_dep_time and 
							in_arr_station < departure_station and 
							in_dep_station > arrival_station
					order by train_id, seat_id ) then
			
            /* generate the train that seat is not occupied */
            drop table if exists `seat_tbl` ;
			create temporary table seat_tbl as
			select distinct a.train_id, a.seat_id as seat_id
			from		(select distinct(Train.train_id), Seat.seat_id 
						 from db_105408525.Train, db_105408525.Seat                  
						 order by train_id, seat_id) a -- all trains with all seats
			left join 	(select train_id, train_date, seat_id 
						 from db_105408525.Ticket 
						 order by train_id, seat_id) b -- trains and seats that are booked
				on a.train_id = b.train_id  and a.seat_id = b.seat_id
				-- filter the train that will depart in future and the same date to input departure date
			where train_date is null 
			order by train_id, seat_id;
		
        else  -- no tickets are  booked
			drop table if exists seat_tbl ;
		
			create temporary table seat_tbl as
			select distinct(Train.train_id), Seat.seat_id 
						from db_105408525.Train, db_105408525.Seat 
						order by train_id, seat_id ;
        end if ;
	else -- go south
		if  exists ( -- Tickets are booked
					select train_id, train_date, seat_id 
					from db_105408525.Ticket 
					where 	train_date >= current_timestamp() and 
							train_date >= in_dep_time and 
							in_arr_station > departure_station and 
							in_dep_station < arrival_station
					order by train_id, seat_id ) then
            /* generate the train that seat is not occupied */
            drop table if exists `seat_tbl` ;
			create temporary table seat_tbl as
			select distinct a.train_id, a.seat_id as seat_id
			from		(select distinct(Train.train_id), Seat.seat_id 
						 from db_105408525.Train, db_105408525.Seat                  
						 order by train_id, seat_id) a -- all trains with all seats
			left join 	(select train_id, train_date, seat_id 
						 from db_105408525.Ticket 
						 order by train_id, seat_id) b -- trains and seats that are booked
				on a.train_id = b.train_id  and a.seat_id = b.seat_id
				-- filter the train that will depart in future and the same date to input departure date
			where train_date is null 
			order by train_id, seat_id;	
        else  -- no tickets are  booked
			drop table if exists seat_tbl ;
		
			create temporary table seat_tbl as
			select distinct(Train.train_id), Seat.seat_id 
						from db_105408525.Train, db_105408525.Seat 
						order by train_id, seat_id ;
		end if ;
    end if ;
	
    drop table if exists ticketQueryWithSeats ;
			
	create temporary table ticketQueryWithSeats as
	select 	a.train_id, a.departure_station, a.arrival_station, 
			b.seat_id, a.departure_time, a.arrival_time, a.price
	from ticketQuery a
	left join (select distinct * from seat_tbl) b
		on a.train_id = b.train_id
	where seat_id is not null 
	order by train_id, seat_id ; 
    
    select * from ticketQueryWithSeats ;
	set num_row = (select count(*) from ticketQueryWithSeats) ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_RegisterUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`105408525`@`192.168.56.1` PROCEDURE `sp_RegisterUser`(
    in in_email varchar(100),
    in in_firstname varchar(100),
    in in_lastname varchar(100),
    in in_Dob date,
    in in_salt char(255),
    in in_hashedPwd char(255),
    out row_num int(100) 
)
BEGIN
	declare new_userID int(10) ;
    declare new_user_register_time datetime ;
    
	if exists(select user_id from User where email = in_email) THEN
		select 1;
	else
		insert into User 
			values(NULL, in_email, in_firstname, in_lastname, in_Dob,
					in_salt, current_timestamp(), NULL) ;
	end if;       
    
	if exists (select * from User where email = in_email) then
		set @new_userID = (select user_id from User where email = in_email ) ;
        set @new_user_register_time = (select registerDateTime from User where email = in_email) ;
        
        insert into UserCredential 
			values(Null, @new_userID,  in_hashedPwd, @new_user_register_time) ; 
	else
		select 1 ;
	
    end if ;

    set row_num = (select _user_id from User where email = in_email) ;
	
    
    
	-- select @affected_row_num := count(*) as affected_row_num from User where email = in_email ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ResetNewPassword` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`105408525`@`192.168.56.1` PROCEDURE `sp_ResetNewPassword`(
	in in_userID int(10),
    in in_salt char(255),
    in in_hashedPwd char(255),
    out affected_row_num int(100),
    out message varchar(200)
)
BEGIN
    -- If password doesn't change: do nothing
	if exists ( select * from UserCredential where hashedPwd = in_hashedPwd) then
		select affected_row_num = 0 ;
        set message = (select "Password unchanged, please choose a different password." ) ;
	-- If user not exists: do nothing
	elseif not exists( select * from User where user_id = in_userID ) then
		select affected_row_num = 0 ;
        set message = (select "User Not Found!");
	else 
		update User 
			set salt = in_salt 
            where user_id = in_userID ;
            
		update UserCredential 
			set hashedPwd = in_hashedPwd,
				createDateTime = current_timestamp() 
			where user_id = in_userID ;
		set affected_row_num = (select count(*) from User where user_id = in_userID) ;
        set message = (select "Password Changed") ;
	end if ;
    
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_TrainManagement` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`105408525`@`192.168.56.1` PROCEDURE `sp_TrainManagement`(
	in in_trainID int,
    in in_off_date date,
    in in_dep_time time, 
    in in_dep_station int,
    in in_arr_station int,
    in in_on_date date,
    out affected_row_num int(100)
)
BEGIN
	declare new_station_row_num int ;
    declare iter int default 1 ;
    declare new_train_id int ;
    declare previous_dep_time time ;
    declare need_time int ;
    
	-- Change old train.off_date to in_off_date
	update Train set off_date = in_off_date where train_id = in_trainID ;
    
    if in_dep_station > in_arr_station then -- go north
		set @quot = (select time_marker from Station where station_id = in_arr_station );
        -- Generate the Station table only contain in_dep_station and in_arr_station
        
        drop table if exists `go_north` ;
		create temporary table `go_north` as 
		select station_id, station_name ,@quot lag_marker, @quot:= time_marker curr_time_marker
		from Station where station_id >= in_arr_station and in_dep_station >= station_id 
		order by station_id ;
        
        drop table if exists `new_station` ;
        create temporary table new_station as 
        select station_id, station_name, curr_time_marker - lag_marker as marker_diff from go_north ;
	else -- go south
		set @quot = (select time_marker from Station where station_id = in_arr_station );
        -- Generate the Station table only contain in_dep_station and in_arr_station
        
        drop table if exists `go_south` ;
		create temporary table `go_south` as 
		select station_id, station_name ,@quot lag_marker, @quot:= time_marker curr_time_marker
		from Station where station_id >= in_dep_station and in_arr_station >= station_id 
		order by station_id desc;
        
        drop table if exists `new_station` ;
        create temporary table new_station as 
        select station_id, station_name, lag_marker - curr_time_marker as marker_diff from go_south;
 	
	end if ;
    /*
    drop table if exists `new_train` ;
	create table if not exists `new_train` (
	  `train_id` INT NOT NULL,
	  `arrival_time` TIME NULL,
	  `departure_time` TIME NULL,
	  `departure_station` INT NOT NULL,
	  `off_date` DATETIME NULL,
	  `on_date` DATETIME NULL,
	  PRIMARY KEY (`train_id`, `departure_station`),
	  INDEX `train_2_station_idx` (`departure_station` ASC))
	ENGINE = InnoDB;
    */
    set new_station_row_num = (select count(*) from new_station) ; -- Total Station that the new train will go through
    set new_train_id = (select max(train_id) from Train limit 1 ) + 1; -- The next train_id
    
    while iter <= new_station_row_num do
		if in_dep_station > in_arr_station then-- go north
			if iter = 1 then -- the departure station information 
				insert into Train
					values(new_train_id, null, in_dep_time, in_dep_station, null, in_on_date) ; 
				set previous_dep_time = (select departure_time from Train where train_id = new_train_id and departure_station = in_dep_station) ;
				set need_time = (select marker_diff from new_station where station_id = in_dep_station ) ;
                set iter = iter + 1 ;
			elseif iter > 1 and iter < new_station_row_num then -- stations passed
				insert into Train
					values(	new_train_id, previous_dep_time + interval need_time minute, previous_dep_time + interval need_time + 2 minute,
							in_dep_station - (iter - 1), null, in_on_date ) ;
				set previous_dep_time = (select departure_time from Train where train_id = new_train_id and departure_station = in_dep_station - (iter - 1)) ;
				set need_time = (select marker_diff from new_station where station_id = in_dep_station - (iter - 1) ) ;
				set iter = iter + 1 ;
			elseif iter = new_station_row_num then -- arrival_station
				insert into Train
					values(	new_train_id, previous_dep_time + interval need_time minute, null,
							in_arr_station, null, in_on_date ) ;
				set iter = iter + 1 ;
			end if ;
		else -- go south
			if iter = 1 then -- the departure station information 
				insert into Train
					values(new_train_id, null, in_dep_time, in_dep_station, null, in_on_date) ; 
				set previous_dep_time = (select departure_time from Train where train_id = new_train_id and departure_station = in_dep_station) ;
				set need_time = (select marker_diff from new_station where station_id = in_dep_station  ) ;
                set iter = iter + 1 ;
			elseif iter > 1 and iter < new_station_row_num then -- stations passed
				insert into Train
					values(	new_train_id, previous_dep_time + interval need_time minute, previous_dep_time + interval need_time + 2 minute,
							in_dep_station + (iter - 1), null, in_on_date ) ;
				set previous_dep_time = (select departure_time from Train where train_id = new_train_id and departure_station = in_dep_station + (iter - 1)) ;
				set need_time = (select marker_diff from new_station where station_id = in_dep_station + (iter - 1)) ;
				set iter = iter + 1 ;
			elseif iter = new_station_row_num then
				insert into Train
					values(	new_train_id, previous_dep_time + interval need_time minute, null,
							in_arr_station, null, in_on_date ) ;
                set iter = iter + 1 ;
			end if ;
		end if ;
	end while ;
    
    set affected_row_num = (select count(*) from Train where train_id = new_train_id ) + -- new train 
						   (select count(*) from Train where train_id = in_trainID) ; -- old train
    
	select 	a.train_id, 
			a.departure_time,
            b.arrival_time,
			a.departure_station as departure_station,
			b.departure_station as arrival_station,
            a.on_date,
            a.off_date
	from       (select train_id, departure_time,  departure_station, on_date, off_date from Train
				where departure_station = in_dep_station and 
					  departure_time is not null
				order by train_id, arrival_time ) a 
	inner join (select train_id, arrival_time, departure_station from Train
				where departure_station = in_arr_station and 
					  arrival_time is not null
				order by train_id, arrival_time ) b
		on a.train_id = b.train_id 
	having train_id = new_train_id;
        
        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UserLogin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`105408525`@`192.168.56.1` PROCEDURE `sp_UserLogin`(
	in in_email varchar(200),
    in in_hashedPwd char(200),
    out row_num int(100),
    out login_status varchar(100)
)
BEGIN
	if exists (select *, b.hashedPwd
			   from User a left join UserCredential b 
			   on a.user_id = b.user_id
			   where email = in_email and hashedPwd = in_hashedPwd) then
		set row_num = (select a.user_id 
					   from User a left join UserCredential b 
                       on a.user_id = b.user_id
					   where email = in_email and hashedPwd = in_hashedPwd ); 
		set login_status = (select "Login Succesfully");
	else 
		set login_status = (select "Nonexistent E-mail or invalid password") ;
	end if ;
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

-- Dump completed on 2020-06-26 13:48:10

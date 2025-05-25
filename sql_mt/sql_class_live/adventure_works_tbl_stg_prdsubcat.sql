-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: adventure_works
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tbl_stg_prdsubcat`
--

DROP TABLE IF EXISTS `tbl_stg_prdsubcat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_stg_prdsubcat` (
  `ProductSubcategoryKey` bigint DEFAULT NULL,
  `SubcategoryName` text,
  `ProductCategoryKey` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_stg_prdsubcat`
--

LOCK TABLES `tbl_stg_prdsubcat` WRITE;
/*!40000 ALTER TABLE `tbl_stg_prdsubcat` DISABLE KEYS */;
INSERT INTO `tbl_stg_prdsubcat` VALUES (1,'Mountain Bikes',1),(2,'Road Bikes',1),(3,'Touring Bikes',1),(4,'Handlebars',2),(5,'Bottom Brackets',2),(6,'Brakes',2),(7,'Chains',2),(8,'Cranksets',2),(9,'Derailleurs',2),(10,'Forks',2),(11,'Headsets',2),(12,'Mountain Frames',2),(13,'Pedals',2),(14,'Road Frames',2),(15,'Saddles',2),(16,'Touring Frames',2),(17,'Wheels',2),(18,'Bib-Shorts',3),(19,'Caps',3),(20,'Gloves',3),(21,'Jerseys',3),(22,'Shorts',3),(23,'Socks',3),(24,'Tights',3),(25,'Vests',3),(26,'Bike Racks',4),(27,'Bike Stands',4),(28,'Bottles and Cages',4),(29,'Cleaners',4),(30,'Fenders',4),(31,'Helmets',4),(32,'Hydration Packs',4),(33,'Lights',4),(34,'Locks',4),(35,'Panniers',4),(36,'Pumps',4),(37,'Tires and Tubes',4);
/*!40000 ALTER TABLE `tbl_stg_prdsubcat` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-23  8:43:41

CREATE DATABASE  IF NOT EXISTS `library_system` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `library_system`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: library_system
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `isbn` varchar(255) NOT NULL,
  `book_title` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `rental_price` decimal(6,2) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `publisher` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`isbn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES ('978-0-06-025492-6','Where the Wild Things Are','Children',3.50,'yes','Maurice Sendak','HarperCollins'),('978-0-06-112008-4','To Kill a Mockingbird','Classic',5.00,'yes','Harper Lee','J.B. Lippincott & Co.'),('978-0-06-112241-5','The Kite Runner','Fiction',5.50,'yes','Khaled Hosseini','Riverhead Books'),('978-0-06-440055-8','Charlotte\'s Web','Children',4.00,'yes','E.B. White','Harper & Row'),('978-0-09-957807-9','A Game of Thrones','Fantasy',7.50,'yes','George R.R. Martin','Bantam'),('978-0-14-027526-3','A Tale of Two Cities','Classic',4.50,'yes','Charles Dickens','Penguin Books'),('978-0-14-044930-3','The Histories','History',5.50,'yes','Herodotus','Penguin Classics'),('978-0-14-118776-1','One Hundred Years of Solitude','Literary Fiction',6.50,'yes','Gabriel Garcia Marquez','Penguin Books'),('978-0-14-143951-8','Pride and Prejudice','Classic',5.00,'yes','Jane Austen','Penguin Classics'),('978-0-141-44171-6','Jane Eyre','Classic',4.00,'yes','Charlotte Bronte','Penguin Classics'),('978-0-19-280551-1','The Guns of August','History',7.00,'yes','Barbara W. Tuchman','Oxford University Press'),('978-0-307-37840-1','The Alchemist','Fiction',2.50,'yes','Paulo Coelho','HarperOne'),('978-0-307-58837-1','Sapiens: A Brief History of Humankind','History',8.00,'no','Yuval Noah Harari','Harper Perennial'),('978-0-330-25864-8','Animal Farm','Classic',5.50,'yes','George Orwell','Penguin Books'),('978-0-345-39180-3','Dune','Science Fiction',8.50,'yes','Frank Herbert','Ace'),('978-0-375-41398-8','The Diary of a Young Girl','History',6.50,'no','Anne Frank','Bantam'),('978-0-375-50167-0','The Road','Dystopian',7.00,'yes','Cormac McCarthy','Vintage'),('978-0-385-33312-0','The Shining','Horror',6.00,'yes','Stephen King','Doubleday'),('978-0-393-05081-8','A Peoples History of the United States','History',9.00,'yes','Howard Zinn','Harper Perennial'),('978-0-393-91257-8','Guns, Germs, and Steel: The Fates of Human Societies','History',7.00,'yes','Jared Diamond','W. W. Norton & Company'),('978-0-451-52993-5','Fahrenheit 451','Dystopian',5.50,'yes','Ray Bradbury','Ballantine Books'),('978-0-451-52994-2','Moby Dick','Classic',6.50,'yes','Herman Melville','Penguin Books'),('978-0-452-28240-7','Brave New World','Dystopian',6.50,'yes','Aldous Huxley','Harper Perennial'),('978-0-525-47535-5','The Great Gatsby','Classic',8.00,'yes','F. Scott Fitzgerald','Scribner'),('978-0-553-29698-2','The Catcher in the Rye','Classic',7.00,'yes','J.D. Salinger','Little, Brown and Company'),('978-0-553-57340-1','1984','Dystopian',6.50,'yes','George Orwell','Penguin Books'),('978-0-670-81302-4','The Road','Dystopian',7.00,'yes','Cormac McCarthy','Knopf'),('978-0-679-64115-3','1984','Dystopian',6.50,'yes','George Orwell','Penguin Books'),('978-0-679-76489-8','Harry Potter and the Sorcerers Stone','Fantasy',7.00,'yes','J.K. Rowling','Scholastic'),('978-0-679-77644-3','Beloved','Fiction',6.50,'yes','Toni Morrison','Knopf'),('978-0-7432-4722-4','The Da Vinci Code','Mystery',8.00,'yes','Dan Brown','Doubleday'),('978-0-7432-4722-5','Angels & Demons','Mystery',7.50,'yes','Dan Brown','Doubleday'),('978-0-7432-7356-4','The Hobbit','Fantasy',7.00,'yes','J.R.R. Tolkien','Houghton Mifflin Harcourt'),('978-0-7432-7357-1','1491: New Revelations of the Americas Before Columbus','History',6.50,'no','Charles C. Mann','Vintage Books'),('978-0-7434-7679-3','The Stand','Horror',7.00,'yes','Stephen King','Doubleday');
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branch` (
  `branch_id` varchar(50) NOT NULL,
  `manager_id` varchar(50) DEFAULT NULL,
  `branch_address` varchar(255) DEFAULT NULL,
  `contact_on` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch`
--

LOCK TABLES `branch` WRITE;
/*!40000 ALTER TABLE `branch` DISABLE KEYS */;
INSERT INTO `branch` VALUES ('B001','E109','123 Main St','919099988676'),('B002','E109','456 Elm St','919099988677'),('B003','E109','789 Oak St','919099988678'),('B004','E110','567 Pine St','919099988679'),('B005','E110','890 Maple St','919099988680');
/*!40000 ALTER TABLE `branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employe`
--

DROP TABLE IF EXISTS `employe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employe` (
  `emp_id` varchar(50) NOT NULL,
  `emp_name` varchar(100) DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL,
  `salary` int DEFAULT NULL,
  `branch_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`emp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employe`
--

LOCK TABLES `employe` WRITE;
/*!40000 ALTER TABLE `employe` DISABLE KEYS */;
INSERT INTO `employe` VALUES ('E101','John Doe','Clerk',60000,'B001'),('E102','Jane Smith','Clerk',45000,'B002'),('E103','Mike Johnson','Librarian',55000,'B001'),('E104','Emily Davis','Assistant',40000,'B001'),('E105','Sarah Brown','Assistant',42000,'B001'),('E106','Michelle Ramirez','Assistant',43000,'B001'),('E107','Michael Thompson','Clerk',62000,'B005'),('E108','Jessica Taylor','Clerk',46000,'B004'),('E109','Daniel Anderson','Manager',57000,'B003'),('E110','Laura Martinez','Manager',41000,'B005'),('E111','Christopher Lee','Assistant',65000,'B005');
/*!40000 ALTER TABLE `employe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue`
--

DROP TABLE IF EXISTS `issue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue` (
  `issued_id` varchar(50) NOT NULL,
  `issued_member_id` varchar(50) DEFAULT NULL,
  `issued_book_name` varchar(100) DEFAULT NULL,
  `issued_date` varchar(50) DEFAULT NULL,
  `issued_book_isbn` varchar(100) DEFAULT NULL,
  `issued_emp_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`issued_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue`
--

LOCK TABLES `issue` WRITE;
/*!40000 ALTER TABLE `issue` DISABLE KEYS */;
INSERT INTO `issue` VALUES ('IS106','C106','Animal Farm','2024-03-10','978-0-330-25864-8','E104'),('IS107','C107','One Hundred Years of Solitude','2024-03-11','978-0-14-118776-1','E104'),('IS108','C108','The Great Gatsby','2024-03-12','978-0-525-47535-5','E104'),('IS109','C109','Jane Eyre','2024-03-13','978-0-141-44171-6','E105'),('IS110','C110','The Alchemist','2024-03-14','978-0-307-37840-1','E105'),('IS111','C109','Harry Potter and the Sorcerers Stone','2024-03-15','978-0-679-76489-8','E105'),('IS112','C109','A Game of Thrones','2024-03-16','978-0-09-957807-9','E106'),('IS113','C109','A Peoples History of the United States','2024-03-17','978-0-393-05081-8','E106'),('IS114','C109','The Guns of August','2024-03-18','978-0-19-280551-1','E106'),('IS115','C109','The Histories','2024-03-19','978-0-14-044930-3','E107'),('IS116','C110','Guns, Germs, and Steel: The Fates of Human Societies','2024-03-20','978-0-393-91257-8','E107'),('IS117','C110','1984','2024-03-21','978-0-679-64115-3','E107'),('IS118','C101','Pride and Prejudice','2024-03-22','978-0-14-143951-8','E108'),('IS119','C110','Brave New World','2024-03-23','978-0-452-28240-7','E108'),('IS120','C110','The Road','2024-03-24','978-0-670-81302-4','E108'),('IS121','C102','The Shining','2024-03-25','978-0-385-33312-0','E109'),('IS122','C102','Fahrenheit 451','2024-03-26','978-0-451-52993-5','E109'),('IS123','C103','Dune','2024-03-27','978-0-345-39180-3','E109'),('IS124','C104','Where the Wild Things Are','2024-03-28','978-0-06-025492-6','E110'),('IS125','C105','The Kite Runner','2024-03-29','978-0-06-112241-5','E110'),('IS126','C105','Charlotte\'s Web','2024-03-30','978-0-06-440055-8','E110'),('IS127','C105','Beloved','2024-03-31','978-0-679-77644-3','E110'),('IS128','C105','A Tale of Two Cities','2024-04-01','978-0-14-027526-3','E110'),('IS129','C105','The Stand','2024-04-02','978-0-7434-7679-3','E110'),('IS130','C106','Moby Dick','2024-04-03','978-0-451-52994-2','E101'),('IS131','C106','To Kill a Mockingbird','2024-04-04','978-0-06-112008-4','E101'),('IS132','C106','The Hobbit','2024-04-05','978-0-7432-7356-4','E106'),('IS133','C107','Angels & Demons','2024-04-06','978-0-7432-4722-5','E106'),('IS134','C107','The Diary of a Young Girl','2024-04-07','978-0-375-41398-8','E106'),('IS135','C107','Sapiens: A Brief History of Humankind','2024-04-08','978-0-307-58837-1','E108'),('IS136','C107','1491: New Revelations of the Americas Before Columbus','2024-04-09','978-0-7432-7357-1','E102'),('IS137','C107','The Catcher in the Rye','2024-04-10','978-0-553-29698-2','E103'),('IS138','C108','The Great Gatsby','2024-04-11','978-0-525-47535-5','E104'),('IS139','C109','Harry Potter and the Sorcerers Stone','2024-04-12','978-0-679-76489-8','E105'),('IS140','C110','Animal Farm','2024-04-13','978-0-330-25864-8','E102');
/*!40000 ALTER TABLE `issue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members` (
  `member_id` varchar(255) NOT NULL,
  `member_name` varchar(250) DEFAULT NULL,
  `member_address` varchar(250) DEFAULT NULL,
  `reg_date` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members`
--

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
INSERT INTO `members` VALUES ('C101','Alice Johnson','123 Main St','2021-05-15'),('C102','Bob Smith','456 Elm St','2021-06-20'),('C103','Carol Davis','789 Oak St','2021-07-10'),('C104','Dave Wilson','567 Pine St','2021-08-05'),('C105','Eve Brown','890 Maple St','2021-09-25'),('C106','Frank Thomas','234 Cedar St','2021-10-15'),('C107','Grace Taylor','345 Walnut St','2021-11-20'),('C108','Henry Anderson','456 Birch St','2021-12-10'),('C109','Ivy Martinez','567 Oak St','2022-01-05'),('C110','Jack Wilson','678 Pine St','2022-02-25'),('C118','Sam','133 Pine St','2024-06-01'),('C119','John','143 Main St','2024-05-01');
/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `return`
--

DROP TABLE IF EXISTS `return`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `return` (
  `return_id` varchar(20) NOT NULL,
  `issued_id` varchar(20) DEFAULT NULL,
  `return_date` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`return_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `return`
--

LOCK TABLES `return` WRITE;
/*!40000 ALTER TABLE `return` DISABLE KEYS */;
INSERT INTO `return` VALUES ('RS101','IS101','2023-06-06'),('RS102','IS105','2023-06-07'),('RS103','IS103','2023-08-07'),('RS104','IS106','2024-05-01'),('RS105','IS107','2024-05-03'),('RS106','IS108','2024-05-05'),('RS107','IS109','2024-05-07'),('RS108','IS110','2024-05-09'),('RS109','IS111','2024-05-11'),('RS110','IS112','2024-05-13'),('RS111','IS113','2024-05-15'),('RS112','IS114','2024-05-17'),('RS113','IS115','2024-05-19'),('RS114','IS116','2024-05-21'),('RS115','IS117','2024-05-23'),('RS116','IS118','2024-05-25'),('RS117','IS119','2024-05-27'),('RS118','IS120','2024-05-29');
/*!40000 ALTER TABLE `return` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-24 22:28:28

-- MySQL dump 10.13  Distrib 5.7.12, for osx10.11 (x86_64)
--
-- Host: localhost    Database: ScavengerHunt
-- ------------------------------------------------------
-- Server version	5.7.12

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
-- Table structure for table `DemoQuestionBank`
--

DROP TABLE IF EXISTS `DemoQuestionBank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DemoQuestionBank` (
  `QID` int(11) NOT NULL AUTO_INCREMENT,
  `Question` varchar(300) DEFAULT NULL,
  `Option1` varchar(300) DEFAULT NULL,
  `Option2` varchar(300) DEFAULT NULL,
  `Option3` varchar(300) DEFAULT NULL,
  `Option4` varchar(300) DEFAULT NULL,
  `CorrectAns` int(11) DEFAULT NULL,
  PRIMARY KEY (`QID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DemoQuestionBank`
--

LOCK TABLES `DemoQuestionBank` WRITE;
/*!40000 ALTER TABLE `DemoQuestionBank` DISABLE KEYS */;
INSERT INTO `DemoQuestionBank` VALUES (1,'What is the closest planet to the Sun?','Saturn','Earth','Jupiter','Mercury',4),(2,'Earth is located in which galaxy?','Andromeda','Black Eye Galaxy','MilkyWay','Whirlpool',3),(3,'What is the name of the first satellite sent into space?','Aryabhata','Sputnik I','DFH-1','Vanguard ',2),(4,'How many planets in the solar system?','7','8','9','10',3),(5,'What is the second biggest planet in the solar system?','Uranus','Saturn','Jupiter','Earth',3),(6,'What is the hottest planet in our solar system?','Mars','Saturn','Venus','Mercury',4),(7,'What planet is known as the red planet?','Mars','Mercury','Saturn','Venus',1);
/*!40000 ALTER TABLE `DemoQuestionBank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DemoStudentReport`
--

DROP TABLE IF EXISTS `DemoStudentReport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DemoStudentReport` (
  `RID` int(11) NOT NULL AUTO_INCREMENT,
  `StudentName` varchar(300) DEFAULT NULL,
  `Time` varchar(300) DEFAULT NULL,
  `DateOfTest` datetime DEFAULT NULL,
  `TimeDiff` int(11) DEFAULT NULL,
  PRIMARY KEY (`RID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DemoStudentReport`
--

LOCK TABLES `DemoStudentReport` WRITE;
/*!40000 ALTER TABLE `DemoStudentReport` DISABLE KEYS */;
/*!40000 ALTER TABLE `DemoStudentReport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QuestionBank`
--

DROP TABLE IF EXISTS `QuestionBank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QuestionBank` (
  `QID` int(11) NOT NULL AUTO_INCREMENT,
  `Question` varchar(300) DEFAULT NULL,
  `Option1` varchar(300) DEFAULT NULL,
  `Option2` varchar(300) DEFAULT NULL,
  `Option3` varchar(300) DEFAULT NULL,
  `Option4` varchar(300) DEFAULT NULL,
  `CorrectAns` int(11) DEFAULT NULL,
  PRIMARY KEY (`QID`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QuestionBank`
--

LOCK TABLES `QuestionBank` WRITE;
/*!40000 ALTER TABLE `QuestionBank` DISABLE KEYS */;
INSERT INTO `QuestionBank` VALUES (1,'Which of the following is the valid IP address?','gencyber@memphis.edu','1000.23.400.500','https://www.gen-cyber.com','192.168.5.10',4),(2,'Which one is not an Operating System?','Linux','MS-DOS','MySQL','MAC OS X',3),(3,'What is a computer network?','A super computer','Interconnected computers or devices','An Internet service provider','All of the above',2),(4,'Why are cyber vulnerabilities unlikely to ever go away?','They\'re protected in a secret base on the moon.','Criminals need them to steal identities.','They are side effects of the buggy software, human behavior, and ease of Internet access. ','The government won\'t allow people to fix them',3),(5,'Which of these is not a hack?','Using a bicycle to power a computer','Stealing an unlocked bicycle','Building a working bicycle out of discarded umbrellas','Creating a kinetic bicycle sculpture',2),(6,'How can you tell if a website encrypts its traffic?','Google it.','Look for the closed lock symbol or https in a URL.','By checking the color and content of the web page.','Generally, all websites encrypt their traffic.',2),(7,'Which of the following is 100 % secure?','Text messages','Emails','Apps','None of the above',4),(8,'Ensuring that only approved personnel can properly modify a particular piece of information is the definition of:','Confidentiality','Integrity','Availability','Deterrence',2),(9,'Ensuring that only approved personnel can access sensitive information is an example of:','Confidentiality','Integrity','Availability','Deterrence',1),(10,'Security controls are designed to do what?','Prevent an attack before it occurs','Halt an attack while it is in progress','Recover from an attack after it is over','All of the above',1),(11,'In a company, the employees are allowed to work from home occasionally. Which the following biometrics are not applicable in that scenario?','Fingerprint','KeyStroke','Voice','All of the Above',1),(12,'What is the most common type of attack used on Web sites? ','denial of service','session hijacking','cross-site scripting','HTML code injection',3),(13,'You friend has found an unlabeled CD. What do you want to do?','Insert CD into Computer.','Decline to insert the CD into Computer','Wait and Open CD on home computer.','Check Phone',2),(14,'An IP Address is the Internet equivalent of which of the following?','Your birth date','Your mailing address','Your social security number','Your phone number',2),(16,'_______ are scripts/files a website stores on an individual\'s computer that monitors their actions on their website.','Tags','Bookmarks','Data Keys','Cookies',4),(17,'Which of the following is NOT an example of cybercrime?','Internet Fraud','Website Defacement','System Intrusion','Breaking a house',4),(18,'Which one of the following is a key function of a firewall?','Monitoring','Deleting','Copying','Moving',1),(19,'What type of characters should you include in a password?','Numbers and Symbols only','Symbols and Alphabets only','Numbers Symbols and Alphabets','Alphabets and Numbers only',3),(20,'There is a scheme that attempts to steal personal information through fraudulent email that looks legitimate. What is the term for this type of cyber crime?','Identity Theft','Hacking','Cyber Stalking','Phishing',4),(21,'What is the term for flooding the emails of larger number of recipients with irrelevant or inappropriate messages?','Hacking','Phishing','Spamming','Cyber Stalking',3),(22,'What term refers to uncovering computer-stored information suitable for use as evidence in courts of law?','Computer Probing','Computer Forensics','Computer investigation','Computer Detective work',2),(23,'A __________ attack occurs when hackers bombard a site with more requests for service than it can possibly handle, preventing legitimate users from accessing the site.','Spam','Virus','Bomb','All of the Above',3),(24,'Which of the following is the number 1 target for cyber crimes','Financial Institutes','Individuals','Educational Institutes','Businesses',4),(25,'Which of the following is NOT a reason why many businesses and corporations under-report computer crimes?','Consumers generally don\'t care about confidentiality','Exposure to financial losses','Data Losses','Damage to brand',1),(26,'One of the earliest examples of computer crime is ________, which consists of an activity in which telecommunications systems are manipulated and ultimately compromised.','Phreaking','Spamming','Hacking','Cracking',1),(27,'Which of the following characteristics of new payment methods has facilitated money laundering and terrorist financing?','Increased competition','Lower interest rates','Anonymity of transaction','Lower costs',3),(28,'Accurate and complete data enters the system for processing and remains accurate thereafter, is said to have:','Integrity','Security','Virus','None of the Above',1),(29,'What has become more important because of increased use of computers, the internet and WWW (World Wide Web)?','Natural Disasters','Hardware Malfunctions','Data integrity and data security','Malicious Deletions',3),(30,'Which reasons listed below makes Software piracy wrong?','Software Creator does not receive any revenue from pirated software','Pirated software does not contain all element and documentation which cause problems.','Pirated software is illegal','All of the Above',1),(31,'What is a worm?','A weakness in security system that never copies itself into a computerâ??s memory until no more space is left.','A computer program that places destructive code in programs such as games to erase either hard disk or programs on disk.','Corrupts or replaces boot sector instructions.','A program that uses computer networks and security holes to copy itself in the computer memory until no more memory is left.',4);
/*!40000 ALTER TABLE `QuestionBank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `StudentReport`
--

DROP TABLE IF EXISTS `StudentReport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `StudentReport` (
  `RID` int(11) NOT NULL AUTO_INCREMENT,
  `StudentName` varchar(300) DEFAULT NULL,
  `Time` varchar(300) DEFAULT NULL,
  `DateOfTest` datetime DEFAULT NULL,
  `TimeDiff` int(11) DEFAULT NULL,
  PRIMARY KEY (`RID`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `StudentReport`
--

LOCK TABLES `StudentReport` WRITE;
/*!40000 ALTER TABLE `StudentReport` DISABLE KEYS */;
INSERT INTO `StudentReport` VALUES (24,'mona','1 minutes, 46 seconds ','2016-06-20 12:49:58',106452),(25,'Jason','38 seconds ','2016-06-20 14:16:07',38922),(26,'Mona','46 seconds ','2016-06-20 14:56:25',46793),(27,'karen','55 seconds ','2016-06-20 14:57:50',55875),(28,'mona','38 seconds ','2016-06-20 15:04:21',38660),(29,'moan','1 minutes, 0 seconds ','2016-06-20 15:09:15',60713);
/*!40000 ALTER TABLE `StudentReport` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-06-20 15:10:24

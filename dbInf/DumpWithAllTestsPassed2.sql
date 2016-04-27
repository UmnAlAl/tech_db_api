-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: dbsubd
-- ------------------------------------------------------
-- Server version	5.7.11-log

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
-- Table structure for table `forum`
--

DROP TABLE IF EXISTS `forum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `idUser` int(11) unsigned NOT NULL COMMENT 'id of founder of the forum',
  `name` varchar(255) NOT NULL COMMENT 'name of the forum',
  `shortName` varchar(255) NOT NULL COMMENT 'forum short name',
  PRIMARY KEY (`id`),
  KEY `fkUser_idx` (`idUser`),
  CONSTRAINT `fkUserFromForum` FOREIGN KEY (`idUser`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum`
--

LOCK TABLES `forum` WRITE;
/*!40000 ALTER TABLE `forum` DISABLE KEYS */;
INSERT INTO `forum` VALUES (1,3,'Forum With Sufficiently Large Name','forumwithsufficientlylargename'),(2,2,'Forum I','forum1'),(3,1,'Forum II','forum2'),(4,4,'Форум Три','forum3');
/*!40000 ALTER TABLE `forum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `globalintvariables`
--

DROP TABLE IF EXISTS `globalintvariables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globalintvariables` (
  `id` int(11) NOT NULL,
  `val` int(11) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `globalintvariables`
--

LOCK TABLES `globalintvariables` WRITE;
/*!40000 ALTER TABLE `globalintvariables` DISABLE KEYS */;
INSERT INTO `globalintvariables` VALUES (0,22,'currentMaxPostRoot');
/*!40000 ALTER TABLE `globalintvariables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `idThread` int(11) unsigned NOT NULL COMMENT 'thread id of this post',
  `idUser` int(11) unsigned NOT NULL COMMENT 'author id',
  `idForum` int(11) unsigned NOT NULL COMMENT 'id of forum where post exists',
  `idParent` int(11) unsigned DEFAULT NULL COMMENT 'id of parent post. Default: None',
  `date` timestamp NOT NULL DEFAULT '1970-10-10 07:10:10' COMMENT 'date of creation. Format: ''YYYY-MM-DD hh-mm-ss''',
  `message` text COMMENT 'post body',
  `isApproved` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'is post marked as approved by moderator',
  `isHighlighted` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'is post marked as higlighted',
  `isEdited` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'is post marked as edited',
  `isSpam` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'is post marked as spam',
  `isDeleted` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'is post marked as deleted',
  `likes` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'num of likes for post',
  `dislikes` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'num of dislikes for post',
  `matPath` varchar(255) NOT NULL COMMENT 'Materialized path of the post',
  `countChildren` int(11) unsigned NOT NULL DEFAULT '0',
  `firstIndex` int(11) unsigned NOT NULL COMMENT 'first index of the post in mat path',
  PRIMARY KEY (`id`),
  KEY `fkThread_idx` (`idThread`),
  KEY `fkUser_idx` (`idUser`),
  CONSTRAINT `fkThreadFromPost` FOREIGN KEY (`idThread`) REFERENCES `thread` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fkUserFromPost` FOREIGN KEY (`idUser`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,1,4,4,NULL,'2014-12-12 06:48:15','my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0',1,0,1,1,0,0,0,'00001/',1,1),(2,1,1,4,NULL,'2016-02-24 11:45:07','my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1',0,0,1,0,0,0,0,'00002/',2,2),(3,1,4,4,2,'2016-04-23 13:25:48','my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2',1,0,0,1,0,0,0,'00002/00001/',0,2),(4,1,5,4,2,'2016-04-27 08:48:30','my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3',1,1,0,1,0,0,0,'00002/00002/',0,2),(5,1,5,4,NULL,'2016-04-27 11:05:15','my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4',1,1,0,0,0,0,0,'00003/',0,3),(6,1,1,4,NULL,'2016-04-27 11:56:45','my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5',1,1,1,1,0,0,0,'00004/',0,4),(7,1,2,4,1,'2016-04-27 12:18:41','my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6',0,0,1,0,0,0,0,'00001/00001/',0,1),(8,1,3,4,NULL,'2016-04-27 17:19:37','my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7',0,0,0,1,0,0,0,'00005/',0,5),(9,1,4,4,NULL,'2016-04-27 17:22:40','my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8',0,1,0,1,0,0,0,'00006/',0,6),(10,1,5,4,NULL,'2016-04-27 17:37:44','my message 9my message 9my message 9my message 9my message 9my message 9my message 9my message 9my message 9my message 9my message 9my message 9my message 9',1,0,1,0,0,0,0,'00007/',0,7),(11,2,4,4,NULL,'2014-04-13 08:22:05','my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0',0,0,0,0,0,0,0,'00008/',1,8),(12,2,1,4,NULL,'2015-08-10 02:04:43','my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1',0,0,1,0,0,0,0,'00009/',0,9),(13,2,2,4,NULL,'2016-04-24 08:24:04','my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2',0,1,1,1,0,0,0,'00010/',1,10),(14,2,2,4,NULL,'2016-04-27 08:01:44','my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3',0,1,1,0,0,0,0,'00011/',0,11),(15,2,1,4,13,'2016-04-27 16:05:01','my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4',1,0,1,1,0,0,0,'00010/00001/',0,10),(16,2,3,4,11,'2016-04-27 16:49:11','my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5',0,0,1,0,0,0,0,'00008/00001/',1,8),(17,2,2,4,16,'2016-04-27 17:29:43','my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6',1,0,0,0,0,0,0,'00008/00001/00001/',0,8),(18,3,1,3,NULL,'2015-09-07 21:35:39','my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0',0,0,0,0,0,0,0,'00012/',0,12),(19,3,2,3,NULL,'2015-12-23 16:08:36','my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1',1,0,0,1,0,0,0,'00013/',3,13),(20,3,4,3,19,'2016-02-10 05:05:52','my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2',0,0,1,0,0,0,0,'00013/00001/',0,13),(21,3,3,3,NULL,'2016-03-30 02:30:39','my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3',1,1,1,0,0,0,0,'00014/',0,14),(22,3,1,3,19,'2016-04-22 21:14:05','my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4',1,1,1,1,0,0,0,'00013/00002/',0,13),(23,3,3,3,19,'2016-04-27 09:13:26','my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5',1,1,0,0,0,0,0,'00013/00003/',0,13),(24,3,2,3,NULL,'2016-04-27 11:14:06','my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6',1,1,1,1,0,0,0,'00015/',0,15),(25,3,2,3,NULL,'2016-04-27 14:45:10','my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7',0,0,1,0,0,0,0,'00016/',0,16),(26,3,3,3,NULL,'2016-04-27 17:28:25','my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8my message 8',1,1,1,1,0,0,0,'00017/',0,17),(27,4,3,3,NULL,'2015-01-22 13:45:49','my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0my message 0',1,0,1,0,0,0,0,'00018/',1,18),(28,4,3,3,27,'2015-05-15 12:56:14','my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1my message 1',0,0,1,0,0,0,0,'00018/00001/',1,18),(29,4,4,3,28,'2015-11-16 02:36:14','my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2my message 2',0,1,0,0,0,1,0,'00018/00001/00001/',0,18),(30,4,3,3,NULL,'2016-04-20 23:35:43','my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3my message 3',1,1,1,1,0,0,0,'00019/',1,19),(31,4,2,3,NULL,'2016-04-23 07:16:25','my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4my message 4',1,1,1,1,0,0,0,'00020/',0,20),(32,4,4,3,30,'2016-04-23 10:18:25','my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5my message 5',1,0,1,0,0,0,0,'00019/00001/',0,19),(33,4,5,3,NULL,'2016-04-24 23:06:49','my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6my message 6',0,1,0,1,0,0,0,'00021/',0,21),(34,4,2,3,NULL,'2016-04-26 21:31:04','my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7my message 7',0,0,1,1,0,0,0,'00022/',0,22);
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thread`
--

DROP TABLE IF EXISTS `thread`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `thread` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id of thread',
  `idForum` int(11) unsigned DEFAULT NULL COMMENT 'id of forum with thread',
  `idUser` int(11) unsigned NOT NULL,
  `title` varchar(255) NOT NULL COMMENT 'thread title',
  `date` timestamp NOT NULL DEFAULT '1970-10-10 07:10:10' COMMENT 'date of creation. Format: ''YYYY-MM-DD hh-mm-ss''',
  `message` text COMMENT 'thread message',
  `slug` varchar(255) NOT NULL COMMENT 'thread slug',
  `isClosed` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'is thread marker as closed',
  `isDeleted` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'is thread marked as deleted',
  `likes` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'num of likes for thread',
  `dislikes` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'num of dislikes for thread',
  PRIMARY KEY (`id`),
  KEY `fkUser_idx` (`idUser`),
  CONSTRAINT `fkUserFromThread` FOREIGN KEY (`idUser`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thread`
--

LOCK TABLES `thread` WRITE;
/*!40000 ALTER TABLE `thread` DISABLE KEYS */;
INSERT INTO `thread` VALUES (1,4,3,'Thread With Sufficiently Large Title','2013-12-31 21:00:01','hey hey hey hey!','Threadwithsufficientlylargetitle',1,0,0,1),(2,4,3,'Thread I','2013-12-30 21:01:01','hey!','thread1',0,0,0,0),(3,3,3,'Thread II','2013-12-29 21:01:01','hey hey!','newslug',0,0,0,0),(4,3,4,'Тред Три','2013-12-28 21:01:01','hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! hey hey hey! ','thread3',0,0,0,0);
/*!40000 ALTER TABLE `thread` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `threadsubscribers`
--

DROP TABLE IF EXISTS `threadsubscribers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `threadsubscribers` (
  `idThread` int(11) unsigned NOT NULL COMMENT 'id of thread to subscribe',
  `idUser` int(11) unsigned NOT NULL COMMENT 'id of subscriber',
  KEY `fkThread_idx` (`idThread`),
  KEY `fkUser_idx` (`idUser`),
  CONSTRAINT `fkSubscriber` FOREIGN KEY (`idUser`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fkThreadToSubscribe` FOREIGN KEY (`idThread`) REFERENCES `thread` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `threadsubscribers`
--

LOCK TABLES `threadsubscribers` WRITE;
/*!40000 ALTER TABLE `threadsubscribers` DISABLE KEYS */;
INSERT INTO `threadsubscribers` VALUES (2,4),(4,4),(3,4),(2,4),(2,2);
/*!40000 ALTER TABLE `threadsubscribers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'user id',
  `email` varchar(255) NOT NULL COMMENT 'user email (unique)',
  `username` varchar(255) DEFAULT NULL COMMENT 'username (nick)',
  `name` varchar(255) DEFAULT NULL COMMENT 'name of user',
  `about` text COMMENT 'user curriculum',
  `isAnonymous` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'is user marked as anonymous',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idxEmail` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'example@mail.ru','user1','John','hello im user1',0),(2,'richard.nixon@example.com',NULL,NULL,NULL,1),(3,'example2@mail.ru','user2','NewName','Wowowowow',0),(4,'example3@mail.ru','user3','NewName2','Wowowowow!!!',0),(5,'example4@mail.ru','user4','Jim','hello im user4',0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userfollowers`
--

DROP TABLE IF EXISTS `userfollowers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userfollowers` (
  `idFollower` int(11) unsigned NOT NULL COMMENT 'id of user who follows another',
  `idFollowee` int(11) unsigned NOT NULL COMMENT 'id of user to be followed',
  UNIQUE KEY `uniquePair` (`idFollower`,`idFollowee`),
  KEY `fkFollower_idx` (`idFollower`),
  KEY `fkFollowee_idx` (`idFollowee`),
  CONSTRAINT `fkFollowee` FOREIGN KEY (`idFollowee`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fkFollower` FOREIGN KEY (`idFollower`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userfollowers`
--

LOCK TABLES `userfollowers` WRITE;
/*!40000 ALTER TABLE `userfollowers` DISABLE KEYS */;
/*!40000 ALTER TABLE `userfollowers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'dbsubd'
--

--
-- Dumping routines for database 'dbsubd'
--
/*!50003 DROP FUNCTION IF EXISTS `forumCreate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `forumCreate`(forumName VARCHAR(255), 
								forumShortName VARCHAR(255), 
                                forumFounderEmail VARCHAR(255)) RETURNS int(11)
BEGIN
	DECLARE userId INT;
    SELECT id INTO userId FROM user WHERE email = forumFounderEmail;
    INSERT INTO forum VALUES(null, userId, forumName, forumShortName);
    RETURN LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getThreadIdByTitle` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getThreadIdByTitle`(threadTitle VARCHAR(255)) RETURNS int(11)
BEGIN
	DECLARE threadId INT;
	SELECT id INTO threadId FROM thread WHERE thread.title = threadTitle;
    RETURN threadId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `postCreate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `postCreate`(postIdThread INT,
								postAuthorEmail VARCHAR(255),
                                postForumShortName VARCHAR(255),
                                postIdParent INT,
                                postDate TIMESTAMP,
                                postMessage TEXT,
								postIsApproved TINYINT,
                                postIsHighlighted TINYINT,
                                postIsEdited TINYINT,
                                postIsSpam TINYINT,
                                postIsDeleted TINYINT) RETURNS int(11)
BEGIN

	/* создание поста */
    /* postIdThread указан всегда */
    /* postAuthorEmail указан всегда */
    /* postForumShortName указан всегда */
    /* postIdParent если не указан то null */
    /* postDate postMessage указаны всегда */
    /* все is* по умолчанию 0 */

	/* 
		mat path строится наподобие 00001/00012/00011/... 
        на каждый уровень по 6 символов включая / => 10^5  постов на уровне
        max длина пути 255 => максимум вложенности - 42
    */

	DECLARE userId INT; /* id автора */
    DECLARE forumId INT; /* id форума */
    DECLARE parentMatPath VARCHAR(255); /* materialized path родителя (если есть, то надо будет дополнить и установить себе) */
    DECLARE currentMatPath VARCHAR(255); /* текущий materialized path */
    DECLARE cnt INT;
    DECLARE frIn INT; /*first index - первый индес в пути*/
    
    /* получить id форума и пользователя */
    SELECT id INTO userId FROM user WHERE email = postAuthorEmail;
    SELECT id INTO forumId FROM forum WHERE shortName = postForumShortName;
    
    /* если id родителя не указан - новый корень */
    IF (postIdParent IS NULL) THEN
		/*LOCK TABLES globalIntVariables WRITE;*/
		SELECT val INTO cnt FROM globalIntVariables WHERE id = 0; /* получаем текущий счетчик корней */
        SET cnt = cnt + 1; /* увеличиваем счетчик */
        SET frIn = cnt; /* получаем свой новый первый индекс */
        UPDATE globalIntVariables SET val = cnt WHERE id = 0; /*увеличиваем глобальный счетчик корней */
        /*UNLOCK TABLES;*/
		SET currentMatPath = CONCAT(LPAD(CAST(cnt AS CHAR), 5, '0'), '/'); /* делаем путь в виде числа длины 5, дополненного нулями и / */
    ELSE /* если есть родитель */
        SELECT matPath INTO parentMatPath FROM post WHERE id = postIdParent; /* получить путь родителя */
        SELECT countChildren INTO cnt FROM post WHERE id = postIdParent; /* получить число потомков у родителя */
        SELECT firstIndex INTO frIn FROM post WHERE id = postIdParent; /* получить первый индекс у родителя */
        SET cnt = cnt + 1; /* увеличить счетчик */
        UPDATE post SET countChildren = cnt WHERE id = postIdParent; /* установить новое значение в родителе */
        SET currentMatPath = CONCAT(parentMatPath, LPAD(CAST(cnt AS CHAR), 5, '0'), '/'); /* присоединить к пути родителя номер нового потомка дополненного 0 до длины 5 и / */
    END IF;
    
    
    INSERT INTO post VALUES(
		null, /*pk*/
		postIdThread,
        userId,
        forumId,
        postIdParent,
        postDate,
        postMessage,
        postIsApproved,
        postIsHighlighted,
        postIsEdited,
        postIsSpam,
        postIsDeleted,
        0, /* likes */
        0, /* dislikes */
        currentMatPath,
        0, /* countCildren */
        frIn /*first index в пути*/
	);
    RETURN LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `threadCreate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `threadCreate`(threadParentForumShortName VARCHAR(255), 
								threadTitle VARCHAR(255), 
                                threadIsClosed TINYINT, 
                                threadFounderEmail VARCHAR(255), 
                                threadDate TIMESTAMP, 
                                threadMessage TEXT,
								threadSlug VARCHAR(255), 
                                threadIsDeleted TINYINT) RETURNS int(11)
BEGIN
	/* создание нового треда */
    /* получить id форума и создателя */
	DECLARE parentForumId INT;
    DECLARE founderId INT;
    SELECT id INTO parentForumId FROM forum WHERE forum.shortName = threadParentForumShortName;
    SELECT id INTO founderId FROM user WHERE user.email = threadFounderEmail;
    
    INSERT INTO thread VALUES (
		null, /*pk*/
        parentForumId,
        founderId,
        threadTitle,
        threadDate,
        threadMessage,
        threadSlug,
        threadIsClosed,
        threadIsDeleted,
        0, /*likes*/
        0 /*dislikes*/
    );
    RETURN LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `userCreate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `userCreate`( userEmail VARCHAR(255), userUserName VARCHAR(255), userName VARCHAR(255), userAbout TEXT, userIsAnonymous TINYINT) RETURNS int(11)
BEGIN
	/* Просто вставка в таблицу пользователей*/
	INSERT INTO user VALUES(null, userEmail, userUserName, userName, userAbout, userIsAnonymous);
    RETURN LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `clear` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clear`()
BEGIN
	/* Truncates all tables */
	SET FOREIGN_KEY_CHECKS = 0;
	TRUNCATE TABLE user;
    TRUNCATE TABLE post;
    TRUNCATE TABLE thread;
    TRUNCATE TABLE forum;
    TRUNCATE TABLE threadSubscribers;
    TRUNCATE TABLE userFollowers;
    TRUNCATE TABLE globalIntVariables;
    SET FOREIGN_KEY_CHECKS = 1;
    INSERT INTO globalIntVariables VALUES(0, 0, 'currentMaxPostRoot');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `forumListPostsByForumShortName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `forumListPostsByForumShortName`(IN forumShortName VARCHAR(255),
													IN lim INT, 
                                                    IN ord CHAR(5), 
                                                    IN sinceDate TIMESTAMP)
BEGIN
	DECLARE forumId INT;
    SELECT id INTO forumId FROM forum WHERE forum.shortName = forumShortName;
	IF (ord = 'desc') THEN
		SELECT * FROM post
        WHERE post.idForum = forumId AND post.date >= sinceDate
        ORDER BY post.date DESC
        LIMIT lim;
    ELSE
		SELECT * FROM post
        WHERE post.idForum = forumId AND post.date >= sinceDate
        ORDER BY post.date ASC
        LIMIT lim;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `forumListThreadsByForumShortName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `forumListThreadsByForumShortName`(IN forumShortName VARCHAR(255), IN lim INT, IN ord CHAR(5), IN sinceDate TIMESTAMP)
BEGIN
	DECLARE forumId INT;
    SELECT id INTO forumId FROM forum WHERE forum.shortName = forumShortName;
	IF (ord = 'desc') THEN
		SELECT * FROM thread
        WHERE thread.idForum = forumId AND thread.date >= sinceDate
        ORDER BY thread.date DESC
        LIMIT lim;
    ELSE
		SELECT * FROM thread
        WHERE thread.idForum = forumId AND thread.date >= sinceDate
        ORDER BY thread.date ASC
        LIMIT lim;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `forumListUserByForumShortName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `forumListUserByForumShortName`(IN forumShortName VARCHAR(255),
													IN lim INT,
													IN ord CHAR(5),
                                                    IN sinceUserId INT)
BEGIN
	DECLARE forumId INT;
    SELECT id INTO forumId FROM forum WHERE forum.shortName = forumShortName;
	IF (ord = 'desc') THEN
		SELECT DISTINCT u1.* FROM user AS u1
        JOIN post AS p1 ON p1.idUser = u1.id
        WHERE p1.idForum = forumId AND u1.id >= sinceUserId
        ORDER BY u1.name DESC
        LIMIT lim;
    ELSE
		SELECT DISTINCT u1.* FROM user AS u1
        JOIN post AS p1 ON p1.idUser = u1.id
        WHERE p1.idForum = forumId AND u1.id >= sinceUserId
        ORDER BY u1.name ASC
        LIMIT lim;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getForumById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getForumById`(IN forumId INT)
BEGIN
	/* получить фоум по id */
	SELECT * FROM forum WHERE forum.id = forumId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getForumByShortName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getForumByShortName`(IN forumShortName VARCHAR(255))
BEGIN
	SELECT * FROM forum WHERE forum.shortName = forumShortName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getNumOfPostsByThreadId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getNumOfPostsByThreadId`(IN threadId INT)
BEGIN
	/* посчитать число незакрытых постов в треде */
    START transaction;
	SELECT COUNT(*) AS cnt FROM post WHERE post.idThread = threadId AND post.isDeleted = 0;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPostById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPostById`(IN idPost INT)
BEGIN
	/*ЧАСТЬ API*/
	/* получить пост по id */
	SELECT * FROM post WHERE post.id = idPost;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getThreadById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getThreadById`(IN threadId INT)
BEGIN
	/* получить тред по id */
    START TRANSACTION;
	SELECT t1.*, (SELECT COUNT(*) FROM post WHERE post.idThread = threadId AND post.isDeleted = 0) AS cnt
    FROM thread AS t1 WHERE t1.id = threadId;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getUserByEmail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserByEmail`(IN userEmail VARCHAR(255))
BEGIN
	SELECT * FROM user WHERE user.email = userEmail;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getUserById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserById`(IN userId INT)
BEGIN
	/* получить пользователя по id */
	SELECT * FROM user WHERE user.id = userId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MY_CREATE_DB_ROUTINE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MY_CREATE_DB_ROUTINE`()
BEGIN
	/*
    описание процедур
    название процедуры начинается с того раздела api, к которому она относится
    */
    
    DECLARE threadId INT;
    
    /*создать пользователей*/
	SET @uid = userCreate('email1@email1.com', 'username1', 'name1', 'about user 1', 0);
    SET @uid = userCreate('email2@email2.com', 'username2', 'name2', 'about user 2', 0);
    SET @uid = userCreate('email3@email3.com', 'username3', 'name3', 'about user 3', 0);
    SET @uid = userCreate('email4@email4.com', 'username4', 'name4', 'about user 4', 0);
    SET @uid = userCreate('email5@email5.com', 'username5', 'name5', 'about user 5', 0);
    SET @uid = userCreate('admin@admin.com', 'admin', 'admin', 'about admin', 0);
    
    /*задать последователей, первый аргумент - кто следит, второй - за кем*/
    /*короткий цикл между 1 и 2*/
    CALL userFollow('email1@email1.com', 'email2@email2.com');
    CALL userFollow('email2@email2.com', 'email1@email1.com');
    /*цикл 3-4-5*/
    CALL userFollow('email3@email3.com', 'email4@email4.com');
    CALL userFollow('email4@email4.com', 'email5@email5.com');
    CALL userFollow('email5@email5.com', 'email3@email3.com');
    /*между циклами*/
    CALL userFollow('email1@email1.com', 'email3@email3.com');
    
    /*админ делает два форума*/
    SET @fid = forumCreate('forumName1', 'forumShortName1', 'admin@admin.com');
    SET @fid = forumCreate('forumName2', 'forumShortName2', 'admin@admin.com');
    
    /*пользователи 1 и 2 создают по 2 треда в каждом форуме*/
    SET @tid = threadCreate(
		'forumShortName1',
		'forum1Thread1',
        0, /*isClosed*/
        'email1@email1.com',
        TIMESTAMP('1990-10-10 10-10-10'),
        'message of forum1Thread1',
        'slug of forum1Thread1',
        0 /*isDeleted*/
    );
    
    SET @tid = threadCreate(
		'forumShortName1',
		'forum1Thread2',
        0, /*isClosed*/
        'email2@email2.com',
        TIMESTAMP('1991-10-10 10-10-10'),
        'message of forum1Thread2',
        'slug of forum1Thread2',
        0 /*isDeleted*/
    );
    
    SET @tid = threadCreate(
		'forumShortName2',
		'forum2Thread1',
        0, /*isClosed*/
        'email1@email1.com',
        TIMESTAMP('1992-12-10 10-10-10'),
        'message of forum2Thread1',
        'slug of forum2Thread1',
        0 /*isDeleted*/
    );
    
    SET @tid = threadCreate(
		'forumShortName2',
		'forum2Thread2',
        0, /*isClosed*/
        'email2@email2.com',
        TIMESTAMP('2000-11-10 10-10-10'),
        'message of forum2Thread2',
        'slug of forum2Thread2',
        0 /*isDeleted*/
    );
    /*подписка*/
    CALL threadSubscribe('email1@email1.com', 1);
    CALL threadSubscribe('email1@email1.com', 2);
    CALL threadSubscribe('email2@email2.com', 1);
    CALL threadSubscribe('email2@email2.com', 2);
    CALL threadSubscribe('email3@email3.com', 1);
    CALL threadSubscribe('email3@email3.com', 2);
    
    /*пользователи отписываются различным образом*/
    /*------------------------------------------------------------*/
    SET threadId = getThreadIdByTitle('forum1Thread1');
    SET @pid = postCreate(
		threadId,
        'email1@email1.com',
        'forumShortName1',
        null, /*id parent*/
        TIMESTAMP('2000-11-10 10-10-10'), /*post date*/
        'forum1Thread1user1 message',
        1, /*is approved*/
        0, /*is highlited*/
        0, /*is edited*/
        0, /*is spam*/
        0 /*is deleted*/
    );
    
    SET @pid = postCreate(
		threadId,
        'email2@email2.com',
        'forumShortName1',
        null, /*id parent*/
        TIMESTAMP('2000-11-11 10-10-10'), /*post date*/
        'forum1Thread1user2 message',
        1, /*is approved*/
        0, /*is highlited*/
        0, /*is edited*/
        0, /*is spam*/
        0 /*is deleted*/
    );
    
    SET @pid = postCreate(
		threadId,
        'email4@email4.com',
        'forumShortName1',
        1, /*id parent*/
        TIMESTAMP('2000-11-11 10-10-10'), /*post date*/
        'forum1Thread1user4 message',
        1, /*is approved*/
        0, /*is highlited*/
        0, /*is edited*/
        0, /*is spam*/
        0 /*is deleted*/
    );
    
    SET @pid = postCreate(
		threadId,
        'email5@email5.com',
        'forumShortName1',
        1, /*id parent*/
        TIMESTAMP('2000-11-13 10-10-10'), /*post date*/
        'forum1Thread1user4 message',
        1, /*is approved*/
        0, /*is highlited*/
        0, /*is edited*/
        0, /*is spam*/
        0 /*is deleted*/
    );
    
    SET @pid = postCreate(
		threadId,
        'email5@email5.com',
        'forumShortName1',
        3, /*id parent*/
        TIMESTAMP('2000-10-13 17-10-10'), /*post date*/
        'forum1Thread1user4 message',
        1, /*is approved*/
        0, /*is highlited*/
        0, /*is edited*/
        0, /*is spam*/
        0 /*is deleted*/
    );
    
    SET @pid = postCreate(
		threadId,
        'email5@email5.com',
        'forumShortName1',
        3, /*id parent*/
        TIMESTAMP('2001-11-13 10-10-10'), /*post date*/
        'forum1Thread1user4 message',
        1, /*is approved*/
        0, /*is highlited*/
        0, /*is edited*/
        0, /*is spam*/
        0 /*is deleted*/
    );
    /*------------------------------------------------------------*/
    
    SET threadId = getThreadIdByTitle('forum1Thread2');
    SET @pid = postCreate(
		threadId,
        'email3@email3.com',
        'forumShortName1',
        null, /*id parent*/
        TIMESTAMP('2000-11-12 10-10-10'), /*post date*/
        'forum1Thread2user3 message',
        1, /*is approved*/
        0, /*is highlited*/
        0, /*is edited*/
        0, /*is spam*/
        0 /*is deleted*/
    );
    
    SET @pid = postCreate(
		threadId,
        'email4@email4.com',
        'forumShortName1',
        null, /*id parent*/
        TIMESTAMP('2000-11-13 10-10-10'), /*post date*/
        'forum1Thread2user4 message',
        1, /*is approved*/
        0, /*is highlited*/
        0, /*is edited*/
        0, /*is spam*/
        0 /*is deleted*/
    );
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `postListByForumShortName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `postListByForumShortName`(
					IN forumShortName VARCHAR(255),
                    IN lim INT,
                    IN ord CHAR(5),
                    IN since_date TIMESTAMP)
BEGIN
	/* Выводит посты по имени форума */
    /* forumShortName приходит всегда */
    /* если не пришел lim - передать max_int */
    /* если не рпишел ord - передать desc */
    /* если не пришел since_date - передать 0 */
    
    DECLARE forumId INT;
    SELECT id INTO forumId FROM forum WHERE forum.shortName = forumShortName; /* получаем id форума */
    
    /* Варианты сортировки по убыванию и возрастанию */
    IF (ord = 'desc') THEN
		SELECT f.shortName, u.email, p.* 
        FROM post AS p /* вебрать из таблицы постов */
        JOIN forum AS f
        ON p.idForum = f.id
        JOIN user AS u
        ON p.idUser = u.id
        WHERE p.idForum = forumId AND p.date >= since_date /* по id форума */
        ORDER BY p.date DESC /* упорядочить по дате */
        LIMIT lim; /* с ограничением */
	ELSE /* аналогично */
		SELECT f.shortName, u.email, p.* 
        FROM post AS p /* вебрать из таблицы постов */
        JOIN forum AS f
        ON p.idForum = f.id
        JOIN user AS u
        ON p.idUser = u.id
        WHERE p.idForum = forumId AND p.date >= since_date
        ORDER BY p.date ASC
        LIMIT lim;
	END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `postListByThreadId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `postListByThreadId`(
						IN threadId INT,
                        IN lim INT,
                        IN ord CHAR(5),
                        IN since_date TIMESTAMP
                        )
BEGIN
	/* Выводит посты по id треда */
    /* threadId приходит всегда */
    /* если не пришел lim - передать max_int */
    /* если не рпишел ord - передать desc */
    /* если не пришел since_date - передать 0 */
    
    /* Варианты сортировки по убыванию и возрастанию */
    IF (ord = 'desc') THEN
		SELECT f.shortName, u.email, p.* 
        FROM post AS p /* вебрать из таблицы постов */
        JOIN forum AS f
        ON p.idForum = f.id
        JOIN user AS u
        ON p.idUser = u.id
        WHERE p.idThread = threadId AND p.date >= since_date /* по id треда */
        ORDER BY p.date DESC /* упорядочить по дате */
        LIMIT lim; /* с ограничением */
	ELSE /* аналогично */
		SELECT f.shortName, u.email, p.* 
        FROM post AS p /* вебрать из таблицы постов */
        JOIN forum AS f
        ON p.idForum = f.id
        JOIN user AS u
        ON p.idUser = u.id
        WHERE p.idThread = threadId AND p.date >= since_date /* по id треда */
        ORDER BY p.date ASC /* упорядочить по дате */
        LIMIT lim; /* с ограничением */
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `postRemoveDirectly` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `postRemoveDirectly`(IN postId INT)
BEGIN
	/* удалить пост напрямую - последний бит в 1 у него, у его потомков - предпоследний*/
    /*DECLARE mp VARCHAR(255);  путь для удаляемого поста */
    START TRANSACTION;
    
    UPDATE post SET post.isDeleted = post.isDeleted | 1 /* пометить текущий пост удаленным */
    WHERE post.id = postId;
    
    /*SELECT matPath INTO mp FROM post WHERE post.id = postId;  получить matpath 
    UPDATE post SET post.isDeleted = post.isDeleted | 1  пометить текущий пост удаленным 
    WHERE post.id = postId;
    UPDATE post SET post.isDeleted = post.isDeleted | 2  предпоследний бит в 1 у потомков 
    WHERE post.matPath RLIKE CONCAT(mp, '.+');*/
    
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `postRestoreDirectly` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `postRestoreDirectly`(IN postId INT)
BEGIN
	/* восстановить пост напрямую - последний бит в 0 у него, у его потомков - предпоследний*/
    /*DECLARE mp VARCHAR(255);  путь для удаляемого поста */
    
    START TRANSACTION;
    
    UPDATE post SET post.isDeleted = post.isDeleted & (~1) /* пометить текущий пост восстановленным */
    WHERE post.id = postId;
    
    /*SELECT matPath INTO mp FROM post WHERE post.id = postId;  получить matpath 
    UPDATE post SET post.isDeleted = post.isDeleted & (~1)  пометить текущий пост восстановленным 
    WHERE post.id = postId;
    UPDATE post SET post.isDeleted = post.isDeleted & (~2)  предпоследний бит в 0 у потомков 
    WHERE post.matPath RLIKE CONCAT(mp, '.+');*/
    
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `postUpdate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `postUpdate`(IN postId INT, IN postMessage TEXT)
BEGIN
	/* обновляем текст поста по его id */
    UPDATE post SET post.message = post.Message WHERE post.id = postId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `postVote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `postVote`(IN postId INT, IN postVote INT)
BEGIN
	/*увеличить число лайков/дизлайков у поста*/
    IF (postVote = 1) THEN
		UPDATE post SET post.likes = post.likes + 1
        WHERE post.id = postId;
	ELSE 
		UPDATE post SET post.dislikes = post.dislikes + 1
        WHERE post.id = postId;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `status`()
BEGIN
	DECLARE u INT;
    DECLARE t INT;
    DECLARE f INT;
    DECLARE p INT;
    SELECT COUNT(*) INTO u FROM user;
    SELECT COUNT(*) INTO t FROM thread;
    SELECT COUNT(*) INTO f FROM forum;
    SELECT COUNT(*) INTO p FROM post;
    SELECT u, t, f, p;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `threadClose` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `threadClose`(IN idThread INT)
BEGIN
	/* пометить тред как закрытый */
	UPDATE thread SET thread.isClosed = 1 WHERE thread.id = idThread;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `threadListPostsFlat` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `threadListPostsFlat`(IN threadId INT, IN lim INT, IN ord CHAR(5), IN sinceDate TIMESTAMP)
BEGIN
	IF (ord = 'desc') THEN
		SELECT p.*, f.shortName, u.email 
        FROM post AS p
        JOIN forum AS f
        ON p.idForum = f.id
        JOIN user AS u
        ON p.idUser = u.id
        WHERE p.idThread = threadId AND p.date >= sinceDate
        ORDER BY p.date DESC
        LIMIT lim;
    ELSE
		SELECT p.*, f.shortName, u.email 
        FROM post AS p
        JOIN forum AS f
        ON p.idForum = f.id
        JOIN user AS u
        ON p.idUser = u.id
        WHERE p.idThread = threadId AND p.date >= sinceDate
        ORDER BY p.date ASC
        LIMIT lim;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `threadListPostsParentTree` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `threadListPostsParentTree`(IN threadId INT, IN lim INT, IN ord CHAR(5), IN sinceDate TIMESTAMP)
BEGIN
	IF (ord = 'desc') THEN
		SELECT p1.*, f.shortName, u.email FROM post AS p1
        JOIN forum AS f
        ON p1.idForum = f.id
        JOIN user AS u
		ON p1.idUser = u.id
        WHERE p1.date >= sinceDate AND p1.firstIndex IN (
			/*костыль*/
			SELECT * FROM ( /*выбрать максимальные первые индексы в соответствии с ограничением*/
				SELECT DISTINCT post.firstIndex FROM post
                WHERE post.idThread = threadId
                ORDER BY post.firstIndex DESC 
                LIMIT lim
            ) AS p2
        )
        ORDER BY p1.firstIndex DESC, p1.matPath ASC; /*первый индекс убывает, остальное - возрастает*/
    ELSE
		SELECT p1.*, f.shortName, u.email FROM post AS p1
        JOIN forum AS f
        ON p1.idForum = f.id
        JOIN user AS u
		ON p1.idUser = u.id
        WHERE p1.date >= sinceDate AND p1.firstIndex IN (
			/*костыль*/
			SELECT * FROM ( /*выбрать максимальные первые индексы в соответствии с ограничением*/
				SELECT DISTINCT post.firstIndex FROM post 
                WHERE post.idThread = threadId
                ORDER BY post.firstIndex ASC 
                LIMIT lim
            ) AS p2
        )
        ORDER BY p1.firstIndex ASC, p1.matPath ASC;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `threadListPostsTree` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `threadListPostsTree`(IN threadId INT,
										IN lim INT,
                                        IN ord CHAR(5),
                                        IN sinceDate TIMESTAMP)
BEGIN
	IF (ord = 'desc') THEN
		SELECT p.*, f.shortName, u.email 
        FROM post AS p
        JOIN forum AS f
        ON p.idForum = f.id
        JOIN user AS u
		ON p.idUser = u.id
        WHERE p.idThread = threadId AND p.date >= sinceDate
        ORDER BY firstIndex DESC, p.matPath ASC
        LIMIT lim;
    ELSE
		SELECT p.*, f.shortName, u.email 
        FROM post AS p
        JOIN forum AS f
        ON p.idForum = f.id
        JOIN user AS u
		ON p.idUser = u.id
        WHERE p.idThread = threadId AND p.date >= sinceDate
        ORDER BY p.matPath ASC
        LIMIT lim;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `threadListThreadsByFounderEmail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `threadListThreadsByFounderEmail`(IN founderEmail VARCHAR(255), IN lim INT, IN ord CHAR(5), IN sinceDate TIMESTAMP)
BEGIN
	/* перечислить треды по email создателя */
    DECLARE founderId INT;
    SELECT id INTO founderId FROM user WHERE user.email = founderEmail;
    IF (ord = 'desc') THEN
		SELECT t.*, f.shortName, COUNT(*) as cnt 
        FROM thread AS t
        JOIN post AS p
        ON p.idThread = t.id
        JOIN forum AS f
        ON f.id = t.idForum
        WHERE t.idUser = founderId AND t.date >= sinceDate
        GROUP BY t.id
        ORDER BY t.date DESC 
        LIMIT lim;
	ELSE
		SELECT t.*, f.shortName, COUNT(*) as cnt 
        FROM thread AS t
        JOIN post AS p
        ON p.idThread = t.id
        JOIN forum AS f
        ON f.id = t.idForum
        WHERE t.idUser = founderId AND t.date >= sinceDate
        GROUP BY t.id
        ORDER BY t.date ASC 
        LIMIT lim;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `threadListThreadsByParentForum` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `threadListThreadsByParentForum`(IN parentShortName VARCHAR(255),
													IN lim INT,
                                                    IN ord CHAR(5),
                                                    IN sinceDate TIMESTAMP)
BEGIN
	/* перечислить треды по имени форума */
    DECLARE forumId INT;
    SELECT id INTO forumId FROM forum WHERE forum.shortName = parentShortName;
    IF (ord = 'desc') THEN
		SELECT t.*, u.email, COUNT(*) as cnt 
        FROM thread AS t
        JOIN post AS p
        ON p.idThread = t.id
        JOIN user AS u
        ON u.id = t.idUser
        WHERE t.idForum = forumId AND t.date >= sinceDate
        GROUP BY t.id
        ORDER BY t.date DESC 
        LIMIT lim;
	ELSE
		SELECT t.*, u.email, COUNT(*) as cnt 
        FROM thread AS t
        JOIN post AS p
        ON p.idThread = t.id
        JOIN user AS u
        ON u.id = t.idUser
        WHERE t.idForum = forumId AND t.date >= sinceDate
        GROUP BY t.id
        ORDER BY t.date ASC 
        LIMIT lim;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `threadOpen` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `threadOpen`(IN idThread INT)
BEGIN
	/* пометить тред как открытый */
	UPDATE thread SET thread.isClosed = 0 WHERE thread.id = idThread;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `threadRemove` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `threadRemove`(IN threadId INT)
BEGIN
	/* удаление треда */
	/* помечаем тред как удаленный */
    START TRANSACTION;
    UPDATE thread SET thread.isDeleted = 1 WHERE thread.id = threadId;
    /* помечаем внутренние посты удаленными - ставим третий бит с конца в их полях isDeleted */
    UPDATE post SET post.isDeleted = post.isDeleted | 4 WHERE post.idThread = threadId;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `threadRestore` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `threadRestore`(IN threadId INT)
BEGIN
	/* восстановление треда */
	/* помечаем текущиий тред как восстановленный */
    UPDATE thread SET thread.isDeleted = 0 WHERE thread.id = threadId;
    /* помечаем внутренние посты восстановленными - убираем третий бит с конца в их полях isDeleted */
    UPDATE post SET post.isDeleted = post.isDeleted & (~4) WHERE post.idThread = threadId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `threadSubscribe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `threadSubscribe`(IN userEmail VARCHAR(255), IN threadId INT)
BEGIN
	/* подписать юзеа на тред по email */
    /* получить id пользователя */
	DECLARE userId INT;
    SELECT id INTO userId FROM user WHERE user.email = userEmail;
    INSERT INTO threadSubscribers VALUES (threadId, userId);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `threadUnsubscribe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `threadUnsubscribe`(IN userEmail VARCHAR(255), IN threadId INT)
BEGIN
	/* отписать юзера от треда по email */
    /* получить id пользователя */
	DECLARE userId INT;
    SELECT id INTO userId FROM user WHERE user.email = userEmail;
    DELETE FROM threadSubscribers WHERE idThread = threadId AND idUser = userId; /*удаляем пару*/
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `threadUpdate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `threadUpdate`(IN threadId INT,
									IN threadSlug VARCHAR(255),
                                    IN threadMessage TEXT)
BEGIN
	UPDATE thread SET thread.slug = threadSlug, thread.Message = threadMessage WHERE thread.id = threadId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `threadVote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `threadVote`(IN threadId INT, IN threadVote INT)
BEGIN
	/*увеличить число лайков/дизлайков у треда*/
    IF (threadVote = 1) THEN
		UPDATE thread SET thread.likes = thread.likes + 1
        WHERE thread.id = threadId;
	ELSE 
		UPDATE thread SET thread.dislikes = thread.dislikes + 1
        WHERE thread.id = threadId;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `userFollow` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `userFollow`(IN userEmailFollower VARCHAR(255), IN userEmailFollowee VARCHAR(255))
BEGIN
	/* задаёт последователя */
	/* Получить id следящего и ведущего по email из таблицы пользователей */
	DECLARE userIdFollower INT;
    DECLARE userIdFollowee INT;
    SELECT id INTO userIdFollower FROM user WHERE email = userEmailFollower;
    SELECT id INTO userIdFollowee FROM user WHERE email = userEmailFollowee;
    /* Вставляем пару id */
    INSERT INTO userFollowers VALUES(userIdFollower, userIdFollowee);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `userGetEmailsOfFolloweesByUserId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `userGetEmailsOfFolloweesByUserId`(IN userId INT)
BEGIN
    SELECT DISTINCT u2.email FROM 
    user AS u1 
    JOIN userFollowers AS f ON u1.id = userId AND u1.id = f.idFollower
    JOIN user AS u2 ON f.idFollowee = u2.id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `userGetEmailsOfFollowersByUserId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `userGetEmailsOfFollowersByUserId`(IN userId INT)
BEGIN
    SELECT DISTINCT u2.email FROM 
    user AS u1 
    JOIN userFollowers AS f ON u1.id = userId AND u1.id = f.idFollowee
    JOIN user AS u2 ON f.idFollower = u2.id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `userGetSubscriptionsByUserId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `userGetSubscriptionsByUserId`(IN userId INT)
BEGIN
	/* перечислить треды, на которые подписан пользователь */
    /* из таблицы подписок выбираем id тредов по id пользователя */
	SELECT DISTINCT (idThread) FROM threadSubscribers
    WHERE idUser = userId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `userListFolloweesByUserEmail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `userListFolloweesByUserEmail`(IN userEmail VARCHAR(255), IN lim INT, IN ord VARCHAR(5), IN since_id INT, IN max_id INT)
BEGIN
	/*
    это процедура для api, она не возвращает
    вложенных последователей, последуемых, подписки
    для последователей использовать userGetEmailsOfFollowersByUserEmail
    для последуемых использовать userGetEmailsOfFolloweesByUserEmail
    для подписок - userGetSubscriptionsByUserEmail
    */
    
	/*получение тех, за кем следит пользователь*/
    /*если не указан lim - передать max_int*/
    /*если не указан ord - передать desc*/
    /*если не указан since_id - передать -1*/
    /*если не указан max_id - передать max_int*/
    
    /* получим id по email */
	DECLARE userId INT;
    SELECT id INTO userId FROM user WHERE email = userEmail;
    /* Варианты сортировки по убыванию и возрастанию */
    IF (ord = 'desc') THEN
		SELECT DISTINCT u2.* FROM  /* DISTINCT на всякий случай */
		user AS u1 /* взять 1 экземпляр таблицы с юзерами */
		JOIN userFollowers AS f ON u1.id = userId AND u1.id = f.idFollower  /* соединить с таблицей Followers, по id следящего пользователя */
		JOIN user AS u2 ON f.idFollowee = u2.id /* соединить результат со второй табл. пользователей по id последователя */
		WHERE u2.id >= since_id AND u2.id <= max_id /* во второй таблице оказались ведущие, которых надо отфильтровать */
		ORDER BY u2.name DESC
        LIMIT lim;
	ELSE /* аналогично */
		SELECT DISTINCT u2.* FROM 
		user AS u1 
		JOIN userFollowers AS f ON u1.id = userId AND u1.id = f.idFollower
		JOIN user AS u2 ON f.idFollowee = u2.id
		WHERE u2.id >= since_id AND u2.id <= max_id
		ORDER BY u2.name ASC
        LIMIT lim;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `userListFolloweesIdsByUserEmail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `userListFolloweesIdsByUserEmail`(IN userEmail VARCHAR(255), IN lim INT, IN ord VARCHAR(5), IN since_id INT)
BEGIN
	/*
    это процедура для api, она не возвращает
    вложенных последователей, последуемых, подписки
    для последователей использовать userGetEmailsOfFollowersByUserEmail
    для последуемых использовать userGetEmailsOfFolloweesByUserEmail
    для подписок - userGetSubscriptionsByUserEmail
    */
    
	/*получение тех, за кем следит пользователь*/
    /*если не указан lim - передать max_int*/
    /*если не указан ord - передать desc*/
    /*если не указан since_id - передать -1*/
    /*если не указан max_id - передать max_int*/
    
    /* получим id по email */
	DECLARE userId INT;
    SELECT id INTO userId FROM user WHERE email = userEmail;
    /* Варианты сортировки по убыванию и возрастанию */
    IF (ord = 'desc') THEN
		SELECT DISTINCT u2.id FROM  /* DISTINCT на всякий случай */
		user AS u1 /* взять 1 экземпляр таблицы с юзерами */
		JOIN userFollowers AS f ON u1.id = userId AND u1.id = f.idFollower  /* соединить с таблицей Followers, по id следящего пользователя */
		JOIN user AS u2 ON f.idFollowee = u2.id /* соединить результат со второй табл. пользователей по id последователя */
		WHERE u2.id >= since_id /* во второй таблице оказались ведущие, которых надо отфильтровать */
		ORDER BY u2.name DESC
        LIMIT lim;
	ELSE /* аналогично */
		SELECT DISTINCT u2.id FROM 
		user AS u1 
		JOIN userFollowers AS f ON u1.id = userId AND u1.id = f.idFollower
		JOIN user AS u2 ON f.idFollowee = u2.id
		WHERE u2.id >= since_id
		ORDER BY u2.name ASC
        LIMIT lim;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `userListFollowersByUserEmail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `userListFollowersByUserEmail`(IN userEmail VARCHAR(255), IN lim INT, IN ord VARCHAR(5), IN since_id INT, IN max_id INT)
BEGIN
	/*
    это процедура для api, она не возвращает
    вложенных последователей, последуемых, подписки
    для последователей использовать userGetEmailsOfFollowersByUserEmail
    для последуемых использовать userGetEmailsOfFolloweesByUserEmail
    для подписок - userGetSubscriptionsByUserEmail
    */


	/*получение тех, кто следит за пользователем*/
    /*если не указан lim - передать max_int*/
    /*если не указан ord - передать desc*/
    /*если не указан since_id - передать -1*/
    /* получим id по email */
	DECLARE userId INT;
    SELECT id INTO userId FROM user WHERE email = userEmail;
    /* Варианты сортировки по убыванию и возрастанию */
    IF (ord = 'desc') THEN
		SELECT DISTINCT u2.* FROM /* DISTINCT на всякий случай */
		user AS u1 /* взять 1 экземпляр таблицы с юзерами */
		JOIN userFollowers AS f ON u1.id = userId AND u1.id = f.idFollowee /* соединить с таблицей Followers, по id ведущего пользователя */
		JOIN user AS u2 ON f.idFollower = u2.id /* соединить результат со второй табл. пользователей по id последователя */
		WHERE u2.id >= since_id AND u2.id <= max_id /* во второй таблице оказались последователи, которых надо отфильтровать */
		ORDER BY u2.name DESC
        LIMIT lim;
	ELSE /*аналогично*/
		SELECT DISTINCT u2.* FROM 
		user AS u1 
		JOIN userFollowers AS f ON u1.id = userId AND u1.id = f.idFollowee
		JOIN user AS u2 ON f.idFollower = u2.id
		WHERE u2.id >= since_id
		ORDER BY u2.name ASC
        LIMIT lim;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `userListFollowersIdsByUserEmail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `userListFollowersIdsByUserEmail`(IN userEmail VARCHAR(255), IN lim INT, IN ord VARCHAR(5), IN since_id INT)
BEGIN
	/*
    это процедура для api, она не возвращает
    вложенных последователей, последуемых, подписки
    для последователей использовать userGetEmailsOfFollowersByUserEmail
    для последуемых использовать userGetEmailsOfFolloweesByUserEmail
    для подписок - userGetSubscriptionsByUserEmail
    */


	/*получение тех, кто следит за пользователем*/
    /*если не указан lim - передать max_int*/
    /*если не указан ord - передать desc*/
    /*если не указан since_id - передать -1*/
    /* получим id по email */
	DECLARE userId INT;
    SELECT id INTO userId FROM user WHERE email = userEmail;
    /* Варианты сортировки по убыванию и возрастанию */
    IF (ord = 'desc') THEN
		SELECT DISTINCT u2.id FROM /* DISTINCT на всякий случай */
		user AS u1 /* взять 1 экземпляр таблицы с юзерами */
		JOIN userFollowers AS f ON u1.id = userId AND u1.id = f.idFollowee /* соединить с таблицей Followers, по id ведущего пользователя */
		JOIN user AS u2 ON f.idFollower = u2.id /* соединить результат со второй табл. пользователей по id последователя */
		WHERE u2.id >= since_id /* во второй таблице оказались последователи, которых надо отфильтровать */
		ORDER BY u2.name DESC
        LIMIT lim;
	ELSE /*аналогично*/
		SELECT DISTINCT u2.id FROM 
		user AS u1 
		JOIN userFollowers AS f ON u1.id = userId AND u1.id = f.idFollowee
		JOIN user AS u2 ON f.idFollower = u2.id
		WHERE u2.id >= since_id
		ORDER BY u2.name ASC
        LIMIT lim;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `userListPostsByUserEmail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `userListPostsByUserEmail`(IN userEmail VARCHAR(255), IN lim INT, IN ord VARCHAR(5), IN since_date TIMESTAMP)
BEGIN
	/* Перечислить все посты пользователя по email с ограничениями */
    /* если не указан lim - передать max_int */
    /* если не указан ord - передать desc */
    /* если не указан since_date - передать 0 */
    
    /* получим id пользователя по email */
	DECLARE userId INT;
    SELECT id INTO userId FROM user WHERE email = userEmail;
    
    /* два вида сортировки */
    IF (ord = 'desc') THEN
		SELECT f.shortName, p.* /* выбрать все столбцы из постов */
        FROM post AS p
        JOIN forum AS f
        ON p.idForum = f.id
        WHERE p.idUser = userId AND p.date >= since_date /* которые написал юзер с этим id после опр даты */
        ORDER BY p.date DESC /* упорядочить по дате по убыванию */
        LIMIT lim; /* ограничить число */
	ELSE
		SELECT f.shortName, p.*
        FROM post AS p
        JOIN forum AS f
        ON p.idForum = f.id
        WHERE p.idUser = userId AND p.date >= since_date
        ORDER BY p.date ASC
        LIMIT lim;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `userUnfollow` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `userUnfollow`(IN userEmailFollower VARCHAR(255), IN userEmailFollowee VARCHAR(255))
BEGIN
	/* отписать следящего от ведущего по их email */
    
    /* получить id следящего и ведущего по email */
	DECLARE userIdFollower INT;
    DECLARE userIdFollowee INT;
    SELECT id INTO userIdFollower FROM user WHERE email = userEmailFollower;
    SELECT id INTO userIdFollowee FROM user WHERE email = userEmailFollowee;
    /* удалить пару id из таблицы followers */
    DELETE FROM userFollowers
    WHERE userFollowers.idFollower = userIdFollower AND userFollowers.idFollowee = userIdFollowee;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `userUpdateByEmail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `userUpdateByEmail`(IN userEmail VARCHAR(255), IN userName VARCHAR(255), IN userAbout TEXT)
BEGIN
	/* обновляем имя пользователя и информацию о нём по его email */
	UPDATE user SET user.name = userName, user.about = userAbout
    WHERE user.email = userEmail;
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

-- Dump completed on 2016-04-27 20:40:15

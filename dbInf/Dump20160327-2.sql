CREATE DATABASE  IF NOT EXISTS `dbsubd` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `dbsubd`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: dbsubd
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
  `id` int(11) unsigned NOT NULL COMMENT 'id of forum',
  `idUser` int(11) unsigned NOT NULL COMMENT 'id of founder of the forum',
  `name` varchar(255) NOT NULL COMMENT 'name of the forum',
  `shortName` varchar(255) NOT NULL COMMENT 'forum short name',
  PRIMARY KEY (`id`),
  KEY `fkUser_idx` (`idUser`),
  CONSTRAINT `fkUserFromForum` FOREIGN KEY (`idUser`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum`
--

LOCK TABLES `forum` WRITE;
/*!40000 ALTER TABLE `forum` DISABLE KEYS */;
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
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'date of creation. Format: ''YYYY-MM-DD hh-mm-ss''',
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
  KEY `fkForum_idx` (`idForum`),
  CONSTRAINT `fkForumFromPost` FOREIGN KEY (`idForum`) REFERENCES `forum` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fkThreadFromPost` FOREIGN KEY (`idThread`) REFERENCES `thread` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fkUserFromPost` FOREIGN KEY (`idUser`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
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
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'date of creation. Format: ''YYYY-MM-DD hh-mm-ss''',
  `message` text COMMENT 'thread message',
  `slug` varchar(255) NOT NULL COMMENT 'thread slug',
  `isClosed` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'is thread marker as closed',
  `isDeleted` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'is thread marked as deleted',
  `likes` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'num of likes for thread',
  `dislikes` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'num of dislikes for thread',
  PRIMARY KEY (`id`),
  KEY `fkForum_idx` (`idForum`),
  KEY `fkUser_idx` (`idUser`),
  CONSTRAINT `fkForumFromThread` FOREIGN KEY (`idForum`) REFERENCES `forum` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fkUserFromThread` FOREIGN KEY (`idUser`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thread`
--

LOCK TABLES `thread` WRITE;
/*!40000 ALTER TABLE `thread` DISABLE KEYS */;
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
  `username` varchar(255) NOT NULL COMMENT 'username (nick)',
  `name` varchar(255) DEFAULT NULL COMMENT 'name of user',
  `about` text COMMENT 'user curriculum',
  `isAnonymous` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
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
    SET FOREIGN_KEY_CHECKS = 1;
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
	SELECT COUNT(*) FROM post WHERE post.idThread = threadId AND post.isClosed = 0;
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
	SELECT * FROM thread WHERE thread.id = threadId;
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
/*!50003 DROP PROCEDURE IF EXISTS `postCreate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `postCreate`(IN postIdThread INT, IN postAuthorEmail VARCHAR(255), IN postForumShortName VARCHAR(255), IN postIdParent INT, IN postDate TIMESTAMP, IN postMessage TEXT,
								IN postIsApproved TINYINT, IN postIsHighlighted TINYINT, IN postIsEdited TINYINT, IN postIsSpam TINYINT, IN postIsDeleted TINYINT)
BEGIN

	/* создание поста */
    /* postIdThread указан всегда */
    /* postAuthorEmail указан всегда */
    /* postForumShortName указан всегда */
    /* postIdParent если не указан то null */
    /* postDate postMessage указаны всегда */
    /* все is* по умолчанию 0 */

	/* 
		mat path строится таподобие 00001/00012/00011/... 
        на каждый уровень по 6 символов включая / => 10^5  постов на уровнеaction
        max длина пути 255 => максимум вложенности - 42
    */

	DECLARE userId INT; /* id автора */
    DECLARE forumId INT; /* id форума */
    DECLARE parentMatPath VARCHAR(255); /* materialized path родителя (если есть, то надо будет дополнить и установить себе) */
    DECLARE currentMatPath VARCHAR(255); /* текущий materialized path */
    DECLARE cnt INT;
    DECLARE frIn INT;
    
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
        postIsHighlited,
        postIsEdited,
        postIsSpam,
        postIsDeleted,
        0, /* likes */
        0, /* dislikes */
        currentMatPath,
        0, /* countCildren */
        frIn
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `postListByForumShortName`(IN forumShortName VARCHAR(255), IN lim INT, IN ord CHAR(5), IN since_id INT)
BEGIN
	/* Выводит посты по имени форума */
    /* forumShortName приходит всегда */
    /* если не пришел lim - передать max_int */
    /* если не рпишел ord - передать desc */
    /* если не пришел since_id - передать -1 */
    
    DECLARE forumId INT;
    SELECT id FROM forum WHERE forum.shortName = forumShortName; /* получаем id форума */
    
    /* Варианты сортировки по убыванию и возрастанию */
    IF (ord = 'desc') THEN
		SELECT * FROM post /* вебрать из таблицы постов */
        WHERE post.idForum = forumId /* по id форума */
        ORDER BY post.date DESC /* упорядочить по дате */
        LIMIT lim; /* с ограничением */
	ELSE /* аналогично */
		SELECT * FROM post
        WHERE post.idForum = forumId
        ORDER BY post.date ASC
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `postListByThreadId`(IN threadId INT, IN lim INT, IN ord CHAR(5), IN since_id INT)
BEGIN
	/* Выводит посты по id треда */
    /* threadId приходит всегда */
    /* если не пришел lim - передать max_int */
    /* если не рпишел ord - передать desc */
    /* если не пришел since_id - передать -1 */
    
    /* Варианты сортировки по убыванию и возрастанию */
    IF (ord = 'desc') THEN
		SELECT * FROM post /* вебрать из таблицы постов */
        WHERE post.idThread = threadId /* по id треда */
        ORDER BY post.date DESC /* упорядочить по дате */
        LIMIT lim; /* с ограничением */
	ELSE /* аналогично */
		SELECT * FROM post
        WHERE post.idThread = threadId
        ORDER BY post.date ASC
        LIMIT lim;
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
    DECLARE mp VARCHAR(255); /* путь для удаляемого поста */
    SELECT matPath INTO mp FROM post WHERE post.id = postId; /* получить matpath */
    UPDATE post SET post.isDeleted = post.isDeleted | 1 /* пометить текущий пост удаленным */
    WHERE post.id = postId;
    UPDATE post SET post.isDeleted = post.isDeleted | 2 /* предпоследний бит в 1 у потомков */
    WHERE post.mathPath LIKE CONCAT(mp, '.+');
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
    DECLARE mp VARCHAR(255); /* путь для удаляемого поста */
    SELECT matPath INTO mp FROM post WHERE post.id = postId; /* получить matpath */
    UPDATE post SET post.isDeleted = post.isDeleted & (~1) /* пометить текущий пост восстановленным */
    WHERE post.id = postId;
    UPDATE post SET post.isDeleted = post.isDeleted & (~2) /* предпоследний бит в 0 у потомков */
    WHERE post.mathPath LIKE CONCAT(mp, '.+');
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
    UPDATE post SET post.message = post.Message WHERE posst.id = postId;
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
/*!50003 DROP PROCEDURE IF EXISTS `threadCreate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `threadCreate`(IN threadParentForumShortName VARCHAR(255), IN threadTitle VARCHAR(255), IN threadIsClosed TINYINT, IN threadFounderEmail VARCHAR(255), IN threadDate TIMESTAMP, IN threadMessage TEXT,
								IN threadSlug VARCHAR(255), IN threadIsDeleted TINYINT)
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
		SELECT * FROM post
        WHERE post.idThread = threadId AND post.date >= sinceDate
        ORDER BY post.date DESC
        LIMIT lim;
    ELSE
		SELECT * FROM post
        WHERE post.idThread = threadId AND post.date >= sinceDate
        ORDER BY post.date ASC
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
		SELECT * FROM post AS p1
        WHERE p1.firstIndex IN (
			SELECT * FROM (
				SELECT DISTINCT p1.firstIndex ORDER BY p1.firstIndex DESC LIMIT lim
            ) AS p2
        )
        ORDER BY p1.firstIndex DESC, p1.matPath ASC;
    ELSE
		SELECT * FROM post AS p1
        WHERE p1.firstIndex IN (
			SELECT * FROM (
				SELECT DISTINCT p1.firstIndex ORDER BY p1.firstIndex ASC LIMIT lim
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `threadListPostsTree`(IN threadId INT, IN lim INT, IN ord CHAR(5), IN sinceDate TIMESTAMP)
BEGIN
	IF (ord = 'desc') THEN
		SELECT * FROM post
        WHERE post.idThread = threadId AND post.date >= sinceDate
        ORDER BY firstIndex DESC, post.matPath ASC
        LIMIT lim;
    ELSE
		SELECT post.* FROM post
        WHERE post.idThread = threadId AND post.date >= sinceDate
        ORDER BY post.matPath ASC
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
		SELECT * FROM thread WHERE thread.idUser = founderId ORDER BY thread.date DESC LIMIT lim;
	ELSE
		SELECT * FROM thread WHERE thread.idUser = founderId ORDER BY thread.date ASC LIMIT lim;
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `threadListThreadsByParentForum`(IN parentShortName VARCHAR(255), IN lim INT, IN ord CHAR(5), IN sinceDate TIMESTAMP)
BEGIN
	/* перечислить треды по имени форума */
    DECLARE forumId INT;
    SELECT id INTO forumId FROM forum WHERE forum.shortName = parentShortName;
    IF (ord = 'desc') THEN
		SELECT * FROM thread WHERE thread.idForum = forumId ORDER BY thread.date DESC LIMIT lim;
	ELSE
		SELECT * FROM thread WHERE thread.idForum = forumId ORDER BY thread.date ASC LIMIT lim;
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
    UPDATE thread SET thread.isDeleted = 1 WHERE thread.id = threadId;
    /* помечаем внутренние посты удаленными - ставим третий бит с конца в их полях isDeleted */
    UPDATE post SET post.isDeleted = post.isDeleted | 4 WHERE post.idThread = threadId;
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
    DELETE FROM threadSubscribers WHERE thread.idThread = threadId AND thread.idUser = userId; /*удаляем пару*/
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `threadUpdate`(IN threadId INT, IN threadSlug VARCHAR(255), IN threadMessage TEXT)
BEGIN
	UPDATE thread SET thread.slug = thredSlug, thread.Message = threadMessage WHERE thread.id = threadId;
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
/*!50003 DROP PROCEDURE IF EXISTS `userCreate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `userCreate`( IN userEmail VARCHAR(255), IN userUserName VARCHAR(255), IN userName VARCHAR(255), IN userAbout TEXT, IN userIsAnonymous TINYINT)
BEGIN
	/* Просто вставка в таблицу пользователей*/
	INSERT INTO user VALUES(null, userEmail, userUserName, userName, userAbout, userIsAnonymous);
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
	/*Получить id следящего и ведущего по email из таблицы пользователей*/
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
/*!50003 DROP PROCEDURE IF EXISTS `userGetEmailsOfFolloweesByUserEmail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `userGetEmailsOfFolloweesByUserEmail`(IN userEmail VARCHAR(255))
BEGIN
	DECLARE userId INT;
    SELECT id INTO userId FROM user WHERE email = userEmail;
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
/*!50003 DROP PROCEDURE IF EXISTS `userGetEmailsOfFollowersByUserEmail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `userGetEmailsOfFollowersByUserEmail`(IN userEmail VARCHAR(255))
BEGIN
	DECLARE userId INT;
    SELECT id INTO userId FROM user WHERE email = userEmail;
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `userListFolloweesByUserEmail`(IN userEmail VARCHAR(255), IN lim INT, IN ord VARCHAR(5), IN since_id INT)
BEGIN
	/*получение тех, за кем следит пользователь*/
    /*если не указан lim - передать max_int*/
    /*если не указан ord - передать desc*/
    /*если не указан since_id - передать -1*/
    /* получим id по email */
	DECLARE userId INT;
    SELECT id INTO userId FROM user WHERE email = userEmail;
    /* Варианты сортировки по убыванию и возрастанию */
    IF (ord = 'desc') THEN
		SELECT DISTINCT u2.* FROM  /* DISTINCT на всякий случай */
		user AS u1 /* взять 1 экземпляр таблицы с юзерами */
		JOIN userFollowers AS f ON u1.id = userId AND u1.id = f.idFollower  /* соединить с таблицей Followers, по id следящего пользователя */
		JOIN user AS u2 ON f.idFollowee = u2.id /* соединить результат со второй табл. пользователей по id последователя */
		WHERE u2.id >= since_id /* во второй таблице оказались ведущие, которых надо отфильтровать */
		ORDER BY u2.name DESC
        LIMIT lim;
	ELSE /* аналогично */
		SELECT DISTINCT u2.* FROM 
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `userListFollowersByUserEmail`(IN userEmail VARCHAR(255), IN lim INT, IN ord VARCHAR(5), IN since_id INT)
BEGIN
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
		WHERE u2.id >= since_id /* во второй таблице оказались последователи, которых надо отфильтровать */
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
		SELECT * /* выбрать все столбцы из постов */
        FROM post
        WHERE post.idUser = userId AND post.date >= since_date /* которые написал юзер с этим id после опр даты */
        ORDER BY post.date DESC /* упорядочить по дате по убыванию */
        LIMIT lim; /* ограничить число */
	ELSE
		SELECT * 
        FROM post
        WHERE post.idUser = userId AND post.date >= since_date
        ORDER BY post.date ASC
        LIMIT lim;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `userListSubscriptionsByEmail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `userListSubscriptionsByEmail`(IN userEmail VARCHAR(255))
BEGIN
	/* перечислить посты, на которые подписан пользователь */
    /* получить id пользователя по email */
	DECLARE userId INT;
    SELECT id INTO userId FROM user WHERE email = userEmail;
    /* из таблицы подписок выбираем id тредов по id gjkmpjdfntkz */
	SELECT DISTINCT (idThread) FROM threadSubscribers
    WHERE idUser = userId;
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

-- Dump completed on 2016-03-27 21:36:08

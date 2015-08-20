-- MySQL dump 10.13  Distrib 5.5.20, for Linux (x86_64)
--
-- Host: localhost    Database: pwntter
-- ------------------------------------------------------
-- Server version	5.5.20-log

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
-- Table structure for table `direct_messages`
--

DROP TABLE IF EXISTS `direct_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `direct_messages` (
  `id` bigint(20) unsigned NOT NULL,
  `sender_id` bigint(20) NOT NULL,
  `text` varchar(140) NOT NULL,
  `recipient_id` bigint(20) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `sender_screen_name` varchar(20) NOT NULL,
  `recipient_screen_name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sender_id_index` (`sender_id`),
  KEY `recipient_id_index` (`recipient_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Direct Messages';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tweets`
--

DROP TABLE IF EXISTS `tweets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tweets` (
  `id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `screen_name` varchar(20) NOT NULL,
  `text` varchar(163) NOT NULL,
  `created_at` datetime NOT NULL,
  `source` varchar(256) NOT NULL,
  `truncated` tinyint(1) NOT NULL DEFAULT '0',
  `user_name` varchar(40) NOT NULL,
  `geo_lat` varchar(50) DEFAULT NULL,
  `geo_long` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Tweets';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL,
  `name` varchar(20) NOT NULL,
  `screen_name` varchar(20) NOT NULL,
  `location` varchar(128) DEFAULT NULL,
  `description` varchar(256) DEFAULT NULL,
  `profile_image_url` text NOT NULL,
  `url` text,
  `protected` tinyint(1) NOT NULL DEFAULT '0',
  `followers_count` bigint(20) DEFAULT '0',
  `friends_count` bigint(20) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `favourites_count` bigint(20) DEFAULT '0',
  `utc_offset` int(11) NOT NULL DEFAULT '0',
  `time_zone` tinytext,
  `statuses_count` bigint(20) DEFAULT NULL,
  `following` tinyint(1) NOT NULL DEFAULT '0',
  `verified` tinyint(1) NOT NULL DEFAULT '0',
  `geo_enabled` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `screen_name_index` (`screen_name`),
  KEY `name_index` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Twitter User Information';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-02-05  8:35:51

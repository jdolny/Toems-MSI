create database theopenem;
use theopenem;
-- MySQL dump 10.16  Distrib 10.3.10-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: theopenem
-- ------------------------------------------------------
-- Server version	10.3.10-MariaDB

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
-- Table structure for table `active_client_policies`
--

DROP TABLE IF EXISTS `active_client_policies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `active_client_policies` (
  `active_client_policy_id` int(11) NOT NULL AUTO_INCREMENT,
  `policy_id` int(11) NOT NULL,
  `json_string` text NOT NULL,
  PRIMARY KEY (`active_client_policy_id`),
  UNIQUE KEY `policy_id_UNIQUE` (`policy_id`),
  CONSTRAINT `AP_POLICY_FK` FOREIGN KEY (`policy_id`) REFERENCES `policies` (`policy_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `active_client_policies`
--

LOCK TABLES `active_client_policies` WRITE;
/*!40000 ALTER TABLE `active_client_policies` DISABLE KEYS */;
/*!40000 ALTER TABLE `active_client_policies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `active_group_policy`
--

DROP TABLE IF EXISTS `active_group_policy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `active_group_policy` (
  `active_group_policy_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `json_string` text NOT NULL,
  PRIMARY KEY (`active_group_policy_id`),
  UNIQUE KEY `group_id_UNIQUE` (`group_id`),
  CONSTRAINT `GP_GROUP_FK` FOREIGN KEY (`group_id`) REFERENCES `groups` (`group_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `active_group_policy`
--

LOCK TABLES `active_group_policy` WRITE;
/*!40000 ALTER TABLE `active_group_policy` DISABLE KEYS */;
/*!40000 ALTER TABLE `active_group_policy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `active_imaging_tasks`
--

DROP TABLE IF EXISTS `active_imaging_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `active_imaging_tasks` (
  `active_task_id` int(11) NOT NULL AUTO_INCREMENT,
  `task_arguments` varchar(1000) DEFAULT NULL,
  `task_completed` varchar(200) DEFAULT NULL,
  `computer_id` int(11) NOT NULL,
  `task_elapsed` varchar(200) DEFAULT NULL,
  `multicast_id` int(11) NOT NULL,
  `task_partition` varchar(100) DEFAULT NULL,
  `task_queue_position` int(11) NOT NULL,
  `task_rate` varchar(200) DEFAULT NULL,
  `task_remaining` varchar(200) DEFAULT NULL,
  `task_status` int(11) NOT NULL,
  `task_type` varchar(100) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `com_server_id` int(11) NOT NULL,
  `last_update_time_utc` datetime DEFAULT NULL,
  `image_profile_id` int(11) NOT NULL,
  PRIMARY KEY (`active_task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `active_imaging_tasks`
--

LOCK TABLES `active_imaging_tasks` WRITE;
/*!40000 ALTER TABLE `active_imaging_tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `active_imaging_tasks` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `theopenem`.`active_imaging_tasks_BEFORE_INSERT` BEFORE INSERT ON `theopenem`.`active_imaging_tasks` FOR EACH ROW
BEGIN
set new.last_update_time_utc=utc_timestamp();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `theopenem`.`active_imaging_tasks_BEFORE_UPDATE` BEFORE UPDATE ON `theopenem`.`active_imaging_tasks` FOR EACH ROW
BEGIN
set new.last_update_time_utc=utc_timestamp();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `active_multicast_sessions`
--

DROP TABLE IF EXISTS `active_multicast_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `active_multicast_sessions` (
  `multicast_session_id` int(11) NOT NULL AUTO_INCREMENT,
  `ond_image_profile_id` int(11) NOT NULL,
  `multicast_name` varchar(50) DEFAULT NULL,
  `multicast_pid` int(11) NOT NULL,
  `multicast_port` int(11) NOT NULL,
  `com_server_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `upload_task_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`multicast_session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `active_multicast_sessions`
--

LOCK TABLES `active_multicast_sessions` WRITE;
/*!40000 ALTER TABLE `active_multicast_sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `active_multicast_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `active_socket_connections`
--

DROP TABLE IF EXISTS `active_socket_connections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `active_socket_connections` (
  `active_socket_connection_id` int(11) NOT NULL AUTO_INCREMENT,
  `computer_id` int(11) NOT NULL,
  `connection_id` varchar(255) NOT NULL,
  `com_server` varchar(255) NOT NULL,
  PRIMARY KEY (`active_socket_connection_id`),
  KEY `fk_asc_comp_idx` (`computer_id`),
  CONSTRAINT `fk_asc_comp` FOREIGN KEY (`computer_id`) REFERENCES `computers` (`computer_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `active_socket_connections`
--

LOCK TABLES `active_socket_connections` WRITE;
/*!40000 ALTER TABLE `active_socket_connections` DISABLE KEYS */;
/*!40000 ALTER TABLE `active_socket_connections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_settings`
--

DROP TABLE IF EXISTS `admin_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_settings` (
  `admin_setting_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_setting_name` varchar(255) DEFAULT NULL,
  `admin_setting_value` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`admin_setting_id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_settings`
--

LOCK TABLES `admin_settings` WRITE;
/*!40000 ALTER TABLE `admin_settings` DISABLE KEYS */;
INSERT INTO `admin_settings` VALUES (1,'AD Login Domain',''),(2,'Approve Report Cron','0 7,15 * * *'),(3,'Audit Log Auto Delete Days','400'),(4,'Certificate Organization',''),(5,'Checkin Interval','60'),(6,'Computer Auto Archive Days','90'),(7,'Computer Auto Delete Days','400'),(8,'Computer Process Auto Delete Days','400'),(9,'Data Cleanup Cron','0 4 * * *'),(10,'Dynamic Group Cron','15 */3 * * *'),(11,'Folder Sync Cron','30 */4 * * *'),(12,'Intercom Key Encrypted',NULL),(13,'Ldap Auth Attribute','samaccountname'),(14,'Ldap Auth Type','Secure'),(15,'Ldap Base DN',''),(16,'Ldap Bind Password Encrypted',''),(17,'Ldap Bind Username',''),(18,'Ldap Enabled','1'),(19,'Ldap Port','389'),(20,'Ldap Server',''),(21,'LDAP Sync Cron','0 1 * * *'),(22,'Policy History Auto Delete Days','730'),(23,'PreProvision Requires Approval','1'),(24,'Provision Key Encrypted',NULL),(25,'Require PreProvision','1'),(26,'Require Provision Approval','1'),(27,'Require Reset Requests','1'),(28,'Reset Report Cron','0 7,15 * * *'),(29,'Shutdown Delay','60'),(30,'Smart Report Cron','0 2 * * *'),(31,'Smtp Enabled','0'),(32,'Smtp Mail From',''),(33,'Smtp Mail To',''),(34,'Smtp Password Encrypted',''),(35,'Smtp Port','25'),(36,'Smtp Server',''),(37,'Smtp Ssl','No'),(38,'Smtp Username',''),(39,'Startup Delay Sub',''),(40,'Startup Delay Type','0'),(41,'Storage Domain',''),(42,'Storage Password Encrypted',''),(43,'Storage Path',''),(44,'Storage Type','Local'),(45,'Storage Username',''),(46,'Threshold Window','90'),(47,'User Login History Auto Delete Days','730'),(48,'Remote Access Server',''),(49,'Remote Access Admin Password Encrypted',''),(50,'Remote Access Control Password Encrypted',''),(51,'Remote Access View Password Encrypted',''),(52,'Remote Access Status','0'),(54,'Proxy Dhcp','No'),(56,'PXE Bootloader','ipxe'),(58,'Proxy Bios Bootloader','ipxe'),(59,'Proxy Efi32 Bootloader','ipxe_efi'),(60,'Proxy Efi64 Bootloader','ipxe_efi'),(65,'iPXE Requires Login','False'),(67,'iPXE SSL','False'),(68,'Global Imaging Arguments',''),(69,'iPXE Http Port','8088'),(72,'Web Tasks Require Login','False'),(73,'Console Tasks Require Login','True'),(74,'Global Imaging Token',''),(75,'Low Disk Cron','0 3 * * *'),(76,'Imaging Logs Auto Delete Days','180'),(78,'Image Task Timeout Minutes','240'),(79,'Registration Enabled','Yes'),(80,'Disabled Registration Name Prompt','Yes');
/*!40000 ALTER TABLE `admin_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `antivirus_inventory`
--

DROP TABLE IF EXISTS `antivirus_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `antivirus_inventory` (
  `antivirus_inventory_id` int(11) NOT NULL AUTO_INCREMENT,
  `computer_id` int(11) NOT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `rt_scanner` varchar(50) DEFAULT NULL,
  `definition_status` varchar(50) DEFAULT NULL,
  `product_state` int(11) DEFAULT NULL,
  PRIMARY KEY (`antivirus_inventory_id`),
  KEY `fk_av_comp_idx` (`computer_id`),
  CONSTRAINT `fk_av_comp` FOREIGN KEY (`computer_id`) REFERENCES `computers` (`computer_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `antivirus_inventory`
--

LOCK TABLES `antivirus_inventory` WRITE;
/*!40000 ALTER TABLE `antivirus_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `antivirus_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `approval_requests`
--

DROP TABLE IF EXISTS `approval_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `approval_requests` (
  `approval_request_id` int(11) NOT NULL AUTO_INCREMENT,
  `computer_name` varchar(45) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `request_time_utc` datetime DEFAULT NULL,
  `requestor_installation_id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`approval_request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `approval_requests`
--

LOCK TABLES `approval_requests` WRITE;
/*!40000 ALTER TABLE `approval_requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `approval_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset_attachments`
--

DROP TABLE IF EXISTS `asset_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset_attachments` (
  `asset_attachment_id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_id` int(11) NOT NULL,
  `attachment_id` int(11) NOT NULL,
  PRIMARY KEY (`asset_attachment_id`),
  KEY `fk_asset_attach_idx` (`attachment_id`),
  KEY `fk_assetattach_asset_idx` (`asset_id`),
  CONSTRAINT `fk_asset_attach` FOREIGN KEY (`attachment_id`) REFERENCES `attachments` (`attachment_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_assetattach_asset` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`asset_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_attachments`
--

LOCK TABLES `asset_attachments` WRITE;
/*!40000 ALTER TABLE `asset_attachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `asset_attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset_attributes`
--

DROP TABLE IF EXISTS `asset_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset_attributes` (
  `asset_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_id` int(11) NOT NULL,
  `custom_attribute_id` int(11) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`asset_attribute_id`),
  KEY `fk_asset_attrib_asset_idx` (`asset_id`),
  KEY `fk_asset_attrib_attrib_idx` (`custom_attribute_id`),
  CONSTRAINT `fk_asset_attrib_asset` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`asset_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_asset_attrib_attrib` FOREIGN KEY (`custom_attribute_id`) REFERENCES `custom_attributes` (`custom_attribute_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_attributes`
--

LOCK TABLES `asset_attributes` WRITE;
/*!40000 ALTER TABLE `asset_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `asset_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset_comments`
--

DROP TABLE IF EXISTS `asset_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset_comments` (
  `asset_comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_id` int(11) NOT NULL,
  `comment_id` int(11) NOT NULL,
  PRIMARY KEY (`asset_comment_id`),
  KEY `fk_assetcomment_asset_idx` (`asset_id`),
  KEY `fk_assetcomment_comment_idx` (`comment_id`),
  CONSTRAINT `fk_assetcomment_asset` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`asset_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_assetcomment_comment` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`comment_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_comments`
--

LOCK TABLES `asset_comments` WRITE;
/*!40000 ALTER TABLE `asset_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `asset_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset_group_members`
--

DROP TABLE IF EXISTS `asset_group_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset_group_members` (
  `asset_group_member_id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_group_id` int(11) NOT NULL,
  `asset_id` int(11) NOT NULL,
  PRIMARY KEY (`asset_group_member_id`),
  KEY `fk_assetgrmem_group_idx` (`asset_group_id`),
  KEY `fk_assetgrmem_asset_idx` (`asset_id`),
  CONSTRAINT `fk_assetgrmem_asset` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`asset_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_assetgrmem_group` FOREIGN KEY (`asset_group_id`) REFERENCES `asset_groups` (`asset_group_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_group_members`
--

LOCK TABLES `asset_group_members` WRITE;
/*!40000 ALTER TABLE `asset_group_members` DISABLE KEYS */;
/*!40000 ALTER TABLE `asset_group_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset_groups`
--

DROP TABLE IF EXISTS `asset_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset_groups` (
  `asset_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`asset_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_groups`
--

LOCK TABLES `asset_groups` WRITE;
/*!40000 ALTER TABLE `asset_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `asset_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets` (
  `asset_id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_type_id` int(11) NOT NULL,
  `asset_display_name` varchar(45) NOT NULL,
  `is_archived` tinyint(4) DEFAULT 0,
  `archived_datetime_local` datetime DEFAULT NULL,
  PRIMARY KEY (`asset_id`),
  KEY `fk_asset_type_idx` (`asset_type_id`),
  CONSTRAINT `fk_asset_type` FOREIGN KEY (`asset_type_id`) REFERENCES `custom_asset_types` (`custom_asset_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attachments`
--

DROP TABLE IF EXISTS `attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attachments` (
  `attachment_id` int(11) NOT NULL AUTO_INCREMENT,
  `attachment_name` varchar(255) NOT NULL,
  `attachment_time_local` datetime NOT NULL,
  `directory_guid` varchar(45) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`attachment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attachments`
--

LOCK TABLES `attachments` WRITE;
/*!40000 ALTER TABLE `attachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audit_logs`
--

DROP TABLE IF EXISTS `audit_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audit_logs` (
  `audit_log_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `audit_type` tinyint(11) DEFAULT NULL,
  `object_type` varchar(45) DEFAULT NULL,
  `object_id` int(11) DEFAULT NULL,
  `object_name` varchar(45) DEFAULT NULL,
  `date_time_local` datetime DEFAULT NULL,
  `user_name` varchar(45) DEFAULT NULL,
  `object_json` text DEFAULT NULL,
  PRIMARY KEY (`audit_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_logs`
--

LOCK TABLES `audit_logs` WRITE;
/*!40000 ALTER TABLE `audit_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `audit_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bios_inventory`
--

DROP TABLE IF EXISTS `bios_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bios_inventory` (
  `bios_inventory_id` int(11) NOT NULL AUTO_INCREMENT,
  `computer_id` int(11) NOT NULL,
  `serial_number` varchar(45) DEFAULT NULL,
  `version` varchar(45) DEFAULT NULL,
  `sm_bios_version` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`bios_inventory_id`),
  KEY `fk_biosinven_computer_idx` (`computer_id`),
  CONSTRAINT `fk_biosinven_computer` FOREIGN KEY (`computer_id`) REFERENCES `computers` (`computer_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bios_inventory`
--

LOCK TABLES `bios_inventory` WRITE;
/*!40000 ALTER TABLE `bios_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `bios_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bitlocker_inventory`
--

DROP TABLE IF EXISTS `bitlocker_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bitlocker_inventory` (
  `bitlocker_inventory_id` int(11) NOT NULL AUTO_INCREMENT,
  `computer_id` int(11) NOT NULL,
  `drive_letter` varchar(45) DEFAULT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`bitlocker_inventory_id`),
  KEY `fk_bitlocker_computer_idx` (`computer_id`),
  CONSTRAINT `fk_bitlocker_computer` FOREIGN KEY (`computer_id`) REFERENCES `computers` (`computer_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bitlocker_inventory`
--

LOCK TABLES `bitlocker_inventory` WRITE;
/*!40000 ALTER TABLE `bitlocker_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `bitlocker_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(45) NOT NULL,
  `category_description` text DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certificate_inventory`
--

DROP TABLE IF EXISTS `certificate_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certificate_inventory` (
  `certificate_inventory_id` int(11) NOT NULL AUTO_INCREMENT,
  `store` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `subject` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  `friendlyname` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  `thumbprint` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `serial` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `issuer` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  `notbefore_utc` datetime DEFAULT NULL,
  `notafter_utc` datetime DEFAULT NULL,
  PRIMARY KEY (`certificate_inventory_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificate_inventory`
--

LOCK TABLES `certificate_inventory` WRITE;
/*!40000 ALTER TABLE `certificate_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `certificate_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certificates`
--

DROP TABLE IF EXISTS `certificates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certificates` (
  `certificate_id` int(11) NOT NULL AUTO_INCREMENT,
  `serial_number` varchar(45) DEFAULT NULL,
  `subject_name` varchar(255) DEFAULT NULL,
  `pfx_blob` blob DEFAULT NULL,
  `pfx_password_enc` varchar(45) DEFAULT NULL,
  `not_before_utc` date DEFAULT NULL,
  `not_after_utc` date DEFAULT NULL,
  `is_revoked` tinyint(4) DEFAULT NULL,
  `revoked_date_utc` date DEFAULT NULL,
  `certificate_type` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`certificate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificates`
--

LOCK TABLES `certificates` WRITE;
/*!40000 ALTER TABLE `certificates` DISABLE KEYS */;
/*!40000 ALTER TABLE `certificates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_com_servers`
--

DROP TABLE IF EXISTS `client_com_servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_com_servers` (
  `client_com_server_id` int(11) NOT NULL AUTO_INCREMENT,
  `display_name` varchar(45) NOT NULL,
  `description` text DEFAULT NULL,
  `url` varchar(255) NOT NULL,
  `replicate_storage` tinyint(4) NOT NULL DEFAULT 1,
  `is_imaging_server` tinyint(4) NOT NULL DEFAULT 1,
  `is_tftp_server` tinyint(4) NOT NULL DEFAULT 1,
  `is_multicast_server` tinyint(4) NOT NULL DEFAULT 1,
  `unique_id` varchar(50) NOT NULL,
  `is_em_server` tinyint(4) NOT NULL DEFAULT 1,
  `local_storage_path` varchar(200) DEFAULT NULL,
  `em_max_bps` int(11) NOT NULL DEFAULT 0,
  `em_max_clients` int(11) NOT NULL DEFAULT 0,
  `imaging_max_bps` int(11) NOT NULL DEFAULT 0,
  `imaging_max_clients` int(11) NOT NULL DEFAULT 0,
  `replication_rate_ipg` int(11) NOT NULL DEFAULT 0,
  `tftp_path` varchar(255) DEFAULT NULL,
  `tftp_interface_ip` varchar(50) DEFAULT NULL,
  `multicast_interface_ip` varchar(50) DEFAULT NULL,
  `multicast_start_port` int(11) NOT NULL DEFAULT 9000,
  `multicast_end_port` int(11) NOT NULL DEFAULT 10000,
  `multicast_send_arguments` varchar(255) DEFAULT NULL,
  `multicast_rec_arguments` varchar(255) DEFAULT NULL,
  `decompress_image` varchar(50) DEFAULT NULL,
  `tftp_info_server` tinyint(4) NOT NULL DEFAULT 0,
  `imaging_ip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`client_com_server_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_com_servers`
--

LOCK TABLES `client_com_servers` WRITE;
/*!40000 ALTER TABLE `client_com_servers` DISABLE KEYS */;
/*!40000 ALTER TABLE `client_com_servers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `com_server_cluster_servers`
--

DROP TABLE IF EXISTS `com_server_cluster_servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `com_server_cluster_servers` (
  `com_server_cluster_server_id` int(11) NOT NULL AUTO_INCREMENT,
  `com_server_cluster_id` int(11) NOT NULL,
  `client_com_server_id` int(11) NOT NULL,
  `role` varchar(45) DEFAULT NULL,
  `is_imaging_server` tinyint(4) NOT NULL DEFAULT 1,
  `is_tftp_server` tinyint(4) NOT NULL DEFAULT 1,
  `is_multicast_server` tinyint(4) NOT NULL DEFAULT 1,
  `is_em_server` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`com_server_cluster_server_id`),
  KEY `FK_COM_CLUSTER_idx` (`com_server_cluster_id`),
  KEY `FK_COMSERVER_idx` (`client_com_server_id`),
  CONSTRAINT `FK_COMCLUSTER` FOREIGN KEY (`com_server_cluster_id`) REFERENCES `com_server_clusters` (`com_server_cluster_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_COMSERVER` FOREIGN KEY (`client_com_server_id`) REFERENCES `client_com_servers` (`client_com_server_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `com_server_cluster_servers`
--

LOCK TABLES `com_server_cluster_servers` WRITE;
/*!40000 ALTER TABLE `com_server_cluster_servers` DISABLE KEYS */;
/*!40000 ALTER TABLE `com_server_cluster_servers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `com_server_clusters`
--

DROP TABLE IF EXISTS `com_server_clusters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `com_server_clusters` (
  `com_server_cluster_id` int(11) NOT NULL AUTO_INCREMENT,
  `com_server_cluster_name` varchar(45) NOT NULL,
  `description` text DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`com_server_cluster_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `com_server_clusters`
--

LOCK TABLES `com_server_clusters` WRITE;
/*!40000 ALTER TABLE `com_server_clusters` DISABLE KEYS */;
/*!40000 ALTER TABLE `com_server_clusters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `command_modules`
--

DROP TABLE IF EXISTS `command_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `command_modules` (
  `command_module_id` int(11) NOT NULL AUTO_INCREMENT,
  `command_module_guid` varchar(45) NOT NULL,
  `command_module_name` varchar(45) NOT NULL,
  `command_module_description` text DEFAULT NULL,
  `command_module_command` varchar(255) DEFAULT NULL,
  `command_module_arguments` varchar(255) DEFAULT NULL,
  `command_module_timeout` int(11) DEFAULT NULL,
  `command_module_workingdir` varchar(255) DEFAULT NULL,
  `redirect_stdout` tinyint(4) DEFAULT NULL,
  `redirect_stderror` tinyint(4) DEFAULT NULL,
  `success_codes` varchar(45) DEFAULT NULL,
  `is_archived` tinyint(4) DEFAULT 0,
  `impersonation_id` int(11) DEFAULT -1,
  `datetime_archived_local` datetime DEFAULT NULL,
  PRIMARY KEY (`command_module_id`),
  KEY `CMD_MOD_FK_idx` (`command_module_guid`),
  CONSTRAINT `CMD_MOD_FK` FOREIGN KEY (`command_module_guid`) REFERENCES `modules` (`module_guid`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `command_modules`
--

LOCK TABLES `command_modules` WRITE;
/*!40000 ALTER TABLE `command_modules` DISABLE KEYS */;
/*!40000 ALTER TABLE `command_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_text` text NOT NULL,
  `comment_username` varchar(100) NOT NULL,
  `comment_time_local` datetime NOT NULL,
  PRIMARY KEY (`comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `computer_attachments`
--

DROP TABLE IF EXISTS `computer_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `computer_attachments` (
  `computer_attachment_id` int(11) NOT NULL AUTO_INCREMENT,
  `computer_id` int(11) NOT NULL,
  `attachment_id` int(11) NOT NULL,
  PRIMARY KEY (`computer_attachment_id`),
  KEY `fk_compattach_comp_idx` (`computer_id`),
  KEY `fk_compattach_attach_idx` (`attachment_id`),
  CONSTRAINT `fk_compattach_attach` FOREIGN KEY (`attachment_id`) REFERENCES `attachments` (`attachment_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_compattach_comp` FOREIGN KEY (`computer_id`) REFERENCES `computers` (`computer_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `computer_attachments`
--

LOCK TABLES `computer_attachments` WRITE;
/*!40000 ALTER TABLE `computer_attachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `computer_attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `computer_categories`
--

DROP TABLE IF EXISTS `computer_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `computer_categories` (
  `computer_category_id` int(11) NOT NULL AUTO_INCREMENT,
  `computer_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`computer_category_id`),
  KEY `fk_compcat_comp_idx` (`computer_id`),
  KEY `fk_compcat_cat_idx` (`category_id`),
  KEY `fk_compcat_group_idx` (`group_id`),
  CONSTRAINT `fk_compcat_cat` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_compcat_comp` FOREIGN KEY (`computer_id`) REFERENCES `computers` (`computer_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_compcat_group` FOREIGN KEY (`group_id`) REFERENCES `groups` (`group_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `computer_categories`
--

LOCK TABLES `computer_categories` WRITE;
/*!40000 ALTER TABLE `computer_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `computer_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `computer_certificates`
--

DROP TABLE IF EXISTS `computer_certificates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `computer_certificates` (
  `computer_certificate_id` int(11) NOT NULL AUTO_INCREMENT,
  `computer_id` int(11) NOT NULL,
  `certificate_id` int(11) NOT NULL,
  PRIMARY KEY (`computer_certificate_id`),
  KEY `fk_cc_comp_idx` (`computer_id`),
  KEY `fk_cc_cert_idx` (`certificate_id`),
  CONSTRAINT `fk_cc_cert` FOREIGN KEY (`certificate_id`) REFERENCES `certificate_inventory` (`certificate_inventory_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_cc_comp` FOREIGN KEY (`computer_id`) REFERENCES `computers` (`computer_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `computer_certificates`
--

LOCK TABLES `computer_certificates` WRITE;
/*!40000 ALTER TABLE `computer_certificates` DISABLE KEYS */;
/*!40000 ALTER TABLE `computer_certificates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `computer_comments`
--

DROP TABLE IF EXISTS `computer_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `computer_comments` (
  `computer_comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `computer_id` int(11) NOT NULL,
  `comment_id` int(11) NOT NULL,
  PRIMARY KEY (`computer_comment_id`),
  KEY `fk_compcomm_comp_idx` (`computer_id`),
  KEY `fk_compcomm_comm_idx` (`comment_id`),
  CONSTRAINT `fk_compcomm_comm` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`comment_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_compcomm_comp` FOREIGN KEY (`computer_id`) REFERENCES `computers` (`computer_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `computer_comments`
--

LOCK TABLES `computer_comments` WRITE;
/*!40000 ALTER TABLE `computer_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `computer_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `computer_logs`
--

DROP TABLE IF EXISTS `computer_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `computer_logs` (
  `computer_log_id` int(11) NOT NULL AUTO_INCREMENT,
  `computer_id` int(11) NOT NULL,
  `log_contents` text DEFAULT NULL,
  `log_time` datetime DEFAULT NULL,
  `computer_mac` varchar(50) DEFAULT NULL,
  `log_sub_type` varchar(50) DEFAULT NULL,
  `log_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`computer_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `computer_logs`
--

LOCK TABLES `computer_logs` WRITE;
/*!40000 ALTER TABLE `computer_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `computer_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `computer_process_history`
--

DROP TABLE IF EXISTS `computer_process_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `computer_process_history` (
  `computer_process_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `computer_id` int(11) NOT NULL,
  `process_id` int(11) NOT NULL,
  `username` varchar(45) NOT NULL,
  `start_time_utc` datetime NOT NULL,
  `close_time_utc` datetime NOT NULL,
  PRIMARY KEY (`computer_process_history_id`),
  KEY `fk_process_comp_idx` (`computer_id`),
  KEY `fk_process_process_idx` (`process_id`),
  CONSTRAINT `fk_process_comp` FOREIGN KEY (`computer_id`) REFERENCES `computers` (`computer_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_process_process` FOREIGN KEY (`process_id`) REFERENCES `process_inventory` (`process_inventory_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `computer_process_history`
--

LOCK TABLES `computer_process_history` WRITE;
/*!40000 ALTER TABLE `computer_process_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `computer_process_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `computer_software`
--

DROP TABLE IF EXISTS `computer_software`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `computer_software` (
  `computer_software_id` int(11) NOT NULL AUTO_INCREMENT,
  `computer_id` int(11) NOT NULL,
  `software_id` int(11) NOT NULL,
  PRIMARY KEY (`computer_software_id`),
  KEY `CS_COMPUTER_FK_idx` (`computer_id`),
  KEY `CS_SOFTWARE_FK_idx` (`software_id`),
  CONSTRAINT `CS_COMPUTER_FK` FOREIGN KEY (`computer_id`) REFERENCES `computers` (`computer_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `CS_SOFTWARE_FK` FOREIGN KEY (`software_id`) REFERENCES `software_inventory` (`software_inventory_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `computer_software`
--

LOCK TABLES `computer_software` WRITE;
/*!40000 ALTER TABLE `computer_software` DISABLE KEYS */;
/*!40000 ALTER TABLE `computer_software` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `computer_system_inventory`
--

DROP TABLE IF EXISTS `computer_system_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `computer_system_inventory` (
  `computer_system_inventory_id` int(11) NOT NULL AUTO_INCREMENT,
  `computer_id` int(11) NOT NULL,
  `manufacturer` varchar(45) DEFAULT NULL,
  `model` varchar(45) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `domain` varchar(45) DEFAULT NULL,
  `workgroup` varchar(45) DEFAULT NULL,
  `memory` int(11) DEFAULT 0,
  PRIMARY KEY (`computer_system_inventory_id`),
  KEY `CSI_COMPUTER_FK_idx` (`computer_id`),
  CONSTRAINT `CSI_COMPUTER_FK` FOREIGN KEY (`computer_id`) REFERENCES `computers` (`computer_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `computer_system_inventory`
--

LOCK TABLES `computer_system_inventory` WRITE;
/*!40000 ALTER TABLE `computer_system_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `computer_system_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `computer_updates`
--

DROP TABLE IF EXISTS `computer_updates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `computer_updates` (
  `computer_update_id` int(11) NOT NULL AUTO_INCREMENT,
  `computer_id` int(11) NOT NULL,
  `wu_inventory_id` int(11) NOT NULL,
  `install_date` varchar(45) DEFAULT NULL,
  `is_installed` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`computer_update_id`),
  KEY `FK_U_COMPID_idx` (`computer_id`),
  KEY `FK_U_WUID_idx` (`wu_inventory_id`),
  CONSTRAINT `FK_U_COMPID` FOREIGN KEY (`computer_id`) REFERENCES `computers` (`computer_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_U_WUID` FOREIGN KEY (`wu_inventory_id`) REFERENCES `wu_inventory` (`wu_inventory_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `computer_updates`
--

LOCK TABLES `computer_updates` WRITE;
/*!40000 ALTER TABLE `computer_updates` DISABLE KEYS */;
/*!40000 ALTER TABLE `computer_updates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `computers`
--

DROP TABLE IF EXISTS `computers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `computers` (
  `computer_id` int(11) NOT NULL AUTO_INCREMENT,
  `computer_name` varchar(255) DEFAULT NULL,
  `computer_guid` varchar(45) DEFAULT NULL,
  `provision_status` tinyint(4) DEFAULT 0,
  `certificate_id` int(11) NOT NULL DEFAULT -1,
  `symmetric_key_enc` text DEFAULT NULL,
  `ad_guid` varchar(45) DEFAULT NULL,
  `installation_id` varchar(45) DEFAULT NULL,
  `provisioned_time_local` datetime DEFAULT '0001-01-01 00:00:00',
  `last_checkin_time_local` datetime DEFAULT '0001-01-01 00:00:00',
  `last_ip` varchar(45) DEFAULT NULL,
  `is_ad_sync` tinyint(4) DEFAULT 0,
  `client_version` varchar(45) DEFAULT NULL,
  `last_inventory_time_local` datetime DEFAULT '0001-01-01 00:00:00',
  `push_url` varchar(255) DEFAULT NULL,
  `ad_disabled` tinyint(4) DEFAULT 0,
  `datetime_archived_local` datetime DEFAULT NULL,
  `remote_access_id` varchar(100) DEFAULT NULL,
  `imaging_client_id` varchar(255) DEFAULT NULL,
  `image_id` int(11) NOT NULL DEFAULT -1,
  `image_profile_id` int(11) NOT NULL DEFAULT -1,
  `hardware_uuid` varchar(100) DEFAULT NULL,
  `imaging_mac` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`computer_id`),
  UNIQUE KEY `computer_guid_UNIQUE` (`computer_guid`),
  UNIQUE KEY `installation_id_UNIQUE` (`installation_id`),
  UNIQUE KEY `computer_name_UNIQUE` (`computer_name`),
  KEY `computers_name` (`computer_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `computers`
--

LOCK TABLES `computers` WRITE;
/*!40000 ALTER TABLE `computers` DISABLE KEYS */;
/*!40000 ALTER TABLE `computers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `current_downloads`
--

DROP TABLE IF EXISTS `current_downloads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `current_downloads` (
  `current_download_id` int(11) NOT NULL AUTO_INCREMENT,
  `computer_id` int(11) NOT NULL,
  `last_request_time_local` datetime DEFAULT NULL,
  `com_server` varchar(255) NOT NULL,
  PRIMARY KEY (`current_download_id`),
  KEY `fk_currentdownload_comp_idx` (`computer_id`),
  CONSTRAINT `fk_currentdownload_comp` FOREIGN KEY (`computer_id`) REFERENCES `computers` (`computer_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `current_downloads`
--

LOCK TABLES `current_downloads` WRITE;
/*!40000 ALTER TABLE `current_downloads` DISABLE KEYS */;
/*!40000 ALTER TABLE `current_downloads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_asset_categories`
--

DROP TABLE IF EXISTS `custom_asset_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_asset_categories` (
  `custom_asset_category_id` int(11) NOT NULL AUTO_INCREMENT,
  `custom_asset_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`custom_asset_category_id`),
  KEY `fk_cacat_asset_idx` (`custom_asset_id`),
  KEY `fk_cacat_cat_idx` (`category_id`),
  CONSTRAINT `fk_cacat_asset` FOREIGN KEY (`custom_asset_id`) REFERENCES `assets` (`asset_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_cacat_cat` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_asset_categories`
--

LOCK TABLES `custom_asset_categories` WRITE;
/*!40000 ALTER TABLE `custom_asset_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_asset_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_asset_types`
--

DROP TABLE IF EXISTS `custom_asset_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_asset_types` (
  `custom_asset_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`custom_asset_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_asset_types`
--

LOCK TABLES `custom_asset_types` WRITE;
/*!40000 ALTER TABLE `custom_asset_types` DISABLE KEYS */;
INSERT INTO `custom_asset_types` VALUES (-3,'Built-In Any','The built in any type'),(-2,'Built-In Software','The built in software type'),(-1,'Built-In Computers','The built in computers type');
/*!40000 ALTER TABLE `custom_asset_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_attributes`
--

DROP TABLE IF EXISTS `custom_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_attributes` (
  `custom_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` text DEFAULT NULL,
  `textmode` tinyint(4) DEFAULT 0,
  `usage_type` int(11) NOT NULL DEFAULT -1,
  `client_imaging` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`custom_attribute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_attributes`
--

LOCK TABLES `custom_attributes` WRITE;
/*!40000 ALTER TABLE `custom_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_boot_menu`
--

DROP TABLE IF EXISTS `custom_boot_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_boot_menu` (
  `custom_boot_menu_id` int(11) NOT NULL AUTO_INCREMENT,
  `custom_boot_menu_name` varchar(50) NOT NULL,
  `custom_boot_menu_description` text DEFAULT NULL,
  `custom_boot_menu_type` varchar(50) NOT NULL,
  `custom_boot_menu_order` int(11) NOT NULL,
  `custom_boot_menu_content` text NOT NULL,
  `custom_boot_menu_is_active` tinyint(4) NOT NULL,
  `custom_boot_menu_is_default` tinyint(4) NOT NULL,
  PRIMARY KEY (`custom_boot_menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_boot_menu`
--

LOCK TABLES `custom_boot_menu` WRITE;
/*!40000 ALTER TABLE `custom_boot_menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_boot_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_computer_attributes`
--

DROP TABLE IF EXISTS `custom_computer_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_computer_attributes` (
  `custom_computer_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `computer_id` int(11) NOT NULL,
  `custom_attribute_id` int(11) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`custom_computer_attribute_id`),
  KEY `fk_compattrib_comp_idx` (`computer_id`),
  KEY `fk_compattrib_attrib_idx` (`custom_attribute_id`),
  CONSTRAINT `fk_compattrib_attrib` FOREIGN KEY (`custom_attribute_id`) REFERENCES `custom_attributes` (`custom_attribute_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_compattrib_comp` FOREIGN KEY (`computer_id`) REFERENCES `computers` (`computer_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_computer_attributes`
--

LOCK TABLES `custom_computer_attributes` WRITE;
/*!40000 ALTER TABLE `custom_computer_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_computer_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_inventory`
--

DROP TABLE IF EXISTS `custom_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_inventory` (
  `custom_inventory_id` int(11) NOT NULL AUTO_INCREMENT,
  `computer_id` int(11) NOT NULL,
  `script_module_id` int(11) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`custom_inventory_id`),
  KEY `FK_CI_COMPID_idx` (`computer_id`),
  KEY `FK_CI_SCRIPTID_idx` (`script_module_id`),
  CONSTRAINT `FK_CI_COMPID` FOREIGN KEY (`computer_id`) REFERENCES `computers` (`computer_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_CI_SCRIPTID` FOREIGN KEY (`script_module_id`) REFERENCES `script_modules` (`script_module_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_inventory`
--

LOCK TABLES `custom_inventory` WRITE;
/*!40000 ALTER TABLE `custom_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `external_downloads`
--

DROP TABLE IF EXISTS `external_downloads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `external_downloads` (
  `external_download_id` int(11) NOT NULL AUTO_INCREMENT,
  `file_name` varchar(100) NOT NULL,
  `url` varchar(255) NOT NULL,
  `progress` varchar(45) DEFAULT NULL,
  `status` tinyint(4) DEFAULT 0,
  `error_message` text DEFAULT NULL,
  `sha256_hash` varchar(255) DEFAULT NULL,
  `date_downloaded_local` datetime DEFAULT NULL,
  `module_guid` varchar(45) NOT NULL,
  `md5_hash` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`external_download_id`),
  KEY `fk_extdown_module_idx` (`module_guid`),
  CONSTRAINT `fk_extdown_module` FOREIGN KEY (`module_guid`) REFERENCES `modules` (`module_guid`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_downloads`
--

LOCK TABLES `external_downloads` WRITE;
/*!40000 ALTER TABLE `external_downloads` DISABLE KEYS */;
/*!40000 ALTER TABLE `external_downloads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filecopy_modules`
--

DROP TABLE IF EXISTS `filecopy_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filecopy_modules` (
  `filecopy_module_id` int(11) NOT NULL AUTO_INCREMENT,
  `filecopy_module_guid` varchar(45) NOT NULL,
  `filecopy_module_name` varchar(45) NOT NULL,
  `filecopy_module_description` text DEFAULT NULL,
  `filecopy_module_destination` varchar(255) DEFAULT NULL,
  `filecopy_module_decompress` tinyint(4) DEFAULT NULL,
  `is_archived` tinyint(4) DEFAULT 0,
  `datetime_archived_local` datetime DEFAULT NULL,
  PRIMARY KEY (`filecopy_module_id`),
  KEY `FC_MOD_PK_idx` (`filecopy_module_guid`),
  CONSTRAINT `FC_MOD_PK` FOREIGN KEY (`filecopy_module_guid`) REFERENCES `modules` (`module_guid`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filecopy_modules`
--

LOCK TABLES `filecopy_modules` WRITE;
/*!40000 ALTER TABLE `filecopy_modules` DISABLE KEYS */;
/*!40000 ALTER TABLE `filecopy_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `firewall_inventory`
--

DROP TABLE IF EXISTS `firewall_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `firewall_inventory` (
  `firewall_inventory_id` int(11) NOT NULL AUTO_INCREMENT,
  `computer_id` int(11) DEFAULT NULL,
  `domain_enabled` tinyint(4) DEFAULT 0,
  `private_enabled` tinyint(4) DEFAULT 0,
  `public_enabled` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`firewall_inventory_id`),
  KEY `fk_firwall_comp_idx` (`computer_id`),
  CONSTRAINT `fk_firwall_comp` FOREIGN KEY (`computer_id`) REFERENCES `computers` (`computer_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `firewall_inventory`
--

LOCK TABLES `firewall_inventory` WRITE;
/*!40000 ALTER TABLE `firewall_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `firewall_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_categories`
--

DROP TABLE IF EXISTS `group_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_categories` (
  `group_category_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`group_category_id`),
  KEY `fk_groupcat_group_idx` (`group_id`),
  KEY `fk_groupcat_cat_idx` (`category_id`),
  CONSTRAINT `fk_groupcat_cat` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_groupcat_group` FOREIGN KEY (`group_id`) REFERENCES `groups` (`group_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_categories`
--

LOCK TABLES `group_categories` WRITE;
/*!40000 ALTER TABLE `group_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_memberships`
--

DROP TABLE IF EXISTS `group_memberships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_memberships` (
  `group_membership_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `computer_id` int(11) NOT NULL,
  PRIMARY KEY (`group_membership_id`),
  KEY `GROUP_FK_idx` (`group_id`),
  KEY `COMPUTER_FK_idx` (`computer_id`),
  CONSTRAINT `COMPUTER_FK` FOREIGN KEY (`computer_id`) REFERENCES `computers` (`computer_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `GROUP_FK` FOREIGN KEY (`group_id`) REFERENCES `groups` (`group_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_memberships`
--

LOCK TABLES `group_memberships` WRITE;
/*!40000 ALTER TABLE `group_memberships` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_memberships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_policies`
--

DROP TABLE IF EXISTS `group_policies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_policies` (
  `group_policy_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `policy_id` int(11) NOT NULL,
  `policy_order` int(11) DEFAULT 0,
  PRIMARY KEY (`group_policy_id`),
  KEY `POLICY` (`policy_id`),
  KEY `GROUP` (`group_id`),
  CONSTRAINT `GROUP` FOREIGN KEY (`group_id`) REFERENCES `groups` (`group_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `POLICY` FOREIGN KEY (`policy_id`) REFERENCES `policies` (`policy_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_policies`
--

LOCK TABLES `group_policies` WRITE;
/*!40000 ALTER TABLE `group_policies` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_policies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `group_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(45) NOT NULL,
  `group_description` text DEFAULT NULL,
  `group_dn` text DEFAULT NULL,
  `is_ou` tinyint(4) DEFAULT NULL,
  `group_parent_ou` text DEFAULT NULL,
  `parent_id` varchar(45) DEFAULT NULL,
  `group_type` varchar(45) DEFAULT NULL,
  `cluster_id` int(11) DEFAULT -1,
  `wakeup_schedule_id` int(11) NOT NULL DEFAULT -1,
  `shutdown_schedule_id` int(11) NOT NULL DEFAULT -1,
  `prevent_shutdown` tinyint(4) NOT NULL DEFAULT 0,
  `imaging_priority` int(11) NOT NULL DEFAULT 0,
  `em_priority` int(11) NOT NULL DEFAULT 0,
  `image_id` int(11) NOT NULL DEFAULT -1,
  `image_profile_id` int(11) NOT NULL DEFAULT -1,
  `proxy_bootloader` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hdd_inventory`
--

DROP TABLE IF EXISTS `hdd_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hdd_inventory` (
  `hdd_inventory_id` int(11) NOT NULL AUTO_INCREMENT,
  `computer_id` int(11) NOT NULL,
  `model` varchar(255) DEFAULT NULL,
  `firmware` varchar(255) DEFAULT NULL,
  `serial_number` varchar(255) DEFAULT NULL,
  `size` int(11) DEFAULT 0,
  `smart_status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`hdd_inventory_id`),
  KEY `HD_COMPUTER_FK_idx` (`computer_id`),
  CONSTRAINT `HD_COMPUTER_FK` FOREIGN KEY (`computer_id`) REFERENCES `computers` (`computer_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hdd_inventory`
--

LOCK TABLES `hdd_inventory` WRITE;
/*!40000 ALTER TABLE `hdd_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `hdd_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image_categories`
--

DROP TABLE IF EXISTS `image_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_categories` (
  `image_category_id` int(11) NOT NULL AUTO_INCREMENT,
  `image_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`image_category_id`),
  KEY `fk_imagecatim_idx` (`image_id`),
  KEY `fk_imagecatcat_idx` (`category_id`),
  CONSTRAINT `fk_imagecatcat` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_imagecatim` FOREIGN KEY (`image_id`) REFERENCES `images` (`image_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image_categories`
--

LOCK TABLES `image_categories` WRITE;
/*!40000 ALTER TABLE `image_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `image_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image_profile_file_copy`
--

DROP TABLE IF EXISTS `image_profile_file_copy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_profile_file_copy` (
  `image_profile_file_copy_id` int(11) NOT NULL AUTO_INCREMENT,
  `destination_partition` varchar(45) DEFAULT NULL,
  `filecopy_module_id` int(11) NOT NULL,
  `priority` int(11) NOT NULL,
  `image_profile_id` int(11) NOT NULL,
  PRIMARY KEY (`image_profile_file_copy_id`),
  KEY `fk_imageprofile_idx` (`image_profile_id`),
  KEY `fk_file_idx` (`filecopy_module_id`),
  CONSTRAINT `fk_file` FOREIGN KEY (`filecopy_module_id`) REFERENCES `filecopy_modules` (`filecopy_module_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_imageprofile` FOREIGN KEY (`image_profile_id`) REFERENCES `image_profiles` (`image_profile_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image_profile_file_copy`
--

LOCK TABLES `image_profile_file_copy` WRITE;
/*!40000 ALTER TABLE `image_profile_file_copy` DISABLE KEYS */;
/*!40000 ALTER TABLE `image_profile_file_copy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image_profile_scripts`
--

DROP TABLE IF EXISTS `image_profile_scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_profile_scripts` (
  `image_profile_script_id` int(11) NOT NULL AUTO_INCREMENT,
  `priority` int(11) NOT NULL,
  `image_profile_id` int(11) NOT NULL,
  `run_when` int(11) NOT NULL,
  `script_module_id` int(11) NOT NULL,
  PRIMARY KEY (`image_profile_script_id`),
  KEY `fk_ipscriptscript_idx` (`script_module_id`),
  KEY `fk_ipscriptip_idx` (`image_profile_id`),
  CONSTRAINT `fk_ipscriptip` FOREIGN KEY (`image_profile_id`) REFERENCES `image_profiles` (`image_profile_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_ipscriptscript` FOREIGN KEY (`script_module_id`) REFERENCES `script_modules` (`script_module_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image_profile_scripts`
--

LOCK TABLES `image_profile_scripts` WRITE;
/*!40000 ALTER TABLE `image_profile_scripts` DISABLE KEYS */;
/*!40000 ALTER TABLE `image_profile_scripts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image_profile_sysprep`
--

DROP TABLE IF EXISTS `image_profile_sysprep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_profile_sysprep` (
  `image_profile_sysprep_tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `priority` int(11) NOT NULL,
  `image_profile_id` int(11) NOT NULL,
  `sysprep_module_id` int(11) NOT NULL,
  PRIMARY KEY (`image_profile_sysprep_tag_id`),
  KEY `fk_ipsysprepsysprep_idx` (`sysprep_module_id`),
  KEY `fk_ipsysprepimagep_idx` (`image_profile_id`),
  CONSTRAINT `fk_ipsysprepimagep` FOREIGN KEY (`image_profile_id`) REFERENCES `image_profiles` (`image_profile_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_ipsysprepsysprep` FOREIGN KEY (`sysprep_module_id`) REFERENCES `sysprep_modules` (`sysprep_module_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image_profile_sysprep`
--

LOCK TABLES `image_profile_sysprep` WRITE;
/*!40000 ALTER TABLE `image_profile_sysprep` DISABLE KEYS */;
/*!40000 ALTER TABLE `image_profile_sysprep` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image_profile_templates`
--

DROP TABLE IF EXISTS `image_profile_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_profile_templates` (
  `image_profile_template_id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_boot_image` varchar(50) DEFAULT NULL,
  `change_name` tinyint(4) NOT NULL,
  `compression_algorithm` varchar(45) DEFAULT NULL,
  `compression_level` varchar(45) DEFAULT NULL,
  `custom_partition_script` text DEFAULT NULL,
  `custom_image_schema` text DEFAULT NULL,
  `custom_upload_schema` text DEFAULT NULL,
  `profile_description` text DEFAULT NULL,
  `fix_bcd` tinyint(4) NOT NULL,
  `fix_bootloader` tinyint(4) NOT NULL,
  `force_dynamic_partitions` tinyint(4) NOT NULL,
  `profile_kernel` varchar(45) DEFAULT NULL,
  `profile_kernel_arguments` varchar(255) DEFAULT NULL,
  `profile_name` varchar(45) DEFAULT NULL,
  `partition_method` varchar(45) DEFAULT NULL,
  `multicast_receiver_arguments` varchar(255) DEFAULT NULL,
  `remove_gpt_structures` tinyint(4) NOT NULL,
  `multicast_sender_arguments` varchar(255) DEFAULT NULL,
  `skip_core_download` tinyint(4) NOT NULL,
  `skip_volume_expand` tinyint(4) NOT NULL,
  `skip_lvm_shrink` tinyint(4) NOT NULL,
  `skip_volume_shrink` tinyint(4) NOT NULL,
  `task_completed_action` varchar(45) DEFAULT NULL,
  `upload_schema_only` tinyint(4) NOT NULL,
  `web_cancel` tinyint(4) NOT NULL,
  `skip_nvram` tinyint(4) NOT NULL,
  `randomize_guids` tinyint(4) NOT NULL,
  `force_standard_efi` tinyint(4) NOT NULL,
  `force_standard_legacy` tinyint(4) NOT NULL,
  `simple_upload_schema` tinyint(4) NOT NULL,
  `template_type` tinyint(4) NOT NULL,
  `skip_hibernation_check` tinyint(4) NOT NULL,
  `skip_bitlocker_check` tinyint(4) NOT NULL,
  PRIMARY KEY (`image_profile_template_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image_profile_templates`
--

LOCK TABLES `image_profile_templates` WRITE;
/*!40000 ALTER TABLE `image_profile_templates` DISABLE KEYS */;
INSERT INTO `image_profile_templates` VALUES (1,'initrd.xz',1,'lz4','1','','','','',1,1,0,'5.6.4x64','','Default LIE Block','Dynamic','',0,'',0,0,0,0,'Reboot',0,1,0,0,0,0,0,0,0,0),(2,'initrd.xz',1,'gzip','1','','','','',1,1,0,'5.6.4x64','','Default LIE File','Dynamic','',0,'',0,1,1,1,'Reboot',0,1,0,0,0,0,0,1,0,0),(3,'debug.xz',1,'gzip','1','','','','',1,1,1,'5.6.4.5x64','','Default WIE','Dynamic','',1,'',0,1,1,1,'Reboot',0,1,1,1,0,0,0,2,1,1);
/*!40000 ALTER TABLE `image_profile_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image_profiles`
--

DROP TABLE IF EXISTS `image_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_profiles` (
  `image_profile_id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_boot_image` varchar(50) DEFAULT NULL,
  `change_name` tinyint(4) NOT NULL,
  `compression_algorithm` varchar(50) DEFAULT NULL,
  `compression_level` varchar(45) DEFAULT NULL,
  `custom_partition_script` text DEFAULT NULL,
  `custom_image_schema` text DEFAULT NULL,
  `custom_upload_schema` text DEFAULT NULL,
  `profile_description` text DEFAULT NULL,
  `fix_bcd` tinyint(4) NOT NULL,
  `fix_bootloader` tinyint(4) NOT NULL,
  `force_dynamic_partitions` tinyint(4) NOT NULL,
  `image_id` int(11) NOT NULL,
  `profile_kernel` varchar(45) DEFAULT NULL,
  `profile_kernel_arguments` varchar(255) DEFAULT NULL,
  `profile_name` varchar(45) DEFAULT NULL,
  `partition_method` varchar(45) DEFAULT NULL,
  `multicast_receiver_arguments` varchar(255) DEFAULT NULL,
  `remove_gpt_structures` tinyint(4) NOT NULL,
  `multicast_sender_arguments` varchar(255) DEFAULT NULL,
  `skip_core_download` tinyint(4) NOT NULL,
  `skip_volume_expand` tinyint(4) NOT NULL,
  `skip_lvm_shrink` tinyint(4) NOT NULL,
  `skip_volume_shrink` tinyint(4) NOT NULL,
  `task_completed_action` varchar(45) DEFAULT NULL,
  `upload_schema_only` tinyint(4) NOT NULL,
  `web_cancel` tinyint(4) NOT NULL,
  `skip_nvram` tinyint(4) NOT NULL,
  `randomize_guids` tinyint(4) NOT NULL,
  `force_standard_efi` tinyint(4) NOT NULL,
  `force_standard_legacy` tinyint(4) NOT NULL,
  `simple_upload_schema` tinyint(4) NOT NULL,
  `model_match` varchar(50) DEFAULT NULL,
  `model_match_type` varchar(50) DEFAULT NULL,
  `skip_hibernation_check` tinyint(4) NOT NULL,
  `skip_bitlocker_check` tinyint(4) NOT NULL,
  PRIMARY KEY (`image_profile_id`),
  KEY `fk_ipimage_idx` (`image_id`),
  CONSTRAINT `fk_ipimage` FOREIGN KEY (`image_id`) REFERENCES `images` (`image_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image_profiles`
--

LOCK TABLES `image_profiles` WRITE;
/*!40000 ALTER TABLE `image_profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `image_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `images` (
  `image_id` int(11) NOT NULL AUTO_INCREMENT,
  `image_description` text DEFAULT NULL,
  `image_enabled` tinyint(4) NOT NULL,
  `image_environment` varchar(50) DEFAULT NULL,
  `image_is_viewable_ond` tinyint(4) NOT NULL,
  `last_upload_guid` varchar(50) DEFAULT NULL,
  `image_name` varchar(50) NOT NULL,
  `image_is_protected` tinyint(4) NOT NULL,
  `image_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`image_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imaging_client_ids`
--

DROP TABLE IF EXISTS `imaging_client_ids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imaging_client_ids` (
  `imaging_client_id` int(11) NOT NULL AUTO_INCREMENT,
  `computer_id` int(11) NOT NULL,
  `computer_client_id` varchar(255) NOT NULL,
  PRIMARY KEY (`imaging_client_id`),
  KEY `fk_imageidcomp_idx` (`computer_id`),
  CONSTRAINT `fk_imageidcomp` FOREIGN KEY (`computer_id`) REFERENCES `computers` (`computer_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imaging_client_ids`
--

LOCK TABLES `imaging_client_ids` WRITE;
/*!40000 ALTER TABLE `imaging_client_ids` DISABLE KEYS */;
/*!40000 ALTER TABLE `imaging_client_ids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `impersonation_accounts`
--

DROP TABLE IF EXISTS `impersonation_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `impersonation_accounts` (
  `impersonation_account_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password_encrypted` varchar(45) NOT NULL,
  `impersonation_guid` varchar(45) NOT NULL,
  PRIMARY KEY (`impersonation_account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `impersonation_accounts`
--

LOCK TABLES `impersonation_accounts` WRITE;
/*!40000 ALTER TABLE `impersonation_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `impersonation_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logical_volume_inventory`
--

DROP TABLE IF EXISTS `logical_volume_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logical_volume_inventory` (
  `logical_volume_inventory_id` int(11) NOT NULL AUTO_INCREMENT,
  `computer_id` int(11) NOT NULL,
  `drive` varchar(45) DEFAULT NULL,
  `free_space_gb` int(11) DEFAULT NULL,
  `free_space_percent` int(11) DEFAULT NULL,
  `size_gb` int(11) DEFAULT NULL,
  PRIMARY KEY (`logical_volume_inventory_id`),
  KEY `fk_lv_comp_idx` (`computer_id`),
  CONSTRAINT `fk_lv_comp` FOREIGN KEY (`computer_id`) REFERENCES `computers` (`computer_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logical_volume_inventory`
--

LOCK TABLES `logical_volume_inventory` WRITE;
/*!40000 ALTER TABLE `logical_volume_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `logical_volume_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_modules`
--

DROP TABLE IF EXISTS `message_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_modules` (
  `message_module_id` int(11) NOT NULL AUTO_INCREMENT,
  `message_module_guid` varchar(45) NOT NULL,
  `message_module_name` varchar(45) NOT NULL,
  `message_module_description` text DEFAULT NULL,
  `message_module_title` varchar(45) DEFAULT NULL,
  `message_module_message` text DEFAULT NULL,
  `message_module_timeout` int(11) NOT NULL,
  `is_archived` tinyint(4) DEFAULT 0,
  `datetime_archived_local` datetime DEFAULT NULL,
  PRIMARY KEY (`message_module_id`),
  KEY `FK_MM_MOD_idx` (`message_module_guid`),
  CONSTRAINT `FK_MM_MOD` FOREIGN KEY (`message_module_guid`) REFERENCES `modules` (`module_guid`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_modules`
--

LOCK TABLES `message_modules` WRITE;
/*!40000 ALTER TABLE `message_modules` DISABLE KEYS */;
/*!40000 ALTER TABLE `message_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `module_categories`
--

DROP TABLE IF EXISTS `module_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module_categories` (
  `module_category_id` int(11) NOT NULL AUTO_INCREMENT,
  `module_guid` varchar(45) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`module_category_id`),
  KEY `fk_modcat_module_idx` (`module_guid`),
  KEY `fk_modcat_cat_idx` (`category_id`),
  CONSTRAINT `fk_modcat_cat` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_modcat_module` FOREIGN KEY (`module_guid`) REFERENCES `modules` (`module_guid`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module_categories`
--

LOCK TABLES `module_categories` WRITE;
/*!40000 ALTER TABLE `module_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `module_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modules`
--

DROP TABLE IF EXISTS `modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modules` (
  `module_id` int(11) NOT NULL AUTO_INCREMENT,
  `module_guid` varchar(45) NOT NULL,
  `module_type` int(11) NOT NULL,
  PRIMARY KEY (`module_id`),
  UNIQUE KEY `module_guid_UNIQUE` (`module_guid`),
  KEY `module_guid_index` (`module_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modules`
--

LOCK TABLES `modules` WRITE;
/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
/*!40000 ALTER TABLE `modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `multicast_ports`
--

DROP TABLE IF EXISTS `multicast_ports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `multicast_ports` (
  `multicast_port_id` int(11) NOT NULL AUTO_INCREMENT,
  `multicast_port_number` int(11) NOT NULL,
  `com_server_id` int(11) NOT NULL,
  PRIMARY KEY (`multicast_port_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `multicast_ports`
--

LOCK TABLES `multicast_ports` WRITE;
/*!40000 ALTER TABLE `multicast_ports` DISABLE KEYS */;
/*!40000 ALTER TABLE `multicast_ports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nic_inventory`
--

DROP TABLE IF EXISTS `nic_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nic_inventory` (
  `nic_inventory_id` int(11) NOT NULL AUTO_INCREMENT,
  `computer_id` int(11) NOT NULL,
  `nic_name` varchar(255) DEFAULT NULL,
  `nic_description` varchar(255) DEFAULT NULL,
  `nic_type` varchar(45) DEFAULT NULL,
  `nic_mac` varchar(45) DEFAULT NULL,
  `nic_status` varchar(45) DEFAULT NULL,
  `nic_speed` bigint(20) DEFAULT NULL,
  `nic_ips` varchar(255) DEFAULT NULL,
  `nic_gateways` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`nic_inventory_id`),
  KEY `FK_NIC_COMPID_idx` (`computer_id`),
  CONSTRAINT `FK_NIC_COMPID` FOREIGN KEY (`computer_id`) REFERENCES `computers` (`computer_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nic_inventory`
--

LOCK TABLES `nic_inventory` WRITE;
/*!40000 ALTER TABLE `nic_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `nic_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `os_inventory`
--

DROP TABLE IF EXISTS `os_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `os_inventory` (
  `os_inventory_id` int(11) NOT NULL AUTO_INCREMENT,
  `computer_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `version` varchar(45) DEFAULT NULL,
  `build` varchar(45) DEFAULT NULL,
  `arch` varchar(45) DEFAULT NULL,
  `sp_major` tinyint(4) DEFAULT 0,
  `sp_minor` tinyint(4) DEFAULT 0,
  `release_id` varchar(45) DEFAULT NULL,
  `uac_status` varchar(45) DEFAULT NULL,
  `local_time_zone` varchar(255) DEFAULT NULL,
  `latitude` varchar(45) DEFAULT NULL,
  `longitude` varchar(45) DEFAULT NULL,
  `location_enabled` tinyint(4) DEFAULT 0,
  `last_location_update_utc` datetime DEFAULT '0001-01-01 00:00:00',
  `update_server` varchar(200) DEFAULT NULL,
  `update_server_target_group` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`os_inventory_id`),
  KEY `OS_COMPUTER_FK_idx` (`computer_id`),
  CONSTRAINT `OS_COMPUTER_FK` FOREIGN KEY (`computer_id`) REFERENCES `computers` (`computer_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `os_inventory`
--

LOCK TABLES `os_inventory` WRITE;
/*!40000 ALTER TABLE `os_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `os_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pinned_groups`
--

DROP TABLE IF EXISTS `pinned_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pinned_groups` (
  `pinned_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`pinned_group_id`),
  KEY `fk_pingroup_group_idx` (`group_id`),
  KEY `fk_pingroup_user_idx` (`user_id`),
  CONSTRAINT `fk_pingroup_group` FOREIGN KEY (`group_id`) REFERENCES `groups` (`group_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_pingroup_user` FOREIGN KEY (`user_id`) REFERENCES `toems_users` (`toems_user_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pinned_groups`
--

LOCK TABLES `pinned_groups` WRITE;
/*!40000 ALTER TABLE `pinned_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `pinned_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pinned_policies`
--

DROP TABLE IF EXISTS `pinned_policies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pinned_policies` (
  `pinned_policy_id` int(11) NOT NULL AUTO_INCREMENT,
  `policy_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`pinned_policy_id`),
  KEY `FK_PIN_POLICYID_idx` (`policy_id`),
  KEY `FK_PIN_USERID_idx` (`user_id`),
  CONSTRAINT `FK_PIN_POLICYID` FOREIGN KEY (`policy_id`) REFERENCES `policies` (`policy_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_PIN_USERID` FOREIGN KEY (`user_id`) REFERENCES `toems_users` (`toems_user_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pinned_policies`
--

LOCK TABLES `pinned_policies` WRITE;
/*!40000 ALTER TABLE `pinned_policies` DISABLE KEYS */;
/*!40000 ALTER TABLE `pinned_policies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `policies`
--

DROP TABLE IF EXISTS `policies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policies` (
  `policy_id` int(11) NOT NULL AUTO_INCREMENT,
  `policy_guid` varchar(45) NOT NULL,
  `policy_hash` varchar(45) DEFAULT NULL,
  `policy_name` varchar(45) NOT NULL,
  `policy_description` text DEFAULT NULL,
  `policy_trigger` tinyint(4) DEFAULT 0,
  `policy_frequency` tinyint(4) DEFAULT 0,
  `policy_sub_frequency` tinyint(4) DEFAULT 0,
  `policy_start_date_utc` datetime DEFAULT NULL,
  `policy_completed_action` tinyint(4) DEFAULT 0,
  `policy_run_inventory` tinyint(4) DEFAULT 0,
  `policy_run_login_tracker` tinyint(4) DEFAULT 0,
  `policy_remove_cache` tinyint(4) DEFAULT 0,
  `policy_execution_type` tinyint(4) DEFAULT 0,
  `policy_error_action` tinyint(4) DEFAULT 0,
  `policy_log_level` tinyint(4) DEFAULT 0,
  `policy_missed_action` tinyint(4) DEFAULT 0,
  `auto_archive_type` tinyint(4) DEFAULT 0,
  `sub_auto_archive` tinyint(4) DEFAULT 0,
  `is_archived` tinyint(4) DEFAULT 0,
  `skip_server_result` tinyint(4) DEFAULT 0,
  `run_application_monitor` tinyint(4) DEFAULT 0,
  `window_start_schedule_id` tinyint(4) DEFAULT -1,
  `window_end_schedule_id` tinyint(4) DEFAULT -1,
  `policy_wu` tinyint(4) DEFAULT 0,
  `policy_com_condition` tinyint(4) DEFAULT 0,
  `datetime_archived_local` datetime DEFAULT NULL,
  `policy_condition_id` int(11) NOT NULL DEFAULT -1,
  `condition_failed_action` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`policy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `policies`
--

LOCK TABLES `policies` WRITE;
/*!40000 ALTER TABLE `policies` DISABLE KEYS */;
/*!40000 ALTER TABLE `policies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `policy_categories`
--

DROP TABLE IF EXISTS `policy_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policy_categories` (
  `policy_category_id` int(11) NOT NULL AUTO_INCREMENT,
  `policy_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`policy_category_id`),
  KEY `fk_policycat_policy_idx` (`policy_id`),
  KEY `fk_policycat_cat_idx` (`category_id`),
  CONSTRAINT `fk_policycat_cat` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_policycat_policy` FOREIGN KEY (`policy_id`) REFERENCES `policies` (`policy_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `policy_categories`
--

LOCK TABLES `policy_categories` WRITE;
/*!40000 ALTER TABLE `policy_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `policy_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `policy_com_servers`
--

DROP TABLE IF EXISTS `policy_com_servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policy_com_servers` (
  `policy_com_server_id` int(11) NOT NULL AUTO_INCREMENT,
  `policy_id` int(11) NOT NULL,
  `com_server_id` int(11) NOT NULL,
  PRIMARY KEY (`policy_com_server_id`),
  KEY `pcom_policy_fk_idx` (`policy_id`),
  KEY `pcom_com_fk_idx` (`com_server_id`),
  CONSTRAINT `pcom_com_fk` FOREIGN KEY (`com_server_id`) REFERENCES `client_com_servers` (`client_com_server_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `pcom_policy_fk` FOREIGN KEY (`policy_id`) REFERENCES `policies` (`policy_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `policy_com_servers`
--

LOCK TABLES `policy_com_servers` WRITE;
/*!40000 ALTER TABLE `policy_com_servers` DISABLE KEYS */;
/*!40000 ALTER TABLE `policy_com_servers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `policy_hash_history`
--

DROP TABLE IF EXISTS `policy_hash_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policy_hash_history` (
  `policy_hash_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `policy_id` int(11) NOT NULL,
  `policy_hash` varchar(45) NOT NULL,
  `policy_json` text DEFAULT NULL,
  `modify_time_utc` datetime DEFAULT NULL,
  PRIMARY KEY (`policy_hash_history_id`),
  KEY `FK_HASH_POLICYID_idx` (`policy_id`),
  CONSTRAINT `FK_HASH_POLICYID` FOREIGN KEY (`policy_id`) REFERENCES `policies` (`policy_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `policy_hash_history`
--

LOCK TABLES `policy_hash_history` WRITE;
/*!40000 ALTER TABLE `policy_hash_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `policy_hash_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `policy_history`
--

DROP TABLE IF EXISTS `policy_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policy_history` (
  `policy_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `policy_id` int(11) NOT NULL,
  `computer_id` int(11) NOT NULL,
  `run_result` tinyint(4) DEFAULT NULL,
  `policy_hash` varchar(45) DEFAULT NULL,
  `run_time_utc` datetime DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`policy_history_id`),
  KEY `FK_PHIST_COMPID_idx` (`computer_id`),
  KEY `FK_PHIST_POLICYID_idx` (`policy_id`),
  CONSTRAINT `FK_PHIST_COMPID` FOREIGN KEY (`computer_id`) REFERENCES `computers` (`computer_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_PHIST_POLICYID` FOREIGN KEY (`policy_id`) REFERENCES `policies` (`policy_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `policy_history`
--

LOCK TABLES `policy_history` WRITE;
/*!40000 ALTER TABLE `policy_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `policy_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `policy_modules`
--

DROP TABLE IF EXISTS `policy_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policy_modules` (
  `policy_module_id` int(11) NOT NULL AUTO_INCREMENT,
  `policy_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `module_guid` varchar(45) NOT NULL,
  `module_type` int(11) NOT NULL,
  `module_order` int(11) DEFAULT NULL,
  `condition_module_id` int(11) NOT NULL DEFAULT -1,
  `condition_failed_action` int(11) NOT NULL DEFAULT 0,
  `condition_next_module` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`policy_module_id`),
  KEY `PM_POLICY_PK_idx` (`policy_id`),
  KEY `PM_POLICY_FK_idx` (`policy_id`),
  KEY `PM_MODULE_FK_idx` (`module_guid`),
  CONSTRAINT `PM_MODULE_FK` FOREIGN KEY (`module_guid`) REFERENCES `modules` (`module_guid`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `PM_POLICY_FK` FOREIGN KEY (`policy_id`) REFERENCES `policies` (`policy_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `policy_modules`
--

LOCK TABLES `policy_modules` WRITE;
/*!40000 ALTER TABLE `policy_modules` DISABLE KEYS */;
/*!40000 ALTER TABLE `policy_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `printer_inventory`
--

DROP TABLE IF EXISTS `printer_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `printer_inventory` (
  `printer_inventory_id` int(11) NOT NULL AUTO_INCREMENT,
  `computer_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `driver_name` varchar(255) DEFAULT NULL,
  `is_local` tinyint(4) DEFAULT NULL,
  `is_network` tinyint(4) DEFAULT NULL,
  `share_name` varchar(255) DEFAULT NULL,
  `system_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`printer_inventory_id`),
  KEY `PRINT_COMPUTER_FK_idx` (`computer_id`),
  CONSTRAINT `PRINT_COMPUTER_FK` FOREIGN KEY (`computer_id`) REFERENCES `computers` (`computer_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `printer_inventory`
--

LOCK TABLES `printer_inventory` WRITE;
/*!40000 ALTER TABLE `printer_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `printer_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `printer_modules`
--

DROP TABLE IF EXISTS `printer_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `printer_modules` (
  `printer_module_id` int(11) NOT NULL AUTO_INCREMENT,
  `printer_module_guid` varchar(45) NOT NULL,
  `printer_module_name` varchar(45) NOT NULL,
  `printer_module_description` text DEFAULT NULL,
  `printer_module_path` varchar(255) DEFAULT NULL,
  `printer_module_action` tinyint(4) DEFAULT NULL,
  `printer_module_setdefault` tinyint(4) DEFAULT NULL,
  `printer_module_restartspooler` tinyint(4) DEFAULT NULL,
  `is_archived` tinyint(4) DEFAULT 0,
  `wait_for_enumeration` tinyint(4) DEFAULT 1,
  `datetime_archived_local` datetime DEFAULT NULL,
  PRIMARY KEY (`printer_module_id`),
  KEY `print_mod_fk1_idx` (`printer_module_guid`),
  CONSTRAINT `print_mod_fk1` FOREIGN KEY (`printer_module_guid`) REFERENCES `modules` (`module_guid`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `printer_modules`
--

LOCK TABLES `printer_modules` WRITE;
/*!40000 ALTER TABLE `printer_modules` DISABLE KEYS */;
/*!40000 ALTER TABLE `printer_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `process_inventory`
--

DROP TABLE IF EXISTS `process_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `process_inventory` (
  `process_inventory_id` int(11) NOT NULL AUTO_INCREMENT,
  `process_name` varchar(1000) NOT NULL,
  `process_path` varchar(1000) NOT NULL,
  PRIMARY KEY (`process_inventory_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `process_inventory`
--

LOCK TABLES `process_inventory` WRITE;
/*!40000 ALTER TABLE `process_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `process_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `processor_inventory`
--

DROP TABLE IF EXISTS `processor_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `processor_inventory` (
  `processor_inventory_id` int(11) NOT NULL AUTO_INCREMENT,
  `computer_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `clock_speed` int(11) DEFAULT 0,
  `cores` int(11) DEFAULT 0,
  PRIMARY KEY (`processor_inventory_id`),
  KEY `PROC_COMP_FK_idx` (`computer_id`),
  CONSTRAINT `PROC_COMP_FK` FOREIGN KEY (`computer_id`) REFERENCES `computers` (`computer_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `processor_inventory`
--

LOCK TABLES `processor_inventory` WRITE;
/*!40000 ALTER TABLE `processor_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `processor_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reset_requests`
--

DROP TABLE IF EXISTS `reset_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reset_requests` (
  `reset_request_id` int(11) NOT NULL AUTO_INCREMENT,
  `computer_name` varchar(45) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `request_time_utc` datetime DEFAULT NULL,
  `requestor_installation_id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`reset_request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reset_requests`
--

LOCK TABLES `reset_requests` WRITE;
/*!40000 ALTER TABLE `reset_requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `reset_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedules`
--

DROP TABLE IF EXISTS `schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedules` (
  `schedule_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` text DEFAULT NULL,
  `monday` tinyint(4) NOT NULL DEFAULT 0,
  `tuesday` tinyint(4) NOT NULL DEFAULT 0,
  `wednesday` tinyint(4) NOT NULL DEFAULT 0,
  `thursday` tinyint(4) NOT NULL DEFAULT 0,
  `friday` tinyint(4) NOT NULL DEFAULT 0,
  `saturday` tinyint(4) NOT NULL DEFAULT 0,
  `sunday` tinyint(4) NOT NULL DEFAULT 0,
  `hour` int(11) NOT NULL DEFAULT 0,
  `minute` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`schedule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedules`
--

LOCK TABLES `schedules` WRITE;
/*!40000 ALTER TABLE `schedules` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `script_modules`
--

DROP TABLE IF EXISTS `script_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `script_modules` (
  `script_module_id` int(11) NOT NULL AUTO_INCREMENT,
  `script_module_guid` varchar(45) NOT NULL,
  `script_module_name` varchar(45) NOT NULL,
  `script_module_description` text DEFAULT NULL,
  `script_module_type` tinyint(4) NOT NULL,
  `script_module_arguments` text DEFAULT NULL,
  `script_module_contents` text DEFAULT NULL,
  `script_module_timeout` int(11) DEFAULT NULL,
  `script_module_workingdir` varchar(255) DEFAULT NULL,
  `redirect_stdout` tinyint(4) DEFAULT NULL,
  `redirect_stderror` tinyint(4) DEFAULT NULL,
  `success_codes` varchar(45) DEFAULT NULL,
  `add_inventory_collection` tinyint(4) DEFAULT 0,
  `use_as_condition` tinyint(4) DEFAULT 0,
  `is_archived` tinyint(4) DEFAULT 0,
  `impersonation_id` int(11) DEFAULT -1,
  `datetime_archived_local` datetime DEFAULT NULL,
  PRIMARY KEY (`script_module_id`),
  KEY `SCRIPT_MOD_FK_idx` (`script_module_guid`),
  CONSTRAINT `SCRIPT_MOD_FK` FOREIGN KEY (`script_module_guid`) REFERENCES `modules` (`module_guid`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `script_modules`
--

LOCK TABLES `script_modules` WRITE;
/*!40000 ALTER TABLE `script_modules` DISABLE KEYS */;
/*!40000 ALTER TABLE `script_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `smart_group_queries`
--

DROP TABLE IF EXISTS `smart_group_queries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `smart_group_queries` (
  `smart_group_query_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `and_or` varchar(3) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `left_parenthesis` varchar(1) DEFAULT NULL,
  `query_table` varchar(45) DEFAULT NULL,
  `query_field` varchar(255) DEFAULT NULL,
  `operator` varchar(45) DEFAULT NULL,
  `value` text DEFAULT NULL,
  `right_parenthesis` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`smart_group_query_id`),
  KEY `FK_SMARTG_GROUPID_idx` (`group_id`),
  CONSTRAINT `FK_SMARTG_GROUPID` FOREIGN KEY (`group_id`) REFERENCES `groups` (`group_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smart_group_queries`
--

LOCK TABLES `smart_group_queries` WRITE;
/*!40000 ALTER TABLE `smart_group_queries` DISABLE KEYS */;
/*!40000 ALTER TABLE `smart_group_queries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `software_asset_softwares`
--

DROP TABLE IF EXISTS `software_asset_softwares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `software_asset_softwares` (
  `software_asset_softwares_id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_id` int(11) NOT NULL,
  `software_inventory_id` int(11) NOT NULL,
  `match_type` tinyint(4) NOT NULL,
  PRIMARY KEY (`software_asset_softwares_id`),
  KEY `fk_sas_asset_idx` (`asset_id`),
  KEY `fk_sas_software_idx` (`software_inventory_id`),
  CONSTRAINT `fk_sas_asset` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`asset_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_sas_software` FOREIGN KEY (`software_inventory_id`) REFERENCES `software_inventory` (`software_inventory_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `software_asset_softwares`
--

LOCK TABLES `software_asset_softwares` WRITE;
/*!40000 ALTER TABLE `software_asset_softwares` DISABLE KEYS */;
/*!40000 ALTER TABLE `software_asset_softwares` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `software_inventory`
--

DROP TABLE IF EXISTS `software_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `software_inventory` (
  `software_inventory_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `version` varchar(45) DEFAULT NULL,
  `major` int(11) DEFAULT NULL,
  `minor` int(11) DEFAULT NULL,
  `build` int(11) DEFAULT NULL,
  `revision` int(11) DEFAULT NULL,
  PRIMARY KEY (`software_inventory_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `software_inventory`
--

LOCK TABLES `software_inventory` WRITE;
/*!40000 ALTER TABLE `software_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `software_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `software_modules`
--

DROP TABLE IF EXISTS `software_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `software_modules` (
  `software_module_id` int(11) NOT NULL AUTO_INCREMENT,
  `software_module_guid` varchar(45) NOT NULL,
  `software_module_name` varchar(45) NOT NULL,
  `software_module_description` text DEFAULT NULL,
  `software_module_type` tinyint(4) NOT NULL,
  `software_module_command` varchar(255) DEFAULT NULL,
  `software_module_arguments` varchar(255) DEFAULT NULL,
  `software_module_addarguments` varchar(255) DEFAULT NULL,
  `software_module_timeout` tinyint(4) DEFAULT NULL,
  `redirect_stdout` tinyint(4) DEFAULT NULL,
  `redirect_stderror` tinyint(4) DEFAULT NULL,
  `success_codes` varchar(45) DEFAULT NULL,
  `is_archived` tinyint(4) DEFAULT 0,
  `impersonation_id` int(11) DEFAULT -1,
  `datetime_archived_local` datetime DEFAULT NULL,
  PRIMARY KEY (`software_module_id`),
  KEY `SFT_MOD_FK_idx` (`software_module_guid`),
  CONSTRAINT `SFT_MOD_FK` FOREIGN KEY (`software_module_guid`) REFERENCES `modules` (`module_guid`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `software_modules`
--

LOCK TABLES `software_modules` WRITE;
/*!40000 ALTER TABLE `software_modules` DISABLE KEYS */;
/*!40000 ALTER TABLE `software_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysprep_modules`
--

DROP TABLE IF EXISTS `sysprep_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysprep_modules` (
  `sysprep_module_id` int(11) NOT NULL AUTO_INCREMENT,
  `sysprep_module_close` varchar(50) DEFAULT NULL,
  `sysprep_module_contents` text DEFAULT NULL,
  `sysprep_module_description` text DEFAULT NULL,
  `sysprep_module_name` varchar(45) NOT NULL,
  `sysprep_module_open` varchar(45) DEFAULT NULL,
  `sysprep_module_guid` varchar(50) NOT NULL,
  `is_archived` tinyint(4) NOT NULL,
  `datetime_archived_local` datetime DEFAULT NULL,
  PRIMARY KEY (`sysprep_module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysprep_modules`
--

LOCK TABLES `sysprep_modules` WRITE;
/*!40000 ALTER TABLE `sysprep_modules` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysprep_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `toems_user_groups`
--

DROP TABLE IF EXISTS `toems_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `toems_user_groups` (
  `toems_user_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `toems_user_group_name` varchar(45) NOT NULL,
  `toems_user_group_role` varchar(45) NOT NULL,
  `toems_user_group_ldap` tinyint(4) DEFAULT 0,
  `toems_user_group_ldapname` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`toems_user_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `toems_user_groups`
--

LOCK TABLES `toems_user_groups` WRITE;
/*!40000 ALTER TABLE `toems_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `toems_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `toems_user_lockouts`
--

DROP TABLE IF EXISTS `toems_user_lockouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `toems_user_lockouts` (
  `toems_user_lockout_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `bad_login_count` int(11) DEFAULT 0,
  `locked_until_time_utc` datetime DEFAULT NULL,
  PRIMARY KEY (`toems_user_lockout_id`),
  KEY `LOCK_USER_FK_idx` (`user_id`),
  CONSTRAINT `LOCK_USER_FK` FOREIGN KEY (`user_id`) REFERENCES `toems_users` (`toems_user_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `toems_user_lockouts`
--

LOCK TABLES `toems_user_lockouts` WRITE;
/*!40000 ALTER TABLE `toems_user_lockouts` DISABLE KEYS */;
/*!40000 ALTER TABLE `toems_user_lockouts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `toems_user_rights`
--

DROP TABLE IF EXISTS `toems_user_rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `toems_user_rights` (
  `toems_user_right_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `user_right` varchar(45) NOT NULL,
  PRIMARY KEY (`toems_user_right_id`),
  KEY `RIGHT_USER_FK_idx` (`user_id`),
  CONSTRAINT `RIGHT_USER_FK` FOREIGN KEY (`user_id`) REFERENCES `toems_users` (`toems_user_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `toems_user_rights`
--

LOCK TABLES `toems_user_rights` WRITE;
/*!40000 ALTER TABLE `toems_user_rights` DISABLE KEYS */;
/*!40000 ALTER TABLE `toems_user_rights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `toems_usergroup_rights`
--

DROP TABLE IF EXISTS `toems_usergroup_rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `toems_usergroup_rights` (
  `toems_usergroup_right_id` int(11) NOT NULL AUTO_INCREMENT,
  `usergroup_id` int(11) NOT NULL,
  `usergroup_right` varchar(45) NOT NULL,
  PRIMARY KEY (`toems_usergroup_right_id`),
  KEY `FK_UG_RIGHT_idx` (`usergroup_id`),
  CONSTRAINT `FK_UG_RIGHT` FOREIGN KEY (`usergroup_id`) REFERENCES `toems_user_groups` (`toems_user_group_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `toems_usergroup_rights`
--

LOCK TABLES `toems_usergroup_rights` WRITE;
/*!40000 ALTER TABLE `toems_usergroup_rights` DISABLE KEYS */;
/*!40000 ALTER TABLE `toems_usergroup_rights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `toems_users`
--

DROP TABLE IF EXISTS `toems_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `toems_users` (
  `toems_user_id` int(11) NOT NULL AUTO_INCREMENT,
  `toems_username` varchar(45) NOT NULL,
  `toems_user_pwd` varchar(255) NOT NULL,
  `toems_user_salt` varchar(255) NOT NULL,
  `toems_user_role` varchar(45) NOT NULL,
  `toems_user_email` varchar(45) DEFAULT NULL,
  `toems_user_is_ldap` tinyint(4) DEFAULT 0,
  `toems_usergroup_id` int(11) DEFAULT -1,
  `toems_theme` varchar(45) DEFAULT 'dark',
  `imaging_token` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`toems_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `toems_users`
--

LOCK TABLES `toems_users` WRITE;
/*!40000 ALTER TABLE `toems_users` DISABLE KEYS */;
INSERT INTO `toems_users` VALUES (1,'toemsadmin','ynR74SyWh73NxqzWQNpwsWzHJPOdmWJd1BgxuOxVd+4=','8Q+LD8za/YzoK7OuAlU8orXTpeu/YpCyNl0yNxEKinQzzfwjI4njKt4FANt74ZxR2D2G7N1QxsNpreLNfd3Dpg==','Administrator',NULL,0,-1,'dark','');
/*!40000 ALTER TABLE `toems_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `toems_version`
--

DROP TABLE IF EXISTS `toems_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `toems_version` (
  `toems_version_id` int(11) NOT NULL AUTO_INCREMENT,
  `expected_app_version` varchar(45) NOT NULL,
  `database_version` varchar(45) NOT NULL,
  `first_run_completed` tinyint(4) DEFAULT 0,
  `latest_client_version` varchar(45) NOT NULL,
  `expected_toecapi_version` varchar(45) NOT NULL,
  PRIMARY KEY (`toems_version_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `toems_version`
--

LOCK TABLES `toems_version` WRITE;
/*!40000 ALTER TABLE `toems_version` DISABLE KEYS */;
INSERT INTO `toems_version` VALUES (1,'1.2.1.0','1.2.1.0',1,'1.2.0.0','1.2.1.0');
/*!40000 ALTER TABLE `toems_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uploaded_files`
--

DROP TABLE IF EXISTS `uploaded_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uploaded_files` (
  `uploaded_file_id` int(11) NOT NULL AUTO_INCREMENT,
  `module_guid` varchar(45) NOT NULL,
  `uploaded_file_hash` varchar(45) DEFAULT NULL,
  `uploaded_file_name` varchar(255) DEFAULT NULL,
  `uploaded_time_utc` datetime DEFAULT NULL,
  PRIMARY KEY (`uploaded_file_id`),
  KEY `UF_MODULE_FK_idx` (`module_guid`),
  CONSTRAINT `UF_MODULE_FK` FOREIGN KEY (`module_guid`) REFERENCES `modules` (`module_guid`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uploaded_files`
--

LOCK TABLES `uploaded_files` WRITE;
/*!40000 ALTER TABLE `uploaded_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `uploaded_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_logins`
--

DROP TABLE IF EXISTS `user_logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_logins` (
  `user_login_id` int(11) NOT NULL AUTO_INCREMENT,
  `computer_id` int(11) NOT NULL,
  `username` varchar(45) DEFAULT NULL,
  `login_date_time_utc` datetime DEFAULT NULL,
  `logout_date_time_utc` datetime DEFAULT NULL,
  PRIMARY KEY (`user_login_id`),
  KEY `FK_LOGINS_COMPID_idx` (`computer_id`),
  CONSTRAINT `FK_LOGINS_COMPID` FOREIGN KEY (`computer_id`) REFERENCES `computers` (`computer_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_logins`
--

LOCK TABLES `user_logins` WRITE;
/*!40000 ALTER TABLE `user_logins` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_logins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wol_relays`
--

DROP TABLE IF EXISTS `wol_relays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wol_relays` (
  `wol_relay_id` int(11) NOT NULL AUTO_INCREMENT,
  `wol_gateway` varchar(45) NOT NULL,
  `com_server_id` int(11) NOT NULL,
  PRIMARY KEY (`wol_relay_id`),
  KEY `fk_wolrelay_comserver_idx` (`com_server_id`),
  CONSTRAINT `fk_wolrelay_comserver` FOREIGN KEY (`com_server_id`) REFERENCES `client_com_servers` (`client_com_server_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wol_relays`
--

LOCK TABLES `wol_relays` WRITE;
/*!40000 ALTER TABLE `wol_relays` DISABLE KEYS */;
/*!40000 ALTER TABLE `wol_relays` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wu_inventory`
--

DROP TABLE IF EXISTS `wu_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wu_inventory` (
  `wu_inventory_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `update_id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`wu_inventory_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wu_inventory`
--

LOCK TABLES `wu_inventory` WRITE;
/*!40000 ALTER TABLE `wu_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `wu_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wu_modules`
--

DROP TABLE IF EXISTS `wu_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wu_modules` (
  `wu_module_id` int(11) NOT NULL AUTO_INCREMENT,
  `wu_module_guid` varchar(45) NOT NULL,
  `wu_module_name` varchar(45) NOT NULL,
  `wu_module_description` text DEFAULT NULL,
  `wu_module_addarguments` varchar(255) DEFAULT NULL,
  `wu_module_timeout` tinyint(4) DEFAULT NULL,
  `redirect_stdout` tinyint(4) DEFAULT NULL,
  `redirect_stderror` tinyint(4) DEFAULT NULL,
  `success_codes` varchar(45) DEFAULT NULL,
  `is_archived` tinyint(4) DEFAULT 0,
  `datetime_archived_local` datetime DEFAULT NULL,
  PRIMARY KEY (`wu_module_id`),
  KEY `fk_wumod_module_idx` (`wu_module_guid`),
  CONSTRAINT `fk_wumod_module` FOREIGN KEY (`wu_module_guid`) REFERENCES `modules` (`module_guid`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wu_modules`
--

LOCK TABLES `wu_modules` WRITE;
/*!40000 ALTER TABLE `wu_modules` DISABLE KEYS */;
/*!40000 ALTER TABLE `wu_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'theopenem'
--
/*!50003 DROP FUNCTION IF EXISTS `DiffMinutes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `DiffMinutes`(startDate datetime, endDate datetime) RETURNS int(11)
BEGIN
    RETURN TIMESTAMPDIFF(MINUTE,startDate,endDate);
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

-- Dump completed on 2020-04-10 21:41:04

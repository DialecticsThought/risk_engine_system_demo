-- MySQL dump 10.13  Distrib 5.7.25, for Linux (x86_64)
--
-- Host: localhost    Database: imooc
-- ------------------------------------------------------
-- Server version	5.7.25

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
-- Table structure for table `activation`
--

CREATE DATABASE IF NOT EXISTS imooc;
use imooc;

DROP TABLE IF EXISTS `activation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activation` (
  `activation_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `activation_name` varchar(100) NOT NULL COMMENT '策略名称',
  `risk_level` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '风险等级',
  `action_id` int(10) unsigned NOT NULL COMMENT '动作id',
  PRIMARY KEY (`activation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='策略表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activation`
--

LOCK TABLES `activation` WRITE;
/*!40000 ALTER TABLE `activation` DISABLE KEYS */;
/*!40000 ALTER TABLE `activation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activity_action`
--

DROP TABLE IF EXISTS `activity_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity_action` (
  `action_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `action_model` varchar(100) NOT NULL,
  PRIMARY KEY (`action_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='策略动作表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_action`
--

LOCK TABLES `activity_action` WRITE;
/*!40000 ALTER TABLE `activity_action` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blacklist`
--

DROP TABLE IF EXISTS `blacklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blacklist` (
  `list_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `user_id` int(10) unsigned NOT NULL COMMENT 'uid',
  `reason` varchar(100) NOT NULL COMMENT '列入黑名单原因',
  `level` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '1~5等级, 等级越高,危险度越高',
  PRIMARY KEY (`list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='黑灰名单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blacklist`
--

LOCK TABLES `blacklist` WRITE;
/*!40000 ALTER TABLE `blacklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `blacklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `event_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `event_cn` varchar(100) NOT NULL COMMENT '行为事件名称(cn)',
  `event_en` varchar(100) NOT NULL COMMENT '行为事件名称(en)',
  `scene` varchar(100) NOT NULL COMMENT '行为事件所属场景',
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='行为事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,'登录事件','login_success','SCEN_LOGIN'),(2,'登录失败事件','login_fail','SCEN_LOGIN'),(3,'下单事件','order','SCEN_ORDER'),(4,'支付事件','pay','SCEN_PAY'),(5,'用户信息修改事件','user_profile_modify','SCEN_ACCOUNT'),(6,'优惠券领取事件','coupons_receive','SCEN_COUPON'),(7,'优惠券使用事件','coupons_use','SCEN_COUPON'),(8,'发表评论事件','comment','SCEN_ORDER'),(9,'商品收藏事件','favorites','SCEN_ORDER'),(10,'浏览事件','browse','SCEN_ORDER'),(11,'加入购物车事件','cart_add','SCEN_ORDER');
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logic_operator`
--

DROP TABLE IF EXISTS `logic_operator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logic_operator` (
  `auto_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `operator_id` tinyint(3) unsigned NOT NULL COMMENT '运算符id (逻辑运算)',
  `logic_type` tinyint(3) unsigned NOT NULL COMMENT '逻辑运算类型',
  `logic_left_id` int(10) unsigned NOT NULL COMMENT '逻辑运算左元素id',
  `logic_right_id` int(10) unsigned NOT NULL COMMENT '逻辑运算右元素id',
  `logic_string` varchar(100) NOT NULL COMMENT '逻辑运算表达式字符串',
  `logic_order` tinyint(3) unsigned NOT NULL COMMENT '逻辑运算优先级',
  `logic_id` int(10) unsigned NOT NULL COMMENT '逻辑id',
  PRIMARY KEY (`auto_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='逻辑运算表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logic_operator`
--

LOCK TABLES `logic_operator` WRITE;
/*!40000 ALTER TABLE `logic_operator` DISABLE KEYS */;
/*!40000 ALTER TABLE `logic_operator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metric_attr`
--

DROP TABLE IF EXISTS `metric_attr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metric_attr` (
  `metric_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `metric_name` varchar(100) NOT NULL COMMENT '指标名称',
  `metric_sign` varchar(100) NOT NULL COMMENT ' 指标标识 ',
  `scene` varchar(100) NOT NULL COMMENT '风控场景',
  `event` varchar(100) NOT NULL COMMENT '行为事件类型',
  `main_dim` varchar(100) NOT NULL COMMENT '主维度',
  `second_dim` varchar(100) NOT NULL COMMENT '从维度',
  `start_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime NOT NULL COMMENT '结束时间',
  `aggregation` varchar(100) NOT NULL COMMENT '聚合计算',
  PRIMARY KEY (`metric_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='风控指标属性表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metric_attr`
--

LOCK TABLES `metric_attr` WRITE;
/*!40000 ALTER TABLE `metric_attr` DISABLE KEYS */;
/*!40000 ALTER TABLE `metric_attr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metric_fields`
--

DROP TABLE IF EXISTS `metric_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metric_fields` (
  `field_id` int(10) unsigned NOT NULL COMMENT '自增id',
  `fields` varchar(100) NOT NULL COMMENT '字段名',
  PRIMARY KEY (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='风控字段表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metric_fields`
--

LOCK TABLES `metric_fields` WRITE;
/*!40000 ALTER TABLE `metric_fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `metric_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mysql_test`
--

DROP TABLE IF EXISTS `mysql_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mysql_test` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='mysql测试表¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mysql_test`
--

LOCK TABLES `mysql_test` WRITE;
/*!40000 ALTER TABLE `mysql_test` DISABLE KEYS */;
INSERT INTO `mysql_test` VALUES (1,'imooc-mysql-1'),(2,'imooc-mysql-2'),(3,'imooc-mysql-3'),(4,'imooc-mysql-4'),(5,'imooc-mysql-5');
/*!40000 ALTER TABLE `mysql_test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rule`
--

DROP TABLE IF EXISTS `rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `version` varchar(100) NOT NULL COMMENT '规则版本',
  `rule_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '规则类型（ 数字 ）',
  `rule_type_cn` varchar(100) NOT NULL COMMENT '规则类型（ 中文 ）',
  `event` varchar(100) NOT NULL COMMENT '行为事件类型',
  `rule_description` varchar(100) NOT NULL COMMENT '规则功能说明',
  `is_enable` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '规则是否开启',
  PRIMARY KEY (`rule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='原子规则表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rule`
--

LOCK TABLES `rule` WRITE;
/*!40000 ALTER TABLE `rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rule_condition`
--

DROP TABLE IF EXISTS `rule_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rule_condition` (
  `condition_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `rule_id` int(10) unsigned NOT NULL COMMENT '规则id ',
  `metric_id` int(10) unsigned NOT NULL COMMENT '指标id',
  `threshold` varchar(100) NOT NULL COMMENT '阈值',
  `operator_id` tinyint(3) unsigned NOT NULL COMMENT '运算符id (关系运算)',
  `operator_string` varchar(100) NOT NULL COMMENT '关系运算字符串',
  PRIMARY KEY (`condition_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='规则条件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rule_condition`
--

LOCK TABLES `rule_condition` WRITE;
/*!40000 ALTER TABLE `rule_condition` DISABLE KEYS */;
/*!40000 ALTER TABLE `rule_condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rule_hit`
--

DROP TABLE IF EXISTS `rule_hit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rule_hit` (
  `hit_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rule_id` int(10) unsigned NOT NULL,
  `rule_dim_id` int(10) unsigned NOT NULL,
  `hit_result` varchar(100) NOT NULL,
  `hit_date` datetime NOT NULL,
  PRIMARY KEY (`hit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='规则命中追溯表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rule_hit`
--

LOCK TABLES `rule_hit` WRITE;
/*!40000 ALTER TABLE `rule_hit` DISABLE KEYS */;
/*!40000 ALTER TABLE `rule_hit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rule_operator`
--

DROP TABLE IF EXISTS `rule_operator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rule_operator` (
  `operator_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `operator_cn` varchar(100) NOT NULL COMMENT '运算符名称',
  `operator_exp` varchar(100) NOT NULL COMMENT '运算符表达式',
  `operator_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '运算符类型',
  `operator_type_cn` varchar(100) NOT NULL COMMENT '运算符类型',
  PRIMARY KEY (`operator_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='运算符表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rule_operator`
--

LOCK TABLES `rule_operator` WRITE;
/*!40000 ALTER TABLE `rule_operator` DISABLE KEYS */;
/*!40000 ALTER TABLE `rule_operator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rule_set`
--

DROP TABLE IF EXISTS `rule_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rule_set` (
  `auto_id` int(10) unsigned NOT NULL COMMENT '自增id',
  `rule_id` int(10) unsigned NOT NULL COMMENT '规则id',
  `logic_id` tinyint(3) unsigned NOT NULL COMMENT '逻辑运算id',
  `rule_set_name` varchar(100) NOT NULL COMMENT '规则集名称',
  `set_id` int(10) unsigned NOT NULL COMMENT '规则集id',
  PRIMARY KEY (`auto_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='规则集表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rule_set`
--

LOCK TABLES `rule_set` WRITE;
/*!40000 ALTER TABLE `rule_set` DISABLE KEYS */;
/*!40000 ALTER TABLE `rule_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scene`
--

DROP TABLE IF EXISTS `scene`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scene` (
  `scene_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `scene_cn` varchar(100) NOT NULL COMMENT '场景名称(中文)',
  `scene_en` varchar(100) NOT NULL COMMENT '场景名称(英文)',
  PRIMARY KEY (`scene_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='风控事件场景表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scene`
--

LOCK TABLES `scene` WRITE;
/*!40000 ALTER TABLE `scene` DISABLE KEYS */;
INSERT INTO `scene` VALUES (1,'账号场景','SCEN_ACCOUNT'),(2,'登录场景','SCEN_LOGIN'),(3,'购物场景','SCEN_ORDER'),(4,'支付场景','SCEN_PAY'),(5,'优惠券场景','SCEN_COUPON');
/*!40000 ALTER TABLE `scene` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `whitelist`
--

DROP TABLE IF EXISTS `whitelist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `whitelist` (
  `list_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `user_id` int(10) unsigned NOT NULL COMMENT 'uid',
  `reason` varchar(100) NOT NULL COMMENT '列入白名单原因',
  `level` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '1~5等级, 等级越高,自由度越高',
  PRIMARY KEY (`list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='白名单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `whitelist`
--

LOCK TABLES `whitelist` WRITE;
/*!40000 ALTER TABLE `whitelist` DISABLE KEYS */;
/*!40000 ALTER TABLE `whitelist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-09-21 10:03:25

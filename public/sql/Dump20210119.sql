-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: 炬象矿池_21w01
-- ------------------------------------------------------
-- Server version	8.0.21

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
-- Table structure for table `adm_admin`
--

DROP TABLE IF EXISTS `adm_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adm_admin` (
  `admin_id` int NOT NULL AUTO_INCREMENT COMMENT '管理员id',
  `account` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '管理员账号',
  `password` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '管理员密码',
  `password_salt` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '管理员密码相关-加盐',
  `via` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '管理员头像',
  `nickname` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '管理员昵称',
  `role_id` int NOT NULL DEFAULT '0' COMMENT '管理员角色',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '手机号',
  `email` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '邮箱',
  `qq` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'QQ',
  `wx` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '微信',
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adm_admin`
--

LOCK TABLES `adm_admin` WRITE;
/*!40000 ALTER TABLE `adm_admin` DISABLE KEYS */;
INSERT INTO `adm_admin` VALUES (1,'root','42960a50f11334ea5bcba697e67bc7b0','BJPrExO9','/storage/admin_via/20191223\\cffa5aa1724e4b3aef20524a7eea66b5.jpg','开发者账号',1,'13939390003','1223050252@qq.com','1223050251','anyuhanfeifff'),(7,'admin','73822800f3ac3f45ef7827297a6ec572','O8Vhk8vT','','超级管理员',2,'','','','');
/*!40000 ALTER TABLE `adm_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adm_admin_login`
--

DROP TABLE IF EXISTS `adm_admin_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adm_admin_login` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '管理员异常登录统计',
  `ip` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '登录ip',
  `error_number` tinyint NOT NULL DEFAULT '0' COMMENT '异常次数',
  `insert_time` datetime DEFAULT NULL COMMENT '登录时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adm_admin_login`
--

LOCK TABLES `adm_admin_login` WRITE;
/*!40000 ALTER TABLE `adm_admin_login` DISABLE KEYS */;
/*!40000 ALTER TABLE `adm_admin_login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adm_freeze_ip`
--

DROP TABLE IF EXISTS `adm_freeze_ip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adm_freeze_ip` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '冻结ip表id',
  `ip` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ip',
  `freeze_start_time` datetime DEFAULT NULL COMMENT '冻结开始时间',
  `freeze_end_time` datetime DEFAULT NULL COMMENT '冻结结束时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adm_freeze_ip`
--

LOCK TABLES `adm_freeze_ip` WRITE;
/*!40000 ALTER TABLE `adm_freeze_ip` DISABLE KEYS */;
/*!40000 ALTER TABLE `adm_freeze_ip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adm_role`
--

DROP TABLE IF EXISTS `adm_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adm_role` (
  `role_id` int NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `role_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '角色名称',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `power` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '管理权限',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adm_role`
--

LOCK TABLES `adm_role` WRITE;
/*!40000 ALTER TABLE `adm_role` DISABLE KEYS */;
INSERT INTO `adm_role` VALUES (1,'开发者','',',27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,51,52,117,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,96,97,98,99,100,101,102,103,104,105,106,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,75,76,77,78,79,80,81,82,83,84,85,86,88,89,90,91,92,93,94,95,73,74,115,116,'),(2,'超级管理员','',',27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,51,52,117,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,96,97,98,99,100,101,102,103,104,105,106,75,76,77,78,79,80,81,82,83,84,85,86,88,89,90,91,92,93,94,95,73,74,115,116,');
/*!40000 ALTER TABLE `adm_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auto_value`
--

DROP TABLE IF EXISTS `auto_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auto_value` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '币实时价值',
  `coin` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '币种',
  `hight_number` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '最高',
  `low_number` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '最低',
  `last_number` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '最近',
  `vol` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '涨幅(%)',
  `insert_time` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auto_value`
--

LOCK TABLES `auto_value` WRITE;
/*!40000 ALTER TABLE `auto_value` DISABLE KEYS */;
INSERT INTO `auto_value` VALUES (1,'比特币','40097.7','37455.8','38734.6','3.27','1610688551.8429239'),(2,'以太坊','1256.15','1106.54','1223.74','10.34','1610688551.8488705');
/*!40000 ALTER TABLE `auto_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_article`
--

DROP TABLE IF EXISTS `cms_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_article` (
  `article_id` int NOT NULL AUTO_INCREMENT COMMENT '文章id',
  `tag_ids` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '文章标签',
  `category_id` int NOT NULL DEFAULT '0' COMMENT '文章分类',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '文章标题',
  `author` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '文章作者',
  `intro` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '文章简介',
  `keyword` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '文章关键字',
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '图片',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `content_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'html' COMMENT '内容类型html或markdown',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '内容',
  `insert_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`article_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_article`
--

LOCK TABLES `cms_article` WRITE;
/*!40000 ALTER TABLE `cms_article` DISABLE KEYS */;
INSERT INTO `cms_article` VALUES (1,'',1,'这里是公告','开发者账号','阿斯大苏打','','/storage/article/20210113/15c5643279ef0587ecea255ad32acc02.png',0,'html','<p>这里是公告事实上</p>','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `cms_article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_article_data`
--

DROP TABLE IF EXISTS `cms_article_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_article_data` (
  `article_id` int NOT NULL COMMENT '文章id',
  `is_stick` tinyint(1) NOT NULL DEFAULT '0' COMMENT '置顶',
  `is_hot` tinyint(1) NOT NULL DEFAULT '0' COMMENT '热门',
  `is_recomment` tinyint(1) NOT NULL DEFAULT '0' COMMENT '推荐',
  `looknum` int NOT NULL DEFAULT '0' COMMENT '查看量',
  `likenum` int NOT NULL DEFAULT '0' COMMENT '点赞量',
  PRIMARY KEY (`article_id`)
) ENGINE=InnoDB DEFAULT CHARSET=ascii;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_article_data`
--

LOCK TABLES `cms_article_data` WRITE;
/*!40000 ALTER TABLE `cms_article_data` DISABLE KEYS */;
INSERT INTO `cms_article_data` VALUES (1,0,0,0,0,0);
/*!40000 ALTER TABLE `cms_article_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_category`
--

DROP TABLE IF EXISTS `cms_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_category` (
  `category_id` int NOT NULL AUTO_INCREMENT COMMENT '文章分类id',
  `category_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '分类名称',
  `category_image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '分类图片',
  `sort` tinyint NOT NULL COMMENT '排序',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_category`
--

LOCK TABLES `cms_category` WRITE;
/*!40000 ALTER TABLE `cms_category` DISABLE KEYS */;
INSERT INTO `cms_category` VALUES (1,'公告','',1),(2,'新闻','',2);
/*!40000 ALTER TABLE `cms_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_tag`
--

DROP TABLE IF EXISTS `cms_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_tag` (
  `tag_id` int NOT NULL AUTO_INCREMENT COMMENT '标签id',
  `tag_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标签名称',
  `tag_image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标签图片（可选）',
  `sort` tinyint NOT NULL COMMENT '排序',
  PRIMARY KEY (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_tag`
--

LOCK TABLES `cms_tag` WRITE;
/*!40000 ALTER TABLE `cms_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `idx_activity`
--

DROP TABLE IF EXISTS `idx_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `idx_activity` (
  `id` int NOT NULL AUTO_INCREMENT,
  `标题` varchar(45) NOT NULL DEFAULT '',
  `副标题` varchar(45) NOT NULL DEFAULT '',
  `活动时间` varchar(45) NOT NULL DEFAULT '',
  `列表图` varchar(145) NOT NULL DEFAULT '',
  `首页图` varchar(145) NOT NULL DEFAULT '',
  `内容` text NOT NULL,
  `insert_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `idx_activity`
--

LOCK TABLES `idx_activity` WRITE;
/*!40000 ALTER TABLE `idx_activity` DISABLE KEYS */;
INSERT INTO `idx_activity` VALUES (1,'测试','测试','12.15~12.19','/storage/article/20210108/c937a407c493df6dd7f3915ccca66dd3.png','/storage/article/20210108/f4053220f920c769e0621996b731dc3e.png','<p>阿萨德发射点发1</p>','2021-01-08 15:31:49',2),(2,'测试2','测试2','12.15~12.19','/storage/article/20210113/f576320bb30dc015625191949797dcea.png','/storage/article/20210113/e6694c884f536b3acefdb98799274b9d.png','<p>敖德萨多</p>','2021-01-13 10:13:00',2),(3,'测试3','测试3','12.15~12.19','/storage/article/20210113/d15dd8054f39976d938984eddbf29ed6.png','/storage/article/20210113/59baec9a18d36b6f34601cafac8082ae.png','<p>法电风扇</p>','2021-01-13 10:21:12',2);
/*!40000 ALTER TABLE `idx_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `idx_feedback`
--

DROP TABLE IF EXISTS `idx_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `idx_feedback` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(45) NOT NULL DEFAULT '0',
  `user_identity` varchar(45) NOT NULL DEFAULT '',
  `content` varchar(1000) NOT NULL DEFAULT '',
  `reply` varchar(1000) NOT NULL DEFAULT '',
  `insert_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `operation_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='意见反馈';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `idx_feedback`
--

LOCK TABLES `idx_feedback` WRITE;
/*!40000 ALTER TABLE `idx_feedback` DISABLE KEYS */;
INSERT INTO `idx_feedback` VALUES (1,'2','13939390001','测试','/n测试回复<br/>测试<br/>测试<br/>撒','2021-01-08 16:53:37','0000-00-00 00:00:00',1),(2,'2','13939390001','测试唉唉唉','','2021-01-13 11:02:31','0000-00-00 00:00:00',0);
/*!40000 ALTER TABLE `idx_feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `idx_forgot_pwd`
--

DROP TABLE IF EXISTS `idx_forgot_pwd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `idx_forgot_pwd` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL DEFAULT '0',
  `user_identity` varchar(45) NOT NULL DEFAULT '',
  `voucher` varchar(145) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `insert_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `idx_forgot_pwd`
--

LOCK TABLES `idx_forgot_pwd` WRITE;
/*!40000 ALTER TABLE `idx_forgot_pwd` DISABLE KEYS */;
INSERT INTO `idx_forgot_pwd` VALUES (1,2,'13939390001','',2,'2021-01-09 13:07:15'),(2,2,'13939390001','/storage/card/20210113/ad1ee0c629595fb5794453d3dbf0da0f.png',0,'2021-01-13 14:07:57'),(3,2,'13939390001','/storage/card/20210113/59c3ea7be2c3cdcfeff3685e33d1202e.png',0,'2021-01-13 14:09:20');
/*!40000 ALTER TABLE `idx_forgot_pwd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `idx_mill`
--

DROP TABLE IF EXISTS `idx_mill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `idx_mill` (
  `mill_id` int NOT NULL AUTO_INCREMENT,
  `名称` varchar(45) NOT NULL DEFAULT '',
  `单份存力` decimal(11,2) NOT NULL DEFAULT '0.00',
  `单份价格` decimal(11,2) NOT NULL DEFAULT '0.00',
  `合约周期` int NOT NULL DEFAULT '0',
  `预计产出回报率` decimal(11,2) NOT NULL DEFAULT '0.00',
  `剩余算力` decimal(11,2) NOT NULL DEFAULT '0.00',
  `日产出` decimal(11,2) NOT NULL DEFAULT '0.00',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `全周期收益` decimal(11,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`mill_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `idx_mill`
--

LOCK TABLES `idx_mill` WRITE;
/*!40000 ALTER TABLE `idx_mill` DISABLE KEYS */;
INSERT INTO `idx_mill` VALUES (1,'测试',1.00,1000.00,360,300.00,1000.00,10.00,1,3000.00),(2,'测试2',1.50,1500.00,200,400.00,2000.00,40.00,1,6000.00);
/*!40000 ALTER TABLE `idx_mill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `idx_mill_lease`
--

DROP TABLE IF EXISTS `idx_mill_lease`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `idx_mill_lease` (
  `mill_id` int NOT NULL AUTO_INCREMENT,
  `名称` varchar(45) NOT NULL,
  `单份存力` varchar(45) NOT NULL DEFAULT '',
  `单份价格` decimal(11,2) NOT NULL DEFAULT '0.00',
  `合约周期` int NOT NULL DEFAULT '0',
  `剩余算力` decimal(11,2) NOT NULL DEFAULT '0.00',
  `日产出展示` decimal(11,2) NOT NULL DEFAULT '0.00',
  `日产出计算` decimal(11,2) NOT NULL DEFAULT '0.00',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `开挖时间` varchar(45) NOT NULL DEFAULT '',
  `分币比例` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`mill_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `idx_mill_lease`
--

LOCK TABLES `idx_mill_lease` WRITE;
/*!40000 ALTER TABLE `idx_mill_lease` DISABLE KEYS */;
INSERT INTO `idx_mill_lease` VALUES (1,'测试111','1TB+50%',500.00,40,10000.00,100.00,50.00,1,'2021-1-20 00:00:00','50'),(2,'测试222','1TB',600.00,90,2000.00,100.00,60.00,1,'2021-1-19 00:00:00','60');
/*!40000 ALTER TABLE `idx_mill_lease` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `idx_user`
--

DROP TABLE IF EXISTS `idx_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `idx_user` (
  `user_id` int NOT NULL AUTO_INCREMENT COMMENT '会员id',
  `account` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '会员账号',
  `phone` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '会员手机号',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '会员邮箱',
  `nickname` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '会员昵称',
  `password` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '会员登录密码',
  `level_password` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '会员二级密码',
  `password_salt` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '密码加盐',
  `top_id` int NOT NULL DEFAULT '0' COMMENT '上级会员id',
  `register_time` date NOT NULL COMMENT '注册时间',
  `is_login` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否可以登录，1是0否',
  `invite_code` varchar(45) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `invite_qrcode` varchar(145) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `is_实名` tinyint(1) NOT NULL DEFAULT '0',
  `via` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `idx_user`
--

LOCK TABLES `idx_user` WRITE;
/*!40000 ALTER TABLE `idx_user` DISABLE KEYS */;
INSERT INTO `idx_user` VALUES (2,'','13939390001','','aaa','6dfca3d1fe70443bfd584e910898272f','123456','56jGK7',0,'2021-01-08',1,'49VuqarFiJ','/storage/qrcode/13939390001.png',0,'/storage/via/20210113/a523649517be1b666cef08b5fc664f14.png'),(3,'','13939390011','','测试下级','f64616fd47ccb1cef3586e720dd8983a','123456','462zZD',2,'2021-01-08',1,'','',0,''),(4,'','13939390002','','','d9b971afe3c9282883a824bc25636fe8','','odVf02',0,'2021-01-12',1,'111111','',0,''),(5,'','13939390111','','','2a74a6cc60bc5a5b4ca335e6b5f130fd','','0k6Gs4',3,'2021-01-12',1,'','',0,''),(6,'','13939391111','','','55d54222c4b7261acb3ddad7a6b29cb7','','5G865N',0,'2021-01-12',1,'','',0,''),(7,'','13939390022','','','78ad9b41ca98492f5c3bfc0001b27bad','','A5DV1X',4,'2021-01-12',1,'','',0,'');
/*!40000 ALTER TABLE `idx_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `idx_user_count`
--

DROP TABLE IF EXISTS `idx_user_count`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `idx_user_count` (
  `user_id` int NOT NULL COMMENT '会员id',
  `down_team_number` int NOT NULL DEFAULT '0' COMMENT '直推会员人数',
  `team_number` int NOT NULL DEFAULT '0' COMMENT '团队总人数',
  `累计收益` decimal(11,2) NOT NULL DEFAULT '0.00',
  `历史最高算龄` decimal(11,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `idx_user_count`
--

LOCK TABLES `idx_user_count` WRITE;
/*!40000 ALTER TABLE `idx_user_count` DISABLE KEYS */;
INSERT INTO `idx_user_count` VALUES (2,0,0,0.00,4.00),(3,0,0,0.00,0.00),(4,1,1,0.00,0.00),(5,0,0,0.00,0.00),(6,0,0,0.00,0.00),(7,0,0,0.00,0.00);
/*!40000 ALTER TABLE `idx_user_count` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `idx_user_data`
--

DROP TABLE IF EXISTS `idx_user_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `idx_user_data` (
  `user_id` int NOT NULL AUTO_INCREMENT COMMENT '会员详细信息（预置）',
  `id_card_username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '身份证--姓名',
  `id_card_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '身份证--身份证号',
  `id_card_front_img` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '身份证--身份证正面照',
  `id_card_verso_img` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '身份证--身份证背面照',
  `id_card_hand_img` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '身份证--手持身份证照',
  `bank_username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '银行卡--开户人姓名',
  `bank_phone` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '银行卡--预留手机号',
  `bank_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '银行卡--银行卡号',
  `bank_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '银行卡--开户行',
  `site_username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '地址--姓名',
  `site_phone` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '地址--手机号',
  `site_province` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '地址--省',
  `site_city` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '地址--市',
  `site_district` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '地址--区/县',
  `site_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '地址--详细地址',
  `wx_account` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '微信--微信账号',
  `wx_nickname` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '微信--微信昵称',
  `wx_qrcode` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '微信--收款二维码',
  `alipay_account` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '支付宝--支付宝账号',
  `alipay_username` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '支付宝--支付宝实名认证姓名',
  `alipay_qrcode` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '支付宝--收款二维码',
  `qq` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'qq',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `idx_user_data`
--

LOCK TABLES `idx_user_data` WRITE;
/*!40000 ALTER TABLE `idx_user_data` DISABLE KEYS */;
INSERT INTO `idx_user_data` VALUES (2,'阿斯顿','23424243','/storage/card/20210113/55356b0c4dc48b90f731d04b8bd38ee6.png','/storage/card/20210113/268cdeb5add417a8b0bd08ca0dd32285.png','','','','','','','','','','','','','','','','','',''),(3,'','','','','','','','','','','','','','','','','','','','','',''),(4,'','','','','','','','','','','','','','','','','','','','','',''),(5,'','','','','','','','','','','','','','','','','','','','','',''),(6,'','','','','','','','','','','','','','','','','','','','','',''),(7,'','','','','','','','','','','','','','','','','','','','','','');
/*!40000 ALTER TABLE `idx_user_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `idx_user_fund`
--

DROP TABLE IF EXISTS `idx_user_fund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `idx_user_fund` (
  `user_id` int NOT NULL COMMENT '会员id',
  `USDT` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '余额',
  `FIL` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `idx_user_fund`
--

LOCK TABLES `idx_user_fund` WRITE;
/*!40000 ALTER TABLE `idx_user_fund` DISABLE KEYS */;
INSERT INTO `idx_user_fund` VALUES (2,88000.00,3770.00),(3,0.00,0.00),(4,0.00,0.00),(5,0.00,0.00),(6,0.00,0.00),(7,1000000.00,0.00);
/*!40000 ALTER TABLE `idx_user_fund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `idx_user_message`
--

DROP TABLE IF EXISTS `idx_user_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `idx_user_message` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL DEFAULT '0',
  `user_identity` varchar(45) NOT NULL DEFAULT '',
  `title` varchar(145) NOT NULL DEFAULT '',
  `content` varchar(1000) NOT NULL DEFAULT '',
  `insert_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `is_全局` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是全局消息, 0不是1是',
  `is_read` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已读, 0否1是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='会员消息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `idx_user_message`
--

LOCK TABLES `idx_user_message` WRITE;
/*!40000 ALTER TABLE `idx_user_message` DISABLE KEYS */;
INSERT INTO `idx_user_message` VALUES (1,2,'13939390001','意见反馈回复','测试','2021-01-08 17:00:30',0,0),(2,2,'13939390001','意见反馈回复','撒','2021-01-08 17:05:42',0,0),(3,2,'13939390001','测试发送','测试发送','2021-01-09 10:47:24',0,0),(4,2,'13939390001','测试发送2','测试发送2','2021-01-09 10:47:41',1,0),(5,3,'13939390011','测试发送2','测试发送2','2021-01-09 10:47:41',1,0),(6,2,'13939390001','找回交易密码申请通过','管理员已审核通过了您的找回交易密码的申请, 您的交易密码为123456。为保证您的密码安全, 请及时更新密码。','2021-01-09 13:18:57',0,1),(7,2,'13939390001','找回交易密码申请驳回','驳回测试','2021-01-09 13:20:57',0,1);
/*!40000 ALTER TABLE `idx_user_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `idx_user_mill`
--

DROP TABLE IF EXISTS `idx_user_mill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `idx_user_mill` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL DEFAULT '0',
  `user_identity` varchar(45) NOT NULL DEFAULT '',
  `mill_id` int NOT NULL DEFAULT '0',
  `number` int NOT NULL DEFAULT '0',
  `总价` decimal(11,2) NOT NULL DEFAULT '0.00',
  `剩余周期` int NOT NULL DEFAULT '0',
  `insert_time` date NOT NULL DEFAULT '0000-00-00',
  `operation_time` date NOT NULL DEFAULT '0000-00-00',
  `每日收益` decimal(11,2) NOT NULL DEFAULT '0.00',
  `总算力` decimal(11,2) NOT NULL DEFAULT '0.00',
  `总产出` decimal(11,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `idx_user_mill`
--

LOCK TABLES `idx_user_mill` WRITE;
/*!40000 ALTER TABLE `idx_user_mill` DISABLE KEYS */;
INSERT INTO `idx_user_mill` VALUES (1,2,'13939390001',1,2,2000.00,353,'2021-01-14','2021-01-19',20.00,2.00,80.00),(2,2,'13939390001',1,1,1000.00,353,'2021-01-14','2021-01-19',10.00,1.00,40.00),(3,2,'13939390001',1,1,1000.00,356,'2021-01-15','2021-01-19',10.00,1.00,40.00);
/*!40000 ALTER TABLE `idx_user_mill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `idx_user_mill_lease`
--

DROP TABLE IF EXISTS `idx_user_mill_lease`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `idx_user_mill_lease` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL DEFAULT '0',
  `user_identity` varchar(45) NOT NULL DEFAULT '',
  `mill_id` int NOT NULL DEFAULT '0',
  `number` int NOT NULL DEFAULT '0',
  `总价` decimal(11,2) NOT NULL DEFAULT '0.00',
  `剩余周期` int NOT NULL DEFAULT '0',
  `insert_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `operation_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `每日收益` decimal(11,2) NOT NULL DEFAULT '0.00',
  `总产出` decimal(11,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `idx_user_mill_lease`
--

LOCK TABLES `idx_user_mill_lease` WRITE;
/*!40000 ALTER TABLE `idx_user_mill_lease` DISABLE KEYS */;
INSERT INTO `idx_user_mill_lease` VALUES (1,2,'13939390001',1,2,1000.00,39,'2021-01-20 00:00:00','2021-01-19 00:00:00',100.00,100.00);
/*!40000 ALTER TABLE `idx_user_mill_lease` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `idx_withdraw`
--

DROP TABLE IF EXISTS `idx_withdraw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `idx_withdraw` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL DEFAULT '0',
  `user_identity` varchar(45) NOT NULL DEFAULT '',
  `coin_type` varchar(45) NOT NULL DEFAULT '',
  `address` varchar(245) NOT NULL DEFAULT '',
  `remark` varchar(145) NOT NULL DEFAULT '',
  `number` varchar(45) NOT NULL DEFAULT '',
  `fee` varchar(45) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `insert_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `operation_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='提现记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `idx_withdraw`
--

LOCK TABLES `idx_withdraw` WRITE;
/*!40000 ALTER TABLE `idx_withdraw` DISABLE KEYS */;
INSERT INTO `idx_withdraw` VALUES (3,2,'13939390001','USDT','大沙发沙发是浮点数','111','10000','',0,'2021-01-19 15:17:08','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `idx_withdraw` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_admin_operation`
--

DROP TABLE IF EXISTS `log_admin_operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_admin_operation` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '管理员操作日志',
  `admin_id` int NOT NULL DEFAULT '0' COMMENT '管理员id',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '类型，operation操作，login登录',
  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'ip',
  `content` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '内容',
  `remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `insert_time` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_admin_operation`
--

LOCK TABLES `log_admin_operation` WRITE;
/*!40000 ALTER TABLE `log_admin_operation` DISABLE KEYS */;
INSERT INTO `log_admin_operation` VALUES (8,0,'login','127.0.0.1','登录成功，账号：root','','2021-01-07 14:15:34'),(9,0,'login','127.0.0.1','登录成功，账号：root','','2021-01-07 13:31:08'),(10,1,'operation','127.0.0.1','会员信息添加：13939390001','','2021-01-07 13:34:14'),(11,1,'operation','127.0.0.1','会员信息添加：13939390011','','2021-01-07 13:35:12'),(12,1,'operation','127.0.0.1','活动添加：测试','','2021-01-07 15:16:00'),(13,1,'operation','127.0.0.1','修改活动信息, 活动id为:1','','2021-01-07 15:31:24'),(14,1,'operation','127.0.0.1','修改活动信息, 活动id为:1','','2021-01-07 15:31:34'),(15,1,'operation','127.0.0.1','修改活动信息, 活动id为:1','','2021-01-08 15:31:49'),(16,1,'operation','127.0.0.1','修改活动状态, 活动id为:1','','2021-01-08 15:34:45'),(17,1,'operation','127.0.0.1','修改活动状态, 活动id为:1','','2021-01-08 15:35:58'),(18,1,'operation','127.0.0.1','修改活动状态, 活动id为:1','','2021-01-08 15:36:41'),(19,1,'operation','127.0.0.1','修改活动状态, 活动id为:1','','2021-01-08 15:36:47'),(20,1,'operation','127.0.0.1','模块信息添加：应用管理','','2021-01-08 15:38:19'),(21,1,'operation','127.0.0.1','方法信息添加：活动管理','','2021-01-08 15:38:47'),(54,0,'login','127.0.0.1','登录成功，账号：root','','2021-01-09 10:03:56'),(55,1,'operation','127.0.0.1','方法信息添加：意见反馈','','2021-01-09 10:48:52'),(56,1,'operation','127.0.0.1','方法信息添加：意见反馈回复','','2021-01-09 10:49:07'),(57,1,'operation','127.0.0.1','方法信息添加：意见反馈状态','','2021-01-09 10:49:17'),(58,1,'operation','127.0.0.1','方法信息添加：会员消息','','2021-01-09 10:49:32'),(59,1,'operation','127.0.0.1','方法信息添加：发送消息','','2021-01-09 10:49:46'),(60,1,'operation','127.0.0.1','后台目录添加：应用管理','','2021-01-09 10:50:31'),(61,1,'operation','127.0.0.1','后台目录添加：意见反馈','','2021-01-09 10:51:10'),(62,1,'operation','127.0.0.1','后台目录添加：会员消息','','2021-01-09 10:51:39'),(63,1,'operation','127.0.0.1','找回交易密码审核, 数据ID为:1','','2021-01-09 13:18:57'),(64,1,'operation','127.0.0.1','找回交易密码审核, 数据ID为:1','','2021-01-09 13:20:57'),(65,1,'operation','127.0.0.1','方法信息添加：找回交易密码','','2021-01-09 13:21:51'),(66,1,'operation','127.0.0.1','方法信息添加：找回交易密码审核','','2021-01-09 13:22:05'),(67,1,'operation','127.0.0.1','后台目录添加：找回交易密码管理','','2021-01-09 13:22:36'),(68,1,'operation','127.0.0.1','方法信息添加：提现管理','','2021-01-09 14:55:30'),(69,1,'operation','127.0.0.1','方法信息添加：提现审核','','2021-01-09 14:55:43'),(70,1,'operation','127.0.0.1','后台目录添加：提现管理','','2021-01-09 14:56:16'),(71,1,'operation','127.0.0.1','角色信息权限设置：开发者','','2021-01-09 14:56:41'),(72,0,'login','127.0.0.1','登录成功，账号：root','','2021-01-11 11:08:52'),(73,0,'login','127.0.0.1','登录成功，账号：root','','2021-01-12 15:41:19'),(74,1,'operation','127.0.0.1','广告信息修改：注册协议->《炬象矿池平台服务协议》','','2021-01-12 15:48:07'),(75,0,'login','127.0.0.1','登录成功，账号：root','','2021-01-13 10:07:22'),(76,0,'login','127.0.0.1','登录成功，账号：root','','2021-01-13 10:07:30'),(77,1,'operation','127.0.0.1','广告信息修改：banner图五->banner图五','','2021-01-13 10:07:43'),(78,1,'operation','127.0.0.1','广告信息删除：banner图五','','2021-01-13 10:07:49'),(79,1,'operation','127.0.0.1','广告信息删除：banner图四','','2021-01-13 10:07:52'),(80,1,'operation','127.0.0.1','文章信息添加：这里是公告','','2021-01-13 10:12:23'),(81,1,'operation','127.0.0.1','修改活动状态, 活动id为:1','','2021-01-13 10:12:43'),(82,1,'operation','127.0.0.1','活动添加：测试2','','2021-01-13 10:13:00'),(83,1,'operation','127.0.0.1','活动添加：测试3','','2021-01-13 10:13:15'),(84,1,'operation','127.0.0.1','修改活动状态, 活动id为:2','','2021-01-13 10:13:18'),(85,1,'operation','127.0.0.1','修改活动状态, 活动id为:3','','2021-01-13 10:13:20'),(86,1,'operation','127.0.0.1','修改活动信息, 活动id为:3','','2021-01-13 10:21:12'),(87,1,'operation','127.0.0.1','网站设置添加: ','','2021-01-13 10:44:05'),(88,1,'operation','127.0.0.1','网站设置添加: 当前版本号','','2021-01-13 10:44:51'),(89,1,'operation','127.0.0.1','网站设置修改: 当前版本号 ','','2021-01-13 10:45:00'),(90,1,'operation','127.0.0.1','广告位信息添加：关于我们','','2021-01-13 10:47:26'),(91,1,'operation','127.0.0.1','广告信息修改：公司介绍->公司介绍','','2021-01-13 10:47:33'),(92,1,'operation','127.0.0.1','广告信息添加：协议与声明','','2021-01-13 10:47:54'),(93,1,'operation','127.0.0.1','广告位信息添加：邀请好友页面','','2021-01-13 11:16:07'),(94,1,'operation','127.0.0.1','广告信息添加：邀请好友页面头部图片','','2021-01-13 11:16:29'),(95,0,'login','127.0.0.1','登录成功，账号：root','','2021-01-13 15:02:33'),(96,1,'operation','127.0.0.1','网站设置添加: 1USDT可兑换CNY的比例','','2021-01-13 15:03:42'),(97,1,'operation','127.0.0.1','网站设置修改: 1USDT可兑换CNY的比例 ','','2021-01-13 15:03:46'),(98,1,'operation','127.0.0.1','网站设置添加: ','','2021-01-13 15:14:41'),(99,0,'login','127.0.0.1','登录成功，账号：root','','2021-01-14 09:18:31'),(100,1,'operation','127.0.0.1','广告位信息添加：算力','','2021-01-14 09:57:30'),(101,1,'operation','127.0.0.1','广告信息添加：算力说明','','2021-01-14 09:58:06'),(102,1,'operation','127.0.0.1','广告信息添加：算力风险','','2021-01-14 09:58:25'),(103,1,'operation','127.0.0.1','会员充值：给13939390022充值1000000USDT','','2021-01-14 10:41:28'),(104,1,'operation','127.0.0.1','会员充值：给13939390001充值100000USDT','','2021-01-14 10:41:41'),(105,1,'operation','127.0.0.1','修改算力状态, 算力id为:1','','2021-01-14 13:27:16'),(106,1,'operation','127.0.0.1','修改算力状态, 算力id为:1','','2021-01-14 13:27:21'),(107,1,'operation','127.0.0.1','算力添加：测试2','','2021-01-14 13:28:12'),(108,1,'operation','127.0.0.1','修改算力信息, 算力id为:2','','2021-01-14 13:29:39'),(109,1,'operation','127.0.0.1','修改算力状态, 算力id为:2','','2021-01-14 13:29:46'),(110,1,'operation','127.0.0.1','方法信息添加：算力管理','','2021-01-14 13:54:38'),(111,1,'operation','127.0.0.1','方法信息添加：算力添加','','2021-01-14 13:55:08'),(112,1,'operation','127.0.0.1','方法信息添加：算力添加提交','','2021-01-14 13:55:27'),(113,1,'operation','127.0.0.1','方法信息添加：算力修改','','2021-01-14 13:55:53'),(114,1,'operation','127.0.0.1','方法信息添加：算力修改提交','','2021-01-14 13:56:11'),(115,1,'operation','127.0.0.1','方法信息添加：算力状态修改','','2021-01-14 13:56:29'),(116,1,'operation','127.0.0.1','方法信息添加：持有算力管理','','2021-01-14 13:57:09'),(117,1,'operation','127.0.0.1','后台目录添加：算力管理','','2021-01-14 13:57:37'),(118,1,'operation','127.0.0.1','后台目录添加：持有算力管理','','2021-01-14 13:58:01'),(119,1,'operation','127.0.0.1','后台目录修改：应用管理->应用管理','','2021-01-14 13:58:36'),(120,0,'login','127.0.0.1','登录成功，账号：root','','2021-01-15 09:22:21'),(121,1,'operation','127.0.0.1','网站设置添加: 1USDT兑换FIL比例','','2021-01-15 11:36:06'),(122,1,'operation','127.0.0.1','网站设置修改: 1USDT兑换FIL比例 ','','2021-01-15 11:36:10'),(123,0,'login','127.0.0.1','登录成功，账号：root','','2021-01-16 14:31:13'),(124,1,'operation','127.0.0.1','修改算力信息, 算力id为:1','','2021-01-16 14:36:56'),(125,1,'operation','127.0.0.1','修改算力信息, 算力id为:2','','2021-01-16 14:37:09'),(126,0,'login','127.0.0.1','登录成功，账号：root','','2021-01-18 15:29:57'),(127,0,'login','127.0.0.1','登录成功，账号：root','','2021-01-19 09:41:00'),(128,0,'login','127.0.0.1','登录成功，账号：root','','2021-01-19 09:41:07'),(129,1,'operation','127.0.0.1','算力添加：测试111','','2021-01-19 09:43:01'),(130,1,'operation','127.0.0.1','修改算力信息, 算力id为:1','','2021-01-19 09:46:30'),(131,1,'operation','127.0.0.1','算力添加：测试222','','2021-01-19 09:47:36'),(132,1,'operation','127.0.0.1','修改算力状态, 算力id为:1','','2021-01-19 09:48:12'),(133,1,'operation','127.0.0.1','修改算力状态, 算力id为:2','','2021-01-19 09:48:13'),(134,1,'operation','127.0.0.1','方法信息添加：mill租赁','','2021-01-19 09:49:29'),(135,1,'operation','127.0.0.1','方法信息添加：单挖矿机租赁添加','','2021-01-19 09:50:00'),(136,1,'operation','127.0.0.1','方法信息添加：单挖矿机租赁提交','','2021-01-19 09:50:17'),(137,1,'operation','127.0.0.1','方法信息添加：单挖矿机租赁修改','','2021-01-19 09:50:34'),(138,1,'operation','127.0.0.1','方法信息添加：单挖矿机租赁修改提交','','2021-01-19 09:50:56'),(139,1,'operation','127.0.0.1','方法信息添加：单挖矿机租赁状态修改','','2021-01-19 09:51:17'),(140,1,'operation','127.0.0.1','方法信息添加：持有单挖租赁矿机','','2021-01-19 09:51:53'),(141,1,'operation','127.0.0.1','后台目录添加：持有单挖租赁算力','','2021-01-19 09:52:46'),(142,1,'operation','127.0.0.1','方法信息修改：mill租赁--列表->单挖租赁矿机','','2021-01-19 09:53:05'),(143,1,'operation','127.0.0.1','后台目录添加：单挖租赁算力','','2021-01-19 09:53:36'),(144,1,'operation','127.0.0.1','网站设置添加: USDT最小提现额度','','2021-01-19 14:07:20'),(145,1,'operation','127.0.0.1','网站设置添加: FIL最小提现额度','','2021-01-19 14:07:36'),(146,1,'operation','127.0.0.1','网站设置修改: USDT最小提现额度 FIL最小提现额度 ','','2021-01-19 14:07:43');
/*!40000 ALTER TABLE `log_admin_operation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_user_fund`
--

DROP TABLE IF EXISTS `log_user_fund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_user_fund` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '资金流水记录',
  `user_id` int NOT NULL DEFAULT '0' COMMENT '会员id',
  `user_identity` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '会员标识',
  `number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '金额',
  `coin_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '币种',
  `fund_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '操作类型',
  `content` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '说明',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `insert_time` datetime NOT NULL COMMENT '记录时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_user_fund`
--

LOCK TABLES `log_user_fund` WRITE;
/*!40000 ALTER TABLE `log_user_fund` DISABLE KEYS */;
INSERT INTO `log_user_fund` VALUES (1,2,'13939390001','2000','USDT','购买算力','购买测试2份','','2021-01-14 11:10:09'),(2,2,'13939390001','1000','USDT','购买算力','购买测试1份','','2021-01-14 11:10:43'),(3,2,'13939390001','260','FIL','算力收益','算力收益','','2021-01-15 11:49:06'),(4,2,'13939390001','130','FIL','算力收益','算力收益','','2021-01-15 11:49:06'),(5,2,'13939390001','1000','USDT','购买算力','购买测试1份','','2021-01-15 13:12:22'),(6,2,'13939390001','1000','USDT','租赁单挖算力','购买测试1112份','','2021-01-19 10:21:33'),(7,2,'13939390001','260','FIL','算力收益','算力收益','','2021-01-19 10:35:08'),(8,2,'13939390001','130','FIL','算力收益','算力收益','','2021-01-19 10:35:08'),(9,2,'13939390001','130','FIL','算力收益','算力收益','','2021-01-19 10:35:08'),(10,2,'13939390001','1300','FIL','算力收益','算力收益','','2021-01-19 10:35:08'),(11,2,'13939390001','260','FIL','算力收益','算力收益','','2021-01-19 10:35:37'),(12,2,'13939390001','130','FIL','算力收益','算力收益','','2021-01-19 10:35:37'),(13,2,'13939390001','130','FIL','算力收益','算力收益','','2021-01-19 10:35:37'),(14,2,'13939390001','260','FIL','算力收益','算力收益','','2021-01-19 10:36:38'),(15,2,'13939390001','130','FIL','算力收益','算力收益','','2021-01-19 10:36:38'),(16,2,'13939390001','130','FIL','算力收益','算力收益','','2021-01-19 10:36:38'),(17,2,'13939390001','260','FIL','算力收益','算力收益','','2021-01-19 10:36:42'),(18,2,'13939390001','130','FIL','算力收益','算力收益','','2021-01-19 10:36:42'),(19,2,'13939390001','130','FIL','算力收益','算力收益','','2021-01-19 10:36:42'),(22,2,'13939390001','-10000','USDT','提现','提现','','2021-01-19 15:17:08');
/*!40000 ALTER TABLE `log_user_fund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_user_operation`
--

DROP TABLE IF EXISTS `log_user_operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_user_operation` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '会员操作表',
  `user_id` int NOT NULL DEFAULT '0' COMMENT '会员id',
  `user_identity` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '会员标识',
  `content` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '操作内容',
  `remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'ip',
  `insert_time` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_user_operation`
--

LOCK TABLES `log_user_operation` WRITE;
/*!40000 ALTER TABLE `log_user_operation` DISABLE KEYS */;
INSERT INTO `log_user_operation` VALUES (1,2,'13939390001','提交意见反馈','operation','','2021-01-13 11:02:31'),(2,2,'13939390001','实名认证申请','operation','','2021-01-13 13:38:18'),(3,2,'13939390001','设置交易密码','operation','','2021-01-13 14:01:20'),(4,2,'13939390001','找回交易密码申请','operation','','2021-01-13 14:07:57'),(5,2,'13939390001','找回交易密码申请','operation','','2021-01-13 14:09:20'),(6,2,'13939390001','修改昵称','operation','','2021-01-13 14:34:00'),(7,2,'13939390001','修改登录密码','operation','','2021-01-13 14:45:22'),(8,2,'13939390001','修改头像','operation','','2021-01-13 14:59:06'),(9,2,'13939390001','修改头像','operation','','2021-01-13 15:09:56'),(10,2,'13939390001','修改头像','operation','','2021-01-13 15:10:45'),(11,2,'13939390001','修改头像','operation','','2021-01-13 15:11:11'),(12,2,'13939390001','购买算力','operation','','2021-01-14 11:10:09'),(13,2,'13939390001','购买算力','operation','','2021-01-14 11:10:43'),(14,2,'13939390001','购买算力','operation','','2021-01-15 13:12:22'),(15,2,'13939390001','租赁单挖算力','operation','','2021-01-19 10:21:33'),(18,2,'13939390001','提现申请','operation','','2021-01-19 15:17:08');
/*!40000 ALTER TABLE `log_user_operation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_ad`
--

DROP TABLE IF EXISTS `sys_ad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_ad` (
  `ad_id` int NOT NULL AUTO_INCREMENT COMMENT '广告id',
  `adv_id` int NOT NULL DEFAULT '0' COMMENT '广告位id',
  `sign` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标签',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '标题',
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '图片',
  `value` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '值',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '内容',
  PRIMARY KEY (`ad_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_ad`
--

LOCK TABLES `sys_ad` WRITE;
/*!40000 ALTER TABLE `sys_ad` DISABLE KEYS */;
INSERT INTO `sys_ad` VALUES (1,1,'banner','banner图一','/storage/ad/20210108/734f6e1bebe047ae0a709b839b27a83c.png','',''),(2,1,'banner','banner图二','/storage/ad/20210108/d1458fcd17b4efe1e42f7f5ed1d5c950.png','',''),(3,1,'banner','banner图三','/storage/ad/20210108/10a715822f3cda5418744e973bff4fe4.png','',''),(6,2,'注册协议','《炬象矿池平台服务协议》','','','<p>这里是《炬象矿池平台服务协议》</p>'),(7,4,'公司介绍','公司介绍','','','<p>这里是公司介绍</p>'),(8,2,'邀请规则','邀请规则','','','<p>这里是邀请规则</p>'),(9,3,'资产详解','资产详解','','','<p>这里是资产详解</p>'),(10,3,'如何修改交易密码','如何修改交易密码','','','<p>这里是如何修改交易密码</p>'),(11,3,'如何修改登录密码','如何修改登录密码','','','<p>这里是如何修改登录密码</p>'),(12,3,'如何邀请好友','如何邀请好友','','','<p>这里是如何邀请好友</p>'),(13,2,'IPFS云算力服务销售及托管协议','IPFS云算力服务销售及托管协议','','','<p>这里是IPFS云算力服务销售及托管协议</p>'),(14,4,'协议与声明','协议与声明','','','<p>协议与声明</p>'),(15,5,'邀请好友页面头部图片','邀请好友页面头部图片','/storage/ad/20210113/897bff1d831c341a289941169a51f21f.png','',''),(16,6,'算力说明','算力说明','','','<p>这里是算力说明</p>'),(17,6,'算力风险','算力风险','','','<p>这里是算力风险</p>');
/*!40000 ALTER TABLE `sys_ad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_adv`
--

DROP TABLE IF EXISTS `sys_adv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_adv` (
  `adv_id` int NOT NULL AUTO_INCREMENT COMMENT '广告位id',
  `adv_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '广告位名称',
  `sign` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '广告位标签',
  PRIMARY KEY (`adv_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_adv`
--

LOCK TABLES `sys_adv` WRITE;
/*!40000 ALTER TABLE `sys_adv` DISABLE KEYS */;
INSERT INTO `sys_adv` VALUES (1,'banner图','banners'),(2,'文章','content'),(3,'帮助','帮助'),(4,'关于我们','关于我们'),(5,'邀请好友页面','邀请好友页面'),(6,'算力','算力');
/*!40000 ALTER TABLE `sys_adv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_basic`
--

DROP TABLE IF EXISTS `sys_basic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_basic` (
  `id` tinyint NOT NULL COMMENT 'id',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `keyword` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '简介',
  `copyright` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '版权',
  `aq` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '备案号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_basic`
--

LOCK TABLES `sys_basic` WRITE;
/*!40000 ALTER TABLE `sys_basic` DISABLE KEYS */;
INSERT INTO `sys_basic` VALUES (1,'aner_admin后台管理系统','aner_admin，php，后台管理系统','aner_admin后台管理系统','','');
/*!40000 ALTER TABLE `sys_basic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_catalog`
--

DROP TABLE IF EXISTS `sys_catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_catalog` (
  `catalog_id` int NOT NULL AUTO_INCREMENT COMMENT '后台目录id',
  `title` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '标题',
  `icon` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '图标',
  `module_id` int DEFAULT NULL COMMENT '模块id',
  `action_id` int DEFAULT NULL COMMENT '方法id',
  `path` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '路径',
  `route` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '路由',
  `top_id` int NOT NULL DEFAULT '0' COMMENT '上级目录',
  `sort` tinyint DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`catalog_id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_catalog`
--

LOCK TABLES `sys_catalog` WRITE;
/*!40000 ALTER TABLE `sys_catalog` DISABLE KEYS */;
INSERT INTO `sys_catalog` VALUES (1,'开发者中心','la la-user-secret',0,0,'','',0,29),(2,'模块管理','la la-th-large',2,1,'system/module','/admin/system/module',1,1),(3,'方法管理','la la-th',2,8,'system/action','/admin/system/action',1,2),(4,'后台目录','la la-th-list',2,14,'system/catalog','/admin/system/catalog',1,3),(5,'静态资源管理','la la-file-o',0,0,'','',0,30),(6,'列表资源','la la-file-powerpoint-o',4,21,'system/table','/admin/system/resource/table',5,4),(7,'表单资源','la la-file-word-o',4,22,'system/form','/admin/system/resource/form',5,5),(8,'图标资源','la la-file-pdf-o',4,23,'system/icon','/admin/system/resource/icon',5,6),(9,'按钮资源','la la-file-audio-o',4,24,'system/button','/admin/system/resource/button',5,7),(10,'标题资源','la la-file-text',4,25,'system/text','/admin/system/resource/text',5,8),(11,'引导提示资源','la la-file-code-o',4,26,'system/notify','/admin/system/resource/notify',5,9),(12,'首页','la la-dashboard',5,27,'index/index','/admin',0,0),(13,'管理设置','la la-slideshare',0,0,'','',0,2),(14,'角色管理','la la-sitemap',8,28,'adm/role','/admin/role',13,1),(15,'管理员列表','la la-reddit',8,36,'adm/admin','/admin/admin',13,2),(16,'系统设置','la la-cog',0,0,'','',0,3),(17,'基本信息','la la-leanpub',9,43,'webset/basic','/admin/basic',16,1),(18,'网站设置','la la-wrench',9,45,'webset/setting','/admin/setting',16,2),(19,'广告管理',' la la-cc-amex',10,57,'ad/ad','/admin/ad',16,1),(20,'个人中心','la la-institution',0,0,'','',0,1),(21,'个人资料','la la-hdd-o',11,69,'me/detail','/admin/me/detail',20,1),(22,'修改密码',' la la-edit',11,71,'me/update_password','/admin/me/update/password',20,2),(23,'日志管理','la la-calendar',0,0,'','',0,20),(24,'管理员操作日志','la la-cutlery',12,73,'log/admin_operation_log','/admin/admin/operation/log',23,1),(25,'管理员登录日志','la la-map-signs',12,74,'log/admin_login_log','/admin/admin/login/log',23,2),(26,'文章管理','la la-server',0,0,'','',0,15),(29,'文章列表','la la-tasks',13,88,'cms/article','/admin/cms/article',26,3),(30,'会员管理','la la-users',0,0,'','',0,10),(31,'会员列表','la la-street-view',14,96,'user/user','/admin/user',30,1),(35,'会员资金流水日志','la la-credit-card',14,115,'log/user_fund_log','/admin/user/fund/log',23,2),(36,'会员操作日志','la la-newspaper-o',12,116,'log/user_operation_log','/admin/user/operation/log',23,3),(37,'活动管理','la la-bell-o',16,125,'app/活动','/admin/app/活动',26,2),(38,'应用管理',' la la-calculator',0,0,'','',0,11),(39,'意见反馈',' la la-edit',16,132,'app/意见反馈','/admin/app/意见反馈',38,1),(40,'会员消息',' la la-file-text',16,135,'app/会员消息','/admin/app/会员消息',30,3),(41,'找回交易密码管理','la la-file-image-o',16,137,'app/找回交易密码','/admin/app/找回交易密码',38,4),(42,'提现管理','la la-cloud-download',16,139,'app/提现','/admin/app/提现',38,6),(43,'算力管理','la la-cubes',16,141,'app/mill','/admin/app/mill',38,5),(44,'持有算力管理',' la la-dropbox',16,147,'app/会员算力','/admin/app/会员算力',30,4),(45,'持有单挖租赁算力',' la la-cc-paypal',16,154,'app/会员租赁算力','/admin/app/会员租赁算力',30,31),(46,'单挖租赁算力',' la la-cc-mastercard',16,148,'app/mill租赁','/admin/app/mill租赁',38,32);
/*!40000 ALTER TABLE `sys_catalog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_module`
--

DROP TABLE IF EXISTS `sys_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_module` (
  `module_id` int NOT NULL AUTO_INCREMENT COMMENT '模块id',
  `title` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模块名称',
  `sort` tinyint DEFAULT NULL COMMENT '排序',
  `remark` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_module`
--

LOCK TABLES `sys_module` WRITE;
/*!40000 ALTER TABLE `sys_module` DISABLE KEYS */;
INSERT INTO `sys_module` VALUES (5,'首页',1,''),(8,'管理设置',10,''),(9,'系统设置',20,''),(10,'广告模块',30,''),(11,'个人中心',40,''),(12,'日志管理',90,''),(13,'文章管理',80,''),(14,'会员管理',50,''),(16,'应用管理',60,'');
/*!40000 ALTER TABLE `sys_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_module_action`
--

DROP TABLE IF EXISTS `sys_module_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_module_action` (
  `action_id` int NOT NULL AUTO_INCREMENT COMMENT '方法id',
  `module_id` int DEFAULT NULL COMMENT '模块id',
  `title` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '方法名称',
  `path` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '路径',
  `route` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '路由',
  `sort` tinyint DEFAULT NULL COMMENT '排序',
  `remark` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`action_id`)
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_module_action`
--

LOCK TABLES `sys_module_action` WRITE;
/*!40000 ALTER TABLE `sys_module_action` DISABLE KEYS */;
INSERT INTO `sys_module_action` VALUES (27,5,'首页','index/index','/admin',1,''),(28,8,'角色管理-列表','adm/role','/admin/role',1,''),(29,8,'角色信息添加-表单','adm/role_add',NULL,2,''),(30,8,'角色信息添加-提交','adm/role_add_submit',NULL,3,''),(31,8,'角色信息修改-表单','adm/role_update',NULL,4,''),(32,8,'角色信息修改-提交','adm/role_update_submit',NULL,5,''),(33,8,'角色信息删除-操作','adm/role_delete_submit',NULL,6,''),(34,8,'角色权限设置-表单','adm/role_power',NULL,7,''),(35,8,'角色权限设置-提交','adm/role_power_submit',NULL,8,''),(36,8,'管理员管理-列表','adm/admin','/admin/admin',9,''),(37,8,'管理员信息添加-表单','adm/admin_add',NULL,10,''),(38,8,'管理员信息添加-提交','adm/admin_add_submit',NULL,11,''),(39,8,'管理员信息修改-表单','adm/admin_update',NULL,12,''),(40,8,'管理员信息修改-提交','adm/admin_update_submit',NULL,13,''),(41,8,'管理员信息删除-操作','adm/admin_delete_submit',NULL,14,''),(42,8,'分配管理员角色-操作','adm/admin_allot',NULL,15,''),(43,9,'基本信息展示-表单','webset/basic','/admin/basic',1,''),(44,9,'基本信息修改-提交','webset/basic_submit',NULL,2,''),(45,9,'网站设置-列表','webset/setting','/admin/setting',3,''),(51,9,'网站设置添加-表单','webset/setting_add','',9,''),(52,9,'网站设置信息添加-提交','webset/setting_add_submit','',10,''),(57,10,'广告管理-列表','ad/ad','/admin/ad',1,''),(58,10,'广告位信息添加-表单','ad/ad_adv_add',NULL,2,''),(59,10,'广告位信息添加-提交','ad/ad_adv_add_submit',NULL,3,''),(60,10,'广告位信息修改-表单','ad/ad_adv_update',NULL,4,''),(61,10,'广告位信息修改-提交','ad/ad_adv_update_submit',NULL,5,''),(62,10,'广告位信息删除-操作','ad/ad_adv_delete_submit',NULL,6,''),(63,10,'广告信息添加-表单','ad/ad_ad_add',NULL,7,''),(64,10,'广告信息添加-提交','ad/ad_ad_add_submit',NULL,8,''),(65,10,'广告信息修改-表单','ad/ad_ad_update',NULL,9,''),(66,10,'广告信息修改-提交','ad/ad_ad_update_submit',NULL,10,''),(67,10,'广告信息删除-操作','ad/ad_ad_delete_submit',NULL,11,''),(68,10,'广告信息文本编辑上传图片-提交','ad/ad_img',NULL,12,''),(69,11,'个人资料展示-表单','me/detail','/admin/me/detail',1,''),(70,11,'个人资料修改-提交','me/detail_submit',NULL,2,''),(71,11,'修改密码-表单','me/update_password','/admin/me/update/password',3,''),(72,11,'修改密码-提交','me/update_password_submit',NULL,4,''),(73,12,'管理员操作日志-列表','log/admin_operation_log','/admin/admin/operation/log',1,''),(74,12,'管理员登录日志-列表','log/admin_login_log','/admin/admin/login/log',2,''),(75,13,'文章标签管理-列表','cms/tag','/admin/cms/tag',1,''),(76,13,'文章标签信息添加-表单','cms/tag_add',NULL,2,''),(77,13,'文章标签信息添加-提交','cms/tag_add_submit',NULL,3,''),(78,13,'文章标签信息修改-表单','cms/tag_update',NULL,4,''),(79,13,'文章标签信息修改-提交','cms/tag_update_submit',NULL,5,''),(80,13,'文章标签信息删除-操作','cms/tag_delete_submit',NULL,6,''),(81,13,'文章分类管理-列表','cms/category','/admin/cms/category',7,''),(82,13,'文章分类信息添加-表单','cms/category_add',NULL,8,''),(83,13,'文章分类信息添加-提交','cms/category_add_submit',NULL,9,''),(84,13,'文章分类信息修改-表单','cms/category_update',NULL,10,''),(85,13,'文章分类信息修改-提交','cms/category_update_submit',NULL,11,''),(86,13,'文章分类信息删除-操作','cms/category_delete_submit',NULL,12,''),(88,13,'文章管理-列表','cms/article','/admin/cms/article',13,''),(89,13,'文章信息添加-表单','cms/article_add','',14,''),(90,13,'文章信息添加-提交','cms/article_add_submit','',15,''),(91,13,'文章信息修改-表单','cms/article_update','',16,''),(92,13,'文章信息修改-提交','cms/article_update_submit','',17,''),(93,13,'文章信息删除-操作','cms/article_delete_submit','',18,''),(94,13,'文章信息内容获取-操作','cms/article_content','',19,''),(95,13,'文章信息上传图片-操作','cms/article_img','',20,''),(96,14,'会员管理--列表','user/user','/admin/user',1,''),(97,14,'会员信息添加-表单','user/user_add','',2,''),(98,14,'会员信息添加-提交','user/user_add_submit','',3,''),(99,14,'会员团队-展示页','user/user_team','',4,''),(100,14,'会员详情-展示页','user/user_detail','',5,''),(101,14,'会员信息编辑-表单','user/user_update','',6,''),(102,14,'会员信息编辑-提交','user/user_update_submit','',7,''),(103,14,'会员登录权限设置-操作','user/user_freeze','',8,''),(104,14,'删除会员-操作','user/user_delete','',9,''),(105,14,'会员充值-表单','user/user_recharge','',10,''),(106,14,'会员充值-提交','user/user_recharge_submit','',11,''),(115,12,'会员资金流水日志-列表','log/user_fund_log','/admin/user/fund/log',3,''),(116,12,'会员操作日志-列表','log/user_operation_log','/admin/user/operation/log',4,''),(117,9,'网站设置值修改--提交','webset/setting_value_submit','',21,''),(125,16,'活动管理--列表','app/活动','/admin/app/活动',1,''),(126,16,'活动添加页面--表单','app/活动添加','',2,''),(127,16,'活动添加提交--提交','app/活动添加提交','',3,''),(128,16,'活动修改页面--表单','app/活动修改','',4,''),(129,16,'活动修改提交--提交','app/活动修改提交','',5,''),(130,16,'活动状态修改--操作','app/活动状态','',6,''),(131,16,'活动内容查看--操作','app/活动内容','',7,''),(132,16,'意见反馈--列表','app/意见反馈','/admin/app/意见反馈',9,''),(133,16,'意见反馈回复--操作','app/意见反馈回复','',10,''),(134,16,'意见反馈状态--操作','app/意见反馈状态','',11,''),(135,16,'会员消息--列表','app/会员消息','/admin/app/会员消息',12,''),(136,16,'发送消息--提交','app/发送消息','',13,''),(137,16,'找回交易密码--列表','app/找回交易密码','/admin/app/找回交易密码',13,''),(138,16,'找回交易密码审核--操作','app/找回交易密码审核','',14,''),(139,16,'提现管理--列表','app/提现','/admin/app/提现',16,''),(140,16,'提现审核--操作','app/提现审核','',17,''),(141,16,'算力管理--列表','app/mill','/admin/app/mill',18,''),(142,16,'算力添加--表单','app/mill_add','',19,''),(143,16,'算力添加提交--提交','app/mill_add_submit','',20,''),(144,16,'算力修改--表单','app/mill_update','',21,''),(145,16,'算力修改提交--提交','app/mill_update_submit','',22,''),(146,16,'算力状态修改--操作','app/mill_status','',23,''),(147,16,'持有算力管理--列表','app/会员算力','/admin/app/会员算力',24,''),(148,16,'单挖租赁矿机--列表','app/mill租赁','/admin/app/mill租赁',25,''),(149,16,'单挖矿机租赁添加--表单','app/mill租赁_add','',26,''),(150,16,'单挖矿机租赁提交--提交','app/mill租赁_add_submit','',27,''),(151,16,'单挖矿机租赁修改--表单','app/mill租赁_update','',28,''),(152,16,'单挖矿机租赁修改提交--提交','app/mill租赁_update_submit','',29,''),(153,16,'单挖矿机租赁状态修改--操作','app/mill租赁_status','',30,''),(154,16,'持有单挖租赁矿机--列表','app/会员租赁算力','/admin/app/会员租赁算力',31,'');
/*!40000 ALTER TABLE `sys_module_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_setting`
--

DROP TABLE IF EXISTS `sys_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_setting` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '设置id',
  `type` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '类型: cgory 分类  value 设置',
  `category_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '分类名称',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `input_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '表单类型',
  `sign` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标签',
  `value` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '值',
  `sort` int NOT NULL DEFAULT '1' COMMENT '排序',
  `remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '备注, select表单是以逗号分割的, 其他为输入提示',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_setting`
--

LOCK TABLES `sys_setting` WRITE;
/*!40000 ALTER TABLE `sys_setting` DISABLE KEYS */;
INSERT INTO `sys_setting` VALUES (3,'cgory','网站设置','','','','',1,''),(4,'value','网站设置','当前版本号','text','版本号','炬象矿池1.0.0',0,'版本号规则:  炬象矿池x.x.x'),(5,'value','网站设置','1USDT可兑换CNY的比例','number','USDT2CNY','7',2,''),(6,'cgory','公家账号','','','','',2,''),(7,'value','网站设置','1USDT兑换FIL比例','number','USDT2FIL','13',3,''),(8,'value','网站设置','USDT最小提现额度','number','USDT最小提现额度','5',3,''),(9,'value','网站设置','FIL最小提现额度','number','FIL最小提现额度','50',3,'');
/*!40000 ALTER TABLE `sys_setting` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-19 15:45:46

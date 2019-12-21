/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50725
 Source Host           : localhost:3306
 Source Schema         : zup

 Target Server Type    : MySQL
 Target Server Version : 50725
 File Encoding         : 65001

 Date: 21/12/2019 10:10:38
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `ACCOUNTID` int(11) NOT NULL AUTO_INCREMENT,
  `USERID` int(38) DEFAULT NULL,
  `ACCOUNTNAME` varchar(255) NOT NULL,
  `PASSWORD` varchar(255) NOT NULL,
  `VALIDFLAG` int(3) DEFAULT NULL,
  `ACCOUNTTYPE` int(11) DEFAULT NULL,
  `accountUsed` varchar(64) DEFAULT NULL,
  `responsiblepersion` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`ACCOUNTID`),
  KEY `userids` (`USERID`) USING BTREE,
  CONSTRAINT `account_ibfk_1` FOREIGN KEY (`USERID`) REFERENCES `userinfo` (`USERID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account
-- ----------------------------
BEGIN;
INSERT INTO `account` VALUES (1, 1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', 1, 1, '1', '1');
COMMIT;

-- ----------------------------
-- Table structure for accountrole
-- ----------------------------
DROP TABLE IF EXISTS `accountrole`;
CREATE TABLE `accountrole` (
  `ACCOUNTID` int(38) NOT NULL,
  `ROLEID` int(38) NOT NULL,
  PRIMARY KEY (`ACCOUNTID`,`ROLEID`),
  KEY `arr` (`ROLEID`) USING BTREE,
  CONSTRAINT `accountrole_ibfk_1` FOREIGN KEY (`ACCOUNTID`) REFERENCES `account` (`ACCOUNTID`),
  CONSTRAINT `accountrole_ibfk_2` FOREIGN KEY (`ROLEID`) REFERENCES `role` (`ROLEID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of accountrole
-- ----------------------------
BEGIN;
INSERT INTO `accountrole` VALUES (1, 1);
COMMIT;

-- ----------------------------
-- Table structure for action
-- ----------------------------
DROP TABLE IF EXISTS `action`;
CREATE TABLE `action` (
  `ACTIONID` int(38) NOT NULL AUTO_INCREMENT,
  `MENUID` int(38) NOT NULL,
  `ACTIONNAME` varchar(255) DEFAULT NULL,
  `CAPTION` varchar(255) DEFAULT NULL,
  `ACTIONTYPE` int(10) DEFAULT NULL,
  `ACTIONCODE` varchar(127) DEFAULT NULL,
  PRIMARY KEY (`ACTIONID`),
  KEY `menuid` (`MENUID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ahp_flow
-- ----------------------------
DROP TABLE IF EXISTS `ahp_flow`;
CREATE TABLE `ahp_flow` (
  `FLOW_ID` int(11) NOT NULL AUTO_INCREMENT,
  `FLOW_NAME` varchar(64) NOT NULL,
  `SYSTEM_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`FLOW_ID`),
  KEY `RefWF_SYSTEM42` (`SYSTEM_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ahp_line
-- ----------------------------
DROP TABLE IF EXISTS `ahp_line`;
CREATE TABLE `ahp_line` (
  `LINE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `FLOW_ID` int(11) NOT NULL,
  `BEGIN_CODE` varchar(32) DEFAULT NULL,
  `END_CODE` varchar(32) DEFAULT NULL,
  `LINE_CONTENT` varchar(2048) DEFAULT NULL,
  `LINE_INFLECTION` varchar(32) DEFAULT NULL,
  `LINE_NAME` varchar(32) DEFAULT NULL,
  `LINE_CODE` varchar(32) DEFAULT NULL,
  `LINE_TYPE` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`LINE_ID`),
  KEY `FK_WF_LINE_WF_FLOW` (`FLOW_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ahp_node
-- ----------------------------
DROP TABLE IF EXISTS `ahp_node`;
CREATE TABLE `ahp_node` (
  `NODE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `FLOW_ID` int(11) NOT NULL,
  `NODE_CODE` varchar(64) DEFAULT NULL,
  `NODE_NAME` varchar(64) DEFAULT NULL,
  `NODE_LEFT` decimal(4,0) DEFAULT NULL,
  `NODE_TOP` decimal(4,0) DEFAULT NULL,
  `NODE_ICON` varchar(32) DEFAULT NULL,
  `NODE_TYPE` varchar(26) DEFAULT NULL,
  `NEXT_NODE_CODE` varchar(64) DEFAULT NULL,
  `NODE_WEIGHT` double(5,4) DEFAULT '1.0000',
  PRIMARY KEY (`NODE_ID`),
  KEY `FK_WF_ACTIVITY_WF_FLOW` (`FLOW_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ahp_node_relation
-- ----------------------------
DROP TABLE IF EXISTS `ahp_node_relation`;
CREATE TABLE `ahp_node_relation` (
  `NODE_RELATION_ID` int(11) NOT NULL AUTO_INCREMENT,
  `NODE_ID_1` int(11) DEFAULT NULL,
  `NODE_ID_2` int(11) DEFAULT NULL,
  `PARENT_NODE_ID` int(11) DEFAULT NULL,
  `VALUE` decimal(7,4) DEFAULT NULL,
  PRIMARY KEY (`NODE_RELATION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ahp_norm_base
-- ----------------------------
DROP TABLE IF EXISTS `ahp_norm_base`;
CREATE TABLE `ahp_norm_base` (
  `NORM_ID` int(11) NOT NULL AUTO_INCREMENT,
  `NORM_CODE` varchar(255) DEFAULT NULL,
  `NORM_NAME` varchar(255) DEFAULT NULL,
  `NORM_TYPE` int(5) DEFAULT '1',
  `NORM_FUN` varchar(2048) DEFAULT NULL,
  `NORM_VALUE` decimal(5,4) DEFAULT '1.0000',
  `NORM_SOURCE` varchar(1024) DEFAULT NULL,
  `SYSTEM_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`NORM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ahp_norm_node
-- ----------------------------
DROP TABLE IF EXISTS `ahp_norm_node`;
CREATE TABLE `ahp_norm_node` (
  `NORM_NODE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `NODE_CODE` varchar(11) DEFAULT NULL,
  `NORM_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`NORM_NODE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for area_evaluation
-- ----------------------------
DROP TABLE IF EXISTS `area_evaluation`;
CREATE TABLE `area_evaluation` (
  `evaluation_id` int(11) NOT NULL AUTO_INCREMENT,
  `FLOW_ID` int(11) DEFAULT NULL,
  `province` int(11) DEFAULT NULL,
  `city` int(11) DEFAULT NULL,
  `country` int(11) DEFAULT NULL,
  `AREA_NAME` varchar(32) DEFAULT NULL,
  `EVALUATION_USER` varchar(32) DEFAULT NULL,
  `EVALUATION_DATE` datetime NOT NULL,
  `EVALUATION_VALUE` decimal(18,2) DEFAULT NULL,
  `EVALUATION_RESULT` int(11) DEFAULT NULL,
  `EVALUATION_CURRENTVALUE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`evaluation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for bi_block
-- ----------------------------
DROP TABLE IF EXISTS `bi_block`;
CREATE TABLE `bi_block` (
  `BLOCK_ID` int(38) NOT NULL AUTO_INCREMENT,
  `BLOCK_FLAG` varchar(255) DEFAULT NULL,
  `X_POINT` int(10) DEFAULT NULL,
  `Y_POINT` int(10) DEFAULT NULL,
  `WIDTH` int(10) DEFAULT NULL,
  `HEIGHT` int(10) DEFAULT NULL,
  `REPORT_ID` int(38) DEFAULT NULL,
  `BI_PAGE_ID` int(38) DEFAULT NULL,
  `BLOCK_TYPE` int(5) DEFAULT NULL,
  `SCREEN_INDEX` int(11) DEFAULT NULL,
  PRIMARY KEY (`BLOCK_ID`),
  KEY `REPORTID` (`REPORT_ID`) USING BTREE,
  KEY `ID` (`BLOCK_ID`) USING BTREE,
  KEY `PAGEID` (`BI_PAGE_ID`) USING BTREE,
  CONSTRAINT `bi_block_ibfk_1` FOREIGN KEY (`BI_PAGE_ID`) REFERENCES `bi_page` (`BI_PAGE_ID`),
  CONSTRAINT `bi_block_ibfk_2` FOREIGN KEY (`REPORT_ID`) REFERENCES `bi_report` (`REPORT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=547 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bi_block
-- ----------------------------
BEGIN;
INSERT INTO `bi_block` VALUES (546, NULL, 1, NULL, NULL, NULL, 170, 29, 2, 1);
COMMIT;

-- ----------------------------
-- Table structure for bi_dim
-- ----------------------------
DROP TABLE IF EXISTS `bi_dim`;
CREATE TABLE `bi_dim` (
  `DIM_ID` int(38) NOT NULL AUTO_INCREMENT,
  `DIM_NAME` varchar(127) DEFAULT '',
  `BIZ_TABLE_NAME` varchar(100) DEFAULT '',
  `TEXT_FIELD` varchar(150) DEFAULT '',
  `ID_FIELD` varchar(500) DEFAULT '',
  `DRILL_TYPE` int(10) DEFAULT NULL,
  `DRILL_INFO` varchar(512) DEFAULT '',
  PRIMARY KEY (`DIM_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=255 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bi_dim
-- ----------------------------
BEGIN;
INSERT INTO `bi_dim` VALUES (253, '商品分类信息', 'pms_product_catego1ry', 'name', 'id', 1, '');
INSERT INTO `bi_dim` VALUES (254, '商品品牌', 'pms_bra1nd', 'name', 'id', 1, '');
COMMIT;

-- ----------------------------
-- Table structure for bi_dim_attribute
-- ----------------------------
DROP TABLE IF EXISTS `bi_dim_attribute`;
CREATE TABLE `bi_dim_attribute` (
  `ATTRIBUTE_ID` int(38) NOT NULL AUTO_INCREMENT,
  `DIM_ID` int(38) NOT NULL,
  `ATTRIBUTE_NAME` varchar(63) DEFAULT '',
  `ATTRIBUTE_VALUE_FIELD` varchar(63) DEFAULT '',
  `ATTRIBUTE_CAPTION_FIELD` varchar(63) DEFAULT '',
  PRIMARY KEY (`ATTRIBUTE_ID`),
  KEY `dimids` (`DIM_ID`) USING BTREE,
  CONSTRAINT `bi_dim_attribute_ibfk_1` FOREIGN KEY (`DIM_ID`) REFERENCES `bi_dim` (`DIM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for bi_page
-- ----------------------------
DROP TABLE IF EXISTS `bi_page`;
CREATE TABLE `bi_page` (
  `BI_PAGE_ID` int(10) NOT NULL AUTO_INCREMENT,
  `PAGE_TYPE` int(10) DEFAULT NULL,
  `PAGE_TITLE` varchar(255) DEFAULT NULL,
  `PAGE_NAME` varchar(255) DEFAULT NULL,
  `PAGE_URL` varchar(255) DEFAULT NULL,
  `MENU_ID` int(10) DEFAULT NULL,
  `MENU_NAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`BI_PAGE_ID`),
  KEY `pageid` (`BI_PAGE_ID`) USING BTREE,
  KEY `muid` (`MENU_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bi_page
-- ----------------------------
BEGIN;
INSERT INTO `bi_page` VALUES (29, 1, '商品统计展示', '统计演示', 'bi/biBlueLargeScreenTemplate', 198409, '/Bi/198409');
COMMIT;

-- ----------------------------
-- Table structure for bi_report
-- ----------------------------
DROP TABLE IF EXISTS `bi_report`;
CREATE TABLE `bi_report` (
  `REPORT_ID` int(38) NOT NULL AUTO_INCREMENT COMMENT '报表id',
  `TOPIC_ID` int(38) NOT NULL COMMENT '主题id',
  `REPORT_NAME` varchar(63) DEFAULT '' COMMENT '报表名称',
  `REPORT_TITLE` varchar(127) DEFAULT '' COMMENT '报表标题',
  `CREATE_DATE` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `PAGE_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`REPORT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=171 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bi_report
-- ----------------------------
BEGIN;
INSERT INTO `bi_report` VALUES (170, 45, '分类商品价格趋势', '分类商品价格趋势', '2019-12-20 23:32:20', 29);
COMMIT;

-- ----------------------------
-- Table structure for bi_report_field
-- ----------------------------
DROP TABLE IF EXISTS `bi_report_field`;
CREATE TABLE `bi_report_field` (
  `REPORT_FIELD_ID` int(38) NOT NULL AUTO_INCREMENT,
  `REPORT_ID` int(38) NOT NULL,
  `FIELD_ID` int(38) DEFAULT NULL,
  `FIELD_LOCATION` int(5) DEFAULT NULL,
  `DIM_ORDER` int(5) DEFAULT NULL,
  `DISPLAY` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`REPORT_FIELD_ID`),
  KEY `reportid` (`REPORT_ID`) USING BTREE,
  CONSTRAINT `bi_report_field_ibfk_1` FOREIGN KEY (`REPORT_ID`) REFERENCES `bi_report` (`REPORT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=580 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bi_report_field
-- ----------------------------
BEGIN;
INSERT INTO `bi_report_field` VALUES (577, 170, 215, 3, 1, NULL);
INSERT INTO `bi_report_field` VALUES (578, 170, 216, 1, 1, NULL);
INSERT INTO `bi_report_field` VALUES (579, 170, 219, 3, 1, NULL);
COMMIT;

-- ----------------------------
-- Table structure for bi_screen
-- ----------------------------
DROP TABLE IF EXISTS `bi_screen`;
CREATE TABLE `bi_screen` (
  `SCREEN_ID` int(10) NOT NULL AUTO_INCREMENT,
  `SCREEN_NAME` varchar(255) DEFAULT NULL,
  `SCREEN_INDEX` int(8) DEFAULT NULL,
  `PAGE_ID` int(10) DEFAULT NULL,
  PRIMARY KEY (`SCREEN_ID`),
  KEY `page_Id` (`PAGE_ID`) USING BTREE,
  CONSTRAINT `bi_screen_ibfk_1` FOREIGN KEY (`PAGE_ID`) REFERENCES `bi_page` (`BI_PAGE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bi_screen
-- ----------------------------
BEGIN;
INSERT INTO `bi_screen` VALUES (31, '首页', 1, 29);
COMMIT;

-- ----------------------------
-- Table structure for bi_topic
-- ----------------------------
DROP TABLE IF EXISTS `bi_topic`;
CREATE TABLE `bi_topic` (
  `TOPIC_ID` int(38) NOT NULL AUTO_INCREMENT COMMENT '主题id',
  `TOPIC_NAME` varchar(38) DEFAULT '' COMMENT '主题名称',
  `TOPIC_CAPTION` varchar(128) DEFAULT '',
  `TOPIC_TYPE` int(10) DEFAULT NULL COMMENT '主题类型',
  `BIZ_TABLE_NAME` varchar(63) DEFAULT '' COMMENT '表名称',
  PRIMARY KEY (`TOPIC_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bi_topic
-- ----------------------------
BEGIN;
INSERT INTO `bi_topic` VALUES (45, 'product_info', '商品信息', NULL, 'pms_product');
COMMIT;

-- ----------------------------
-- Table structure for bi_topic_field
-- ----------------------------
DROP TABLE IF EXISTS `bi_topic_field`;
CREATE TABLE `bi_topic_field` (
  `FIELD_ID` int(38) NOT NULL AUTO_INCREMENT COMMENT '主题字段',
  `FIELD_NAME` varchar(255) DEFAULT '' COMMENT '字段名称',
  `FIELD_CAPTION` varchar(255) DEFAULT '',
  `FIELD_TITLE` varchar(255) DEFAULT NULL,
  `DATA_TYPE` int(10) DEFAULT NULL COMMENT '数据类型',
  `FIELD_LENGTH` int(128) DEFAULT NULL COMMENT '字段长度',
  `FIELD_DECIMAL` int(10) DEFAULT NULL COMMENT '字段小数',
  `FIELD_NULL` int(10) DEFAULT NULL COMMENT '是否为空',
  `FIELD_IDENTITY` int(10) DEFAULT NULL COMMENT '是否唯一',
  `TOPIC_ID` int(38) DEFAULT NULL COMMENT '主题id',
  `DIM_ID` int(38) DEFAULT NULL COMMENT '维表id',
  `FIELD_TYPE` int(10) DEFAULT NULL COMMENT '聚合类型',
  `AGGREGATE_TYPE` varchar(38) DEFAULT NULL,
  `FIELD_UNIT` varchar(38) DEFAULT NULL,
  PRIMARY KEY (`FIELD_ID`),
  KEY `rdids` (`TOPIC_ID`) USING BTREE,
  KEY `DIM_ID` (`DIM_ID`) USING BTREE,
  CONSTRAINT `bi_topic_field_ibfk_1` FOREIGN KEY (`TOPIC_ID`) REFERENCES `bi_topic` (`TOPIC_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=220 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bi_topic_field
-- ----------------------------
BEGIN;
INSERT INTO `bi_topic_field` VALUES (215, 'id', 'id', '商品数量', 1, 10, 4, 1, 1, 45, NULL, 3, 'COUNT', '数量');
INSERT INTO `bi_topic_field` VALUES (216, 'product_category_id', 'product_category_id', '类型', 2, 10, 4, 1, 1, 45, 253, 1, NULL, '');
INSERT INTO `bi_topic_field` VALUES (217, 'brand_id', 'brand_id', '品牌', 2, 10, 4, 1, 1, 45, 254, 1, NULL, '');
INSERT INTO `bi_topic_field` VALUES (218, 'name', 'name', '名称', 2, 10, 4, 1, 1, 45, NULL, 2, NULL, '');
INSERT INTO `bi_topic_field` VALUES (219, 'price', 'price', '价格', 1, 10, 4, 1, 1, 45, NULL, 2, NULL, '元');
COMMIT;

-- ----------------------------
-- Table structure for bug_feedback_info
-- ----------------------------
DROP TABLE IF EXISTS `bug_feedback_info`;
CREATE TABLE `bug_feedback_info` (
  `BFI_ID` int(38) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(38) NOT NULL,
  `USER_LINK` varchar(50) NOT NULL DEFAULT '',
  `BFI_CONTENT` varchar(200) NOT NULL DEFAULT '',
  `FEEDBACK_TIME` datetime NOT NULL,
  `BFI_TYPE` int(38) NOT NULL,
  `SYSTEM_ID` int(38) NOT NULL,
  `MEMO` varchar(200) DEFAULT '',
  `BUG_STATE` int(38) NOT NULL,
  `USER_NAME` varchar(32) DEFAULT NULL,
  `SYSTEM_NAME` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`BFI_ID`),
  KEY `SYSTEM_IDSYSTEM_ID` (`SYSTEM_ID`) USING BTREE,
  KEY `USER_ID` (`USER_ID`) USING BTREE,
  CONSTRAINT `bug_feedback_info_ibfk_1` FOREIGN KEY (`SYSTEM_ID`) REFERENCES `system` (`SYSTEMID`),
  CONSTRAINT `bug_feedback_info_ibfk_2` FOREIGN KEY (`USER_ID`) REFERENCES `userinfo` (`USERID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for codeconfig
-- ----------------------------
DROP TABLE IF EXISTS `codeconfig`;
CREATE TABLE `codeconfig` (
  `CONFIGID` int(38) NOT NULL AUTO_INCREMENT,
  `CONFIGCODE` varchar(128) NOT NULL,
  `MEMO` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`CONFIGID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for codeserial
-- ----------------------------
DROP TABLE IF EXISTS `codeserial`;
CREATE TABLE `codeserial` (
  `SERIAL` int(38) NOT NULL,
  `CODETYPE` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`CODETYPE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config` (
  `CONFIGID` int(38) NOT NULL AUTO_INCREMENT,
  `SUBID` int(38) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `SUBNAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`CONFIGID`,`SUBID`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of config
-- ----------------------------
BEGIN;
INSERT INTO `config` VALUES (77, 1, '数据类型', '数字');
INSERT INTO `config` VALUES (77, 2, '数据类型', '文本');
INSERT INTO `config` VALUES (78, 1, '是否字段', '是');
INSERT INTO `config` VALUES (78, 2, '是否字段', '否');
INSERT INTO `config` VALUES (79, 1, '字段类型', '关联维度表');
INSERT INTO `config` VALUES (79, 2, '字段类型', '普通字段');
INSERT INTO `config` VALUES (79, 3, '字段类型', '聚合字段');
INSERT INTO `config` VALUES (80, 1, '页面类型', '科技大屏');
INSERT INTO `config` VALUES (80, 2, '页面类型', '流式布局');
INSERT INTO `config` VALUES (81, 1, '科技大屏模板', 'bi/biBlueLargeScreenTemplate');
INSERT INTO `config` VALUES (82, 2, '流式布局模板', 'bi/biFlowLayoutTemplate');
COMMIT;

-- ----------------------------
-- Table structure for domain_system
-- ----------------------------
DROP TABLE IF EXISTS `domain_system`;
CREATE TABLE `domain_system` (
  `RELATION_ID` int(38) NOT NULL AUTO_INCREMENT,
  `SYSTEM_ID` int(38) DEFAULT NULL,
  `SYSTEM_NAME` varchar(255) DEFAULT NULL,
  `DOMAIN` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`RELATION_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of domain_system
-- ----------------------------
BEGIN;
INSERT INTO `domain_system` VALUES (1, 1, 'ZUP', 'homeController');
COMMIT;

-- ----------------------------
-- Table structure for evaluation_x
-- ----------------------------
DROP TABLE IF EXISTS `evaluation_x`;
CREATE TABLE `evaluation_x` (
  `EVALUATION_ID` int(11) NOT NULL DEFAULT '0',
  `MINE_NAME` varchar(255) DEFAULT NULL,
  `EVALUATION_VALUE` double(11,7) DEFAULT NULL,
  `EVALUATION_DATE` datetime DEFAULT NULL,
  `DATA_SOURCE_DATE` int(11) DEFAULT NULL,
  `MINE_SURVEY_ID` int(11) DEFAULT NULL,
  `FLOW_ID` int(11) DEFAULT NULL,
  `batch_ID` int(11) NOT NULL,
  `EVALUATION_CURRENTVALUE` char(255) DEFAULT NULL,
  `PROVINCE` int(11) DEFAULT NULL,
  `CITY` int(11) DEFAULT NULL,
  `COUNTY` int(11) DEFAULT NULL,
  `PROVINCE_NAME` varchar(50) NOT NULL,
  `CITY_NAME` varchar(50) NOT NULL,
  `COUNTY_NAME` varchar(60) NOT NULL,
  `LONGITUDE` varchar(31) DEFAULT NULL,
  `LATITUDE` varchar(32) DEFAULT NULL,
  `MINERALS_TYPE_ID` int(11) DEFAULT NULL,
  `MINERALS_TYPE_NAME` varchar(32) NOT NULL,
  `MINE_SCALE` tinyint(4) DEFAULT NULL,
  `SUB_NM` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for file_format
-- ----------------------------
DROP TABLE IF EXISTS `file_format`;
CREATE TABLE `file_format` (
  `FILEFORMATID` int(38) NOT NULL AUTO_INCREMENT,
  `FORMATNAME` varchar(64) NOT NULL DEFAULT '',
  `EXTENSIONNAME` varchar(32) NOT NULL DEFAULT '',
  `SUPPORTPREVIEW` int(10) NOT NULL,
  `PREVIEWFORM` int(38) DEFAULT NULL,
  PRIMARY KEY (`FILEFORMATID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for file_package
-- ----------------------------
DROP TABLE IF EXISTS `file_package`;
CREATE TABLE `file_package` (
  `FILEPACKAGEID` int(38) NOT NULL AUTO_INCREMENT,
  `FILEPACKAGENAME` varchar(127) NOT NULL DEFAULT '',
  `PARENTID` int(38) NOT NULL,
  `PHYSICALPATH` varchar(255) NOT NULL DEFAULT '',
  `CREATEUSER` varchar(16) NOT NULL DEFAULT '',
  `CREATEDATE` datetime NOT NULL,
  `APPROVEFLAG` int(10) NOT NULL,
  `DESCRIPTION` varchar(511) DEFAULT '',
  PRIMARY KEY (`FILEPACKAGEID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for file_virtual
-- ----------------------------
DROP TABLE IF EXISTS `file_virtual`;
CREATE TABLE `file_virtual` (
  `VIRTUALFILECODE` varchar(32) NOT NULL DEFAULT '',
  `FILEVERSION` varchar(10) NOT NULL DEFAULT '',
  `FILEID` varchar(32) NOT NULL DEFAULT '',
  `FILEFORMATID` int(38) NOT NULL,
  `PHYSICALNAME` varchar(255) NOT NULL DEFAULT '',
  `REALNAME` varchar(32) DEFAULT '',
  `UPLOADER` int(38) DEFAULT NULL,
  `UPLOADTIME` datetime NOT NULL,
  `FILEHASH` varchar(32) DEFAULT '',
  `VERSIONDESCRIPTION` varchar(511) DEFAULT '',
  `BUSINESSKEY` varchar(64) DEFAULT '',
  `VIRTUALFILEID` int(38) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`VIRTUALFILEID`),
  KEY `FILEFORMATID` (`FILEFORMATID`) USING BTREE,
  CONSTRAINT `file_virtual_ibfk_1` FOREIGN KEY (`FILEFORMATID`) REFERENCES `file_format` (`FILEFORMATID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for files
-- ----------------------------
DROP TABLE IF EXISTS `files`;
CREATE TABLE `files` (
  `FILECODE` varchar(20) DEFAULT '',
  `FILEPACKAGEID` int(38) NOT NULL,
  `FILENAME` varchar(255) NOT NULL,
  `TOTALNUMBER` int(38) DEFAULT NULL,
  `CURRENTNUMBER` int(38) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT '',
  `FILECREATER` varchar(27) DEFAULT '',
  `FILECREATEDATE` datetime DEFAULT NULL,
  `FILEID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`FILEID`),
  KEY `FILEPACKAGEID` (`FILEPACKAGEID`) USING BTREE,
  CONSTRAINT `files_ibfk_1` FOREIGN KEY (`FILEPACKAGEID`) REFERENCES `file_package` (`FILEPACKAGEID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for loginlog
-- ----------------------------
DROP TABLE IF EXISTS `loginlog`;
CREATE TABLE `loginlog` (
  `LOGINLOGID` int(38) NOT NULL AUTO_INCREMENT,
  `ACCOUNTID` int(38) NOT NULL,
  `USERID` int(38) NOT NULL,
  `LOGDATETIME` datetime DEFAULT NULL,
  `RETRYCOUNT` int(38) NOT NULL,
  `LOGTYPE` int(38) NOT NULL,
  `LOGIP` varchar(32) DEFAULT '',
  `SYSTEMNAME` varchar(255) DEFAULT '',
  `SYSTEMID` int(38) DEFAULT NULL,
  `USERNAME` varchar(255) DEFAULT '',
  PRIMARY KEY (`LOGINLOGID`)
) ENGINE=InnoDB AUTO_INCREMENT=37572 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of loginlog
-- ----------------------------
BEGIN;
INSERT INTO `loginlog` VALUES (37566, 1, 1, '2019-12-19 11:12:08', 1, 1, '0:0:0:0:0:0:0:1', NULL, NULL, '管理员');
INSERT INTO `loginlog` VALUES (37567, 1, 1, '2019-12-19 11:25:49', 1, 1, '0:0:0:0:0:0:0:1', NULL, NULL, '管理员');
INSERT INTO `loginlog` VALUES (37568, 1, 1, '2019-12-19 14:46:17', 1, 1, '0:0:0:0:0:0:0:1', NULL, NULL, '管理员');
INSERT INTO `loginlog` VALUES (37569, 1, 1, '2019-12-20 22:36:25', 1, 1, '0:0:0:0:0:0:0:1', NULL, NULL, '管理员');
INSERT INTO `loginlog` VALUES (37570, 1, 1, '2019-12-20 22:41:02', 1, 1, '0:0:0:0:0:0:0:1', NULL, NULL, '管理员');
INSERT INTO `loginlog` VALUES (37571, 1, 1, '2019-12-20 23:34:51', 1, 1, '0:0:0:0:0:0:0:1', NULL, NULL, '管理员');
COMMIT;

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `MENUID` int(38) NOT NULL AUTO_INCREMENT,
  `SYSTEMID` int(38) NOT NULL,
  `PARENTMENUID` int(38) DEFAULT NULL,
  `MENUNAME` varchar(255) DEFAULT NULL,
  `ORDERCODE` int(38) DEFAULT NULL,
  `ICONSTYLE` varchar(127) DEFAULT NULL,
  `NAMESPACE` varchar(127) DEFAULT NULL,
  `URLADDRESS` varchar(1024) DEFAULT NULL,
  `FORMADDRESS` varchar(127) DEFAULT NULL,
  `FLOWID` int(38) DEFAULT NULL,
  `MOBILEFLAG` int(38) DEFAULT NULL,
  PRIMARY KEY (`MENUID`),
  KEY `sysidwww` (`SYSTEMID`) USING BTREE,
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`SYSTEMID`) REFERENCES `system` (`SYSTEMID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu
-- ----------------------------
BEGIN;
INSERT INTO `menu` VALUES (1, 1, 0, '首页', 1, NULL, NULL, 'rest/rbac/homeController', NULL, NULL, 2);
INSERT INTO `menu` VALUES (2, 1, 0, '系统管理', 9, NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO `menu` VALUES (3, 1, 2, '菜单管理', 1, NULL, NULL, 'rest/rbac/menuController', NULL, NULL, 2);
INSERT INTO `menu` VALUES (4, 1, 2, '操作项管理', 2, NULL, NULL, 'rest/rbac/menuActionController', NULL, NULL, 2);
INSERT INTO `menu` VALUES (5, 1, 0, '商务智能', 5, NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO `menu` VALUES (6, 1, 5, '维度配置', 1, NULL, NULL, 'rest/bi/BIDimController', NULL, NULL, 2);
INSERT INTO `menu` VALUES (7, 1, 5, '主题配置', 2, NULL, NULL, 'rest/bi/BITopicController', NULL, NULL, 2);
INSERT INTO `menu` VALUES (8, 1, 5, '表单管理', 3, NULL, NULL, 'rest/bi/biPageController', NULL, NULL, 2);
INSERT INTO `menu` VALUES (9, 1, 5, '报表管理', 4, NULL, NULL, 'rest/bi/biReportController', NULL, NULL, 2);
INSERT INTO `menu` VALUES (10, 1, 5, '屏幕管理', 5, NULL, NULL, 'rest/bi/biScreenController', NULL, NULL, 2);
COMMIT;

-- ----------------------------
-- Table structure for mine_evaluation
-- ----------------------------
DROP TABLE IF EXISTS `mine_evaluation`;
CREATE TABLE `mine_evaluation` (
  `EVALUATION_ID` int(11) NOT NULL AUTO_INCREMENT,
  `MINE_NAME` varchar(255) DEFAULT NULL,
  `MINE_SURVEY_ID` int(11) DEFAULT NULL,
  `EVALUATION_USER` varchar(64) DEFAULT NULL,
  `EVALUATION_VALUE` double(11,7) DEFAULT NULL,
  `EVALUATION_RESULT` varchar(64) DEFAULT NULL,
  `EVALUATION_DATE` datetime DEFAULT NULL,
  `FLOW_ID` int(11) DEFAULT NULL,
  `EVALUATION_CURRENTVALUE` char(255) DEFAULT NULL,
  `DATA_SOURCE_DATE` int(11) DEFAULT NULL,
  `batch_ID` int(11) NOT NULL,
  PRIMARY KEY (`EVALUATION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for mine_evaluation_batch
-- ----------------------------
DROP TABLE IF EXISTS `mine_evaluation_batch`;
CREATE TABLE `mine_evaluation_batch` (
  `batch_ID` int(11) NOT NULL AUTO_INCREMENT,
  `EVALUATION_DATE` datetime DEFAULT NULL,
  `batch_name` varchar(128) DEFAULT NULL,
  `evaluation_user_id` int(11) DEFAULT NULL,
  `evaluation_user_name` char(10) DEFAULT NULL,
  `flow_ID` int(11) NOT NULL,
  `range_type` int(11) DEFAULT NULL,
  `range_num` int(11) DEFAULT NULL,
  `DATA_SOURCE_DATE` int(11) DEFAULT NULL,
  PRIMARY KEY (`batch_ID`),
  KEY `流程归属` (`flow_ID`),
  CONSTRAINT `流程归属` FOREIGN KEY (`flow_ID`) REFERENCES `ahp_flow` (`FLOW_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for operatelog
-- ----------------------------
DROP TABLE IF EXISTS `operatelog`;
CREATE TABLE `operatelog` (
  `OPERATEID` int(38) NOT NULL AUTO_INCREMENT,
  `SYSTEMID` int(38) DEFAULT NULL,
  `USERID` int(38) DEFAULT NULL,
  `PAGENAME` varchar(255) DEFAULT '',
  `LOGINFO` varchar(255) DEFAULT '',
  `LOGDATE` datetime DEFAULT NULL,
  `LOGLEVEL` int(38) DEFAULT NULL,
  `LOGSQL` varchar(255) DEFAULT '',
  `USERNAME` varchar(255) DEFAULT '',
  `SYSTEMNAME` varchar(255) DEFAULT '',
  PRIMARY KEY (`OPERATEID`),
  KEY `systemids` (`SYSTEMID`) USING BTREE,
  KEY `userinfo` (`USERID`) USING BTREE,
  CONSTRAINT `operatelog_ibfk_1` FOREIGN KEY (`USERID`) REFERENCES `userinfo` (`USERID`),
  CONSTRAINT `operatelog_ibfk_2` FOREIGN KEY (`SYSTEMID`) REFERENCES `system` (`SYSTEMID`)
) ENGINE=InnoDB AUTO_INCREMENT=336 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of operatelog
-- ----------------------------
BEGIN;
INSERT INTO `operatelog` VALUES (27, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2019-12-19 10:41:14', 1, '', '', '');
INSERT INTO `operatelog` VALUES (28, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2019-12-19 10:41:15', 1, '', '', '');
INSERT INTO `operatelog` VALUES (29, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-19 10:41:15', 1, '', '', '');
INSERT INTO `operatelog` VALUES (30, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2019-12-19 10:41:22', 1, '', '', '');
INSERT INTO `operatelog` VALUES (31, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2019-12-19 10:41:22', 1, '', '', '');
INSERT INTO `operatelog` VALUES (32, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-19 10:41:22', 1, '', '', '');
INSERT INTO `operatelog` VALUES (33, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2019-12-19 11:11:30', 1, '', '', '');
INSERT INTO `operatelog` VALUES (34, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2019-12-19 11:11:30', 1, '', '', '');
INSERT INTO `operatelog` VALUES (35, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-19 11:11:30', 1, '', '', '');
INSERT INTO `operatelog` VALUES (36, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2019-12-19 11:11:43', 1, '', '', '');
INSERT INTO `operatelog` VALUES (37, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2019-12-19 11:11:43', 1, '', '', '');
INSERT INTO `operatelog` VALUES (38, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-19 11:11:43', 1, '', '', '');
INSERT INTO `operatelog` VALUES (39, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2019-12-19 11:12:07', 1, '', '', '');
INSERT INTO `operatelog` VALUES (40, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2019-12-19 11:12:08', 1, '', '', '');
INSERT INTO `operatelog` VALUES (41, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-19 11:12:08', 1, '', '', '');
INSERT INTO `operatelog` VALUES (42, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@40c754fd ,', '2019-12-19 11:12:08', 1, '', '', '');
INSERT INTO `operatelog` VALUES (43, 1, 1, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-19 11:12:09', 1, '', '', '');
INSERT INTO `operatelog` VALUES (44, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2019-12-19 11:12:09', 1, '', '', '');
INSERT INTO `operatelog` VALUES (45, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2019-12-19 11:12:19', 1, '', '', '');
INSERT INTO `operatelog` VALUES (46, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2019-12-19 11:12:20', 1, '', '', '');
INSERT INTO `operatelog` VALUES (47, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@1f993924 ,', '2019-12-19 11:12:20', 1, '', '', '');
INSERT INTO `operatelog` VALUES (48, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2019-12-19 11:12:20', 1, '', '', '');
INSERT INTO `operatelog` VALUES (49, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2019-12-19 11:12:20', 1, '', '', '');
INSERT INTO `operatelog` VALUES (50, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2019-12-19 11:12:20', 1, '', '', '');
INSERT INTO `operatelog` VALUES (51, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2019-12-19 11:12:20', 1, '', '', '');
INSERT INTO `operatelog` VALUES (52, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 1 ,', '2019-12-19 11:12:22', 1, '', '', '');
INSERT INTO `operatelog` VALUES (53, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,2 ,true ,', '2019-12-19 11:12:23', 1, '', '', '');
INSERT INTO `operatelog` VALUES (54, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 2 ,', '2019-12-19 11:12:23', 1, '', '', '');
INSERT INTO `operatelog` VALUES (55, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 3 ,', '2019-12-19 11:12:23', 1, '', '', '');
INSERT INTO `operatelog` VALUES (56, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 3 ,', '2019-12-19 11:12:23', 1, '', '', '');
INSERT INTO `operatelog` VALUES (57, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 1 ,', '2019-12-19 11:12:24', 1, '', '', '');
INSERT INTO `operatelog` VALUES (58, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 3 ,', '2019-12-19 11:13:49', 1, '', '', '');
INSERT INTO `operatelog` VALUES (59, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 2 ,', '2019-12-19 11:13:51', 1, '', '', '');
INSERT INTO `operatelog` VALUES (60, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 1 ,', '2019-12-19 11:13:53', 1, '', '', '');
INSERT INTO `operatelog` VALUES (61, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 2 ,', '2019-12-19 11:13:53', 1, '', '', '');
INSERT INTO `operatelog` VALUES (63, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2019-12-19 11:25:48', 1, '', '', '');
INSERT INTO `operatelog` VALUES (64, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2019-12-19 11:25:49', 1, '', '', '');
INSERT INTO `operatelog` VALUES (65, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-19 11:25:49', 1, '', '', '');
INSERT INTO `operatelog` VALUES (66, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@3d968f ,', '2019-12-19 11:25:49', 1, '', '', '');
INSERT INTO `operatelog` VALUES (67, 1, 1, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-19 11:25:49', 1, '', '', '');
INSERT INTO `operatelog` VALUES (68, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2019-12-19 11:25:49', 1, '', '', '');
INSERT INTO `operatelog` VALUES (69, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2019-12-19 11:25:56', 1, '', '', '');
INSERT INTO `operatelog` VALUES (70, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2019-12-19 11:25:57', 1, '', '', '');
INSERT INTO `operatelog` VALUES (71, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2019-12-19 11:25:59', 1, '', '', '');
INSERT INTO `operatelog` VALUES (72, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@de3f956 ,', '2019-12-19 11:25:59', 1, '', '', '');
INSERT INTO `operatelog` VALUES (73, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2019-12-19 11:25:59', 1, '', '', '');
INSERT INTO `operatelog` VALUES (74, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2019-12-19 11:25:59', 1, '', '', '');
INSERT INTO `operatelog` VALUES (75, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2019-12-19 11:25:59', 1, '', '', '');
INSERT INTO `operatelog` VALUES (76, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2019-12-19 11:25:59', 1, '', '', '');
INSERT INTO `operatelog` VALUES (77, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,2 ,true ,', '2019-12-19 11:26:00', 1, '', '', '');
INSERT INTO `operatelog` VALUES (78, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 2 ,', '2019-12-19 11:26:00', 1, '', '', '');
INSERT INTO `operatelog` VALUES (79, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 3 ,', '2019-12-19 11:26:00', 1, '', '', '');
INSERT INTO `operatelog` VALUES (80, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 3 ,', '2019-12-19 11:26:01', 1, '', '', '');
INSERT INTO `operatelog` VALUES (81, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 1 ,', '2019-12-19 11:26:03', 1, '', '', '');
INSERT INTO `operatelog` VALUES (82, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 2 ,', '2019-12-19 11:26:04', 1, '', '', '');
INSERT INTO `operatelog` VALUES (83, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 2 ,', '2019-12-19 11:26:06', 1, '', '', '');
INSERT INTO `operatelog` VALUES (87, 1, 1, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-19 11:29:07', 1, '', '', '');
INSERT INTO `operatelog` VALUES (88, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2019-12-19 11:29:07', 1, '', '', '');
INSERT INTO `operatelog` VALUES (89, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2019-12-19 11:29:09', 1, '', '', '');
INSERT INTO `operatelog` VALUES (90, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2019-12-19 11:29:10', 1, '', '', '');
INSERT INTO `operatelog` VALUES (91, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@2ee10d2c ,', '2019-12-19 11:29:10', 1, '', '', '');
INSERT INTO `operatelog` VALUES (92, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2019-12-19 11:29:10', 1, '', '', '');
INSERT INTO `operatelog` VALUES (93, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2019-12-19 11:29:10', 1, '', '', '');
INSERT INTO `operatelog` VALUES (94, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2019-12-19 11:29:10', 1, '', '', '');
INSERT INTO `operatelog` VALUES (95, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2019-12-19 11:29:10', 1, '', '', '');
INSERT INTO `operatelog` VALUES (96, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2019-12-19 11:29:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (97, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@3bd84c31 ,1 ,10 ,', '2019-12-19 11:29:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (98, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2019-12-19 11:29:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (99, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2019-12-19 11:29:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (100, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@5b6e805a ,1 ,10 ,', '2019-12-19 11:29:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (101, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2019-12-19 11:29:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (103, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,2 ,true ,', '2019-12-19 11:29:29', 1, '', '', '');
INSERT INTO `operatelog` VALUES (104, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@4c32f20c ,1 ,10 ,', '2019-12-19 11:29:29', 1, '', '', '');
INSERT INTO `operatelog` VALUES (105, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 3 ,', '2019-12-19 11:29:29', 1, '', '', '');
INSERT INTO `operatelog` VALUES (106, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 4 ,', '2019-12-19 11:29:29', 1, '', '', '');
INSERT INTO `operatelog` VALUES (108, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,2 ,true ,', '2019-12-19 11:29:34', 1, '', '', '');
INSERT INTO `operatelog` VALUES (109, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 2 ,', '2019-12-19 11:29:34', 1, '', '', '');
INSERT INTO `operatelog` VALUES (110, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 3 ,', '2019-12-19 11:29:34', 1, '', '', '');
INSERT INTO `operatelog` VALUES (111, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 4 ,', '2019-12-19 11:29:34', 1, '', '', '');
INSERT INTO `operatelog` VALUES (113, 1, 1, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-19 11:30:00', 1, '', '', '');
INSERT INTO `operatelog` VALUES (114, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2019-12-19 11:30:00', 1, '', '', '');
INSERT INTO `operatelog` VALUES (115, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2019-12-19 11:30:01', 1, '', '', '');
INSERT INTO `operatelog` VALUES (116, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2019-12-19 11:30:03', 1, '', '', '');
INSERT INTO `operatelog` VALUES (117, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@6a8c4062 ,', '2019-12-19 11:30:03', 1, '', '', '');
INSERT INTO `operatelog` VALUES (118, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2019-12-19 11:30:03', 1, '', '', '');
INSERT INTO `operatelog` VALUES (119, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2019-12-19 11:30:03', 1, '', '', '');
INSERT INTO `operatelog` VALUES (120, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2019-12-19 11:30:03', 1, '', '', '');
INSERT INTO `operatelog` VALUES (121, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2019-12-19 11:30:03', 1, '', '', '');
INSERT INTO `operatelog` VALUES (122, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2019-12-19 11:30:04', 1, '', '', '');
INSERT INTO `operatelog` VALUES (123, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@28bd71fb ,1 ,10 ,', '2019-12-19 11:30:04', 1, '', '', '');
INSERT INTO `operatelog` VALUES (124, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2019-12-19 11:30:04', 1, '', '', '');
INSERT INTO `operatelog` VALUES (125, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@c90761c ,1 ,10 ,', '2019-12-19 11:30:04', 1, '', '', '');
INSERT INTO `operatelog` VALUES (126, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2019-12-19 11:30:04', 1, '', '', '');
INSERT INTO `operatelog` VALUES (127, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2019-12-19 11:30:04', 1, '', '', '');
INSERT INTO `operatelog` VALUES (128, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2019-12-19 14:46:16', 1, '', '', '');
INSERT INTO `operatelog` VALUES (129, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2019-12-19 14:46:16', 1, '', '', '');
INSERT INTO `operatelog` VALUES (130, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-19 14:46:16', 1, '', '', '');
INSERT INTO `operatelog` VALUES (131, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@50ee89ed ,', '2019-12-19 14:46:16', 1, '', '', '');
INSERT INTO `operatelog` VALUES (132, 1, 1, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-19 14:46:16', 1, '', '', '');
INSERT INTO `operatelog` VALUES (133, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2019-12-19 14:46:16', 1, '', '', '');
INSERT INTO `operatelog` VALUES (134, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2019-12-19 14:46:18', 1, '', '', '');
INSERT INTO `operatelog` VALUES (135, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@1a89663d ,1 ,10 ,', '2019-12-19 14:46:20', 1, '', '', '');
INSERT INTO `operatelog` VALUES (136, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1156 ,', '2019-12-19 14:46:22', 1, '', '', '');
INSERT INTO `operatelog` VALUES (137, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@305c803b ,', '2019-12-19 14:46:22', 1, '', '', '');
INSERT INTO `operatelog` VALUES (138, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIPageServiceImpl.getBIPageListPage(BI_Page,int,int); 操作参数: cn.zup.bi.entity.BI_Page@1a020c9b ,1 ,10 ,', '2019-12-19 14:46:22', 1, '', '', '');
INSERT INTO `operatelog` VALUES (139, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@7188f713 ,', '2019-12-19 14:46:22', 1, '', '', '');
INSERT INTO `operatelog` VALUES (140, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@53b13e35 ,1 ,9999 ,', '2019-12-19 14:46:22', 1, '', '', '');
INSERT INTO `operatelog` VALUES (141, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@4a9f4193 ,', '2019-12-19 14:46:23', 1, '', '', '');
INSERT INTO `operatelog` VALUES (142, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT@7927c677 ,1 ,10 ,', '2019-12-19 14:46:23', 1, '', '', '');
INSERT INTO `operatelog` VALUES (144, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2019-12-20 22:36:25', 1, '', '', '');
INSERT INTO `operatelog` VALUES (145, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2019-12-20 22:36:25', 1, '', '', '');
INSERT INTO `operatelog` VALUES (146, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-20 22:36:25', 1, '', '', '');
INSERT INTO `operatelog` VALUES (147, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@48ca9a92 ,', '2019-12-20 22:36:25', 1, '', '', '');
INSERT INTO `operatelog` VALUES (148, 1, 1, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-20 22:36:25', 1, '', '', '');
INSERT INTO `operatelog` VALUES (149, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2019-12-20 22:36:25', 1, '', '', '');
INSERT INTO `operatelog` VALUES (150, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2019-12-20 22:36:28', 1, '', '', '');
INSERT INTO `operatelog` VALUES (152, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getTableNameList(Connection); 操作参数: com.mysql.jdbc.JDBC4Connection@75d28270 ,', '2019-12-20 22:38:18', 1, '', '', '');
INSERT INTO `operatelog` VALUES (153, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@3e5c71e6 ,pms_product ,', '2019-12-20 22:38:26', 1, '', '', '');
INSERT INTO `operatelog` VALUES (154, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: BI_DIM cn.zup.bi.service.impl.BIDimServiceImpl.getDimInfo(String); 操作参数: pms_product ,', '2019-12-20 22:38:26', 1, '', '', '');
INSERT INTO `operatelog` VALUES (155, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@3e5c71e6 ,pms_product ,', '2019-12-20 22:38:26', 1, '', '', '');
INSERT INTO `operatelog` VALUES (156, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: BI_DIM cn.zup.bi.service.impl.BIDimServiceImpl.getDimInfo(String); 操作参数: pms_product ,', '2019-12-20 22:38:27', 1, '', '', '');
INSERT INTO `operatelog` VALUES (157, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.BIDimServiceImpl.saveDimData(BI_DIM); 操作参数: cn.zup.bi.entity.BI_DIM@13cc78f1 ,', '2019-12-20 22:40:18', 1, '', '', '');
INSERT INTO `operatelog` VALUES (158, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@673f6bbb ,1 ,10 ,', '2019-12-20 22:40:23', 1, '', '', '');
INSERT INTO `operatelog` VALUES (159, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getTableNameList(Connection); 操作参数: com.mysql.jdbc.JDBC4Connection@1e1005b8 ,', '2019-12-20 22:40:24', 1, '', '', '');
INSERT INTO `operatelog` VALUES (160, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2019-12-20 22:41:01', 1, '', '', '');
INSERT INTO `operatelog` VALUES (161, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2019-12-20 22:41:01', 1, '', '', '');
INSERT INTO `operatelog` VALUES (162, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-20 22:41:01', 1, '', '', '');
INSERT INTO `operatelog` VALUES (163, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@789f87e ,', '2019-12-20 22:41:01', 1, '', '', '');
INSERT INTO `operatelog` VALUES (164, 1, 1, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-20 22:41:01', 1, '', '', '');
INSERT INTO `operatelog` VALUES (165, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2019-12-20 22:41:01', 1, '', '', '');
INSERT INTO `operatelog` VALUES (166, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2019-12-20 22:41:03', 1, '', '', '');
INSERT INTO `operatelog` VALUES (167, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getTableNameList(Connection); 操作参数: com.mysql.jdbc.JDBC4Connection@52ffe2bb ,', '2019-12-20 22:41:04', 1, '', '', '');
INSERT INTO `operatelog` VALUES (168, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getTableNameList(Connection); 操作参数: com.mysql.jdbc.JDBC4Connection@12515c44 ,', '2019-12-20 22:52:59', 1, '', '', '');
INSERT INTO `operatelog` VALUES (169, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@2a501d1c ,pms_product_catego1ry ,', '2019-12-20 22:53:07', 1, '', '', '');
INSERT INTO `operatelog` VALUES (170, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: BI_DIM cn.zup.bi.service.impl.BIDimServiceImpl.getDimInfo(String); 操作参数: pms_product_catego1ry ,', '2019-12-20 22:53:07', 1, '', '', '');
INSERT INTO `operatelog` VALUES (171, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@2a501d1c ,pms_product_catego1ry ,', '2019-12-20 22:53:07', 1, '', '', '');
INSERT INTO `operatelog` VALUES (172, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: BI_DIM cn.zup.bi.service.impl.BIDimServiceImpl.getDimInfo(String); 操作参数: pms_product_catego1ry ,', '2019-12-20 22:53:07', 1, '', '', '');
INSERT INTO `operatelog` VALUES (178, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.BIDimServiceImpl.saveDimData(BI_DIM); 操作参数: cn.zup.bi.entity.BI_DIM@2b7a422 ,', '2019-12-20 23:03:12', 1, '', '', '');
INSERT INTO `operatelog` VALUES (179, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getTableNameList(Connection); 操作参数: com.mysql.jdbc.JDBC4Connection@ab06c5c ,', '2019-12-20 23:03:19', 1, '', '', '');
INSERT INTO `operatelog` VALUES (180, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: BI_DIM cn.zup.bi.service.impl.BIDimServiceImpl.getDimInfo(String); 操作参数: pms_comment_replay ,', '2019-12-20 23:03:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (181, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@1773b2f6 ,pms_comment_replay ,', '2019-12-20 23:03:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (182, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@1773b2f6 ,pms_comment_replay ,', '2019-12-20 23:03:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (183, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: BI_DIM cn.zup.bi.service.impl.BIDimServiceImpl.getDimInfo(String); 操作参数: pms_comment_replay ,', '2019-12-20 23:03:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (184, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getTableNameList(Connection); 操作参数: com.mysql.jdbc.JDBC4Connection@4723f19c ,', '2019-12-20 23:03:55', 1, '', '', '');
INSERT INTO `operatelog` VALUES (185, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: BI_DIM cn.zup.bi.service.impl.BIDimServiceImpl.getDimInfo(String); 操作参数: pms_bra1nd ,', '2019-12-20 23:04:00', 1, '', '', '');
INSERT INTO `operatelog` VALUES (186, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@5c00a82a ,pms_bra1nd ,', '2019-12-20 23:04:00', 1, '', '', '');
INSERT INTO `operatelog` VALUES (187, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@5c00a82a ,pms_bra1nd ,', '2019-12-20 23:04:00', 1, '', '', '');
INSERT INTO `operatelog` VALUES (188, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: BI_DIM cn.zup.bi.service.impl.BIDimServiceImpl.getDimInfo(String); 操作参数: pms_bra1nd ,', '2019-12-20 23:04:00', 1, '', '', '');
INSERT INTO `operatelog` VALUES (189, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.BIDimServiceImpl.saveDimData(BI_DIM); 操作参数: cn.zup.bi.entity.BI_DIM@6c06c8c7 ,', '2019-12-20 23:04:19', 1, '', '', '');
INSERT INTO `operatelog` VALUES (190, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@3f18766d ,1 ,10 ,', '2019-12-20 23:04:25', 1, '', '', '');
INSERT INTO `operatelog` VALUES (191, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getTableNameList(Connection); 操作参数: com.mysql.jdbc.JDBC4Connection@472bed33 ,', '2019-12-20 23:04:26', 1, '', '', '');
INSERT INTO `operatelog` VALUES (192, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.TopicServiceImpl.addTopicData(BI_TOPIC); 操作参数: cn.zup.bi.entity.BI_TOPIC@7945adc3 ,', '2019-12-20 23:04:59', 1, '', '', '');
INSERT INTO `operatelog` VALUES (193, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@516f3250 ,1 ,10 ,', '2019-12-20 23:04:59', 1, '', '', '');
INSERT INTO `operatelog` VALUES (194, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getBiDimName(); 操作参数: ', '2019-12-20 23:05:03', 1, '', '', '');
INSERT INTO `operatelog` VALUES (195, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@6727f535 ,', '2019-12-20 23:05:03', 1, '', '', '');
INSERT INTO `operatelog` VALUES (196, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@5588229b ,', '2019-12-20 23:05:03', 1, '', '', '');
INSERT INTO `operatelog` VALUES (197, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@3761f044 ,', '2019-12-20 23:05:03', 1, '', '', '');
INSERT INTO `operatelog` VALUES (198, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldPagingList(BI_TOPIC_FIELD,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC_FIELD@7ca7b58e ,1 ,10 ,', '2019-12-20 23:05:03', 1, '', '', '');
INSERT INTO `operatelog` VALUES (199, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@1e1c51dc ,pms_product ,', '2019-12-20 23:05:06', 1, '', '', '');
INSERT INTO `operatelog` VALUES (200, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@1e1c51dc ,pms_product ,', '2019-12-20 23:05:06', 1, '', '', '');
INSERT INTO `operatelog` VALUES (201, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@767e89a6 ,pms_product ,', '2019-12-20 23:11:08', 1, '', '', '');
INSERT INTO `operatelog` VALUES (202, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@767e89a6 ,pms_product ,', '2019-12-20 23:11:08', 1, '', '', '');
INSERT INTO `operatelog` VALUES (203, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getBiDimName(); 操作参数: ', '2019-12-20 23:20:31', 1, '', '', '');
INSERT INTO `operatelog` VALUES (204, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@4b4c6ad9 ,', '2019-12-20 23:20:31', 1, '', '', '');
INSERT INTO `operatelog` VALUES (205, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldPagingList(BI_TOPIC_FIELD,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC_FIELD@84029f9 ,1 ,10 ,', '2019-12-20 23:20:31', 1, '', '', '');
INSERT INTO `operatelog` VALUES (206, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@25debe3b ,', '2019-12-20 23:20:31', 1, '', '', '');
INSERT INTO `operatelog` VALUES (207, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@7b40dbe2 ,', '2019-12-20 23:20:31', 1, '', '', '');
INSERT INTO `operatelog` VALUES (208, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@11002ac5 ,pms_product ,', '2019-12-20 23:20:33', 1, '', '', '');
INSERT INTO `operatelog` VALUES (209, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@11002ac5 ,pms_product ,', '2019-12-20 23:20:33', 1, '', '', '');
INSERT INTO `operatelog` VALUES (210, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.TopicFieldServiceImpl.addTopicData(BI_TOPIC_FIELD); 操作参数: cn.zup.bi.entity.BI_TOPIC_FIELD@2422a6e9 ,', '2019-12-20 23:23:57', 1, '', '', '');
INSERT INTO `operatelog` VALUES (211, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldPagingList(BI_TOPIC_FIELD,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC_FIELD@43a0f58d ,1 ,10 ,', '2019-12-20 23:23:57', 1, '', '', '');
INSERT INTO `operatelog` VALUES (212, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@706980d0 ,pms_product ,', '2019-12-20 23:24:01', 1, '', '', '');
INSERT INTO `operatelog` VALUES (213, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@706980d0 ,pms_product ,', '2019-12-20 23:24:01', 1, '', '', '');
INSERT INTO `operatelog` VALUES (214, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.TopicFieldServiceImpl.addTopicData(BI_TOPIC_FIELD); 操作参数: cn.zup.bi.entity.BI_TOPIC_FIELD@64c11f16 ,', '2019-12-20 23:24:35', 1, '', '', '');
INSERT INTO `operatelog` VALUES (215, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldPagingList(BI_TOPIC_FIELD,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC_FIELD@6f33d3b8 ,1 ,10 ,', '2019-12-20 23:24:35', 1, '', '', '');
INSERT INTO `operatelog` VALUES (216, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@4f8730d7 ,pms_product ,', '2019-12-20 23:24:38', 1, '', '', '');
INSERT INTO `operatelog` VALUES (217, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@4f8730d7 ,pms_product ,', '2019-12-20 23:24:38', 1, '', '', '');
INSERT INTO `operatelog` VALUES (218, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.TopicFieldServiceImpl.addTopicData(BI_TOPIC_FIELD); 操作参数: cn.zup.bi.entity.BI_TOPIC_FIELD@5d0d92a2 ,', '2019-12-20 23:24:56', 1, '', '', '');
INSERT INTO `operatelog` VALUES (219, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldPagingList(BI_TOPIC_FIELD,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC_FIELD@41147152 ,1 ,10 ,', '2019-12-20 23:24:56', 1, '', '', '');
INSERT INTO `operatelog` VALUES (220, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC_FIELD cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldData(Integer,Integer); 操作参数: 45 ,216 ,', '2019-12-20 23:24:59', 1, '', '', '');
INSERT INTO `operatelog` VALUES (221, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@62f05361 ,pms_product ,', '2019-12-20 23:24:59', 1, '', '', '');
INSERT INTO `operatelog` VALUES (222, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@62f05361 ,pms_product ,', '2019-12-20 23:24:59', 1, '', '', '');
INSERT INTO `operatelog` VALUES (223, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.TopicFieldServiceImpl.updateTopicData(BI_TOPIC_FIELD); 操作参数: cn.zup.bi.entity.BI_TOPIC_FIELD@19cb7a1d ,', '2019-12-20 23:25:02', 1, '', '', '');
INSERT INTO `operatelog` VALUES (224, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldPagingList(BI_TOPIC_FIELD,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC_FIELD@495c9ea3 ,1 ,10 ,', '2019-12-20 23:25:02', 1, '', '', '');
INSERT INTO `operatelog` VALUES (225, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@52eb61d4 ,pms_product ,', '2019-12-20 23:25:05', 1, '', '', '');
INSERT INTO `operatelog` VALUES (226, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@52eb61d4 ,pms_product ,', '2019-12-20 23:25:05', 1, '', '', '');
INSERT INTO `operatelog` VALUES (227, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.TopicFieldServiceImpl.addTopicData(BI_TOPIC_FIELD); 操作参数: cn.zup.bi.entity.BI_TOPIC_FIELD@65f3a4ee ,', '2019-12-20 23:25:19', 1, '', '', '');
INSERT INTO `operatelog` VALUES (228, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldPagingList(BI_TOPIC_FIELD,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC_FIELD@4bea9527 ,1 ,10 ,', '2019-12-20 23:25:19', 1, '', '', '');
INSERT INTO `operatelog` VALUES (229, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@241f1010 ,pms_product ,', '2019-12-20 23:25:22', 1, '', '', '');
INSERT INTO `operatelog` VALUES (230, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@241f1010 ,pms_product ,', '2019-12-20 23:25:22', 1, '', '', '');
INSERT INTO `operatelog` VALUES (231, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.TopicFieldServiceImpl.addTopicData(BI_TOPIC_FIELD); 操作参数: cn.zup.bi.entity.BI_TOPIC_FIELD@4aa56fc6 ,', '2019-12-20 23:26:25', 1, '', '', '');
INSERT INTO `operatelog` VALUES (232, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldPagingList(BI_TOPIC_FIELD,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC_FIELD@5cc556be ,1 ,10 ,', '2019-12-20 23:26:25', 1, '', '', '');
INSERT INTO `operatelog` VALUES (233, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldPagingList(BI_TOPIC_FIELD,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC_FIELD@174af06a ,1 ,10 ,', '2019-12-20 23:26:39', 1, '', '', '');
INSERT INTO `operatelog` VALUES (234, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getBiDimName(); 操作参数: ', '2019-12-20 23:26:39', 1, '', '', '');
INSERT INTO `operatelog` VALUES (235, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@295804fc ,', '2019-12-20 23:26:39', 1, '', '', '');
INSERT INTO `operatelog` VALUES (236, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@70d218b6 ,', '2019-12-20 23:26:39', 1, '', '', '');
INSERT INTO `operatelog` VALUES (237, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@3d385048 ,', '2019-12-20 23:26:39', 1, '', '', '');
INSERT INTO `operatelog` VALUES (238, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@2ddc43d1 ,pms_product ,', '2019-12-20 23:26:41', 1, '', '', '');
INSERT INTO `operatelog` VALUES (239, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@2ddc43d1 ,pms_product ,', '2019-12-20 23:26:41', 1, '', '', '');
INSERT INTO `operatelog` VALUES (240, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@6779bcf2 ,', '2019-12-20 23:27:01', 1, '', '', '');
INSERT INTO `operatelog` VALUES (241, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@6b43f8e0 ,', '2019-12-20 23:27:01', 1, '', '', '');
INSERT INTO `operatelog` VALUES (242, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIPageServiceImpl.getBIPageListPage(BI_Page,int,int); 操作参数: cn.zup.bi.entity.BI_Page@50aed75b ,1 ,10 ,', '2019-12-20 23:27:01', 1, '', '', '');
INSERT INTO `operatelog` VALUES (243, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1156 ,', '2019-12-20 23:27:01', 1, '', '', '');
INSERT INTO `operatelog` VALUES (244, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIPageServiceImpl.getBIPageListPage(BI_Page,int,int); 操作参数: cn.zup.bi.entity.BI_Page@6578e3a9 ,1 ,10 ,', '2019-12-20 23:29:28', 1, '', '', '');
INSERT INTO `operatelog` VALUES (245, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@12f3887a ,', '2019-12-20 23:29:28', 1, '', '', '');
INSERT INTO `operatelog` VALUES (246, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1156 ,', '2019-12-20 23:29:28', 1, '', '', '');
INSERT INTO `operatelog` VALUES (247, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@59cced50 ,', '2019-12-20 23:29:28', 1, '', '', '');
INSERT INTO `operatelog` VALUES (248, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1156 ,', '2019-12-20 23:31:17', 1, '', '', '');
INSERT INTO `operatelog` VALUES (249, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@ef41bc ,', '2019-12-20 23:31:17', 1, '', '', '');
INSERT INTO `operatelog` VALUES (250, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@51055ca3 ,', '2019-12-20 23:31:17', 1, '', '', '');
INSERT INTO `operatelog` VALUES (251, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIPageServiceImpl.getBIPageListPage(BI_Page,int,int); 操作参数: cn.zup.bi.entity.BI_Page@5b9aa94a ,1 ,10 ,', '2019-12-20 23:31:17', 1, '', '', '');
INSERT INTO `operatelog` VALUES (252, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.BIPageServiceImpl.updatePageInfo(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@5115614e ,', '2019-12-20 23:31:34', 1, '', '', '');
INSERT INTO `operatelog` VALUES (253, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIPageServiceImpl.getBIPageListPage(BI_Page,int,int); 操作参数: cn.zup.bi.entity.BI_Page@33adcb58 ,1 ,10 ,', '2019-12-20 23:31:34', 1, '', '', '');
INSERT INTO `operatelog` VALUES (254, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@22b6b10d ,', '2019-12-20 23:31:37', 1, '', '', '');
INSERT INTO `operatelog` VALUES (255, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@3a79d6c4 ,', '2019-12-20 23:31:37', 1, '', '', '');
INSERT INTO `operatelog` VALUES (256, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 0 ,0 ,null ,', '2019-12-20 23:31:39', 1, '', '', '');
INSERT INTO `operatelog` VALUES (257, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,0 ,', '2019-12-20 23:31:39', 1, '', '', '');
INSERT INTO `operatelog` VALUES (258, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT@5cda09 ,1 ,10 ,', '2019-12-20 23:31:44', 1, '', '', '');
INSERT INTO `operatelog` VALUES (259, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@2f12726b ,1 ,9999 ,', '2019-12-20 23:31:44', 1, '', '', '');
INSERT INTO `operatelog` VALUES (260, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@74527873 ,', '2019-12-20 23:31:44', 1, '', '', '');
INSERT INTO `operatelog` VALUES (261, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.ReportServiceImpl.saveReport(BI_REPORT); 操作参数: cn.zup.bi.entity.BI_REPORT@4df656cc ,', '2019-12-20 23:32:20', 1, '', '', '');
INSERT INTO `operatelog` VALUES (262, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT@136230c8 ,1 ,10 ,', '2019-12-20 23:32:20', 1, '', '', '');
INSERT INTO `operatelog` VALUES (263, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2019-12-20 23:32:24', 1, '', '', '');
INSERT INTO `operatelog` VALUES (264, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFields(Integer); 操作参数: 45 ,', '2019-12-20 23:32:24', 1, '', '', '');
INSERT INTO `operatelog` VALUES (265, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportFieldServiceImpl.getReportFieldList(BI_REPORT_FIELD,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT_FIELD@1beb2412 ,10 ,1 ,', '2019-12-20 23:32:24', 1, '', '', '');
INSERT INTO `operatelog` VALUES (266, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.ReportFieldServiceImpl.saveReportField(BI_REPORT_FIELD); 操作参数: cn.zup.bi.entity.BI_REPORT_FIELD@745c314a ,', '2019-12-20 23:32:31', 1, '', '', '');
INSERT INTO `operatelog` VALUES (267, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportFieldServiceImpl.getReportFieldList(BI_REPORT_FIELD,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT_FIELD@43eaf0f1 ,10 ,1 ,', '2019-12-20 23:32:31', 1, '', '', '');
INSERT INTO `operatelog` VALUES (268, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.ReportFieldServiceImpl.saveReportField(BI_REPORT_FIELD); 操作参数: cn.zup.bi.entity.BI_REPORT_FIELD@37fe12e ,', '2019-12-20 23:32:40', 1, '', '', '');
INSERT INTO `operatelog` VALUES (269, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportFieldServiceImpl.getReportFieldList(BI_REPORT_FIELD,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT_FIELD@5efc24fe ,10 ,1 ,', '2019-12-20 23:32:40', 1, '', '', '');
INSERT INTO `operatelog` VALUES (270, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.ReportFieldServiceImpl.saveReportField(BI_REPORT_FIELD); 操作参数: cn.zup.bi.entity.BI_REPORT_FIELD@47ce920f ,', '2019-12-20 23:32:50', 1, '', '', '');
INSERT INTO `operatelog` VALUES (271, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportFieldServiceImpl.getReportFieldList(BI_REPORT_FIELD,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT_FIELD@363e8fb0 ,10 ,1 ,', '2019-12-20 23:32:50', 1, '', '', '');
INSERT INTO `operatelog` VALUES (272, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@561ef277 ,', '2019-12-20 23:33:00', 1, '', '', '');
INSERT INTO `operatelog` VALUES (273, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@5153b241 ,', '2019-12-20 23:33:00', 1, '', '', '');
INSERT INTO `operatelog` VALUES (274, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 0 ,0 ,null ,', '2019-12-20 23:33:01', 1, '', '', '');
INSERT INTO `operatelog` VALUES (275, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,0 ,', '2019-12-20 23:33:01', 1, '', '', '');
INSERT INTO `operatelog` VALUES (276, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@1c426611 ,', '2019-12-20 23:33:18', 1, '', '', '');
INSERT INTO `operatelog` VALUES (277, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@7c88233e ,', '2019-12-20 23:33:18', 1, '', '', '');
INSERT INTO `operatelog` VALUES (278, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 0 ,0 ,null ,', '2019-12-20 23:33:19', 1, '', '', '');
INSERT INTO `operatelog` VALUES (279, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,0 ,', '2019-12-20 23:33:19', 1, '', '', '');
INSERT INTO `operatelog` VALUES (280, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@6340754f ,', '2019-12-20 23:33:35', 1, '', '', '');
INSERT INTO `operatelog` VALUES (281, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@4932578c ,', '2019-12-20 23:33:35', 1, '', '', '');
INSERT INTO `operatelog` VALUES (282, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 0 ,0 ,null ,', '2019-12-20 23:33:36', 1, '', '', '');
INSERT INTO `operatelog` VALUES (283, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,0 ,', '2019-12-20 23:33:36', 1, '', '', '');
INSERT INTO `operatelog` VALUES (284, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2019-12-20 23:34:51', 1, '', '', '');
INSERT INTO `operatelog` VALUES (285, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2019-12-20 23:34:51', 1, '', '', '');
INSERT INTO `operatelog` VALUES (286, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-20 23:34:51', 1, '', '', '');
INSERT INTO `operatelog` VALUES (287, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@7ee06f15 ,', '2019-12-20 23:34:51', 1, '', '', '');
INSERT INTO `operatelog` VALUES (288, 1, 1, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-20 23:34:51', 1, '', '', '');
INSERT INTO `operatelog` VALUES (289, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2019-12-20 23:34:51', 1, '', '', '');
INSERT INTO `operatelog` VALUES (290, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2019-12-20 23:36:21', 1, '', '', '');
INSERT INTO `operatelog` VALUES (291, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@2c10a179 ,', '2019-12-20 23:36:22', 1, '', '', '');
INSERT INTO `operatelog` VALUES (292, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@163d06ad ,1 ,9999 ,', '2019-12-20 23:36:22', 1, '', '', '');
INSERT INTO `operatelog` VALUES (293, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT@1aa99b62 ,1 ,10 ,', '2019-12-20 23:36:22', 1, '', '', '');
INSERT INTO `operatelog` VALUES (294, 1, 1, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-20 23:36:42', 1, '', '', '');
INSERT INTO `operatelog` VALUES (295, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2019-12-20 23:36:42', 1, '', '', '');
INSERT INTO `operatelog` VALUES (296, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2019-12-20 23:36:43', 1, '', '', '');
INSERT INTO `operatelog` VALUES (297, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@35e28f9a ,', '2019-12-20 23:36:46', 1, '', '', '');
INSERT INTO `operatelog` VALUES (298, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIScreenServiceImpl.getBIScreenListPage(BI_Screen,int,int); 操作参数: cn.zup.bi.entity.BI_Screen@36dc74a0 ,1 ,10 ,', '2019-12-20 23:36:46', 1, '', '', '');
INSERT INTO `operatelog` VALUES (300, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.BIScreenServiceImpl.updateScreenInfo(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@31e5a3dc ,', '2019-12-20 23:36:54', 1, '', '', '');
INSERT INTO `operatelog` VALUES (301, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIScreenServiceImpl.getBIScreenListPage(BI_Screen,int,int); 操作参数: cn.zup.bi.entity.BI_Screen@61eda26c ,1 ,10 ,', '2019-12-20 23:36:54', 1, '', '', '');
INSERT INTO `operatelog` VALUES (303, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@440b1e32 ,', '2019-12-20 23:36:57', 1, '', '', '');
INSERT INTO `operatelog` VALUES (304, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@6f9f2c3a ,1 ,9999 ,', '2019-12-20 23:36:57', 1, '', '', '');
INSERT INTO `operatelog` VALUES (305, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT@257fe8e9 ,1 ,10 ,', '2019-12-20 23:36:57', 1, '', '', '');
INSERT INTO `operatelog` VALUES (306, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@24d189b0 ,', '2019-12-20 23:37:02', 1, '', '', '');
INSERT INTO `operatelog` VALUES (307, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@410cc9a0 ,', '2019-12-20 23:37:02', 1, '', '', '');
INSERT INTO `operatelog` VALUES (308, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2019-12-20 23:37:02', 1, '', '', '');
INSERT INTO `operatelog` VALUES (309, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,1 ,', '2019-12-20 23:37:02', 1, '', '', '');
INSERT INTO `operatelog` VALUES (310, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2019-12-20 23:37:04', 1, '', '', '');
INSERT INTO `operatelog` VALUES (311, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,1 ,', '2019-12-20 23:37:04', 1, '', '', '');
INSERT INTO `operatelog` VALUES (312, 1, 1, '', ' 操作层级: Service 层;  操作方法: Integer cn.zup.bi.service.impl.BIPageBlockServiceImpl.saveBlock(BI_Block_Info); 操作参数: cn.zup.bi.entity.BI_Block_Info@2189304d ,', '2019-12-20 23:37:07', 1, '', '', '');
INSERT INTO `operatelog` VALUES (313, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2019-12-20 23:37:07', 1, '', '', '');
INSERT INTO `operatelog` VALUES (314, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@1d4d97fa ,', '2019-12-20 23:37:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (315, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@1c279f52 ,', '2019-12-20 23:37:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (316, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2019-12-20 23:37:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (317, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@2e48db4d ,', '2019-12-20 23:37:17', 1, '', '', '');
INSERT INTO `operatelog` VALUES (318, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@4f222556 ,', '2019-12-20 23:37:17', 1, '', '', '');
INSERT INTO `operatelog` VALUES (319, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2019-12-20 23:37:17', 1, '', '', '');
INSERT INTO `operatelog` VALUES (320, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@1d1238f9 ,', '2019-12-20 23:37:42', 1, '', '', '');
INSERT INTO `operatelog` VALUES (321, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@1ee14003 ,', '2019-12-20 23:37:42', 1, '', '', '');
INSERT INTO `operatelog` VALUES (322, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2019-12-20 23:37:42', 1, '', '', '');
INSERT INTO `operatelog` VALUES (323, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@16ea7a4c ,', '2019-12-20 23:42:47', 1, '', '', '');
INSERT INTO `operatelog` VALUES (324, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@71cacf8e ,', '2019-12-20 23:42:47', 1, '', '', '');
INSERT INTO `operatelog` VALUES (325, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2019-12-20 23:42:47', 1, '', '', '');
INSERT INTO `operatelog` VALUES (326, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@5702256d ,', '2019-12-20 23:42:58', 1, '', '', '');
INSERT INTO `operatelog` VALUES (327, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@6a592c50 ,', '2019-12-20 23:42:58', 1, '', '', '');
INSERT INTO `operatelog` VALUES (328, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2019-12-20 23:42:58', 1, '', '', '');
INSERT INTO `operatelog` VALUES (329, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@7a8c8c40 ,', '2019-12-21 05:23:29', 1, '', '', '');
INSERT INTO `operatelog` VALUES (330, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@1ae310ab ,', '2019-12-21 05:23:30', 1, '', '', '');
INSERT INTO `operatelog` VALUES (331, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2019-12-21 05:23:31', 1, '', '', '');
INSERT INTO `operatelog` VALUES (332, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldList(Integer); 操作参数: 170 ,', '2019-12-21 05:23:31', 1, '', '', '');
INSERT INTO `operatelog` VALUES (333, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getDimFieldList(Integer,List,List); 操作参数: 170 ,[] ,[] ,', '2019-12-21 05:23:31', 1, '', '', '');
INSERT INTO `operatelog` VALUES (334, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2019-12-21 05:23:31', 1, '', '', '');
INSERT INTO `operatelog` VALUES (335, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,1 ,', '2019-12-21 05:23:31', 1, '', '', '');
COMMIT;

-- ----------------------------
-- Table structure for organ
-- ----------------------------
DROP TABLE IF EXISTS `organ`;
CREATE TABLE `organ` (
  `ORGANID` int(38) NOT NULL AUTO_INCREMENT,
  `PARENTORGANID` int(38) DEFAULT NULL,
  `ORGANCODE` varchar(63) DEFAULT NULL,
  `ORGANNAME` varchar(255) DEFAULT NULL,
  `SHORTNAME` varchar(63) DEFAULT NULL,
  `ORDERCODE` int(38) DEFAULT NULL,
  `ORGANTYPE` int(3) DEFAULT NULL,
  `GOVERNOR` varchar(127) DEFAULT NULL,
  `VALIDFLAG` int(3) DEFAULT NULL,
  PRIMARY KEY (`ORGANID`),
  KEY `poid` (`PARENTORGANID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of organ
-- ----------------------------
BEGIN;
INSERT INTO `organ` VALUES (1, 0, NULL, '集团', NULL, 1, 1, '1', 1);
COMMIT;

-- ----------------------------
-- Table structure for orgin_area
-- ----------------------------
DROP TABLE IF EXISTS `orgin_area`;
CREATE TABLE `orgin_area` (
  `ORGIN_AREA_ID` int(10) NOT NULL AUTO_INCREMENT,
  `ORGIN_ID` int(10) DEFAULT NULL,
  `ORGIN_TYPE` int(10) DEFAULT NULL,
  `AREA_CODE` int(10) DEFAULT NULL,
  `AREA_TYPE` int(5) DEFAULT NULL,
  PRIMARY KEY (`ORGIN_AREA_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for post
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post` (
  `POSTID` int(38) NOT NULL AUTO_INCREMENT,
  `ORGANID` int(38) DEFAULT NULL,
  `POSTNAME` varchar(255) DEFAULT NULL,
  `POSTDUTY` varchar(255) DEFAULT NULL,
  `STANDARDNUMBER` int(38) DEFAULT NULL,
  `VALIDFLAG` int(3) DEFAULT NULL,
  PRIMARY KEY (`POSTID`),
  KEY `oid` (`ORGANID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of post
-- ----------------------------
BEGIN;
INSERT INTO `post` VALUES (1, 1, '管理层', '1', 1, 1);
COMMIT;

-- ----------------------------
-- Table structure for regional_construction
-- ----------------------------
DROP TABLE IF EXISTS `regional_construction`;
CREATE TABLE `regional_construction` (
  `REGION_NAME` varchar(255) NOT NULL,
  `REGION_TYPE` int(1) DEFAULT NULL,
  `REGION_DATA` text,
  `BUILDED_DATE` date DEFAULT NULL,
  `REGION_ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`REGION_ID`),
  KEY `name` (`REGION_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `ROLEID` int(38) NOT NULL AUTO_INCREMENT,
  `PARENTROLEID` int(38) DEFAULT NULL,
  `ROLENAME` varchar(255) DEFAULT NULL,
  `ROLETYPE` int(10) DEFAULT NULL,
  `ROLELIMIT` int(38) DEFAULT NULL,
  PRIMARY KEY (`ROLEID`),
  KEY `rid` (`PARENTROLEID`) USING BTREE,
  CONSTRAINT `role_ibfk_1` FOREIGN KEY (`PARENTROLEID`) REFERENCES `role` (`ROLEID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
BEGIN;
INSERT INTO `role` VALUES (1, NULL, '管理员', 1, 1);
COMMIT;

-- ----------------------------
-- Table structure for roleaction
-- ----------------------------
DROP TABLE IF EXISTS `roleaction`;
CREATE TABLE `roleaction` (
  `ACTIONID` int(38) NOT NULL AUTO_INCREMENT,
  `ROLEID` int(38) NOT NULL,
  `ACTIONPERMISSION` int(10) DEFAULT NULL,
  PRIMARY KEY (`ACTIONID`,`ROLEID`),
  KEY `rids` (`ROLEID`) USING BTREE,
  CONSTRAINT `roleaction_ibfk_1` FOREIGN KEY (`ROLEID`) REFERENCES `role` (`ROLEID`),
  CONSTRAINT `roleaction_ibfk_2` FOREIGN KEY (`ACTIONID`) REFERENCES `action` (`ACTIONID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for roledata
-- ----------------------------
DROP TABLE IF EXISTS `roledata`;
CREATE TABLE `roledata` (
  `DATAID` int(38) NOT NULL AUTO_INCREMENT,
  `MENUID` int(38) NOT NULL,
  `ROLEID` int(38) NOT NULL,
  `DATAPERMISSIONTYPE` int(10) NOT NULL,
  `DATAPERMISSION` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`DATAID`),
  KEY `did` (`ROLEID`) USING BTREE,
  CONSTRAINT `roledata_ibfk_1` FOREIGN KEY (`ROLEID`) REFERENCES `role` (`ROLEID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rolemenu
-- ----------------------------
DROP TABLE IF EXISTS `rolemenu`;
CREATE TABLE `rolemenu` (
  `MENUID` int(38) NOT NULL AUTO_INCREMENT,
  `ROLEID` int(38) NOT NULL,
  `MENUPERMISSION` int(10) NOT NULL,
  PRIMARY KEY (`MENUID`,`ROLEID`),
  KEY `ROLEID` (`ROLEID`) USING BTREE,
  CONSTRAINT `rolemenu_ibfk_1` FOREIGN KEY (`ROLEID`) REFERENCES `role` (`ROLEID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rolemenu
-- ----------------------------
BEGIN;
INSERT INTO `rolemenu` VALUES (1, 1, 1);
INSERT INTO `rolemenu` VALUES (2, 1, 1);
INSERT INTO `rolemenu` VALUES (3, 1, 1);
INSERT INTO `rolemenu` VALUES (4, 1, 1);
INSERT INTO `rolemenu` VALUES (5, 1, 1);
INSERT INTO `rolemenu` VALUES (6, 1, 1);
INSERT INTO `rolemenu` VALUES (7, 1, 1);
INSERT INTO `rolemenu` VALUES (8, 1, 1);
INSERT INTO `rolemenu` VALUES (9, 1, 1);
INSERT INTO `rolemenu` VALUES (10, 1, 1);
COMMIT;

-- ----------------------------
-- Table structure for system
-- ----------------------------
DROP TABLE IF EXISTS `system`;
CREATE TABLE `system` (
  `SYSTEMID` int(38) NOT NULL AUTO_INCREMENT,
  `SYSTEMNAME` varchar(255) NOT NULL,
  `SYSTEMURL` varchar(63) DEFAULT NULL,
  `VALIDFLAG` int(38) DEFAULT NULL,
  `IMGPATH` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`SYSTEMID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of system
-- ----------------------------
BEGIN;
INSERT INTO `system` VALUES (1, 'ZUP', 'homeController', 1, NULL);
COMMIT;

-- ----------------------------
-- Table structure for userinfo
-- ----------------------------
DROP TABLE IF EXISTS `userinfo`;
CREATE TABLE `userinfo` (
  `USERID` int(38) NOT NULL AUTO_INCREMENT,
  `ORGANID` int(38) NOT NULL,
  `POSTID` int(38) NOT NULL,
  `REALNAME` varchar(31) DEFAULT '',
  `SEX` int(3) DEFAULT NULL,
  `BIRTHDAY` datetime DEFAULT NULL,
  `IDENTITYCARD` varchar(255) DEFAULT '',
  `NATIVEPLACE` varchar(255) DEFAULT '',
  `ADDRESS` varchar(255) DEFAULT '',
  `PHONE` varchar(31) DEFAULT '',
  `CELLPHONE` varchar(255) DEFAULT '',
  `EDUCATION` varchar(255) DEFAULT '',
  `GRADUATIONDATE` datetime DEFAULT NULL,
  `POLITICSSTATUS` int(3) DEFAULT NULL,
  `CONTRACTTYPE` int(3) DEFAULT NULL,
  `CONTRACTSTARTDATE` datetime DEFAULT NULL,
  `CONTRACTTERMINATIONDATE` datetime DEFAULT NULL,
  `PROFESSIONALINFO` varchar(1023) DEFAULT '',
  `CREATEDATE` datetime DEFAULT NULL,
  `VALIDFLAG` int(3) DEFAULT NULL,
  PRIMARY KEY (`USERID`),
  KEY `pu` (`POSTID`) USING BTREE,
  KEY `ou` (`ORGANID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userinfo
-- ----------------------------
BEGIN;
INSERT INTO `userinfo` VALUES (1, 1, 1, '管理员', 1, '2019-12-19 10:22:02', '', '', '', '', '', '', NULL, NULL, NULL, '2019-12-19 10:22:10', '2019-12-19 10:22:08', '', '2019-12-19 10:22:14', 1);
COMMIT;

-- ----------------------------
-- Table structure for userlogon
-- ----------------------------
DROP TABLE IF EXISTS `userlogon`;
CREATE TABLE `userlogon` (
  `ACCOUNTID` int(38) NOT NULL,
  `OPENID` varchar(255) DEFAULT '',
  `PREVIOUSVISIT` datetime DEFAULT NULL,
  `LASTVISIT` datetime DEFAULT NULL,
  `LOGONCOUNT` int(38) DEFAULT NULL,
  `MULTIUSERLOGIN` int(38) DEFAULT NULL,
  `USERONLINE` int(38) DEFAULT NULL,
  `CHECKIPADDRESS` int(38) DEFAULT NULL,
  `IPADDRESS` varchar(255) DEFAULT '',
  `MACADDRESS` varchar(255) DEFAULT '',
  `SYSTEMID` int(38) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wechat_register
-- ----------------------------
DROP TABLE IF EXISTS `wechat_register`;
CREATE TABLE `wechat_register` (
  `REGISTER_ID` int(38) NOT NULL AUTO_INCREMENT,
  `COMPANY_ID` int(38) DEFAULT NULL,
  `REGISTER_NAME` varchar(50) DEFAULT '',
  `REGISTER_PWD` varchar(50) DEFAULT '',
  `WX_ACCOUNT` varchar(50) DEFAULT '',
  `BIND_DATE` datetime DEFAULT NULL,
  PRIMARY KEY (`REGISTER_ID`),
  KEY `wids` (`COMPANY_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wechat_server
-- ----------------------------
DROP TABLE IF EXISTS `wechat_server`;
CREATE TABLE `wechat_server` (
  `SERVICE_ID` int(38) NOT NULL AUTO_INCREMENT COMMENT '公众号id',
  `SERVICE_NAME` varchar(255) DEFAULT '' COMMENT '公众号名称',
  `SERVICE_ACCOUNT` varchar(255) DEFAULT '' COMMENT '公众号账号',
  `APPID` varchar(255) DEFAULT '',
  `APPSECRET` varchar(255) DEFAULT '',
  `ORIGINAL_ID` varchar(255) DEFAULT '' COMMENT '原始id',
  `VALIDFLAG` int(11) DEFAULT NULL COMMENT '有效性',
  `TOKEN_NAME` varchar(255) DEFAULT '',
  PRIMARY KEY (`SERVICE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wechat_system
-- ----------------------------
DROP TABLE IF EXISTS `wechat_system`;
CREATE TABLE `wechat_system` (
  `COMPANY_ID` int(38) NOT NULL AUTO_INCREMENT,
  `COMPANY_NAME` varchar(100) DEFAULT '',
  `SERVICE_ID` int(38) DEFAULT NULL,
  `SYSTEM_ID` int(38) DEFAULT NULL,
  `SYSTEM_URL` varchar(3000) DEFAULT '',
  `REGION_ID` int(38) DEFAULT NULL,
  `IMG_URL` varchar(2000) DEFAULT '',
  `REGION_TYPE` int(38) DEFAULT NULL,
  PRIMARY KEY (`COMPANY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wechat_template
-- ----------------------------
DROP TABLE IF EXISTS `wechat_template`;
CREATE TABLE `wechat_template` (
  `TEMP_ID` int(38) NOT NULL AUTO_INCREMENT,
  `TEMP_NAME` varchar(1024) DEFAULT '',
  `TEMPLATE_ID` varchar(1024) DEFAULT '',
  `SKIP_URL` varchar(1024) DEFAULT '',
  `REQUEST_URL` varchar(1024) DEFAULT '',
  `TOP_COLOR` varchar(1024) DEFAULT '',
  `SERVICE_ID` int(38) DEFAULT NULL,
  PRIMARY KEY (`TEMP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;

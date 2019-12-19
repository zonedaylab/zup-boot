/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50724
Source Host           : localhost:3306
Source Database       : zup

Target Server Type    : MYSQL
Target Server Version : 50724
File Encoding         : 65001

Date: 2019-12-19 11:30:47
*/

SET FOREIGN_KEY_CHECKS=0;

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
) ENGINE=InnoDB AUTO_INCREMENT=3733 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account
-- ----------------------------
INSERT INTO `account` VALUES ('1', '1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '1', '1', '1', '1');

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
INSERT INTO `accountrole` VALUES ('1', '1');

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
) ENGINE=InnoDB AUTO_INCREMENT=121695 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of action
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ahp_flow
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=330 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ahp_line
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=406 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ahp_node
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=450 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ahp_node_relation
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ahp_norm_base
-- ----------------------------

-- ----------------------------
-- Table structure for ahp_norm_node
-- ----------------------------
DROP TABLE IF EXISTS `ahp_norm_node`;
CREATE TABLE `ahp_norm_node` (
  `NORM_NODE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `NODE_CODE` varchar(11) DEFAULT NULL,
  `NORM_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`NORM_NODE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ahp_norm_node
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of area_evaluation
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=546 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bi_block
-- ----------------------------

-- ----------------------------
-- Table structure for bi_dim
-- ----------------------------
DROP TABLE IF EXISTS `bi_dim`;
CREATE TABLE `bi_dim` (
  `DIM_ID` int(38) NOT NULL AUTO_INCREMENT,
  `DIM_NAME` varchar(127) DEFAULT '',
  `BIZ_TABLE_NAME` varchar(20) DEFAULT '',
  `TEXT_FIELD` varchar(150) DEFAULT '',
  `ID_FIELD` varchar(500) DEFAULT '',
  `DRILL_TYPE` int(10) DEFAULT NULL,
  `DRILL_INFO` varchar(512) DEFAULT '',
  PRIMARY KEY (`DIM_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=252 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bi_dim
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bi_dim_attribute
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bi_page
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bi_report
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=577 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bi_report_field
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bi_screen
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bi_topic
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=215 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bi_topic_field
-- ----------------------------

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
-- Records of bug_feedback_info
-- ----------------------------

-- ----------------------------
-- Table structure for codeconfig
-- ----------------------------
DROP TABLE IF EXISTS `codeconfig`;
CREATE TABLE `codeconfig` (
  `CONFIGID` int(38) NOT NULL AUTO_INCREMENT,
  `CONFIGCODE` varchar(128) NOT NULL,
  `MEMO` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`CONFIGID`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of codeconfig
-- ----------------------------

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
-- Records of codeserial
-- ----------------------------

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
INSERT INTO `domain_system` VALUES ('1', '1', 'ZUP', 'homeController');

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
-- Records of evaluation_x
-- ----------------------------

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
-- Records of files
-- ----------------------------

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
-- Records of file_format
-- ----------------------------

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
-- Records of file_package
-- ----------------------------

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
-- Records of file_virtual
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=37568 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of loginlog
-- ----------------------------
INSERT INTO `loginlog` VALUES ('37566', '1', '1', '2019-12-19 11:12:08', '1', '1', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37567', '1', '1', '2019-12-19 11:25:49', '1', '1', '0:0:0:0:0:0:0:1', null, null, '管理员');

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', '1', '0', '首页', '1', null, null, 'rest/rbac/homeController', null, null, '2');
INSERT INTO `menu` VALUES ('2', '1', '0', '系统管理', '9', null, null, null, null, null, '2');
INSERT INTO `menu` VALUES ('3', '1', '2', '菜单管理', '1', null, null, 'rest/rbac/menuController', null, null, '2');
INSERT INTO `menu` VALUES ('4', '1', '2', '操作项管理', '2', null, null, 'rest/rbac/menuActionController', null, null, '2');

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
) ENGINE=InnoDB AUTO_INCREMENT=187723 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mine_evaluation
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mine_evaluation_batch
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of operatelog
-- ----------------------------
INSERT INTO `operatelog` VALUES ('27', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2019-12-19 10:41:14', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('28', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2019-12-19 10:41:15', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('29', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-19 10:41:15', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('30', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2019-12-19 10:41:22', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('31', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2019-12-19 10:41:22', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('32', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-19 10:41:22', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('33', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2019-12-19 11:11:30', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('34', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2019-12-19 11:11:30', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('35', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-19 11:11:30', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('36', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2019-12-19 11:11:43', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('37', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2019-12-19 11:11:43', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('38', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-19 11:11:43', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('39', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2019-12-19 11:12:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('40', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2019-12-19 11:12:08', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('41', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-19 11:12:08', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('42', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@40c754fd ,', '2019-12-19 11:12:08', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('43', '1', '1', '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-19 11:12:09', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('44', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2019-12-19 11:12:09', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('45', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2019-12-19 11:12:19', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('46', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2019-12-19 11:12:20', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('47', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@1f993924 ,', '2019-12-19 11:12:20', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('48', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2019-12-19 11:12:20', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('49', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2019-12-19 11:12:20', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('50', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2019-12-19 11:12:20', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('51', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2019-12-19 11:12:20', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('52', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 1 ,', '2019-12-19 11:12:22', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('53', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,2 ,true ,', '2019-12-19 11:12:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('54', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 2 ,', '2019-12-19 11:12:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('55', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 3 ,', '2019-12-19 11:12:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('56', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 3 ,', '2019-12-19 11:12:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('57', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 1 ,', '2019-12-19 11:12:24', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('58', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 3 ,', '2019-12-19 11:13:49', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('59', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 2 ,', '2019-12-19 11:13:51', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('60', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 1 ,', '2019-12-19 11:13:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('61', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 2 ,', '2019-12-19 11:13:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('63', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2019-12-19 11:25:48', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('64', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2019-12-19 11:25:49', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('65', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-19 11:25:49', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('66', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@3d968f ,', '2019-12-19 11:25:49', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('67', '1', '1', '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-19 11:25:49', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('68', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2019-12-19 11:25:49', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('69', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2019-12-19 11:25:56', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('70', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2019-12-19 11:25:57', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('71', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2019-12-19 11:25:59', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('72', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@de3f956 ,', '2019-12-19 11:25:59', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('73', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2019-12-19 11:25:59', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('74', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2019-12-19 11:25:59', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('75', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2019-12-19 11:25:59', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('76', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2019-12-19 11:25:59', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('77', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,2 ,true ,', '2019-12-19 11:26:00', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('78', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 2 ,', '2019-12-19 11:26:00', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('79', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 3 ,', '2019-12-19 11:26:00', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('80', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 3 ,', '2019-12-19 11:26:01', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('81', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 1 ,', '2019-12-19 11:26:03', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('82', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 2 ,', '2019-12-19 11:26:04', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('83', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 2 ,', '2019-12-19 11:26:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('87', '1', '1', '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-19 11:29:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('88', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2019-12-19 11:29:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('89', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2019-12-19 11:29:09', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('90', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2019-12-19 11:29:10', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('91', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@2ee10d2c ,', '2019-12-19 11:29:10', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('92', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2019-12-19 11:29:10', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('93', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2019-12-19 11:29:10', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('94', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2019-12-19 11:29:10', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('95', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2019-12-19 11:29:10', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('96', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2019-12-19 11:29:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('97', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@3bd84c31 ,1 ,10 ,', '2019-12-19 11:29:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('98', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2019-12-19 11:29:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('99', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2019-12-19 11:29:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('100', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@5b6e805a ,1 ,10 ,', '2019-12-19 11:29:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('101', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2019-12-19 11:29:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('103', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,2 ,true ,', '2019-12-19 11:29:29', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('104', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@4c32f20c ,1 ,10 ,', '2019-12-19 11:29:29', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('105', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 3 ,', '2019-12-19 11:29:29', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('106', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 4 ,', '2019-12-19 11:29:29', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('108', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,2 ,true ,', '2019-12-19 11:29:34', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('109', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 2 ,', '2019-12-19 11:29:34', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('110', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 3 ,', '2019-12-19 11:29:34', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('111', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 4 ,', '2019-12-19 11:29:34', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('113', '1', '1', '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-19 11:30:00', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('114', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2019-12-19 11:30:00', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('115', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2019-12-19 11:30:01', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('116', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2019-12-19 11:30:03', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('117', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@6a8c4062 ,', '2019-12-19 11:30:03', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('118', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2019-12-19 11:30:03', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('119', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2019-12-19 11:30:03', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('120', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2019-12-19 11:30:03', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('121', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2019-12-19 11:30:03', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('122', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2019-12-19 11:30:04', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('123', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@28bd71fb ,1 ,10 ,', '2019-12-19 11:30:04', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('124', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2019-12-19 11:30:04', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('125', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@c90761c ,1 ,10 ,', '2019-12-19 11:30:04', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('126', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2019-12-19 11:30:04', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('127', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2019-12-19 11:30:04', '1', '', '', '');

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
INSERT INTO `organ` VALUES ('1', '0', null, '集团', null, '1', '1', '1', '1');

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
-- Records of orgin_area
-- ----------------------------

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
INSERT INTO `post` VALUES ('1', '1', '管理层', '1', '1', '1');

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
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of regional_construction
-- ----------------------------

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
INSERT INTO `role` VALUES ('1', null, '管理员', '1', '1');

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
) ENGINE=InnoDB AUTO_INCREMENT=121695 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of roleaction
-- ----------------------------

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
-- Records of roledata
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=1498 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rolemenu
-- ----------------------------
INSERT INTO `rolemenu` VALUES ('1', '1', '1');
INSERT INTO `rolemenu` VALUES ('2', '1', '1');
INSERT INTO `rolemenu` VALUES ('3', '1', '1');
INSERT INTO `rolemenu` VALUES ('4', '1', '1');

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
INSERT INTO `system` VALUES ('1', 'ZUP', 'homeController', '1', null);

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
INSERT INTO `userinfo` VALUES ('1', '1', '1', '管理员', '1', '2019-12-19 10:22:02', '', '', '', '', '', '', null, null, null, '2019-12-19 10:22:10', '2019-12-19 10:22:08', '', '2019-12-19 10:22:14', '1');

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
-- Records of userlogon
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=845 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wechat_register
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wechat_server
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wechat_system
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wechat_template
-- ----------------------------

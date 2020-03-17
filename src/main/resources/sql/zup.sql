/*
Navicat MySQL Data Transfer

Source Server         : docker-3306
Source Server Version : 50723
Source Host           : localhost:3306
Source Database       : zup

Target Server Type    : MYSQL
Target Server Version : 50723
File Encoding         : 65001

Date: 2020-03-17 09:30:46
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of area_evaluation
-- ----------------------------

-- ----------------------------
-- Table structure for auditlog
-- ----------------------------
DROP TABLE IF EXISTS `auditlog`;
CREATE TABLE `auditlog` (
  `auditId` int(99) NOT NULL AUTO_INCREMENT,
  `userId` int(99) DEFAULT NULL,
  `systemId` int(99) DEFAULT NULL,
  `auditPage` varchar(255) DEFAULT NULL,
  `auditEvent` varchar(255) DEFAULT NULL,
  `auditLevel` int(10) DEFAULT NULL,
  `auditDate` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `userIp` varchar(255) DEFAULT NULL,
  `ipAddr` varchar(255) DEFAULT NULL,
  `memo` varchar(999) DEFAULT NULL,
  PRIMARY KEY (`auditId`)
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auditlog
-- ----------------------------
INSERT INTO `auditlog` VALUES ('188', '1', '1', '表单管理 ', '编辑', '3', '2020-03-16 20:17:06', '0:0:0:0:0:0:0:1', '山东省 济南市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES ('189', '1', '1', '表单管理 ', '编辑', '3', '2020-03-16 20:17:07', '0:0:0:0:0:0:0:1', '山东省 济南市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES ('190', '1', '1', '表单管理 ', '取消', '3', '2020-03-16 20:17:23', '0:0:0:0:0:0:0:1', '山东省 济南市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES ('191', '1', '1', '表单管理 ', '编辑', '3', '2020-03-16 20:19:04', '0:0:0:0:0:0:0:1', '山东省 济南市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES ('192', '1', '1', '表单管理 ', '保存', '3', '2020-03-16 20:19:48', '0:0:0:0:0:0:0:1', '山东省 济南市', null);
INSERT INTO `auditlog` VALUES ('193', '1', '1', '表单管理 ', '编辑', '3', '2020-03-16 20:20:41', '0:0:0:0:0:0:0:1', '山东省 济南市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES ('194', '1', '1', '表单管理 ', '保存', '3', '2020-03-16 20:22:10', '0:0:0:0:0:0:0:1', '山东省 济南市', null);
INSERT INTO `auditlog` VALUES ('195', '1', '1', '表单管理 ', '编辑', '3', '2020-03-16 20:23:16', '0:0:0:0:0:0:0:1', '山东省 济南市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES ('196', '1', '1', '表单管理 ', '取消', '3', '2020-03-16 20:23:18', '0:0:0:0:0:0:0:1', '山东省 济南市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES ('197', '1', '1', '表单管理 ', '编辑', '3', '2020-03-16 20:24:17', '0:0:0:0:0:0:0:1', '山东省 济南市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES ('198', '1', '1', '表单管理 ', '编辑', '3', '2020-03-16 20:47:41', '0:0:0:0:0:0:0:1', '山东省 济南市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES ('199', '1', '1', '表单管理 ', '取消', '3', '2020-03-16 20:47:43', '0:0:0:0:0:0:0:1', '山东省 济南市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES ('200', '1', '1', '表单管理 ', '编辑', '3', '2020-03-16 20:47:55', '0:0:0:0:0:0:0:1', '山东省 济南市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES ('201', '1', '1', '表单管理 ', '保存', '3', '2020-03-16 20:48:17', '0:0:0:0:0:0:0:1', '山东省 济南市', null);
INSERT INTO `auditlog` VALUES ('202', '1', '1', '表单管理 ', '编辑', '3', '2020-03-16 20:48:25', '0:0:0:0:0:0:0:1', '山东省 济南市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES ('203', '1', '1', '表单管理 ', '取消', '3', '2020-03-16 20:48:28', '0:0:0:0:0:0:0:1', '山东省 济南市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES ('204', '1', '1', '主题配置 ', '字段设置', '3', '2020-03-16 20:49:25', '0:0:0:0:0:0:0:1', '山东省 济南市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES ('205', '1', '1', '1', '编辑', '3', '2020-03-16 20:49:56', '0:0:0:0:0:0:0:1', '山东省 济南市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES ('206', '1', '1', '1', '保存', '3', '2020-03-16 20:50:19', '0:0:0:0:0:0:0:1', '山东省 济南市', null);
INSERT INTO `auditlog` VALUES ('207', '1', '1', '1', '确定', '3', '2020-03-16 20:50:21', '0:0:0:0:0:0:0:1', '山东省 济南市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES ('208', '1', '1', '表单管理 ', '编辑', '3', '2020-03-16 21:25:17', '0:0:0:0:0:0:0:1', '山东省 济南市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES ('209', '1', '1', '表单管理 ', '取消', '3', '2020-03-16 21:25:19', '0:0:0:0:0:0:0:1', '山东省 济南市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES ('210', '1', '1', '表单管理 ', '元素设置', '3', '2020-03-16 21:26:09', '0:0:0:0:0:0:0:1', '山东省 济南市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES ('211', '1', '1', '1', '字段设置', '3', '2020-03-16 21:26:12', '0:0:0:0:0:0:0:1', '山东省 济南市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES ('212', '1', '1', '1', '删除', '3', '2020-03-16 21:26:30', '0:0:0:0:0:0:0:1', '山东省 济南市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES ('213', '1', '1', '1', '取消', '3', '2020-03-16 21:26:33', '0:0:0:0:0:0:0:1', '山东省 济南市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES ('214', '1', '1', '1', '编辑', '3', '2020-03-16 21:26:34', '0:0:0:0:0:0:0:1', '山东省 济南市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES ('215', '1', '1', '1', '保存', '3', '2020-03-16 21:26:47', '0:0:0:0:0:0:0:1', '山东省 济南市', null);
INSERT INTO `auditlog` VALUES ('216', '1', '1', '1', '确定', '3', '2020-03-16 21:26:48', '0:0:0:0:0:0:0:1', '山东省 济南市', '该用户可能保存了编辑或者添加的数据');

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
INSERT INTO `bi_block` VALUES ('546', null, '1', null, null, null, '170', '29', '2', '1');

-- ----------------------------
-- Table structure for bi_datasource
-- ----------------------------
DROP TABLE IF EXISTS `bi_datasource`;
CREATE TABLE `bi_datasource` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `ds_ip` varchar(1024) DEFAULT NULL COMMENT '数据源ip地址',
  `ds_port` int(4) NOT NULL COMMENT '数据源端口号',
  `ds_username` varchar(64) DEFAULT NULL COMMENT '数据源用户名',
  `ds_password` varchar(256) DEFAULT NULL COMMENT '数据源密码',
  `ds_attr` varchar(255) DEFAULT NULL COMMENT '数据源属性',
  `ds_name` varchar(255) NOT NULL COMMENT '数据源名称',
  `ds_dir` varchar(255) DEFAULT NULL COMMENT '数据源目录',
  `ds_create_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`ds_port`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bi_datasource
-- ----------------------------
INSERT INTO `bi_datasource` VALUES ('1', '127.0.0.1', '3306', 'root', '123456', 'mysql', 'bi-demo', 'root', '2020-02-13 17:59:03');

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
INSERT INTO `bi_dim` VALUES ('253', '商品分类信息', 'pms_product_catego1ry', 'name', 'id', '1', '');
INSERT INTO `bi_dim` VALUES ('254', '商品品牌', 'pms_bra1nd', 'name', 'id', '1', '');

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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bi_page
-- ----------------------------
INSERT INTO `bi_page` VALUES ('29', '3', '商品统计展示', '统计演示', 'bi/biReportTemplate', '12', '数据展示');

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
INSERT INTO `bi_report` VALUES ('170', '45', '分类商品价格趋势', '分类商品价格趋势', '2019-12-20 23:32:20', '29');

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
INSERT INTO `bi_report_field` VALUES ('577', '170', '215', '3', '1', null);
INSERT INTO `bi_report_field` VALUES ('578', '170', '216', '1', '1', null);
INSERT INTO `bi_report_field` VALUES ('579', '170', '217', '2', '1', '0');

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
INSERT INTO `bi_screen` VALUES ('31', '首页', '1', '29');

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
  `DS_ID` int(38) DEFAULT '1',
  PRIMARY KEY (`TOPIC_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bi_topic
-- ----------------------------
INSERT INTO `bi_topic` VALUES ('45', 'product_info', '商品信息', null, 'pms_product', '1');

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
INSERT INTO `bi_topic_field` VALUES ('215', 'id', 'id', '商品数量', '1', '10', '4', '1', '1', '45', null, '3', 'COUNT', '数量');
INSERT INTO `bi_topic_field` VALUES ('216', 'product_category_id', 'product_category_id', '类型', '2', '10', '4', '1', '1', '45', '253', '1', null, '');
INSERT INTO `bi_topic_field` VALUES ('217', 'brand_id', 'brand_id', '品牌', '2', '10', '4', '1', '1', '45', '254', '1', null, '');
INSERT INTO `bi_topic_field` VALUES ('218', 'name', 'name', '名称', '2', '10', '4', '1', '1', '45', null, '2', null, '');
INSERT INTO `bi_topic_field` VALUES ('219', 'price', 'price', '价格', '1', '10', '4', '1', '1', '45', null, '2', null, '元');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
INSERT INTO `config` VALUES ('77', '1', '数据类型', '数字');
INSERT INTO `config` VALUES ('77', '2', '数据类型', '文本');
INSERT INTO `config` VALUES ('78', '1', '是否字段', '是');
INSERT INTO `config` VALUES ('78', '2', '是否字段', '否');
INSERT INTO `config` VALUES ('79', '1', '字段类型', '关联维度表');
INSERT INTO `config` VALUES ('79', '2', '字段类型', '普通字段');
INSERT INTO `config` VALUES ('79', '3', '字段类型', '聚合字段');
INSERT INTO `config` VALUES ('80', '1', '页面类型', '监控大屏');
INSERT INTO `config` VALUES ('80', '2', '页面类型', '普通网页(图)');
INSERT INTO `config` VALUES ('80', '3', '页面类型	', '普通网页（表格）');
INSERT INTO `config` VALUES ('81', '1', '大屏拖拽模板', 'bi/biLargeScreen');
INSERT INTO `config` VALUES ('81', '2', '表格报表模板', 'bi/biReportTemplate');
INSERT INTO `config` VALUES ('81', '3', '多维饼图模板', 'bi/biEchartsTemplate');
INSERT INTO `config` VALUES ('81', '4', '流布局', 'bi/biFlowLayoutTemplate');
INSERT INTO `config` VALUES ('81', '5', '监测点展示', 'monitor/monitorDataShow');

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
) ENGINE=InnoDB AUTO_INCREMENT=37598 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of loginlog
-- ----------------------------
INSERT INTO `loginlog` VALUES ('37566', '1', '1', '2019-12-19 11:12:08', '1', '1', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37567', '1', '1', '2019-12-19 11:25:49', '1', '1', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37568', '1', '1', '2019-12-19 14:46:17', '1', '1', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37569', '1', '1', '2019-12-20 22:36:25', '1', '1', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37570', '1', '1', '2019-12-20 22:41:02', '1', '1', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37571', '1', '1', '2019-12-20 23:34:51', '1', '1', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37572', '1', '1', '2020-01-04 15:19:12', '1', '1', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37573', '1', '1', '2020-01-04 16:52:33', '1', '1', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37574', '1', '1', '2020-01-04 17:27:55', '1', '1', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37575', '1', '1', '2020-01-06 08:37:23', '1', '2', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37576', '1', '1', '2020-01-06 08:37:24', '1', '2', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37577', '1', '1', '2020-01-06 08:37:38', '1', '1', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37578', '1', '1', '2020-01-29 16:11:48', '1', '1', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37579', '1', '1', '2020-02-10 17:12:34', '1', '2', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37580', '1', '1', '2020-02-10 17:12:39', '1', '2', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37581', '1', '1', '2020-02-10 17:12:47', '1', '1', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37582', '1', '1', '2020-02-10 18:17:53', '1', '1', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37583', '1', '1', '2020-02-10 18:25:43', '1', '1', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37584', '1', '1', '2020-02-10 19:58:41', '1', '1', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37585', '1', '1', '2020-02-10 21:12:52', '1', '1', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37586', '1', '1', '2020-02-14 20:02:29', '1', '1', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37587', '1', '1', '2020-02-18 14:15:24', '1', '2', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37588', '1', '1', '2020-02-18 14:15:29', '1', '2', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37589', '1', '1', '2020-02-18 14:15:34', '1', '1', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37590', '1', '1', '2020-03-16 16:15:37', '1', '1', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37591', '1', '1', '2020-03-16 16:35:07', '1', '1', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37592', '1', '1', '2020-03-16 16:50:37', '1', '1', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37593', '1', '1', '2020-03-16 18:25:01', '1', '1', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37594', '1', '1', '2020-03-16 18:29:37', '1', '1', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37595', '1', '1', '2020-03-16 18:57:45', '1', '1', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37596', '1', '1', '2020-03-16 19:03:28', '1', '1', '0:0:0:0:0:0:0:1', null, null, '管理员');
INSERT INTO `loginlog` VALUES ('37597', '1', '1', '2020-03-16 19:19:29', '1', '1', '0:0:0:0:0:0:0:1', null, null, '管理员');

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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', '1', '0', '首页', '1', null, null, 'rest/rbac/homeController', null, null, '2');
INSERT INTO `menu` VALUES ('2', '1', '0', '系统管理', '9', null, null, null, null, null, '2');
INSERT INTO `menu` VALUES ('3', '1', '2', '菜单管理', '1', null, null, 'rest/rbac/menuController', null, null, '2');
INSERT INTO `menu` VALUES ('4', '1', '2', '操作项管理', '2', '', '', 'rest/rbac/roleController', '', '0', null);
INSERT INTO `menu` VALUES ('5', '1', '0', '商务智能', '5', null, null, null, null, null, '2');
INSERT INTO `menu` VALUES ('6', '1', '5', '维度配置', '2', null, null, 'rest/bi/BIDimController', null, null, '2');
INSERT INTO `menu` VALUES ('7', '1', '5', '主题配置', '3', null, null, 'rest/bi/BITopicController', null, null, '2');
INSERT INTO `menu` VALUES ('8', '1', '5', '表单管理', '4', null, null, 'rest/bi/biPageController', null, null, '2');
INSERT INTO `menu` VALUES ('12', '1', '5', '数据展示', null, '', '', '@bi', '', '0', '2');
INSERT INTO `menu` VALUES ('13', '1', '2', '权限管理', '3', '', '', 'rest/rbac/roleController', '', '0', '2');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=1501 DEFAULT CHARSET=utf8;

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
INSERT INTO `operatelog` VALUES ('128', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2019-12-19 14:46:16', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('129', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2019-12-19 14:46:16', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('130', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-19 14:46:16', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('131', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@50ee89ed ,', '2019-12-19 14:46:16', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('132', '1', '1', '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-19 14:46:16', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('133', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2019-12-19 14:46:16', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('134', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2019-12-19 14:46:18', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('135', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@1a89663d ,1 ,10 ,', '2019-12-19 14:46:20', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('136', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1156 ,', '2019-12-19 14:46:22', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('137', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@305c803b ,', '2019-12-19 14:46:22', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('138', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIPageServiceImpl.getBIPageListPage(BI_Page,int,int); 操作参数: cn.zup.bi.entity.BI_Page@1a020c9b ,1 ,10 ,', '2019-12-19 14:46:22', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('139', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@7188f713 ,', '2019-12-19 14:46:22', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('140', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@53b13e35 ,1 ,9999 ,', '2019-12-19 14:46:22', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('141', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@4a9f4193 ,', '2019-12-19 14:46:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('142', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT@7927c677 ,1 ,10 ,', '2019-12-19 14:46:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('144', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2019-12-20 22:36:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('145', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2019-12-20 22:36:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('146', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-20 22:36:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('147', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@48ca9a92 ,', '2019-12-20 22:36:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('148', '1', '1', '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-20 22:36:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('149', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2019-12-20 22:36:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('150', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2019-12-20 22:36:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('152', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getTableNameList(Connection); 操作参数: com.mysql.jdbc.JDBC4Connection@75d28270 ,', '2019-12-20 22:38:18', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('153', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@3e5c71e6 ,pms_product ,', '2019-12-20 22:38:26', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('154', null, null, '', ' 操作层级: Service 层;  操作方法: BI_DIM cn.zup.bi.service.impl.BIDimServiceImpl.getDimInfo(String); 操作参数: pms_product ,', '2019-12-20 22:38:26', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('155', null, null, '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@3e5c71e6 ,pms_product ,', '2019-12-20 22:38:26', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('156', null, null, '', ' 操作层级: Service 层;  操作方法: BI_DIM cn.zup.bi.service.impl.BIDimServiceImpl.getDimInfo(String); 操作参数: pms_product ,', '2019-12-20 22:38:27', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('157', null, null, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.BIDimServiceImpl.saveDimData(BI_DIM); 操作参数: cn.zup.bi.entity.BI_DIM@13cc78f1 ,', '2019-12-20 22:40:18', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('158', null, null, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@673f6bbb ,1 ,10 ,', '2019-12-20 22:40:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('159', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getTableNameList(Connection); 操作参数: com.mysql.jdbc.JDBC4Connection@1e1005b8 ,', '2019-12-20 22:40:24', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('160', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2019-12-20 22:41:01', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('161', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2019-12-20 22:41:01', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('162', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-20 22:41:01', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('163', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@789f87e ,', '2019-12-20 22:41:01', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('164', '1', '1', '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-20 22:41:01', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('165', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2019-12-20 22:41:01', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('166', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2019-12-20 22:41:03', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('167', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getTableNameList(Connection); 操作参数: com.mysql.jdbc.JDBC4Connection@52ffe2bb ,', '2019-12-20 22:41:04', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('168', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getTableNameList(Connection); 操作参数: com.mysql.jdbc.JDBC4Connection@12515c44 ,', '2019-12-20 22:52:59', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('169', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@2a501d1c ,pms_product_catego1ry ,', '2019-12-20 22:53:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('170', null, null, '', ' 操作层级: Service 层;  操作方法: BI_DIM cn.zup.bi.service.impl.BIDimServiceImpl.getDimInfo(String); 操作参数: pms_product_catego1ry ,', '2019-12-20 22:53:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('171', null, null, '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@2a501d1c ,pms_product_catego1ry ,', '2019-12-20 22:53:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('172', null, null, '', ' 操作层级: Service 层;  操作方法: BI_DIM cn.zup.bi.service.impl.BIDimServiceImpl.getDimInfo(String); 操作参数: pms_product_catego1ry ,', '2019-12-20 22:53:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('178', null, null, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.BIDimServiceImpl.saveDimData(BI_DIM); 操作参数: cn.zup.bi.entity.BI_DIM@2b7a422 ,', '2019-12-20 23:03:12', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('179', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getTableNameList(Connection); 操作参数: com.mysql.jdbc.JDBC4Connection@ab06c5c ,', '2019-12-20 23:03:19', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('180', null, null, '', ' 操作层级: Service 层;  操作方法: BI_DIM cn.zup.bi.service.impl.BIDimServiceImpl.getDimInfo(String); 操作参数: pms_comment_replay ,', '2019-12-20 23:03:52', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('181', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@1773b2f6 ,pms_comment_replay ,', '2019-12-20 23:03:52', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('182', null, null, '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@1773b2f6 ,pms_comment_replay ,', '2019-12-20 23:03:52', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('183', null, null, '', ' 操作层级: Service 层;  操作方法: BI_DIM cn.zup.bi.service.impl.BIDimServiceImpl.getDimInfo(String); 操作参数: pms_comment_replay ,', '2019-12-20 23:03:52', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('184', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getTableNameList(Connection); 操作参数: com.mysql.jdbc.JDBC4Connection@4723f19c ,', '2019-12-20 23:03:55', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('185', null, null, '', ' 操作层级: Service 层;  操作方法: BI_DIM cn.zup.bi.service.impl.BIDimServiceImpl.getDimInfo(String); 操作参数: pms_bra1nd ,', '2019-12-20 23:04:00', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('186', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@5c00a82a ,pms_bra1nd ,', '2019-12-20 23:04:00', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('187', null, null, '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@5c00a82a ,pms_bra1nd ,', '2019-12-20 23:04:00', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('188', null, null, '', ' 操作层级: Service 层;  操作方法: BI_DIM cn.zup.bi.service.impl.BIDimServiceImpl.getDimInfo(String); 操作参数: pms_bra1nd ,', '2019-12-20 23:04:00', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('189', null, null, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.BIDimServiceImpl.saveDimData(BI_DIM); 操作参数: cn.zup.bi.entity.BI_DIM@6c06c8c7 ,', '2019-12-20 23:04:19', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('190', null, null, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@3f18766d ,1 ,10 ,', '2019-12-20 23:04:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('191', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getTableNameList(Connection); 操作参数: com.mysql.jdbc.JDBC4Connection@472bed33 ,', '2019-12-20 23:04:26', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('192', null, null, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.TopicServiceImpl.addTopicData(BI_TOPIC); 操作参数: cn.zup.bi.entity.BI_TOPIC@7945adc3 ,', '2019-12-20 23:04:59', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('193', null, null, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@516f3250 ,1 ,10 ,', '2019-12-20 23:04:59', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('194', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getBiDimName(); 操作参数: ', '2019-12-20 23:05:03', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('195', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@6727f535 ,', '2019-12-20 23:05:03', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('196', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@5588229b ,', '2019-12-20 23:05:03', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('197', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@3761f044 ,', '2019-12-20 23:05:03', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('198', null, null, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldPagingList(BI_TOPIC_FIELD,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC_FIELD@7ca7b58e ,1 ,10 ,', '2019-12-20 23:05:03', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('199', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@1e1c51dc ,pms_product ,', '2019-12-20 23:05:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('200', null, null, '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@1e1c51dc ,pms_product ,', '2019-12-20 23:05:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('201', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@767e89a6 ,pms_product ,', '2019-12-20 23:11:08', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('202', null, null, '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@767e89a6 ,pms_product ,', '2019-12-20 23:11:08', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('203', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getBiDimName(); 操作参数: ', '2019-12-20 23:20:31', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('204', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@4b4c6ad9 ,', '2019-12-20 23:20:31', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('205', null, null, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldPagingList(BI_TOPIC_FIELD,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC_FIELD@84029f9 ,1 ,10 ,', '2019-12-20 23:20:31', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('206', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@25debe3b ,', '2019-12-20 23:20:31', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('207', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@7b40dbe2 ,', '2019-12-20 23:20:31', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('208', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@11002ac5 ,pms_product ,', '2019-12-20 23:20:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('209', null, null, '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@11002ac5 ,pms_product ,', '2019-12-20 23:20:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('210', null, null, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.TopicFieldServiceImpl.addTopicData(BI_TOPIC_FIELD); 操作参数: cn.zup.bi.entity.BI_TOPIC_FIELD@2422a6e9 ,', '2019-12-20 23:23:57', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('211', null, null, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldPagingList(BI_TOPIC_FIELD,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC_FIELD@43a0f58d ,1 ,10 ,', '2019-12-20 23:23:57', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('212', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@706980d0 ,pms_product ,', '2019-12-20 23:24:01', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('213', null, null, '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@706980d0 ,pms_product ,', '2019-12-20 23:24:01', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('214', null, null, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.TopicFieldServiceImpl.addTopicData(BI_TOPIC_FIELD); 操作参数: cn.zup.bi.entity.BI_TOPIC_FIELD@64c11f16 ,', '2019-12-20 23:24:35', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('215', null, null, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldPagingList(BI_TOPIC_FIELD,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC_FIELD@6f33d3b8 ,1 ,10 ,', '2019-12-20 23:24:35', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('216', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@4f8730d7 ,pms_product ,', '2019-12-20 23:24:38', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('217', null, null, '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@4f8730d7 ,pms_product ,', '2019-12-20 23:24:38', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('218', null, null, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.TopicFieldServiceImpl.addTopicData(BI_TOPIC_FIELD); 操作参数: cn.zup.bi.entity.BI_TOPIC_FIELD@5d0d92a2 ,', '2019-12-20 23:24:56', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('219', null, null, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldPagingList(BI_TOPIC_FIELD,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC_FIELD@41147152 ,1 ,10 ,', '2019-12-20 23:24:56', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('220', null, null, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC_FIELD cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldData(Integer,Integer); 操作参数: 45 ,216 ,', '2019-12-20 23:24:59', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('221', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@62f05361 ,pms_product ,', '2019-12-20 23:24:59', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('222', null, null, '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@62f05361 ,pms_product ,', '2019-12-20 23:24:59', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('223', null, null, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.TopicFieldServiceImpl.updateTopicData(BI_TOPIC_FIELD); 操作参数: cn.zup.bi.entity.BI_TOPIC_FIELD@19cb7a1d ,', '2019-12-20 23:25:02', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('224', null, null, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldPagingList(BI_TOPIC_FIELD,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC_FIELD@495c9ea3 ,1 ,10 ,', '2019-12-20 23:25:02', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('225', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@52eb61d4 ,pms_product ,', '2019-12-20 23:25:05', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('226', null, null, '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@52eb61d4 ,pms_product ,', '2019-12-20 23:25:05', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('227', null, null, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.TopicFieldServiceImpl.addTopicData(BI_TOPIC_FIELD); 操作参数: cn.zup.bi.entity.BI_TOPIC_FIELD@65f3a4ee ,', '2019-12-20 23:25:19', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('228', null, null, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldPagingList(BI_TOPIC_FIELD,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC_FIELD@4bea9527 ,1 ,10 ,', '2019-12-20 23:25:19', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('229', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@241f1010 ,pms_product ,', '2019-12-20 23:25:22', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('230', null, null, '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@241f1010 ,pms_product ,', '2019-12-20 23:25:22', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('231', null, null, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.TopicFieldServiceImpl.addTopicData(BI_TOPIC_FIELD); 操作参数: cn.zup.bi.entity.BI_TOPIC_FIELD@4aa56fc6 ,', '2019-12-20 23:26:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('232', null, null, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldPagingList(BI_TOPIC_FIELD,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC_FIELD@5cc556be ,1 ,10 ,', '2019-12-20 23:26:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('233', null, null, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldPagingList(BI_TOPIC_FIELD,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC_FIELD@174af06a ,1 ,10 ,', '2019-12-20 23:26:39', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('234', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getBiDimName(); 操作参数: ', '2019-12-20 23:26:39', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('235', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@295804fc ,', '2019-12-20 23:26:39', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('236', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@70d218b6 ,', '2019-12-20 23:26:39', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('237', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@3d385048 ,', '2019-12-20 23:26:39', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('238', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@2ddc43d1 ,pms_product ,', '2019-12-20 23:26:41', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('239', null, null, '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@2ddc43d1 ,pms_product ,', '2019-12-20 23:26:41', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('240', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@6779bcf2 ,', '2019-12-20 23:27:01', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('241', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@6b43f8e0 ,', '2019-12-20 23:27:01', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('242', null, null, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIPageServiceImpl.getBIPageListPage(BI_Page,int,int); 操作参数: cn.zup.bi.entity.BI_Page@50aed75b ,1 ,10 ,', '2019-12-20 23:27:01', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('243', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1156 ,', '2019-12-20 23:27:01', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('244', null, null, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIPageServiceImpl.getBIPageListPage(BI_Page,int,int); 操作参数: cn.zup.bi.entity.BI_Page@6578e3a9 ,1 ,10 ,', '2019-12-20 23:29:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('245', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@12f3887a ,', '2019-12-20 23:29:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('246', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1156 ,', '2019-12-20 23:29:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('247', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@59cced50 ,', '2019-12-20 23:29:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('248', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1156 ,', '2019-12-20 23:31:17', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('249', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@ef41bc ,', '2019-12-20 23:31:17', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('250', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@51055ca3 ,', '2019-12-20 23:31:17', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('251', null, null, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIPageServiceImpl.getBIPageListPage(BI_Page,int,int); 操作参数: cn.zup.bi.entity.BI_Page@5b9aa94a ,1 ,10 ,', '2019-12-20 23:31:17', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('252', null, null, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.BIPageServiceImpl.updatePageInfo(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@5115614e ,', '2019-12-20 23:31:34', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('253', null, null, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIPageServiceImpl.getBIPageListPage(BI_Page,int,int); 操作参数: cn.zup.bi.entity.BI_Page@33adcb58 ,1 ,10 ,', '2019-12-20 23:31:34', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('254', null, null, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@22b6b10d ,', '2019-12-20 23:31:37', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('255', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@3a79d6c4 ,', '2019-12-20 23:31:37', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('256', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 0 ,0 ,null ,', '2019-12-20 23:31:39', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('257', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,0 ,', '2019-12-20 23:31:39', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('258', null, null, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT@5cda09 ,1 ,10 ,', '2019-12-20 23:31:44', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('259', null, null, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@2f12726b ,1 ,9999 ,', '2019-12-20 23:31:44', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('260', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@74527873 ,', '2019-12-20 23:31:44', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('261', null, null, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.ReportServiceImpl.saveReport(BI_REPORT); 操作参数: cn.zup.bi.entity.BI_REPORT@4df656cc ,', '2019-12-20 23:32:20', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('262', null, null, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT@136230c8 ,1 ,10 ,', '2019-12-20 23:32:20', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('263', null, null, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2019-12-20 23:32:24', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('264', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFields(Integer); 操作参数: 45 ,', '2019-12-20 23:32:24', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('265', null, null, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportFieldServiceImpl.getReportFieldList(BI_REPORT_FIELD,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT_FIELD@1beb2412 ,10 ,1 ,', '2019-12-20 23:32:24', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('266', null, null, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.ReportFieldServiceImpl.saveReportField(BI_REPORT_FIELD); 操作参数: cn.zup.bi.entity.BI_REPORT_FIELD@745c314a ,', '2019-12-20 23:32:31', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('267', null, null, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportFieldServiceImpl.getReportFieldList(BI_REPORT_FIELD,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT_FIELD@43eaf0f1 ,10 ,1 ,', '2019-12-20 23:32:31', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('268', null, null, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.ReportFieldServiceImpl.saveReportField(BI_REPORT_FIELD); 操作参数: cn.zup.bi.entity.BI_REPORT_FIELD@37fe12e ,', '2019-12-20 23:32:40', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('269', null, null, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportFieldServiceImpl.getReportFieldList(BI_REPORT_FIELD,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT_FIELD@5efc24fe ,10 ,1 ,', '2019-12-20 23:32:40', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('270', null, null, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.ReportFieldServiceImpl.saveReportField(BI_REPORT_FIELD); 操作参数: cn.zup.bi.entity.BI_REPORT_FIELD@47ce920f ,', '2019-12-20 23:32:50', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('271', null, null, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportFieldServiceImpl.getReportFieldList(BI_REPORT_FIELD,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT_FIELD@363e8fb0 ,10 ,1 ,', '2019-12-20 23:32:50', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('272', null, null, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@561ef277 ,', '2019-12-20 23:33:00', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('273', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@5153b241 ,', '2019-12-20 23:33:00', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('274', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 0 ,0 ,null ,', '2019-12-20 23:33:01', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('275', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,0 ,', '2019-12-20 23:33:01', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('276', null, null, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@1c426611 ,', '2019-12-20 23:33:18', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('277', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@7c88233e ,', '2019-12-20 23:33:18', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('278', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 0 ,0 ,null ,', '2019-12-20 23:33:19', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('279', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,0 ,', '2019-12-20 23:33:19', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('280', null, null, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@6340754f ,', '2019-12-20 23:33:35', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('281', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@4932578c ,', '2019-12-20 23:33:35', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('282', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 0 ,0 ,null ,', '2019-12-20 23:33:36', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('283', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,0 ,', '2019-12-20 23:33:36', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('284', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2019-12-20 23:34:51', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('285', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2019-12-20 23:34:51', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('286', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-20 23:34:51', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('287', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@7ee06f15 ,', '2019-12-20 23:34:51', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('288', '1', '1', '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-20 23:34:51', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('289', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2019-12-20 23:34:51', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('290', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2019-12-20 23:36:21', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('291', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@2c10a179 ,', '2019-12-20 23:36:22', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('292', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@163d06ad ,1 ,9999 ,', '2019-12-20 23:36:22', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('293', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT@1aa99b62 ,1 ,10 ,', '2019-12-20 23:36:22', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('294', '1', '1', '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2019-12-20 23:36:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('295', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2019-12-20 23:36:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('296', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2019-12-20 23:36:43', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('297', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@35e28f9a ,', '2019-12-20 23:36:46', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('298', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIScreenServiceImpl.getBIScreenListPage(BI_Screen,int,int); 操作参数: cn.zup.bi.entity.BI_Screen@36dc74a0 ,1 ,10 ,', '2019-12-20 23:36:46', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('300', '1', '1', '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.BIScreenServiceImpl.updateScreenInfo(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@31e5a3dc ,', '2019-12-20 23:36:54', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('301', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIScreenServiceImpl.getBIScreenListPage(BI_Screen,int,int); 操作参数: cn.zup.bi.entity.BI_Screen@61eda26c ,1 ,10 ,', '2019-12-20 23:36:54', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('303', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@440b1e32 ,', '2019-12-20 23:36:57', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('304', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@6f9f2c3a ,1 ,9999 ,', '2019-12-20 23:36:57', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('305', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT@257fe8e9 ,1 ,10 ,', '2019-12-20 23:36:57', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('306', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@24d189b0 ,', '2019-12-20 23:37:02', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('307', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@410cc9a0 ,', '2019-12-20 23:37:02', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('308', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2019-12-20 23:37:02', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('309', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,1 ,', '2019-12-20 23:37:02', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('310', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2019-12-20 23:37:04', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('311', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,1 ,', '2019-12-20 23:37:04', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('312', '1', '1', '', ' 操作层级: Service 层;  操作方法: Integer cn.zup.bi.service.impl.BIPageBlockServiceImpl.saveBlock(BI_Block_Info); 操作参数: cn.zup.bi.entity.BI_Block_Info@2189304d ,', '2019-12-20 23:37:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('313', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2019-12-20 23:37:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('314', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@1d4d97fa ,', '2019-12-20 23:37:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('315', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@1c279f52 ,', '2019-12-20 23:37:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('316', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2019-12-20 23:37:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('317', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@2e48db4d ,', '2019-12-20 23:37:17', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('318', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@4f222556 ,', '2019-12-20 23:37:17', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('319', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2019-12-20 23:37:17', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('320', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@1d1238f9 ,', '2019-12-20 23:37:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('321', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@1ee14003 ,', '2019-12-20 23:37:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('322', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2019-12-20 23:37:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('323', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@16ea7a4c ,', '2019-12-20 23:42:47', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('324', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@71cacf8e ,', '2019-12-20 23:42:47', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('325', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2019-12-20 23:42:47', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('326', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@5702256d ,', '2019-12-20 23:42:58', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('327', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@6a592c50 ,', '2019-12-20 23:42:58', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('328', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2019-12-20 23:42:58', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('329', null, null, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@7a8c8c40 ,', '2019-12-21 05:23:29', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('330', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@1ae310ab ,', '2019-12-21 05:23:30', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('331', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2019-12-21 05:23:31', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('332', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldList(Integer); 操作参数: 170 ,', '2019-12-21 05:23:31', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('333', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getDimFieldList(Integer,List,List); 操作参数: 170 ,[] ,[] ,', '2019-12-21 05:23:31', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('334', null, null, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2019-12-21 05:23:31', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('335', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,1 ,', '2019-12-21 05:23:31', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('336', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2020-01-04 15:19:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('337', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-01-04 15:19:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('338', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-01-04 15:19:12', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('339', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@3c41de48 ,', '2020-01-04 15:19:12', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('340', '1', '1', '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-01-04 15:19:12', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('341', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-01-04 15:19:12', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('342', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-04 15:21:45', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('343', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-04 15:21:45', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('344', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-04 15:21:46', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('345', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2020-01-04 16:52:32', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('346', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-01-04 16:52:32', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('347', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-01-04 16:52:32', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('348', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@45b340f1 ,', '2020-01-04 16:52:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('349', '1', '1', '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-01-04 16:52:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('350', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-01-04 16:52:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('351', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-04 16:52:35', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('352', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1156 ,', '2020-01-04 16:52:38', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('353', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@6b9b44d ,', '2020-01-04 16:52:38', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('354', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@1bd9cced ,', '2020-01-04 16:52:38', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('355', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIPageServiceImpl.getBIPageListPage(BI_Page,int,int); 操作参数: cn.zup.bi.entity.BI_Page@416d32a6 ,1 ,10 ,', '2020-01-04 16:52:38', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('356', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@4144377 ,1 ,10 ,', '2020-01-04 16:52:38', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('358', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-01-04 16:59:48', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('359', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2020-01-04 16:59:50', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('360', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@5632963d ,', '2020-01-04 16:59:50', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('361', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-01-04 16:59:51', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('362', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-01-04 16:59:51', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('363', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-01-04 16:59:51', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('364', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-01-04 16:59:51', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('365', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-01-04 16:59:51', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('366', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,5 ,true ,', '2020-01-04 16:59:52', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('367', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 5 ,', '2020-01-04 16:59:52', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('368', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 6 ,', '2020-01-04 16:59:52', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('369', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 7 ,', '2020-01-04 16:59:52', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('370', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 8 ,', '2020-01-04 16:59:52', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('371', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 9 ,', '2020-01-04 16:59:52', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('372', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 10 ,', '2020-01-04 16:59:52', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('374', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 6 ,', '2020-01-04 16:59:55', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('376', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 5 ,', '2020-01-04 17:00:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('377', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 5 ,', '2020-01-04 17:00:13', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('380', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@7941d503 ,', '2020-01-04 17:17:03', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('381', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@2f0d0c46 ,', '2020-01-04 17:17:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('382', '1', '1', '', ' 操作层级: Service 层;  操作方法: boolean cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuRepeatVerify(Integer,int,int,String); 操作参数: null ,1 ,5 ,数据源配置 ,', '2020-01-04 17:20:15', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('383', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@6e2ef4c1 ,', '2020-01-04 17:20:15', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('384', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.ResourceServiceImpl.addMenu(Menu); 操作参数: cn.zup.rbac.entity.Menu@24fa02af ,', '2020-01-04 17:20:15', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('385', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@282ad13e ,', '2020-01-04 17:20:15', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('386', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-01-04 17:20:15', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('387', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-01-04 17:20:15', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('388', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-01-04 17:20:15', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('389', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-01-04 17:20:15', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('390', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-01-04 17:20:15', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('391', '1', '1', '', ' 操作层级: Service 层;  操作方法: boolean cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuRepeatVerify(Integer,int,int,String); 操作参数: null ,1 ,0 ,32323 ,', '2020-01-04 17:21:36', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('392', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@5f9a0d63 ,', '2020-01-04 17:21:36', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('393', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@699bfe80 ,', '2020-01-04 17:21:36', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('394', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.ResourceServiceImpl.addMenu(Menu); 操作参数: cn.zup.rbac.entity.Menu@7f1ae564 ,', '2020-01-04 17:21:36', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('395', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@1ab9a8fe ,', '2020-01-04 17:21:36', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('396', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-01-04 17:21:36', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('397', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-01-04 17:21:36', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('398', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-01-04 17:21:36', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('399', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-01-04 17:21:36', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('400', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-01-04 17:21:36', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('401', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 12 ,', '2020-01-04 17:21:36', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('402', '1', '1', '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-01-04 17:23:14', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('403', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-01-04 17:23:14', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('404', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-04 17:23:15', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('405', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@11f63c60 ,1 ,10 ,', '2020-01-04 17:23:18', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('406', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1156 ,', '2020-01-04 17:23:18', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('407', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@526d052b ,', '2020-01-04 17:23:18', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('408', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@37ddede3 ,', '2020-01-04 17:23:18', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('409', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIPageServiceImpl.getBIPageListPage(BI_Page,int,int); 操作参数: cn.zup.bi.entity.BI_Page@2f0d0fea ,1 ,10 ,', '2020-01-04 17:23:18', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('410', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@63fe1b33 ,1 ,9999 ,', '2020-01-04 17:23:19', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('411', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@205e7f27 ,', '2020-01-04 17:23:19', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('412', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT@333d9287 ,1 ,10 ,', '2020-01-04 17:23:19', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('413', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@631ca039 ,', '2020-01-04 17:23:19', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('414', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIScreenServiceImpl.getBIScreenListPage(BI_Screen,int,int); 操作参数: cn.zup.bi.entity.BI_Screen@48019c32 ,1 ,10 ,', '2020-01-04 17:23:19', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('416', '1', '1', '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-01-04 17:24:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('417', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-01-04 17:24:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('418', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-04 17:24:08', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('419', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2020-01-04 17:27:54', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('420', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-01-04 17:27:55', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('421', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-01-04 17:27:55', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('422', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@727467de ,', '2020-01-04 17:27:55', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('423', '1', '1', '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-01-04 17:27:55', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('424', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-01-04 17:27:55', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('425', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-04 17:27:57', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('426', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@7d1dabbe ,', '2020-01-04 17:27:58', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('427', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@29a9bfe8 ,1 ,9999 ,', '2020-01-04 17:27:58', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('428', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT@475e5706 ,1 ,10 ,', '2020-01-04 17:27:58', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('429', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,f379eaf3c831b04de153469d1bec345e ,', '2020-01-06 08:37:22', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('430', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-01-06 08:37:22', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('431', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-01-06 08:37:22', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('432', null, null, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@14b4d572 ,', '2020-01-06 08:37:22', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('433', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,f379eaf3c831b04de153469d1bec345e ,', '2020-01-06 08:37:24', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('434', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-01-06 08:37:24', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('435', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-01-06 08:37:24', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('436', null, null, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@7bbbcd62 ,', '2020-01-06 08:37:24', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('437', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2020-01-06 08:37:37', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('438', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-01-06 08:37:37', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('439', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-01-06 08:37:37', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('440', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@17516bf7 ,', '2020-01-06 08:37:37', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('441', '1', '1', '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-01-06 08:37:37', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('442', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-01-06 08:37:38', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('443', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2020-01-06 08:37:40', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('444', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2020-01-06 08:37:49', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('445', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-06 08:37:51', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('446', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2020-01-06 08:37:56', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('447', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@79574ec8 ,', '2020-01-06 08:38:04', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('448', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@5ee3dd61 ,1 ,9999 ,', '2020-01-06 08:38:05', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('449', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT@4d8854c3 ,1 ,10 ,', '2020-01-06 08:38:05', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('450', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@1b9c9694 ,', '2020-01-06 08:38:12', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('451', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-01-06 08:41:16', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('452', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@3d9fb03d ,', '2020-01-06 08:41:16', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('453', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-01-06 08:41:21', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('454', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@236db109 ,', '2020-01-06 08:41:21', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('455', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@659a8c25 ,', '2020-01-06 08:42:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('456', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIScreenServiceImpl.getBIScreenListPage(BI_Screen,int,int); 操作参数: cn.zup.bi.entity.BI_Screen@4a991f4f ,1 ,10 ,', '2020-01-06 08:42:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('457', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@7d823809 ,', '2020-01-06 08:42:14', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('458', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT@6eecca0c ,1 ,10 ,', '2020-01-06 08:42:14', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('459', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@438fa813 ,1 ,9999 ,', '2020-01-06 08:42:14', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('460', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1156 ,', '2020-01-06 08:42:15', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('461', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIPageServiceImpl.getBIPageListPage(BI_Page,int,int); 操作参数: cn.zup.bi.entity.BI_Page@3d7df911 ,1 ,10 ,', '2020-01-06 08:42:15', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('462', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@125bdfac ,', '2020-01-06 08:42:16', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('463', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@11ac426c ,', '2020-01-06 08:42:16', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('464', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@7287b5de ,1 ,10 ,', '2020-01-06 08:42:17', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('465', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-01-06 08:42:32', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('466', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@5f0d910c ,', '2020-01-06 08:42:32', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('468', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@bb0a29e ,', '2020-01-06 08:42:46', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('469', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2020-01-06 08:42:52', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('470', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-06 08:42:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('472', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@46c7ee ,', '2020-01-06 08:47:30', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('473', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@d17f037 ,', '2020-01-06 08:47:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('474', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2020-01-06 08:47:56', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('475', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2020-01-06 08:47:58', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('476', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2020-01-06 08:48:04', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('477', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2020-01-06 08:52:17', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('478', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-06 08:52:18', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('479', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2020-01-06 08:52:20', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('480', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-06 08:52:21', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('481', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-01-06 08:52:22', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('482', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-06 08:52:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('483', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@1cee82a5 ,', '2020-01-06 08:53:09', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('484', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2020-01-06 08:53:56', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('485', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-06 08:53:57', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('486', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2020-01-06 08:54:52', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('487', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-06 08:54:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('488', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-01-06 08:54:54', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('489', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2020-01-06 08:54:55', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('490', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2020-01-06 08:54:56', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('491', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-01-06 08:54:57', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('492', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-06 08:54:58', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('493', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-01-06 08:54:59', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('494', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-06 08:55:02', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('495', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-01-06 08:55:03', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('496', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-06 08:55:05', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('497', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-01-06 08:59:13', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('498', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-06 08:59:14', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('499', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2020-01-06 08:59:26', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('500', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-06 08:59:45', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('501', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-01-06 08:59:46', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('502', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-06 08:59:50', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('503', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-01-06 08:59:54', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('504', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2020-01-06 08:59:56', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('505', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@7f97ab74 ,', '2020-01-06 08:59:56', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('506', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-01-06 08:59:56', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('507', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-01-06 08:59:56', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('508', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-01-06 08:59:56', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('509', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-01-06 08:59:56', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('510', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-01-06 08:59:56', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('511', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@3305b407 ,', '2020-01-06 09:00:01', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('512', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@37cfc018 ,', '2020-01-06 09:00:09', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('513', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-06 09:00:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('514', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-06 09:00:51', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('515', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-06 09:00:51', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('516', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2020-01-06 09:00:52', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('517', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2020-01-06 09:00:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('518', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2020-01-06 09:00:55', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('519', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-06 09:00:56', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('520', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-01-06 09:00:57', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('521', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-06 09:00:58', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('522', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-01-06 09:10:24', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('523', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-06 09:10:27', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('524', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@3e0cf02c ,', '2020-01-06 09:10:34', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('525', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@3c336320 ,', '2020-01-06 09:10:35', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('526', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-01-06 09:10:36', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('527', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-01-06 09:37:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('528', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@5144ce89 ,', '2020-01-06 09:37:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('529', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@60a22583 ,', '2020-01-06 09:37:10', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('530', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@152073cc ,', '2020-01-06 09:37:10', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('531', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportFieldServiceImpl.getReportFieldList(BI_REPORT_FIELD,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT_FIELD@5943ac68 ,10 ,1 ,', '2020-01-06 09:37:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('532', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-01-06 09:37:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('533', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFields(Integer); 操作参数: 45 ,', '2020-01-06 09:37:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('534', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@5a21b357 ,', '2020-01-06 09:49:54', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('535', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportFieldServiceImpl.getReportFieldList(BI_REPORT_FIELD,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT_FIELD@75baf6c2 ,10 ,1 ,', '2020-01-06 09:49:54', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('536', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-01-06 09:49:54', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('537', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFields(Integer); 操作参数: 45 ,', '2020-01-06 09:49:54', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('538', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@26a06bc ,', '2020-01-06 09:49:57', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('539', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@4caf8a30 ,', '2020-01-06 09:49:59', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('540', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@353907c ,', '2020-01-06 09:50:00', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('541', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@4a765b5 ,', '2020-01-06 09:50:03', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('542', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-01-06 09:52:16', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('543', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2020-01-06 09:52:17', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('544', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2020-01-06 09:52:18', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('545', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-06 09:52:18', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('546', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@210b5e61 ,', '2020-01-06 09:53:18', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('547', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@4d5dc468 ,', '2020-01-06 09:53:18', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('548', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-01-06 09:53:18', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('549', null, null, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@35773074 ,', '2020-01-06 13:49:50', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('550', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@4dc2d70c ,', '2020-01-06 13:49:50', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('551', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-01-06 13:49:50', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('552', null, null, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-01-06 13:50:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('553', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2020-01-29 16:11:47', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('554', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-01-29 16:11:47', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('555', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-01-29 16:11:47', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('556', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@74d0f0f4 ,', '2020-01-29 16:11:47', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('557', '1', '1', '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-01-29 16:11:47', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('558', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-01-29 16:11:48', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('559', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-29 16:11:55', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('560', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2020-01-29 16:11:55', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('561', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2020-01-29 16:11:56', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('562', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-29 16:11:57', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('563', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@17c7e475 ,', '2020-01-29 16:11:58', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('564', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIDatasourceServiceImpl.getDatasourcePagingList(BI_Datasource,int,int); 操作参数: cn.zup.bi.entity.BI_Datasource@199236f0 ,1 ,10 ,', '2020-01-29 16:11:58', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('565', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@373f2621 ,1 ,9999 ,', '2020-01-29 16:11:58', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('566', null, null, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIDimServiceImpl.getDimPagingList(BI_DIM,int,int); 操作参数: cn.zup.bi.entity.BI_DIM@69cfabde ,1 ,10 ,', '2020-01-29 17:39:44', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('567', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@28a93f39 ,', '2020-01-29 17:45:19', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('569', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@2522a4d3 ,', '2020-01-29 17:45:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('570', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@35db9099 ,', '2020-01-29 17:45:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('571', null, null, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIPageServiceImpl.getBIPageListPage(BI_Page,int,int); 操作参数: cn.zup.bi.entity.BI_Page@5d0a3263 ,1 ,10 ,', '2020-01-29 17:45:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('572', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(Integer,Menu); 操作参数: null ,cn.zup.rbac.entity.Menu@4c808d54 ,', '2020-01-29 17:45:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('573', null, null, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@7fb0e89d ,1 ,10 ,', '2020-01-29 17:47:13', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('574', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@6e323810 ,', '2020-01-29 17:49:52', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('575', null, null, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@3cf1c9f6 ,1 ,9999 ,', '2020-01-29 17:49:52', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('576', null, null, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT@16e7e349 ,1 ,10 ,', '2020-01-29 17:49:52', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('577', null, null, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@2986e200 ,1 ,9999 ,', '2020-01-29 17:55:35', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('578', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@2e6b30e6 ,', '2020-01-29 17:55:35', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('579', null, null, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT@5d01fd14 ,1 ,10 ,', '2020-01-29 17:55:35', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('580', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,f379eaf3c831b04de153469d1bec345e ,', '2020-02-10 17:12:34', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('581', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-02-10 17:12:34', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('582', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-02-10 17:12:34', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('583', null, null, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@e391397 ,', '2020-02-10 17:12:34', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('584', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,f379eaf3c831b04de153469d1bec345e ,', '2020-02-10 17:12:38', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('585', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-02-10 17:12:38', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('586', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-02-10 17:12:38', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('587', null, null, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@5cf74604 ,', '2020-02-10 17:12:38', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('588', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2020-02-10 17:12:46', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('589', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-02-10 17:12:46', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('590', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-02-10 17:12:46', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('591', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@6ed092ce ,', '2020-02-10 17:12:46', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('592', '1', '1', '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-02-10 17:12:46', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('593', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-02-10 17:12:47', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('594', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-02-10 17:12:51', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('596', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDatasourceServiceImpl.getDatasourcePagingList(BI_Datasource,int,int); 操作参数: cn.zup.bi.entity.BI_Datasource@228f2ef8 ,1 ,10 ,', '2020-02-10 17:12:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('600', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@78df74f5 ,', '2020-02-10 17:12:59', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('601', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@1bf49c8f ,', '2020-02-10 17:12:59', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('602', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(Integer,Menu); 操作参数: 1 ,cn.zup.rbac.entity.Menu@29ab2875 ,', '2020-02-10 17:12:59', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('605', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-02-10 17:27:27', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('606', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2020-02-10 17:27:29', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('607', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@64db214f ,', '2020-02-10 17:27:29', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('608', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-02-10 17:27:29', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('609', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-02-10 17:27:29', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('610', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-02-10 17:27:29', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('611', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-02-10 17:27:29', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('612', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-02-10 17:27:29', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('613', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2020-02-10 17:27:30', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('614', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-02-10 17:27:30', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('615', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-02-10 17:27:30', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('616', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-02-10 17:27:30', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('617', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-02-10 17:27:30', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('618', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@4c3acc20 ,1 ,10 ,', '2020-02-10 17:27:30', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('619', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@10c99a98 ,1 ,10 ,', '2020-02-10 17:27:30', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('620', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-02-10 17:27:31', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('621', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2020-02-10 17:27:34', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('622', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2020-02-10 17:27:34', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('623', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-02-10 17:27:35', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('624', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@68bdded8 ,', '2020-02-10 17:28:08', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('626', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@551e4d28 ,', '2020-02-10 17:28:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('627', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@5ed10ed6 ,', '2020-02-10 17:28:13', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('628', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-02-10 17:32:20', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('629', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-02-10 17:32:21', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('631', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2020-02-10 18:17:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('632', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-02-10 18:17:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('633', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-02-10 18:17:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('634', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@1c2b3d99 ,', '2020-02-10 18:17:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('635', '1', '1', '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-02-10 18:17:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('636', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-02-10 18:17:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('637', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2020-02-10 18:25:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('638', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-02-10 18:25:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('639', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-02-10 18:25:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('640', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@44cf8743 ,', '2020-02-10 18:25:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('641', '1', '1', '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-02-10 18:25:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('642', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-02-10 18:25:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('643', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2020-02-10 19:58:41', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('644', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-02-10 19:58:41', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('645', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-02-10 19:58:41', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('646', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@3e5957ca ,', '2020-02-10 19:58:41', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('647', '1', '1', '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-02-10 19:58:57', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('648', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-02-10 19:58:57', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('649', '1', '1', '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-02-10 19:58:57', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('650', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-02-10 19:58:57', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('651', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-02-10 19:59:01', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('653', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDatasourceServiceImpl.getDatasourcePagingList(BI_Datasource,int,int); 操作参数: cn.zup.bi.entity.BI_Datasource@772e5176 ,1 ,10 ,', '2020-02-10 19:59:14', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('656', '1', '1', '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-02-10 20:04:56', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('657', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-02-10 20:04:56', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('658', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2020-02-10 21:12:52', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('659', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-02-10 21:12:52', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('660', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-02-10 21:12:52', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('661', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@721feae0 ,', '2020-02-10 21:12:52', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('662', '1', '1', '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-02-10 21:12:52', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('663', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-02-10 21:12:52', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('664', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-02-10 21:13:02', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('666', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDatasourceServiceImpl.getDatasourcePagingList(BI_Datasource,int,int); 操作参数: cn.zup.bi.entity.BI_Datasource@191627d9 ,1 ,10 ,', '2020-02-10 21:13:03', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('667', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2020-02-14 20:02:29', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('668', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-02-14 20:02:29', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('669', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-02-14 20:02:29', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('670', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@101fa02f ,', '2020-02-14 20:02:29', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('671', '1', '1', '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-02-14 20:02:29', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('672', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-02-14 20:02:29', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('673', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2020-02-14 20:02:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('674', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-02-14 20:02:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('675', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC); 操作参数: BI_TOPIC(topic_Id=null, topic_Name=null, topic_Caption=null, topic_Type=null, biz_Table_Name=null, ds_id=null) ,', '2020-02-14 20:02:35', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('676', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-02-14 20:02:35', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('677', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getDimPagingList(BI_DIM); 操作参数: BI_DIM(dim_Id=null, dim_Name=null, biz_Table_Name=null, text_Field=null, id_Field=null, drill_Type=null, drill_Info=null, ds_Id=null) ,', '2020-02-14 20:02:37', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('678', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC); 操作参数: BI_TOPIC(topic_Id=null, topic_Name=null, topic_Caption=null, topic_Type=null, biz_Table_Name=null, ds_id=null) ,', '2020-02-14 20:02:39', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('679', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(Integer,Menu); 操作参数: 1 ,cn.zup.rbac.entity.Menu@29908533 ,', '2020-02-14 20:02:41', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('680', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@6b659b3b ,', '2020-02-14 20:02:41', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('681', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@30f0e9ef ,', '2020-02-14 20:02:41', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('682', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC); 操作参数: BI_TOPIC(topic_Id=null, topic_Name=null, topic_Caption=null, topic_Type=null, biz_Table_Name=null, ds_id=null) ,', '2020-02-14 20:02:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('683', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-02-14 20:02:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('684', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT); 操作参数: BI_REPORT(report_Id=null, topic_Id=null, report_Name=null, page_Id=null, report_Title=null, create_Date=null, topic_Name=null, page_Name=null) ,', '2020-02-14 20:02:43', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('685', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-02-14 20:02:44', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('686', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBIScreenListPage(BI_Screen,int,int); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=null, page_Name=null) ,1 ,10 ,', '2020-02-14 20:02:44', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('687', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getTableNameList(Connection); 操作参数: com.mysql.jdbc.JDBC4Connection@49ad1e1b ,', '2020-02-14 20:02:52', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('688', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@95274da ,', '2020-02-14 20:03:03', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('689', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getTableNameList(Connection); 操作参数: com.mysql.jdbc.JDBC4Connection@d0c0321 ,', '2020-02-14 20:03:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('690', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@63f87456 ,', '2020-02-14 20:03:46', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('691', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getTableNameList(Connection); 操作参数: com.mysql.jdbc.JDBC4Connection@6765b4f6 ,', '2020-02-14 20:20:38', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('692', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getTableNameList(Connection); 操作参数: com.mysql.jdbc.JDBC4Connection@2847903a ,', '2020-02-14 20:20:38', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('693', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@38ecfaa9 ,', '2020-02-14 20:21:00', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('694', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getTableNameList(Connection); 操作参数: com.mysql.jdbc.JDBC4Connection@4b545b24 ,', '2020-02-14 20:21:03', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('695', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getTableNameList(Connection); 操作参数: com.mysql.jdbc.JDBC4Connection@18a58075 ,', '2020-02-14 20:26:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('696', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getTableNameList(Connection); 操作参数: com.mysql.jdbc.JDBC4Connection@2a194e31 ,', '2020-02-14 20:31:00', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('697', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,f379eaf3c831b04de153469d1bec345e ,', '2020-02-18 14:15:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('698', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-02-18 14:15:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('699', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-02-18 14:15:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('700', null, null, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@2fb940d4 ,', '2020-02-18 14:15:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('701', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,f379eaf3c831b04de153469d1bec345e ,', '2020-02-18 14:15:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('702', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-02-18 14:15:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('703', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-02-18 14:15:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('704', null, null, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@28086512 ,', '2020-02-18 14:15:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('705', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2020-02-18 14:15:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('706', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-02-18 14:15:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('707', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-02-18 14:15:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('708', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@27b038d1 ,', '2020-02-18 14:15:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('709', '1', '1', '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-02-18 14:15:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('710', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-02-18 14:15:34', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('711', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-02-18 14:15:38', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('712', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-02-18 14:15:41', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('713', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2020-02-18 14:15:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('714', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2020-02-18 14:15:43', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('715', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-02-18 14:16:03', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('716', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2020-02-18 14:16:05', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('717', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@461c65fc ,', '2020-02-18 14:16:05', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('718', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-02-18 14:16:05', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('719', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-02-18 14:16:05', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('720', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-02-18 14:16:05', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('721', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-02-18 14:16:05', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('722', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-02-18 14:16:05', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('723', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 5 ,', '2020-02-18 14:16:09', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('724', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-02-18 14:16:10', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('726', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDatasourceServiceImpl.getDatasourcePagingList(BI_Datasource,int,int); 操作参数: cn.zup.bi.entity.BI_Datasource@3a311f9a ,1 ,10 ,', '2020-02-18 14:16:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('729', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@110cfe14 ,', '2020-02-18 14:16:19', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('730', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@268d28df ,', '2020-02-18 14:16:19', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('731', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(Integer,Menu); 操作参数: 1 ,cn.zup.rbac.entity.Menu@6b09f0c5 ,', '2020-02-18 14:16:19', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('732', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-02-18 14:16:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('733', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2020-02-18 14:16:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('734', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-02-18 14:16:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('735', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-02-18 14:16:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('736', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-02-18 14:16:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('737', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-02-18 14:16:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('738', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@510ca113 ,1 ,10 ,', '2020-02-18 14:16:26', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('739', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@3b98a10 ,1 ,10 ,', '2020-02-18 14:16:26', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('740', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 2 ,', '2020-02-18 14:16:30', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('741', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 1 ,', '2020-02-18 14:16:30', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('742', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-02-18 14:16:36', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('743', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-02-18 14:16:36', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('744', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2020-03-16 16:15:36', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('745', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-03-16 16:15:36', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('746', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-03-16 16:15:37', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('747', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@43e56f7a ,', '2020-03-16 16:15:37', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('748', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-03-16 16:15:37', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('749', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-03-16 16:15:39', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('751', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC); 操作参数: BI_TOPIC(topic_Id=null, topic_Name=null, topic_Caption=null, topic_Type=null, biz_Table_Name=null, ds_id=null) ,', '2020-03-16 16:15:48', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('753', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2020-03-16 16:35:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('754', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-03-16 16:35:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('755', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-03-16 16:35:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('756', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@33188bd6 ,', '2020-03-16 16:35:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('757', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-03-16 16:35:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('758', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-03-16 16:35:17', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('759', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getTableNameList(Connection); 操作参数: com.mysql.jdbc.JDBC4Connection@7f43fdba ,', '2020-03-16 16:35:27', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('760', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@72cfebd1 ,pms_bra1nd ,', '2020-03-16 16:35:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('761', '1', '1', '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@72cfebd1 ,pms_bra1nd ,', '2020-03-16 16:35:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('762', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getTableNameList(Connection); 操作参数: com.mysql.jdbc.JDBC4Connection@2cacd6cc ,', '2020-03-16 16:37:46', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('763', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@d6f1e29 ,pms_bra1nd ,', '2020-03-16 16:37:46', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('764', '1', '1', '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@d6f1e29 ,pms_bra1nd ,', '2020-03-16 16:37:46', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('765', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getTableNameList(Connection); 操作参数: com.mysql.jdbc.JDBC4Connection@3cea1ba2 ,', '2020-03-16 16:39:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('766', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getDimPagingList(BI_DIM); 操作参数: BI_DIM(dim_Id=null, dim_Name=null, biz_Table_Name=null, text_Field=null, id_Field=null, drill_Type=null, drill_Info=null, ds_Id=null, ds_name=null) ,', '2020-03-16 16:39:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('767', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@74f354d7 ,pms_bra1nd ,', '2020-03-16 16:39:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('768', null, null, '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@74f354d7 ,pms_bra1nd ,', '2020-03-16 16:39:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('769', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC); 操作参数: BI_TOPIC(topic_Id=null, topic_Name=null, topic_Caption=null, topic_Type=null, biz_Table_Name=null, ds_id=null) ,', '2020-03-16 16:39:10', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('770', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getMenuList(Integer); 操作参数: null ,', '2020-03-16 16:39:20', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('771', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@2711596a ,', '2020-03-16 16:39:20', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('772', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@1ee543f ,', '2020-03-16 16:39:20', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('773', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 16:39:50', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('774', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBIScreenListPage(BI_Screen,int,int); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=29, page_Name=null) ,1 ,10 ,', '2020-03-16 16:39:50', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('775', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC); 操作参数: BI_TOPIC(topic_Id=null, topic_Name=null, topic_Caption=null, topic_Type=null, biz_Table_Name=null, ds_id=null) ,', '2020-03-16 16:40:16', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('776', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 16:40:16', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('777', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT); 操作参数: BI_REPORT(report_Id=null, topic_Id=null, report_Name=null, page_Id=29, report_Title=null, create_Date=null, topic_Name=null, page_Name=null) ,', '2020-03-16 16:40:16', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('778', null, null, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-03-16 16:40:21', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('779', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFields(Integer); 操作参数: 45 ,', '2020-03-16 16:40:21', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('780', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT); 操作参数: BI_REPORT(report_Id=null, topic_Id=null, report_Name=null, page_Id=null, report_Title=null, create_Date=null, topic_Name=null, page_Name=null) ,', '2020-03-16 16:41:02', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('781', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 16:41:02', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('782', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC); 操作参数: BI_TOPIC(topic_Id=null, topic_Name=null, topic_Caption=null, topic_Type=null, biz_Table_Name=null, ds_id=null) ,', '2020-03-16 16:41:02', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('783', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 16:42:03', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('784', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBIScreenListPage(BI_Screen,int,int); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=null, page_Name=null) ,1 ,10 ,', '2020-03-16 16:42:03', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('785', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@6f14f524 ,', '2020-03-16 16:45:10', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('786', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@3eade7c2 ,', '2020-03-16 16:45:10', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('787', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getMenuList(Integer); 操作参数: null ,', '2020-03-16 16:45:10', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('788', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC); 操作参数: BI_TOPIC(topic_Id=null, topic_Name=null, topic_Caption=null, topic_Type=null, biz_Table_Name=null, ds_id=null) ,', '2020-03-16 16:45:12', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('789', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT); 操作参数: BI_REPORT(report_Id=null, topic_Id=null, report_Name=null, page_Id=null, report_Title=null, create_Date=null, topic_Name=null, page_Name=null) ,', '2020-03-16 16:45:12', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('790', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 16:45:12', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('791', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 16:45:20', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('792', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBIScreenListPage(BI_Screen,int,int); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=null, page_Name=null) ,1 ,10 ,', '2020-03-16 16:45:20', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('793', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2020-03-16 16:50:37', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('794', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-03-16 16:50:37', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('795', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-03-16 16:50:37', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('796', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@2602cb53 ,', '2020-03-16 16:50:37', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('797', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-03-16 16:50:37', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('798', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-03-16 16:50:39', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('799', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2020-03-16 16:50:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('800', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@5cfe2e1a ,', '2020-03-16 16:50:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('801', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-03-16 16:50:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('802', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-03-16 16:50:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('803', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-03-16 16:50:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('804', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-03-16 16:50:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('805', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-03-16 16:50:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('806', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2020-03-16 16:50:45', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('807', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-03-16 16:50:45', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('808', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-03-16 16:50:45', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('809', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@368e67c8 ,1 ,10 ,', '2020-03-16 16:50:45', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('810', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-03-16 16:50:45', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('811', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-03-16 16:50:45', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('812', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@ad9cec7 ,1 ,10 ,', '2020-03-16 16:50:45', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('813', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 5 ,', '2020-03-16 16:50:49', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('814', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,5 ,true ,', '2020-03-16 16:50:49', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('815', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 11 ,', '2020-03-16 16:50:49', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('816', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 6 ,', '2020-03-16 16:50:49', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('817', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 7 ,', '2020-03-16 16:50:49', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('818', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 8 ,', '2020-03-16 16:50:49', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('819', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 9 ,', '2020-03-16 16:50:49', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('820', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 10 ,', '2020-03-16 16:50:49', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('821', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 2 ,', '2020-03-16 16:50:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('822', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,2 ,true ,', '2020-03-16 16:50:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('823', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 3 ,', '2020-03-16 16:50:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('824', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 4 ,', '2020-03-16 16:50:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('825', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 10 ,', '2020-03-16 16:50:56', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('826', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 9 ,', '2020-03-16 16:50:59', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('827', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 9 ,', '2020-03-16 16:51:02', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('828', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@49a5eeca ,', '2020-03-16 16:51:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('829', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.ResourceServiceImpl.deleteMenu(Menu); 操作参数: cn.zup.rbac.entity.Menu@1a4c10a1 ,', '2020-03-16 16:51:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('830', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@7d2dfc09 ,', '2020-03-16 16:51:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('831', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@1c1b8918 ,', '2020-03-16 16:51:08', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('832', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-03-16 16:51:08', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('833', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-03-16 16:51:08', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('834', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-03-16 16:51:08', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('835', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-03-16 16:51:08', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('836', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-03-16 16:51:08', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('837', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 5 ,', '2020-03-16 16:51:10', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('838', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,5 ,true ,', '2020-03-16 16:51:10', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('839', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 11 ,', '2020-03-16 16:51:10', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('840', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 6 ,', '2020-03-16 16:51:10', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('841', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 7 ,', '2020-03-16 16:51:10', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('842', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 8 ,', '2020-03-16 16:51:10', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('843', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 10 ,', '2020-03-16 16:51:10', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('844', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 10 ,', '2020-03-16 16:51:12', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('845', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@7577b045 ,', '2020-03-16 16:51:14', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('846', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.ResourceServiceImpl.deleteMenu(Menu); 操作参数: cn.zup.rbac.entity.Menu@1caf0979 ,', '2020-03-16 16:51:15', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('847', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@17e85512 ,', '2020-03-16 16:51:15', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('848', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@5e46ce30 ,', '2020-03-16 16:51:15', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('849', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-03-16 16:51:15', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('850', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-03-16 16:51:15', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('851', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-03-16 16:51:15', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('852', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-03-16 16:51:15', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('853', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-03-16 16:51:15', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('854', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 5 ,', '2020-03-16 16:51:17', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('855', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,5 ,true ,', '2020-03-16 16:51:17', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('856', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 11 ,', '2020-03-16 16:51:17', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('857', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 6 ,', '2020-03-16 16:51:17', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('858', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 7 ,', '2020-03-16 16:51:17', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('859', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 8 ,', '2020-03-16 16:51:17', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('860', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 11 ,', '2020-03-16 16:51:20', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('861', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@58eefd61 ,', '2020-03-16 16:51:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('862', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@47c87a8f ,', '2020-03-16 16:51:27', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('863', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-03-16 17:46:09', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('864', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2020-03-16 17:46:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('865', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@6827236b ,', '2020-03-16 17:46:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('866', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-03-16 17:46:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('867', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-03-16 17:46:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('868', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-03-16 17:46:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('869', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-03-16 17:46:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('870', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-03-16 17:46:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('871', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 1 ,', '2020-03-16 17:46:13', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('872', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-03-16 17:46:16', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('873', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@720585ad ,', '2020-03-16 17:46:20', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('874', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 5 ,', '2020-03-16 17:46:32', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('875', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,5 ,true ,', '2020-03-16 17:46:32', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('876', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 11 ,', '2020-03-16 17:46:32', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('877', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 6 ,', '2020-03-16 17:46:32', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('878', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 7 ,', '2020-03-16 17:46:32', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('879', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 8 ,', '2020-03-16 17:46:32', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('880', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 5 ,', '2020-03-16 17:46:34', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('881', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 11 ,', '2020-03-16 17:46:37', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('882', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@699f144a ,', '2020-03-16 17:46:39', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('883', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.ResourceServiceImpl.deleteMenu(Menu); 操作参数: cn.zup.rbac.entity.Menu@7714bed ,', '2020-03-16 17:46:41', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('884', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@6b38e2b9 ,', '2020-03-16 17:46:41', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('885', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@76f73d ,', '2020-03-16 17:46:41', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('886', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-03-16 17:46:41', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('887', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-03-16 17:46:41', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('888', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-03-16 17:46:41', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('889', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-03-16 17:46:41', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('890', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-03-16 17:46:41', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('891', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,5 ,true ,', '2020-03-16 17:46:43', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('892', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 5 ,', '2020-03-16 17:46:43', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('893', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 6 ,', '2020-03-16 17:46:43', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('894', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 7 ,', '2020-03-16 17:46:43', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('895', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 8 ,', '2020-03-16 17:46:43', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('896', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 1 ,', '2020-03-16 17:46:48', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('897', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 8 ,', '2020-03-16 17:46:56', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('898', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 7 ,', '2020-03-16 17:46:57', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('899', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 6 ,', '2020-03-16 17:46:58', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('900', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-03-16 17:47:01', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('901', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 2 ,', '2020-03-16 17:47:02', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('902', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,2 ,true ,', '2020-03-16 17:47:02', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('903', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 3 ,', '2020-03-16 17:47:02', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('904', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 4 ,', '2020-03-16 17:47:02', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('905', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 4 ,', '2020-03-16 17:47:05', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('906', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 3 ,', '2020-03-16 17:47:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('907', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 5 ,', '2020-03-16 17:47:21', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('908', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 5 ,', '2020-03-16 17:47:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('909', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@1baf21c7 ,', '2020-03-16 17:47:29', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('910', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-03-16 17:47:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('911', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-03-16 17:47:56', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('912', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@42c70c9f ,', '2020-03-16 17:47:56', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('913', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@5d7f1fe4 ,', '2020-03-16 17:48:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('914', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@7adc1556 ,', '2020-03-16 17:48:09', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('915', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@1d8150e0 ,', '2020-03-16 17:48:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('916', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 5 ,', '2020-03-16 17:48:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('917', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@1d9311a ,', '2020-03-16 17:48:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('918', '1', '1', '', ' 操作层级: Service 层;  操作方法: boolean cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuRepeatVerify(Integer,int,int,String); 操作参数: null ,1 ,5 ,数据展示 ,', '2020-03-16 17:48:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('919', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.ResourceServiceImpl.addMenu(Menu); 操作参数: cn.zup.rbac.entity.Menu@5e6e6048 ,', '2020-03-16 17:48:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('920', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@65d926d0 ,', '2020-03-16 17:48:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('921', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@5b12cc8b ,', '2020-03-16 17:48:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('922', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-03-16 17:48:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('923', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-03-16 17:48:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('924', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-03-16 17:48:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('925', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-03-16 17:48:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('926', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-03-16 17:48:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('927', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,5 ,true ,', '2020-03-16 17:48:44', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('928', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 5 ,', '2020-03-16 17:48:44', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('929', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 6 ,', '2020-03-16 17:48:44', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('930', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 7 ,', '2020-03-16 17:48:44', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('931', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 8 ,', '2020-03-16 17:48:44', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('932', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 12 ,', '2020-03-16 17:48:44', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('933', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 12 ,', '2020-03-16 17:48:46', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('934', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2020-03-16 17:48:50', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('935', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@6ba05166 ,1 ,10 ,', '2020-03-16 17:48:50', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('936', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-03-16 17:48:50', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('937', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-03-16 17:48:50', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('938', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-03-16 17:48:50', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('939', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-03-16 17:48:50', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('940', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@1b2e8a71 ,1 ,10 ,', '2020-03-16 17:48:50', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('941', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,5 ,true ,', '2020-03-16 17:48:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('942', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 6 ,', '2020-03-16 17:48:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('943', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 7 ,', '2020-03-16 17:48:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('944', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 8 ,', '2020-03-16 17:48:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('945', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 12 ,', '2020-03-16 17:48:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('946', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@3a2bed7f ,1 ,10 ,', '2020-03-16 17:48:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('947', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,2 ,true ,', '2020-03-16 17:48:54', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('948', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 3 ,', '2020-03-16 17:48:54', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('949', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 4 ,', '2020-03-16 17:48:54', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('950', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@1f2abc3c ,1 ,10 ,', '2020-03-16 17:48:54', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('951', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@65e1af28 ,1 ,10 ,', '2020-03-16 17:49:00', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('952', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@33d2a98 ,1 ,10 ,', '2020-03-16 17:49:01', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('953', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-03-16 17:49:03', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('954', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-03-16 17:49:05', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('955', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-03-16 17:49:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('956', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getMenuList(Integer); 操作参数: 1 ,', '2020-03-16 17:49:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('957', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@6ee5b550 ,', '2020-03-16 17:49:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('958', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@252ad1e3 ,', '2020-03-16 17:49:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('959', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-03-16 17:49:09', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('960', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-03-16 17:49:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('961', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getDimPagingList(BI_DIM); 操作参数: BI_DIM(dim_Id=null, dim_Name=null, biz_Table_Name=null, text_Field=null, id_Field=null, drill_Type=null, drill_Info=null, ds_Id=null, ds_name=null) ,', '2020-03-16 17:49:12', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('962', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getTableNameList(Connection); 操作参数: com.mysql.jdbc.JDBC4Connection@69e62959 ,', '2020-03-16 17:49:12', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('963', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@4256626a ,pms_bra1nd ,', '2020-03-16 17:49:12', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('964', '1', '1', '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@4256626a ,pms_bra1nd ,', '2020-03-16 17:49:12', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('965', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC); 操作参数: BI_TOPIC(topic_Id=null, topic_Name=null, topic_Caption=null, topic_Type=null, biz_Table_Name=null, ds_id=null) ,', '2020-03-16 17:49:13', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('966', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-03-16 17:59:20', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('967', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2020-03-16 17:59:21', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('968', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@577720ca ,1 ,10 ,', '2020-03-16 17:59:21', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('969', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-03-16 17:59:21', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('970', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-03-16 17:59:21', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('971', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-03-16 17:59:21', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('972', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-03-16 17:59:21', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('973', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@18ea7bbf ,1 ,10 ,', '2020-03-16 17:59:21', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('974', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@5d487777 ,1 ,10 ,', '2020-03-16 17:59:31', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('975', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,2 ,true ,', '2020-03-16 17:59:32', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('976', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 3 ,', '2020-03-16 17:59:32', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('977', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 4 ,', '2020-03-16 17:59:32', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('978', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@4431bfea ,1 ,10 ,', '2020-03-16 17:59:32', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('979', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 2 ,', '2020-03-16 18:24:21', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('980', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,2 ,true ,', '2020-03-16 18:24:21', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('981', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 3 ,', '2020-03-16 18:24:21', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('982', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 4 ,', '2020-03-16 18:24:21', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('983', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@1f4d187a ,', '2020-03-16 18:24:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('984', '1', '1', '', ' 操作层级: Service 层;  操作方法: boolean cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuRepeatVerify(Integer,int,int,String); 操作参数: null ,1 ,2 ,权限管理 ,', '2020-03-16 18:24:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('985', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.ResourceServiceImpl.addMenu(Menu); 操作参数: cn.zup.rbac.entity.Menu@619293e2 ,', '2020-03-16 18:24:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('986', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@6e4fbfaf ,', '2020-03-16 18:24:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('987', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@62392da5 ,', '2020-03-16 18:24:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('988', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-03-16 18:24:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('989', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-03-16 18:24:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('990', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-03-16 18:24:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('991', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-03-16 18:24:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('992', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-03-16 18:24:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('993', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-03-16 18:24:36', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('994', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2020-03-16 18:24:40', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('995', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-03-16 18:24:43', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('996', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2020-03-16 18:24:45', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('997', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-03-16 18:24:47', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('998', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2020-03-16 18:25:00', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('999', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-03-16 18:25:00', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1000', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-03-16 18:25:00', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1001', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@7422fe6 ,', '2020-03-16 18:25:00', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1002', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-03-16 18:25:00', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1003', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-03-16 18:25:02', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1004', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2020-03-16 18:25:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1005', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@50c13e59 ,', '2020-03-16 18:25:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1006', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-03-16 18:25:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1007', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-03-16 18:25:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1008', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-03-16 18:25:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1009', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-03-16 18:25:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1010', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-03-16 18:25:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1011', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,2 ,true ,', '2020-03-16 18:25:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1012', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 2 ,', '2020-03-16 18:25:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1013', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 3 ,', '2020-03-16 18:25:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1014', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 4 ,', '2020-03-16 18:25:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1015', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 13 ,', '2020-03-16 18:25:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1016', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 2 ,', '2020-03-16 18:25:10', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1017', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 13 ,', '2020-03-16 18:25:12', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1018', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 4 ,', '2020-03-16 18:25:18', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1019', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 13 ,', '2020-03-16 18:25:19', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1020', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 3 ,', '2020-03-16 18:25:20', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1021', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 13 ,', '2020-03-16 18:25:21', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1022', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@63895584 ,', '2020-03-16 18:25:22', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1023', '1', '1', '', ' 操作层级: Service 层;  操作方法: boolean cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuRepeatVerify(Integer,int,int,String); 操作参数: 13 ,1 ,2 ,权限管理 ,', '2020-03-16 18:25:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1024', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.ResourceServiceImpl.updateMenu(Menu); 操作参数: cn.zup.rbac.entity.Menu@4a8b70c4 ,', '2020-03-16 18:25:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1025', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@4c1129f4 ,', '2020-03-16 18:25:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1026', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@48fc1cdc ,', '2020-03-16 18:25:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1027', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-03-16 18:25:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1028', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-03-16 18:25:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1029', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-03-16 18:25:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1030', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-03-16 18:25:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1031', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-03-16 18:25:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1032', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-03-16 18:25:30', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1033', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-03-16 18:25:32', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1034', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2020-03-16 18:25:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1035', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@38da13dc ,1 ,10 ,', '2020-03-16 18:25:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1036', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-03-16 18:25:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1037', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-03-16 18:25:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1038', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-03-16 18:25:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1039', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-03-16 18:25:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1040', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@16efc9a6 ,1 ,10 ,', '2020-03-16 18:25:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1041', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2020-03-16 18:28:17', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1042', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@4b5f260f ,', '2020-03-16 18:28:17', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1043', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-03-16 18:28:17', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1044', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-03-16 18:28:17', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1045', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-03-16 18:28:17', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1046', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-03-16 18:28:17', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1047', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-03-16 18:28:17', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1048', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 5 ,', '2020-03-16 18:28:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1049', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,5 ,true ,', '2020-03-16 18:28:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1050', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 6 ,', '2020-03-16 18:28:26', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1051', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 7 ,', '2020-03-16 18:28:26', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1052', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 8 ,', '2020-03-16 18:28:26', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1053', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 12 ,', '2020-03-16 18:28:26', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1054', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,2 ,true ,', '2020-03-16 18:28:27', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1055', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 2 ,', '2020-03-16 18:28:27', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1056', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 3 ,', '2020-03-16 18:28:27', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1057', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 4 ,', '2020-03-16 18:28:27', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1058', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 13 ,', '2020-03-16 18:28:27', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1059', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 3 ,', '2020-03-16 18:28:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1060', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 4 ,', '2020-03-16 18:28:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1061', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 13 ,', '2020-03-16 18:28:30', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1062', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 4 ,', '2020-03-16 18:28:34', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1063', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 3 ,', '2020-03-16 18:28:41', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1064', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 13 ,', '2020-03-16 18:28:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1065', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 4 ,', '2020-03-16 18:28:43', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1066', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@10c8be38 ,', '2020-03-16 18:28:45', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1067', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 13 ,', '2020-03-16 18:28:50', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1068', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@52e0c539 ,', '2020-03-16 18:28:51', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1069', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@259cf493 ,', '2020-03-16 18:28:55', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1070', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 3 ,', '2020-03-16 18:28:56', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1071', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 4 ,', '2020-03-16 18:28:57', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1072', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@7a12f1a7 ,', '2020-03-16 18:28:59', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1073', '1', '1', '', ' 操作层级: Service 层;  操作方法: boolean cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuRepeatVerify(Integer,int,int,String); 操作参数: 4 ,1 ,2 ,操作项管理 ,', '2020-03-16 18:29:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1074', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.ResourceServiceImpl.updateMenu(Menu); 操作参数: cn.zup.rbac.entity.Menu@d09e321 ,', '2020-03-16 18:29:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1075', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@468c3696 ,', '2020-03-16 18:29:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1076', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@36f73e82 ,', '2020-03-16 18:29:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1077', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-03-16 18:29:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1078', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-03-16 18:29:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1079', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-03-16 18:29:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1080', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-03-16 18:29:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1081', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-03-16 18:29:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1082', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2020-03-16 18:29:14', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1083', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@31f69606 ,1 ,10 ,', '2020-03-16 18:29:14', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1084', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-03-16 18:29:14', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1085', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-03-16 18:29:14', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1086', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-03-16 18:29:14', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1087', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-03-16 18:29:14', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1088', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@428013cd ,1 ,10 ,', '2020-03-16 18:29:14', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1089', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-03-16 18:29:20', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1090', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-03-16 18:29:21', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1091', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2020-03-16 18:29:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1092', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@6ac751b9 ,', '2020-03-16 18:29:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1093', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-03-16 18:29:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1094', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-03-16 18:29:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1095', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-03-16 18:29:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1096', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-03-16 18:29:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1097', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-03-16 18:29:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1098', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-03-16 18:29:27', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1099', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-03-16 18:29:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1100', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2020-03-16 18:29:36', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1101', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-03-16 18:29:36', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1102', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-03-16 18:29:36', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1103', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@6308fb6a ,', '2020-03-16 18:29:36', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1104', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-03-16 18:29:36', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1105', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-03-16 18:29:38', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1106', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2020-03-16 18:29:39', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1107', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@450191a2 ,', '2020-03-16 18:29:39', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1108', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-03-16 18:29:39', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1109', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-03-16 18:29:39', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1110', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-03-16 18:29:39', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1111', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-03-16 18:29:39', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1112', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-03-16 18:29:39', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1113', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 2 ,', '2020-03-16 18:29:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1114', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,2 ,true ,', '2020-03-16 18:29:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1115', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 3 ,', '2020-03-16 18:29:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1116', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 4 ,', '2020-03-16 18:29:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1117', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 13 ,', '2020-03-16 18:29:42', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1118', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 4 ,', '2020-03-16 18:29:43', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1119', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 13 ,', '2020-03-16 18:29:45', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1120', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 4 ,', '2020-03-16 18:29:47', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1121', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-03-16 18:57:29', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1122', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-03-16 18:57:31', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1123', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-03-16 18:57:34', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1124', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-03-16 18:57:35', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1125', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2020-03-16 18:57:37', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1126', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@b43a204 ,', '2020-03-16 18:57:37', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1127', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-03-16 18:57:37', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1128', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-03-16 18:57:37', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1129', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-03-16 18:57:37', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1130', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-03-16 18:57:37', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1131', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-03-16 18:57:37', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1132', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2020-03-16 18:57:45', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1133', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-03-16 18:57:45', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1134', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-03-16 18:57:45', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1135', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@5f691f8c ,', '2020-03-16 18:57:45', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1136', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-03-16 18:57:45', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1137', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-03-16 18:57:46', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1138', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-03-16 18:59:03', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1139', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-03-16 18:59:04', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1140', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-03-16 18:59:10', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1141', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-03-16 18:59:12', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1142', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-03-16 18:59:16', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1143', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-03-16 18:59:17', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1144', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-03-16 18:59:22', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1145', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2020-03-16 18:59:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1146', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@73eb552 ,', '2020-03-16 18:59:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1147', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-03-16 18:59:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1148', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-03-16 18:59:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1149', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-03-16 18:59:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1150', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-03-16 18:59:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1151', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-03-16 18:59:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1152', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-03-16 19:01:34', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1153', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2020-03-16 19:03:15', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1154', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-03-16 19:03:15', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1155', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-03-16 19:03:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1156', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@132caa55 ,', '2020-03-16 19:03:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1157', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-03-16 19:03:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1158', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-03-16 19:03:54', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1159', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-03-16 19:03:54', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1160', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-03-16 19:04:39', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1161', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-03-16 19:04:39', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1162', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-03-16 19:08:51', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1163', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-03-16 19:10:24', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1164', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-03-16 19:10:24', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1165', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2020-03-16 19:10:24', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1166', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@32da443f ,', '2020-03-16 19:10:24', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1167', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-03-16 19:10:24', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1168', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-03-16 19:10:24', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1169', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-03-16 19:10:24', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1170', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-03-16 19:10:24', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1171', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-03-16 19:10:24', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1172', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,2 ,true ,', '2020-03-16 19:10:30', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1173', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 2 ,', '2020-03-16 19:10:30', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1174', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 3 ,', '2020-03-16 19:10:30', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1175', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 4 ,', '2020-03-16 19:10:30', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1176', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 13 ,', '2020-03-16 19:10:30', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1177', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 13 ,', '2020-03-16 19:10:32', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1178', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@6a54e78 ,', '2020-03-16 19:10:37', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1179', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@5427b2f1 ,', '2020-03-16 19:10:45', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1180', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@25c24f25 ,', '2020-03-16 19:10:57', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1181', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@73a47c8e ,', '2020-03-16 19:11:10', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1182', '1', '1', '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 3 ,', '2020-03-16 19:11:13', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1183', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-03-16 19:12:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1184', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-03-16 19:12:09', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1185', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@583296bc ,', '2020-03-16 19:12:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1186', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@78f374c3 ,', '2020-03-16 19:12:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1187', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.AccountRoleServiceImpl.getRolePagingList(Role,int,int); 操作参数: cn.zup.rbac.entity.Role@42d5cbc0 ,1 ,10 ,', '2020-03-16 19:12:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1188', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.AccountRoleServiceImpl.getRolePagingList(Role,int,int); 操作参数: cn.zup.rbac.entity.Role@5c17ec5f ,1 ,10 ,', '2020-03-16 19:12:22', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1189', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@ef5c5fd ,', '2020-03-16 19:12:22', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1190', '1', '1', '', ' 操作层级: Service 层;  操作方法: Role cn.zup.rbac.service.impl.AccountRoleServiceImpl.getRoleInfo(int); 操作参数: 1 ,', '2020-03-16 19:12:40', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1191', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.AccountRoleServiceImpl.getRoleAccountList(int); 操作参数: 1 ,', '2020-03-16 19:12:40', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1192', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@128cf345 ,', '2020-03-16 19:12:40', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1193', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.AccountRoleServiceImpl.getRoleAccountList(int); 操作参数: 1 ,', '2020-03-16 19:12:40', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1194', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@78cc2e90 ,', '2020-03-16 19:12:47', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1195', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@4d21059 ,', '2020-03-16 19:12:49', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1196', '1', '1', '', ' 操作层级: Service 层;  操作方法: Role cn.zup.rbac.service.impl.AccountRoleServiceImpl.getRoleInfo(int); 操作参数: 1 ,', '2020-03-16 19:12:51', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1197', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2020-03-16 19:12:51', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1198', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@5378a8b ,', '2020-03-16 19:12:51', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1199', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-03-16 19:12:51', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1200', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-03-16 19:12:51', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1201', '1', '1', '', ' 操作层级: Service 层;  操作方法: boolean cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuPermission(int,int); 操作参数: 0 ,1 ,', '2020-03-16 19:12:51', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1202', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-03-16 19:12:51', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1203', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-03-16 19:12:51', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1204', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getRolePermitActionAdd(Integer,int,int,int); 操作参数: 0 ,1 ,1 ,10 ,', '2020-03-16 19:12:52', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1205', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,2 ,true ,', '2020-03-16 19:12:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1206', '1', '1', '', ' 操作层级: Service 层;  操作方法: boolean cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuPermission(int,int); 操作参数: 2 ,1 ,', '2020-03-16 19:12:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1207', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 3 ,', '2020-03-16 19:12:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1208', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 13 ,', '2020-03-16 19:12:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1209', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 4 ,', '2020-03-16 19:12:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1210', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getRolePermitActionAdd(Integer,int,int,int); 操作参数: 2 ,1 ,1 ,10 ,', '2020-03-16 19:12:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1211', '1', '1', '', ' 操作层级: Service 层;  操作方法: boolean cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuPermission(int,int); 操作参数: 13 ,1 ,', '2020-03-16 19:12:55', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1212', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getRolePermitActionAdd(Integer,int,int,int); 操作参数: 13 ,1 ,1 ,10 ,', '2020-03-16 19:12:55', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1213', '1', '1', '', ' 操作层级: Service 层;  操作方法: boolean cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuPermission(int,int); 操作参数: 5 ,1 ,', '2020-03-16 19:12:57', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1214', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,5 ,true ,', '2020-03-16 19:12:57', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1215', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 12 ,', '2020-03-16 19:12:57', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1216', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getRolePermitActionAdd(Integer,int,int,int); 操作参数: 5 ,1 ,1 ,10 ,', '2020-03-16 19:12:57', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1217', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 6 ,', '2020-03-16 19:12:57', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1218', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 7 ,', '2020-03-16 19:12:57', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1219', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 8 ,', '2020-03-16 19:12:57', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1220', '1', '1', '', ' 操作层级: Service 层;  操作方法: boolean cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuPermission(int,int); 操作参数: 8 ,1 ,', '2020-03-16 19:13:02', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1221', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getRolePermitActionAdd(Integer,int,int,int); 操作参数: 8 ,1 ,1 ,10 ,', '2020-03-16 19:13:02', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1222', '1', '1', '', ' 操作层级: Service 层;  操作方法: boolean cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuPermission(int,int); 操作参数: 12 ,1 ,', '2020-03-16 19:13:05', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1223', '1', '1', '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getRolePermitActionAdd(Integer,int,int,int); 操作参数: 12 ,1 ,1 ,10 ,', '2020-03-16 19:13:05', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1224', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@f6fee6c ,', '2020-03-16 19:13:17', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1225', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-03-16 19:13:18', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1226', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=12, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 19:13:20', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1227', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getDimPagingList(BI_DIM); 操作参数: BI_DIM(dim_Id=null, dim_Name=null, biz_Table_Name=null, text_Field=null, id_Field=null, drill_Type=null, drill_Info=null, ds_Id=null, ds_name=null) ,', '2020-03-16 19:13:38', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1228', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getTableNameList(Connection); 操作参数: com.mysql.jdbc.JDBC4Connection@6cae2027 ,', '2020-03-16 19:13:38', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1229', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@43cae3a0 ,pms_bra1nd ,', '2020-03-16 19:13:38', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1230', '1', '1', '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@43cae3a0 ,pms_bra1nd ,', '2020-03-16 19:13:38', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1231', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_DIM cn.zup.bi.service.impl.BIDimServiceImpl.getDimInfo(int); 操作参数: 254 ,', '2020-03-16 19:13:44', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1232', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@44a07bc6 ,', '2020-03-16 19:13:44', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1233', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getDimPagingList(BI_DIM); 操作参数: BI_DIM(dim_Id=null, dim_Name=null, biz_Table_Name=null, text_Field=null, id_Field=null, drill_Type=null, drill_Info=null, ds_Id=1, ds_name=null) ,', '2020-03-16 19:13:54', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1234', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC); 操作参数: BI_TOPIC(topic_Id=null, topic_Name=null, topic_Caption=null, topic_Type=null, biz_Table_Name=null, ds_id=null) ,', '2020-03-16 19:14:14', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1235', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_DIM cn.zup.bi.service.impl.BIDimServiceImpl.getDimInfo(int); 操作参数: 254 ,', '2020-03-16 19:14:30', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1236', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@29b385a0 ,', '2020-03-16 19:14:30', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1237', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@ea6500 ,', '2020-03-16 19:14:58', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1238', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@f1b176c ,', '2020-03-16 19:15:04', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1239', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@66d6ac66 ,', '2020-03-16 19:15:05', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1240', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@68dee982 ,', '2020-03-16 19:15:05', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1241', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@36a46fdd ,', '2020-03-16 19:15:05', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1242', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getBiDimName(); 操作参数: ', '2020-03-16 19:15:05', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1243', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@3ea7d745 ,', '2020-03-16 19:15:20', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1244', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getMenuList(Integer); 操作参数: 1 ,', '2020-03-16 19:15:20', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1245', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@66a694a0 ,', '2020-03-16 19:15:20', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1246', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@1e9fbd9c ,', '2020-03-16 19:15:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1247', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 19:15:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1248', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBIScreenListPage(BI_Screen,int,int); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=29, page_Name=null) ,1 ,10 ,', '2020-03-16 19:15:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1249', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@26192428 ,', '2020-03-16 19:15:26', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1250', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC); 操作参数: BI_TOPIC(topic_Id=null, topic_Name=null, topic_Caption=null, topic_Type=null, biz_Table_Name=null, ds_id=null) ,', '2020-03-16 19:15:26', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1251', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 19:15:26', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1252', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT); 操作参数: BI_REPORT(report_Id=null, topic_Id=null, report_Name=null, page_Id=29, report_Title=null, create_Date=null, topic_Name=null, page_Name=null) ,', '2020-03-16 19:15:26', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1253', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@230fec19 ,', '2020-03-16 19:15:32', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1254', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-03-16 19:15:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1255', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFields(Integer); 操作参数: 45 ,', '2020-03-16 19:15:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1256', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=29, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 19:15:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1257', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@180ccec2 ,', '2020-03-16 19:15:53', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1258', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@5402cee4 ,', '2020-03-16 19:15:56', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1259', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=12, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 19:16:03', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1260', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=12, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 19:16:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1261', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-03-16 19:16:14', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1262', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-03-16 19:16:16', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1263', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=12, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 19:16:18', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1264', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2020-03-16 19:19:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1265', null, null, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-03-16 19:19:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1266', null, null, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-03-16 19:19:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1267', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@72d48677 ,', '2020-03-16 19:19:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1268', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-03-16 19:19:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1269', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-03-16 19:19:35', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1270', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=12, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 19:19:36', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1271', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=12, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 19:21:55', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1272', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getMenuList(Integer); 操作参数: 1 ,', '2020-03-16 19:25:55', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1273', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@345aa03a ,', '2020-03-16 19:25:55', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1274', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@6de41071 ,', '2020-03-16 19:25:55', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1275', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@747f85ee ,', '2020-03-16 19:26:00', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1276', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC); 操作参数: BI_TOPIC(topic_Id=null, topic_Name=null, topic_Caption=null, topic_Type=null, biz_Table_Name=null, ds_id=null) ,', '2020-03-16 19:26:00', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1277', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT); 操作参数: BI_REPORT(report_Id=null, topic_Id=null, report_Name=null, page_Id=29, report_Title=null, create_Date=null, topic_Name=null, page_Name=null) ,', '2020-03-16 19:26:00', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1278', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 19:26:00', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1279', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-03-16 19:26:05', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1280', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@26f14d80 ,', '2020-03-16 19:26:05', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1281', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-03-16 19:26:15', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1282', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@4c1f732f ,', '2020-03-16 19:26:15', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1283', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@54b3b1e1 ,', '2020-03-16 19:26:24', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1284', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=29, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 19:26:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1285', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@78d8be97 ,', '2020-03-16 19:26:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1286', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@7ec0fb32 ,', '2020-03-16 19:26:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1287', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@4332cae3 ,', '2020-03-16 19:26:40', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1288', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@3f722311 ,', '2020-03-16 19:27:01', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1289', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@3f1b44a7 ,', '2020-03-16 19:36:11', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1290', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@6f7360c2 ,', '2020-03-16 19:36:14', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1291', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@602fec77 ,', '2020-03-16 19:36:34', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1292', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@5ab53d8c ,', '2020-03-16 19:38:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1293', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@dd49bc3 ,', '2020-03-16 19:39:22', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1294', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@23a97eb3 ,', '2020-03-16 19:39:47', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1295', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@3bb14d9b ,', '2020-03-16 20:00:44', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1296', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@20b79db1 ,', '2020-03-16 20:00:44', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1297', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@e4aa986 ,', '2020-03-16 20:06:03', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1298', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@fba9eb4 ,', '2020-03-16 20:17:05', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1299', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@20318ab5 ,', '2020-03-16 20:17:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1300', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@3bfd165e ,', '2020-03-16 20:17:23', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1301', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@be9612c ,', '2020-03-16 20:19:04', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1302', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@6b9674a1 ,', '2020-03-16 20:19:47', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1303', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@29273b11 ,', '2020-03-16 20:20:41', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1304', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@d3ea2ed ,', '2020-03-16 20:22:40', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1305', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=29, page_Name=统计演示, page_Type=2, page_Title=null, page_Url=bi/biBlueLargeScreenTemplate, menu_Id=12, menu_Name=数据展示, pageTypeStr=null) ,', '2020-03-16 20:23:16', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1306', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@51c79291 ,', '2020-03-16 20:23:16', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1307', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@262db4b5 ,', '2020-03-16 20:23:18', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1308', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=12, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 20:23:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1309', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=29, page_Name=null) ,', '2020-03-16 20:23:25', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1310', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-03-16 20:23:26', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1311', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-03-16 20:23:26', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1312', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-03-16 20:23:26', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1313', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=29, page_Name=统计演示, page_Type=2, page_Title=null, page_Url=bi/biBlueLargeScreenTemplate, menu_Id=12, menu_Name=数据展示, pageTypeStr=null) ,', '2020-03-16 20:24:16', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1314', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@7fd5634a ,', '2020-03-16 20:24:17', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1315', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=29, page_Name=统计演示, page_Type=2, page_Title=null, page_Url=bi/biBlueLargeScreenTemplate, menu_Id=12, menu_Name=数据展示, pageTypeStr=null) ,', '2020-03-16 20:47:40', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1316', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@1d892502 ,', '2020-03-16 20:47:41', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1317', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@14a9c058 ,', '2020-03-16 20:47:43', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1318', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getMenuList(Integer); 操作参数: 1 ,', '2020-03-16 20:47:47', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1319', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@7c7ffe62 ,', '2020-03-16 20:47:54', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1320', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@7c244003 ,', '2020-03-16 20:47:54', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1321', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=29, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 20:47:54', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1322', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@277316aa ,', '2020-03-16 20:47:54', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1323', '1', '1', '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.BIPageServiceImpl.updatePageInfo(BI_Page); 操作参数: BI_Page(bi_Page_Id=29, page_Name=统计演示, page_Type=3, page_Title=商品统计展示, page_Url=bi/biReportTemplate, menu_Id=12, menu_Name=数据展示, pageTypeStr=null) ,', '2020-03-16 20:48:17', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1324', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@562c283 ,', '2020-03-16 20:48:17', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1325', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=29, page_Name=统计演示, page_Type=3, page_Title=商品统计展示, page_Url=bi/biReportTemplate, menu_Id=12, menu_Name=数据展示, pageTypeStr=null) ,', '2020-03-16 20:48:24', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1326', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@1be32c88 ,', '2020-03-16 20:48:24', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1327', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@34cc0114 ,', '2020-03-16 20:48:27', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1328', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=12, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 20:48:32', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1329', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=29, page_Name=null) ,', '2020-03-16 20:48:32', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1330', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,1 ,', '2020-03-16 20:48:32', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1331', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-03-16 20:48:32', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1332', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-03-16 20:48:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1333', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-03-16 20:48:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1334', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC); 操作参数: BI_TOPIC(topic_Id=null, topic_Name=null, topic_Caption=null, topic_Type=null, biz_Table_Name=null, ds_id=null) ,', '2020-03-16 20:49:21', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1335', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@5e1e032 ,', '2020-03-16 20:49:24', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1336', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@1750b349 ,', '2020-03-16 20:49:29', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1337', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@5a169f65 ,', '2020-03-16 20:49:38', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1338', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@465b20d8 ,', '2020-03-16 20:49:39', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1339', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getBiDimName(); 操作参数: ', '2020-03-16 20:49:39', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1340', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_TOPIC_FIELD cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldData(Integer,Integer); 操作参数: 45 ,216 ,', '2020-03-16 20:49:56', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1341', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@531b49c9 ,', '2020-03-16 20:49:56', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1342', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@47a023bf ,pms_product ,', '2020-03-16 20:49:56', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1343', '1', '1', '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@47a023bf ,pms_product ,', '2020-03-16 20:49:56', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1344', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@213591b4 ,', '2020-03-16 20:50:18', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1345', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@2c528a94 ,', '2020-03-16 20:50:20', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1346', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getDimPagingList(BI_DIM); 操作参数: BI_DIM(dim_Id=null, dim_Name=null, biz_Table_Name=null, text_Field=null, id_Field=null, drill_Type=null, drill_Info=null, ds_Id=null, ds_name=null) ,', '2020-03-16 20:51:21', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1347', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getTableNameList(Connection); 操作参数: com.mysql.jdbc.JDBC4Connection@716d19aa ,', '2020-03-16 20:51:21', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1348', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@2b0ab0ad ,pms_bra1nd ,', '2020-03-16 20:51:21', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1349', '1', '1', '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@2b0ab0ad ,pms_bra1nd ,', '2020-03-16 20:51:21', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1350', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=29, page_Name=统计演示, page_Type=3, page_Title=商品统计展示, page_Url=bi/biReportTemplate, menu_Id=12, menu_Name=数据展示, pageTypeStr=null) ,', '2020-03-16 21:25:16', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1351', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@691ba7b0 ,', '2020-03-16 21:25:16', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1352', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@2d881a54 ,', '2020-03-16 21:25:18', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1353', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-03-16 21:25:26', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1354', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-03-16 21:25:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1355', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=12, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 21:25:39', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1356', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=29, page_Name=null) ,', '2020-03-16 21:25:39', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1357', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,1 ,', '2020-03-16 21:25:39', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1358', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-03-16 21:25:39', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1359', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-03-16 21:25:40', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1360', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-03-16 21:25:40', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1361', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getMenuList(Integer); 操作参数: 1 ,', '2020-03-16 21:26:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1362', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@5e9f3fcb ,', '2020-03-16 21:26:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1363', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@45d7d067 ,', '2020-03-16 21:26:06', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1364', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@3bc5d162 ,', '2020-03-16 21:26:08', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1365', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT); 操作参数: BI_REPORT(report_Id=null, topic_Id=null, report_Name=null, page_Id=29, report_Title=null, create_Date=null, topic_Name=null, page_Name=null) ,', '2020-03-16 21:26:08', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1366', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC); 操作参数: BI_TOPIC(topic_Id=null, topic_Name=null, topic_Caption=null, topic_Type=null, biz_Table_Name=null, ds_id=null) ,', '2020-03-16 21:26:08', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1367', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 21:26:08', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1368', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@68cbea22 ,', '2020-03-16 21:26:12', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1369', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-03-16 21:26:12', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1370', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFields(Integer); 操作参数: 45 ,', '2020-03-16 21:26:12', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1371', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@421157e9 ,', '2020-03-16 21:26:30', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1372', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@67e150de ,', '2020-03-16 21:26:32', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1373', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@7727a15d ,', '2020-03-16 21:26:33', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1374', '1', '1', '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.ReportFieldServiceImpl.saveReportField(BI_REPORT_FIELD); 操作参数: BI_REPORT_FIELD(report_Field_Id=579, report_Id=170, field_Id=217, field_Location=2, dim_Order=1, display=0, field_Name=null) ,', '2020-03-16 21:26:46', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1375', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@3d4386fe ,', '2020-03-16 21:26:47', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1376', '1', '1', '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@538042a9 ,', '2020-03-16 21:26:48', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1377', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=12, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 21:26:59', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1378', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=29, page_Name=null) ,', '2020-03-16 21:26:59', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1379', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,1 ,', '2020-03-16 21:27:00', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1380', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-03-16 21:27:00', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1381', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-03-16 21:27:00', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1382', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-03-16 21:27:00', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1383', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=12, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 21:27:26', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1384', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=29, page_Name=null) ,', '2020-03-16 21:27:26', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1385', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,1 ,', '2020-03-16 21:27:26', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1386', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-03-16 21:27:26', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1387', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-03-16 21:27:26', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1388', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-03-16 21:27:26', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1389', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=12, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 21:27:49', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1390', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=29, page_Name=null) ,', '2020-03-16 21:27:49', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1391', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,1 ,', '2020-03-16 21:27:50', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1392', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-03-16 21:27:50', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1393', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-03-16 21:27:50', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1394', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-03-16 21:27:50', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1395', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=12, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 21:29:02', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1396', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=29, page_Name=null) ,', '2020-03-16 21:29:02', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1397', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,1 ,', '2020-03-16 21:29:02', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1398', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-03-16 21:29:02', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1399', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-03-16 21:29:02', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1400', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-03-16 21:29:02', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1401', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=12, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 21:36:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1402', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=29, page_Name=null) ,', '2020-03-16 21:36:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1403', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,1 ,', '2020-03-16 21:36:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1404', '1', '1', '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-03-16 21:36:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1405', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-03-16 21:36:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1406', '1', '1', '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-03-16 21:36:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1407', null, null, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=12, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 21:39:03', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1408', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=29, page_Name=null) ,', '2020-03-16 21:39:03', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1409', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,1 ,', '2020-03-16 21:39:04', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1410', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-03-16 21:39:04', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1411', null, null, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-03-16 21:39:04', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1412', null, null, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-03-16 21:39:04', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1413', null, null, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=12, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 21:40:29', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1414', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=29, page_Name=null) ,', '2020-03-16 21:40:29', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1415', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,1 ,', '2020-03-16 21:40:30', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1416', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-03-16 21:40:31', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1417', null, null, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-03-16 21:40:31', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1418', null, null, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-03-16 21:40:31', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1419', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC); 操作参数: BI_TOPIC(topic_Id=null, topic_Name=null, topic_Caption=null, topic_Type=null, biz_Table_Name=null, ds_id=null) ,', '2020-03-16 21:48:16', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1420', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getBiDimName(); 操作参数: ', '2020-03-16 21:48:19', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1421', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@6582bdd2 ,', '2020-03-16 21:48:19', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1422', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@5dee57e8 ,', '2020-03-16 21:48:19', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1423', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@f1890e8 ,', '2020-03-16 21:48:19', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1424', null, null, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC_FIELD cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldData(Integer,Integer); 操作参数: 45 ,219 ,', '2020-03-16 21:48:21', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1425', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@4ba83eaa ,pms_product ,', '2020-03-16 21:48:21', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1426', null, null, '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@4ba83eaa ,pms_product ,', '2020-03-16 21:48:21', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1427', null, null, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=12, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 21:55:49', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1428', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=29, page_Name=null) ,', '2020-03-16 21:55:49', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1429', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,1 ,', '2020-03-16 21:55:51', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1430', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-03-16 21:55:51', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1431', null, null, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-03-16 21:55:51', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1432', null, null, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-03-16 21:55:51', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1433', null, null, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=12, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 21:59:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1434', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=29, page_Name=null) ,', '2020-03-16 21:59:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1435', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,1 ,', '2020-03-16 21:59:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1436', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-03-16 21:59:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1437', null, null, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-03-16 21:59:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1438', null, null, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-03-16 21:59:07', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1439', null, null, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=12, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 22:00:26', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1440', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=29, page_Name=null) ,', '2020-03-16 22:00:26', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1441', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,1 ,', '2020-03-16 22:00:27', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1442', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-03-16 22:00:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1443', null, null, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-03-16 22:00:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1444', null, null, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-03-16 22:00:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1445', null, null, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=12, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 22:11:48', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1446', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=29, page_Name=null) ,', '2020-03-16 22:11:48', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1447', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,1 ,', '2020-03-16 22:11:49', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1448', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-03-16 22:11:49', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1449', null, null, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-03-16 22:11:49', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1450', null, null, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-03-16 22:11:49', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1451', null, null, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=12, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 22:26:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1452', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=29, page_Name=null) ,', '2020-03-16 22:26:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1453', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,1 ,', '2020-03-16 22:26:29', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1454', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-03-16 22:26:30', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1455', null, null, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-03-16 22:26:30', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1456', null, null, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-03-16 22:26:30', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1457', null, null, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=12, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 22:27:04', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1458', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=29, page_Name=null) ,', '2020-03-16 22:27:04', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1459', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,1 ,', '2020-03-16 22:27:04', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1460', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-03-16 22:27:04', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1461', null, null, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-03-16 22:27:04', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1462', null, null, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-03-16 22:27:04', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1463', null, null, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=12, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 22:36:27', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1464', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=29, page_Name=null) ,', '2020-03-16 22:36:27', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1465', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,1 ,', '2020-03-16 22:36:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1466', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-03-16 22:36:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1467', null, null, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-03-16 22:36:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1468', null, null, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-03-16 22:36:28', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1469', null, null, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=12, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 22:39:12', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1470', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=29, page_Name=null) ,', '2020-03-16 22:39:12', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1471', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,1 ,', '2020-03-16 22:39:12', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1472', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-03-16 22:39:12', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1473', null, null, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-03-16 22:39:12', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1474', null, null, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-03-16 22:39:12', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1475', null, null, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=12, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 22:39:49', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1476', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=29, page_Name=null) ,', '2020-03-16 22:39:49', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1477', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,1 ,', '2020-03-16 22:39:49', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1478', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-03-16 22:39:49', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1479', null, null, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-03-16 22:39:49', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1480', null, null, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-03-16 22:39:49', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1481', null, null, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=12, menu_Name=null, pageTypeStr=null) ,', '2020-03-16 22:47:04', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1482', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=29, page_Name=null) ,', '2020-03-16 22:47:04', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1483', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,1 ,', '2020-03-16 22:47:08', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1484', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-03-16 22:47:09', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1485', null, null, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-03-16 22:47:09', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1486', null, null, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-03-16 22:47:09', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1487', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldList(Integer); 操作参数: 170 ,', '2020-03-16 22:47:09', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1488', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getDimFieldList(ConditionTransfer); 操作参数: cn.zup.bi.entity.ConditionTransfer@5ac0b4a7 ,', '2020-03-16 22:47:09', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1489', null, null, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-03-16 22:47:09', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1490', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getDimFilter(String); 操作参数: name ,', '2020-03-16 22:47:09', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1491', null, null, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=12, menu_Name=null, pageTypeStr=null) ,', '2020-03-17 09:27:19', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1492', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=29, page_Name=null) ,', '2020-03-17 09:27:19', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1493', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,1 ,', '2020-03-17 09:27:19', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1494', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-03-17 09:27:19', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1495', null, null, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-03-17 09:27:19', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1496', null, null, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-03-17 09:27:19', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1497', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldList(Integer); 操作参数: 170 ,', '2020-03-17 09:27:19', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1498', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getDimFieldList(ConditionTransfer); 操作参数: cn.zup.bi.entity.ConditionTransfer@4ef48fcd ,', '2020-03-17 09:27:19', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1499', null, null, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-03-17 09:27:19', '1', '', '', '');
INSERT INTO `operatelog` VALUES ('1500', null, null, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getDimFilter(String); 操作参数: name ,', '2020-03-17 09:27:20', '1', '', '', '');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rolemenu
-- ----------------------------
INSERT INTO `rolemenu` VALUES ('1', '1', '1');
INSERT INTO `rolemenu` VALUES ('2', '1', '1');
INSERT INTO `rolemenu` VALUES ('3', '1', '1');
INSERT INTO `rolemenu` VALUES ('4', '1', '1');
INSERT INTO `rolemenu` VALUES ('5', '1', '1');
INSERT INTO `rolemenu` VALUES ('6', '1', '1');
INSERT INTO `rolemenu` VALUES ('7', '1', '1');
INSERT INTO `rolemenu` VALUES ('8', '1', '1');
INSERT INTO `rolemenu` VALUES ('9', '1', '1');
INSERT INTO `rolemenu` VALUES ('12', '1', '1');
INSERT INTO `rolemenu` VALUES ('13', '1', '1');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wechat_template
-- ----------------------------

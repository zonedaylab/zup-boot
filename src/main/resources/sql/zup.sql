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

 Date: 13/02/2020 18:25:58
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
) ENGINE=InnoDB AUTO_INCREMENT=248 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auditlog
-- ----------------------------
BEGIN;
INSERT INTO `auditlog` VALUES (116, 1, 1, '表单管理 ', '编辑', 3, '2020-02-12 17:23:17', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (117, 1, 1, '表单管理 ', '取消', 3, '2020-02-12 17:23:27', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (118, 1, 1, '表单管理 ', '布局设置', 3, '2020-02-12 17:23:37', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (119, 1, 1, '表单管理 ', '元素设置', 3, '2020-02-12 17:23:42', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (120, 1, 1, '1', '编辑', 3, '2020-02-12 17:23:45', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (121, 1, 1, '1', '取消', 3, '2020-02-12 17:23:50', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (122, 1, 1, '1', '字段设置', 3, '2020-02-12 17:23:52', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (123, 1, 1, '表单管理 ', '添加', 3, '2020-02-12 17:24:13', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (124, 1, 1, '表单管理 ', '保存', 3, '2020-02-12 17:24:27', '0:0:0:0:0:0:0:1', '山东省 泰安市', NULL);
INSERT INTO `auditlog` VALUES (125, 1, 1, '表单管理 ', '添加', 3, '2020-02-12 17:24:38', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (126, 1, 1, '表单管理 ', '保存', 3, '2020-02-12 17:24:46', '0:0:0:0:0:0:0:1', '山东省 泰安市', NULL);
INSERT INTO `auditlog` VALUES (127, 1, 1, '表单管理 ', '编辑', 3, '2020-02-12 17:24:52', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (128, 1, 1, '表单管理 ', '布局设置', 3, '2020-02-12 17:24:54', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (129, 1, 1, '表单管理 ', '布局设置', 3, '2020-02-12 17:25:00', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (130, 1, 1, '', '添加', 3, '2020-02-12 17:25:02', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (131, 1, 1, '', '保存', 3, '2020-02-12 17:25:06', '0:0:0:0:0:0:0:1', '山东省 泰安市', NULL);
INSERT INTO `auditlog` VALUES (132, 1, 1, '1', '确定', 3, '2020-02-12 17:25:08', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (133, 1, 1, '表单管理 ', '元素设置', 3, '2020-02-12 17:25:11', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (134, 1, 1, '', '添加', 3, '2020-02-12 17:25:12', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (135, 1, 1, '', '保存', 3, '2020-02-12 17:25:27', '0:0:0:0:0:0:0:1', '山东省 泰安市', NULL);
INSERT INTO `auditlog` VALUES (136, 1, 1, '1', '确定', 3, '2020-02-12 17:25:28', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (137, 1, 1, '1', '字段设置', 3, '2020-02-12 17:25:30', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (138, 1, 1, '', '添加', 3, '2020-02-12 17:25:32', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (139, 1, 1, '', '保存', 3, '2020-02-12 17:25:39', '0:0:0:0:0:0:0:1', '山东省 泰安市', NULL);
INSERT INTO `auditlog` VALUES (140, 1, 1, '1', '确定', 3, '2020-02-12 17:25:40', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (141, 1, 1, '1', '添加', 3, '2020-02-12 17:25:41', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (142, 1, 1, '1', '保存', 3, '2020-02-12 17:25:48', '0:0:0:0:0:0:0:1', '山东省 泰安市', NULL);
INSERT INTO `auditlog` VALUES (143, 1, 1, '1', '确定', 3, '2020-02-12 17:25:49', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (144, 1, 1, '表单管理 ', '删除', 3, '2020-02-12 17:27:22', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (145, 1, 1, '表单管理 ', '布局设置', 3, '2020-02-12 17:28:15', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (146, 1, 1, '1', '删除', 3, '2020-02-12 17:28:18', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (147, 1, 1, '', '确定', 3, '2020-02-12 17:28:19', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (148, 1, 1, '', '确定', 3, '2020-02-12 17:28:20', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (149, 1, 1, '表单管理 ', '元素设置', 3, '2020-02-12 17:28:24', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (150, 1, 1, '1', '字段设置', 3, '2020-02-12 17:28:27', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (151, 1, 1, '1', '删除', 3, '2020-02-12 17:28:29', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (152, 1, 1, '', '确定', 3, '2020-02-12 17:28:30', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (153, 1, 1, '', '确定', 3, '2020-02-12 17:28:31', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (154, 1, 1, '1', '删除', 3, '2020-02-12 17:28:34', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (155, 1, 1, '1', '确定', 3, '2020-02-12 17:28:35', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (156, 1, 1, '1', '确定', 3, '2020-02-12 17:28:37', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (157, 1, 1, '1', '删除', 3, '2020-02-12 17:28:39', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (158, 1, 1, '1', '确定', 3, '2020-02-12 17:28:40', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (159, 1, 1, '1', '确定', 3, '2020-02-12 17:28:41', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (160, 1, 1, '1', '字段设置', 3, '2020-02-12 17:28:42', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (161, 1, 1, '1', '删除', 3, '2020-02-12 17:29:59', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (162, 1, 1, '', '确定', 3, '2020-02-12 17:30:00', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (163, 1, 1, '表单管理 ', '删除', 3, '2020-02-12 17:30:04', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (164, 1, 1, '表单管理 ', '删除', 3, '2020-02-12 17:30:08', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (165, 1, 1, '表单管理 ', '元素设置', 3, '2020-02-12 17:30:11', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (166, 1, 1, '1', '删除', 3, '2020-02-12 17:30:14', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (167, 1, 1, '1', '取消', 3, '2020-02-12 17:30:15', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (168, 1, 1, '1', '字段设置', 3, '2020-02-12 17:30:16', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (169, 1, 1, '1', '添加', 3, '2020-02-12 17:30:22', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (170, 1, 1, '1', '字段设置', 3, '2020-02-12 17:30:25', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (171, 1, 1, '', '添加', 3, '2020-02-12 17:30:26', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (172, 1, 1, '', '保存', 3, '2020-02-12 17:30:32', '0:0:0:0:0:0:0:1', '山东省 泰安市', NULL);
INSERT INTO `auditlog` VALUES (173, 1, 1, '1', '确定', 3, '2020-02-12 17:30:33', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (174, 1, 1, '1', '添加', 3, '2020-02-12 17:30:34', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (175, 1, 1, '1', '保存', 3, '2020-02-12 17:30:39', '0:0:0:0:0:0:0:1', '山东省 泰安市', NULL);
INSERT INTO `auditlog` VALUES (176, 1, 1, '1', '确定', 3, '2020-02-12 17:30:40', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (177, 1, 1, '1', '添加', 3, '2020-02-12 17:30:42', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (178, 1, 1, '1', '保存', 3, '2020-02-12 17:30:46', '0:0:0:0:0:0:0:1', '山东省 泰安市', NULL);
INSERT INTO `auditlog` VALUES (179, 1, 1, '1', '确定', 3, '2020-02-12 17:30:47', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (180, 1, 1, '1', '编辑', 3, '2020-02-12 17:30:51', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (181, 1, 1, '1', '字段设置', 3, '2020-02-12 17:30:54', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (182, 1, 1, '1', '编辑', 3, '2020-02-12 17:31:00', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (183, 1, 1, '表单管理 ', '元素设置', 3, '2020-02-12 17:31:28', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (184, 1, 1, '1', '字段设置', 3, '2020-02-12 17:31:32', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (185, 1, 1, '1', '删除', 3, '2020-02-12 17:31:34', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (186, 1, 1, '', '确定', 3, '2020-02-12 17:31:35', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (187, 1, 1, '', '确定', 3, '2020-02-12 17:31:36', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (188, 1, 1, '1', '字段设置', 3, '2020-02-12 17:31:39', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (189, 1, 1, '1', '删除', 3, '2020-02-12 17:31:42', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (190, 1, 1, '1', '确定', 3, '2020-02-12 17:31:43', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (191, 1, 1, '1', '确定', 3, '2020-02-12 17:31:44', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (192, 1, 1, '1', '删除', 3, '2020-02-12 17:31:55', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (193, 1, 1, '', '确定', 3, '2020-02-12 17:31:56', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (194, 1, 1, '表单管理 ', '删除', 3, '2020-02-12 17:31:59', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (195, 1, 1, '表单管理 ', '布局设置', 3, '2020-02-12 17:32:05', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (196, 1, 1, '1', '删除', 3, '2020-02-12 17:32:07', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (197, 1, 1, '', '确定', 3, '2020-02-12 17:32:08', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (198, 1, 1, '表单管理 ', '删除', 3, '2020-02-12 17:32:10', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (199, 1, 1, '表单管理 ', '编辑', 3, '2020-02-12 17:32:14', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (200, 1, 1, '表单管理 ', '保存', 3, '2020-02-12 17:32:21', '0:0:0:0:0:0:0:1', '山东省 泰安市', NULL);
INSERT INTO `auditlog` VALUES (201, 1, 1, '表单管理 ', '添加', 3, '2020-02-12 17:32:24', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (202, 1, 1, '菜单管理 ', '编辑', 3, '2020-02-12 17:32:59', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (203, 1, 1, '表单管理 ', '添加', 3, '2020-02-12 17:33:20', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (204, 1, 1, '表单管理 ', '添加', 3, '2020-02-12 17:34:35', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (205, 1, 1, '表单管理 ', '保存', 3, '2020-02-12 17:34:43', '0:0:0:0:0:0:0:1', '山东省 泰安市', NULL);
INSERT INTO `auditlog` VALUES (206, 1, 1, '表单管理 ', '编辑', 3, '2020-02-12 17:36:51', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (207, 1, 1, '表单管理 ', '布局设置', 3, '2020-02-12 17:37:20', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (208, 1, 1, '', '添加', 3, '2020-02-12 17:37:21', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (209, 1, 1, '', '保存', 3, '2020-02-12 17:37:27', '0:0:0:0:0:0:0:1', '山东省 泰安市', NULL);
INSERT INTO `auditlog` VALUES (210, 1, 1, '1', '确定', 3, '2020-02-12 17:37:28', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (211, 1, 1, '表单管理 ', '元素设置', 3, '2020-02-12 17:37:31', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (212, 1, 1, '', '添加', 3, '2020-02-12 17:37:32', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (213, 1, 1, '', '保存', 3, '2020-02-12 17:37:42', '0:0:0:0:0:0:0:1', '山东省 泰安市', NULL);
INSERT INTO `auditlog` VALUES (214, 1, 1, '1', '确定', 3, '2020-02-12 17:37:43', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (215, 1, 1, '1', '字段设置', 3, '2020-02-12 17:37:45', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (216, 1, 1, '', '添加', 3, '2020-02-12 17:37:46', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (217, 1, 1, '', '保存', 3, '2020-02-12 17:37:52', '0:0:0:0:0:0:0:1', '山东省 泰安市', NULL);
INSERT INTO `auditlog` VALUES (218, 1, 1, '1', '确定', 3, '2020-02-12 17:37:54', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (219, 1, 1, '1', '添加', 3, '2020-02-12 17:37:55', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (220, 1, 1, '1', '保存', 3, '2020-02-12 17:38:01', '0:0:0:0:0:0:0:1', '山东省 泰安市', NULL);
INSERT INTO `auditlog` VALUES (221, 1, 1, '1', '确定', 3, '2020-02-12 17:38:02', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (222, 1, 1, '1', '添加', 3, '2020-02-12 17:38:03', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (223, 1, 1, '1', '保存', 3, '2020-02-12 17:38:09', '0:0:0:0:0:0:0:1', '山东省 泰安市', NULL);
INSERT INTO `auditlog` VALUES (224, 1, 1, '1', '确定', 3, '2020-02-12 17:38:10', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (225, 1, 1, '维度配置 ', '编辑', 3, '2020-02-13 18:21:53', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (226, 1, 1, '表单管理 ', '布局设置', 3, '2020-02-13 18:22:09', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (227, 1, 1, '', '添加', 3, '2020-02-13 18:22:10', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (228, 1, 1, '', '保存', 3, '2020-02-13 18:22:15', '0:0:0:0:0:0:0:1', '山东省 泰安市', NULL);
INSERT INTO `auditlog` VALUES (229, 1, 1, '1', '确定', 3, '2020-02-13 18:22:16', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (230, 1, 1, '表单管理 ', '布局设置', 3, '2020-02-13 18:22:20', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (231, 1, 1, '', '添加', 3, '2020-02-13 18:22:22', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (232, 1, 1, '', '保存', 3, '2020-02-13 18:22:25', '0:0:0:0:0:0:0:1', '山东省 泰安市', NULL);
INSERT INTO `auditlog` VALUES (233, 1, 1, '1', '确定', 3, '2020-02-13 18:22:27', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (234, 1, 1, '表单管理 ', '元素设置', 3, '2020-02-13 18:22:30', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (235, 1, 1, '1', '字段设置', 3, '2020-02-13 18:22:34', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (236, 1, 1, '维度配置 ', '编辑', 3, '2020-02-13 18:22:48', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (237, 1, 1, '表单管理 ', '元素设置', 3, '2020-02-13 18:24:46', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (238, 1, 1, '1', '字段设置', 3, '2020-02-13 18:24:49', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (239, 1, 1, '', '添加', 3, '2020-02-13 18:24:50', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (240, 1, 1, '', '保存', 3, '2020-02-13 18:24:56', '0:0:0:0:0:0:0:1', '山东省 泰安市', NULL);
INSERT INTO `auditlog` VALUES (241, 1, 1, '1', '确定', 3, '2020-02-13 18:24:57', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (242, 1, 1, '1', '添加', 3, '2020-02-13 18:24:58', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (243, 1, 1, '1', '保存', 3, '2020-02-13 18:25:03', '0:0:0:0:0:0:0:1', '山东省 泰安市', NULL);
INSERT INTO `auditlog` VALUES (244, 1, 1, '1', '确定', 3, '2020-02-13 18:25:04', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (245, 1, 1, '1', '添加', 3, '2020-02-13 18:25:25', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
INSERT INTO `auditlog` VALUES (246, 1, 1, '1', '保存', 3, '2020-02-13 18:25:31', '0:0:0:0:0:0:0:1', '山东省 泰安市', NULL);
INSERT INTO `auditlog` VALUES (247, 1, 1, '1', '确定', 3, '2020-02-13 18:25:32', '0:0:0:0:0:0:0:1', '山东省 泰安市', '该用户可能保存了编辑或者添加的数据');
COMMIT;

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
) ENGINE=InnoDB AUTO_INCREMENT=554 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bi_block
-- ----------------------------
BEGIN;
INSERT INTO `bi_block` VALUES (551, NULL, 1, NULL, NULL, NULL, 172, 31, 2, 1);
INSERT INTO `bi_block` VALUES (553, NULL, 1, NULL, NULL, NULL, 173, 32, 2, 1);
COMMIT;

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
BEGIN;
INSERT INTO `bi_datasource` VALUES (1, '127.0.0.1', 3306, 'root', '123456', 'mysql', 'bi-demo', 'root', '2020-02-13 17:59:03');
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
  `DS_ID` int(38) DEFAULT NULL,
  PRIMARY KEY (`DIM_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=255 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bi_dim
-- ----------------------------
BEGIN;
INSERT INTO `bi_dim` VALUES (253, '商品分类信息', 'pms_product_catego1ry', 'name', 'id', 1, '', 1);
INSERT INTO `bi_dim` VALUES (254, '商品品牌', 'pms_bra1nd', 'name', 'id', 1, '', 1);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bi_dim_attribute
-- ----------------------------
BEGIN;
INSERT INTO `bi_dim_attribute` VALUES (1, 254, 'id', 'name', '品牌');
COMMIT;

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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bi_page
-- ----------------------------
BEGIN;
INSERT INTO `bi_page` VALUES (31, 1, '商品统计展示', '商品价格统计', 'bi/biBlueLargeScreenTemplate', 96555, '/Bi/96555');
INSERT INTO `bi_page` VALUES (32, 2, '商品统计展示', '商品价格统计', 'bi/biLargeScreen', 13, '商品-演示');
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
) ENGINE=InnoDB AUTO_INCREMENT=174 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bi_report
-- ----------------------------
BEGIN;
INSERT INTO `bi_report` VALUES (172, 45, '价格', '价格', '2020-02-12 17:25:27', 31);
INSERT INTO `bi_report` VALUES (173, 45, '商品', '商品', '2020-02-12 17:37:42', 32);
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
) ENGINE=InnoDB AUTO_INCREMENT=591 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bi_report_field
-- ----------------------------
BEGIN;
INSERT INTO `bi_report_field` VALUES (585, 173, 215, 3, 1, 1);
INSERT INTO `bi_report_field` VALUES (586, 173, 217, 1, 1, 1);
INSERT INTO `bi_report_field` VALUES (587, 173, 219, 3, 1, 1);
INSERT INTO `bi_report_field` VALUES (588, 172, 217, 1, 1, 1);
INSERT INTO `bi_report_field` VALUES (589, 172, 215, 3, 1, 1);
INSERT INTO `bi_report_field` VALUES (590, 172, 219, 3, 1, 1);
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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bi_screen
-- ----------------------------
BEGIN;
INSERT INTO `bi_screen` VALUES (35, '首页', 1, 32);
INSERT INTO `bi_screen` VALUES (36, '首页', 1, 31);
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
  `DS_ID` int(38) DEFAULT NULL,
  PRIMARY KEY (`TOPIC_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bi_topic
-- ----------------------------
BEGIN;
INSERT INTO `bi_topic` VALUES (45, 'product_info', '商品信息', NULL, 'pms_product', 1);
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
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8;

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
INSERT INTO `config` VALUES (83, 3, '普通大屏', 'bi/biLargeScreen');
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
) ENGINE=InnoDB AUTO_INCREMENT=37577 DEFAULT CHARSET=utf8;

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
INSERT INTO `loginlog` VALUES (37572, 1, 1, '2020-01-04 15:19:12', 1, 1, '0:0:0:0:0:0:0:1', NULL, NULL, '管理员');
INSERT INTO `loginlog` VALUES (37573, 1, 1, '2020-01-04 16:52:33', 1, 1, '0:0:0:0:0:0:0:1', NULL, NULL, '管理员');
INSERT INTO `loginlog` VALUES (37574, 1, 1, '2020-01-04 17:27:55', 1, 1, '0:0:0:0:0:0:0:1', NULL, NULL, '管理员');
INSERT INTO `loginlog` VALUES (37575, 1, 1, '2020-01-06 23:08:11', 1, 1, '0:0:0:0:0:0:0:1', NULL, NULL, '管理员');
INSERT INTO `loginlog` VALUES (37576, 1, 1, '2020-02-13 18:00:30', 1, 1, '0:0:0:0:0:0:0:1', NULL, NULL, '管理员');
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu
-- ----------------------------
BEGIN;
INSERT INTO `menu` VALUES (1, 1, 0, '首页', 1, NULL, NULL, 'rest/rbac/homeController', NULL, NULL, 2);
INSERT INTO `menu` VALUES (2, 1, 0, '系统管理', 9, NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO `menu` VALUES (3, 1, 2, '菜单管理', 1, NULL, NULL, 'rest/rbac/menuController', NULL, NULL, 2);
INSERT INTO `menu` VALUES (4, 1, 2, '操作项管理', 2, NULL, NULL, 'rest/rbac/menuActionController', NULL, NULL, 2);
INSERT INTO `menu` VALUES (5, 1, 0, '商务智能', 5, NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO `menu` VALUES (6, 1, 5, '维度配置', 2, NULL, NULL, 'rest/bi/BIDimController', NULL, NULL, 2);
INSERT INTO `menu` VALUES (7, 1, 5, '主题配置', 3, NULL, NULL, 'rest/bi/BITopicController', NULL, NULL, 2);
INSERT INTO `menu` VALUES (8, 1, 5, '表单管理', 4, NULL, NULL, 'rest/bi/biPageController', NULL, NULL, 2);
INSERT INTO `menu` VALUES (11, 1, 5, '数据源配置', 1, '', '', 'rest/bi/BIDatasourceController', '', NULL, 2);
INSERT INTO `menu` VALUES (13, 1, 5, '演示-商品', 12, '', '', 'Bi/MenuShow', '', NULL, 2);
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
) ENGINE=InnoDB AUTO_INCREMENT=1130 DEFAULT CHARSET=utf8;

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
INSERT INTO `operatelog` VALUES (336, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2020-01-04 15:19:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (337, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-01-04 15:19:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (338, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-01-04 15:19:12', 1, '', '', '');
INSERT INTO `operatelog` VALUES (339, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@3c41de48 ,', '2020-01-04 15:19:12', 1, '', '', '');
INSERT INTO `operatelog` VALUES (340, 1, 1, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-01-04 15:19:12', 1, '', '', '');
INSERT INTO `operatelog` VALUES (341, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-01-04 15:19:12', 1, '', '', '');
INSERT INTO `operatelog` VALUES (342, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-04 15:21:45', 1, '', '', '');
INSERT INTO `operatelog` VALUES (343, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-04 15:21:45', 1, '', '', '');
INSERT INTO `operatelog` VALUES (344, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-04 15:21:46', 1, '', '', '');
INSERT INTO `operatelog` VALUES (345, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2020-01-04 16:52:32', 1, '', '', '');
INSERT INTO `operatelog` VALUES (346, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-01-04 16:52:32', 1, '', '', '');
INSERT INTO `operatelog` VALUES (347, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-01-04 16:52:32', 1, '', '', '');
INSERT INTO `operatelog` VALUES (348, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@45b340f1 ,', '2020-01-04 16:52:33', 1, '', '', '');
INSERT INTO `operatelog` VALUES (349, 1, 1, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-01-04 16:52:33', 1, '', '', '');
INSERT INTO `operatelog` VALUES (350, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-01-04 16:52:33', 1, '', '', '');
INSERT INTO `operatelog` VALUES (351, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-04 16:52:35', 1, '', '', '');
INSERT INTO `operatelog` VALUES (352, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1156 ,', '2020-01-04 16:52:38', 1, '', '', '');
INSERT INTO `operatelog` VALUES (353, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@6b9b44d ,', '2020-01-04 16:52:38', 1, '', '', '');
INSERT INTO `operatelog` VALUES (354, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@1bd9cced ,', '2020-01-04 16:52:38', 1, '', '', '');
INSERT INTO `operatelog` VALUES (355, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIPageServiceImpl.getBIPageListPage(BI_Page,int,int); 操作参数: cn.zup.bi.entity.BI_Page@416d32a6 ,1 ,10 ,', '2020-01-04 16:52:38', 1, '', '', '');
INSERT INTO `operatelog` VALUES (356, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@4144377 ,1 ,10 ,', '2020-01-04 16:52:38', 1, '', '', '');
INSERT INTO `operatelog` VALUES (358, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-01-04 16:59:48', 1, '', '', '');
INSERT INTO `operatelog` VALUES (359, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2020-01-04 16:59:50', 1, '', '', '');
INSERT INTO `operatelog` VALUES (360, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@5632963d ,', '2020-01-04 16:59:50', 1, '', '', '');
INSERT INTO `operatelog` VALUES (361, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-01-04 16:59:51', 1, '', '', '');
INSERT INTO `operatelog` VALUES (362, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-01-04 16:59:51', 1, '', '', '');
INSERT INTO `operatelog` VALUES (363, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-01-04 16:59:51', 1, '', '', '');
INSERT INTO `operatelog` VALUES (364, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-01-04 16:59:51', 1, '', '', '');
INSERT INTO `operatelog` VALUES (365, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-01-04 16:59:51', 1, '', '', '');
INSERT INTO `operatelog` VALUES (366, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,5 ,true ,', '2020-01-04 16:59:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (367, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 5 ,', '2020-01-04 16:59:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (368, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 6 ,', '2020-01-04 16:59:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (369, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 7 ,', '2020-01-04 16:59:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (370, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 8 ,', '2020-01-04 16:59:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (371, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 9 ,', '2020-01-04 16:59:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (372, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 10 ,', '2020-01-04 16:59:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (374, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 6 ,', '2020-01-04 16:59:55', 1, '', '', '');
INSERT INTO `operatelog` VALUES (376, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 5 ,', '2020-01-04 17:00:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (377, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 5 ,', '2020-01-04 17:00:13', 1, '', '', '');
INSERT INTO `operatelog` VALUES (380, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@7941d503 ,', '2020-01-04 17:17:03', 1, '', '', '');
INSERT INTO `operatelog` VALUES (381, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@2f0d0c46 ,', '2020-01-04 17:17:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (382, 1, 1, '', ' 操作层级: Service 层;  操作方法: boolean cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuRepeatVerify(Integer,int,int,String); 操作参数: null ,1 ,5 ,数据源配置 ,', '2020-01-04 17:20:15', 1, '', '', '');
INSERT INTO `operatelog` VALUES (383, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@6e2ef4c1 ,', '2020-01-04 17:20:15', 1, '', '', '');
INSERT INTO `operatelog` VALUES (384, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.ResourceServiceImpl.addMenu(Menu); 操作参数: cn.zup.rbac.entity.Menu@24fa02af ,', '2020-01-04 17:20:15', 1, '', '', '');
INSERT INTO `operatelog` VALUES (385, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@282ad13e ,', '2020-01-04 17:20:15', 1, '', '', '');
INSERT INTO `operatelog` VALUES (386, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-01-04 17:20:15', 1, '', '', '');
INSERT INTO `operatelog` VALUES (387, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-01-04 17:20:15', 1, '', '', '');
INSERT INTO `operatelog` VALUES (388, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-01-04 17:20:15', 1, '', '', '');
INSERT INTO `operatelog` VALUES (389, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-01-04 17:20:15', 1, '', '', '');
INSERT INTO `operatelog` VALUES (390, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-01-04 17:20:15', 1, '', '', '');
INSERT INTO `operatelog` VALUES (391, 1, 1, '', ' 操作层级: Service 层;  操作方法: boolean cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuRepeatVerify(Integer,int,int,String); 操作参数: null ,1 ,0 ,32323 ,', '2020-01-04 17:21:36', 1, '', '', '');
INSERT INTO `operatelog` VALUES (392, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@5f9a0d63 ,', '2020-01-04 17:21:36', 1, '', '', '');
INSERT INTO `operatelog` VALUES (393, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@699bfe80 ,', '2020-01-04 17:21:36', 1, '', '', '');
INSERT INTO `operatelog` VALUES (394, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.ResourceServiceImpl.addMenu(Menu); 操作参数: cn.zup.rbac.entity.Menu@7f1ae564 ,', '2020-01-04 17:21:36', 1, '', '', '');
INSERT INTO `operatelog` VALUES (395, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@1ab9a8fe ,', '2020-01-04 17:21:36', 1, '', '', '');
INSERT INTO `operatelog` VALUES (396, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-01-04 17:21:36', 1, '', '', '');
INSERT INTO `operatelog` VALUES (397, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-01-04 17:21:36', 1, '', '', '');
INSERT INTO `operatelog` VALUES (398, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-01-04 17:21:36', 1, '', '', '');
INSERT INTO `operatelog` VALUES (399, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-01-04 17:21:36', 1, '', '', '');
INSERT INTO `operatelog` VALUES (400, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-01-04 17:21:36', 1, '', '', '');
INSERT INTO `operatelog` VALUES (401, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 12 ,', '2020-01-04 17:21:36', 1, '', '', '');
INSERT INTO `operatelog` VALUES (402, 1, 1, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-01-04 17:23:14', 1, '', '', '');
INSERT INTO `operatelog` VALUES (403, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-01-04 17:23:14', 1, '', '', '');
INSERT INTO `operatelog` VALUES (404, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-04 17:23:15', 1, '', '', '');
INSERT INTO `operatelog` VALUES (405, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@11f63c60 ,1 ,10 ,', '2020-01-04 17:23:18', 1, '', '', '');
INSERT INTO `operatelog` VALUES (406, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1156 ,', '2020-01-04 17:23:18', 1, '', '', '');
INSERT INTO `operatelog` VALUES (407, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@526d052b ,', '2020-01-04 17:23:18', 1, '', '', '');
INSERT INTO `operatelog` VALUES (408, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@37ddede3 ,', '2020-01-04 17:23:18', 1, '', '', '');
INSERT INTO `operatelog` VALUES (409, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIPageServiceImpl.getBIPageListPage(BI_Page,int,int); 操作参数: cn.zup.bi.entity.BI_Page@2f0d0fea ,1 ,10 ,', '2020-01-04 17:23:18', 1, '', '', '');
INSERT INTO `operatelog` VALUES (410, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@63fe1b33 ,1 ,9999 ,', '2020-01-04 17:23:19', 1, '', '', '');
INSERT INTO `operatelog` VALUES (411, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@205e7f27 ,', '2020-01-04 17:23:19', 1, '', '', '');
INSERT INTO `operatelog` VALUES (412, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT@333d9287 ,1 ,10 ,', '2020-01-04 17:23:19', 1, '', '', '');
INSERT INTO `operatelog` VALUES (413, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@631ca039 ,', '2020-01-04 17:23:19', 1, '', '', '');
INSERT INTO `operatelog` VALUES (414, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIScreenServiceImpl.getBIScreenListPage(BI_Screen,int,int); 操作参数: cn.zup.bi.entity.BI_Screen@48019c32 ,1 ,10 ,', '2020-01-04 17:23:19', 1, '', '', '');
INSERT INTO `operatelog` VALUES (416, 1, 1, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-01-04 17:24:07', 1, '', '', '');
INSERT INTO `operatelog` VALUES (417, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-01-04 17:24:07', 1, '', '', '');
INSERT INTO `operatelog` VALUES (418, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-04 17:24:08', 1, '', '', '');
INSERT INTO `operatelog` VALUES (419, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2020-01-04 17:27:54', 1, '', '', '');
INSERT INTO `operatelog` VALUES (420, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-01-04 17:27:55', 1, '', '', '');
INSERT INTO `operatelog` VALUES (421, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-01-04 17:27:55', 1, '', '', '');
INSERT INTO `operatelog` VALUES (422, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@727467de ,', '2020-01-04 17:27:55', 1, '', '', '');
INSERT INTO `operatelog` VALUES (423, 1, 1, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-01-04 17:27:55', 1, '', '', '');
INSERT INTO `operatelog` VALUES (424, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-01-04 17:27:55', 1, '', '', '');
INSERT INTO `operatelog` VALUES (425, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-04 17:27:57', 1, '', '', '');
INSERT INTO `operatelog` VALUES (426, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@7d1dabbe ,', '2020-01-04 17:27:58', 1, '', '', '');
INSERT INTO `operatelog` VALUES (427, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@29a9bfe8 ,1 ,9999 ,', '2020-01-04 17:27:58', 1, '', '', '');
INSERT INTO `operatelog` VALUES (428, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT@475e5706 ,1 ,10 ,', '2020-01-04 17:27:58', 1, '', '', '');
INSERT INTO `operatelog` VALUES (429, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@1ec01fda ,', '2020-01-06 23:06:22', 1, '', '', '');
INSERT INTO `operatelog` VALUES (430, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@312d1935 ,', '2020-01-06 23:06:22', 1, '', '', '');
INSERT INTO `operatelog` VALUES (431, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-01-06 23:06:22', 1, '', '', '');
INSERT INTO `operatelog` VALUES (432, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-01-06 23:06:54', 1, '', '', '');
INSERT INTO `operatelog` VALUES (433, 1, 1, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-01-06 23:07:04', 1, '', '', '');
INSERT INTO `operatelog` VALUES (434, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-01-06 23:07:04', 1, '', '', '');
INSERT INTO `operatelog` VALUES (435, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-06 23:07:05', 1, '', '', '');
INSERT INTO `operatelog` VALUES (436, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT@6e657a06 ,1 ,10 ,', '2020-01-06 23:07:06', 1, '', '', '');
INSERT INTO `operatelog` VALUES (437, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@61918999 ,', '2020-01-06 23:07:06', 1, '', '', '');
INSERT INTO `operatelog` VALUES (438, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@6a18a2d ,1 ,9999 ,', '2020-01-06 23:07:06', 1, '', '', '');
INSERT INTO `operatelog` VALUES (439, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2020-01-06 23:08:10', 1, '', '', '');
INSERT INTO `operatelog` VALUES (440, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-01-06 23:08:10', 1, '', '', '');
INSERT INTO `operatelog` VALUES (441, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-01-06 23:08:10', 1, '', '', '');
INSERT INTO `operatelog` VALUES (442, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@4fec82cf ,', '2020-01-06 23:08:10', 1, '', '', '');
INSERT INTO `operatelog` VALUES (443, 1, 1, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-01-06 23:08:10', 1, '', '', '');
INSERT INTO `operatelog` VALUES (444, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-01-06 23:08:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (445, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-06 23:08:13', 1, '', '', '');
INSERT INTO `operatelog` VALUES (446, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@6832c5e8 ,', '2020-01-06 23:08:14', 1, '', '', '');
INSERT INTO `operatelog` VALUES (447, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@3e9a2c ,1 ,9999 ,', '2020-01-06 23:08:14', 1, '', '', '');
INSERT INTO `operatelog` VALUES (448, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT@78d062f9 ,1 ,10 ,', '2020-01-06 23:08:14', 1, '', '', '');
INSERT INTO `operatelog` VALUES (449, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1156 ,', '2020-01-06 23:08:16', 1, '', '', '');
INSERT INTO `operatelog` VALUES (450, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIPageServiceImpl.getBIPageListPage(BI_Page,int,int); 操作参数: cn.zup.bi.entity.BI_Page@7cd4bb6a ,1 ,10 ,', '2020-01-06 23:08:16', 1, '', '', '');
INSERT INTO `operatelog` VALUES (451, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@59430e3c ,', '2020-01-06 23:08:16', 1, '', '', '');
INSERT INTO `operatelog` VALUES (452, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@a82451c ,', '2020-01-06 23:08:16', 1, '', '', '');
INSERT INTO `operatelog` VALUES (453, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@7adea495 ,1 ,9999 ,', '2020-01-06 23:08:16', 1, '', '', '');
INSERT INTO `operatelog` VALUES (454, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@3befd153 ,', '2020-01-06 23:08:16', 1, '', '', '');
INSERT INTO `operatelog` VALUES (455, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT@31e7dc79 ,1 ,10 ,', '2020-01-06 23:08:16', 1, '', '', '');
INSERT INTO `operatelog` VALUES (456, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@1eaf34d2 ,', '2020-01-06 23:08:19', 1, '', '', '');
INSERT INTO `operatelog` VALUES (457, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@62ff86ce ,', '2020-01-06 23:08:19', 1, '', '', '');
INSERT INTO `operatelog` VALUES (458, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-01-06 23:08:20', 1, '', '', '');
INSERT INTO `operatelog` VALUES (459, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldList(Integer); 操作参数: 170 ,', '2020-01-06 23:08:20', 1, '', '', '');
INSERT INTO `operatelog` VALUES (460, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getDimFieldList(Integer,List,List); 操作参数: 170 ,[] ,[] ,', '2020-01-06 23:08:20', 1, '', '', '');
INSERT INTO `operatelog` VALUES (461, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-01-06 23:08:20', 1, '', '', '');
INSERT INTO `operatelog` VALUES (462, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,1 ,', '2020-01-06 23:08:21', 1, '', '', '');
INSERT INTO `operatelog` VALUES (463, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@72a945d1 ,', '2020-01-06 23:09:25', 1, '', '', '');
INSERT INTO `operatelog` VALUES (464, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@203c9f14 ,', '2020-01-06 23:09:38', 1, '', '', '');
INSERT INTO `operatelog` VALUES (465, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIScreenServiceImpl.getBIScreenListPage(BI_Screen,int,int); 操作参数: cn.zup.bi.entity.BI_Screen@6788a48 ,1 ,10 ,', '2020-01-06 23:09:38', 1, '', '', '');
INSERT INTO `operatelog` VALUES (466, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-01-06 23:09:41', 1, '', '', '');
INSERT INTO `operatelog` VALUES (467, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2020-01-06 23:09:43', 1, '', '', '');
INSERT INTO `operatelog` VALUES (468, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@34ec6943 ,', '2020-01-06 23:09:43', 1, '', '', '');
INSERT INTO `operatelog` VALUES (469, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-01-06 23:09:43', 1, '', '', '');
INSERT INTO `operatelog` VALUES (470, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-01-06 23:09:43', 1, '', '', '');
INSERT INTO `operatelog` VALUES (471, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-01-06 23:09:43', 1, '', '', '');
INSERT INTO `operatelog` VALUES (472, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-01-06 23:09:43', 1, '', '', '');
INSERT INTO `operatelog` VALUES (473, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-01-06 23:09:43', 1, '', '', '');
INSERT INTO `operatelog` VALUES (474, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 5 ,', '2020-01-06 23:09:45', 1, '', '', '');
INSERT INTO `operatelog` VALUES (475, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,5 ,true ,', '2020-01-06 23:09:45', 1, '', '', '');
INSERT INTO `operatelog` VALUES (476, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 11 ,', '2020-01-06 23:09:45', 1, '', '', '');
INSERT INTO `operatelog` VALUES (477, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 6 ,', '2020-01-06 23:09:45', 1, '', '', '');
INSERT INTO `operatelog` VALUES (478, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 7 ,', '2020-01-06 23:09:45', 1, '', '', '');
INSERT INTO `operatelog` VALUES (479, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 8 ,', '2020-01-06 23:09:45', 1, '', '', '');
INSERT INTO `operatelog` VALUES (480, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 9 ,', '2020-01-06 23:09:45', 1, '', '', '');
INSERT INTO `operatelog` VALUES (481, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 10 ,', '2020-01-06 23:09:45', 1, '', '', '');
INSERT INTO `operatelog` VALUES (482, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 5 ,', '2020-01-06 23:09:48', 1, '', '', '');
INSERT INTO `operatelog` VALUES (483, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@13b9c739 ,', '2020-01-06 23:09:49', 1, '', '', '');
INSERT INTO `operatelog` VALUES (484, 1, 1, '', ' 操作层级: Service 层;  操作方法: boolean cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuRepeatVerify(Integer,int,int,String); 操作参数: null ,1 ,5 ,演示-商品 ,', '2020-01-06 23:10:41', 1, '', '', '');
INSERT INTO `operatelog` VALUES (485, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@6b39178e ,', '2020-01-06 23:10:41', 1, '', '', '');
INSERT INTO `operatelog` VALUES (486, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.ResourceServiceImpl.addMenu(Menu); 操作参数: cn.zup.rbac.entity.Menu@50ecc07d ,', '2020-01-06 23:10:41', 1, '', '', '');
INSERT INTO `operatelog` VALUES (487, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@5ff156a8 ,', '2020-01-06 23:10:41', 1, '', '', '');
INSERT INTO `operatelog` VALUES (488, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-01-06 23:10:41', 1, '', '', '');
INSERT INTO `operatelog` VALUES (489, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-01-06 23:10:41', 1, '', '', '');
INSERT INTO `operatelog` VALUES (490, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-01-06 23:10:41', 1, '', '', '');
INSERT INTO `operatelog` VALUES (491, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-01-06 23:10:41', 1, '', '', '');
INSERT INTO `operatelog` VALUES (492, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-01-06 23:10:41', 1, '', '', '');
INSERT INTO `operatelog` VALUES (493, 1, 1, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-01-06 23:11:31', 1, '', '', '');
INSERT INTO `operatelog` VALUES (494, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-01-06 23:11:31', 1, '', '', '');
INSERT INTO `operatelog` VALUES (495, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-06 23:11:32', 1, '', '', '');
INSERT INTO `operatelog` VALUES (496, 1, 1, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-01-06 23:11:51', 1, '', '', '');
INSERT INTO `operatelog` VALUES (497, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-01-06 23:11:51', 1, '', '', '');
INSERT INTO `operatelog` VALUES (498, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-06 23:11:51', 1, '', '', '');
INSERT INTO `operatelog` VALUES (499, 1, 1, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-01-06 23:12:17', 1, '', '', '');
INSERT INTO `operatelog` VALUES (500, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-01-06 23:12:17', 1, '', '', '');
INSERT INTO `operatelog` VALUES (501, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-06 23:12:18', 1, '', '', '');
INSERT INTO `operatelog` VALUES (502, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@2b78559b ,', '2020-01-06 23:12:19', 1, '', '', '');
INSERT INTO `operatelog` VALUES (503, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIPageServiceImpl.getBIPageListPage(BI_Page,int,int); 操作参数: cn.zup.bi.entity.BI_Page@9c6be25 ,1 ,10 ,', '2020-01-06 23:12:31', 1, '', '', '');
INSERT INTO `operatelog` VALUES (504, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1156 ,', '2020-01-06 23:12:31', 1, '', '', '');
INSERT INTO `operatelog` VALUES (505, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@391e6edc ,', '2020-01-06 23:12:31', 1, '', '', '');
INSERT INTO `operatelog` VALUES (506, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@7879f76b ,', '2020-01-06 23:12:31', 1, '', '', '');
INSERT INTO `operatelog` VALUES (507, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@3ad6f6d2 ,', '2020-01-06 23:12:32', 1, '', '', '');
INSERT INTO `operatelog` VALUES (508, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-01-06 23:14:04', 1, '', '', '');
INSERT INTO `operatelog` VALUES (509, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@7bae0621 ,', '2020-01-06 23:14:04', 1, '', '', '');
INSERT INTO `operatelog` VALUES (510, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@7b7231ac ,', '2020-01-06 23:14:04', 1, '', '', '');
INSERT INTO `operatelog` VALUES (511, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIPageServiceImpl.getBIPageListPage(BI_Page,int,int); 操作参数: cn.zup.bi.entity.BI_Page@74c09ea4 ,1 ,10 ,', '2020-01-06 23:14:04', 1, '', '', '');
INSERT INTO `operatelog` VALUES (512, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@4526f0ea ,', '2020-01-06 23:14:05', 1, '', '', '');
INSERT INTO `operatelog` VALUES (513, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@7cb0fa74 ,', '2020-01-06 23:16:48', 1, '', '', '');
INSERT INTO `operatelog` VALUES (514, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@2eb366a5 ,', '2020-01-06 23:16:48', 1, '', '', '');
INSERT INTO `operatelog` VALUES (515, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIPageServiceImpl.getBIPageListPage(BI_Page,int,int); 操作参数: cn.zup.bi.entity.BI_Page@479e01d3 ,1 ,10 ,', '2020-01-06 23:16:48', 1, '', '', '');
INSERT INTO `operatelog` VALUES (517, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@4b32d96a ,', '2020-01-06 23:17:22', 1, '', '', '');
INSERT INTO `operatelog` VALUES (518, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@42380746 ,', '2020-01-06 23:17:22', 1, '', '', '');
INSERT INTO `operatelog` VALUES (519, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIPageServiceImpl.getBIPageListPage(BI_Page,int,int); 操作参数: cn.zup.bi.entity.BI_Page@26466266 ,1 ,10 ,', '2020-01-06 23:17:22', 1, '', '', '');
INSERT INTO `operatelog` VALUES (520, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-01-06 23:17:22', 1, '', '', '');
INSERT INTO `operatelog` VALUES (521, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@26f8b19f ,', '2020-01-06 23:17:28', 1, '', '', '');
INSERT INTO `operatelog` VALUES (522, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIPageServiceImpl.getBIPageListPage(BI_Page,int,int); 操作参数: cn.zup.bi.entity.BI_Page@670b4cfd ,1 ,10 ,', '2020-01-06 23:19:53', 1, '', '', '');
INSERT INTO `operatelog` VALUES (523, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-01-06 23:19:53', 1, '', '', '');
INSERT INTO `operatelog` VALUES (524, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@267e40a2 ,', '2020-01-06 23:19:53', 1, '', '', '');
INSERT INTO `operatelog` VALUES (525, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@71804ef3 ,', '2020-01-06 23:19:53', 1, '', '', '');
INSERT INTO `operatelog` VALUES (526, 1, 1, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-01-06 23:20:56', 1, '', '', '');
INSERT INTO `operatelog` VALUES (527, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-01-06 23:20:56', 1, '', '', '');
INSERT INTO `operatelog` VALUES (528, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-01-06 23:20:58', 1, '', '', '');
INSERT INTO `operatelog` VALUES (529, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@400f33c9 ,', '2020-01-06 23:21:00', 1, '', '', '');
INSERT INTO `operatelog` VALUES (530, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@7c3d320a ,', '2020-01-06 23:21:00', 1, '', '', '');
INSERT INTO `operatelog` VALUES (531, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@2cf1eeb1 ,', '2020-01-06 23:21:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (532, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@61fb821f ,', '2020-01-06 23:21:56', 1, '', '', '');
INSERT INTO `operatelog` VALUES (533, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@38db2fea ,', '2020-01-06 23:21:59', 1, '', '', '');
INSERT INTO `operatelog` VALUES (534, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@20110132 ,', '2020-01-06 23:22:01', 1, '', '', '');
INSERT INTO `operatelog` VALUES (535, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT@6e793910 ,1 ,10 ,', '2020-01-06 23:22:06', 1, '', '', '');
INSERT INTO `operatelog` VALUES (536, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@189cc78 ,', '2020-01-06 23:22:06', 1, '', '', '');
INSERT INTO `operatelog` VALUES (537, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC,int,int); 操作参数: cn.zup.bi.entity.BI_TOPIC@5aabb40 ,1 ,9999 ,', '2020-01-06 23:22:06', 1, '', '', '');
INSERT INTO `operatelog` VALUES (538, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-01-06 23:22:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (539, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIPageServiceImpl.getBIPageListPage(BI_Page,int,int); 操作参数: cn.zup.bi.entity.BI_Page@3af806dd ,1 ,10 ,', '2020-01-06 23:22:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (540, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@4f7fa692 ,', '2020-01-06 23:22:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (541, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@7e905e0e ,', '2020-01-06 23:22:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (542, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@3d139861 ,', '2020-01-06 23:22:15', 1, '', '', '');
INSERT INTO `operatelog` VALUES (543, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@35d7c669 ,', '2020-01-06 23:22:21', 1, '', '', '');
INSERT INTO `operatelog` VALUES (544, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.ReportServiceImpl.saveReport(BI_REPORT); 操作参数: cn.zup.bi.entity.BI_REPORT@244295fa ,', '2020-01-06 23:22:41', 1, '', '', '');
INSERT INTO `operatelog` VALUES (545, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@e2abe65 ,', '2020-01-06 23:22:41', 1, '', '', '');
INSERT INTO `operatelog` VALUES (546, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT,int,int); 操作参数: cn.zup.bi.entity.BI_REPORT@3e2d538f ,1 ,10 ,', '2020-01-06 23:22:41', 1, '', '', '');
INSERT INTO `operatelog` VALUES (547, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@33a2f3eb ,', '2020-01-06 23:22:49', 1, '', '', '');
INSERT INTO `operatelog` VALUES (548, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@137312ef ,', '2020-01-06 23:22:49', 1, '', '', '');
INSERT INTO `operatelog` VALUES (549, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@73d7cff8 ,', '2020-01-06 23:24:26', 1, '', '', '');
INSERT INTO `operatelog` VALUES (550, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@4cf7f289 ,', '2020-01-06 23:24:26', 1, '', '', '');
INSERT INTO `operatelog` VALUES (551, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 0 ,0 ,null ,', '2020-01-06 23:24:27', 1, '', '', '');
INSERT INTO `operatelog` VALUES (552, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 30 ,0 ,', '2020-01-06 23:24:27', 1, '', '', '');
INSERT INTO `operatelog` VALUES (553, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@446f90d8 ,', '2020-01-06 23:24:36', 1, '', '', '');
INSERT INTO `operatelog` VALUES (554, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@24d09ca ,', '2020-01-06 23:24:36', 1, '', '', '');
INSERT INTO `operatelog` VALUES (555, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 0 ,0 ,null ,', '2020-01-06 23:24:36', 1, '', '', '');
INSERT INTO `operatelog` VALUES (556, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 30 ,0 ,', '2020-01-06 23:24:36', 1, '', '', '');
INSERT INTO `operatelog` VALUES (557, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@2597e1f7 ,', '2020-01-06 23:24:48', 1, '', '', '');
INSERT INTO `operatelog` VALUES (558, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@3a8a633a ,', '2020-01-06 23:24:48', 1, '', '', '');
INSERT INTO `operatelog` VALUES (559, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-01-06 23:24:48', 1, '', '', '');
INSERT INTO `operatelog` VALUES (560, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldList(Integer); 操作参数: 170 ,', '2020-01-06 23:24:49', 1, '', '', '');
INSERT INTO `operatelog` VALUES (561, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getDimFieldList(Integer,List,List); 操作参数: 170 ,[] ,[] ,', '2020-01-06 23:24:49', 1, '', '', '');
INSERT INTO `operatelog` VALUES (562, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-01-06 23:24:49', 1, '', '', '');
INSERT INTO `operatelog` VALUES (563, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,1 ,', '2020-01-06 23:24:49', 1, '', '', '');
INSERT INTO `operatelog` VALUES (564, 1, 1, '', ' 操作层级: Service 层;  操作方法: boolean cn.zup.bi.service.impl.BIPageBlockServiceImpl.updateBlock(BI_Block_Info); 操作参数: cn.zup.bi.entity.BI_Block_Info@5efd70f ,', '2020-01-06 23:25:03', 1, '', '', '');
INSERT INTO `operatelog` VALUES (565, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,546 ,', '2020-01-06 23:25:03', 1, '', '', '');
INSERT INTO `operatelog` VALUES (566, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldList(Integer); 操作参数: 170 ,', '2020-01-06 23:25:03', 1, '', '', '');
INSERT INTO `operatelog` VALUES (567, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getDimFieldList(Integer,List,List); 操作参数: 170 ,[] ,[] ,', '2020-01-06 23:25:03', 1, '', '', '');
INSERT INTO `operatelog` VALUES (568, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-01-06 23:25:03', 1, '', '', '');
INSERT INTO `operatelog` VALUES (569, 1, 1, '', ' 操作层级: Service 层;  操作方法: Integer cn.zup.bi.service.impl.BIPageBlockServiceImpl.saveBlock(BI_Block_Info); 操作参数: cn.zup.bi.entity.BI_Block_Info@3ae883dd ,', '2020-01-06 23:25:07', 1, '', '', '');
INSERT INTO `operatelog` VALUES (570, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-01-06 23:25:07', 1, '', '', '');
INSERT INTO `operatelog` VALUES (571, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldList(Integer); 操作参数: 170 ,', '2020-01-06 23:25:07', 1, '', '', '');
INSERT INTO `operatelog` VALUES (572, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getDimFieldList(Integer,List,List); 操作参数: 170 ,[] ,[] ,', '2020-01-06 23:25:07', 1, '', '', '');
INSERT INTO `operatelog` VALUES (573, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-01-06 23:25:07', 1, '', '', '');
INSERT INTO `operatelog` VALUES (574, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldList(Integer); 操作参数: 170 ,', '2020-01-06 23:25:07', 1, '', '', '');
INSERT INTO `operatelog` VALUES (575, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getDimFieldList(Integer,List,List); 操作参数: 170 ,[] ,[] ,', '2020-01-06 23:25:07', 1, '', '', '');
INSERT INTO `operatelog` VALUES (576, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-01-06 23:25:07', 1, '', '', '');
INSERT INTO `operatelog` VALUES (577, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 29 ,1 ,', '2020-01-06 23:25:08', 1, '', '', '');
INSERT INTO `operatelog` VALUES (578, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIScreenServiceImpl.getBIScreenListPage(BI_Screen,int,int); 操作参数: cn.zup.bi.entity.BI_Screen@ffe954a ,1 ,10 ,', '2020-01-06 23:25:33', 1, '', '', '');
INSERT INTO `operatelog` VALUES (579, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@231cf753 ,', '2020-01-06 23:25:33', 1, '', '', '');
INSERT INTO `operatelog` VALUES (580, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@45fa12ae ,', '2020-01-06 23:25:36', 1, '', '', '');
INSERT INTO `operatelog` VALUES (581, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@14d86ecc ,', '2020-01-06 23:25:36', 1, '', '', '');
INSERT INTO `operatelog` VALUES (582, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 0 ,0 ,null ,', '2020-01-06 23:25:37', 1, '', '', '');
INSERT INTO `operatelog` VALUES (583, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 30 ,0 ,', '2020-01-06 23:25:37', 1, '', '', '');
INSERT INTO `operatelog` VALUES (584, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@5ca38297 ,', '2020-01-06 23:26:12', 1, '', '', '');
INSERT INTO `operatelog` VALUES (585, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@8fc83fc ,', '2020-01-06 23:26:17', 1, '', '', '');
INSERT INTO `operatelog` VALUES (586, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@2a060f70 ,', '2020-01-06 23:26:21', 1, '', '', '');
INSERT INTO `operatelog` VALUES (587, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.BIScreenServiceImpl.updateScreenInfo(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@2a8b0a1b ,', '2020-01-06 23:26:26', 1, '', '', '');
INSERT INTO `operatelog` VALUES (588, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@7ab5867 ,', '2020-01-06 23:26:26', 1, '', '', '');
INSERT INTO `operatelog` VALUES (589, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.bi.service.impl.BIScreenServiceImpl.getBIScreenListPage(BI_Screen,int,int); 操作参数: cn.zup.bi.entity.BI_Screen@76d62288 ,1 ,10 ,', '2020-01-06 23:26:26', 1, '', '', '');
INSERT INTO `operatelog` VALUES (590, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@623bdb40 ,', '2020-01-06 23:26:31', 1, '', '', '');
INSERT INTO `operatelog` VALUES (591, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@11472a05 ,', '2020-01-06 23:26:31', 1, '', '', '');
INSERT INTO `operatelog` VALUES (592, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 30 ,1 ,null ,', '2020-01-06 23:26:32', 1, '', '', '');
INSERT INTO `operatelog` VALUES (593, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 30 ,1 ,', '2020-01-06 23:26:32', 1, '', '', '');
INSERT INTO `operatelog` VALUES (594, 1, 1, '', ' 操作层级: Service 层;  操作方法: Integer cn.zup.bi.service.impl.BIPageBlockServiceImpl.saveBlock(BI_Block_Info); 操作参数: cn.zup.bi.entity.BI_Block_Info@61d0631d ,', '2020-01-06 23:26:35', 1, '', '', '');
INSERT INTO `operatelog` VALUES (595, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 30 ,1 ,null ,', '2020-01-06 23:26:35', 1, '', '', '');
INSERT INTO `operatelog` VALUES (596, 1, 1, '', ' 操作层级: Service 层;  操作方法: Integer cn.zup.bi.service.impl.BIPageBlockServiceImpl.saveBlock(BI_Block_Info); 操作参数: cn.zup.bi.entity.BI_Block_Info@2ec8449d ,', '2020-01-06 23:26:38', 1, '', '', '');
INSERT INTO `operatelog` VALUES (597, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 30 ,1 ,null ,', '2020-01-06 23:26:38', 1, '', '', '');
INSERT INTO `operatelog` VALUES (598, 1, 1, '', ' 操作层级: Service 层;  操作方法: Integer cn.zup.bi.service.impl.BIPageBlockServiceImpl.saveBlock(BI_Block_Info); 操作参数: cn.zup.bi.entity.BI_Block_Info@76e94258 ,', '2020-01-06 23:26:40', 1, '', '', '');
INSERT INTO `operatelog` VALUES (599, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 30 ,1 ,null ,', '2020-01-06 23:26:40', 1, '', '', '');
INSERT INTO `operatelog` VALUES (600, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@44a0fd9c ,', '2020-01-06 23:26:41', 1, '', '', '');
INSERT INTO `operatelog` VALUES (601, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@45fc55bc ,', '2020-01-06 23:26:41', 1, '', '', '');
INSERT INTO `operatelog` VALUES (602, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 30 ,1 ,null ,', '2020-01-06 23:26:42', 1, '', '', '');
INSERT INTO `operatelog` VALUES (603, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@4652fd85 ,', '2020-01-06 23:26:50', 1, '', '', '');
INSERT INTO `operatelog` VALUES (604, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@7ff46f8b ,', '2020-01-06 23:26:50', 1, '', '', '');
INSERT INTO `operatelog` VALUES (605, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 30 ,1 ,null ,', '2020-01-06 23:26:50', 1, '', '', '');
INSERT INTO `operatelog` VALUES (606, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@78eafb0e ,', '2020-01-06 23:27:40', 1, '', '', '');
INSERT INTO `operatelog` VALUES (607, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@5b120e41 ,', '2020-01-06 23:27:40', 1, '', '', '');
INSERT INTO `operatelog` VALUES (608, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 30 ,1 ,null ,', '2020-01-06 23:27:40', 1, '', '', '');
INSERT INTO `operatelog` VALUES (609, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@627ab084 ,', '2020-01-06 23:27:47', 1, '', '', '');
INSERT INTO `operatelog` VALUES (610, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@18c1137e ,', '2020-01-06 23:27:47', 1, '', '', '');
INSERT INTO `operatelog` VALUES (611, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 30 ,1 ,null ,', '2020-01-06 23:27:48', 1, '', '', '');
INSERT INTO `operatelog` VALUES (612, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: cn.zup.bi.entity.BI_Page@7567b8ae ,', '2020-01-06 23:28:25', 1, '', '', '');
INSERT INTO `operatelog` VALUES (613, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: cn.zup.bi.entity.BI_Screen@33a2fdbd ,', '2020-01-06 23:28:25', 1, '', '', '');
INSERT INTO `operatelog` VALUES (614, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 30 ,1 ,null ,', '2020-01-06 23:28:25', 1, '', '', '');
INSERT INTO `operatelog` VALUES (615, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldList(Integer); 操作参数: 170 ,', '2020-01-06 23:28:25', 1, '', '', '');
INSERT INTO `operatelog` VALUES (616, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getDimFieldList(Integer,List,List); 操作参数: 170 ,[] ,[] ,', '2020-01-06 23:28:25', 1, '', '', '');
INSERT INTO `operatelog` VALUES (617, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-01-06 23:28:25', 1, '', '', '');
INSERT INTO `operatelog` VALUES (618, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldList(Integer); 操作参数: 170 ,', '2020-01-06 23:28:25', 1, '', '', '');
INSERT INTO `operatelog` VALUES (619, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getDimFieldList(Integer,List,List); 操作参数: 170 ,[] ,[] ,', '2020-01-06 23:28:25', 1, '', '', '');
INSERT INTO `operatelog` VALUES (620, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-01-06 23:28:25', 1, '', '', '');
INSERT INTO `operatelog` VALUES (621, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 30 ,1 ,', '2020-01-06 23:28:25', 1, '', '', '');
INSERT INTO `operatelog` VALUES (622, 1, 1, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-02-12 17:23:04', 1, '', '', '');
INSERT INTO `operatelog` VALUES (623, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-02-12 17:23:04', 1, '', '', '');
INSERT INTO `operatelog` VALUES (624, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-02-12 17:23:06', 1, '', '', '');
INSERT INTO `operatelog` VALUES (625, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:23:07', 1, '', '', '');
INSERT INTO `operatelog` VALUES (626, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC); 操作参数: BI_TOPIC(topic_Id=null, topic_Name=null, topic_Caption=null, topic_Type=null, biz_Table_Name=null, ds_id=null) ,', '2020-02-12 17:23:07', 1, '', '', '');
INSERT INTO `operatelog` VALUES (627, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getDimPagingList(BI_DIM); 操作参数: BI_DIM(dim_Id=null, dim_Name=null, biz_Table_Name=null, text_Field=null, id_Field=null, drill_Type=null, drill_Info=null, ds_Id=null) ,', '2020-02-12 17:23:08', 1, '', '', '');
INSERT INTO `operatelog` VALUES (628, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(Integer,Menu); 操作参数: 1 ,cn.zup.rbac.entity.Menu@7936c4d4 ,', '2020-02-12 17:23:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (629, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@5ae29978 ,', '2020-02-12 17:23:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (630, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@53f86b6b ,', '2020-02-12 17:23:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (631, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=29, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:23:16', 1, '', '', '');
INSERT INTO `operatelog` VALUES (632, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@7b3a5e02 ,', '2020-02-12 17:23:16', 1, '', '', '');
INSERT INTO `operatelog` VALUES (633, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@5b73edf0 ,', '2020-02-12 17:23:26', 1, '', '', '');
INSERT INTO `operatelog` VALUES (634, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@67c4b215 ,', '2020-02-12 17:23:36', 1, '', '', '');
INSERT INTO `operatelog` VALUES (635, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:23:37', 1, '', '', '');
INSERT INTO `operatelog` VALUES (636, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBIScreenListPage(BI_Screen,int,int); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=29, page_Name=null) ,1 ,10 ,', '2020-02-12 17:23:37', 1, '', '', '');
INSERT INTO `operatelog` VALUES (637, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@be22451 ,', '2020-02-12 17:23:42', 1, '', '', '');
INSERT INTO `operatelog` VALUES (638, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC); 操作参数: BI_TOPIC(topic_Id=null, topic_Name=null, topic_Caption=null, topic_Type=null, biz_Table_Name=null, ds_id=null) ,', '2020-02-12 17:23:42', 1, '', '', '');
INSERT INTO `operatelog` VALUES (639, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:23:42', 1, '', '', '');
INSERT INTO `operatelog` VALUES (640, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT); 操作参数: BI_REPORT(report_Id=null, topic_Id=null, report_Name=null, page_Id=29, report_Title=null, create_Date=null, topic_Name=null, page_Name=null) ,', '2020-02-12 17:23:42', 1, '', '', '');
INSERT INTO `operatelog` VALUES (641, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-02-12 17:23:44', 1, '', '', '');
INSERT INTO `operatelog` VALUES (642, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@371c7ea9 ,', '2020-02-12 17:23:44', 1, '', '', '');
INSERT INTO `operatelog` VALUES (643, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@75c37f85 ,', '2020-02-12 17:23:49', 1, '', '', '');
INSERT INTO `operatelog` VALUES (644, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@53ba84b3 ,', '2020-02-12 17:23:51', 1, '', '', '');
INSERT INTO `operatelog` VALUES (645, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-02-12 17:23:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (646, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFields(Integer); 操作参数: 45 ,', '2020-02-12 17:23:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (647, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=198409, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:24:00', 1, '', '', '');
INSERT INTO `operatelog` VALUES (648, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=29, page_Name=null) ,', '2020-02-12 17:24:00', 1, '', '', '');
INSERT INTO `operatelog` VALUES (649, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-02-12 17:24:01', 1, '', '', '');
INSERT INTO `operatelog` VALUES (650, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=198409, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:24:06', 1, '', '', '');
INSERT INTO `operatelog` VALUES (651, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=29, page_Name=null) ,', '2020-02-12 17:24:06', 1, '', '', '');
INSERT INTO `operatelog` VALUES (652, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-02-12 17:24:06', 1, '', '', '');
INSERT INTO `operatelog` VALUES (653, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@75e02775 ,', '2020-02-12 17:24:12', 1, '', '', '');
INSERT INTO `operatelog` VALUES (654, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@3434c7e2 ,', '2020-02-12 17:24:27', 1, '', '', '');
INSERT INTO `operatelog` VALUES (655, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(Integer,Menu); 操作参数: 1 ,cn.zup.rbac.entity.Menu@39ca9e03 ,', '2020-02-12 17:24:36', 1, '', '', '');
INSERT INTO `operatelog` VALUES (656, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@3e263ce6 ,', '2020-02-12 17:24:36', 1, '', '', '');
INSERT INTO `operatelog` VALUES (657, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@44953c35 ,', '2020-02-12 17:24:36', 1, '', '', '');
INSERT INTO `operatelog` VALUES (658, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@5eb0e6ba ,', '2020-02-12 17:24:38', 1, '', '', '');
INSERT INTO `operatelog` VALUES (659, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@55e08f9 ,', '2020-02-12 17:24:46', 1, '', '', '');
INSERT INTO `operatelog` VALUES (660, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@78f1ef5d ,', '2020-02-12 17:24:51', 1, '', '', '');
INSERT INTO `operatelog` VALUES (661, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@2a4a6636 ,', '2020-02-12 17:24:54', 1, '', '', '');
INSERT INTO `operatelog` VALUES (662, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBIScreenListPage(BI_Screen,int,int); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=29, page_Name=null) ,1 ,10 ,', '2020-02-12 17:24:54', 1, '', '', '');
INSERT INTO `operatelog` VALUES (663, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:24:54', 1, '', '', '');
INSERT INTO `operatelog` VALUES (664, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@6fe5fc20 ,', '2020-02-12 17:25:00', 1, '', '', '');
INSERT INTO `operatelog` VALUES (665, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:25:00', 1, '', '', '');
INSERT INTO `operatelog` VALUES (666, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBIScreenListPage(BI_Screen,int,int); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=31, page_Name=null) ,1 ,10 ,', '2020-02-12 17:25:00', 1, '', '', '');
INSERT INTO `operatelog` VALUES (667, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@6ed7adc1 ,', '2020-02-12 17:25:02', 1, '', '', '');
INSERT INTO `operatelog` VALUES (668, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.BIScreenServiceImpl.updateScreenInfo(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=1, screen_Name=首页, page_Id=31, page_Name=null) ,', '2020-02-12 17:25:06', 1, '', '', '');
INSERT INTO `operatelog` VALUES (669, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBIScreenListPage(BI_Screen,int,int); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=31, page_Name=null) ,1 ,10 ,', '2020-02-12 17:25:06', 1, '', '', '');
INSERT INTO `operatelog` VALUES (670, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@50eec9cc ,', '2020-02-12 17:25:06', 1, '', '', '');
INSERT INTO `operatelog` VALUES (671, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@14870a12 ,', '2020-02-12 17:25:07', 1, '', '', '');
INSERT INTO `operatelog` VALUES (672, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@18606938 ,', '2020-02-12 17:25:10', 1, '', '', '');
INSERT INTO `operatelog` VALUES (673, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT); 操作参数: BI_REPORT(report_Id=null, topic_Id=null, report_Name=null, page_Id=31, report_Title=null, create_Date=null, topic_Name=null, page_Name=null) ,', '2020-02-12 17:25:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (674, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC); 操作参数: BI_TOPIC(topic_Id=null, topic_Name=null, topic_Caption=null, topic_Type=null, biz_Table_Name=null, ds_id=null) ,', '2020-02-12 17:25:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (675, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:25:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (676, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@67572af4 ,', '2020-02-12 17:25:12', 1, '', '', '');
INSERT INTO `operatelog` VALUES (677, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT); 操作参数: BI_REPORT(report_Id=null, topic_Id=null, report_Name=null, page_Id=31, report_Title=null, create_Date=null, topic_Name=null, page_Name=null) ,', '2020-02-12 17:25:27', 1, '', '', '');
INSERT INTO `operatelog` VALUES (678, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@575c409b ,', '2020-02-12 17:25:27', 1, '', '', '');
INSERT INTO `operatelog` VALUES (679, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@3ebbf5b4 ,', '2020-02-12 17:25:28', 1, '', '', '');
INSERT INTO `operatelog` VALUES (680, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@13360b2f ,', '2020-02-12 17:25:30', 1, '', '', '');
INSERT INTO `operatelog` VALUES (681, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 172 ,', '2020-02-12 17:25:30', 1, '', '', '');
INSERT INTO `operatelog` VALUES (682, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFields(Integer); 操作参数: 45 ,', '2020-02-12 17:25:30', 1, '', '', '');
INSERT INTO `operatelog` VALUES (683, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@5bbcdef2 ,', '2020-02-12 17:25:31', 1, '', '', '');
INSERT INTO `operatelog` VALUES (684, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.ReportFieldServiceImpl.saveReportField(BI_REPORT_FIELD); 操作参数: BI_REPORT_FIELD(report_Field_Id=null, report_Id=172, field_Id=217, field_Location=1, dim_Order=1, display=1, field_Name=null) ,', '2020-02-12 17:25:38', 1, '', '', '');
INSERT INTO `operatelog` VALUES (685, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@3ef0c9ed ,', '2020-02-12 17:25:38', 1, '', '', '');
INSERT INTO `operatelog` VALUES (686, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@534bfe80 ,', '2020-02-12 17:25:40', 1, '', '', '');
INSERT INTO `operatelog` VALUES (687, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@7338386 ,', '2020-02-12 17:25:41', 1, '', '', '');
INSERT INTO `operatelog` VALUES (688, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.ReportFieldServiceImpl.saveReportField(BI_REPORT_FIELD); 操作参数: BI_REPORT_FIELD(report_Field_Id=null, report_Id=172, field_Id=219, field_Location=3, dim_Order=1, display=1, field_Name=null) ,', '2020-02-12 17:25:47', 1, '', '', '');
INSERT INTO `operatelog` VALUES (689, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@174630d6 ,', '2020-02-12 17:25:47', 1, '', '', '');
INSERT INTO `operatelog` VALUES (690, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@197b8928 ,', '2020-02-12 17:25:48', 1, '', '', '');
INSERT INTO `operatelog` VALUES (691, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=93097, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:25:53', 1, '', '', '');
INSERT INTO `operatelog` VALUES (692, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=31, page_Name=null) ,', '2020-02-12 17:25:53', 1, '', '', '');
INSERT INTO `operatelog` VALUES (693, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 31 ,1 ,null ,', '2020-02-12 17:25:54', 1, '', '', '');
INSERT INTO `operatelog` VALUES (694, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 31 ,1 ,', '2020-02-12 17:25:54', 1, '', '', '');
INSERT INTO `operatelog` VALUES (695, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 31 ,1 ,null ,', '2020-02-12 17:25:56', 1, '', '', '');
INSERT INTO `operatelog` VALUES (696, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldList(Integer); 操作参数: 172 ,', '2020-02-12 17:25:56', 1, '', '', '');
INSERT INTO `operatelog` VALUES (697, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getDimFieldList(ConditionTransfer); 操作参数: cn.zup.bi.entity.ConditionTransfer@75032ad1 ,', '2020-02-12 17:25:56', 1, '', '', '');
INSERT INTO `operatelog` VALUES (698, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 172 ,', '2020-02-12 17:25:56', 1, '', '', '');
INSERT INTO `operatelog` VALUES (699, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 31 ,1 ,', '2020-02-12 17:25:56', 1, '', '', '');
INSERT INTO `operatelog` VALUES (700, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-02-12 17:26:16', 1, '', '', '');
INSERT INTO `operatelog` VALUES (701, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(Integer,Menu); 操作参数: 1 ,cn.zup.rbac.entity.Menu@4146e0e5 ,', '2020-02-12 17:26:18', 1, '', '', '');
INSERT INTO `operatelog` VALUES (702, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@391df67 ,', '2020-02-12 17:26:18', 1, '', '', '');
INSERT INTO `operatelog` VALUES (703, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@7549842 ,', '2020-02-12 17:26:18', 1, '', '', '');
INSERT INTO `operatelog` VALUES (704, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:26:19', 1, '', '', '');
INSERT INTO `operatelog` VALUES (705, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC); 操作参数: BI_TOPIC(topic_Id=null, topic_Name=null, topic_Caption=null, topic_Type=null, biz_Table_Name=null, ds_id=null) ,', '2020-02-12 17:26:19', 1, '', '', '');
INSERT INTO `operatelog` VALUES (706, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT); 操作参数: BI_REPORT(report_Id=null, topic_Id=null, report_Name=null, page_Id=null, report_Title=null, create_Date=null, topic_Name=null, page_Name=null) ,', '2020-02-12 17:26:19', 1, '', '', '');
INSERT INTO `operatelog` VALUES (707, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:26:23', 1, '', '', '');
INSERT INTO `operatelog` VALUES (708, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBIScreenListPage(BI_Screen,int,int); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=null, page_Name=null) ,1 ,10 ,', '2020-02-12 17:26:23', 1, '', '', '');
INSERT INTO `operatelog` VALUES (709, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=13, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:27:01', 1, '', '', '');
INSERT INTO `operatelog` VALUES (710, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=30, page_Name=null) ,', '2020-02-12 17:27:01', 1, '', '', '');
INSERT INTO `operatelog` VALUES (711, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 30 ,1 ,null ,', '2020-02-12 17:27:01', 1, '', '', '');
INSERT INTO `operatelog` VALUES (712, 1, 1, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-02-12 17:27:08', 1, '', '', '');
INSERT INTO `operatelog` VALUES (713, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-02-12 17:27:08', 1, '', '', '');
INSERT INTO `operatelog` VALUES (714, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-02-12 17:27:09', 1, '', '', '');
INSERT INTO `operatelog` VALUES (715, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC); 操作参数: BI_TOPIC(topic_Id=null, topic_Name=null, topic_Caption=null, topic_Type=null, biz_Table_Name=null, ds_id=null) ,', '2020-02-12 17:27:10', 1, '', '', '');
INSERT INTO `operatelog` VALUES (716, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(Integer,Menu); 操作参数: 1 ,cn.zup.rbac.entity.Menu@1a66f8fb ,', '2020-02-12 17:27:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (717, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@3a96b980 ,', '2020-02-12 17:27:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (718, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@1f76ede1 ,', '2020-02-12 17:27:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (719, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=93097, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:27:13', 1, '', '', '');
INSERT INTO `operatelog` VALUES (720, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=31, page_Name=null) ,', '2020-02-12 17:27:13', 1, '', '', '');
INSERT INTO `operatelog` VALUES (721, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 31 ,1 ,null ,', '2020-02-12 17:27:14', 1, '', '', '');
INSERT INTO `operatelog` VALUES (722, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldList(Integer); 操作参数: 172 ,', '2020-02-12 17:27:14', 1, '', '', '');
INSERT INTO `operatelog` VALUES (723, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getDimFieldList(ConditionTransfer); 操作参数: cn.zup.bi.entity.ConditionTransfer@6c38fdf5 ,', '2020-02-12 17:27:14', 1, '', '', '');
INSERT INTO `operatelog` VALUES (724, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 172 ,', '2020-02-12 17:27:14', 1, '', '', '');
INSERT INTO `operatelog` VALUES (725, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 31 ,1 ,', '2020-02-12 17:27:14', 1, '', '', '');
INSERT INTO `operatelog` VALUES (726, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=166349, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:27:16', 1, '', '', '');
INSERT INTO `operatelog` VALUES (727, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=29, page_Name=null) ,', '2020-02-12 17:27:16', 1, '', '', '');
INSERT INTO `operatelog` VALUES (728, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 29 ,1 ,null ,', '2020-02-12 17:27:17', 1, '', '', '');
INSERT INTO `operatelog` VALUES (729, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@43efe107 ,', '2020-02-12 17:27:22', 1, '', '', '');
INSERT INTO `operatelog` VALUES (730, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.BIPageServiceImpl.deletePageInfo(int); 操作参数: 29 ,', '2020-02-12 17:27:23', 1, '', '', '');
INSERT INTO `operatelog` VALUES (731, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@3e26ff10 ,', '2020-02-12 17:27:27', 1, '', '', '');
INSERT INTO `operatelog` VALUES (732, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@1df1131 ,', '2020-02-12 17:27:27', 1, '', '', '');
INSERT INTO `operatelog` VALUES (733, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(Integer,Menu); 操作参数: 1 ,cn.zup.rbac.entity.Menu@72ac9ce0 ,', '2020-02-12 17:27:27', 1, '', '', '');
INSERT INTO `operatelog` VALUES (734, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@187686fb ,', '2020-02-12 17:28:15', 1, '', '', '');
INSERT INTO `operatelog` VALUES (735, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:28:15', 1, '', '', '');
INSERT INTO `operatelog` VALUES (736, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBIScreenListPage(BI_Screen,int,int); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=29, page_Name=null) ,1 ,10 ,', '2020-02-12 17:28:15', 1, '', '', '');
INSERT INTO `operatelog` VALUES (737, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@77a62f9a ,', '2020-02-12 17:28:17', 1, '', '', '');
INSERT INTO `operatelog` VALUES (738, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.BIScreenServiceImpl.deleteScreenInfo(int); 操作参数: 31 ,', '2020-02-12 17:28:18', 1, '', '', '');
INSERT INTO `operatelog` VALUES (739, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBIScreenListPage(BI_Screen,int,int); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=29, page_Name=null) ,1 ,10 ,', '2020-02-12 17:28:18', 1, '', '', '');
INSERT INTO `operatelog` VALUES (740, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@39aaa7b9 ,', '2020-02-12 17:28:18', 1, '', '', '');
INSERT INTO `operatelog` VALUES (741, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@50b4fa24 ,', '2020-02-12 17:28:20', 1, '', '', '');
INSERT INTO `operatelog` VALUES (742, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@fad00d0 ,', '2020-02-12 17:28:24', 1, '', '', '');
INSERT INTO `operatelog` VALUES (743, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:28:24', 1, '', '', '');
INSERT INTO `operatelog` VALUES (744, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC); 操作参数: BI_TOPIC(topic_Id=null, topic_Name=null, topic_Caption=null, topic_Type=null, biz_Table_Name=null, ds_id=null) ,', '2020-02-12 17:28:24', 1, '', '', '');
INSERT INTO `operatelog` VALUES (745, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT); 操作参数: BI_REPORT(report_Id=null, topic_Id=null, report_Name=null, page_Id=29, report_Title=null, create_Date=null, topic_Name=null, page_Name=null) ,', '2020-02-12 17:28:24', 1, '', '', '');
INSERT INTO `operatelog` VALUES (746, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@16132169 ,', '2020-02-12 17:28:26', 1, '', '', '');
INSERT INTO `operatelog` VALUES (747, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-02-12 17:28:26', 1, '', '', '');
INSERT INTO `operatelog` VALUES (748, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFields(Integer); 操作参数: 45 ,', '2020-02-12 17:28:26', 1, '', '', '');
INSERT INTO `operatelog` VALUES (749, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@6589344a ,', '2020-02-12 17:28:29', 1, '', '', '');
INSERT INTO `operatelog` VALUES (750, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.bi.service.impl.ReportFieldServiceImpl.deleteRpoetField(int); 操作参数: 579 ,', '2020-02-12 17:28:30', 1, '', '', '');
INSERT INTO `operatelog` VALUES (751, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.bi.service.impl.ReportFieldServiceImpl.deleteRpoetField(int); 操作参数: 578 ,', '2020-02-12 17:28:30', 1, '', '', '');
INSERT INTO `operatelog` VALUES (752, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.bi.service.impl.ReportFieldServiceImpl.deleteRpoetField(int); 操作参数: 577 ,', '2020-02-12 17:28:30', 1, '', '', '');
INSERT INTO `operatelog` VALUES (753, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@5504ad50 ,', '2020-02-12 17:28:30', 1, '', '', '');
INSERT INTO `operatelog` VALUES (754, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@23c21c00 ,', '2020-02-12 17:28:31', 1, '', '', '');
INSERT INTO `operatelog` VALUES (755, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@625285a9 ,', '2020-02-12 17:28:34', 1, '', '', '');
INSERT INTO `operatelog` VALUES (756, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.ReportServiceImpl.deleteReport(int); 操作参数: 170 ,', '2020-02-12 17:28:35', 1, '', '', '');
INSERT INTO `operatelog` VALUES (757, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@1eed3b35 ,', '2020-02-12 17:28:35', 1, '', '', '');
INSERT INTO `operatelog` VALUES (758, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@4c2f9f2f ,', '2020-02-12 17:28:37', 1, '', '', '');
INSERT INTO `operatelog` VALUES (759, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@154d545a ,', '2020-02-12 17:28:39', 1, '', '', '');
INSERT INTO `operatelog` VALUES (760, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.ReportServiceImpl.deleteReport(int); 操作参数: 170 ,', '2020-02-12 17:28:40', 1, '', '', '');
INSERT INTO `operatelog` VALUES (761, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@f7fcbac ,', '2020-02-12 17:28:40', 1, '', '', '');
INSERT INTO `operatelog` VALUES (762, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@da8dcbd ,', '2020-02-12 17:28:41', 1, '', '', '');
INSERT INTO `operatelog` VALUES (763, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@58d1d889 ,', '2020-02-12 17:28:42', 1, '', '', '');
INSERT INTO `operatelog` VALUES (764, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 170 ,', '2020-02-12 17:28:42', 1, '', '', '');
INSERT INTO `operatelog` VALUES (765, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFields(Integer); 操作参数: 45 ,', '2020-02-12 17:28:42', 1, '', '', '');
INSERT INTO `operatelog` VALUES (766, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@4d60fc53 ,', '2020-02-12 17:29:58', 1, '', '', '');
INSERT INTO `operatelog` VALUES (767, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.ReportServiceImpl.deleteReport(int); 操作参数: 170 ,', '2020-02-12 17:29:59', 1, '', '', '');
INSERT INTO `operatelog` VALUES (768, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT); 操作参数: BI_REPORT(report_Id=null, topic_Id=null, report_Name=null, page_Id=29, report_Title=null, create_Date=null, topic_Name=null, page_Name=null) ,', '2020-02-12 17:29:59', 1, '', '', '');
INSERT INTO `operatelog` VALUES (769, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@73f8d1de ,', '2020-02-12 17:29:59', 1, '', '', '');
INSERT INTO `operatelog` VALUES (770, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@5991496 ,', '2020-02-12 17:30:04', 1, '', '', '');
INSERT INTO `operatelog` VALUES (771, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.BIPageServiceImpl.deletePageInfo(int); 操作参数: 29 ,', '2020-02-12 17:30:04', 1, '', '', '');
INSERT INTO `operatelog` VALUES (772, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@78042320 ,', '2020-02-12 17:30:08', 1, '', '', '');
INSERT INTO `operatelog` VALUES (773, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.BIPageServiceImpl.deletePageInfo(int); 操作参数: 30 ,', '2020-02-12 17:30:09', 1, '', '', '');
INSERT INTO `operatelog` VALUES (774, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@2e13a140 ,', '2020-02-12 17:30:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (775, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT); 操作参数: BI_REPORT(report_Id=null, topic_Id=null, report_Name=null, page_Id=30, report_Title=null, create_Date=null, topic_Name=null, page_Name=null) ,', '2020-02-12 17:30:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (776, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC); 操作参数: BI_TOPIC(topic_Id=null, topic_Name=null, topic_Caption=null, topic_Type=null, biz_Table_Name=null, ds_id=null) ,', '2020-02-12 17:30:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (777, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:30:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (778, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@7ea8ca6e ,', '2020-02-12 17:30:13', 1, '', '', '');
INSERT INTO `operatelog` VALUES (779, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@5de53644 ,', '2020-02-12 17:30:15', 1, '', '', '');
INSERT INTO `operatelog` VALUES (780, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@5c8c0718 ,', '2020-02-12 17:30:16', 1, '', '', '');
INSERT INTO `operatelog` VALUES (781, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 171 ,', '2020-02-12 17:30:16', 1, '', '', '');
INSERT INTO `operatelog` VALUES (782, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFields(Integer); 操作参数: 45 ,', '2020-02-12 17:30:16', 1, '', '', '');
INSERT INTO `operatelog` VALUES (783, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@71b18d5d ,', '2020-02-12 17:30:21', 1, '', '', '');
INSERT INTO `operatelog` VALUES (784, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@51544512 ,', '2020-02-12 17:30:24', 1, '', '', '');
INSERT INTO `operatelog` VALUES (785, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 171 ,', '2020-02-12 17:30:25', 1, '', '', '');
INSERT INTO `operatelog` VALUES (786, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFields(Integer); 操作参数: 45 ,', '2020-02-12 17:30:25', 1, '', '', '');
INSERT INTO `operatelog` VALUES (787, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@6a07227f ,', '2020-02-12 17:30:26', 1, '', '', '');
INSERT INTO `operatelog` VALUES (788, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.ReportFieldServiceImpl.saveReportField(BI_REPORT_FIELD); 操作参数: BI_REPORT_FIELD(report_Field_Id=null, report_Id=171, field_Id=217, field_Location=1, dim_Order=1, display=1, field_Name=null) ,', '2020-02-12 17:30:31', 1, '', '', '');
INSERT INTO `operatelog` VALUES (789, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@46633a02 ,', '2020-02-12 17:30:31', 1, '', '', '');
INSERT INTO `operatelog` VALUES (790, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@8be04ab ,', '2020-02-12 17:30:32', 1, '', '', '');
INSERT INTO `operatelog` VALUES (791, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@43c58a32 ,', '2020-02-12 17:30:33', 1, '', '', '');
INSERT INTO `operatelog` VALUES (792, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.ReportFieldServiceImpl.saveReportField(BI_REPORT_FIELD); 操作参数: BI_REPORT_FIELD(report_Field_Id=null, report_Id=171, field_Id=215, field_Location=3, dim_Order=1, display=1, field_Name=null) ,', '2020-02-12 17:30:39', 1, '', '', '');
INSERT INTO `operatelog` VALUES (793, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@1b698609 ,', '2020-02-12 17:30:39', 1, '', '', '');
INSERT INTO `operatelog` VALUES (794, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@6e6aaf8e ,', '2020-02-12 17:30:40', 1, '', '', '');
INSERT INTO `operatelog` VALUES (795, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@69603963 ,', '2020-02-12 17:30:41', 1, '', '', '');
INSERT INTO `operatelog` VALUES (796, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.ReportFieldServiceImpl.saveReportField(BI_REPORT_FIELD); 操作参数: BI_REPORT_FIELD(report_Field_Id=null, report_Id=171, field_Id=219, field_Location=3, dim_Order=1, display=1, field_Name=null) ,', '2020-02-12 17:30:46', 1, '', '', '');
INSERT INTO `operatelog` VALUES (797, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@18b28dd9 ,', '2020-02-12 17:30:46', 1, '', '', '');
INSERT INTO `operatelog` VALUES (798, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@77c11b0b ,', '2020-02-12 17:30:47', 1, '', '', '');
INSERT INTO `operatelog` VALUES (799, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 171 ,', '2020-02-12 17:30:50', 1, '', '', '');
INSERT INTO `operatelog` VALUES (800, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@458f08c0 ,', '2020-02-12 17:30:50', 1, '', '', '');
INSERT INTO `operatelog` VALUES (801, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@35f456fe ,', '2020-02-12 17:30:54', 1, '', '', '');
INSERT INTO `operatelog` VALUES (802, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 171 ,', '2020-02-12 17:30:54', 1, '', '', '');
INSERT INTO `operatelog` VALUES (803, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFields(Integer); 操作参数: 45 ,', '2020-02-12 17:30:54', 1, '', '', '');
INSERT INTO `operatelog` VALUES (804, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@5786e02e ,', '2020-02-12 17:30:59', 1, '', '', '');
INSERT INTO `operatelog` VALUES (805, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=13, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:31:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (806, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=30, page_Name=null) ,', '2020-02-12 17:31:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (807, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 30 ,1 ,null ,', '2020-02-12 17:31:12', 1, '', '', '');
INSERT INTO `operatelog` VALUES (808, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 30 ,1 ,', '2020-02-12 17:31:12', 1, '', '', '');
INSERT INTO `operatelog` VALUES (809, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 30 ,1 ,null ,', '2020-02-12 17:31:13', 1, '', '', '');
INSERT INTO `operatelog` VALUES (810, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=13, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:31:17', 1, '', '', '');
INSERT INTO `operatelog` VALUES (811, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=30, page_Name=null) ,', '2020-02-12 17:31:17', 1, '', '', '');
INSERT INTO `operatelog` VALUES (812, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 30 ,1 ,null ,', '2020-02-12 17:31:17', 1, '', '', '');
INSERT INTO `operatelog` VALUES (813, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@22853f64 ,', '2020-02-12 17:31:27', 1, '', '', '');
INSERT INTO `operatelog` VALUES (814, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT); 操作参数: BI_REPORT(report_Id=null, topic_Id=null, report_Name=null, page_Id=30, report_Title=null, create_Date=null, topic_Name=null, page_Name=null) ,', '2020-02-12 17:31:28', 1, '', '', '');
INSERT INTO `operatelog` VALUES (815, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC); 操作参数: BI_TOPIC(topic_Id=null, topic_Name=null, topic_Caption=null, topic_Type=null, biz_Table_Name=null, ds_id=null) ,', '2020-02-12 17:31:28', 1, '', '', '');
INSERT INTO `operatelog` VALUES (816, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:31:28', 1, '', '', '');
INSERT INTO `operatelog` VALUES (817, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@3d9c3440 ,', '2020-02-12 17:31:31', 1, '', '', '');
INSERT INTO `operatelog` VALUES (818, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 171 ,', '2020-02-12 17:31:32', 1, '', '', '');
INSERT INTO `operatelog` VALUES (819, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFields(Integer); 操作参数: 45 ,', '2020-02-12 17:31:32', 1, '', '', '');
INSERT INTO `operatelog` VALUES (820, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@69d43696 ,', '2020-02-12 17:31:34', 1, '', '', '');
INSERT INTO `operatelog` VALUES (821, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.bi.service.impl.ReportFieldServiceImpl.deleteRpoetField(int); 操作参数: 584 ,', '2020-02-12 17:31:35', 1, '', '', '');
INSERT INTO `operatelog` VALUES (822, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.bi.service.impl.ReportFieldServiceImpl.deleteRpoetField(int); 操作参数: 582 ,', '2020-02-12 17:31:35', 1, '', '', '');
INSERT INTO `operatelog` VALUES (823, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.bi.service.impl.ReportFieldServiceImpl.deleteRpoetField(int); 操作参数: 583 ,', '2020-02-12 17:31:35', 1, '', '', '');
INSERT INTO `operatelog` VALUES (824, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@17104ec8 ,', '2020-02-12 17:31:35', 1, '', '', '');
INSERT INTO `operatelog` VALUES (825, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@1c268193 ,', '2020-02-12 17:31:36', 1, '', '', '');
INSERT INTO `operatelog` VALUES (826, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@30974187 ,', '2020-02-12 17:31:39', 1, '', '', '');
INSERT INTO `operatelog` VALUES (827, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 171 ,', '2020-02-12 17:31:39', 1, '', '', '');
INSERT INTO `operatelog` VALUES (828, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFields(Integer); 操作参数: 45 ,', '2020-02-12 17:31:39', 1, '', '', '');
INSERT INTO `operatelog` VALUES (829, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@7c8c6917 ,', '2020-02-12 17:31:41', 1, '', '', '');
INSERT INTO `operatelog` VALUES (830, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.ReportServiceImpl.deleteReport(int); 操作参数: 171 ,', '2020-02-12 17:31:42', 1, '', '', '');
INSERT INTO `operatelog` VALUES (831, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@584d4536 ,', '2020-02-12 17:31:43', 1, '', '', '');
INSERT INTO `operatelog` VALUES (832, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@f419e66 ,', '2020-02-12 17:31:43', 1, '', '', '');
INSERT INTO `operatelog` VALUES (833, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@4531f9ad ,', '2020-02-12 17:31:55', 1, '', '', '');
INSERT INTO `operatelog` VALUES (834, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.ReportServiceImpl.deleteReport(int); 操作参数: 171 ,', '2020-02-12 17:31:55', 1, '', '', '');
INSERT INTO `operatelog` VALUES (835, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT); 操作参数: BI_REPORT(report_Id=null, topic_Id=null, report_Name=null, page_Id=30, report_Title=null, create_Date=null, topic_Name=null, page_Name=null) ,', '2020-02-12 17:31:56', 1, '', '', '');
INSERT INTO `operatelog` VALUES (836, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@6b610966 ,', '2020-02-12 17:31:56', 1, '', '', '');
INSERT INTO `operatelog` VALUES (837, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@16432822 ,', '2020-02-12 17:31:59', 1, '', '', '');
INSERT INTO `operatelog` VALUES (838, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.BIPageServiceImpl.deletePageInfo(int); 操作参数: 30 ,', '2020-02-12 17:32:00', 1, '', '', '');
INSERT INTO `operatelog` VALUES (839, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@702cd577 ,', '2020-02-12 17:32:04', 1, '', '', '');
INSERT INTO `operatelog` VALUES (840, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:32:04', 1, '', '', '');
INSERT INTO `operatelog` VALUES (841, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBIScreenListPage(BI_Screen,int,int); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=30, page_Name=null) ,1 ,10 ,', '2020-02-12 17:32:04', 1, '', '', '');
INSERT INTO `operatelog` VALUES (842, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@77dc8258 ,', '2020-02-12 17:32:06', 1, '', '', '');
INSERT INTO `operatelog` VALUES (843, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.BIScreenServiceImpl.deleteScreenInfo(int); 操作参数: 32 ,', '2020-02-12 17:32:07', 1, '', '', '');
INSERT INTO `operatelog` VALUES (844, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBIScreenListPage(BI_Screen,int,int); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=30, page_Name=null) ,1 ,10 ,', '2020-02-12 17:32:07', 1, '', '', '');
INSERT INTO `operatelog` VALUES (845, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@35b21b0 ,', '2020-02-12 17:32:07', 1, '', '', '');
INSERT INTO `operatelog` VALUES (846, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@2b229246 ,', '2020-02-12 17:32:10', 1, '', '', '');
INSERT INTO `operatelog` VALUES (847, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.BIPageServiceImpl.deletePageInfo(int); 操作参数: 30 ,', '2020-02-12 17:32:11', 1, '', '', '');
INSERT INTO `operatelog` VALUES (848, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=31, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:32:13', 1, '', '', '');
INSERT INTO `operatelog` VALUES (849, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@4843460 ,', '2020-02-12 17:32:14', 1, '', '', '');
INSERT INTO `operatelog` VALUES (850, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@7945ede4 ,', '2020-02-12 17:32:21', 1, '', '', '');
INSERT INTO `operatelog` VALUES (851, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@3d34d08b ,', '2020-02-12 17:32:24', 1, '', '', '');
INSERT INTO `operatelog` VALUES (852, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=13, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:32:47', 1, '', '', '');
INSERT INTO `operatelog` VALUES (853, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,2 ,2 ,', '2020-02-12 17:32:50', 1, '', '', '');
INSERT INTO `operatelog` VALUES (854, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2020-02-12 17:32:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (855, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@2a98f9b8 ,1 ,10 ,', '2020-02-12 17:32:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (856, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-02-12 17:32:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (857, 1, 1, '', ' 操作层级: Service 层;  操作方法: MiniDaoPage cn.zup.rbac.service.impl.ResourceServiceImpl.getActionPagingList(Action,int,int); 操作参数: cn.zup.rbac.entity.Action@4dd9c764 ,1 ,10 ,', '2020-02-12 17:32:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (858, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-02-12 17:32:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (859, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-02-12 17:32:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (860, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-02-12 17:32:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (861, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2020-02-12 17:32:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (862, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@1ec7dc1e ,', '2020-02-12 17:32:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (863, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-02-12 17:32:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (864, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-02-12 17:32:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (865, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-02-12 17:32:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (866, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-02-12 17:32:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (867, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-02-12 17:32:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (868, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 5 ,', '2020-02-12 17:32:53', 1, '', '', '');
INSERT INTO `operatelog` VALUES (869, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,5 ,true ,', '2020-02-12 17:32:53', 1, '', '', '');
INSERT INTO `operatelog` VALUES (870, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 11 ,', '2020-02-12 17:32:53', 1, '', '', '');
INSERT INTO `operatelog` VALUES (871, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 6 ,', '2020-02-12 17:32:53', 1, '', '', '');
INSERT INTO `operatelog` VALUES (872, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 7 ,', '2020-02-12 17:32:53', 1, '', '', '');
INSERT INTO `operatelog` VALUES (873, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 8 ,', '2020-02-12 17:32:53', 1, '', '', '');
INSERT INTO `operatelog` VALUES (874, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 13 ,', '2020-02-12 17:32:53', 1, '', '', '');
INSERT INTO `operatelog` VALUES (875, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,2 ,true ,', '2020-02-12 17:32:54', 1, '', '', '');
INSERT INTO `operatelog` VALUES (876, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 2 ,', '2020-02-12 17:32:54', 1, '', '', '');
INSERT INTO `operatelog` VALUES (877, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 3 ,', '2020-02-12 17:32:54', 1, '', '', '');
INSERT INTO `operatelog` VALUES (878, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 4 ,', '2020-02-12 17:32:54', 1, '', '', '');
INSERT INTO `operatelog` VALUES (879, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,3 ,true ,', '2020-02-12 17:32:55', 1, '', '', '');
INSERT INTO `operatelog` VALUES (880, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 3 ,', '2020-02-12 17:32:55', 1, '', '', '');
INSERT INTO `operatelog` VALUES (881, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,13 ,true ,', '2020-02-12 17:32:56', 1, '', '', '');
INSERT INTO `operatelog` VALUES (882, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 13 ,', '2020-02-12 17:32:56', 1, '', '', '');
INSERT INTO `operatelog` VALUES (883, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@2594da0c ,', '2020-02-12 17:32:58', 1, '', '', '');
INSERT INTO `operatelog` VALUES (884, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemList(); 操作参数: ', '2020-02-12 17:33:06', 1, '', '', '');
INSERT INTO `operatelog` VALUES (885, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@7efde5c3 ,', '2020-02-12 17:33:06', 1, '', '', '');
INSERT INTO `operatelog` VALUES (886, 1, 1, '', ' 操作层级: Service 层;  操作方法: Menu cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuInfo(int); 操作参数: 0 ,', '2020-02-12 17:33:06', 1, '', '', '');
INSERT INTO `operatelog` VALUES (887, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getSystemMenuList(int,int,boolean); 操作参数: 1 ,0 ,true ,', '2020-02-12 17:33:06', 1, '', '', '');
INSERT INTO `operatelog` VALUES (888, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 1 ,', '2020-02-12 17:33:06', 1, '', '', '');
INSERT INTO `operatelog` VALUES (889, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 5 ,', '2020-02-12 17:33:06', 1, '', '', '');
INSERT INTO `operatelog` VALUES (890, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(int); 操作参数: 2 ,', '2020-02-12 17:33:06', 1, '', '', '');
INSERT INTO `operatelog` VALUES (891, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-02-12 17:33:07', 1, '', '', '');
INSERT INTO `operatelog` VALUES (892, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@2483fde4 ,', '2020-02-12 17:33:19', 1, '', '', '');
INSERT INTO `operatelog` VALUES (893, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@3bfa79a2 ,', '2020-02-12 17:33:26', 1, '', '', '');
INSERT INTO `operatelog` VALUES (894, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(Integer,Menu); 操作参数: 1 ,cn.zup.rbac.entity.Menu@7890b6f9 ,', '2020-02-12 17:33:26', 1, '', '', '');
INSERT INTO `operatelog` VALUES (895, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@5830320f ,', '2020-02-12 17:33:26', 1, '', '', '');
INSERT INTO `operatelog` VALUES (896, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@3525ff2 ,', '2020-02-12 17:34:35', 1, '', '', '');
INSERT INTO `operatelog` VALUES (897, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@314a2945 ,', '2020-02-12 17:34:43', 1, '', '', '');
INSERT INTO `operatelog` VALUES (898, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=6886, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:34:45', 1, '', '', '');
INSERT INTO `operatelog` VALUES (899, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=32, page_Name=null) ,', '2020-02-12 17:34:45', 1, '', '', '');
INSERT INTO `operatelog` VALUES (900, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 0 ,0 ,null ,', '2020-02-12 17:34:46', 1, '', '', '');
INSERT INTO `operatelog` VALUES (901, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 32 ,0 ,', '2020-02-12 17:34:46', 1, '', '', '');
INSERT INTO `operatelog` VALUES (902, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@5e113932 ,', '2020-02-12 17:35:21', 1, '', '', '');
INSERT INTO `operatelog` VALUES (903, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@551778ee ,', '2020-02-12 17:35:21', 1, '', '', '');
INSERT INTO `operatelog` VALUES (904, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(Integer,Menu); 操作参数: 1 ,cn.zup.rbac.entity.Menu@1c14f5c1 ,', '2020-02-12 17:35:21', 1, '', '', '');
INSERT INTO `operatelog` VALUES (905, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=13, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:36:36', 1, '', '', '');
INSERT INTO `operatelog` VALUES (906, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=32, page_Name=null) ,', '2020-02-12 17:36:36', 1, '', '', '');
INSERT INTO `operatelog` VALUES (907, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=32, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:36:50', 1, '', '', '');
INSERT INTO `operatelog` VALUES (908, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@7d6ae7db ,', '2020-02-12 17:36:51', 1, '', '', '');
INSERT INTO `operatelog` VALUES (909, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@1ef1ea5 ,', '2020-02-12 17:37:16', 1, '', '', '');
INSERT INTO `operatelog` VALUES (910, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(Integer,Menu); 操作参数: 1 ,cn.zup.rbac.entity.Menu@5706397b ,', '2020-02-12 17:37:16', 1, '', '', '');
INSERT INTO `operatelog` VALUES (911, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@e73c653 ,', '2020-02-12 17:37:16', 1, '', '', '');
INSERT INTO `operatelog` VALUES (912, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@397d0551 ,', '2020-02-12 17:37:19', 1, '', '', '');
INSERT INTO `operatelog` VALUES (913, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:37:20', 1, '', '', '');
INSERT INTO `operatelog` VALUES (914, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBIScreenListPage(BI_Screen,int,int); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=32, page_Name=null) ,1 ,10 ,', '2020-02-12 17:37:20', 1, '', '', '');
INSERT INTO `operatelog` VALUES (915, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@4468f04b ,', '2020-02-12 17:37:21', 1, '', '', '');
INSERT INTO `operatelog` VALUES (916, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.BIScreenServiceImpl.updateScreenInfo(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=1, screen_Name=首页, page_Id=32, page_Name=null) ,', '2020-02-12 17:37:26', 1, '', '', '');
INSERT INTO `operatelog` VALUES (917, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@716b251d ,', '2020-02-12 17:37:26', 1, '', '', '');
INSERT INTO `operatelog` VALUES (918, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBIScreenListPage(BI_Screen,int,int); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=32, page_Name=null) ,1 ,10 ,', '2020-02-12 17:37:27', 1, '', '', '');
INSERT INTO `operatelog` VALUES (919, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@6010bad ,', '2020-02-12 17:37:28', 1, '', '', '');
INSERT INTO `operatelog` VALUES (920, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@6fe94042 ,', '2020-02-12 17:37:30', 1, '', '', '');
INSERT INTO `operatelog` VALUES (921, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:37:30', 1, '', '', '');
INSERT INTO `operatelog` VALUES (922, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT); 操作参数: BI_REPORT(report_Id=null, topic_Id=null, report_Name=null, page_Id=32, report_Title=null, create_Date=null, topic_Name=null, page_Name=null) ,', '2020-02-12 17:37:30', 1, '', '', '');
INSERT INTO `operatelog` VALUES (923, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC); 操作参数: BI_TOPIC(topic_Id=null, topic_Name=null, topic_Caption=null, topic_Type=null, biz_Table_Name=null, ds_id=null) ,', '2020-02-12 17:37:30', 1, '', '', '');
INSERT INTO `operatelog` VALUES (924, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@12ddf441 ,', '2020-02-12 17:37:32', 1, '', '', '');
INSERT INTO `operatelog` VALUES (925, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT); 操作参数: BI_REPORT(report_Id=null, topic_Id=null, report_Name=null, page_Id=32, report_Title=null, create_Date=null, topic_Name=null, page_Name=null) ,', '2020-02-12 17:37:41', 1, '', '', '');
INSERT INTO `operatelog` VALUES (926, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@65352f42 ,', '2020-02-12 17:37:41', 1, '', '', '');
INSERT INTO `operatelog` VALUES (927, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@72a856ad ,', '2020-02-12 17:37:42', 1, '', '', '');
INSERT INTO `operatelog` VALUES (928, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@437f13a6 ,', '2020-02-12 17:37:45', 1, '', '', '');
INSERT INTO `operatelog` VALUES (929, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 173 ,', '2020-02-12 17:37:45', 1, '', '', '');
INSERT INTO `operatelog` VALUES (930, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFields(Integer); 操作参数: 45 ,', '2020-02-12 17:37:45', 1, '', '', '');
INSERT INTO `operatelog` VALUES (931, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@6fa49ffb ,', '2020-02-12 17:37:46', 1, '', '', '');
INSERT INTO `operatelog` VALUES (932, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.ReportFieldServiceImpl.saveReportField(BI_REPORT_FIELD); 操作参数: BI_REPORT_FIELD(report_Field_Id=null, report_Id=173, field_Id=215, field_Location=3, dim_Order=1, display=1, field_Name=null) ,', '2020-02-12 17:37:51', 1, '', '', '');
INSERT INTO `operatelog` VALUES (933, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@4ce2b506 ,', '2020-02-12 17:37:51', 1, '', '', '');
INSERT INTO `operatelog` VALUES (934, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@3f887afe ,', '2020-02-12 17:37:53', 1, '', '', '');
INSERT INTO `operatelog` VALUES (935, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@32011ef1 ,', '2020-02-12 17:37:54', 1, '', '', '');
INSERT INTO `operatelog` VALUES (936, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.ReportFieldServiceImpl.saveReportField(BI_REPORT_FIELD); 操作参数: BI_REPORT_FIELD(report_Field_Id=null, report_Id=173, field_Id=217, field_Location=1, dim_Order=1, display=1, field_Name=null) ,', '2020-02-12 17:38:01', 1, '', '', '');
INSERT INTO `operatelog` VALUES (937, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@fec1a5b ,', '2020-02-12 17:38:01', 1, '', '', '');
INSERT INTO `operatelog` VALUES (938, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@1a8673f ,', '2020-02-12 17:38:02', 1, '', '', '');
INSERT INTO `operatelog` VALUES (939, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@1b5c3682 ,', '2020-02-12 17:38:03', 1, '', '', '');
INSERT INTO `operatelog` VALUES (940, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.ReportFieldServiceImpl.saveReportField(BI_REPORT_FIELD); 操作参数: BI_REPORT_FIELD(report_Field_Id=null, report_Id=173, field_Id=219, field_Location=3, dim_Order=1, display=1, field_Name=null) ,', '2020-02-12 17:38:09', 1, '', '', '');
INSERT INTO `operatelog` VALUES (941, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@574e2f0 ,', '2020-02-12 17:38:09', 1, '', '', '');
INSERT INTO `operatelog` VALUES (942, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@1ed6bd01 ,', '2020-02-12 17:38:10', 1, '', '', '');
INSERT INTO `operatelog` VALUES (943, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=13, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:38:25', 1, '', '', '');
INSERT INTO `operatelog` VALUES (944, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=32, page_Name=null) ,', '2020-02-12 17:38:25', 1, '', '', '');
INSERT INTO `operatelog` VALUES (945, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 32 ,1 ,null ,', '2020-02-12 17:38:26', 1, '', '', '');
INSERT INTO `operatelog` VALUES (946, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=13, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:38:55', 1, '', '', '');
INSERT INTO `operatelog` VALUES (947, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=32, page_Name=null) ,', '2020-02-12 17:38:55', 1, '', '', '');
INSERT INTO `operatelog` VALUES (948, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 32 ,1 ,null ,', '2020-02-12 17:38:56', 1, '', '', '');
INSERT INTO `operatelog` VALUES (949, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 32 ,1 ,', '2020-02-12 17:38:56', 1, '', '', '');
INSERT INTO `operatelog` VALUES (950, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 32 ,1 ,null ,', '2020-02-12 17:39:02', 1, '', '', '');
INSERT INTO `operatelog` VALUES (951, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=13, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:39:07', 1, '', '', '');
INSERT INTO `operatelog` VALUES (952, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=32, page_Name=null) ,', '2020-02-12 17:39:07', 1, '', '', '');
INSERT INTO `operatelog` VALUES (953, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 32 ,1 ,null ,', '2020-02-12 17:39:08', 1, '', '', '');
INSERT INTO `operatelog` VALUES (954, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=13, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:40:29', 1, '', '', '');
INSERT INTO `operatelog` VALUES (955, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=32, page_Name=null) ,', '2020-02-12 17:40:29', 1, '', '', '');
INSERT INTO `operatelog` VALUES (956, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 32 ,1 ,null ,', '2020-02-12 17:40:30', 1, '', '', '');
INSERT INTO `operatelog` VALUES (957, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=13, menu_Name=null, pageTypeStr=null) ,', '2020-02-12 17:42:22', 1, '', '', '');
INSERT INTO `operatelog` VALUES (958, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=32, page_Name=null) ,', '2020-02-12 17:42:22', 1, '', '', '');
INSERT INTO `operatelog` VALUES (959, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 32 ,1 ,null ,', '2020-02-12 17:42:23', 1, '', '', '');
INSERT INTO `operatelog` VALUES (960, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldList(Integer); 操作参数: 173 ,', '2020-02-12 17:42:26', 1, '', '', '');
INSERT INTO `operatelog` VALUES (961, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getDimFieldList(ConditionTransfer); 操作参数: cn.zup.bi.entity.ConditionTransfer@5f573083 ,', '2020-02-12 17:42:26', 1, '', '', '');
INSERT INTO `operatelog` VALUES (962, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 173 ,', '2020-02-12 17:42:26', 1, '', '', '');
INSERT INTO `operatelog` VALUES (963, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 32 ,1 ,', '2020-02-12 17:42:26', 1, '', '', '');
INSERT INTO `operatelog` VALUES (964, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,1 ,2 ,', '2020-02-12 17:43:01', 1, '', '', '');
INSERT INTO `operatelog` VALUES (965, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,e10adc3949ba59abbe56e057f20f883e ,', '2020-02-13 18:00:29', 1, '', '', '');
INSERT INTO `operatelog` VALUES (966, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: UserSession cn.zup.rbac.service.impl.UserServiceImpl.getUserSessionInfo(String,String); 操作参数: admin ,null ,', '2020-02-13 18:00:29', 1, '', '', '');
INSERT INTO `operatelog` VALUES (967, NULL, NULL, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-02-13 18:00:29', 1, '', '', '');
INSERT INTO `operatelog` VALUES (968, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.LoginLogServiceImpl.addLoginLog(LoginLog); 操作参数: cn.zup.rbac.entity.LoginLog@5cd2bdda ,', '2020-02-13 18:00:29', 1, '', '', '');
INSERT INTO `operatelog` VALUES (969, 1, 1, '', ' 操作层级: Service 层;  操作方法: DomainSystem cn.zup.rbac.service.impl.ResourceServiceImpl.getDomainSystemByDomain(String); 操作参数: homeController ,', '2020-02-13 18:00:29', 1, '', '', '');
INSERT INTO `operatelog` VALUES (970, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitMenu(Integer,Integer,boolean,Integer); 操作参数: 1 ,1 ,true ,2 ,', '2020-02-13 18:00:29', 1, '', '', '');
INSERT INTO `operatelog` VALUES (971, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getAccountPermitSubMenu(int,int,int); 操作参数: 1 ,5 ,2 ,', '2020-02-13 18:00:43', 1, '', '', '');
INSERT INTO `operatelog` VALUES (972, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC); 操作参数: BI_TOPIC(topic_Id=null, topic_Name=null, topic_Caption=null, topic_Type=null, biz_Table_Name=null, ds_id=null) ,', '2020-02-13 18:00:45', 1, '', '', '');
INSERT INTO `operatelog` VALUES (973, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ResourceServiceImpl.getMenuList(Integer,Menu); 操作参数: 1 ,cn.zup.rbac.entity.Menu@50baa321 ,', '2020-02-13 18:00:48', 1, '', '', '');
INSERT INTO `operatelog` VALUES (974, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@2bd4862d ,', '2020-02-13 18:00:48', 1, '', '', '');
INSERT INTO `operatelog` VALUES (975, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.rbac.service.impl.ConfigurationServiceImpl.getConfigInfo(Config); 操作参数: cn.zup.rbac.entity.Config@23d53d2f ,', '2020-02-13 18:00:48', 1, '', '', '');
INSERT INTO `operatelog` VALUES (976, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=96555, menu_Name=null, pageTypeStr=null) ,', '2020-02-13 18:00:49', 1, '', '', '');
INSERT INTO `operatelog` VALUES (977, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=31, page_Name=null) ,', '2020-02-13 18:00:50', 1, '', '', '');
INSERT INTO `operatelog` VALUES (978, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 31 ,1 ,null ,', '2020-02-13 18:00:50', 1, '', '', '');
INSERT INTO `operatelog` VALUES (979, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 172 ,', '2020-02-13 18:00:50', 1, '', '', '');
INSERT INTO `operatelog` VALUES (980, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-02-13 18:00:50', 1, '', '', '');
INSERT INTO `operatelog` VALUES (981, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=96555, menu_Name=null, pageTypeStr=null) ,', '2020-02-13 18:05:20', 1, '', '', '');
INSERT INTO `operatelog` VALUES (982, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=31, page_Name=null) ,', '2020-02-13 18:05:20', 1, '', '', '');
INSERT INTO `operatelog` VALUES (983, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 31 ,1 ,null ,', '2020-02-13 18:05:22', 1, '', '', '');
INSERT INTO `operatelog` VALUES (984, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 172 ,', '2020-02-13 18:05:28', 1, '', '', '');
INSERT INTO `operatelog` VALUES (985, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-02-13 18:05:28', 1, '', '', '');
INSERT INTO `operatelog` VALUES (986, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=96555, menu_Name=null, pageTypeStr=null) ,', '2020-02-13 18:05:42', 1, '', '', '');
INSERT INTO `operatelog` VALUES (987, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=31, page_Name=null) ,', '2020-02-13 18:05:42', 1, '', '', '');
INSERT INTO `operatelog` VALUES (988, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 31 ,1 ,null ,', '2020-02-13 18:05:43', 1, '', '', '');
INSERT INTO `operatelog` VALUES (989, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 172 ,', '2020-02-13 18:05:43', 1, '', '', '');
INSERT INTO `operatelog` VALUES (990, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-02-13 18:05:43', 1, '', '', '');
INSERT INTO `operatelog` VALUES (991, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=96555, menu_Name=null, pageTypeStr=null) ,', '2020-02-13 18:08:33', 1, '', '', '');
INSERT INTO `operatelog` VALUES (992, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=31, page_Name=null) ,', '2020-02-13 18:08:33', 1, '', '', '');
INSERT INTO `operatelog` VALUES (993, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 31 ,1 ,null ,', '2020-02-13 18:08:35', 1, '', '', '');
INSERT INTO `operatelog` VALUES (994, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 172 ,', '2020-02-13 18:08:35', 1, '', '', '');
INSERT INTO `operatelog` VALUES (995, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-02-13 18:08:35', 1, '', '', '');
INSERT INTO `operatelog` VALUES (996, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Datasource cn.zup.bi.service.impl.BIDatasourceServiceImpl.getDatasourceInfo(int); 操作参数: 1 ,', '2020-02-13 18:08:44', 1, '', '', '');
INSERT INTO `operatelog` VALUES (997, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=96555, menu_Name=null, pageTypeStr=null) ,', '2020-02-13 18:12:48', 1, '', '', '');
INSERT INTO `operatelog` VALUES (998, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=31, page_Name=null) ,', '2020-02-13 18:12:48', 1, '', '', '');
INSERT INTO `operatelog` VALUES (999, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 31 ,1 ,null ,', '2020-02-13 18:12:49', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1000, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 172 ,', '2020-02-13 18:12:49', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1001, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-02-13 18:12:49', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1002, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Datasource cn.zup.bi.service.impl.BIDatasourceServiceImpl.getDatasourceInfo(int); 操作参数: 1 ,', '2020-02-13 18:12:49', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1003, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=96555, menu_Name=null, pageTypeStr=null) ,', '2020-02-13 18:13:16', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1004, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=31, page_Name=null) ,', '2020-02-13 18:13:16', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1005, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 31 ,1 ,null ,', '2020-02-13 18:13:16', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1006, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 172 ,', '2020-02-13 18:13:16', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1007, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-02-13 18:13:16', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1008, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Datasource cn.zup.bi.service.impl.BIDatasourceServiceImpl.getDatasourceInfo(int); 操作参数: 1 ,', '2020-02-13 18:13:16', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1009, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=96555, menu_Name=null, pageTypeStr=null) ,', '2020-02-13 18:14:24', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1010, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=31, page_Name=null) ,', '2020-02-13 18:14:24', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1011, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 31 ,1 ,null ,', '2020-02-13 18:14:25', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1012, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 172 ,', '2020-02-13 18:14:25', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1013, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-02-13 18:14:25', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1014, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=96555, menu_Name=null, pageTypeStr=null) ,', '2020-02-13 18:15:09', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1015, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=31, page_Name=null) ,', '2020-02-13 18:15:09', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1016, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 31 ,1 ,null ,', '2020-02-13 18:15:10', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1017, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 172 ,', '2020-02-13 18:15:10', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1018, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-02-13 18:15:10', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1019, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=96555, menu_Name=null, pageTypeStr=null) ,', '2020-02-13 18:17:43', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1020, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=31, page_Name=null) ,', '2020-02-13 18:17:43', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1021, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 31 ,1 ,null ,', '2020-02-13 18:17:44', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1022, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 172 ,', '2020-02-13 18:17:44', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1023, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-02-13 18:17:44', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1024, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Datasource cn.zup.bi.service.impl.BIDatasourceServiceImpl.getDatasourceInfo(int); 操作参数: 1 ,', '2020-02-13 18:17:44', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1025, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=96555, menu_Name=null, pageTypeStr=null) ,', '2020-02-13 18:19:29', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1026, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=31, page_Name=null) ,', '2020-02-13 18:19:29', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1027, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 31 ,1 ,null ,', '2020-02-13 18:19:30', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1028, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 172 ,', '2020-02-13 18:19:30', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1029, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-02-13 18:19:30', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1030, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Datasource cn.zup.bi.service.impl.BIDatasourceServiceImpl.getDatasourceInfo(int); 操作参数: 1 ,', '2020-02-13 18:19:30', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1031, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=96555, menu_Name=null, pageTypeStr=null) ,', '2020-02-13 18:19:37', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1032, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=31, page_Name=null) ,', '2020-02-13 18:19:37', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1033, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 31 ,1 ,null ,', '2020-02-13 18:19:37', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1034, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 172 ,', '2020-02-13 18:19:37', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1035, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-02-13 18:19:37', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1036, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Datasource cn.zup.bi.service.impl.BIDatasourceServiceImpl.getDatasourceInfo(int); 操作参数: 1 ,', '2020-02-13 18:19:37', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1037, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=96555, menu_Name=null, pageTypeStr=null) ,', '2020-02-13 18:19:54', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1038, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=31, page_Name=null) ,', '2020-02-13 18:19:54', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1039, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 31 ,1 ,null ,', '2020-02-13 18:19:54', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1040, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 172 ,', '2020-02-13 18:19:54', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1041, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-02-13 18:19:54', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1042, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Datasource cn.zup.bi.service.impl.BIDatasourceServiceImpl.getDatasourceInfo(int); 操作参数: 1 ,', '2020-02-13 18:19:54', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1043, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-02-13 18:21:36', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1044, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC); 操作参数: BI_TOPIC(topic_Id=null, topic_Name=null, topic_Caption=null, topic_Type=null, biz_Table_Name=null, ds_id=null) ,', '2020-02-13 18:21:36', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1045, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getDimPagingList(BI_DIM); 操作参数: BI_DIM(dim_Id=null, dim_Name=null, biz_Table_Name=null, text_Field=null, id_Field=null, drill_Type=null, drill_Info=null, ds_Id=null) ,', '2020-02-13 18:21:38', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1046, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getTableNameList(Connection); 操作参数: com.mysql.jdbc.JDBC4Connection@6553ce80 ,', '2020-02-13 18:21:53', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1047, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@3fc8aea6 ,', '2020-02-13 18:21:53', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1048, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@6b2f3788 ,', '2020-02-13 18:22:08', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1049, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBIScreenListPage(BI_Screen,int,int); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=32, page_Name=null) ,1 ,10 ,', '2020-02-13 18:22:08', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1050, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-02-13 18:22:08', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1051, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@3f681f4e ,', '2020-02-13 18:22:09', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1052, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.BIScreenServiceImpl.updateScreenInfo(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=1, screen_Name=首页, page_Id=32, page_Name=null) ,', '2020-02-13 18:22:14', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1053, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBIScreenListPage(BI_Screen,int,int); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=32, page_Name=null) ,1 ,10 ,', '2020-02-13 18:22:14', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1054, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@69d60310 ,', '2020-02-13 18:22:14', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1055, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@2abb9ae9 ,', '2020-02-13 18:22:15', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1056, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@52adc02 ,', '2020-02-13 18:22:20', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1057, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBIScreenListPage(BI_Screen,int,int); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=31, page_Name=null) ,1 ,10 ,', '2020-02-13 18:22:20', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1058, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-02-13 18:22:20', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1059, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@317ed8b8 ,', '2020-02-13 18:22:21', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1060, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.BIScreenServiceImpl.updateScreenInfo(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=1, screen_Name=首页, page_Id=31, page_Name=null) ,', '2020-02-13 18:22:25', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1061, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBIScreenListPage(BI_Screen,int,int); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=31, page_Name=null) ,1 ,10 ,', '2020-02-13 18:22:25', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1062, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@41fdbb7d ,', '2020-02-13 18:22:25', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1063, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@5a2c1c1 ,', '2020-02-13 18:22:27', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1064, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@4e19b1b8 ,', '2020-02-13 18:22:30', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1065, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC); 操作参数: BI_TOPIC(topic_Id=null, topic_Name=null, topic_Caption=null, topic_Type=null, biz_Table_Name=null, ds_id=null) ,', '2020-02-13 18:22:30', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1066, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-02-13 18:22:30', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1067, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT); 操作参数: BI_REPORT(report_Id=null, topic_Id=null, report_Name=null, page_Id=31, report_Title=null, create_Date=null, topic_Name=null, page_Name=null) ,', '2020-02-13 18:22:30', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1068, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@4efe9ed1 ,', '2020-02-13 18:22:34', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1069, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 172 ,', '2020-02-13 18:22:34', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1070, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFields(Integer); 操作参数: 45 ,', '2020-02-13 18:22:34', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1071, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@5dd1c40d ,', '2020-02-13 18:22:47', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1072, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getTableNameList(Connection); 操作参数: com.mysql.jdbc.JDBC4Connection@223276d1 ,', '2020-02-13 18:22:47', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1073, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_DIM cn.zup.bi.service.impl.BIDimServiceImpl.getDimInfo(String); 操作参数: pms_product ,', '2020-02-13 18:22:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1074, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@63c3a55c ,pms_product ,', '2020-02-13 18:22:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1075, 1, 1, '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@63c3a55c ,pms_product ,', '2020-02-13 18:22:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1076, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_DIM cn.zup.bi.service.impl.BIDimServiceImpl.getDimInfo(String); 操作参数: pms_product ,', '2020-02-13 18:22:52', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1077, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_DIM cn.zup.bi.service.impl.BIDimServiceImpl.getDimInfo(String); 操作参数: pms_bra1nd ,', '2020-02-13 18:23:02', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1078, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getDimInInfo(int); 操作参数: 254 ,', '2020-02-13 18:23:02', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1079, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getColumnNameList(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@134923a ,pms_bra1nd ,', '2020-02-13 18:23:02', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1080, 1, 1, '', ' 操作层级: Service 层;  操作方法: String cn.zup.bi.service.impl.BIDimServiceImpl.getPrimaryKey(Connection,String); 操作参数: com.mysql.jdbc.JDBC4Connection@134923a ,pms_bra1nd ,', '2020-02-13 18:23:02', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1081, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_DIM cn.zup.bi.service.impl.BIDimServiceImpl.getDimInfo(String); 操作参数: pms_bra1nd ,', '2020-02-13 18:23:02', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1082, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getDimInInfo(int); 操作参数: 254 ,', '2020-02-13 18:23:02', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1083, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.BIDimServiceImpl.updateDimData(BI_DIM); 操作参数: BI_DIM(dim_Id=254, dim_Name=商品品牌, biz_Table_Name=pms_bra1nd, text_Field=name, id_Field=id, drill_Type=1, drill_Info=, ds_Id=null) ,', '2020-02-13 18:23:12', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1084, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getDimPagingList(BI_DIM); 操作参数: BI_DIM(dim_Id=null, dim_Name=null, biz_Table_Name=null, text_Field=null, id_Field=null, drill_Type=null, drill_Info=null, ds_Id=null) ,', '2020-02-13 18:23:12', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1085, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=96555, menu_Name=null, pageTypeStr=null) ,', '2020-02-13 18:24:01', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1086, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=31, page_Name=null) ,', '2020-02-13 18:24:01', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1087, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 31 ,1 ,null ,', '2020-02-13 18:24:02', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1088, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 172 ,', '2020-02-13 18:24:02', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1089, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-02-13 18:24:02', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1090, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Datasource cn.zup.bi.service.impl.BIDatasourceServiceImpl.getDatasourceInfo(int); 操作参数: 1 ,', '2020-02-13 18:24:02', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1091, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@4a8b9d92 ,', '2020-02-13 18:24:46', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1092, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportPagingList(BI_REPORT); 操作参数: BI_REPORT(report_Id=null, topic_Id=null, report_Name=null, page_Id=31, report_Title=null, create_Date=null, topic_Name=null, page_Name=null) ,', '2020-02-13 18:24:46', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1093, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicServiceImpl.getTopicPagingList(BI_TOPIC); 操作参数: BI_TOPIC(topic_Id=null, topic_Name=null, topic_Caption=null, topic_Type=null, biz_Table_Name=null, ds_id=null) ,', '2020-02-13 18:24:46', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1094, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageServiceImpl.getBiPageList(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=null, menu_Name=null, pageTypeStr=null) ,', '2020-02-13 18:24:46', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1095, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@4728639 ,', '2020-02-13 18:24:49', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1096, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 172 ,', '2020-02-13 18:24:49', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1097, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFields(Integer); 操作参数: 45 ,', '2020-02-13 18:24:49', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1098, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@629ef4cf ,', '2020-02-13 18:24:50', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1099, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.ReportFieldServiceImpl.saveReportField(BI_REPORT_FIELD); 操作参数: BI_REPORT_FIELD(report_Field_Id=null, report_Id=172, field_Id=217, field_Location=1, dim_Order=1, display=1, field_Name=null) ,', '2020-02-13 18:24:55', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1100, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@60dc09b4 ,', '2020-02-13 18:24:55', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1101, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@73e4ede0 ,', '2020-02-13 18:24:56', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1102, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@6e18a00a ,', '2020-02-13 18:24:57', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1103, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.ReportFieldServiceImpl.saveReportField(BI_REPORT_FIELD); 操作参数: BI_REPORT_FIELD(report_Field_Id=null, report_Id=172, field_Id=215, field_Location=3, dim_Order=1, display=1, field_Name=null) ,', '2020-02-13 18:25:03', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1104, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@4033a48f ,', '2020-02-13 18:25:03', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1105, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@2a01e76f ,', '2020-02-13 18:25:04', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1106, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=96555, menu_Name=null, pageTypeStr=null) ,', '2020-02-13 18:25:08', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1107, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=31, page_Name=null) ,', '2020-02-13 18:25:08', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1108, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 31 ,1 ,null ,', '2020-02-13 18:25:08', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1109, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 172 ,', '2020-02-13 18:25:08', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1110, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-02-13 18:25:08', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1111, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Datasource cn.zup.bi.service.impl.BIDatasourceServiceImpl.getDatasourceInfo(int); 操作参数: 1 ,', '2020-02-13 18:25:08', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1112, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldList(Integer); 操作参数: 172 ,', '2020-02-13 18:25:19', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1113, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getDimFieldList(ConditionTransfer); 操作参数: cn.zup.bi.entity.ConditionTransfer@5c96c71 ,', '2020-02-13 18:25:19', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1114, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 172 ,', '2020-02-13 18:25:19', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1115, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 31 ,1 ,', '2020-02-13 18:25:19', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1116, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@42dc0b1d ,', '2020-02-13 18:25:24', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1117, 1, 1, '', ' 操作层级: Service 层;  操作方法: int cn.zup.bi.service.impl.ReportFieldServiceImpl.saveReportField(BI_REPORT_FIELD); 操作参数: BI_REPORT_FIELD(report_Field_Id=null, report_Id=172, field_Id=219, field_Location=3, dim_Order=1, display=1, field_Name=null) ,', '2020-02-13 18:25:30', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1118, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@10c4ade ,', '2020-02-13 18:25:31', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1119, 1, 1, '', ' 操作层级: Service 层;  操作方法: void cn.zup.rbac.service.impl.AuditLogServiceImpl.addAuditLog(AuditLog); 操作参数: cn.zup.rbac.entity.AuditLog@4615f6cc ,', '2020-02-13 18:25:32', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1120, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Page cn.zup.bi.service.impl.BIPageServiceImpl.getBiPage(BI_Page); 操作参数: BI_Page(bi_Page_Id=null, page_Name=null, page_Type=null, page_Title=null, page_Url=null, menu_Id=96555, menu_Name=null, pageTypeStr=null) ,', '2020-02-13 18:25:34', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1121, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIScreenServiceImpl.getBiScreenList(BI_Screen); 操作参数: BI_Screen(screen_Id=null, screen_Index=null, screen_Name=null, page_Id=31, page_Name=null) ,', '2020-02-13 18:25:34', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1122, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIPageBlockServiceImpl.getPageBlockByPageId(Integer,Integer,Integer); 操作参数: 31 ,1 ,null ,', '2020-02-13 18:25:34', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1123, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 172 ,', '2020-02-13 18:25:34', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1124, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_TOPIC cn.zup.bi.service.impl.TopicServiceImpl.getTopicData(Integer); 操作参数: 45 ,', '2020-02-13 18:25:34', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1125, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_Datasource cn.zup.bi.service.impl.BIDatasourceServiceImpl.getDatasourceInfo(int); 操作参数: 1 ,', '2020-02-13 18:25:34', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1126, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.TopicFieldServiceImpl.getTopicFieldList(Integer); 操作参数: 172 ,', '2020-02-13 18:25:34', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1127, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.BIDimServiceImpl.getDimFieldList(ConditionTransfer); 操作参数: cn.zup.bi.entity.ConditionTransfer@4c5131c5 ,', '2020-02-13 18:25:34', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1128, 1, 1, '', ' 操作层级: Service 层;  操作方法: BI_REPORT cn.zup.bi.service.impl.ReportServiceImpl.getReportInfo(int); 操作参数: 172 ,', '2020-02-13 18:25:34', 1, '', '', '');
INSERT INTO `operatelog` VALUES (1129, 1, 1, '', ' 操作层级: Service 层;  操作方法: List cn.zup.bi.service.impl.ReportServiceImpl.getReportListByPageId(int,int); 操作参数: 31 ,1 ,', '2020-02-13 18:25:34', 1, '', '', '');
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

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
INSERT INTO `rolemenu` VALUES (11, 1, 1);
INSERT INTO `rolemenu` VALUES (13, 1, 1);
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

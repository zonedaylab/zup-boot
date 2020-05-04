/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50729
 Source Host           : localhost:3306
 Source Schema         : zup

 Target Server Type    : MySQL
 Target Server Version : 50729
 File Encoding         : 65001

 Date: 04/05/2020 08:45:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bi_report
-- ----------------------------
DROP TABLE IF EXISTS `bi_report`;
CREATE TABLE `bi_report`  (
  `REPORT_ID` int(38) NOT NULL AUTO_INCREMENT COMMENT '报表id',
  `REPORT_NAME` varchar(63) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '报表名称',
  `REPORT_TITLE` varchar(127) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '报表标题',
  `CREATE_DATE` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `PAGE_ID` int(11) NULL DEFAULT NULL COMMENT '页面主键',
  `BIZ_TABLE_NAME` varchar(63) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据表名',
  PRIMARY KEY (`REPORT_ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 171 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bi_report
-- ----------------------------
INSERT INTO `bi_report` VALUES (170, '分类商品价格趋势3', '分类商品价格趋势21', '2020-05-02 19:33:15', 29, 'pms_product');

SET FOREIGN_KEY_CHECKS = 1;

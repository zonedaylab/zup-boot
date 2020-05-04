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

 Date: 04/05/2020 08:40:42
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bi_report_field
-- ----------------------------
DROP TABLE IF EXISTS `bi_report_field`;
CREATE TABLE `bi_report_field`  (
  `REPORT_FIELD_ID` int(38) NOT NULL AUTO_INCREMENT,
  `REPORT_ID` int(38) NOT NULL COMMENT '报表ID',
  `FIELD_LOCATION` int(5) NULL DEFAULT NULL COMMENT '字段位置',
  `DIM_ORDER` int(5) NULL DEFAULT NULL COMMENT '维度顺序',
  `DISPLAY` tinyint(2) NULL DEFAULT NULL COMMENT '是否显示',
  `FIELD_NAME` varchar(63) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段名称',
  `FIELD_CAPTION` varchar(63) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段别名',
  `FIELD_TITLE` varchar(63) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段标题',
  `DATA_TYPE` int(5) NULL DEFAULT NULL COMMENT '数据类型（数据库类型）',
  `FIELD_TYPE` int(5) NULL DEFAULT NULL COMMENT '字段类型（业务类型）',
  `AGGREGATE_TYPE` varchar(63) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '聚合类型',
  `UNIT` varchar(38) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单位',
  `DIM_ID` int(11) NULL DEFAULT NULL COMMENT '维表ID',
  PRIMARY KEY (`REPORT_FIELD_ID`) USING BTREE,
  INDEX `reportid`(`REPORT_ID`) USING BTREE,
  CONSTRAINT `bi_report_field_ibfk_1` FOREIGN KEY (`REPORT_ID`) REFERENCES `bi_report` (`REPORT_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 588 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bi_report_field
-- ----------------------------
INSERT INTO `bi_report_field` VALUES (577, 170, 3, 1, 0, 'id', 'id', '商品数量', 1, 2, 'COUNT', '数量', NULL);
INSERT INTO `bi_report_field` VALUES (578, 170, 2, 1, 0, 'product_category_id', 'product_category_id', '类型', 2, 1, NULL, '', 253);
INSERT INTO `bi_report_field` VALUES (579, 170, 2, 3, 0, 'brand_id', 'brand_id', '品牌', 2, 1, NULL, '', 254);
INSERT INTO `bi_report_field` VALUES (581, 170, 1, 1, 1, 'name', 'name', '名称', 2, 2, NULL, '', NULL);
INSERT INTO `bi_report_field` VALUES (582, 170, 1, 1, 1, 'price', 'price', '价格', 1, 2, NULL, '元', NULL);
INSERT INTO `bi_report_field` VALUES (587, 170, 1, 5, 0, 'pic', 'pic1', '不清楚1', 1, 3, 'MAX_', '没有12', NULL);

SET FOREIGN_KEY_CHECKS = 1;

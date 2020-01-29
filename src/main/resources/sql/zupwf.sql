/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50724
Source Host           : localhost:3306
Source Database       : zupwf

Target Server Type    : MYSQL
Target Server Version : 50724
File Encoding         : 65001

Date: 2019-12-19 11:25:39
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for demoprovince
-- ----------------------------
DROP TABLE IF EXISTS `demoprovince`;
CREATE TABLE `demoprovince` (
  `ID` int(38) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(50) DEFAULT '',
  `CODE` varchar(50) DEFAULT '',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of demoprovince
-- ----------------------------
INSERT INTO `demoprovince` VALUES ('1', '北京', '11');
INSERT INTO `demoprovince` VALUES ('2', '天津', '12');
INSERT INTO `demoprovince` VALUES ('3', '河北', '13');
INSERT INTO `demoprovince` VALUES ('4', '山西', '14');
INSERT INTO `demoprovince` VALUES ('5', '内蒙', '15');
INSERT INTO `demoprovince` VALUES ('6', '辽宁', '21');
INSERT INTO `demoprovince` VALUES ('7', '吉林', '22');
INSERT INTO `demoprovince` VALUES ('8', '黑龙江', '23');
INSERT INTO `demoprovince` VALUES ('9', '上海', '31');
INSERT INTO `demoprovince` VALUES ('10', '江苏', '32');
INSERT INTO `demoprovince` VALUES ('11', '浙江', '33');
INSERT INTO `demoprovince` VALUES ('12', '安徽', '34');
INSERT INTO `demoprovince` VALUES ('13', '福建', '35');
INSERT INTO `demoprovince` VALUES ('14', '江西', '36');
INSERT INTO `demoprovince` VALUES ('15', '山东', '37');
INSERT INTO `demoprovince` VALUES ('29', '11', '11');

-- ----------------------------
-- Table structure for demo_sample_receive_register
-- ----------------------------
DROP TABLE IF EXISTS `demo_sample_receive_register`;
CREATE TABLE `demo_sample_receive_register` (
  `SAMPLE_ID` int(10) NOT NULL AUTO_INCREMENT,
  `SAMPLE_START_TIME` datetime DEFAULT NULL,
  `SAMPLE_END_TIME` datetime DEFAULT NULL,
  `SAMPLE_PEOPER` varchar(255) DEFAULT '',
  `RECEIVE_TIME` datetime DEFAULT NULL,
  `RECEIVE_PEOPER` varchar(255) DEFAULT '',
  `CONTAINER_TYPE` varchar(255) DEFAULT '',
  `CONTAINER_SPECIFICATION` varchar(255) DEFAULT '',
  `SAMPLE_SOURCE` int(10) DEFAULT NULL,
  `SAMPLE_FACE` varchar(255) DEFAULT '',
  `SAMPLE_USE` varchar(255) DEFAULT '',
  PRIMARY KEY (`SAMPLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of demo_sample_receive_register
-- ----------------------------

-- ----------------------------
-- Table structure for wf_activity
-- ----------------------------
DROP TABLE IF EXISTS `wf_activity`;
CREATE TABLE `wf_activity` (
  `ACTIVITY_ID` int(38) NOT NULL AUTO_INCREMENT COMMENT '活动ID',
  `FLOW_ID` int(38) NOT NULL COMMENT '流程ID',
  `FORM_ID` int(38) DEFAULT NULL COMMENT '表单ID',
  `ACTIVITY_CODE` int(3) DEFAULT NULL COMMENT '活动序号',
  `ACTIVITY_NAME` varchar(64) DEFAULT '' COMMENT '活动名称',
  `ACTIVITY_LEFT` int(4) DEFAULT NULL,
  `ACTIVITY_TOP` int(4) DEFAULT NULL,
  `ACTIVITY_ICON` varchar(32) DEFAULT '',
  `ACTIVITY_TYPE` int(3) DEFAULT NULL COMMENT '活动类型',
  `NEXT_ACTIVITY_CODE` varchar(64) DEFAULT '' COMMENT '下一活动序号',
  `SUB_FLOW_ID` int(38) DEFAULT NULL COMMENT '子流程ID',
  `REVIEW_TYPE` int(3) DEFAULT NULL COMMENT '评审模式',
  `REJECT_ACTIVITY_CODE` varchar(64) DEFAULT NULL COMMENT '驳回节点编号',
  `BRANCH_SEL_TYPE` int(38) DEFAULT NULL,
  `HANDLER_SEL_TYPE` int(38) DEFAULT NULL COMMENT '操作者选择模式',
  `ACTIVITY_INTERVAL` int(38) DEFAULT NULL COMMENT '允许最大办理时间',
  `ACTIVITY_PROPERTY` int(38) DEFAULT NULL COMMENT '活动性质',
  `RELATION_NODE` int(38) DEFAULT NULL COMMENT '默认选择经办者关联节点',
  PRIMARY KEY (`ACTIVITY_ID`),
  KEY `fk_wf_activity_wf_flow` (`FLOW_ID`) USING BTREE,
  CONSTRAINT `wf_activity_ibfk_1` FOREIGN KEY (`FLOW_ID`) REFERENCES `wf_flow` (`FLOW_ID`),
  CONSTRAINT `wf_activity_ibfk_1
` FOREIGN KEY (`FLOW_ID`) REFERENCES `wf_flow` (`FLOW_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=548 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wf_activity
-- ----------------------------

-- ----------------------------
-- Table structure for wf_activity_popedom
-- ----------------------------
DROP TABLE IF EXISTS `wf_activity_popedom`;
CREATE TABLE `wf_activity_popedom` (
  `ACTIVITY_ID` int(38) NOT NULL,
  `CONTROL_ID` int(38) NOT NULL,
  `STATE` int(38) NOT NULL,
  `GRID_COLUMN_DISPLAY` varchar(255) DEFAULT '',
  KEY `activity_ida` (`ACTIVITY_ID`) USING BTREE,
  KEY `control_ida` (`CONTROL_ID`) USING BTREE,
  CONSTRAINT `wf_activity_popedom_ibfk_1` FOREIGN KEY (`ACTIVITY_ID`) REFERENCES `wf_activity` (`ACTIVITY_ID`),
  CONSTRAINT `wf_activity_popedom_ibfk_1
` FOREIGN KEY (`ACTIVITY_ID`) REFERENCES `wf_activity` (`ACTIVITY_ID`),
  CONSTRAINT `wf_activity_popedom_ibfk_2` FOREIGN KEY (`CONTROL_ID`) REFERENCES `wf_form_control` (`CONTROL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wf_activity_popedom
-- ----------------------------

-- ----------------------------
-- Table structure for wf_config
-- ----------------------------
DROP TABLE IF EXISTS `wf_config`;
CREATE TABLE `wf_config` (
  `ID` int(38) NOT NULL COMMENT '配置类型ID',
  `NAME` varchar(132) DEFAULT '' COMMENT '配置类型名称',
  `SUB_ID` int(38) NOT NULL COMMENT '配置子类型ID',
  `SUB_NAME` varchar(32) DEFAULT '' COMMENT '配置子类型名称',
  PRIMARY KEY (`ID`,`SUB_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wf_config
-- ----------------------------
INSERT INTO `wf_config` VALUES ('1', '工作状态', '1', '正在办理');
INSERT INTO `wf_config` VALUES ('1', '工作状态', '2', '正常结束');
INSERT INTO `wf_config` VALUES ('1', '工作状态', '3', '强制结束');
INSERT INTO `wf_config` VALUES ('1', '工作状态', '4', '暂停');
INSERT INTO `wf_config` VALUES ('2', '工作活动状态', '1', '正在办理');
INSERT INTO `wf_config` VALUES ('2', '工作活动状态', '2', '正常结束');
INSERT INTO `wf_config` VALUES ('2', '工作活动状态', '3', '驳回');
INSERT INTO `wf_config` VALUES ('3', '工作项状态', '1', '正在办理');
INSERT INTO `wf_config` VALUES ('3', '工作项状态', '2', '正常结束');
INSERT INTO `wf_config` VALUES ('3', '工作项状态', '3', '强制结束');
INSERT INTO `wf_config` VALUES ('3', '工作项状态', '4', '驳回');
INSERT INTO `wf_config` VALUES ('3', '工作项状态', '5', '自动通过');
INSERT INTO `wf_config` VALUES ('3', '工作项状态', '6', '暂停');
INSERT INTO `wf_config` VALUES ('4', '流程状态', '1', '有效');
INSERT INTO `wf_config` VALUES ('4', '流程状态', '2', '无效');
INSERT INTO `wf_config` VALUES ('5', '活动类型', '1', '开始');
INSERT INTO `wf_config` VALUES ('5', '活动类型', '2', '中间段');
INSERT INTO `wf_config` VALUES ('5', '活动类型', '3', '结束');
INSERT INTO `wf_config` VALUES ('6', '评审类型', '1', '一人通过审批可流转');
INSERT INTO `wf_config` VALUES ('6', '评审类型', '2', '所有人通过评审才流转');
INSERT INTO `wf_config` VALUES ('7', '分支选择模式', '1', '默认');
INSERT INTO `wf_config` VALUES ('7', '分支选择模式', '2', '单选');
INSERT INTO `wf_config` VALUES ('7', '分支选择模式', '3', '多选');
INSERT INTO `wf_config` VALUES ('8', '操作者及监控者类型', '1', '用户');
INSERT INTO `wf_config` VALUES ('8', '操作者及监控者类型', '2', '岗位');
INSERT INTO `wf_config` VALUES ('8', '操作者及监控者类型', '3', '单位');
INSERT INTO `wf_config` VALUES ('9', '操作者选择模式', '1', '无约束');
INSERT INTO `wf_config` VALUES ('9', '操作者选择模式', '2', '同部门');
INSERT INTO `wf_config` VALUES ('10', '规则类型', '1', '大于');
INSERT INTO `wf_config` VALUES ('10', '规则类型', '2', '大于或等于');
INSERT INTO `wf_config` VALUES ('10', '规则类型', '3', '等于');
INSERT INTO `wf_config` VALUES ('10', '规则类型', '4', '小于');
INSERT INTO `wf_config` VALUES ('10', '规则类型', '5', '小于或等于');
INSERT INTO `wf_config` VALUES ('10', '规则类型', '6', '包含');
INSERT INTO `wf_config` VALUES ('10', '规则类型', '7', '不包含');
INSERT INTO `wf_config` VALUES ('11', '组件类型', '1', 'Label');
INSERT INTO `wf_config` VALUES ('11', '组件类型', '2', 'TextField');
INSERT INTO `wf_config` VALUES ('11', '组件类型', '3', 'NumberField');
INSERT INTO `wf_config` VALUES ('11', '组件类型', '4', 'DateField');
INSERT INTO `wf_config` VALUES ('11', '组件类型', '5', 'ComboBox');
INSERT INTO `wf_config` VALUES ('11', '组件类型', '6', 'DropDownField');
INSERT INTO `wf_config` VALUES ('11', '组件类型', '7', 'GridPanel');
INSERT INTO `wf_config` VALUES ('11', '组件类型', '8', 'Button');
INSERT INTO `wf_config` VALUES ('11', '组件类型', '9', 'CompositeField');
INSERT INTO `wf_config` VALUES ('11', '组件类型', '10', 'FileUploadField');
INSERT INTO `wf_config` VALUES ('11', '组件类型', '11', 'TextArea');
INSERT INTO `wf_config` VALUES ('11', '组件类型', '12', 'FieldSet');
INSERT INTO `wf_config` VALUES ('11', '组件类型', '13', 'TreePanel');
INSERT INTO `wf_config` VALUES ('11', '组件类型', '14', 'SpinnerField');
INSERT INTO `wf_config` VALUES ('11', '组件类型', '15', 'Container');
INSERT INTO `wf_config` VALUES ('11', '组件类型', '16', 'GridView');
INSERT INTO `wf_config` VALUES ('11', '组件类型', '17', 'TextBox');
INSERT INTO `wf_config` VALUES ('12', '可空标志', '1', '可空');
INSERT INTO `wf_config` VALUES ('12', '可空标志', '2', '不可空');
INSERT INTO `wf_config` VALUES ('13', '组件含义', '1', '自定义');
INSERT INTO `wf_config` VALUES ('13', '组件含义', '2', '删除业务数据');
INSERT INTO `wf_config` VALUES ('13', '组件含义', '3', '添加业务数据');
INSERT INTO `wf_config` VALUES ('14', '组件状态', '1', '可用');
INSERT INTO `wf_config` VALUES ('14', '组件状态', '2', '只读');
INSERT INTO `wf_config` VALUES ('14', '组件状态', '3', '隐藏');
INSERT INTO `wf_config` VALUES ('15', '活动属性', '1', '无特殊属性');
INSERT INTO `wf_config` VALUES ('15', '活动属性', '2', '关键属性');
INSERT INTO `wf_config` VALUES ('15', '活动属性', '3', '批量处理');
INSERT INTO `wf_config` VALUES ('16', '接收标志', '0', '未签收');
INSERT INTO `wf_config` VALUES ('16', '接收标志', '1', '已签收');
INSERT INTO `wf_config` VALUES ('17', '接收标志', '0', '无效');
INSERT INTO `wf_config` VALUES ('17', '接收标志', '1', '有效');

-- ----------------------------
-- Table structure for wf_flow
-- ----------------------------
DROP TABLE IF EXISTS `wf_flow`;
CREATE TABLE `wf_flow` (
  `FLOW_ID` int(38) NOT NULL AUTO_INCREMENT COMMENT '流程ID',
  `FLOW_NAME` varchar(64) NOT NULL DEFAULT '' COMMENT '流程名称',
  `FLOW_TYPE` varchar(64) NOT NULL DEFAULT '' COMMENT '流程类型',
  `FLOW_STATE` int(3) NOT NULL COMMENT '流程状态',
  `SYSTEM_ID` int(38) DEFAULT NULL,
  PRIMARY KEY (`FLOW_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=454 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wf_flow
-- ----------------------------

-- ----------------------------
-- Table structure for wf_form
-- ----------------------------
DROP TABLE IF EXISTS `wf_form`;
CREATE TABLE `wf_form` (
  `FORM_ID` int(38) NOT NULL AUTO_INCREMENT COMMENT '表单ID',
  `PARENT_FORM_ID` int(38) NOT NULL COMMENT '父级表单ID',
  `SYSTEM_ID` int(38) DEFAULT NULL COMMENT '系统ID',
  `FORM_NAME` varchar(127) NOT NULL DEFAULT '' COMMENT '表单名称',
  `URL` varchar(127) DEFAULT '' COMMENT '地址',
  `FORM_AUTO_CONTENT` blob COMMENT '表单内容',
  `FORM_DELBIZ_CONTROLLER` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`FORM_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=336 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wf_form
-- ----------------------------

-- ----------------------------
-- Table structure for wf_formauto_job
-- ----------------------------
DROP TABLE IF EXISTS `wf_formauto_job`;
CREATE TABLE `wf_formauto_job` (
  `JOBID` int(38) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `DATA_NAME` varchar(255) DEFAULT NULL COMMENT '表单名称',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '创建时间',
  `USER_ID` int(38) DEFAULT NULL COMMENT '用户ID',
  `USER_NAME` varchar(38) DEFAULT '' COMMENT '用户姓名',
  `FORM_ID` int(38) DEFAULT NULL COMMENT '表单ID',
  PRIMARY KEY (`JOBID`),
  KEY `refwf_form_id` (`FORM_ID`) USING BTREE,
  CONSTRAINT `wf_formauto_job_ibfk_1` FOREIGN KEY (`FORM_ID`) REFERENCES `wf_form` (`FORM_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=608 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wf_formauto_job
-- ----------------------------

-- ----------------------------
-- Table structure for wf_formauto_job_data
-- ----------------------------
DROP TABLE IF EXISTS `wf_formauto_job_data`;
CREATE TABLE `wf_formauto_job_data` (
  `JOB_ID` int(38) NOT NULL,
  `CONTROL_ID` int(38) NOT NULL,
  `VALUE` varchar(256) DEFAULT '' COMMENT '数据',
  `CONTROL_NAME` varchar(32) DEFAULT '' COMMENT '组件名称',
  PRIMARY KEY (`JOB_ID`,`CONTROL_ID`),
  KEY `REFWF_FORM_CONTROL` (`CONTROL_ID`) USING BTREE,
  CONSTRAINT `wf_formauto_job_data_ibfk_1` FOREIGN KEY (`CONTROL_ID`) REFERENCES `wf_form_control` (`CONTROL_ID`),
  CONSTRAINT `wf_formauto_job_data_ibfk_2` FOREIGN KEY (`JOB_ID`) REFERENCES `wf_formauto_job` (`JOBID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wf_formauto_job_data
-- ----------------------------

-- ----------------------------
-- Table structure for wf_form_control
-- ----------------------------
DROP TABLE IF EXISTS `wf_form_control`;
CREATE TABLE `wf_form_control` (
  `CONTROL_ID` int(38) NOT NULL AUTO_INCREMENT COMMENT '组件ID',
  `FORM_ID` int(38) NOT NULL COMMENT '表单ID',
  `CONTROL_NAME` varchar(132) NOT NULL DEFAULT '' COMMENT '组件名称',
  `CONTROL_TEXT` varchar(32) DEFAULT '' COMMENT '组件显示文本',
  `CONTROL_TYPE` int(3) NOT NULL COMMENT '组件类型',
  `NULL_PERMIT` int(3) NOT NULL COMMENT '为空标识',
  `DEFAULT_LENGTH` int(38) NOT NULL COMMENT '默认长度',
  `CONTROL_MEANING` int(3) NOT NULL COMMENT '控件含义',
  `USER_CONTROL_NAME` varchar(64) DEFAULT NULL COMMENT '用户组件名称',
  PRIMARY KEY (`CONTROL_ID`),
  KEY `refwf_form20` (`FORM_ID`) USING BTREE,
  CONSTRAINT `wf_form_control_ibfk_1` FOREIGN KEY (`FORM_ID`) REFERENCES `wf_form` (`FORM_ID`),
  CONSTRAINT `wf_form_control_ibfk_1
` FOREIGN KEY (`FORM_ID`) REFERENCES `wf_form` (`FORM_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=433 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wf_form_control
-- ----------------------------

-- ----------------------------
-- Table structure for wf_handler
-- ----------------------------
DROP TABLE IF EXISTS `wf_handler`;
CREATE TABLE `wf_handler` (
  `HANDLER_ID` int(38) NOT NULL AUTO_INCREMENT COMMENT '操作者ID',
  `ACTIVITY_ID` int(38) NOT NULL COMMENT '活动ID',
  `HANDLER` int(38) DEFAULT NULL COMMENT '操作者（rbac)',
  `HANDLER_TYPE` int(38) DEFAULT NULL COMMENT '操作者类型（rbac)',
  `HANDLER_NAME` varchar(255) DEFAULT '' COMMENT '操作者名字（rbac)',
  PRIMARY KEY (`HANDLER_ID`),
  KEY `refwf_activity15` (`ACTIVITY_ID`) USING BTREE,
  CONSTRAINT `wf_handler_ibfk_1` FOREIGN KEY (`ACTIVITY_ID`) REFERENCES `wf_activity` (`ACTIVITY_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3103 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wf_handler
-- ----------------------------

-- ----------------------------
-- Table structure for wf_line
-- ----------------------------
DROP TABLE IF EXISTS `wf_line`;
CREATE TABLE `wf_line` (
  `LINE_ID` int(38) NOT NULL AUTO_INCREMENT COMMENT '活动关系ID',
  `FLOW_ID` int(38) NOT NULL COMMENT '流程ID',
  `BEGIN_CODE` varchar(32) DEFAULT '' COMMENT '开始序号',
  `END_CODE` varchar(32) DEFAULT '' COMMENT '结束序号',
  `LINE_CONTENT` varchar(2048) DEFAULT '' COMMENT '线条',
  `LINE_INFLECTION` varchar(32) DEFAULT '',
  `LINE_NAME` varchar(32) DEFAULT '',
  `LINE_CODE` varchar(32) DEFAULT '',
  PRIMARY KEY (`LINE_ID`),
  KEY `fk_wf_line_wf_wf_flow` (`FLOW_ID`) USING BTREE,
  CONSTRAINT `wf_line_ibfk_1` FOREIGN KEY (`FLOW_ID`) REFERENCES `wf_flow` (`FLOW_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1142 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wf_line
-- ----------------------------

-- ----------------------------
-- Table structure for wf_monitor
-- ----------------------------
DROP TABLE IF EXISTS `wf_monitor`;
CREATE TABLE `wf_monitor` (
  `MONITOR_ID` int(38) NOT NULL AUTO_INCREMENT COMMENT '监控者ID',
  `FLOW_ID` int(38) NOT NULL COMMENT '流程ID',
  `MONITOR` int(38) DEFAULT NULL COMMENT '监控者（rbac)',
  `MONITOR_TYPE` int(3) DEFAULT NULL COMMENT '监控者类型（rbac)',
  PRIMARY KEY (`MONITOR_ID`),
  KEY `refef_flow14` (`FLOW_ID`) USING BTREE,
  CONSTRAINT `wf_monitor` FOREIGN KEY (`FLOW_ID`) REFERENCES `wf_flow` (`FLOW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wf_monitor
-- ----------------------------

-- ----------------------------
-- Table structure for wf_msg_set
-- ----------------------------
DROP TABLE IF EXISTS `wf_msg_set`;
CREATE TABLE `wf_msg_set` (
  `MSG_ID` int(38) NOT NULL AUTO_INCREMENT COMMENT '通知ID',
  `ACTIVITY_ID` int(38) NOT NULL COMMENT '活动ID',
  `RECEIVER_TYPE` int(3) NOT NULL COMMENT '接收者类型(rbac)',
  `RECEIVER_ID` int(38) NOT NULL COMMENT '接收者ID(rbac)',
  `RECEIVER_NAME` varchar(256) DEFAULT '' COMMENT '接收者名称(rbac)',
  PRIMARY KEY (`MSG_ID`),
  KEY `refwf_activity39` (`ACTIVITY_ID`) USING BTREE,
  CONSTRAINT `wf_msg_set_ibfk_1` FOREIGN KEY (`ACTIVITY_ID`) REFERENCES `wf_activity` (`ACTIVITY_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wf_msg_set
-- ----------------------------

-- ----------------------------
-- Table structure for wf_system
-- ----------------------------
DROP TABLE IF EXISTS `wf_system`;
CREATE TABLE `wf_system` (
  `SYSTEM_ID` int(38) NOT NULL AUTO_INCREMENT,
  `SYSTEM_NAME` varchar(64) DEFAULT '',
  `CREATE_DATE` datetime DEFAULT NULL,
  PRIMARY KEY (`SYSTEM_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wf_system
-- ----------------------------

-- ----------------------------
-- Table structure for wf_work
-- ----------------------------
DROP TABLE IF EXISTS `wf_work`;
CREATE TABLE `wf_work` (
  `WORK_ID` int(38) NOT NULL AUTO_INCREMENT COMMENT '工作ID',
  `FLOW_ID` int(38) NOT NULL COMMENT '流程ID',
  `WORK_NAME` varchar(256) DEFAULT NULL COMMENT '工作名称',
  `WORK_STATE` int(3) NOT NULL COMMENT '工作状态',
  `SPONSOR_ID` int(38) NOT NULL COMMENT '发起人(rbac)',
  `SPONSOR_NAME` varchar(16) DEFAULT '' COMMENT '发起人名称(rbac)',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '创建时间',
  `MAIN_BIZ_KEY` varchar(128) DEFAULT NULL COMMENT '主表键值',
  `PARENT_WORK_ID` int(38) DEFAULT NULL COMMENT '父工作ID',
  `PARENT_ACTIVITY_ID` int(38) DEFAULT NULL COMMENT '父活动ID',
  PRIMARY KEY (`WORK_ID`),
  KEY `fk_wf_work_wf_flow` (`FLOW_ID`) USING BTREE,
  CONSTRAINT `wf_work_ibfk_1` FOREIGN KEY (`FLOW_ID`) REFERENCES `wf_flow` (`FLOW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wf_work
-- ----------------------------

-- ----------------------------
-- Table structure for wf_work_activity
-- ----------------------------
DROP TABLE IF EXISTS `wf_work_activity`;
CREATE TABLE `wf_work_activity` (
  `WORK_ACTIVITY_ID` int(38) NOT NULL AUTO_INCREMENT COMMENT '工作活动ID',
  `WORK_ID` int(38) NOT NULL COMMENT '工作ID',
  `ACTIVITY_ID` int(38) NOT NULL COMMENT '活动ID',
  `WORK_ACTIVITY_STATE` int(38) DEFAULT NULL COMMENT '工作活动状态',
  `CREATE_DATETIME` datetime NOT NULL COMMENT '创建时间',
  `FINISHED_DATETIME` datetime DEFAULT NULL COMMENT '完成时间',
  `PRE_ACTIVITY_INFO` varchar(256) DEFAULT '' COMMENT '前一个活动信息',
  `NEXT_ACTIVITY_HANDLERS` varchar(128) DEFAULT '' COMMENT '下一活动经办者',
  `NEXT_ACTIVITY_CODES` varchar(128) DEFAULT '' COMMENT '下一活动编码',
  PRIMARY KEY (`WORK_ACTIVITY_ID`),
  KEY `fk_wf_work_activity_wf_work` (`WORK_ID`) USING BTREE,
  KEY `refwf_activity29` (`ACTIVITY_ID`) USING BTREE,
  CONSTRAINT `wf_work_activity_ibfk_1` FOREIGN KEY (`WORK_ID`) REFERENCES `wf_work` (`WORK_ID`),
  CONSTRAINT `wf_work_activity_ibfk_2` FOREIGN KEY (`ACTIVITY_ID`) REFERENCES `wf_activity` (`ACTIVITY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wf_work_activity
-- ----------------------------

-- ----------------------------
-- Table structure for wf_work_item
-- ----------------------------
DROP TABLE IF EXISTS `wf_work_item`;
CREATE TABLE `wf_work_item` (
  `WORK_ITEM_ID` int(38) NOT NULL AUTO_INCREMENT COMMENT '工作项ID',
  `WORK_ACTIVITY_ID` int(38) NOT NULL COMMENT '工作活动ID',
  `RECEIVER_TYPE` int(3) DEFAULT NULL COMMENT '接收者类型（rbac)',
  `RECEIVER_ID` int(38) NOT NULL COMMENT '接收者ID（rbac)',
  `RECEIVER_NAME` varchar(255) DEFAULT '' COMMENT '接收者名称（rbac）',
  `CONTENT` varchar(256) DEFAULT '' COMMENT '审批内容',
  `WORK_ITEM_DATETIME` datetime DEFAULT NULL COMMENT '审批时间',
  `WORK_ITEM_STATE` int(3) DEFAULT NULL COMMENT '工作项状态',
  `RESPONSIBLE_ID` int(38) DEFAULT NULL COMMENT '经办人ID（rbac)',
  `SIGN_NAME` varchar(32) DEFAULT NULL COMMENT '签字人（rbac)',
  `SIGN_DATE` datetime DEFAULT NULL COMMENT '签字时间',
  `SIGN_OPINION` varchar(128) DEFAULT NULL COMMENT '签字意见',
  PRIMARY KEY (`WORK_ITEM_ID`),
  KEY `refwf_work_activity17` (`WORK_ACTIVITY_ID`) USING BTREE,
  CONSTRAINT `wf_work_item_ibfk_1` FOREIGN KEY (`WORK_ACTIVITY_ID`) REFERENCES `wf_work_activity` (`WORK_ACTIVITY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wf_work_item
-- ----------------------------

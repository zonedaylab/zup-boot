
## zup版本


1）zup的main.jsp返回配置的BI报表，没有考虑@BI配置，导致出错
2）zup plugin/ace/bi 的js css文件不全导致页面加载出错(ReportTemplage.jsp)
3） CharacterFilter.java 过滤了table关键字导致出错
4） Data truncation: Data too long for column 'LOGINFO' at row 1
\cn\zup\mapper\bi\TopicMapper.xml
 Unknown column 'DS_ID' in 'field list'
 
 
 
1.1.1 BI升级--->

-- copy  webap/plug-in/ace/bi覆盖业务系统


------增加数据源
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
-- Records of bi_datasource  bi-demo替换成自己的数据库如fund_nature 
-- ----------------------------
BEGIN;
INSERT INTO `bi_datasource` VALUES (1, '127.0.0.1', 3306, 'root', '123456', 'mysql', 'bi-demo', 'root', '2020-02-13 17:59:03');
COMMIT;
-- 添加数据源字段,默认数据源字段1.
ALTER TABLE BI_TOPIC DROP COLUMN DS_ID;
ALTER TABLE BI_TOPIC ADD COLUMN DS_ID int(38) DEFAULT 1

####配置数据源配置菜单  BI_datasource
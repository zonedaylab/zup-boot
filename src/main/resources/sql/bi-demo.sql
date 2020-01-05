/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50725
 Source Host           : localhost:3306
 Source Schema         : bi-demo

 Target Server Type    : MySQL
 Target Server Version : 50725
 File Encoding         : 65001

 Date: 21/12/2019 12:00:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for pms_bra1nd
-- ----------------------------
DROP TABLE IF EXISTS `pms_bra1nd`;
CREATE TABLE `pms_bra1nd` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `first_letter` varchar(8) DEFAULT NULL COMMENT '首字母',
  `sort` int(11) DEFAULT NULL,
  `factory_status` int(1) DEFAULT NULL COMMENT '是否为品牌制造商：0->不是；1->是',
  `show_status` int(1) DEFAULT NULL,
  `product_count` int(11) DEFAULT NULL COMMENT '产品数量',
  `product_comment_count` int(11) DEFAULT NULL COMMENT '产品评论数量',
  `logo` varchar(255) DEFAULT NULL COMMENT '品牌logo',
  `big_pic` varchar(255) DEFAULT NULL COMMENT '专区大图',
  `brand_story` text COMMENT '品牌故事',
  `category_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8 COMMENT='品牌表';

-- ----------------------------
-- Records of pms_bra1nd
-- ----------------------------
BEGIN;
INSERT INTO `pms_bra1nd` VALUES (62, '可口可乐', 'K', 0, 1, 1, NULL, NULL, 'http://39.98.239.6:8080/file/20190601/img_fbee37908406440ba5d96e6afc4d330f_webwxgetmsgimg (1).jpg', '', '', 56);
INSERT INTO `pms_bra1nd` VALUES (63, '康师傅饮品', 'KY', 0, 1, 1, NULL, NULL, 'http://39.98.239.6:8080/file/20190601/img_0c7eadd8b59f4bdba0b3109a68d658e8_webwxgetmsgimg (2).jpg', '', '', 56);
INSERT INTO `pms_bra1nd` VALUES (64, '海底捞', 'H', 0, 1, 1, NULL, NULL, 'http://39.98.239.6:8080/file/20190601/img_7f17dac6cf3447978919a8f2ed10f846_1779536430.jpg', '', '', 61);
INSERT INTO `pms_bra1nd` VALUES (65, '康师傅食品', 'KS', 0, 1, 1, NULL, NULL, 'http://39.98.239.6:8080/file/20190601/img_773dac9125414c9cb661dafdf48f52bc_webwxgetmsgimg.jpg', '', '', 62);
INSERT INTO `pms_bra1nd` VALUES (66, '元气森林', 'Y', 0, 0, 0, NULL, NULL, 'http://39.98.239.6:8080/file/20190601/img_486529c5564c46a79a4baba9a6def7c7_webwxgetmsgimg (6).jpg', '', '', 56);
INSERT INTO `pms_bra1nd` VALUES (67, '娃哈哈', 'w', 0, 1, 1, NULL, NULL, 'http://39.98.239.6:8080/file/20190605/img_1d757ec1f74f47a29e1a7a6a10c05605_1604295357.jpg', '', '', 56);
INSERT INTO `pms_bra1nd` VALUES (68, '达利园', 'd', 0, 1, 1, NULL, NULL, 'http://39.98.239.6:8080/file/20190605/img_ac40078c3f9744fd8bc2b3b3a48e8370_1395735338.jpg', '', '', 56);
INSERT INTO `pms_bra1nd` VALUES (70, '农夫山泉', 'N', 0, 1, 1, NULL, NULL, 'http://39.98.239.6:8080/file/20190609/img_428918e8743c491d8b952ac7bec5471f_webwxgetmsgimg (23).jpg', '', '', 56);
COMMIT;

-- ----------------------------
-- Table structure for pms_product
-- ----------------------------
DROP TABLE IF EXISTS `pms_product`;
CREATE TABLE `pms_product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `brand_id` bigint(20) DEFAULT NULL,
  `product_category_id` bigint(20) DEFAULT NULL,
  `feight_template_id` bigint(20) DEFAULT NULL,
  `product_attribute_category_id` bigint(20) DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `pic` varchar(255) DEFAULT NULL,
  `product_sn` varchar(64) DEFAULT NULL COMMENT '货号',
  `delete_status` int(1) DEFAULT NULL COMMENT '删除状态：0->未删除；1->已删除',
  `publish_status` int(1) DEFAULT NULL COMMENT '上架状态：0->下架；1->上架',
  `new_status` int(1) DEFAULT NULL COMMENT '新品状态:0->不是新品；1->新品',
  `recommand_status` int(1) DEFAULT NULL COMMENT '推荐状态；0->不推荐；1->推荐',
  `verify_status` int(1) DEFAULT NULL COMMENT '审核状态：0->未审核；1->审核通过',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `sale` int(11) DEFAULT NULL COMMENT '销量',
  `price` decimal(10,2) DEFAULT NULL,
  `promotion_price` decimal(10,2) DEFAULT NULL COMMENT '促销价格',
  `gift_growth` int(11) DEFAULT '0' COMMENT '赠送的成长值',
  `gift_point` int(11) DEFAULT '0' COMMENT '赠送的积分',
  `use_point_limit` int(11) DEFAULT NULL COMMENT '限制使用的积分数',
  `sub_title` varchar(255) DEFAULT NULL COMMENT '副标题',
  `description` text COMMENT '商品描述',
  `original_price` decimal(10,2) DEFAULT NULL COMMENT '市场价',
  `stock` int(11) DEFAULT NULL COMMENT '库存',
  `low_stock` int(11) DEFAULT NULL COMMENT '库存预警值',
  `unit` varchar(16) DEFAULT NULL COMMENT '单位',
  `weight` decimal(10,2) DEFAULT NULL COMMENT '商品重量，默认为克',
  `preview_status` int(1) DEFAULT NULL COMMENT '是否为预告商品：0->不是；1->是',
  `service_ids` varchar(64) DEFAULT NULL COMMENT '以逗号分割的产品服务：1->无忧退货；2->快速退款；3->免费包邮',
  `keywords` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `album_pics` varchar(255) DEFAULT NULL COMMENT '画册图片，连产品图片限制为5张，以逗号分割',
  `detail_title` varchar(255) DEFAULT NULL,
  `detail_desc` text,
  `detail_html` text COMMENT '产品详情网页内容',
  `detail_mobile_html` text COMMENT '移动端网页详情',
  `promotion_start_time` datetime DEFAULT NULL COMMENT '促销开始时间',
  `promotion_end_time` datetime DEFAULT NULL COMMENT '促销结束时间',
  `promotion_per_limit` int(11) DEFAULT NULL COMMENT '活动限购数量',
  `promotion_type` int(1) DEFAULT NULL COMMENT '促销类型：0->没有促销使用原价;1->使用促销价；2->使用会员价；3->使用阶梯价格；4->使用满减价格；5->限时购',
  `brand_name` varchar(255) DEFAULT NULL COMMENT '品牌名称',
  `product_category_name` varchar(255) DEFAULT NULL COMMENT '商品分类名称',
  `is_package` int(2) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8 COMMENT='商品信息';

-- ----------------------------
-- Records of pms_product
-- ----------------------------
BEGIN;
INSERT INTO `pms_product` VALUES (1, 62, 56, 0, NULL, '可口可乐500ml*24瓶/箱', 'http://39.98.239.6:8080/file/20190601/img_a5f32729b9884a38b28a18d514e624b8_51551025.jpg', '', 0, 1, 0, 0, 0, 0, 0, 49.00, 45.00, 0, 0, 0, '可口可乐', '', 49.00, 111, 0, '箱', 300.00, 0, '', '', '', '', '', '', '<p>可口可乐</p>', '', NULL, NULL, 0, 1, '可口可乐', '饮料', 0);
INSERT INTO `pms_product` VALUES (2, 62, 59, 0, NULL, '显示圣诞节', 'http://39.98.239.6:8080/file/20190601/img_81b2b9e5c4a343ec9c9d85129b3d6861_TIM截图20190421175750.png', '', 1, 1, 1, 1, 0, 0, 0, 0.00, 45.00, 0, 0, 0, '是大V是', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '可口可乐', '膨化食品', 0);
INSERT INTO `pms_product` VALUES (3, 64, 61, 0, NULL, '海底捞 脆爽牛肚自热火锅435g/盒', 'http://39.98.239.6:8080/file/20190601/img_ecec3c90b37f4d88b7d787aee93d95a0_webwxgetmsgimg.jpg', '', 0, 1, 0, 0, 0, 0, 0, 0.00, 45.00, 0, 0, 0, '海底捞', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '海底捞', '', 0);
INSERT INTO `pms_product` VALUES (4, 63, 56, 0, NULL, '康师傅冰红茶500ml*15瓶/箱', 'http://39.98.239.6:8080/file/20190601/img_ebacb24dd2214c7db61201b7b12b804e_webwxgetmsgimg (3).jpg', '', 0, 1, 0, 0, 0, 0, 0, 0.00, 45.00, 0, 0, 0, '康师傅冰红茶', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅饮品', '饮料', 0);
INSERT INTO `pms_product` VALUES (5, 65, 62, 0, NULL, '康师傅红烧牛肉面108g*24袋/箱', 'http://39.98.239.6:8080/file/20190601/img_a13f6cfdb99a4742becc49c22398574d_webwxgetmsgimg (4).jpg', '', 0, 1, 0, 0, 0, 0, 0, 0.00, 45.00, 0, 0, 0, '康师傅红烧牛肉面', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅食品', '', 0);
INSERT INTO `pms_product` VALUES (6, 66, 56, 0, NULL, '元气森林', 'http://39.98.239.6:8080/file/20190601/img_41d6f40de5f04958ab71f66f3b099565_webwxgetmsgimg (5).jpg', '', 0, 0, 0, 1, 0, 0, 0, 0.00, 45.00, 0, 0, 0, '元气森林', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '元气森林', '饮料', 0);
INSERT INTO `pms_product` VALUES (7, 62, 56, 0, NULL, '雪碧500ml*24瓶/箱', 'http://39.98.239.6:8080/file/20190604/img_f9955d3e5cf349089bed818d4085a52a_1220290277.jpg', '', 0, 1, 0, 0, 0, 0, 0, 50.00, 45.00, 0, 0, 0, '500ml*24', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '可口可乐', '饮料', 0);
INSERT INTO `pms_product` VALUES (8, 62, 56, 0, NULL, '雪碧零卡500ml*24瓶/箱', 'http://39.98.239.6:8080/file/20190604/img_dc24131170f44faeafa161c28a1b8aeb_363564124.jpg', '', 0, 1, 0, 0, 0, 0, 0, 50.00, 45.00, 0, 0, 0, '500ml*24', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '可口可乐', '饮料', 0);
INSERT INTO `pms_product` VALUES (9, 62, 56, 0, NULL, '可乐摩登罐330ml*24听/箱', 'http://39.98.239.6:8080/file/20190604/img_db01250656ae43f1887c08551e2438cd_50906534.jpg', '', 0, 1, 0, 0, 0, 0, 0, 47.00, 45.00, 0, 0, 0, '330ml*24', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '可口可乐', '饮料', 0);
INSERT INTO `pms_product` VALUES (10, 62, 56, 0, NULL, '雪碧摩登罐330ml*24听/箱', 'http://39.98.239.6:8080/file/20190604/img_0c74f34ead5c453dade12c74c00709b0_1002239369.jpg', '', 0, 1, 0, 0, 0, 0, 0, 47.00, 45.00, 0, 0, 0, '330ml*24', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '可口可乐', '饮料', 0);
INSERT INTO `pms_product` VALUES (11, 62, 56, 0, NULL, '零度可乐摩登罐330ml*24听/箱', 'http://39.98.239.6:8080/file/20190604/img_67adf0d73d594f3d8c926ebfe02635dc_1521311088.jpg', '', 0, 1, 0, 0, 0, 0, 0, 47.00, 45.00, 0, 0, 0, '330ml*24', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '可口可乐', '饮料', 0);
INSERT INTO `pms_product` VALUES (12, 62, 56, 0, NULL, '雪碧零卡摩登罐330ml*24听/箱', 'http://39.98.239.6:8080/file/20190604/img_e43df668cb9c4b3fb5ff2ba03cd8c380_351902092.jpg', '', 0, 1, 0, 0, 0, 0, 0, 0.00, 45.00, 0, 0, 0, '330ml*24', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '可口可乐', '饮料', 0);
INSERT INTO `pms_product` VALUES (13, 62, 56, 0, NULL, '芬达摩登罐330ml*24听/箱', 'http://39.98.239.6:8080/file/20190604/img_9e97aff20f2044e699c1d889d4c6d11a_1200594773.jpg', '', 0, 1, 0, 0, 0, 0, 0, 0.00, 45.00, 0, 0, 0, '330ml*24听', '', 47.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '可口可乐', '饮料', 0);
INSERT INTO `pms_product` VALUES (14, 62, 56, 0, NULL, '芬达500ml*12瓶/箱', 'http://39.98.239.6:8080/file/20190604/img_b12d79e0803f46b8820536989da06e5f_966764037.jpg', '', 0, 1, 0, 0, 0, 0, 0, 25.00, 45.00, 0, 0, 0, '500ml*12瓶', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '可口可乐', '饮料', 0);
INSERT INTO `pms_product` VALUES (15, 62, 56, 0, NULL, '雪碧300ml*12瓶/箱', 'http://39.98.239.6:8080/file/20190604/img_fdde0fdafb26437686eb19c8c66cea1b_1429615013.jpg', '', 0, 1, 0, 0, 0, 0, 0, 19.00, 45.00, 0, 0, 0, '300ml*12', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '可口可乐', '饮料', 0);
INSERT INTO `pms_product` VALUES (16, 62, 56, 0, NULL, '雪碧2L*6瓶/箱', 'http://39.98.239.6:8080/file/20190604/img_15ac9abd6578485b8cc1636e42f4b321_1943001119.jpg', '', 0, 1, 0, 0, 0, 0, 0, 30.00, 45.00, 0, 0, 0, '2', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '可口可乐', '饮料', 0);
INSERT INTO `pms_product` VALUES (17, 62, 56, 0, NULL, '纤维雪碧500ml*12瓶/箱', 'http://39.98.239.6:8080/file/20190604/img_691fd26ebecb4a40b0a6cb6f73c49e38_1663258282.jpg', '', 0, 1, 0, 0, 0, 0, 0, 39.00, 45.00, 0, 0, 0, '5', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '可口可乐', '饮料', 0);
INSERT INTO `pms_product` VALUES (18, 62, 56, 0, NULL, '可乐零度500ml*24瓶/箱', 'http://39.98.239.6:8080/file/20190604/img_88b9ad83970e4514bb0e01ebbb9d7149_1990542416.jpg', '', 0, 1, 0, 0, 0, 0, 0, 49.00, 45.00, 0, 0, 0, '5', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '可口可乐', '饮料', 0);
INSERT INTO `pms_product` VALUES (19, 62, 56, 0, NULL, '零度l可乐300ml*12瓶/箱', 'http://39.98.239.6:8080/file/20190604/img_89b5697b7427425eafd91bff80afc5f2_1215862875.jpg', '', 0, 1, 0, 0, 0, 0, 0, 19.00, 45.00, 0, 0, 0, '3', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '可口可乐', '饮料', 0);
INSERT INTO `pms_product` VALUES (20, 62, 56, 0, NULL, '可乐300ml*12瓶/箱', 'http://39.98.239.6:8080/file/20190604/img_7703ac8ab40949bf9ca2860469da3028_1868958010.jpg', '', 0, 1, 0, 0, 0, 0, 0, 19.00, 45.00, 0, 0, 0, '3', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '可口可乐', '饮料', 0);
INSERT INTO `pms_product` VALUES (21, 62, 56, 0, NULL, '可乐2L*6瓶/箱', 'http://39.98.239.6:8080/file/20190604/img_8c168524a9c4418e809f458ebe7f1f9c_824020482.jpg', '', 0, 1, 0, 0, 0, 0, 0, 30.00, 45.00, 0, 0, 0, '2', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '可口可乐', '饮料', 0);
INSERT INTO `pms_product` VALUES (22, 62, 56, 0, NULL, '纤维可乐500ml*12瓶', 'http://39.98.239.6:8080/file/20190604/img_35c61824f9524afda5e3cbd84d75a531_824020482.jpg', '', 1, 1, 0, 0, 0, 0, 0, 39.00, 45.00, 0, 0, 0, '5', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '可口可乐', '饮料', 0);
INSERT INTO `pms_product` VALUES (23, 62, 56, 0, NULL, '纤维可乐500ml*12瓶/箱', 'http://39.98.239.6:8080/file/20190604/img_0769ce3a54cb4ed189e569275d406c31_968606858.jpg', '', 0, 1, 0, 0, 0, 0, 0, 39.00, 45.00, 0, 0, 0, '5', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '可口可乐', '饮料', 0);
INSERT INTO `pms_product` VALUES (24, 62, 56, 0, NULL, '可乐888ml*12瓶/箱', 'http://39.98.239.6:8080/file/20190604/img_c3c04f723f4e4a7f85db3d775a7f1dcf_1815423489.jpg', '', 0, 1, 0, 0, 0, 0, 0, 38.00, 45.00, 0, 0, 0, '8', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '可口可乐', '饮料', 0);
INSERT INTO `pms_product` VALUES (25, 62, 56, 0, NULL, '雪碧888ml*12瓶/箱', 'http://39.98.239.6:8080/file/20190604/img_077a090a92694f83bfbfbcad0530c7c2_1050322838.jpg', '', 0, 1, 0, 0, 0, 0, 0, 38.00, 45.00, 0, 0, 0, '8', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '可口可乐', '饮料', 0);
INSERT INTO `pms_product` VALUES (26, 62, 56, 0, NULL, '纤维可乐330ml*24听/箱', 'http://39.98.239.6:8080/file/20190604/img_8e2d62debbe64d7fa76d21d998e9efb8_935708080.jpg', '', 0, 1, 0, 0, 0, 0, 0, 70.00, 45.00, 0, 0, 0, '3', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '可口可乐', '饮料', 0);
INSERT INTO `pms_product` VALUES (27, 62, 56, 0, NULL, '纤维雪碧330ml*24听/箱', 'http://39.98.239.6:8080/file/20190604/img_fbf651e719d64ff38f8dff4cb4942445_83822365.jpg', '', 0, 1, 0, 0, 0, 0, 0, 70.00, 45.00, 0, 0, 0, '3', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '可口可乐', '饮料', 0);
INSERT INTO `pms_product` VALUES (28, 62, 56, 0, NULL, '芬达2L*6瓶/箱', 'http://39.98.239.6:8080/file/20190604/img_19b2ed09583b4d07b5f3cd9789bedee6_911898801.jpg', '', 0, 1, 0, 0, 0, 0, 0, 30.00, 45.00, 0, 0, 0, '2', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '可口可乐', '饮料', 0);
INSERT INTO `pms_product` VALUES (29, 62, 56, 0, NULL, '芬达苹果味500ml*12瓶/箱', 'http://39.98.239.6:8080/file/20190604/img_8f50704fa0944f48bbb2405c7b06f3d4_1311022489.jpg', '', 0, 1, 0, 0, 0, 0, 0, 25.00, 45.00, 0, 0, 0, '5', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '可口可乐', '饮料', 0);
INSERT INTO `pms_product` VALUES (30, 62, 56, 0, NULL, '芬达葡萄500ml*12瓶/箱', 'http://39.98.239.6:8080/file/20190604/img_7bb00b7575344c05bcf94819d0c3ab07_301663517.jpg', '', 0, 1, 0, 0, 0, 0, 0, 25.00, 45.00, 0, 0, 0, '5', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '可口可乐', '饮料', 0);
INSERT INTO `pms_product` VALUES (31, 62, 56, 0, NULL, '芬达桃味500ml*12瓶/箱', 'http://39.98.239.6:8080/file/20190604/img_ddbc4ebc2caa4714808bffad26242cc5_1410208482.jpg', '', 0, 1, 0, 0, 0, 0, 0, 25.00, 45.00, 0, 0, 0, '5', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '可口可乐', '饮料', 0);
INSERT INTO `pms_product` VALUES (32, 62, 56, 0, NULL, '芬达苹果味2L*6瓶/箱', 'http://39.98.239.6:8080/file/20190604/img_f79e57d9c8314c16b01792b1b1cb9363_356018712.jpg', '', 0, 1, 0, 0, 0, 0, 0, 30.00, 45.00, 0, 0, 0, '2', '', 30.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '可口可乐', '饮料', 0);
INSERT INTO `pms_product` VALUES (33, 62, 56, 0, NULL, '芬达菠萝味500ml*12瓶/箱', 'http://39.98.239.6:8080/file/20190604/img_b92dd8c1ca554c7c870b02fa66569d8a_951806207.jpg', '', 0, 1, 0, 0, 0, 0, 0, 25.00, 45.00, 0, 0, 0, '5', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '可口可乐', '饮料', 0);
INSERT INTO `pms_product` VALUES (34, 63, 56, 0, NULL, '康师傅冰红茶1L*12瓶/箱', 'http://39.98.239.6:8080/file/20190605/img_4c8a35b7f15b4e9cbd4f5db6432dd053_972990659.jpg', '6921317996364', 0, 1, 0, 0, 0, 0, 0, 35.00, 45.00, 0, 0, 0, '1', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅饮品', '饮料', 0);
INSERT INTO `pms_product` VALUES (35, 66, 56, 0, NULL, '元气森林青瓜味苏打气泡水480ml*15瓶/箱', 'http://39.98.239.6:8080/file/20190605/img_52d94bb79e524404ae9fcffc311d49db_602959484.jpg', '6970399920057', 0, 1, 0, 0, 0, 0, 0, 52.00, 45.00, 0, 0, 0, '4', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '元气森林', '饮料', 0);
INSERT INTO `pms_product` VALUES (36, 67, 63, 0, NULL, '娃哈哈饮用纯净水596ml*24瓶/箱', 'http://39.98.239.6:8080/file/20190605/img_110e70a8d69440b99b2356c4afec1867_626449966.jpg', '6902083881405', 0, 1, 0, 0, 0, 0, 0, 22.00, 45.00, 0, 0, 0, '5', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '娃哈哈', '矿泉水', 0);
INSERT INTO `pms_product` VALUES (37, 66, 56, 0, NULL, '元气森林白桃味苏打气泡水480ml*15瓶/箱', 'http://39.98.239.6:8080/file/20190605/img_7247eec20125451baa875d1a13f7893d_213249147.jpg', '', 0, 1, 0, 0, 0, 0, 0, 52.00, 45.00, 0, 0, 0, '4', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '元气森林', '饮料', 0);
INSERT INTO `pms_product` VALUES (38, 66, 56, 0, NULL, '元气森林卡曼橘味苏打气泡水480ml*15瓶/箱', 'http://39.98.239.6:8080/file/20190605/img_88f0ba41aa4e46178946f931daa8e9ba_710549285.jpg', '', 0, 1, 0, 0, 0, 0, 0, 52.00, 45.00, 0, 0, 0, '4', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '元气森林', '饮料', 0);
INSERT INTO `pms_product` VALUES (39, 66, 56, 0, NULL, '元气森林醇香乌龙500ml*15瓶/箱', 'http://39.98.239.6:8080/file/20190605/img_2bbd0a47180a437485b2a898374cc094_547229835.jpg', '', 0, 1, 0, 0, 0, 0, 0, 62.00, 45.00, 0, 0, 0, '5', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '元气森林', '饮料', 0);
INSERT INTO `pms_product` VALUES (40, 66, 56, 0, NULL, '元气森林石榴绿茶500ml*15瓶/箱', 'http://39.98.239.6:8080/file/20190605/img_4e82ec820d9240b28d9c28f5bbd74f15_1570423945.jpg', '6970399920033', 0, 1, 0, 0, 0, 0, 0, 62.00, 45.00, 0, 0, 0, '5', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '元气森林', '饮料', 0);
INSERT INTO `pms_product` VALUES (41, 68, 56, 0, NULL, '达利园青梅绿茶500ml*15瓶/箱', 'http://39.98.239.6:8080/file/20190605/img_111b40b415b64f3d8eb3d91ad4dd5378_1358808225.jpg', '6911988014320', 0, 1, 0, 0, 0, 0, 0, 26.00, 45.00, 0, 0, 0, '5', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '达利园', '饮料', 0);
INSERT INTO `pms_product` VALUES (42, 66, 56, 0, NULL, '元气森林百香果绿茶500ml*15瓶/箱', 'http://39.98.239.6:8080/file/20190605/img_22b19e3b5fac47a3a05f7ef3fe97fcee_webwxgetmsgimg(1).jpg', '', 0, 1, 0, 0, 0, 0, 0, 62.00, 45.00, 0, 0, 0, '5', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '元气森林', '饮料', 0);
INSERT INTO `pms_product` VALUES (43, 66, 56, 0, NULL, '元气森林柠檬绿茶500ml*15瓶/箱', 'http://39.98.239.6:8080/file/20190605/img_666f662b914f4f1eb3c64ed2d1f1400f_webwxgetmsgimg(1).jpg', '', 0, 1, 0, 0, 0, 0, 0, 62.00, 45.00, 0, 0, 0, '5', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '元气森林', '饮料', 0);
INSERT INTO `pms_product` VALUES (44, 66, 56, 0, NULL, '宠肌青苹果味胶原蛋白饮品410ml*15瓶/箱', 'http://39.98.239.6:8080/file/20190605/img_e61256e6c6364f03adc5bb2a413d42f4_931942989.jpg', '6970399921030', 0, 1, 1, 0, 0, 0, 0, 100.00, 45.00, 0, 0, 0, '4', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '元气森林', '饮料', 0);
INSERT INTO `pms_product` VALUES (45, 66, 56, 0, NULL, '宠肌白桃味胶原蛋白水410ml*15瓶/箱', 'http://39.98.239.6:8080/file/20190605/img_e7b8c1caff104c84a649034877c81d49_228388330.jpg', '6970399921054', 0, 1, 1, 0, 0, 0, 0, 100.00, 45.00, 0, 0, 0, '4', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '元气森林', '饮料', 0);
INSERT INTO `pms_product` VALUES (46, 66, 56, 0, NULL, '元气森林健美轻茶500ml*15瓶/箱', 'http://39.98.239.6:8080/file/20190605/img_b67694279ced4fef983fe5417ae4c517_1582409996.jpg', '', 0, 1, 1, 0, 0, 0, 0, 100.00, 45.00, 0, 0, 0, '5', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '元气森林', '饮料', 0);
INSERT INTO `pms_product` VALUES (47, 66, 56, 0, NULL, '元气森林玄米乌龙茶500ml*15瓶/箱', 'http://39.98.239.6:8080/file/20190605/img_d1634d88a2644c938627025e5c083fd1_1632312964.jpg', '', 0, 1, 0, 0, 0, 0, 0, 62.00, 45.00, 0, 0, 0, '5', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '元气森林', '饮料', 0);
INSERT INTO `pms_product` VALUES (48, 62, 63, 0, NULL, '冰露包装饮用水550ml*12瓶/箱', 'http://39.98.239.6:8080/file/20190605/img_6d788912a73b449e8c7c76842a339e04_296547229.jpg', '6954767470573', 0, 1, 0, 0, 0, 0, 0, 5.50, 45.00, 0, 0, 0, '5', '', 0.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '可口可乐', '矿泉水', 0);
INSERT INTO `pms_product` VALUES (49, 63, 56, 0, NULL, '康师傅 绿茶500ml 15瓶/箱', 'http://39.98.239.6:8080/file/20190608/img_ccda3135fb624b099b3e0bdee0360578_379230971.jpg', '', 0, 1, 0, 0, 0, 0, 0, 30.00, 45.00, 0, 0, 0, '康师傅', '', 30.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅饮品', '饮料', 0);
INSERT INTO `pms_product` VALUES (50, 63, 56, 0, NULL, '康师傅冰红茶2L*6瓶/箱', 'http://39.98.239.6:8080/file/20190608/img_db622ccc83d14d0c83f81d837e0e28f8_webwxgetmsgimg.jpg', '', 0, 1, 0, 0, 0, 0, 0, 30.00, 45.00, 0, 0, 0, '康师傅红茶', '', 30.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅饮品', '饮料', 0);
INSERT INTO `pms_product` VALUES (51, 63, 56, 0, NULL, '康师傅绿茶1L*12瓶/箱', 'http://39.98.239.6:8080/file/20190608/img_aa77f18240ae40c0a146660fa50be467_webwxgetmsgimg (2).jpg', '', 0, 1, 0, 0, 0, 0, 0, 35.00, 45.00, 0, 0, 0, '康师傅绿茶', '', 35.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅饮品', '饮料', 0);
INSERT INTO `pms_product` VALUES (52, 63, 56, 0, NULL, '康师傅绿茶2L*6/箱', 'http://39.98.239.6:8080/file/20190608/img_506176e5da8048c7a4b822388fb74b9f_webwxgetmsgimg (1).jpg', '', 0, 1, 0, 0, 0, 0, 0, 30.00, 45.00, 0, 0, 0, '康师傅绿茶', '', 30.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅饮品', '饮料', 0);
INSERT INTO `pms_product` VALUES (53, 63, 56, 0, NULL, '康师傅茉莉蜜茶500ml*15/箱', 'http://39.98.239.6:8080/file/20190608/img_fabd8366dd984d12bd835cabec616aad_webwxgetmsgimg (3).jpg', '', 0, 1, 0, 0, 0, 0, 0, 30.00, 45.00, 0, 0, 0, '康师傅茉莉蜜茶', '', 30.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅饮品', '饮料', 0);
INSERT INTO `pms_product` VALUES (54, 63, 56, 0, NULL, '康师傅茉莉蜜茶1L*12瓶/箱', 'http://39.98.239.6:8080/file/20190608/img_1e57ce659f134f90ae5d34b60ca739cb_webwxgetmsgimg (4).jpg', '', 0, 1, 0, 0, 0, 0, 0, 35.00, 45.00, 0, 0, 0, '康师傅茉莉蜜茶', '', 35.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅饮品', '饮料', 0);
INSERT INTO `pms_product` VALUES (55, 63, 56, 0, NULL, '康师傅茉莉蜜茶2L*6/箱', 'http://39.98.239.6:8080/file/20190608/img_443067be1330401d946c2f2f0af9a0a2_webwxgetmsgimg (5).jpg', '', 0, 1, 0, 0, 0, 0, 0, 30.00, 45.00, 0, 0, 0, '康师傅茉莉蜜茶', '', 30.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅饮品', '饮料', 0);
INSERT INTO `pms_product` VALUES (56, 63, 56, 0, NULL, '康师傅茉莉清茶500ml*15瓶/箱', 'http://39.98.239.6:8080/file/20190608/img_8b9f05290b454276a75d177af178801b_webwxgetmsgimg (6).jpg', '', 0, 1, 0, 0, 0, 0, 0, 30.00, 45.00, 0, 0, 0, '康师傅茉莉清茶', '', 30.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅饮品', '饮料', 0);
INSERT INTO `pms_product` VALUES (57, 63, 56, 0, NULL, '康师傅茉莉清茶1L*12/箱', 'http://39.98.239.6:8080/file/20190608/img_61b2284fa95b41fcb657cd97ce847c1d_webwxgetmsgimg (7).jpg', '', 0, 1, 0, 0, 0, 0, 0, 35.00, 45.00, 0, 0, 0, '康师傅茉莉清茶', '', 35.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅饮品', '饮料', 0);
INSERT INTO `pms_product` VALUES (58, 63, 56, 0, NULL, '康师傅冰糖雪梨500*15瓶/箱', 'http://39.98.239.6:8080/file/20190608/img_887a1344dc7c47ee89856d652736ba3c_webwxgetmsgimg (8).jpg', '', 0, 1, 0, 0, 0, 0, 0, 30.00, 45.00, 0, 0, 0, '康师傅冰糖雪梨', '', 30.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅饮品', '饮料', 0);
INSERT INTO `pms_product` VALUES (59, 63, 56, 0, NULL, '康师傅冰糖雪梨1L*8/箱', 'http://39.98.239.6:8080/file/20190608/img_c151f1d0d19a4344a2a4f6b08138dda5_webwxgetmsgimg (9).jpg', '', 0, 1, 0, 0, 0, 0, 0, 27.00, 45.00, 0, 0, 0, '康师傅冰糖雪梨', '', 27.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅饮品', '饮料', 0);
INSERT INTO `pms_product` VALUES (60, 63, 56, 0, NULL, '康师傅冰糖雪梨2L*6/箱', 'http://39.98.239.6:8080/file/20190608/img_a0e2eb13fe3442f39b7857248812019b_webwxgetmsgimg (10).jpg', '', 0, 1, 0, 0, 0, 0, 0, 37.00, 45.00, 0, 0, 0, '康师傅冰糖雪梨', '', 37.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅饮品', '饮料', 0);
INSERT INTO `pms_product` VALUES (61, 63, 56, 0, NULL, '康师傅酸梅汤500ml*15瓶/箱', 'http://39.98.239.6:8080/file/20190608/img_cd180a266ecd458686fecb035e3c5f5e_webwxgetmsgimg (11).jpg', '', 0, 1, 0, 0, 0, 0, 0, 33.00, 45.00, 0, 0, 0, '康师傅酸梅汤', '', 33.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅饮品', '饮料', 0);
INSERT INTO `pms_product` VALUES (62, 63, 56, 0, NULL, '康师傅酸梅汤1L*8瓶/箱', 'http://39.98.239.6:8080/file/20190608/img_1eb8471711d44f97bacdb64ff337b27b_webwxgetmsgimg (12).jpg', '', 0, 1, 0, 0, 0, 0, 0, 28.00, 45.00, 0, 0, 0, '康师傅酸梅汤', '', 28.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅饮品', '饮料', 0);
INSERT INTO `pms_product` VALUES (63, 63, 56, 0, NULL, '康师傅酸梅汤2L*6瓶/箱', 'http://39.98.239.6:8080/file/20190608/img_d871e64a12aa4e0dae9596abee306fc1_webwxgetmsgimg (13).jpg', '', 0, 1, 0, 0, 0, 0, 0, 43.00, 45.00, 0, 0, 0, '康师傅酸梅汤', '', 43.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅饮品', '饮料', 0);
INSERT INTO `pms_product` VALUES (64, 63, 56, 0, NULL, '康师傅水蜜桃2L*6瓶/箱', 'http://39.98.239.6:8080/file/20190608/img_e4ffd0f6c56e4a7d82873c9c65f1e1b4_webwxgetmsgimg (14).jpg', '', 0, 1, 0, 0, 0, 0, 0, 37.00, 45.00, 0, 0, 0, '康师傅水蜜桃', '', 37.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅饮品', '饮料', 0);
INSERT INTO `pms_product` VALUES (65, 63, 56, 0, NULL, '康师傅水蜜桃1L*8瓶/箱', 'http://39.98.239.6:8080/file/20190608/img_08352198d5a74a63bbede0044c99df86_webwxgetmsgimg (15).jpg', '', 0, 1, 0, 0, 0, 0, 0, 27.00, 45.00, 0, 0, 0, '康师傅水蜜桃', '', 27.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅饮品', '饮料', 0);
INSERT INTO `pms_product` VALUES (66, 63, 56, 0, NULL, '康师傅水蜜桃500ml*15瓶/箱', 'http://39.98.239.6:8080/file/20190608/img_82a78a8f66964be1b777ab5b4dc8b214_webwxgetmsgimg (16).jpg', '', 0, 1, 0, 0, 0, 0, 0, 0.00, 45.00, 0, 0, 0, '康师傅水蜜桃', '', 30.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅饮品', '饮料', 0);
INSERT INTO `pms_product` VALUES (67, 63, 56, 0, NULL, '康师傅水晶葡萄500ml*15瓶/箱', 'http://39.98.239.6:8080/file/20190608/img_c9a5fe0959794b2eb099d7176f2762a2_webwxgetmsgimg (17).jpg', '', 0, 1, 0, 0, 0, 0, 0, 30.00, 45.00, 0, 0, 0, '康师傅水晶葡萄', '', 30.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅饮品', '饮料', 0);
INSERT INTO `pms_product` VALUES (68, 63, 56, 0, NULL, '康师傅水晶葡萄1L*8瓶/箱', 'http://39.98.239.6:8080/file/20190608/img_6da8bbaa3ea24358a5ff44067ec41375_webwxgetmsgimg (18).jpg', '', 0, 1, 0, 0, 0, 0, 0, 27.00, 45.00, 0, 0, 0, '康师傅水晶葡萄', '', 27.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅饮品', '饮料', 0);
INSERT INTO `pms_product` VALUES (69, 63, 56, 0, NULL, '康师傅水晶葡萄2L*6瓶/箱', 'http://39.98.239.6:8080/file/20190608/img_46be119d30b149f79e02284c114da7fd_webwxgetmsgimg (19).jpg', '', 0, 0, 0, 0, 0, 0, 0, 37.00, 45.00, 0, 0, 0, '康师傅水晶葡萄', '', 37.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅饮品', '饮料', 0);
INSERT INTO `pms_product` VALUES (70, 63, 56, 0, NULL, '康师傅鲜果橙500ml*15瓶/箱', 'http://39.98.239.6:8080/file/20190608/img_64ca259bb8324fabb4a8544ae056d42c_webwxgetmsgimg (20).jpg', '', 0, 0, 0, 0, 0, 0, 0, 30.00, 45.00, 0, 0, 0, '康师傅鲜果橙', '', 30.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅饮品', '饮料', 0);
INSERT INTO `pms_product` VALUES (71, 63, 56, 0, NULL, '康师傅鲜果橙1L*8瓶/箱', 'http://39.98.239.6:8080/file/20190608/img_c6a5804f4ae243e58b1c7bf355826cd8_webwxgetmsgimg (21).jpg', '', 0, 1, 0, 0, 0, 0, 0, 27.00, 45.00, 0, 0, 0, '康师傅鲜果橙', '', 27.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅饮品', '饮料', 0);
INSERT INTO `pms_product` VALUES (72, 63, 56, 0, NULL, '康师傅鲜果橙2L*6瓶/箱', 'http://39.98.239.6:8080/file/20190608/img_373c5b205ea14d709c4195d4ff467950_webwxgetmsgimg (22).jpg', '', 0, 1, 0, 0, 0, 0, 0, 37.00, 45.00, 0, 0, 0, '康师傅鲜果橙', '', 37.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅饮品', '饮料', 0);
INSERT INTO `pms_product` VALUES (73, 64, 61, 0, NULL, '海底捞 麻辣嫩牛自热火锅435g/盒', 'http://39.98.239.6:8080/file/20190609/img_a0b145e6b39e4520a19a615644d12169_webwxgetmsgimg (24).jpg', '', 0, 1, 0, 0, 0, 0, 0, 26.00, 45.00, 0, 0, 0, '海底捞', '', 26.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '海底捞', '', 0);
INSERT INTO `pms_product` VALUES (74, 64, 61, 0, NULL, '海底捞 番茄牛腩自热火锅365g/盒', 'http://39.98.239.6:8080/file/20190609/img_e29f8c18ed834dd0b93952aa5d8ed9a9_webwxgetmsgimg (25).jpg', '', 0, 1, 0, 0, 0, 0, 0, 26.00, 45.00, 0, 0, 0, '海底捞', '', 26.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '海底捞', '', 0);
INSERT INTO `pms_product` VALUES (75, 64, 61, 0, NULL, '海底捞 番茄小酥肉自热火锅435g/盒', 'http://39.98.239.6:8080/file/20190609/img_3166146cb7ec4514969859713c7ad26b_webwxgetmsgimg (26).jpg', '', 0, 1, 0, 0, 0, 0, 0, 26.00, 45.00, 0, 0, 0, '海底捞', '', 26.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '海底捞', '', 0);
INSERT INTO `pms_product` VALUES (76, 64, 61, 0, NULL, '海底捞 香辣素食自热火锅200g/盒', 'http://39.98.239.6:8080/file/20190609/img_d397d156591b43d2aca88508b5fc61aa_webwxgetmsgimg (27).jpg', '', 0, 1, 0, 0, 0, 0, 0, 19.00, 45.00, 0, 0, 0, '海底捞', '', 19.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '海底捞', '', 0);
INSERT INTO `pms_product` VALUES (77, 64, 61, 0, NULL, '海底捞 酸辣什锦蔬菜自热火锅200g/盒', 'http://39.98.239.6:8080/file/20190609/img_360289c4aa6841aabdccf91c0a609b17_webwxgetmsgimg (28).jpg', '', 0, 1, 0, 0, 0, 0, 0, 19.00, 45.00, 0, 0, 0, '海底捞', '', 19.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '海底捞', '', 0);
INSERT INTO `pms_product` VALUES (78, 65, 62, 0, NULL, '康师傅 香辣牛肉面108g*24袋/箱', 'http://39.98.239.6:8080/file/20190609/img_de9c53d32d404fc9b43399fb325ea154_webwxgetmsgimg (29).jpg', '', 0, 1, 0, 0, 0, 0, 0, 46.00, 45.00, 0, 0, 0, '康师傅', '', 46.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅食品', '', 0);
INSERT INTO `pms_product` VALUES (79, 65, 62, 0, NULL, '康师傅 鲜虾鱼板面103g*24袋/箱', 'http://39.98.239.6:8080/file/20190609/img_dd1ccc24ddf3469aa9cc200db8f41e7d_webwxgetmsgimg (30).jpg', '', 0, 1, 0, 0, 0, 0, 0, 46.00, 45.00, 0, 0, 0, '康师傅 ', '', 46.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅食品', '', 0);
INSERT INTO `pms_product` VALUES (80, 65, 62, 0, NULL, '康师傅 西红柿打卤面110g*24袋/箱', 'http://39.98.239.6:8080/file/20190609/img_fb8f5a39f8ce48a89130f399e7e5fe35_webwxgetmsgimg (31).jpg', '', 0, 1, 0, 0, 0, 0, 0, 46.00, 45.00, 0, 0, 0, '康师傅', '', 46.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅食品', '', 0);
INSERT INTO `pms_product` VALUES (81, 65, 62, 0, NULL, '康师傅 小鸡炖蘑菇面101g*24袋/箱', 'http://39.98.239.6:8080/file/20190609/img_942d02439c8242bc83a0baa968cf9311_webwxgetmsgimg (32).jpg', '', 0, 1, 0, 0, 0, 0, 0, 46.00, 45.00, 0, 0, 0, '康师傅', '', 46.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅食品', '', 0);
INSERT INTO `pms_product` VALUES (82, 65, 62, 0, NULL, '康师傅 酸辣牛肉面116g*24袋/箱', 'http://39.98.239.6:8080/file/20190609/img_0c6b09cf28304503a09df97e9c3d899d_webwxgetmsgimg (33).jpg', '', 0, 1, 0, 0, 0, 0, 0, 46.00, 45.00, 0, 0, 0, '康师傅 ', '', 46.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅食品', '', 0);
INSERT INTO `pms_product` VALUES (83, 65, 62, 0, NULL, '康师傅 老坛酸菜牛肉面122g*24袋/箱', 'http://39.98.239.6:8080/file/20190609/img_21eae9b656164fcebdb565fcb8d1b4bd_webwxgetmsgimg (34).jpg', '', 0, 1, 0, 0, 0, 0, 0, 46.00, 45.00, 0, 0, 0, '康师傅 ', '', 46.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅食品', '', 0);
INSERT INTO `pms_product` VALUES (84, 65, 62, 0, NULL, '康师傅 红烧牛肉面（桶）109g*12桶/箱', 'http://39.98.239.6:8080/file/20190609/img_ed14333192904babaedbff5ffad693be_webwxgetmsgimg (35).jpg', '', 0, 1, 0, 0, 0, 0, 0, 37.00, 45.00, 0, 0, 0, '康师傅 ', '', 37.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅食品', '', 0);
INSERT INTO `pms_product` VALUES (85, 65, 62, 0, NULL, '康师傅 老坛酸菜牛肉面（桶）122g*12桶/箱', 'http://39.98.239.6:8080/file/20190609/img_038c3fbb42224685b685998150bd9fc8_webwxgetmsgimg (36).jpg', '', 0, 1, 0, 0, 0, 0, 0, 37.00, 45.00, 0, 0, 0, '康师傅', '', 37.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅食品', '', 0);
INSERT INTO `pms_product` VALUES (86, 65, 62, 0, NULL, '康师傅 香辣牛肉面（桶）108g*12桶/箱', 'http://39.98.239.6:8080/file/20190609/img_5cbe190c17134887ae750757d14453b0_webwxgetmsgimg (37).jpg', '', 0, 1, 0, 0, 0, 0, 0, 37.00, 45.00, 0, 0, 0, '康师傅 ', '', 37.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅食品', '', 0);
INSERT INTO `pms_product` VALUES (87, 65, 62, 0, NULL, '康师傅 鲜虾鱼板面（桶）101g*12桶/箱', 'http://39.98.239.6:8080/file/20190609/img_c0b8445d974a46af904c64f2782da770_webwxgetmsgimg (38).jpg', '', 0, 1, 0, 0, 0, 0, 0, 37.00, 45.00, 0, 0, 0, '康师傅 ', '', 37.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅食品', '', 0);
INSERT INTO `pms_product` VALUES (88, 65, 62, 0, NULL, '康师傅 小鸡炖蘑菇（桶）101g*12桶/箱', 'http://39.98.239.6:8080/file/20190609/img_e3d28589886b47bd80924f2acced77ec_webwxgetmsgimg (39).jpg', '', 0, 1, 0, 0, 0, 0, 0, 37.00, 45.00, 0, 0, 0, '康师傅 ', '', 37.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅食品', '', 0);
INSERT INTO `pms_product` VALUES (89, 65, 62, 0, NULL, '康师傅 酸辣牛肉面（桶）122g*12桶/箱', 'http://39.98.239.6:8080/file/20190609/img_a7b4b61fbc8149d38ff5ffa36dcafaa0_webwxgetmsgimg (40).jpg', '', 0, 1, 0, 0, 0, 0, 0, 37.00, 45.00, 0, 0, 0, '康师傅 ', '', 37.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅食品', '', 0);
INSERT INTO `pms_product` VALUES (90, 65, 62, 0, NULL, '康师傅 西红柿打卤面（桶）111g*12桶/箱', 'http://39.98.239.6:8080/file/20190609/img_c1b411c3c79a43549b0313221c195d4c_webwxgetmsgimg (41).jpg', '', 0, 1, 0, 0, 0, 0, 0, 37.00, 45.00, 0, 0, 0, '康师傅', '', 37.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅食品', '', 0);
INSERT INTO `pms_product` VALUES (91, 65, 62, 0, NULL, '康师傅 红烧牛肉面五合一108g*5袋*6包/箱', 'http://39.98.239.6:8080/file/20190609/img_d03758cbf71d4e5880a30ea83ef617cb_webwxgetmsgimg (42).jpg', '', 0, 1, 0, 0, 0, 0, 0, 60.00, 45.00, 0, 0, 0, '康师傅', '', 60.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅食品', '', 0);
INSERT INTO `pms_product` VALUES (92, 65, 62, 0, NULL, '康师傅 香辣牛肉面五合一108g*5袋*6包/箱', 'http://39.98.239.6:8080/file/20190609/img_2f00c2745a6e423291fcf7123fd81b39_webwxgetmsgimg (43).jpg', '', 0, 1, 0, 0, 0, 0, 0, 60.00, 45.00, 0, 0, 0, '康师傅', '', 60.00, 111, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '康师傅食品', '', 0);
INSERT INTO `pms_product` VALUES (93, NULL, NULL, NULL, NULL, '测试套餐', 'http://39.98.239.6:8080/file/20190616/img_d03a7ffef30c4ad69dabd3f130aaa04f_男孩 ǽֽ 梦想 月亮 云 船 飞行 4K壁纸_彼岸图网.jpg', NULL, 0, 1, NULL, 1, 1, 1, 0, 12.50, 45.00, NULL, NULL, NULL, NULL, '测试曹参你要啥说明', 9.90, 99999, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'http://39.98.239.6:8080/file/20190616/img_1527b6de566741d6a7b2c7fad6799582_静谧的林间小路阳光4k风景壁纸3840x2160_彼岸图网.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `pms_product` VALUES (94, 70, 56, 0, NULL, '茶π蜜桃乌龙茶 500ml*15瓶/箱', 'http://39.98.239.6:8080/file/20190616/img_0c32ff17500d4684bece1496c8e35abc_webwxgetmsgimg (45).jpg', '', 0, 1, 0, 0, 0, 0, 0, 50.00, 45.00, 0, 0, 0, '茶π', '', 50.00, 0, 0, '', 0.00, 0, '', '', '', '', '', '', '', '', NULL, NULL, 0, 0, '农夫山泉', '饮料', 0);
COMMIT;

-- ----------------------------
-- Table structure for pms_product_catego1ry
-- ----------------------------
DROP TABLE IF EXISTS `pms_product_catego1ry`;
CREATE TABLE `pms_product_catego1ry` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL COMMENT '上机分类的编号：0表示一级分类',
  `name` varchar(64) DEFAULT NULL,
  `level` int(1) DEFAULT NULL COMMENT '分类级别：0->1级；1->2级',
  `product_count` int(11) DEFAULT NULL,
  `product_unit` varchar(64) DEFAULT NULL,
  `nav_status` int(1) DEFAULT NULL COMMENT '是否显示在导航栏：0->不显示；1->显示',
  `show_status` int(1) DEFAULT NULL COMMENT '显示状态：0->不显示；1->显示',
  `sort` int(11) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL COMMENT '图标',
  `keywords` varchar(255) DEFAULT NULL,
  `description` text COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 COMMENT='产品分类';

-- ----------------------------
-- Records of pms_product_catego1ry
-- ----------------------------
BEGIN;
INSERT INTO `pms_product_catego1ry` VALUES (55, 0, '饮料', 0, 0, '瓶', 1, 1, 1, 'http://39.98.239.6:8080/file/20190531/img_fba6677869af4cfea0dcc0208a935391_小男孩.png', '饮料,汽水', '');
INSERT INTO `pms_product_catego1ry` VALUES (56, 55, '饮料', 1, 0, '箱', 0, 0, 0, '', '', '');
INSERT INTO `pms_product_catego1ry` VALUES (57, 0, '零食', 0, 0, '包', 1, 1, 2, '', '', '');
INSERT INTO `pms_product_catego1ry` VALUES (59, 57, '膨化食品', 1, 0, '袋', 0, 0, 0, '', '', '');
INSERT INTO `pms_product_catego1ry` VALUES (60, 0, '方便食品', 0, 0, '箱', 1, 1, 0, '', '', '');
INSERT INTO `pms_product_catego1ry` VALUES (61, 60, '自热火锅', 1, 0, '碗', 0, 1, 0, '', '', '');
INSERT INTO `pms_product_catego1ry` VALUES (62, 60, '方便面', 1, 0, '箱', 0, 1, 0, '', '', '');
INSERT INTO `pms_product_catego1ry` VALUES (63, 55, '矿泉水', 1, 0, '箱', 0, 0, 0, '', '', '');
INSERT INTO `pms_product_catego1ry` VALUES (64, 57, '糖果', 1, 0, '', 0, 0, 0, '', '', '');
INSERT INTO `pms_product_catego1ry` VALUES (65, 0, '酒类', 0, 0, '箱', 1, 1, 0, '', '', '');
INSERT INTO `pms_product_catego1ry` VALUES (66, 65, '烈酒', 1, 0, '箱', 0, 1, 0, '', '', '');
INSERT INTO `pms_product_catego1ry` VALUES (67, 65, '啤酒', 1, 0, '箱', 0, 1, 0, '', '', '');
INSERT INTO `pms_product_catego1ry` VALUES (68, 65, '预调酒', 1, 0, '箱', 0, 1, 0, '', '', '');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;

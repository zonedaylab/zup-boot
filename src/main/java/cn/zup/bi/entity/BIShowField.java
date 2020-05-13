package cn.zup.bi.entity;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class BIShowField {
	private String dim_Table;  //维表数据表
	private Integer drill_Type;  //钻取类型
	private String drill_Info;   //钻取信息

	private String id_Field;    //主键
	private String text_Field;   //字段
	private String attribute_Name;  //属性字段
	private String attribute_Value_Field;  //属性文字
	private String attribute_Caption_Field;  //属性备注



	private String topic_Table;  //主题数据表
	private Integer field_Id;     //字段id

	//这么多？ 必将去之  liuxf
	private Integer field_Type;  //字段类型
	private String field_Name;   //字段名称
	private String field_Title;  //字段标题
	private String field_Caption; //字段别名
	private String topic_Caption;  //主题别名


	private String aggregate_Type;  //聚合类型
	private String field_Unit; //单位
	
	private Integer field_Location; //字段行维、列维、指标
	private Integer dim_Order;      //第几列


	//针对dtrill_type=4 不同的主题 by liuxf
	/*
	 drill_name= 维度名称:主题表索引index； 表示要钻取的维度；主题表索引index=1表示第一个主题表；index=2表示第二个主题表
	 drill_value= 该维度对应的值；
	 后台接收后，构建查询语句 例如
	 drill_name="organ_code-1"
	 drill_value="山东省"

	 维度配置(BI_DIM):
	 drill_info :     topicTable1,filterField1  -  topicTable2,filterField2-topicTable3,filterField3........
	 NextTopicTableIndex=currentTopicTableIndex+1
	 通过dill_info ,NextTopicTableIndex获取  nextTopicTableName,nextFilterFied
	 过滤条件  filter_condition =drill_value=山东省
	 构建子主题查询：
	  select * from  [nextTopicTableName] where  [nextFilterFied]=[filter_condition]

	  例如：
	  select * from  [view_city] where  [parent_provice]=[filter_condition]
	*/

	private Integer currentShowReportIndex;
	private String nextTopicTableName;//下一个主题表的名字
	private String nextFilterName; //过滤字段
}

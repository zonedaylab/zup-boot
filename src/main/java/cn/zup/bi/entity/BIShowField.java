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
	private String field_Title;  //字段标题
	private Integer field_Type;  //字段类型
	private String field_Name;   //字段名称
	private String topic_Table;  //主题数据表
	private String topic_Name;   //主题名称
	private Integer field_Id;  //字段id
	
	private String field_Caption; //字段别名
	private String aggregate_Type;  //聚合类型
	private String topic_Caption;   //主题别名
	private String field_Unit; //单位
	
	private Integer field_Location; //字段行维、列维、指标
	private Integer dim_Order;      //第几列
}

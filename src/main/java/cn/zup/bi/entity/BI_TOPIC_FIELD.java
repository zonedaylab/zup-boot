package cn.zup.bi.entity;

import lombok.Data;

/**
 * 主题字段实体
 * 
 * */
@Data
public class BI_TOPIC_FIELD {
	private Integer field_Id;
	private String field_Name;
	private String field_Title;
	private String field_Caption;
	
	private Integer data_Type;
	private Integer field_Length;
	private Integer field_Decimal;
	private Integer field_Null; 
	private Integer field_Identity; 
	private String field_Unit;
	
	private Integer topic_Id;
	private Integer dim_Id;
	
	private Integer field_Type; 
	private String aggregate_Type;
	
	private String data_Type_Str;
	private String field_Type_Str;
	private String field_Null_Str;
	private String field_Identity_Str;
	private String dim_Name;
}

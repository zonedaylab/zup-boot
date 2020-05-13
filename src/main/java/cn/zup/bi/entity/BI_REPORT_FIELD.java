package cn.zup.bi.entity;

import lombok.Data;

import java.io.Serializable;

@Data
public class BI_REPORT_FIELD implements Serializable {
	private Integer report_Field_Id;
	private Integer report_Id; //报表ID

	private Integer field_Location;//字段位置
	private Integer dim_Order; //维度顺序
	private Integer display; //字段是否显示

	private String field_Name;//字段名称

	//新加
	private String field_Caption;//字段别名
	private String field_Title;//字段标题
	private Integer data_Type;//数据类型（数据库类型）
	private Integer field_Type;//字段类型（业务类型）
	private String aggregate_Type;//聚合类型
	private String unit;//单位
	private Integer dim_Id;//维表ID


	private String data_Type_Str;
	private String field_Type_Str;

}

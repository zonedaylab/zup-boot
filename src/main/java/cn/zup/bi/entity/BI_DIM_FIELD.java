package cn.zup.bi.entity;

import lombok.Data;

import java.io.Serializable;

@Data
public class BI_DIM_FIELD implements Serializable {
	private String dim_Field_Name; //字段名称
	private String field_Desc;  //字段描述
	private String field_Length; //字段长度
	private String field_Decimal; //小数位数
	private String field_Type; //字段类型
}

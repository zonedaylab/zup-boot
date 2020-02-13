package cn.zup.bi.entity;

import lombok.Data;

import java.io.Serializable;

@Data
public class BI_DIM_ATTRIBUTE implements Serializable {
	private Integer attribute_Id;
	private Integer dim_Id;
	private String attribute_Name;
	private String attribute_Value_Field;
	private String attribute_Caption_Field;
}
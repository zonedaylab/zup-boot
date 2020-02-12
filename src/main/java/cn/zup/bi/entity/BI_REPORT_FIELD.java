package cn.zup.bi.entity;

import lombok.Data;

import java.io.Serializable;

@Data
public class BI_REPORT_FIELD implements Serializable {
	private Integer report_Field_Id;
	private Integer report_Id;
	private Integer field_Id;
	private Integer field_Location;
	private Integer dim_Order;
	private Integer display; //字段是否显示
	private String field_Name;
}

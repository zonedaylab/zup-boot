package cn.zup.bi.entity;

import lombok.Data;

@Data
public class BI_REPORT_FIELD_VIEW {
	private Integer report_Field_Id;
	private Integer report_Id;
	private String report_Field_Name;
	private Integer field_Type;
	private Integer field_Row;
	private Integer field_Col;
	private Integer title_Field_Id;
	private Integer extend_Type;
	private Integer drill_Type;
	private String report_Name;
	private Integer menu_Id;
	private String report_Title;
	private String report_Field_Caption;
}

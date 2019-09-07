package cn.zup.bi.entity;

public class TOPIC_FIELD_PARAM {
	private String report_Field_Name;
	private Integer title_Field_Id;
	private String aggregate_Type;
	private String field_Caption;
	private String report_Name;
	private String report_Title;
	private String report_Field_Title;  //聚合字段别名
	public String getReport_Field_Name() {
		return report_Field_Name;
	}
	public void setReport_Field_Name(String report_Field_Name) {
		this.report_Field_Name = report_Field_Name;
	}
	public Integer getTitle_Field_Id() {
		return title_Field_Id;
	}
	public void setTitle_Field_Id(Integer title_Field_Id) {
		this.title_Field_Id = title_Field_Id;
	}
	public String getAggregate_Type() {
		return aggregate_Type;
	}
	public void setAggregate_Type(String aggregate_Type) {
		this.aggregate_Type = aggregate_Type;
	}
	public String getField_Caption() {
		return field_Caption;
	}
	public void setField_Caption(String field_Caption) {
		this.field_Caption = field_Caption;
	}
	public String getReport_Name() {
		return report_Name;
	}
	public void setReport_Name(String report_Name) {
		this.report_Name = report_Name;
	}
	public String getReport_Title() {
		return report_Title;
	}
	public void setReport_Title(String report_Title) {
		this.report_Title = report_Title;
	}
	public String getReport_Field_Title() {
		return report_Field_Title;
	}
	public void setReport_Field_Title(String report_Field_Title) {
		this.report_Field_Title = report_Field_Title;
	}
	
}

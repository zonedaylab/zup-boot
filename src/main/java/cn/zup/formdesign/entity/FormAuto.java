package cn.zup.formdesign.entity;

public class FormAuto {
	private Integer id;
	private Integer fieldNum;
	private String originalHtml;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getFieldNum() {
		return fieldNum;
	}
	public void setFieldNum(Integer fieldNum) {
		this.fieldNum = fieldNum;
	}
	public String getOriginalHtml() { 
		return originalHtml;
	}
	public void setOriginalHtml(String originalHtml) {
		this.originalHtml = originalHtml;
	}
	
}

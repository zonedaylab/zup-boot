package cn.zup.bi.entity;

public class BI_DIM_FIELD {
	private String dim_Field_Name; //字段名称
	private String field_Desc;  //字段描述
	private String field_Length; //字段长度
	private String field_Decimal; //小数位数
	private String field_Type; //字段类型
	
	public String getDim_Field_Name() {
		return dim_Field_Name;
	}
	public void setDim_Field_Name(String dimFieldName) {
		dim_Field_Name = dimFieldName;
	}
	public String getField_Desc() {
		return field_Desc;
	}
	public void setField_Desc(String fieldDesc) {
		field_Desc = fieldDesc;
	}
	public String getField_Length() {
		return field_Length;
	}
	public void setField_Length(String fieldLength) {
		field_Length = fieldLength;
	}
	public String getField_Decimal() {
		return field_Decimal;
	}
	public void setField_Decimal(String fieldDecimal) {
		field_Decimal = fieldDecimal;
	}
	public String getField_Type() {
		return field_Type;
	}
	public void setField_Type(String fieldType) {
		field_Type = fieldType;
	}
	
	
}

package cn.zup.bi.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

/**
 * 主题字段实体
 * 
 * */
@Entity
@Table(name = "BI_TOPIC_FIELD")
public class BI_TOPIC_FIELD implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
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
	
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getField_Id() {
		return field_Id;
	}
	public void setField_Id(Integer field_Id) {
		this.field_Id = field_Id;
	}
	public String getField_Name() {
		return field_Name;
	}
	public void setField_Name(String field_Name) {
		this.field_Name = field_Name;
	}
	public String getField_Title() {
		return field_Title;
	}
	public void setField_Title(String field_Title) {
		this.field_Title = field_Title;
	}
	public String getField_Caption() {
		return field_Caption;
	}
	public void setField_Caption(String field_Caption) {
		this.field_Caption = field_Caption;
	}
	public Integer getData_Type() {
		return data_Type;
	}
	public void setData_Type(Integer data_Type) {
		this.data_Type = data_Type;
	}
	public Integer getField_Length() {
		return field_Length;
	}
	public void setField_Length(Integer field_Length) {
		this.field_Length = field_Length;
	}
	public Integer getField_Decimal() {
		return field_Decimal;
	}
	public void setField_Decimal(Integer field_Decimal) {
		this.field_Decimal = field_Decimal;
	}
	public Integer getField_Null() {
		return field_Null;
	}
	public void setField_Null(Integer field_Null) {
		this.field_Null = field_Null;
	}
	public Integer getField_Identity() {
		return field_Identity;
	}
	public void setField_Identity(Integer field_Identity) {
		this.field_Identity = field_Identity;
	}
	public Integer getTopic_Id() {
		return topic_Id;
	}
	public void setTopic_Id(Integer topic_Id) {
		this.topic_Id = topic_Id;
	}
	public Integer getDim_Id() {
		return dim_Id;
	}
	public void setDim_Id(Integer dim_Id) {
		this.dim_Id = dim_Id;
	}
	public Integer getField_Type() {
		return field_Type;
	}
	public void setField_Type(Integer field_Type) {
		this.field_Type = field_Type;
	}
	public String getAggregate_Type() {
		return aggregate_Type;
	}
	public void setAggregate_Type(String aggregate_Type) {
		this.aggregate_Type = aggregate_Type;
	}
	public String getField_Unit() {
		return field_Unit;
	}
	public void setField_Unit(String field_Unit) {
		this.field_Unit = field_Unit;
	}
	@Transient
	public String getData_Type_Str() {
		return data_Type_Str;
	}
	public void setData_Type_Str(String data_Type_Str) {
		this.data_Type_Str = data_Type_Str;
	}
	@Transient
	public String getField_Type_Str() {
		return field_Type_Str;
	}
	public void setField_Type_Str(String field_Type_Str) {
		this.field_Type_Str = field_Type_Str;
	}
	@Transient
	public String getField_Null_Str() {
		return field_Null_Str;
	}
	public void setField_Null_Str(String field_Null_Str) {
		this.field_Null_Str = field_Null_Str;
	}
	@Transient
	public String getField_Identity_Str() {
		return field_Identity_Str;
	}
	public void setField_Identity_Str(String field_Identity_Str) {
		this.field_Identity_Str = field_Identity_Str;
	}
	@Transient
	public String getDim_Name() {
		return dim_Name;
	}
	public void setDim_Name(String dim_Name) {
		this.dim_Name = dim_Name;
	}
}

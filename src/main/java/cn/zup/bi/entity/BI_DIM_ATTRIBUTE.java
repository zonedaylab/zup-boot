package cn.zup.bi.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

@Entity
@Table(name = "BI_DIM_ATTRIBUTE")
public class BI_DIM_ATTRIBUTE implements Serializable {
	private Integer attribute_Id;
	private Integer dim_Id;
	private String attribute_Name;
	private String attribute_Value_Field;
	private String attribute_Caption_Field;
	
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getAttribute_Id() {
		return attribute_Id;
	}
	public void setAttribute_Id(Integer attribute_Id) {
		this.attribute_Id = attribute_Id;
	}
	public Integer getDim_Id() {
		return dim_Id;
	}
	public void setDim_Id(Integer dim_Id) {
		this.dim_Id = dim_Id;
	}
	public String getAttribute_Name() {
		return attribute_Name;
	}
	public void setAttribute_Name(String attribute_Name) {
		this.attribute_Name = attribute_Name;
	}
	public String getAttribute_Value_Field() {
		return attribute_Value_Field;
	}
	public void setAttribute_Value_Field(String attribute_Value_Field) {
		this.attribute_Value_Field = attribute_Value_Field;
	}
	public String getAttribute_Caption_Field() {
		return attribute_Caption_Field;
	}
	public void setAttribute_Caption_Field(String attribute_Caption_Field) {
		this.attribute_Caption_Field = attribute_Caption_Field;
	}
	
}
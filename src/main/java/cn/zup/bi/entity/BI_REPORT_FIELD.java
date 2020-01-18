package cn.zup.bi.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table (name = "BI_REPORT_FIELD")
public class BI_REPORT_FIELD implements Serializable {
	private Integer report_Field_Id;
	private Integer report_Id;
	private Integer field_Id;
	private Integer field_Location;
	private Integer dim_Order;
	private Integer display; //字段是否显示
	private String field_Name;
	
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getReport_Field_Id() {
		return report_Field_Id;
	}
	public void setReport_Field_Id(Integer reportFieldId) {
		report_Field_Id = reportFieldId;
	}
	public Integer getReport_Id() {
		return report_Id;
	}
	public void setReport_Id(Integer reportId) {
		report_Id = reportId;
	}
	public Integer getField_Id() {
		return field_Id;
	}
	public void setField_Id(Integer field_Id) {
		this.field_Id = field_Id;
	}
	public Integer getField_Location() {
		return field_Location;
	}
	public void setField_Location(Integer field_Location) {
		this.field_Location = field_Location;
	}
	public Integer getDim_Order() {
		return dim_Order;
	}
	public void setDim_Order(Integer dim_Order) {
		this.dim_Order = dim_Order;
	}

	public Integer getDisplay() {
		return display;
	}

	public void setDisplay(Integer display) {
		this.display = display;
	}

	@Transient
	public String getField_Name() {
		return field_Name;
	}
	public void setField_Name(String field_Name) {
		this.field_Name = field_Name;
	}
	
}

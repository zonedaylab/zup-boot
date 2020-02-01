package cn.zup.bi.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

@Entity
@Table(name = "bi_dim")
public class BI_DIM  implements Serializable{
	private Integer dim_Id;   // 维表ID
	private String dim_Name;  // 维名称
	private String biz_Table_Name;  // 数据库表名
	private String text_Field;  // 文本字段
	private String id_Field;  // ID字段
	private String drill_Type;  // 钻取类型
	private String drill_Info;// 钻取信息
	private Integer ds_Id;// 数据源id

	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getDim_Id() {
		return dim_Id;
	}
	public void setDim_Id(Integer dimId) {
		dim_Id = dimId;
	}
	public String getDim_Name() {
		return dim_Name;
	}
	public void setDim_Name(String dimName) {
		dim_Name = dimName;
	}
	public String getBiz_Table_Name() {
		return biz_Table_Name;
	}
	public void setBiz_Table_Name(String bizTableName) {
		biz_Table_Name = bizTableName;
	}
	public String getText_Field() {
		return text_Field;
	}
	public void setText_Field(String textField) {
		text_Field = textField;
	}
	public String getId_Field() {
		return id_Field;
	}
	public void setId_Field(String idField) {
		id_Field = idField;
	}
	public String getDrill_Type() {
		return drill_Type;
	}
	public void setDrill_Type(String drillType) {
		drill_Type = drillType;
	}
	public String getDrill_Info() {
		return drill_Info;
	}
	public void setDrill_Info(String drillInfo) {
		drill_Info = drillInfo;
	}

	public Integer getDs_Id() {
		return ds_Id;
	}

	public void setDs_Id(Integer ds_Id) {
		this.ds_Id = ds_Id;
	}
}

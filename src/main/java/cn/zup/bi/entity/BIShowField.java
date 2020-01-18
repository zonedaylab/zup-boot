package cn.zup.bi.entity;

public class BIShowField {
	private String dim_Table;  //维表数据表
	private Integer drill_Type;  //钻取类型
	private String drill_Info;   //钻取信息
	private String id_Field;    //主键
	private String text_Field;   //字段
	private String attribute_Name;  //属性字段
	private String attribute_Value_Field;  //属性文字
	private String attribute_Caption_Field;  //属性备注
	private String field_Title;  //字段标题
	private Integer field_Type;  //字段类型
	private String Field_Name;   //字段名称
	private String topic_Table;  //主题数据表
	private String topic_Name;   //主题名称
	private Integer field_Id;  //字段id
	
	private String field_Caption; //字段别名
	private String aggregate_Type;  //聚合类型
	private String topic_Caption;   //主题别名
	private String field_Unit; //单位
	
	private Integer field_Location; //字段行维、列维、指标
	private Integer dim_Order;      //第几列
	
	public String getDim_Table() {
		return dim_Table;
	}
	public void setDim_Table(String dim_Table) {
		this.dim_Table = dim_Table;
	}
	public Integer getDrill_Type() {
		return drill_Type;
	}
	public void setDrill_Type(Integer drill_Type) {
		this.drill_Type = drill_Type;
	}
	public String getDrill_Info() {
		return drill_Info;
	}
	public void setDrill_Info(String drill_Info) {
		this.drill_Info = drill_Info;
	}
	public String getId_Field() {
		return id_Field;
	}
	public void setId_Field(String id_Field) {
		this.id_Field = id_Field;
	}
	public String getText_Field() {
		return text_Field;
	}
	public void setText_Field(String text_Field) {
		this.text_Field = text_Field;
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
	public String getField_Title() {
		return field_Title;
	}
	public void setField_Title(String field_Title) {
		this.field_Title = field_Title;
	}
	public Integer getField_Type() {
		return field_Type;
	}
	public void setField_Type(Integer field_Type) {
		this.field_Type = field_Type;
	}
	public String getField_Name() {
		return Field_Name;
	}
	public void setField_Name(String field_Name) {
		Field_Name = field_Name;
	}
	public String getTopic_Table() {
		return topic_Table;
	}
	public void setTopic_Table(String topic_Table) {
		this.topic_Table = topic_Table;
	}
	public String getTopic_Name() {
		return topic_Name;
	}
	public void setTopic_Name(String topic_Name) {
		this.topic_Name = topic_Name;
	}
	public String getField_Caption() {
		return field_Caption;
	}
	public void setField_Caption(String field_Caption) {
		this.field_Caption = field_Caption;
	}
	public String getAggregate_Type() {
		return aggregate_Type;
	}
	public void setAggregate_Type(String aggregate_Type) {
		this.aggregate_Type = aggregate_Type;
	}
	public String getTopic_Caption() {
		return topic_Caption;
	}
	public void setTopic_Caption(String topic_Caption) {
		this.topic_Caption = topic_Caption;
	}
	public String getField_Unit() {
		return field_Unit;
	}
	public void setField_Unit(String field_Unit) {
		this.field_Unit = field_Unit;
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

	public Integer getField_Id() {
		return field_Id;
	}

	public void setField_Id(Integer field_Id) {
		this.field_Id = field_Id;
	}
}

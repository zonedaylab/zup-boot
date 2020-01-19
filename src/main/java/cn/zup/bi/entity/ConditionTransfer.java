package cn.zup.bi.entity;

import java.util.List;

/**
 * 条件数据传输类
 * @author Andot
 *
 */
public class ConditionTransfer {
	private String drill_Name;
	private Object drill_Value;
	private List<String> key;
	private List<Object> value;
	private Integer report_Id;
	private Integer index;  //是否指定指标
	private Integer type; //图标类型
	
	public String getDrill_Name() {
		return drill_Name;
	}
	public void setDrill_Name(String drill_Name) {
		this.drill_Name = drill_Name;
	}
	public Object getDrill_Value() {
		return drill_Value;
	}
	public void setDrill_Value(Object drill_Value) {
		this.drill_Value = drill_Value;
	}
	public List<String> getKey() {
		return key;
	}
	public void setKey(List<String> key) {
		this.key = key;
	}
	public List<Object> getValue() {
		return value;
	}
	public void setValue(List<Object> value) {
		this.value = value;
	}
	public Integer getReport_Id() {
		return report_Id;
	}
	public void setReport_Id(Integer report_Id) {
		this.report_Id = report_Id;
	}

	public Integer getIndex() {
		return index;
	}

	public void setIndex(Integer index) {
		this.index = index;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}
}

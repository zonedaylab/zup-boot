package cn.zup.bi.entity;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

/**
 * 条件数据传输类
 * @author Andot
 *
 */
@Setter
@Getter
public class ConditionTransfer {
	private String drill_Name;
	private Object drill_Value;
	private List<String> key;
	private List<Object> value;
	private Integer report_Id;
	private Integer index;  //是否指定指标
	private Integer type; //图标类型
}

package cn.zup.bi.entity;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class TOPIC_FIELD_PARAM {
	private String report_Field_Name;
	private Integer title_Field_Id;
	private String aggregate_Type;
	private String field_Caption;
	private String report_Name;
	private String report_Title;
	/**
	 * 聚合字段别名
	 */
	private String report_Field_Title;
}

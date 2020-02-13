package cn.zup.bi.entity;

import lombok.Data;

import java.util.Date;

@Data
public class BI_REPORT {
	private Integer report_Id;  //
	private Integer topic_Id;
	private String report_Name;
	private Integer page_Id;
	private String report_Title;
	private Date create_Date;
	
	private String topic_Name;
	private String page_Name;
}

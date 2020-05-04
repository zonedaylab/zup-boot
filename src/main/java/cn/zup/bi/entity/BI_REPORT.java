package cn.zup.bi.entity;

import lombok.Data;

import java.util.Date;

@Data
public class BI_REPORT {
	private Integer report_Id;  //报表id
	private Integer topic_Id;
	private String report_Name; //报表名称
	private Integer page_Id; //页面主键
	private String report_Title;//报表主题
	private Date create_Date;//创建时间
	
	private String topic_Name;
	private String page_Name;

	//新加的
	private String biz_Table_Name;//数据表名


}

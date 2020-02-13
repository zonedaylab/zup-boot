package cn.zup.bi.entity;

import lombok.Data;

@Data
public class BI_Screen {
	private Integer screen_Id;   //屏幕主键
	private Integer screen_Index; //屏幕索引
	private String screen_Name;   //屏幕名称
	private Integer page_Id;   //页面id
	private String page_Name;   //页面名称
}

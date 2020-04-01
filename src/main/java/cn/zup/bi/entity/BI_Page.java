package cn.zup.bi.entity;

import lombok.Data;

@Data
public class BI_Page {
	private Integer bi_Page_Id;   //页面主键
	private String page_Name;     //页面名称
	private Integer page_Type;  //页面类型
	private String page_Title;  //页面标题
	private String page_Url;      //页面url
	private Integer menu_Id;      //菜单id
	private String menu_Name;
	
	private String pageTypeStr;
	
}

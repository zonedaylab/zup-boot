package cn.zup.bi.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

@Entity
@Table(name="bi_page")
public class BI_Page {
	private Integer bi_Page_Id;   //页面主键
	private String page_Name;     //页面名称
	private Integer page_Type;  //页面类型
	private String page_Title;  //页面标题
	private String page_Url;      //页面url
	private Integer menu_Id;      //菜单id
	private String menu_Name;
	
	private String pageTypeStr;
	
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getBi_Page_Id() {
		return bi_Page_Id;
	}
	public void setBi_Page_Id(Integer bi_Page_Id) {
		this.bi_Page_Id = bi_Page_Id;
	}
	public String getPage_Name() {
		return page_Name;
	}
	public void setPage_Name(String page_Name) {
		this.page_Name = page_Name;
	}
	public Integer getPage_Type() {
		return page_Type;
	}
	public void setPage_Type(Integer page_Type) {
		this.page_Type = page_Type;
	}
	public String getPage_Title() {
		return page_Title;
	}
	public void setPage_Title(String page_Title) {
		this.page_Title = page_Title;
	}
	public String getPage_Url() {
		return page_Url;
	}
	public void setPage_Url(String page_Url) {
		this.page_Url = page_Url;
	}
	public Integer getMenu_Id() {
		return menu_Id;
	}
	public void setMenu_Id(Integer menu_Id) {
		this.menu_Id = menu_Id;
	}
	public String getMenu_Name() {
		return menu_Name;
	}
	public void setMenu_Name(String menu_Name) {
		this.menu_Name = menu_Name;
	}
	@Transient
	public String getPageTypeStr() {
		return pageTypeStr;
	}
	public void setPageTypeStr(String pageTypeStr) {
		this.pageTypeStr = pageTypeStr;
	}
	
}

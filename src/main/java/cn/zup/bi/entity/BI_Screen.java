package cn.zup.bi.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="bi_screen")
public class BI_Screen {
	private Integer screen_Id;   //屏幕主键
	private Integer screen_Index; //屏幕索引
	private String screen_Name;   //屏幕名称
	private Integer page_Id;   //页面id
	private String page_Name;   //页面名称

	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getScreen_Id() {
		return screen_Id;
	}

	public void setScreen_Id(Integer screen_Id) {
		this.screen_Id = screen_Id;
	}

	public Integer getScreen_Index() {
		return screen_Index;
	}

	public void setScreen_Index(Integer screen_Index) {
		this.screen_Index = screen_Index;
	}

	public String getScreen_Name() {
		return screen_Name;
	}

	public void setScreen_Name(String screen_Name) {
		this.screen_Name = screen_Name;
	}

	public Integer getPage_Id() {
		return page_Id;
	}

	public void setPage_Id(Integer page_Id) {
		this.page_Id = page_Id;
	}
	@Transient
	public String getPage_Name() {
		return page_Name;
	}

	public void setPage_Name(String page_Name) {
		this.page_Name = page_Name;
	}
}

package cn.zup.bi.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "BI_REPORT")
public class BI_REPORT {
	private Integer report_Id;  //
	private Integer topic_Id;
	private String report_Name;
	private Integer page_Id;
	private String report_Title;
	private Date create_Date;
	
	private String topic_Name;
	private String page_Name;
	
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getReport_Id() {
		return report_Id;
	}
	public void setReport_Id(Integer report_Id) {
		this.report_Id = report_Id;
	}
	public Integer getTopic_Id() {
		return topic_Id;
	}
	public void setTopic_Id(Integer topic_Id) {
		this.topic_Id = topic_Id;
	}
	public String getReport_Name() {
		return report_Name;
	}
	public void setReport_Name(String report_Name) {
		this.report_Name = report_Name;
	}
	public Integer getPage_Id() {
		return page_Id;
	}
	public void setPage_Id(Integer page_Id) {
		this.page_Id = page_Id;
	}
	public String getReport_Title() {
		return report_Title;
	}
	public void setReport_Title(String report_Title) {
		this.report_Title = report_Title;
	}
	public Date getCreate_Date() {
		return create_Date;
	}
	public void setCreate_Date(Date create_Date) {
		this.create_Date = create_Date;
	}
	@Transient
	public String getTopic_Name() {
		return topic_Name;
	}
	public void setTopic_Name(String topic_Name) {
		this.topic_Name = topic_Name;
	}
	@Transient
	public String getPage_Name() {
		return page_Name;
	}
	public void setPage_Name(String page_Name) {
		this.page_Name = page_Name;
	}
	
}

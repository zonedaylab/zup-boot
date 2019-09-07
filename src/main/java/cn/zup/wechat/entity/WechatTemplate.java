package cn.zup.wechat.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="wechat_template")
public class WechatTemplate {
	private Integer temp_Id;  //主键id
	private String temp_NAME;  //模板名称
	private String template_Id;  //微信模板id
	private String skip_Url;  //跳转链接
	private String request_Url;  //请求微信地址
	private String top_Color;  //模板头部样式颜色
	private Integer service_Id;  //公众号id
	//冗余字段
	private String service_Name;
	
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getTemp_Id() {
		return temp_Id;
	}
	public void setTemp_Id(Integer tempId) {
		temp_Id = tempId;
	}
	public String getTemp_NAME() {
		return temp_NAME;
	}
	public void setTemp_NAME(String tempNAME) {
		temp_NAME = tempNAME;
	}
	public String getTemplate_Id() {
		return template_Id;
	}
	public void setTemplate_Id(String templateId) {
		template_Id = templateId;
	}
	public String getSkip_Url() {
		return skip_Url;
	}
	public void setSkip_Url(String skipUrl) {
		skip_Url = skipUrl;
	}
	public String getRequest_Url() {
		return request_Url;
	}
	public void setRequest_Url(String requestUrl) {
		request_Url = requestUrl;
	}
	public String getTop_Color() {
		return top_Color;
	}
	public void setTop_Color(String topColor) {
		top_Color = topColor;
	}
	public Integer getService_Id() {
		return service_Id;
	}
	public void setService_Id(Integer serviceId) {
		service_Id = serviceId;
	}
	@Transient
	public String getService_Name() {
		return service_Name;
	}
	public void setService_Name(String serviceName) {
		service_Name = serviceName;
	}//公众号名称
}

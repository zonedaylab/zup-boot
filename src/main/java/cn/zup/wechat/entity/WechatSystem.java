package cn.zup.wechat.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

//需要微信绑定的系统
@Entity
@Table(name="WECHAT_SYSTEM")
public class WechatSystem implements Serializable {
	private Integer company_Id;
	private String company_Name;
    private Integer service_ID;//公众号id
	private Integer system_Id;//系统
	private String system_Url;//系统地址
	private Integer region_Id;//告警标识id
	private Integer region_Type;//告警标识类型
	private String img_Url;//图片地址
	
	//冗余字段
	private String service_Name;//公众号名称
	private String system_Name;//系统名称
	private Integer tempId;//
	
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getCompany_Id() {
		return company_Id;
	}
	public void setCompany_Id(Integer companyId) {
		company_Id = companyId;
	}
	public String getCompany_Name() {
		return company_Name;
	}
	public void setCompany_Name(String companyName) {
		company_Name = companyName;
	}
	public Integer getService_ID() {
		return service_ID;
	}
	public void setService_ID(Integer serviceID) {
		service_ID= serviceID;
	}
	public Integer getSystem_Id() {
		return system_Id;
	}
	public void setSystem_Id(Integer systemId) {
		system_Id = systemId;
	}
	public String getSystem_Url() {
		return system_Url;
	}
	public void setSystem_Url(String systemUrl) {
		system_Url = systemUrl;
	}
	public Integer getRegion_Id() {
		return region_Id;
	}
	public void setRegion_Id(Integer regionId) {
		region_Id = regionId;
	}
	public Integer getRegion_Type() {
		return region_Type;
	}
	public void setRegion_Type(Integer regionType) {
		region_Type = regionType;
	}
	public String getImg_Url() {
		return img_Url;
	}
	public void setImg_Url(String imgUrl) {
		img_Url = imgUrl;
	}
	@Transient
	public String getService_Name() {
		return service_Name;
	}
	public void setService_Name(String serviceName) {
		service_Name = serviceName;
	}
	@Transient
	public String getSystem_Name() {
		return system_Name;
	}
	public void setSystem_Name(String systemName) {
		system_Name = systemName;
	}
	@Transient
	public Integer getTempId() {
		return tempId;
	}
	public void setTempId(Integer tempId) {
		this.tempId = tempId;
	}
	
}
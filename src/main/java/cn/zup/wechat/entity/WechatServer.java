package cn.zup.wechat.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="wechat_server")
public class WechatServer {
	private Integer service_ID;   //微信公众号id
	private String service_Name;         //微信名称
	private String service_Account;       //微信公众号
	private String appid;        //微信appid
	private String appsecret;       //微信scraet
	private String token_Name;   //微信保存accesstoken是的名称
	private String Original_ID;    //微信原始id
	private Integer validFlag; //有效性
	
	private String validFlagStr;
	private Integer system_Id;  //如果系统id不为空，就需要根据系统加载微信公众号的Token
	
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getService_ID() {
		return service_ID;
	}
	public void setService_ID(Integer serviceID) {
		service_ID = serviceID;
	}
	public String getService_Name() {
		return service_Name;
	}
	public void setService_Name(String serviceName) {
		service_Name = serviceName;
	}
	public String getService_Account() {
		return service_Account;
	}
	public void setService_Account(String serviceAccount) {
		service_Account = serviceAccount;
	}
	public String getAppid() {
		return appid;
	}
	public void setAppid(String appid) {
		this.appid = appid;
	}
	public String getAppsecret() {
		return appsecret;
	}
	public void setAppsecret(String appsecret) {
		this.appsecret = appsecret;
	}
	public String getToken_Name() {
		return token_Name;
	}
	public void setToken_Name(String tokenName) {
		token_Name = tokenName;
	}
	public String getOriginal_ID() {
		return Original_ID;
	}
	public void setOriginal_ID(String originalID) {
		Original_ID = originalID;
	}
	public Integer getValidFlag() {
		return validFlag;
	}
	public void setValidFlag(Integer validFlag) {
		this.validFlag = validFlag;
	}     
	public Integer getSystem_Id() {
		return system_Id;
	}
	public void setSystem_Id(Integer system_Id) {
		this.system_Id = system_Id;
	}
	@Transient
	public String getValidFlagStr() {
		return validFlagStr;
	}
	public void setValidFlagStr(String validFlagStr) {
		this.validFlagStr = validFlagStr;
	}
}

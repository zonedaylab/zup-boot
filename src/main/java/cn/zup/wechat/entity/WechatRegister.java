package cn.zup.wechat.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

//微信账号
@Entity
@Table(name="WECHAT_REGISTER")
public class WechatRegister implements Serializable {
	
	private Integer registerId;
	private Integer systemId;
	private String registerName;
	private String registerPwd;
	private String wxAccount;
	private Date bindDate;
	
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	@Column(name = "register_id")
	public Integer getRegisterId() {
		return registerId;
	}
	public void setRegisterId(Integer registerId) {
		this.registerId = registerId;
	}
	@Column(name = "company_id")
	public Integer getSystemId() {
		return systemId;
	}
	public void setSystemId(Integer systemId) {
		this.systemId = systemId;
	}
	@Column(name = "register_name")
	public String getRegisterName() {
		return registerName;
	}
	public void setRegisterName(String registerName) {
		this.registerName = registerName;
	}
	@Column(name = "register_pwd")
	public String getRegisterPwd() {
		return registerPwd;
	}
	public void setRegisterPwd(String registerPwd) {
		this.registerPwd = registerPwd;
	}
	@Column(name = "wx_account")
	public String getWxAccount() {
		return wxAccount;
	}
	public void setWxAccount(String wxAccount) {
		this.wxAccount = wxAccount;
	}
	@Column(name = "bind_date")
	public Date getBindDate() {
		return bindDate;
	}
	public void setBindDate(Date bindDate) {
		this.bindDate = bindDate;
	}
	
	
}
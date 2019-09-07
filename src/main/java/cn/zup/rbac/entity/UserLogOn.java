package cn.zup.rbac.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
@Entity
@Table(name = "userlogon")
public class UserLogOn implements Serializable {
	public UserLogOn() {
	}
	private Integer accountid;// 账户ID
	private Integer systemid;
	private String openid;// 当点登录标示
	private Date previousvisit;// 上一次访问时间
	private Date lastvisit;// 最后访问时间
	private Integer logoncount;// 登录次数
	private Integer multiuserlogin = 0;// 允许同时有多用户登录
	private Integer useronline;// 在线状态
	private Integer checkipaddress = 0;// IP访问限制
	private String ipaddress;// 登录IP地址
	private String macaddress;// 登录MAC地址
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getAccountid() {
		return accountid;
	}
	public void setAccountid(Integer accountid) {
		this.accountid = accountid;
	}
	public String getOpenid() {
		return openid;
	}
	public void setOpenid(String openid) {
		this.openid = openid;
	}
	public Date getPreviousvisit() {
		return previousvisit;
	}
	public void setPreviousvisit(Date previousvisit) {
		this.previousvisit = previousvisit;
	}
	public Date getLastvisit() {
		return lastvisit;
	}
	public void setLastvisit(Date lastvisit) {
		this.lastvisit = lastvisit;
	}
	public Integer getLogoncount() {
		return logoncount;
	}
	public void setLogoncount(Integer logoncount) {
		this.logoncount = logoncount;
	}
	public Integer getMultiuserlogin() {
		return multiuserlogin;
	}
	public void setMultiuserlogin(Integer multiuserlogin) {
		this.multiuserlogin = multiuserlogin;
	}
	public Integer getUseronline() {
		return useronline;
	}
	public void setUseronline(Integer useronline) {
		this.useronline = useronline;
	}
	public Integer getCheckipaddress() {
		return checkipaddress;
	}
	public void setCheckipaddress(Integer checkipaddress) {
		this.checkipaddress = checkipaddress;
	}
	public String getIpaddress() {
		return ipaddress;
	}
	public void setIpaddress(String ipaddress) {
		this.ipaddress = ipaddress;
	}
	public String getMacaddress() {
		return macaddress;
	}
	public void setMacaddress(String macaddress) {
		this.macaddress = macaddress;
	}
	public Integer getSystemid() {
		return systemid;
	}
	public void setSystemid(Integer systemid) {
		this.systemid = systemid;
	}
	


}
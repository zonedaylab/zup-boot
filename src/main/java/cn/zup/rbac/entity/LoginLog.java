package cn.zup.rbac.entity;
import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;
@Entity
@Table(name = "loginlog")
/**
 * 登录日志
 */
public class LoginLog implements Serializable {
	public LoginLog() {
	}
	
	private Integer loginlogid;// 登录日志ID
	private Integer accountid;//账户ID
	
	private String accountname;//系统名称
	
	private Integer userid;//用户ID
	private String username;//登录用户名
	private Integer systemid;//登录系统ID
	private String systemname;//登录系统名称 数据库中没有对应字段，只做显示使用
	private Date logdatetime;//登录时间
	private Integer retrycount;//操作次数
	private Integer logtype;//登录类型
	
	private String logtypestring;
	private Integer logTypeConfig;
	private String logip;//登录IP
	private String startLogDateTime;
	private String endLogDateTime;
	private String userIds;  //过滤用户组
	
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getLoginlogid() {
		return loginlogid;
	}
	public void setLoginlogid(Integer loginlogid) {
		this.loginlogid = loginlogid;
	}
	public Integer getAccountid() {
		return accountid;
	}
	public void setAccountid(Integer accountid) {
		this.accountid = accountid;
	}
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid = userid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public Integer getSystemid() {
		return systemid;
	}
	public void setSystemid(Integer systemid) {
		this.systemid = systemid;
	}
	public String getSystemname() {
		return systemname;
	}
	public void setSystemname(String systemname) {
		this.systemname = systemname;
	}
	public Date getLogdatetime() {
		return logdatetime;
	}
	public void setLogdatetime(Date logdatetime) {
		this.logdatetime = logdatetime;
	}
	public Integer getRetrycount() {
		return retrycount;
	}
	public void setRetrycount(Integer retrycount) {
		this.retrycount = retrycount;
	}
	public Integer getLogtype() {
		return logtype;
	}
	public void setLogtype(Integer logtype) {
		this.logtype = logtype;
	}
	public String getLogip() {
		return logip;
	}
	public void setLogip(String logip) {
		this.logip = logip;
	}
	@Transient
	public String getAccountname() {
		return accountname;
	}
	public void setAccountname(String accountname) {
		this.accountname = accountname;
	}
	@Transient
	public String getLogtypestring() {
		return logtypestring;
	}
	public void setLogtypestring(String logtypestring) {
		this.logtypestring = logtypestring;
	}
	@Transient
	public Integer getLogTypeConfig() {
		return logTypeConfig;
	}
	public void setLogTypeConfig(Integer logTypeConfig) {
		this.logTypeConfig = logTypeConfig;
	}
	@Transient
	public String getStartLogDateTime() {
		return startLogDateTime;
	}
	public void setStartLogDateTime(String startLogDateTime) {
		this.startLogDateTime = startLogDateTime;
	}
	@Transient
	public String getEndLogDateTime() {
		return endLogDateTime;
	}
	public void setEndLogDateTime(String endLogDateTime) {
		this.endLogDateTime = endLogDateTime;
	}
	@Transient
	public String getUserIds() {
		return userIds;
	}
	public void setUserIds(String userIds) {
		this.userIds = userIds;
	}

}
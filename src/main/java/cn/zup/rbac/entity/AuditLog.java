package cn.zup.rbac.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

/**
 * 存放系统审计日志
 * @author andot
 * @date 2018-1-18 11:10:03
 * */
@Entity
@Table(name = "auditlog")
public class AuditLog implements Serializable {
	public AuditLog(){}
	
	private Integer auditId;  //审计id
	private Integer userId;   //用户id
	private Integer systemId; //系统id
	private Integer auditLevel; //ip地址对应的真实地址
	private String auditEvent;    //审计事件
	private String auditPage;    //审计页面
	private Date auditDate;    //审计时间
	private String userIp;    //ip地址
	private String ipAddr;    //ip地址对应的真实地址
	private String memo;      //操作备注
	
	//冗余字段
	private String systemName; //系统名称
	private String userName;   //用户名称
	private String auditLevelName;//等级名称
	private String auditDateStart;//开始时间
	private String auditDateEnd;  //结束时间
	private String userIds;  //用户组
	
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getAuditId() {
		return auditId;
	}
	public void setAuditId(Integer auditId) {
		this.auditId = auditId;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public Integer getSystemId() {
		return systemId;
	}
	public void setSystemId(Integer systemId) {
		this.systemId = systemId;
	}
	public Integer getAuditLevel() {
		return auditLevel;
	}
	public void setAuditLevel(Integer auditLevel) {
		this.auditLevel = auditLevel;
	}
	public String getAuditEvent() {
		return auditEvent;
	}
	public void setAuditEvent(String auditEvent) {
		this.auditEvent = auditEvent;
	}
	public String getAuditPage() {
		return auditPage;
	}
	public void setAuditPage(String auditPage) {
		this.auditPage = auditPage;
	}
	public Date getAuditDate() {
		return auditDate;
	}
	public void setAuditDate(Date auditDate) {
		this.auditDate = auditDate;
	}
	public String getUserIp() {
		return userIp;
	}
	public void setUserIp(String userIp) {
		this.userIp = userIp;
	}
	public String getIpAddr() {
		return ipAddr;
	}
	public void setIpAddr(String ipAddr) {
		this.ipAddr = ipAddr;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	
	@Transient
	public String getSystemName() {
		return systemName;
	}
	public void setSystemName(String systemName) {
		this.systemName = systemName;
	}
	@Transient
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	@Transient
	public String getAuditLevelName() {
		return auditLevelName;
	}
	public void setAuditLevelName(String auditLevelName) {
		this.auditLevelName = auditLevelName;
	}
	@Transient
	public String getAuditDateStart() {
		return auditDateStart;
	}
	public void setAuditDateStart(String auditDateStart) {
		this.auditDateStart = auditDateStart;
	}
	@Transient
	public String getAuditDateEnd() {
		return auditDateEnd;
	}
	public void setAuditDateEnd(String auditDateEnd) {
		this.auditDateEnd = auditDateEnd;
	}
	@Transient
	public String getUserIds() {
		return userIds;
	}
	public void setUserIds(String userIds) {
		this.userIds = userIds;
	}
	
}

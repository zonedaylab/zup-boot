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
@Table(name="operatelog")
// 操作日志
public class OperateLog implements Serializable {

	public OperateLog() {
	}

	private Integer operateId;
	private Integer systemId;
	private Integer userId;
	private String pageName;//页面名
	private String logInfo;
	private Date logDate;//日志创建时间
	private Integer logLevel;//告警等级
	private String logSql;
	private String userName;
	private String systemName;
	//冗余字段
	private Integer logLevelConfig;
	private String logLevelString;
	private String userIds;//过滤组织之间的操作日志使用
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getOperateId() {
		return operateId;
	}
	public void setOperateId(Integer operateId) {
		this.operateId = operateId;
	}
	public Integer getSystemId() {
		return systemId;
	}
	public void setSystemId(Integer systemId) {
		this.systemId = systemId;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getPageName() {
		return pageName;
	}
	public void setPageName(String pageName) {
		this.pageName = pageName;
	}
	public String getLogInfo() {
		return logInfo;
	}
	public void setLogInfo(String logInfo) {
		this.logInfo = logInfo;
	}
	public Date getLogDate() {
		return logDate;
	}
	public void setLogDate(Date logDate) {
		this.logDate = logDate;
	}
	public Integer getLogLevel() {
		return logLevel;
	}
	public void setLogLevel(Integer logLevel) {
		this.logLevel = logLevel;
	}
	public String getLogSql() {
		return logSql;
	}
	public void setLogSql(String logSql) {
		this.logSql = logSql;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getSystemName() {
		return systemName;
	}
	public void setSystemName(String systemName) {
		this.systemName = systemName;
	}
	@Transient
	public Integer getLogLevelConfig() {
		return logLevelConfig;
	}
	public void setLogLevelConfig(Integer logLevelConfig) {
		this.logLevelConfig = logLevelConfig;
	}
	@Transient
	public String getLogLevelString() {
		return logLevelString;
	}
	public void setLogLevelString(String logLevelString) {
		this.logLevelString = logLevelString;
	}
	@Transient
	public String getUserIds() {
		return userIds;
	}
	public void setUserIds(String userIds) {
		this.userIds = userIds;
	}
	
}

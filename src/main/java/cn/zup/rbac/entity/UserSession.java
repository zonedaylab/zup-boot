package cn.zup.rbac.entity;

import java.io.Serializable;

/**
 * 用户会话信息
 */
public class UserSession implements Serializable {
	private Integer accountId;//账户ID
	private Integer userId;//用户ID
	private String realName;//用户真实姓名
	private Integer organId;//用户组织ID	
	private String organName;//组织名称
	private Integer postId;//用户岗位ID
	private String postName;//岗位名称
	//默认系统id为1
	private Integer systemId = 1;//系统id
	public Integer getAccountId() {
		return accountId;
	}
	public void setAccountId(Integer accountId) {
		this.accountId = accountId;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public Integer getOrganId() {
		return organId;
	}
	public void setOrganId(Integer organId) {
		this.organId = organId;
	}
	public String getOrganName() {
		return organName;
	}
	public void setOrganName(String organName) {
		this.organName = organName;
	}
	public Integer getPostId() {
		return postId;
	}
	public void setPostId(Integer postId) {
		this.postId = postId;
	}
	public String getPostName() {
		return postName;
	}
	public void setPostName(String postName) {
		this.postName = postName;
	}
	public Integer getSystemId() {
		return systemId;
	}
	public void setSystemId(Integer systemId) {
		this.systemId = systemId;
	}  
}

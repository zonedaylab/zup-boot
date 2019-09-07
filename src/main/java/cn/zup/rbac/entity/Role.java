package cn.zup.rbac.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;
//角色
@Entity
@Table(name = "role")
public class Role implements Serializable {
	public Role() {
	}
	
	private Integer roleId;// 角色ID
	private Integer parentRoleId;// 父角色
	private String roleName;// 角色名称
	private Integer roleType;// 角色类型
	private Integer roleLimit;
	private String roleTypeString;
	private Integer roleTypeConfig;
	private String accountName;
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getRoleId() {
		return roleId;
	}
	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}
	public Integer getParentRoleId() {
		return parentRoleId;
	}
	public void setParentRoleId(Integer parentRoleId) {
		this.parentRoleId = parentRoleId;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	public Integer getRoleType() {
		return roleType;
	}
	public void setRoleType(Integer roleType) {
		this.roleType = roleType;
	}
	public Integer getRoleLimit() {
		return roleLimit;
	}
	public void setRoleLimit(Integer roleLimit) {
		this.roleLimit = roleLimit;
	}// 限额
	@Transient
	public String getRoleTypeString() {
		return roleTypeString;
	}
	public void setRoleTypeString(String roleTypeString) {
		this.roleTypeString = roleTypeString;
	}
	@Transient
	public Integer getRoleTypeConfig() {
		return roleTypeConfig;
	}
	public void setRoleTypeConfig(Integer roleTypeConfig) {
		this.roleTypeConfig = roleTypeConfig;
	}
	@Transient
	public String getAccountName() {
		return accountName;
	}
	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}
	

}
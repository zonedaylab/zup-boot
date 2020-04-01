package cn.zup.rbac.entity;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
@Entity
@Table(name = "roleaction")
public class RoleAction implements Serializable {
	public RoleAction() {
	}
	
	private Integer actionId;// 操作项ID
	private Integer roleId;// 角色ID
	private Integer actionPermission; //新增角色权限
	@Id 
	public Integer getActionId() {
		return actionId;
	}
	public void setActionId(Integer actionId) {
		this.actionId = actionId;
	}
	@Id 
	public Integer getRoleId() {
		return roleId;
	}
	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}
	public Integer getActionPermission() {
		return actionPermission;
	}
	public void setActionPermission(Integer actionPermission) {
		this.actionPermission = actionPermission;
	}// 权限
	
	

}
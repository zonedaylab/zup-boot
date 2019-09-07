package cn.zup.rbac.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
@Entity
@Table(name = "rolemenu")
public class RoleMenu implements Serializable {
	public RoleMenu() {
	}
		
	private Integer menuId;// 菜单ID
	private Integer roleId;// 角色ID
	private Integer menuPermission;

	@Id
	
	public Integer getMenuId() {
		return menuId;
	}
	public void setMenuId(Integer menuId) {
		this.menuId = menuId;
	}
	@Id
	public Integer getRoleId() {
		return roleId;
	}
	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}
	public Integer getMenuPermission() {
		return menuPermission;
	}
	public void setMenuPermission(Integer menuPermission) {
		this.menuPermission = menuPermission;
	}// 权限
	
	
	
	

}
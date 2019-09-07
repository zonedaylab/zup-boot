package cn.zup.rbac.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;
@Entity
@Table(name="roledata")
public class RoleData implements Serializable {
	public RoleData() {
	}
	
	private Integer dataId;//数据id
	private Integer menuId;//菜单id
	private Integer roleId;//角色id
	private Integer dataPermissionType;//数据权限类型
	private String dataPermission;
	private Integer dataPermissionConfig;
	private String dataPermissionString;
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getDataId() {
		return dataId;
	}
	public void setDataId(Integer dataId) {
		this.dataId = dataId;
	}
	public Integer getMenuId() {
		return menuId;
	}
	public void setMenuId(Integer menuId) {
		this.menuId = menuId;
	}
	public Integer getRoleId() {
		return roleId;
	}
	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}
	public Integer getDataPermissionType() {
		return dataPermissionType;
	}
	public void setDataPermissionType(Integer dataPermissionType) {
		this.dataPermissionType = dataPermissionType;
	}
	public String getDataPermission() {
		return dataPermission;
	}
	public void setDataPermission(String dataPermission) {
		this.dataPermission = dataPermission;
	}//数据权限名称
	@Transient
	public Integer getDataPermissionConfig() {
		return dataPermissionConfig;
	}
	public void setDataPermissionConfig(Integer dataPermissionConfig) {
		this.dataPermissionConfig = dataPermissionConfig;
	}
	
	@Transient
	public String getDataPermissionString() {
		return dataPermissionString;
	}
	public void setDataPermissionString(String dataPermissionString) {
		this.dataPermissionString = dataPermissionString;
	}
	

}
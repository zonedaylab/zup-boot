package cn.zup.rbac.entity;


import javax.persistence.Transient;

public class ActionPermission {

	private Integer actionId;//操作项ID

	private Integer menuId;//菜单ID。
	
	private String actionName;//操作项名称 

	private Integer actionType;// 操作项类型 。

	private Integer actionPermission;//操作项权限
	
	private String actionCode;//标识码 
	
	private String menuName;// 菜单名称 
	
	private String caption;  //操作项说明
	
	private String actionPermissionName;  //操作项说明

	public Integer getActionId() {
		return actionId;
	}

	public void setActionId(Integer actionId) {
		this.actionId = actionId;
	}

	public Integer getMenuId() {
		return menuId;
	}

	public void setMenuId(Integer menuId) {
		this.menuId = menuId;
	}

	public String getActionName() {
		return actionName;
	}

	public void setActionName(String actionName) {
		this.actionName = actionName;
	}

	public Integer getActionType() {
		return actionType;
	}

	public void setActionType(Integer actionType) {
		this.actionType = actionType;
	}

	 

	public Integer getActionPermission() {
		return actionPermission;
	}

	public void setActionPermission(Integer actionPermission) {
		this.actionPermission = actionPermission;
	}

	public String getActionCode() {
		return actionCode;
	}

	public void setActionCode(String actionCode) {
		this.actionCode = actionCode;
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getCaption() {
		return caption;
	}

	public void setCaption(String caption) {
		this.caption = caption;
	}

	@Transient
	public String getActionPermissionName() {
		return actionPermissionName;
	}

	public void setActionPermissionName(String actionPermissionName) {
		this.actionPermissionName = actionPermissionName;
	} 
	
	
	
}

package cn.zup.rbac.entity;

public class MenuPermission {
	
	private Integer MenuID;//菜单ID
	private Integer ParentMenuID;//父菜单ID
	private String MenuName;//菜单名称
	private Integer OrderCode;//菜单序号 
	private String IconStyle;//图标样式 。
	private Integer Permission;//操作项权限
	public Integer getMenuID() {
		return MenuID;
	}
	public void setMenuID(Integer menuID) {
		MenuID = menuID;
	}
	public Integer getParentMenuID() {
		return ParentMenuID;
	}
	public void setParentMenuID(Integer parentMenuID) {
		ParentMenuID = parentMenuID;
	}
	public String getMenuName() {
		return MenuName;
	}
	public void setMenuName(String menuName) {
		MenuName = menuName;
	}
	public Integer getOrderCode() {
		return OrderCode;
	}
	public void setOrderCode(Integer orderCode) {
		OrderCode = orderCode;
	}
	public String getIconStyle() {
		return IconStyle;
	}
	public void setIconStyle(String iconStyle) {
		IconStyle = iconStyle;
	}
	public Integer getPermission() {
		return Permission;
	}
	public void setPermission(Integer permission) {
		Permission = permission;
	}
	
}

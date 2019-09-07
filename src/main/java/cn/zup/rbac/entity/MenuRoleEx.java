package cn.zup.rbac.entity;

import java.io.Serializable;
 
//菜单
public class MenuRoleEx implements Serializable {
	public MenuRoleEx() {
	}
	
	private Integer menuId;// 菜单ID
	private Integer systemId;// 系统ID
	private Integer parentMenuId;// 父菜单ID
	private String menuName;// 菜单名称
	private Integer orderCode;// 菜单序号
	private String iconStyle;// 图标样式
	private String nameSpace;// 命名空间
	private String urlAddress;// URL地址
	private String formAddress;// Form地址 
	private Integer menurole;// 菜单角色
	private Integer mobileFlag;//电脑端或手机端标识，排序是使用lixin
	public Integer getMenuId() {
		return menuId;
	}
	public void setMenuId(Integer menuId) {
		this.menuId = menuId;
	}
	public Integer getSystemId() {
		return systemId;
	}
	public void setSystemId(Integer systemId) {
		this.systemId = systemId;
	}
	public Integer getParentMenuId() {
		return parentMenuId;
	}
	public void setParentMenuId(Integer parentMenuId) {
		this.parentMenuId = parentMenuId;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public Integer getOrderCode() {
		return orderCode;
	}
	public void setOrderCode(Integer orderCode) {
		this.orderCode = orderCode;
	}
	public String getIconStyle() {
		return iconStyle;
	}
	public void setIconStyle(String iconStyle) {
		this.iconStyle = iconStyle;
	}
	public String getNameSpace() {
		return nameSpace;
	}
	public void setNameSpace(String nameSpace) {
		this.nameSpace = nameSpace;
	}
	public String getUrlAddress() {
		return urlAddress;
	}
	public void setUrlAddress(String urlAddress) {
		this.urlAddress = urlAddress;
	}
	public String getFormAddress() {
		return formAddress;
	}
	public void setFormAddress(String formAddress) {
		this.formAddress = formAddress;
	}
	public Integer getMenurole() {
		return menurole;
	}
	public void setMenurole(Integer menurole) {
		this.menurole = menurole;
	}
	public Integer getMobileFlag() {
		return mobileFlag;
	}
	public void setMobileFlag(Integer mobileFlag) {
		this.mobileFlag = mobileFlag;
	} 

}
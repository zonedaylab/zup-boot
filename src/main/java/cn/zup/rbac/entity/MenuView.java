package cn.zup.rbac.entity;

public class MenuView {
	
	private Integer menuId;
	private Integer systemId;
	private Integer parentMenuId;
	private String menuName;
	private Integer orderCode;
	private String iconStyle;
	private String nameSpace;
	private String urlAddress;
	private String formAddress;
	private Integer flowId;
	private Integer mobileFlag;
	private Integer mobileFlagConfig;
	private String subMenu;
	
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
	public Integer getFlowId() {
		return flowId;
	}
	public void setFlowId(Integer flowId) {
		this.flowId = flowId;
	}
	public Integer getMobileFlag() {
		return mobileFlag;
	}
	public void setMobileFlag(Integer mobileFlag) {
		this.mobileFlag = mobileFlag;
	}
	public Integer getMobileFlagConfig() {
		return mobileFlagConfig;
	}
	public void setMobileFlagConfig(Integer mobileFlagConfig) {
		this.mobileFlagConfig = mobileFlagConfig;
	}
	public String getSubMenu() {
		return subMenu;
	}
	public void setSubMenu(String subMenu) {
		this.subMenu = subMenu;
	}
}
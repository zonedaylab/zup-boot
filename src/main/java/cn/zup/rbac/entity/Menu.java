package cn.zup.rbac.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;
@Entity
@Table(name = "menu")
//菜单
public class Menu implements Serializable {
	public Menu() {
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
	private Integer flowId;// 流程ID
	private Integer mobileFlag;
	private Integer mobileFlagConfig;
	
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
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
	@Transient
	public Integer getMobileFlagConfig() {
		return mobileFlagConfig;
	}
	public void setMobileFlagConfig(Integer mobileFlagConfig) {
		this.mobileFlagConfig = mobileFlagConfig;
	}
	
}
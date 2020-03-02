package cn.zup.bi.entity;

import lombok.Data;

import java.io.Serializable;

@Data
public class BiMenu implements Serializable {
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
}
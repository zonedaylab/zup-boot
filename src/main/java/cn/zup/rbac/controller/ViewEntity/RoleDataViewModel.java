package cn.zup.rbac.controller.ViewEntity;

import cn.zup.rbac.entity.RoleData;

public class RoleDataViewModel extends RoleData
{
	//菜单名
	private String privateMenuName;
	public final String getMenuName()
	{
		return privateMenuName;
	}
	public final void setMenuName(String value)
	{
		privateMenuName = value;
	}
	//数据权限类型（名称）
	private String privateDataPermissionTypeName;
	public final String getDataPermissionTypeName()
	{
		return privateDataPermissionTypeName;
	}
	public final void setDataPermissionTypeName(String value)
	{
		privateDataPermissionTypeName = value;
	}
	//数据权限内容详情
	private String privateDataPermissionName;
	public final String getDataPermissionName()
	{
		return privateDataPermissionName;
	}
	public final void setDataPermissionName(String value)
	{
		privateDataPermissionName = value;
	}
}

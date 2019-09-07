package cn.zup.rbac.controller.ViewEntity;

import cn.zup.rbac.entity.UserInfo;

public class UserViewModel extends UserInfo
{
	private String privateOrganName;
	public final String getOrganName()
	{
		return privateOrganName;
	}
	public final void setOrganName(String value)
	{
		privateOrganName = value;
	}
	private String privatePostName;
	public final String getPostName()
	{
		return privatePostName;
	}
	public final void setPostName(String value)
	{
		privatePostName = value;
	}
	private String privateValidFlagName;
	public final String getValidFlagName()
	{
		return privateValidFlagName;
	}
	public final void setValidFlagName(String value)
	{
		privateValidFlagName = value;
	}
	private String privateSexName;
	public final String getSexName()
	{
		return privateSexName;
	}
	public final void setSexName(String value)
	{
		privateSexName = value;
	}

}

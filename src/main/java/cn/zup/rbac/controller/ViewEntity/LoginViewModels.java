package cn.zup.rbac.controller.ViewEntity;


public class LoginViewModels
{
	/** 
	 账户名称
	 
	*/
	private String privateAccountName;
	public final String getAccountName()
	{
		return privateAccountName;
	}
	public final void setAccountName(String value)
	{
		privateAccountName = value;
	}
	/** 
	 密码
	 
	*/
	private String privatePassword;
	public final String getPassword()
	{
		return privatePassword;
	}
	public final void setPassword(String value)
	{
		privatePassword = value;
	}

	/** 
	 是否记住
	 
	*/

	private boolean privateRememberMe;
	public final boolean getRememberMe()
	{
		return privateRememberMe;
	}
	public final void setRememberMe(boolean value)
	{
		privateRememberMe = value;
	}
	/** 
	 用户id
	 
	*/

	private int privateUserID;
	public final int getUserID()
	{
		return privateUserID;
	}
	public final void setUserID(int value)
	{
		privateUserID = value;
	}
	/** 
	 id
	 
	*/

	private int privateAccountID;
	public final int getAccountID()
	{
		return privateAccountID;
	}
	public final void setAccountID(int value)
	{
		privateAccountID = value;
	}

	/** 
	 有效性
	 
	*/

	private String privateValidFlagName;
	public final String getValidFlagName()
	{
		return privateValidFlagName;
	}
	public final void setValidFlagName(String value)
	{
		privateValidFlagName = value;
	}
	/** 
	 有效性
	 
	*/

	private byte privateValidFlag;
	public final byte getValidFlag()
	{
		return privateValidFlag;
	}
	public final void setValidFlag(byte value)
	{
		privateValidFlag = value;
	}
}

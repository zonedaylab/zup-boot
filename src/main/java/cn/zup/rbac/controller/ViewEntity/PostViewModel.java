package cn.zup.rbac.controller.ViewEntity;


public class PostViewModel
{

	private int privatePostID;
	public final int getPostID()
	{
		return privatePostID;
	}
	public final void setPostID(int value)
	{
		privatePostID = value;
	}
	/** 
	 岗位名称
	 
	*/

	private String privatePostName;
	public final String getPostName()
	{
		return privatePostName;
	}
	public final void setPostName(String value)
	{
		privatePostName = value;
	}

	/** 
	 部门ID
	 
	*/

	private int privateOrganID;
	public final int getOrganID()
	{
		return privateOrganID;
	}
	public final void setOrganID(int value)
	{
		privateOrganID = value;
	}

	/** 
	 部门
	 
	*/

	private String privateOrganName;
	public final String getOrganName()
	{
		return privateOrganName;
	}
	public final void setOrganName(String value)
	{
		privateOrganName = value;
	}

	/** 
	 岗位职责
	 
	*/

	private String privatePostDuty;
	public final String getPostDuty()
	{
		return privatePostDuty;
	}
	public final void setPostDuty(String value)
	{
		privatePostDuty = value;
	}

	/** 
	 标准人数
	 
	*/

	private int privateStandardNumber;
	public final int getStandardNumber()
	{
		return privateStandardNumber;
	}
	public final void setStandardNumber(int value)
	{
		privateStandardNumber = value;
	}

	/** 
	 有效性
	 
	*/

	private int privateValidFlag;
	public final int getValidFlag()
	{
		return privateValidFlag;
	}
	public final void setValidFlag(int value)
	{
		privateValidFlag = value;
	}
	//
}

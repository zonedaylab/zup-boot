package cn.zup.rbac.service.structure;

/** 
 操作者
 
*/

public final class Handler 
{
	private int userID;
	/** 
	 用户ID
	 
	*/
	public int getUserID()
	{
		return userID;
	}
	public void setUserID(int value)
	{
		userID = value;
	}

	private String userName;
	/** 
	 用户真实姓名
	 
	*/
	public String getUserName()
	{
		return userName;
	}
	public void setUserName(String value)
	{
		userName = value;
	}

	private int postID;
	/** 
	 部门ID
	 
	*/
	public int getPostID()
	{
		return postID;
	}
	public void setPostID(int value)
	{
		postID = value;
	}

	public Handler clone()
	{
		Handler varCopy = new Handler();

		varCopy.userID = this.userID;
		varCopy.userName = this.userName;
		varCopy.postID = this.postID;

		return varCopy;
	}
}

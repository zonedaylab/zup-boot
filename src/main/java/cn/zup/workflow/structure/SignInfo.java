package cn.zup.workflow.structure;
import java.io.Serializable;
import java.sql.Date;




/** 
 签字信息
 
*/

public final class SignInfo implements Serializable
{
	private int signUserID;

	/** 
	 签字人ID
	 
	*/
	public int getSignUserID()
	{
		return signUserID;
	}
	public void setSignUserID(int value)
	{
		signUserID = value;
	}

	private String signUserName;
	/** 
	 签字人名称
	 
	*/
	public String getSignUserName()
	{
		return signUserName;
	}
	public void setSignUserName(String value)
	{
		signUserName = value;
	}


	private String signOpinion;
	/** 
	 签字意见
	 
	*/
	public String getSignOpinion()
	{
		return signOpinion;
	}
	public void setSignOpinion(String value)
	{
		signOpinion = value;
	}

	private Date signDatetime = new java.sql.Date(System.currentTimeMillis());;
	/** 
	 签字时间
	 
	*/
	public Date getSignDatetime()
	{
		return signDatetime;
	}
	public void setSignDatetime(Date value)
	{
		signDatetime = value;
	}

	public SignInfo clone()
	{
		SignInfo varCopy = new SignInfo();

		varCopy.signUserID = this.signUserID;
		varCopy.signUserName = this.signUserName;
		varCopy.signOpinion = this.signOpinion;
		varCopy.signDatetime = this.signDatetime;

		return varCopy;
	}
}
//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#endregion

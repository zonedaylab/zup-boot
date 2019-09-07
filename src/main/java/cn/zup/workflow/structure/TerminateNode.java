package cn.zup.workflow.structure;

/** 
 强制结束节点信息
 
*/
public final class TerminateNode
{
	/** 
	 活动ID
	 
	*/
	private int privateActivityID;
	public int getActivityID()
	{
		return privateActivityID;
	}
	public void setActivityID(int value)
	{
		privateActivityID = value;
	}

	/** 
	 活动类型
	 
	*/
	private int privateActivityType;
	public int getActivityType()
	{
		return privateActivityType;
	}
	public void setActivityType(int value)
	{
		privateActivityType = value;
	}

	/** 
	 工作活动ID
	 
	*/
	private int privateWorkActivityID;
	public int getWorkActivityID()
	{
		return privateWorkActivityID;
	}
	public void setWorkActivityID(int value)
	{
		privateWorkActivityID = value;
	}
}

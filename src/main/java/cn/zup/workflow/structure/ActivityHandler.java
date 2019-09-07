package cn.zup.workflow.structure;
import java.io.Serializable;

/** 
 活动和对应的经办人
 
*/
public class ActivityHandler implements Serializable
{
	private int activityID;
	/** 
	 活动ID
	 
	*/
	public final int getActivityID()
	{
		return activityID;
	}
	public final void setActivityID(int value)
	{
		activityID = value;
	}

	private int activityCode;
	/** 
	 活动编号
	 
	*/
	public final int getActivityCode()
	{
		return activityCode;
	}
	public final void setActivityCode(int value)
	{
		activityCode = value;
	}

	private String activityName;

	/** 
	 活动名称
	 
	*/
	public final String getActivityName()
	{
		return activityName;
	}
	public final void setActivityName(String value)
	{
		activityName = value;
	}

	private java.util.List<cn.zup.workflow.model.WF_HANDLER> handerList;
	/** 
	 活动经办人
	 
	*/
	public final java.util.List<cn.zup.workflow.model.WF_HANDLER> getHanderList()
	{
		return handerList;
	}
	public final void setHanderList(java.util.List<cn.zup.workflow.model.WF_HANDLER> value)
	{
		handerList = value;
	}
}
//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#endregion

package cn.zup.workflow.config;

//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#endregion

//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#region 3-工作项状态
/** 
 工作项状态
 
*/
public enum WorkItemState
{
	/** 
	 正在办理
	 
	*/
	InProgress(1),

	/** 
	 正常结束
	 
	*/
	NormalEnd(2),

	/** 
	 强制结束
	 
	*/
	ForcedEnd(3),

	/** 
	 驳回
	 
	*/
	Reject(4),

	/** 
	 自动审批通过
	 
	*/
	AutoApprovalPassed(5),

	/** 
	暂停 
	 
	*/
	Pause(6);

	private int intValue;
	private static java.util.HashMap<Integer, WorkItemState> mappings;
	private synchronized static java.util.HashMap<Integer, WorkItemState> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, WorkItemState>();
		}
		return mappings;
	}

	private WorkItemState(int value)
	{
		intValue = value;
		WorkItemState.getMappings().put(value, this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static WorkItemState forValue(int value)
	{
		return getMappings().get(value);
	}
}

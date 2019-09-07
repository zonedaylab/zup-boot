package cn.zup.workflow.config;

//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#endregion

//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#region 2-工作活动状态
/** 
 工作活动状态
 
*/
public enum WorkActivityState
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
	暂停 
	 
	*/
	Pause(5);

	private int intValue;
	private static java.util.HashMap<Integer, WorkActivityState> mappings;
	private synchronized static java.util.HashMap<Integer, WorkActivityState> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, WorkActivityState>();
		}
		return mappings;
	}

	private WorkActivityState(int value)
	{
		intValue = value;
		WorkActivityState.getMappings().put(value, this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static WorkActivityState forValue(int value)
	{
		return getMappings().get(value);
	}
}

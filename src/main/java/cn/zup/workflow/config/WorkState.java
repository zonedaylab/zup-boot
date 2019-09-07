package cn.zup.workflow.config;

//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#region 1-工作状态
/** 
 工作状态
 
*/
public enum WorkState
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
	 暂停
	 
	*/
	Pause(4);

	private int intValue;
	private static java.util.HashMap<Integer, WorkState> mappings;
	private synchronized static java.util.HashMap<Integer, WorkState> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, WorkState>();
		}
		return mappings;
	}

	private WorkState(int value)
	{
		intValue = value;
		WorkState.getMappings().put(value, this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static WorkState forValue(int value)
	{
		return getMappings().get(value);
	}
}

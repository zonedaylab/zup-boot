package cn.zup.workflow.config;

/** 
 活动类型
 
*/
public enum ActivityType
{
	/** 
	 开始段
	 
	*/
	IntialStage(1),

	/** 
	 中间段	 
	*/
	InterMediateStage(2),

	/** 
	 结束段	 
	*/
	TerminateStage(3); 

	private int intValue;
	private static java.util.HashMap<Integer, ActivityType> mappings;
	private synchronized static java.util.HashMap<Integer, ActivityType> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, ActivityType>();
		}
		return mappings;
	}

	private ActivityType(int value)
	{
		intValue = value;
		ActivityType.getMappings().put(value, this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static ActivityType forValue(int value)
	{
		return getMappings().get(value);
	}
}

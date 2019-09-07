package cn.zup.workflow.config;

//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#endregion

//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#region 8-操作者及监控者类型
/** 
 操作者及监控者类型
 
*/
public enum HandlerAndMonitorType
{
	/** 
	 用户
	 
	*/
	 User(1),

	/** 
	 岗位
	 
	*/
	Position(2),

	/** 
	 单位
	 
	*/
	Department(3);

	//private int intValue;
	private int intValue;
	private static java.util.HashMap<Integer, HandlerAndMonitorType> mappings;
	private synchronized static java.util.HashMap<Integer, HandlerAndMonitorType> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, HandlerAndMonitorType>();
		}
		return mappings;
	}

	private HandlerAndMonitorType(int value)
	{
		intValue = value;
		HandlerAndMonitorType.getMappings().put(value, this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static HandlerAndMonitorType forValue(int value)
	{
		return getMappings().get(value);
	}
}

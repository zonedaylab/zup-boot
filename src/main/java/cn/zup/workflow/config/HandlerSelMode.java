package cn.zup.workflow.config;

//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#endregion

//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#region 9-操作者选择模式
/** 
 操作者选择模式
 
*/
public enum HandlerSelMode
{
	/** 
	 无约束
	 
	*/
	UnRestrain(1),

	/** 
	 同部门
	 
	*/
	SameDepartment(2);

	private int intValue;
	private static java.util.HashMap<Integer, HandlerSelMode> mappings;
	private synchronized static java.util.HashMap<Integer, HandlerSelMode> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, HandlerSelMode>();
		}
		return mappings;
	}

	private HandlerSelMode(int value)
	{
		intValue = value;
		HandlerSelMode.getMappings().put(value, this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static HandlerSelMode forValue(int value)
	{
		return getMappings().get(value);
	}
}

package cn.zup.workflow.config;

//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#endregion

//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#region 控件显示类型
/** 
 控件显示类型
 
*/
public enum ControlDisplayType
{
	/** 
	 可操作
	 
	*/
	Enable(1),

	/** 
	 不可操作
	 
	*/
	Disable(2),

	/** 
	 隐藏
	 
	*/
	Hidden(3);

	private int intValue;
	private static java.util.HashMap<Integer, ControlDisplayType> mappings;
	private synchronized static java.util.HashMap<Integer, ControlDisplayType> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, ControlDisplayType>();
		}
		return mappings;
	}

	private ControlDisplayType(int value)
	{
		intValue = value;
		ControlDisplayType.getMappings().put(value, this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static ControlDisplayType forValue(int value)
	{
		return getMappings().get(value);
	}
}

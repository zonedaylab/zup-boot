package cn.zup.workflow.config;

//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#endregion

//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#region 委托状态
/** 
 委托状态
 
*/
public enum EntrustState
{
	/** 
	 无效
	 
	*/
	InValid(0),

	//有效
	Valid(1);

	private int intValue;
	private static java.util.HashMap<Integer, EntrustState> mappings;
	private synchronized static java.util.HashMap<Integer, EntrustState> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, EntrustState>();
		}
		return mappings;
	}

	private EntrustState(int value)
	{
		intValue = value;
		EntrustState.getMappings().put(value, this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static EntrustState forValue(int value)
	{
		return getMappings().get(value);
	}
}

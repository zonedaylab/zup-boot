package cn.zup.workflow.config;

//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#endregion

//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#region 4-流程状态
/** 
 流程状态
 
*/
public enum FlowState
{
	/** 
	 有效（正常流转）
	 
	*/
	VALID(1),

	/** 
	 无效（非流程化，不进行流转，不生成工作项）
	 
	*/
	INVALID(2);

	private int intValue;
	private static java.util.HashMap<Integer, FlowState> mappings;
	private synchronized static java.util.HashMap<Integer, FlowState> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, FlowState>();
		}
		return mappings;
	}

	private FlowState(int value)
	{
		intValue = value;
		FlowState.getMappings().put(value, this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static FlowState forValue(int value)
	{
		return getMappings().get(value);
	}
}

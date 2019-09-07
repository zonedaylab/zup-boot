package cn.zup.workflow.config;

//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#endregion

//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#region 10-流转规则类型
/** 
 规则类型
 
*/
public enum ConditionType
{
	/** 
	 1.大于
	 
	*/
	MoreThan(1),

	/** 
	 2.大于或等于
	 
	*/
	MoreThanOrEqual(2),

	/** 
	 3.等于
	 
	*/
	Equal(3),

	/** 
	 4.小于
	 
	*/
	LessThan(4),

	/** 
	 5.小于或等于
	 
	*/
	LessThanOrEqual(5),

	/** 
	 6.包含
	 
	*/
	Contain(6),

	/** 
	 7.不包含
	 
	*/
	NoContain(7);

	private int intValue;
	private static java.util.HashMap<Integer, ConditionType> mappings;
	private synchronized static java.util.HashMap<Integer, ConditionType> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, ConditionType>();
		}
		return mappings;
	}

	private ConditionType(int value)
	{
		intValue = value;
		ConditionType.getMappings().put(value, this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static ConditionType forValue(int value)
	{
		return getMappings().get(value);
	}
}

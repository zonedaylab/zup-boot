package cn.zup.workflow.config;

//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#endregion

//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#region 6-评审类型
/** 
 评审类型
 
*/
public enum ReviewType
{
	/** 
	 只要有一人通过审批即可向下流转
	 
	*/
	OnePass(1),

	/** 
	 所有人通过评审才向下流转
	 
	*/
	AllPass(2);

	private int intValue;
	private static java.util.HashMap<Integer, ReviewType> mappings;
	private synchronized static java.util.HashMap<Integer, ReviewType> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, ReviewType>();
		}
		return mappings;
	}

	private ReviewType(int value)
	{
		intValue = value;
		ReviewType.getMappings().put(value, this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static ReviewType forValue(int value)
	{
		return getMappings().get(value);
	}
}

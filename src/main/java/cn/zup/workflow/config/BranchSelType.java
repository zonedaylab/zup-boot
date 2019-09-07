package cn.zup.workflow.config;

//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#endregion

//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#region 7-分支选择模式

/** 
 分支选择模式
 
*/
public enum BranchSelType
{
	/** 
	 默认多选
	 
	*/
	Default(1),

	/** 
	 单选
	 
	*/
	Single(2),

	/** 
	 多选
	 
	*/
	Multiple(3);

	private int intValue;
	private static java.util.HashMap<Integer, BranchSelType> mappings;
	private synchronized static java.util.HashMap<Integer, BranchSelType> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, BranchSelType>();
		}
		return mappings;
	}

	private BranchSelType(int value)
	{
		intValue = value;
		BranchSelType.getMappings().put(value, this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static BranchSelType forValue(int value)
	{
		return getMappings().get(value);
	}
}

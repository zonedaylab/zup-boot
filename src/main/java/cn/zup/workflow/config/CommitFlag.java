package cn.zup.workflow.config;

//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#endregion

//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
///#region 工作保存、提交返回类型

/** 
 工作保存、提交返回标志
 
*/
public enum CommitFlag
{
	/** 
	 成功
	 
	*/
	Success(1),

	/** 
	 失败
	 
	*/
	Fail(2),
	/** 
	 重复
	 
	*/
	Repeat(3);

	private int intValue;
	private static java.util.HashMap<Integer, CommitFlag> mappings;
	private synchronized static java.util.HashMap<Integer, CommitFlag> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, CommitFlag>();
		}
		return mappings;
	}

	private CommitFlag(int value)
	{
		intValue = value;
		CommitFlag.getMappings().put(value, this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static CommitFlag forValue(int value)
	{
		return getMappings().get(value);
	}
}
//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
///#endregion

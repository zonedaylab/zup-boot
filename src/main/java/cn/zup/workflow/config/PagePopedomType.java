package cn.zup.workflow.config;

//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#endregion

//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#endregion

//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#region 页面权限类型
/** 
 页面权限类型
 
*/
public enum PagePopedomType
{
	/** 
	 业务流控制，默认，待办理工作中使用
	 
	*/
	PopedomFlowCtrl(1),

	/** 
	 没有任何权限 ，已办理工作中查询使用
	 
	*/
	PopedomNone(2),

	/** 
	 业务修改页面 ，已办理工作中修改业务使用
	 
	*/
	PopedomModify(3),

	/** 
	 所有控件权限（预留）
	 
	*/
	PopedomAll(4);

	private int intValue;
	private static java.util.HashMap<Integer, PagePopedomType> mappings;
	private synchronized static java.util.HashMap<Integer, PagePopedomType> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, PagePopedomType>();
		}
		return mappings;
	}

	private PagePopedomType(int value)
	{
		intValue = value;
		PagePopedomType.getMappings().put(value, this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static PagePopedomType forValue(int value)
	{
		return getMappings().get(value);
	}
}

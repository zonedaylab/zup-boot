package cn.zup.workflow.engine.settings;


/** 
活动节点类型
*/
public  enum ActivityNodeTypeEnum
{
	SLEEP(0), //0 休眠
	ACTIVE(1), //1 激活
	FINISHED(2), //2 完成
	DIED(3); //3 僵死状态

	private int intValue;
	private static java.util.HashMap<Integer, ActivityNodeTypeEnum> mappings;
	private static java.util.HashMap<Integer, ActivityNodeTypeEnum> getMappings()
	{
		if (mappings == null)
		{
			synchronized (ActivityNodeTypeEnum.class)
			{
				if (mappings == null)
				{
					mappings = new java.util.HashMap<Integer, ActivityNodeTypeEnum>();
				}
			}
		}
		return mappings;
	}

	private ActivityNodeTypeEnum(int value)
	{
		intValue = value;
		getMappings().put(value, this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static ActivityNodeTypeEnum forValue(int value)
	{
		return getMappings().get(value);
	}
}
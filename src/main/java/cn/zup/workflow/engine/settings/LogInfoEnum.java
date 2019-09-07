package cn.zup.workflow.engine.settings;



public enum LogInfoEnum
{
	INFO_COMMON(1), //基本信息 包括系统启动关闭 ，测试信息，工作遍历信息
	INFO_CRITICAL(2); //重要信息，包括激活节点，工作结束信息

	public static final int SIZE = java.lang.Integer.SIZE;

	private int intValue;
	private static java.util.HashMap<Integer, LogInfoEnum> mappings;
	private static java.util.HashMap<Integer, LogInfoEnum> getMappings()
	{
		if (mappings == null)
		{
			synchronized (LogInfoEnum.class)
			{
				if (mappings == null)
				{
					mappings = new java.util.HashMap<Integer, LogInfoEnum>();
				}
			}
		}
		return mappings;
	}

	private LogInfoEnum(int value)
	{
		intValue = value;
		getMappings().put(value, this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static LogInfoEnum forValue(int value)
	{
		return getMappings().get(value);
	}
}
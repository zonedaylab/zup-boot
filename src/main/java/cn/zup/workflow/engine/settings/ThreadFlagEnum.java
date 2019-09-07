package cn.zup.workflow.engine.settings;


/** 
 * 异常标志
 * lixin
 * 2018-4-4 10:42:56
*/
public enum ThreadFlagEnum
{
	RUNNING(1), //线程运行
	NEED_QUIT(2), //线程需要退出
	FLAG_QUIT(3); //线程已经退出

	public static final int SIZE = java.lang.Integer.SIZE;

	private int intValue;
	private static java.util.HashMap<Integer, ThreadFlagEnum> mappings;
	private static java.util.HashMap<Integer, ThreadFlagEnum> getMappings()
	{
		if (mappings == null)
		{
			synchronized (ThreadFlagEnum.class)
			{
				if (mappings == null)
				{
					mappings = new java.util.HashMap<Integer, ThreadFlagEnum>();
				}
			}
		}
		return mappings;
	}

	private ThreadFlagEnum(int value)
	{
		intValue = value;
		getMappings().put(value, this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static ThreadFlagEnum forValue(int value)
	{
		return getMappings().get(value);
	}
}
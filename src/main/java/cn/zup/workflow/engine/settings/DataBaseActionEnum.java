package cn.zup.workflow.engine.settings;



public enum DataBaseActionEnum
{
	Select(1),
	Insert(2),
	Update(3),
	Delete(4);

	public static final int SIZE = java.lang.Integer.SIZE;

	private int intValue;
	private static java.util.HashMap<Integer, DataBaseActionEnum> mappings;
	private static java.util.HashMap<Integer, DataBaseActionEnum> getMappings()
	{
		if (mappings == null)
		{
			synchronized (DataBaseActionEnum.class)
			{
				if (mappings == null)
				{
					mappings = new java.util.HashMap<Integer, DataBaseActionEnum>();
				}
			}
		}
		return mappings;
	}

	private DataBaseActionEnum(int value)
	{
		intValue = value;
		getMappings().put(value, this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static DataBaseActionEnum forValue(int value)
	{
		return getMappings().get(value);
	}
}
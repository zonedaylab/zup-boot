package cn.zup.rbac.service.settings;


	public enum ConfigValidFlag
	{
		/**
		 * 有效
		 */
		有效(1),
		/**
		 * 无效
		 */
		无效(2);
	private int intValue;
	private static java.util.HashMap<Integer, ConfigValidFlag> mappings;
	private synchronized static java.util.HashMap<Integer, ConfigValidFlag> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, ConfigValidFlag>();
		}
		return mappings;
	}
	
	private ConfigValidFlag(int value)
	{
		intValue = value;
		ConfigValidFlag.getMappings().put(value, this);
	}
	
	public int getValue()
	{
		return intValue;
	}
	
	public static ConfigValidFlag forValue(int value)
	{
		return getMappings().get(value);
	}
	}
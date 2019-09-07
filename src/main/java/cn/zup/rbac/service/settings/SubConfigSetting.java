package cn.zup.rbac.service.settings;


	public enum SubConfigSetting
	{
		/**
		 * 合同类型
		 */
		全日制(1),
		非全日制(2),
		实习生(3),
		劳务(4),
		/**
		 * 政治面貌
		 */
		群众(1),
		共青团员(2),
		预备党员(3),
		中共党员(4),
		其他(5),
		/**
		 * 性别
		 */
		男(1),
		女(2),
		/**
		 * 学历
		 */
		小学(1),
		初中(2),
		高中(3),
		大专(4),
		本科(5),
		硕士(6),
		博士(7),
		;
	private int intValue;
	private static java.util.HashMap<Integer, SubConfigSetting> mappings;
	private synchronized static java.util.HashMap<Integer, SubConfigSetting> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, SubConfigSetting>();
		}
		return mappings;
	}
	
	private SubConfigSetting(int value)
	{
		intValue = value;
		SubConfigSetting.getMappings().put(value, this);
	}
	
	public int getValue()
	{
		return intValue;
	}
	
	public static SubConfigSetting forValue(int value)
	{
		return getMappings().get(value);
	}
	}
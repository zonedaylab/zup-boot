package cn.zup.rbac.service.settings;


	public enum RoleTypeFlag
	{
		/**
		 * 普通用电商户角色
		 */
		普通用电商户角色(2),
		/**
		 * 售电公司角色
		 */
		售电公司角色(3);
	private int intValue;
	private static java.util.HashMap<Integer, RoleTypeFlag> mappings;
	private synchronized static java.util.HashMap<Integer, RoleTypeFlag> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, RoleTypeFlag>();
		}
		return mappings;
	}
	
	private RoleTypeFlag(int value)
	{
		intValue = value;
		RoleTypeFlag.getMappings().put(value, this);
	}
	
	public int getValue()
	{
		return intValue;
	}
	
	public static RoleTypeFlag forValue(int value)
	{
		return getMappings().get(value);
	}
	}
package cn.zup.rbac.service.settings;


	public enum ConfigOrganType
	{
		/**
		 * 普通公司
		 */
		commonCompany(1),
		/**
		 * 经营公司
		 */
		jingyingCompany(2),
		/**
		 * 普通部门
		 */
		commonDepartment(4),
		/**
		 * 运营公司
		 */
		yunyingDepartment(3)
		
		;
	private int intValue;
	private static java.util.HashMap<Integer, ConfigOrganType> mappings;
	private synchronized static java.util.HashMap<Integer, ConfigOrganType> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, ConfigOrganType>();
		}
		return mappings;
	}
	
	private ConfigOrganType(int value)
	{
		intValue = value;
		ConfigOrganType.getMappings().put(value, this);
	}
	
	public int getValue()
	{
		return intValue;
	}
	
	public static ConfigOrganType forValue(int value)
	{
		return getMappings().get(value);
	}
	}
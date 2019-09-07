package cn.zup.rbac.service.settings;

/** 
 * desc:组织类型
 * Author：samson
 * Date: 2016.07.26
 * @param userinfo
*/
public enum SystemTypeEnum
{  
	/** 
	 光伏
	 
	*/
	PHOTOVOL(1),
	/** 
	售电系统
	 
	*/
	ESALE(101);

	private int intValue;
	private static java.util.HashMap<Integer, SystemTypeEnum> mappings;
	private synchronized static java.util.HashMap<Integer, SystemTypeEnum> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, SystemTypeEnum>();
		}
		return mappings;
	}

	private SystemTypeEnum(int value)
	{
		intValue = value;
		SystemTypeEnum.getMappings().put(value,this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static SystemTypeEnum forValue(int value)
	{
		return getMappings().get(value);
	}
}

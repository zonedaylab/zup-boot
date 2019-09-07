package cn.zup.rbac.service.settings;

/** 
 * desc:组织类型
 * Author：samson
 * Date: 2016.07.26
 * @param userinfo
*/
public enum OrganType
{  
	/** 
	 部门
	 
	*/
	ieslab(1),
	/** 
	 单位
	 
	*/
	iesenergy(2);

	private int intValue;
	private static java.util.HashMap<Integer, OrganType> mappings;
	private synchronized static java.util.HashMap<Integer, OrganType> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, OrganType>();
		}
		return mappings;
	}

	private OrganType(int value)
	{
		intValue = value;
		OrganType.getMappings().put(value,this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static OrganType forValue(int value)
	{
		return getMappings().get(value);
	}
}

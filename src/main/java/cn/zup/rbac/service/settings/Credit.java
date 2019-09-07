package cn.zup.rbac.service.settings;

/**
 * 信用等级
 * date:2017/2/21
 * @author zss
 *
 */
public enum Credit
{  
	
	/** 
	A级
	*/
	A级(1),
	/** 
	B级
	*/
	B级(2),
	/** 
	C级
	*/
	C级(3),
	/** 
	D级
	*/
	D级(4)
	;
	private int intValue;
	private static java.util.HashMap<Integer, Credit> mappings;
	private synchronized static java.util.HashMap<Integer, Credit> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, Credit>();
		}
		return mappings;
	}

	private Credit(int value)
	{
		intValue = value;
		Credit.getMappings().put(value,this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static Credit forValue(int value)
	{
		return getMappings().get(value);
	}
}

package cn.zup.rbac.service.settings;


/** 
 * desc:有效标识
 * Author：samson
 * Date: 2016.07.26
 * @param userinfo
*/
public enum ValigFlag
{  
	/** 
	是
	 
	*/
	yes(1),
	/** 
	 否
	 
	*/
	no(2);

	private int intValue;
	private static java.util.HashMap<Integer, ValigFlag> mappings;
	private synchronized static java.util.HashMap<Integer, ValigFlag> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, ValigFlag>();
		}
		return mappings;
	}

	private ValigFlag(int value)
	{
		intValue = value;
		ValigFlag.getMappings().put(value,this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static ValigFlag forValue(int value)
	{
		return getMappings().get(value);
	}
}

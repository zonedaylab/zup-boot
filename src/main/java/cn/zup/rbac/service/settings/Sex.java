package cn.zup.rbac.service.settings;

/** 
 * desc:性别
 * Author：samson
 * Date: 2016.07.26
 * @param userinfo
*/
public enum Sex
{  
	/** 
	 男
	 
	*/
	man(1),
	/** 
	 有女标识
	 
	*/
	woman(2);

	private int intValue;
	private static java.util.HashMap<Integer, Sex> mappings;
	private synchronized static java.util.HashMap<Integer, Sex> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, Sex>();
		}
		return mappings;
	}

	private Sex(int value)
	{
		intValue = value;
		Sex.getMappings().put(value,this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static Sex forValue(int value)
	{
		return getMappings().get(value);
	}
}

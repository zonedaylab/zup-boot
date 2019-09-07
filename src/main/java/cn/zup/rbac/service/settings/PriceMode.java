package cn.zup.rbac.service.settings;


/** 
 * desc:有效标识
 * Author：samson
 * Date: 2016.07.26
 * @param userinfo
*/
public enum PriceMode
{  
	/** 
	单一制
	 
	*/
	单一制(1),
	/** 
	 两部制
	 
	*/
	两部制(2);

	private int intValue;
	private static java.util.HashMap<Integer, PriceMode> mappings;
	private synchronized static java.util.HashMap<Integer, PriceMode> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, PriceMode>();
		}
		return mappings;
	}

	private PriceMode(int value)
	{
		intValue = value;
		PriceMode.getMappings().put(value,this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static PriceMode forValue(int value)
	{
		return getMappings().get(value);
	}
}

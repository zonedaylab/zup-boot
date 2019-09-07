package cn.zup.rbac.service.settings;

/**
 * 用电性质
 * date:2017/2/21
 * @author zss
 *
 */
public enum EnergyProperty
{  
	
	/** 
	大工业用电
	*/
	大工业用电(1),
	/** 
	一般工商业用电
	*/
	一般工商业用电(2),
	/** 
	农业生产用电
	*/
	农业生产用电(3),
	/** 
	居民生活用电
	*/
	居民生活用电(4)
	;
	private int intValue;
	private static java.util.HashMap<Integer, EnergyProperty> mappings;
	private synchronized static java.util.HashMap<Integer, EnergyProperty> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, EnergyProperty>();
		}
		return mappings;
	}

	private EnergyProperty(int value)
	{
		intValue = value;
		EnergyProperty.getMappings().put(value,this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static EnergyProperty forValue(int value)
	{
		return getMappings().get(value);
	}
}

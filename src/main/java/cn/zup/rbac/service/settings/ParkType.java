package cn.zup.rbac.service.settings;

/**
 * 园区类型
 * 2017-3-7 16:58:44
 * @author lixin
 *
 */
public enum ParkType
{  
	
	/** 
	用能园区
	*/
	用能园区(1),
	/** 
	产能园区
	*/
	产能园区(2),
	/** 
	综合园区
	*/
	综合园区(3)
	;
	private int intValue;
	private static java.util.HashMap<Integer, ParkType> mappings;
	private synchronized static java.util.HashMap<Integer, ParkType> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, ParkType>();
		}
		return mappings;
	}

	private ParkType(int value)
	{
		intValue = value;
		ParkType.getMappings().put(value,this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static ParkType forValue(int value)
	{
		return getMappings().get(value);
	}
}

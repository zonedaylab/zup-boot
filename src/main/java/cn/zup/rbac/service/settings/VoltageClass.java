package cn.zup.rbac.service.settings;

/**
 * 商户类别
 * date:2017/2/21
 * @author zss
 *
 */
public enum VoltageClass
{  
	
	/** 
	1kV
	*/
	一kV(1),
	/** 
	6kV
	*/
	六kV(2),
	/** 
	10kV
	*/
	十kV(3),
	/** 
	35kV
	*/
	三十五kV(4),
	/** 
	110kV
	*/
	一一零kV(5),
	/** 
	220kV
	*/
	二二零kV(6),
	/** 
	330kV
	*/
	三三零kV(7),
	/** 
	500kV
	*/
	五百kV(8)
	;
	private int intValue;
	private static java.util.HashMap<Integer, VoltageClass> mappings;
	private synchronized static java.util.HashMap<Integer, VoltageClass> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, VoltageClass>();
		}
		return mappings;
	}

	private VoltageClass(int value)
	{
		intValue = value;
		VoltageClass.getMappings().put(value,this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static VoltageClass forValue(int value)
	{
		return getMappings().get(value);
	}
}

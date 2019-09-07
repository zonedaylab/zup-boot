package cn.zup.rbac.service.settings;

/**
 * 信用等级
 * date:2017/2/21
 * @author zss
 *
 */
public enum MerchantScale
{  
	
	/** 
	大用户
	*/
	大用户(1),
	/** 
	一般用户
	*/
	一般用户(2)
	;
	private int intValue;
	private static java.util.HashMap<Integer, MerchantScale> mappings;
	private synchronized static java.util.HashMap<Integer, MerchantScale> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, MerchantScale>();
		}
		return mappings;
	}

	private MerchantScale(int value)
	{
		intValue = value;
		MerchantScale.getMappings().put(value,this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static MerchantScale forValue(int value)
	{
		return getMappings().get(value);
	}
}

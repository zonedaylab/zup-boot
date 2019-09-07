package cn.zup.rbac.service.settings;

/**
 * 信用等级
 * date:2017/2/21
 * @author zss
 *
 */
public enum TradeFlag
{  
	
	/** 
	有效状态
	*/
	有效状态(1),
	/** 
	无效状态
	*/
	无效状态(2)
	;
	private int intValue;
	private static java.util.HashMap<Integer, TradeFlag> mappings;
	private synchronized static java.util.HashMap<Integer, TradeFlag> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, TradeFlag>();
		}
		return mappings;
	}

	private TradeFlag(int value)
	{
		intValue = value;
		TradeFlag.getMappings().put(value,this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static TradeFlag forValue(int value)
	{
		return getMappings().get(value);
	}
}

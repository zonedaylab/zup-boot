package cn.zup.rbac.service.settings;

/**
 * 审核状态
 * 2017-3-3 16:42:03
 * @author lixin
 *
 */
public enum CheckState
{  
	
	/** 
	已审核
	*/
	已审核(1),
	/** 
	未审核
	*/
	未审核(2)
	;
	private int intValue;
	private static java.util.HashMap<Integer, CheckState> mappings;
	private synchronized static java.util.HashMap<Integer, CheckState> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, CheckState>();
		}
		return mappings;
	}

	private CheckState(int value)
	{
		intValue = value;
		CheckState.getMappings().put(value,this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static CheckState forValue(int value)
	{
		return getMappings().get(value);
	}
}

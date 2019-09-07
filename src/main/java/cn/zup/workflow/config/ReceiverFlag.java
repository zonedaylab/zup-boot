package cn.zup.workflow.config;

/** 
 通知接收标志
 
*/
public enum ReceiverFlag
{
	/** 
	 未签收
	 
	*/
	NoReceive(0),

	/** 
	 已签收
	 
	*/
	Received(1);

	private int intValue;
	private static java.util.HashMap<Integer, ReceiverFlag> mappings;
	private synchronized static java.util.HashMap<Integer, ReceiverFlag> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, ReceiverFlag>();
		}
		return mappings;
	}

	private ReceiverFlag(int value)
	{
		intValue = value;
		ReceiverFlag.getMappings().put(value, this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static ReceiverFlag forValue(int value)
	{
		return getMappings().get(value);
	}
}

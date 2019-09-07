package cn.zup.rbac.service.settings;


/** 
 * desc:有效标识
 * Author：samson
 * Date: 2016.07.26
 * @param userinfo
*/
public enum OperateLogType
{  
	/** 
	信息
	 
	*/
	info(1),
	/** 
	 测试
	 
	*/
	debug(2),
	/** 
	 警告
	 
	*/
	warn(3),
	/** 
	 严重
	 
	*/
	error(4);

	private int intValue;
	private static java.util.HashMap<Integer, OperateLogType> mappings;
	private synchronized static java.util.HashMap<Integer, OperateLogType> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, OperateLogType>();
		}
		return mappings;
	}

	private OperateLogType(int value)
	{
		intValue = value;
		OperateLogType.getMappings().put(value,this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static OperateLogType forValue(int value)
	{
		return getMappings().get(value);
	}
}

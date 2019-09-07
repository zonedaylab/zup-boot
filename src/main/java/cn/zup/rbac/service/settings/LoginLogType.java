package cn.zup.rbac.service.settings;


/** 
 * desc:有效标识
 * Author：samson
 * Date: 2016.07.26
 * @param userinfo
*/
public enum LoginLogType
{  
	/** 
	成功
	 
	*/
	success(1),
	/** 
	 失败
	 
	*/
	quit(2),
	/** 
	 失败
	 
	*/
	fail(2);

	private int intValue;
	private static java.util.HashMap<Integer, LoginLogType> mappings;
	private synchronized static java.util.HashMap<Integer, LoginLogType> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, LoginLogType>();
		}
		return mappings;
	}

	private LoginLogType(int value)
	{
		intValue = value;
		LoginLogType.getMappings().put(value,this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static LoginLogType forValue(int value)
	{
		return getMappings().get(value);
	}
}

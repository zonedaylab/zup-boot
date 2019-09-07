package cn.zup.rbac.service.settings;

/** 
 数据权限类型
 
*/
public enum DataPermissionType
{
	/** 
	 组织权限
	 
	*/
	OrganPermission(1),

	/** 
	 业务范围权限
	 
	*/
	BussinessPermission(2);

	private int Value;
	private static java.util.HashMap<Integer, DataPermissionType> mappings;
	private synchronized static java.util.HashMap<Integer, DataPermissionType> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, DataPermissionType>();
		}
		return mappings;
	}

	private DataPermissionType(int value)
	{
		Value = value;
		DataPermissionType.getMappings().put(value, this);
	}

	public int getValue()
	{
		return Value;
	}

	public static DataPermissionType forValue(int value)
	{
		return getMappings().get(value);
	}
	
}

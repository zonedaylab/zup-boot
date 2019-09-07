package cn.zup.workflow.config;

 public enum ActivityProperty
{
	/** 
	 ����������
	 
	*/
	General(1),

	/** 
	 �ؼ�����
	 
	*/
	KeyAttribute(2),

	/** 
	 ��������
	 
	*/
	BatchHandle(3);

	private int intValue;
	private static java.util.HashMap<Integer, ActivityProperty> mappings;
	private synchronized static java.util.HashMap<Integer, ActivityProperty> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, ActivityProperty>();
		}
		return mappings;
	}

	private ActivityProperty(int value)
	{
		intValue = value;
		ActivityProperty.getMappings().put(value, this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static ActivityProperty forValue(int value)
	{
		return getMappings().get(value);
	}
}
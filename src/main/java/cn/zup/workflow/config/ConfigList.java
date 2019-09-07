package cn.zup.workflow.config;
/** 
 配置列表
 
*/
public enum ConfigList
{
	/** 
	 工作状态
	 
	*/
	WorkState(1),

	/** 
	 工作活动状态
	 
	*/
	WorkActivityState(2),

	/** 
	 工作项状态
	 
	*/
	WorkItemState(3),

	/** 
	 流程状态
	 
	*/
	FlowState(4),

	/** 
	 活动类型
	 
	*/
	ActivityType(5),

	/** 
	 评审类型
	 
	*/
	ReviewType(6),

	/** 
	 分支选择模式
	 
	*/
	BranchSelType(7),

	/** 
	 操作者及监控者类型
	 
	*/
	HandlerAndMonitorType(8),

	/** 
	 操作者选择模式
	 
	*/
	HandlerSelMode(9),

	/** 
	 规则类型
	 
	*/
	ConditionType(10),

	/** 
	 组件类型
	 
	*/
	ControlType(11),

	/** 
	 可空标志
	 
	*/
	NullPermit(12),

	/** 
	 组件含义
	 
	*/
	ControlMeaning(13),

	/** 
	 组件状态 1可用 2只读 3隐藏
	 
	*/
	ControlState(14),

	/** 
	 活动属性
	 
	*/
	ActivityProperty(15),

	/** 
	 通知接收标志
	 
	*/
	ReceiverFlag(16),

	/** 
	 委托状态
	 
	*/
	EntrustState(17);

	private int intValue;
	private static java.util.HashMap<Integer, ConfigList> mappings;
	private synchronized static java.util.HashMap<Integer, ConfigList> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, ConfigList>();
		}
		return mappings;
	}

	private ConfigList(int value)
	{
		intValue = value;
		ConfigList.getMappings().put(value, this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static ConfigList forValue(int value)
	{
		return getMappings().get(value);
	}
}

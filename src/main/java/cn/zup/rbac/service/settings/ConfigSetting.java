package cn.zup.rbac.service.settings;

/** 
 * desc:配置表类型
 * Author：samson
 * Date: 2016.07.26
 * @param userinfo
*/
public enum ConfigSetting
{
	/** 
	 组织类型
	 
	*/
	OrganType(1),

	/** 
	 性别
	 
	*/
	Sex(2),

	/** 
	 有效标识
	 
	*/
	ValigFlag(3),
	/** 
	 登录类型 
	 
	*/
	LoginLogType(4),
	
	/** 
	 告警等级 
	 
	*/
	LogLevelType(5),
	/** 
	角色类型 
	 
	*/
	RoleType(6),
	/** 
	数据权限类型 
	 
	*/
	DataPermissionType(7),
	/** 
	政治面貌
	 
	*/
	PoliticStatus(8),
	/** 
	合同类型
	 
	*/
	ContractType(9),
	/**
	 * 学历
	 */
	Education(10),
	/** 
	 工程类别
	 
	*/
	ProjectType(11),
	/** 
	 工程业务类别
	 
	*/
	BusinessType(12),
	/** 
	 辖区
	 
	*/
	AreaName(13),
	/** 
	 施工组织
	 
	*/
	ConstructName(14),
	/** 
	 电站状态
	 
	*/
	StationStat(15),
	/**
	 * 手机端标识
	 */
	MobileFlagType(16),
	/**
	 * 任务来源
	 */
	TaskSource(17),
	/**
	 * 任务类型
	 */
	TaskType(18),
	/**
	 * 任务状态
	 */
	TaskState(19),
	/**
	 * 处理结果
	 */
	HandleResult(20),
	/**
	 * 评价
	 */
	Evaluate(21),
	/**
	 * 转单
	 */
	TransferList(22),
	/**
	 * 处理类型
	 */
	HandleType(23),
	/**
	 * 交易品种
	 */
	TradeCategory(24), 
	/** 
	 仓库类型
	 
	*/
	  MaterialType(25),
	  /**
	   *告警来源 
	   */
	  WarnSource(26),
	  /**
	   *告警等级 
	   */
	  WarnLevel(27),
	  /**
	   *告警类型 
	   */
	  WarnType(28)	 ,
	  /**
	   * 部件类型
	   */
	  PartsType(29),
	  /**
		 * 园区类型
		 */
		ParkType(31),
		/**
		 * 电压等级
		 */
		VoltageClass(32),
		/**
		 * 电价方式
		 */
		PriceMode(33),
		/**
		 * 审核状态
		 */
		checkState(34),
	  /**
		 * 商户类型
		 */
		MerchantType(52),
		/**
		 * 信用等级
		 */
		Credit(53),
		/**
		 * 行业类别
		 */
		IndustryCategory(54),
		/**
		 * 交易资格
		 */
		TradeFlag(55),
		/**
		 * 商户规模
		 */
		MerchantScale(56),
		/**
		 * 用电性质
		 */
		EnergyProperty(57),
		/**
		 * 交易品种等级
		 */
		TradeCategoryLevel(76),
		/**
		 * 时段类型
		 */
		QuantityType(77)
		;
	private int intValue;
	private static java.util.HashMap<Integer, ConfigSetting> mappings;
	private synchronized static java.util.HashMap<Integer, ConfigSetting> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, ConfigSetting>();
		}
		return mappings;
	}

	private ConfigSetting(int value)
	{
		intValue = value;
		ConfigSetting.getMappings().put(value, this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static ConfigSetting forValue(int value)
	{
		return getMappings().get(value);
	}
}
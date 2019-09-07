package cn.zup.rbac.service.settings;

/**
 * 行业类别
 * date:2017/2/21
 * @author zss
 *
 */
public enum IndustryCategory
{  
	
	/** 
	农、林、牧、渔、业
	*/
	农林牧渔业(1),
	/** 
	采矿业
	*/
	采矿业(2),
	/** 
	制造业
	*/
	制造业(3),
	/** 
	电力、热力、燃气及水生产和供应业
	*/
	电力热力燃气及水生产和供应业(4),
	/** 
	建筑业
	*/
	建筑业(5),
	/** 
	批发和零售业
	*/
	批发和零售业(6),
	/** 
	交通运输、仓储和邮政业
	*/
	交通运输仓储和邮政业(7),
	/** 
	住宿和餐饮业
	*/
	住宿和餐饮业(8),
	/** 
	信息传输、软件和信息技术服务业
	*/
	信息传输软件和信息技术服务业(9),
	/** 
	金融业
	*/
	金融业(10),
	/** 
	房地产业
	*/
	房地产业(11),
	/** 
	租赁和商务服务业
	*/
	租赁和商务服务业(12),
	/** 
	科学研究和技术服务业
	*/
	科学研究和技术服务业(13),
	/** 
        水利、环境和公共设施管理业
	*/
	水利环境和公共设施管理业(14),
	/** 
	居民服务、修理和其他服务业
	*/
	居民服务修理和其他服务业(15),
	/** 
	教育
	*/
	教育(16),
	/** 
	卫生和社会工作
	*/
	卫生和社会工作(17),
	/** 
	文化、体育和娱乐业
	*/
	文化体育和娱乐业(18),
	/** 
	公共管理、社会保障和社会组织
	*/
	公共管理社会保障和社会组织(19),
	/** 
	国际组织
	*/
	国际组织(20),
	;
	private int intValue;
	private static java.util.HashMap<Integer, IndustryCategory> mappings;
	private synchronized static java.util.HashMap<Integer, IndustryCategory> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, IndustryCategory>();
		}
		return mappings;
	}

	private IndustryCategory(int value)
	{
		intValue = value;
		IndustryCategory.getMappings().put(value,this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static IndustryCategory forValue(int value)
	{
		return getMappings().get(value);
	}
}

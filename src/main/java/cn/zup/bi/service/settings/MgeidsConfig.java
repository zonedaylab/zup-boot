package cn.zup.bi.service.settings;

public enum MgeidsConfig {
	
	DataType(77),
	
	ShiFou(78),
	
	FieldType(79),
	
	Page_Type(80),
	
	Template_Url(81),
	
	Block_Type(82);
	
	
	private int intValue;
	private static java.util.HashMap<Integer, MgeidsConfig> mappings;
	private synchronized static java.util.HashMap<Integer, MgeidsConfig> getMappings(){
		if (mappings == null){
			mappings = new java.util.HashMap<Integer, MgeidsConfig>();
		}
		return mappings;
	}

	private MgeidsConfig(int value) {
		intValue = value;
		MgeidsConfig.getMappings().put(value,this);
	}

	public int getValue() {
		return intValue;
	}

	public static MgeidsConfig forValue(int value) {
		return getMappings().get(value);
	}
}

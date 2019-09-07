package cn.zup.bi.service.settings;

public enum FieldTypeConfig {
	
	Integer(1),
	Double(2),
	Float(3),
	Long(4),
	String(5);
	
	
	private int intValue;
	private static java.util.HashMap<Integer, FieldTypeConfig> mappings;
	private synchronized static java.util.HashMap<Integer, FieldTypeConfig> getMappings(){
		if (mappings == null){
			mappings = new java.util.HashMap<Integer, FieldTypeConfig>();
		}
		return mappings;
	}

	private FieldTypeConfig(int value) {
		intValue = value;
		FieldTypeConfig.getMappings().put(value,this);
	}

	public int getValue() {
		return intValue;
	}

	public static FieldTypeConfig forValue(int value) {
		return getMappings().get(value);
	}
}

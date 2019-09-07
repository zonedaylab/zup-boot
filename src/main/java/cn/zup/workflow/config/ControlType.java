package cn.zup.workflow.config;
//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#endregion

//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#region 11-组件类型
/** 
 组件类型
 
*/
public enum ControlType
{
	/** 
	 Label类型
	 
	*/
	Label(1),
	/** 
	 TextField类型
	 
	*/
	TextField(2),
	/** 
	 NumberField类型
	 
	*/
	NumberField(3),
	/** 
	 DateField类型
	 
	*/
	DateField(4), 
	/** 
	 ComboBox类型
	 
	*/
	ComboBox(5),
	/** 
	 DropDownField类型
	 
	*/
	DropDownField(6),
	/** 
	 GridPanel类型
	 
	*/
	GridPanel(7),
	/** 
	 Button类型
	 
	*/
	Button(8),
	/** 
	 CompositeField类型
	 
	*/
	CompositeField(9),
	/** 
	 FileUploadField类型
	 
	*/
	FileUploadField(10),
	/** 
	 TextArea类型
	 
	*/
	TextArea(11),
	/** 
	 FieldSet类型
	 
	*/
	FieldSet(12),
	/** 
	 TreePanel类型
	 
	*/
	TreePanel(13),
	/** 
	 SpinnerField类型
	 
	*/
	SpinnerField(14),
	/** 
	 Container类型
	 
	*/
	Container(15),
	/** 
	 Grid类型
	 
	*/
	GirdView(16);

	private int intValue;
	private static java.util.HashMap<Integer, ControlType> mappings;
	private synchronized static java.util.HashMap<Integer, ControlType> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, ControlType>();
		}
		return mappings;
	}

	private ControlType(int value)
	{
		intValue = value;
		ControlType.getMappings().put(value, this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static ControlType forValue(int value)
	{
		return getMappings().get(value);
	}
}

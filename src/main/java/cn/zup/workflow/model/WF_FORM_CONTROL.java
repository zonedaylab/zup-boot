package cn.zup.workflow.model;
/**
 * 工作流表单控件
 * @author Administrator
 *
 */
public class WF_FORM_CONTROL implements java.io.Serializable {

	private Integer 		CONTROL_ID;//控件id
	private int 			FORM_ID;//表单id
	private String 			CONTROL_NAME;//控件名称
	private String 			CONTROL_TEXT;//控件内容
	private byte 			CONTROL_TYPE;//控件类型
	private byte 			NULL_PERMIT;//是否允许为空
	private int 			DEFAULT_LENGTH;//默认长度
	private byte 			CONTROL_MEANING;//控件是否有意义
	private String 			USER_CONTROL_NAME;//用户控件名称

	public WF_FORM_CONTROL() {
	}

	public WF_FORM_CONTROL(int FORM_ID, String CONTROL_NAME, byte CONTROL_TYPE,
			byte NULL_PERMIT, int DEFAULT_LENGTH, byte CONTROL_MEANING) {
		this.FORM_ID 			= FORM_ID;
		this.CONTROL_NAME 		= CONTROL_NAME;
		this.CONTROL_TYPE 		= CONTROL_TYPE;
		this.NULL_PERMIT 		= NULL_PERMIT;
		this.DEFAULT_LENGTH 	= DEFAULT_LENGTH;
		this.CONTROL_MEANING 	= CONTROL_MEANING;
	}

	public WF_FORM_CONTROL(int FORM_ID, String CONTROL_NAME, String CONTROL_TEXT,
			byte CONTROL_TYPE, byte NULL_PERMIT, int DEFAULT_LENGTH,
			byte CONTROL_MEANING, String USER_CONTROL_NAME) {
		this.FORM_ID 			= FORM_ID;
		this.CONTROL_NAME 		= CONTROL_NAME;
		this.CONTROL_TEXT 		= CONTROL_TEXT;
		this.CONTROL_TYPE 		= CONTROL_TYPE;
		this.NULL_PERMIT 		= NULL_PERMIT;
		this.DEFAULT_LENGTH 	= DEFAULT_LENGTH;
		this.CONTROL_MEANING 	= CONTROL_MEANING;
		this.USER_CONTROL_NAME 	= USER_CONTROL_NAME;
	}

	public Integer getCONTROL_ID() {
		return CONTROL_ID;
	}

	public void setCONTROL_ID(Integer CONTROL_ID) {
		this.CONTROL_ID 		= CONTROL_ID;
	}

	public int getFORM_ID() {
		return FORM_ID;
	}

	public void setFORM_ID(int FORM_ID) {
		this.FORM_ID 			= FORM_ID;
	}

	public String getCONTROL_NAME() {
		return CONTROL_NAME;
	}

	public void setCONTROL_NAME(String CONTROL_NAME) {
		this.CONTROL_NAME 		= CONTROL_NAME;
	}

	public String getCONTROL_TEXT() {
		return CONTROL_TEXT;
	}

	public void setCONTROL_TEXT(String CONTROL_TEXT) {
		this.CONTROL_TEXT 		= CONTROL_TEXT;
	}

	public byte getCONTROL_TYPE() {
		return CONTROL_TYPE;
	}

	public void setCONTROL_TYPE(byte CONTROL_TYPE) {
		this.CONTROL_TYPE 		= CONTROL_TYPE;
	}

	public byte getNULL_PERMIT() {
		return NULL_PERMIT;
	}

	public void setNULL_PERMIT(byte NULL_PERMIT) {
		this.NULL_PERMIT 		= NULL_PERMIT;
	}

	public int getDEFAULT_LENGTH() {
		return DEFAULT_LENGTH;
	}

	public void setDEFAULT_LENGTH(int DEFAULT_LENGTH) {
		this.DEFAULT_LENGTH 	= DEFAULT_LENGTH;
	}

	public byte getCONTROL_MEANING() {
		return CONTROL_MEANING;
	}

	public void setCONTROL_MEANING(byte CONTROL_MEANING) {
		this.CONTROL_MEANING 	= CONTROL_MEANING;
	}

	public String getUSER_CONTROL_NAME() {
		return USER_CONTROL_NAME;
	}

	public void setUSER_CONTROL_NAME(String USER_CONTROL_NAME) {
		this.USER_CONTROL_NAME 	= USER_CONTROL_NAME;
	}
	
}

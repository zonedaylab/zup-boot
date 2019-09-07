package cn.zup.workflow.model;

public class WF_HANDLER implements java.io.Serializable {

	private int 		HANDLER_ID; //自增ID
	private int 			ACTIVITY_ID;
	private Integer 		HANDLER;//对应的真实用户ID
	private Integer 		HANDLER_TYPE;
	private String 			HANDLER_NAME;

	public WF_HANDLER() {
	}

	public WF_HANDLER(int ACTIVITY_ID) {
		this.ACTIVITY_ID 	= ACTIVITY_ID;
	}

	public WF_HANDLER(int ACTIVITY_ID, int HANDLER, int HANDLER_TYPE,
			String HANDLER_NAME) {
		this.ACTIVITY_ID 	= ACTIVITY_ID;
		this.HANDLER 		= HANDLER;
		this.HANDLER_TYPE 	= HANDLER_TYPE;
		this.HANDLER_NAME 	= HANDLER_NAME;
	}

	public int getHANDLER_ID() {
		return HANDLER_ID;
	}

	public void setHANDLER_ID(int HANDLER_ID) {
		this.HANDLER_ID 	= HANDLER_ID;
	}

	public int getACTIVITY_ID() {
		return ACTIVITY_ID;
	}

	public void setACTIVITY_ID(int ACTIVITY_ID) {
		this.ACTIVITY_ID 	= ACTIVITY_ID;
	}

	public int getHANDLER() {
		return HANDLER;
	}

	public void setHANDLER(int HANDLER) {
		this.HANDLER 		= HANDLER;
	}

	public int getHANDLER_TYPE() {
		return HANDLER_TYPE;
	}

	public void setHANDLER_TYPE(int HANDLER_TYPE) {
		this.HANDLER_TYPE 	= HANDLER_TYPE;
	}

	public String getHANDLER_NAME() {
		return HANDLER_NAME;
	}

	public void setHANDLER_NAME(String HANDLER_NAME) {
		this.HANDLER_NAME 	= HANDLER_NAME;
	}


}

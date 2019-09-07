package cn.zup.workflow.model;

public class WF_MSG_SET implements java.io.Serializable {

	private Integer 	MSG_ID;
	private int 		ACTIVITY_ID;
	private int 		RECEIVER_TYPE;
	private int 		RECEIVER_ID;
	private String 		RECEIVER_NAME;

	public WF_MSG_SET() {
	}

	public WF_MSG_SET(int ACTIVITY_ID, byte RECEIVER_TYPE, int RECEIVER_ID) {
		this.ACTIVITY_ID 		= ACTIVITY_ID;
		this.RECEIVER_TYPE 		= RECEIVER_TYPE;
		this.RECEIVER_ID 		= RECEIVER_ID;
	}

	public WF_MSG_SET(int ACTIVITY_ID, byte RECEIVER_TYPE, int RECEIVER_ID,
			String RECEIVER_NAME) {
		this.ACTIVITY_ID 		= ACTIVITY_ID;
		this.RECEIVER_TYPE 		= RECEIVER_TYPE;
		this.RECEIVER_ID 		= RECEIVER_ID;
		this.RECEIVER_NAME 		= RECEIVER_NAME;
	}

	public Integer getMSG_ID() {
		return MSG_ID;
	}

	public void setMSG_ID(Integer mSG_ID) {
		this.MSG_ID 			= mSG_ID;
	}

	public int getACTIVITY_ID() {
		return ACTIVITY_ID;
	}

	public void setACTIVITY_ID(int aCTIVITY_ID) {
		this.ACTIVITY_ID 		= aCTIVITY_ID;
	}

	public int getRECEIVER_TYPE() {
		return RECEIVER_TYPE;
	}

	public void setRECEIVER_TYPE(int rECEIVER_TYPE) {
		this.RECEIVER_TYPE 		= rECEIVER_TYPE;
	}

	public int getRECEIVER_ID() {
		return RECEIVER_ID;
	}

	public void setRECEIVER_ID(int rECEIVER_ID) {
		this.RECEIVER_ID 		= rECEIVER_ID;
	}

	public String getRECEIVER_NAME() {
		return RECEIVER_NAME;
	}

	public void setRECEIVER_NAME(String rECEIVER_NAME) {
		this.RECEIVER_NAME 		= rECEIVER_NAME;
	}


}

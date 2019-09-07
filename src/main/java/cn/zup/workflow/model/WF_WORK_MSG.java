package cn.zup.workflow.model;


import java.sql.Date;

public class WF_WORK_MSG implements java.io.Serializable {

	private Integer 			WORK_MSG_ID;
	private int 				WORK_ACTIVITY_ID;
	private int 				RECEIVER_TYPE;
	private int 				RECEIVER_ID;
	private String 				RECEIVER_NAME;
	private String 				SEND_CONTENT;
	private Date 				SEND_DATE;
	private Date 				RECEIVER_DATE;
	private Byte 				RECEIVER_FLAG;

	public WF_WORK_MSG() {
	}

	public WF_WORK_MSG(int WORK_ACTIVITY_ID, byte RECEIVER_TYPE, int RECEIVER_ID) {
		this.WORK_ACTIVITY_ID 		= WORK_ACTIVITY_ID;
		this.RECEIVER_TYPE 			= RECEIVER_TYPE;
		this.RECEIVER_ID 			= RECEIVER_ID;
	}

	public WF_WORK_MSG(int WORK_ACTIVITY_ID, byte RECEIVER_TYPE, int RECEIVER_ID,
			String RECEIVER_NAME, String SEND_CONTENT, Date SEND_DATE,
			Date RECEIVER_DATE, Byte RECEIVER_FLAG) {
		this.WORK_ACTIVITY_ID 	= WORK_ACTIVITY_ID;
		this.RECEIVER_TYPE 		= RECEIVER_TYPE;
		this.RECEIVER_ID 		= RECEIVER_ID;
		this.RECEIVER_NAME 		= RECEIVER_NAME;
		this.SEND_CONTENT 		= SEND_CONTENT;
		this.SEND_DATE 			= SEND_DATE;
		this.RECEIVER_DATE 		= RECEIVER_DATE;
		this.RECEIVER_FLAG 		= RECEIVER_FLAG;
	}

	public Integer getWORK_MSG_ID() {
		return WORK_MSG_ID;
	}

	public void setWORK_MSG_ID(Integer WORK_MSG_ID) {
		this.WORK_MSG_ID 		= WORK_MSG_ID;
	}

	public int getWORK_ACTIVITY_ID() {
		return WORK_ACTIVITY_ID;
	}

	public void setWORK_ACTIVITY_ID(int WORK_ACTIVITY_ID) {
		this.WORK_ACTIVITY_ID 	= WORK_ACTIVITY_ID;
	}

	public int getRECEIVER_TYPE() {
		return RECEIVER_TYPE;
	}

	public void setRECEIVER_TYPE(int RECEIVER_TYPE) {
		this.RECEIVER_TYPE 		= RECEIVER_TYPE;
	}

	public int getRECEIVER_ID() {
		return RECEIVER_ID;
	}

	public void setRECEIVER_ID(int RECEIVER_ID) {
		this.RECEIVER_ID 		= RECEIVER_ID;
	}

	public String getRECEIVER_NAME() {
		return RECEIVER_NAME;
	}

	public void setRECEIVER_NAME(String RECEIVER_NAME) {
		this.RECEIVER_NAME = RECEIVER_NAME;
	}

	public String getSEND_CONTENT() {
		return SEND_CONTENT;
	}

	public void setSEND_CONTENT(String SEND_CONTENT) {
		this.SEND_CONTENT 		= SEND_CONTENT;
	}

	public Date getSEND_DATE() {
		return SEND_DATE;
	}

	public void setSEND_DATE(Date SEND_DATE) {
		this.SEND_DATE 			= SEND_DATE;
	}

	public Date getRECEIVER_DATE() {
		return RECEIVER_DATE;
	}

	public void setRECEIVER_DATE(Date RECEIVER_DATE) {
		this.RECEIVER_DATE 		= RECEIVER_DATE;
	}

	public Byte getRECEIVER_FLAG() {
		return RECEIVER_FLAG;
	}

	public void setRECEIVER_FLAG(Byte RECEIVER_FLAG) {
		this.RECEIVER_FLAG 		= RECEIVER_FLAG;
	}


}

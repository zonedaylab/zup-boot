package cn.zup.workflow.model;

import java.util.Date;



public class WF_WORK_ITEM implements java.io.Serializable {

	private Integer 		WORK_ITEM_ID;
	private int 			WORK_ACTIVITY_ID;
	private int 			RECEIVER_TYPE;
	private int 			RECEIVER_ID;
	private String 			RECEIVER_NAME;
	private String 			CONTENT;
	private Date 			WORK_ITEM_DATETIME;
	private int 			WORK_ITEM_STATE;
	private Integer 		RESPONSIBLE_ID;
	private String 			SIGN_NAME;
	private Date 			SIGN_DATE;
	private String 			SIGN_OPINION;

	public WF_WORK_ITEM() {
	}

	public WF_WORK_ITEM(int WORK_ACTIVITY_ID, int RECEIVER_ID) {
		this.WORK_ACTIVITY_ID 	= WORK_ACTIVITY_ID;
		this.RECEIVER_ID 		= RECEIVER_ID;
	}

	public WF_WORK_ITEM(int WORK_ACTIVITY_ID, Byte RECEIVER_TYPE, int RECEIVER_ID,
			String RECEIVER_NAME, String CONTENT, Date WORK_ITEM_DATETIME,
			Byte WORK_ITEM_STATE, Integer RESPONSIBLE_ID, String SIGN_NAME,
			Date SIGN_DATE, String SIGN_OPINION) {
		this.WORK_ACTIVITY_ID 		= WORK_ACTIVITY_ID;
		this.RECEIVER_TYPE 			= RECEIVER_TYPE;
		this.RECEIVER_ID 			= RECEIVER_ID;
		this.RECEIVER_NAME 			= RECEIVER_NAME;
		this.CONTENT 				= CONTENT;
		this.WORK_ITEM_DATETIME 	= WORK_ITEM_DATETIME;
		this.WORK_ITEM_STATE 		= WORK_ITEM_STATE;
		this.RESPONSIBLE_ID 		= RESPONSIBLE_ID;
		this.SIGN_NAME 				= SIGN_NAME;
		this.SIGN_DATE 				= SIGN_DATE;
		this.SIGN_OPINION 			= SIGN_OPINION;
	}

	public Integer getWORK_ITEM_ID() {
		return WORK_ITEM_ID;
	}

	public void setWORK_ITEM_ID(Integer WORK_ITEM_ID) {
		this.WORK_ITEM_ID 			= WORK_ITEM_ID;
	}

	public int getWORK_ACTIVITY_ID() {
		return WORK_ACTIVITY_ID;
	}

	public void setWORK_ACTIVITY_ID(int WORK_ACTIVITY_ID) {
		this.WORK_ACTIVITY_ID 		= WORK_ACTIVITY_ID;
	}

	public int getRECEIVER_TYPE() {
		return RECEIVER_TYPE;
	}

	public void setRECEIVER_TYPE(int RECEIVER_TYPE) {
		this.RECEIVER_TYPE 			= RECEIVER_TYPE;
	}

	public int getRECEIVER_ID() {
		return RECEIVER_ID;
	}

	public void setRECEIVER_ID(int RECEIVER_ID) {
		this.RECEIVER_ID 			= RECEIVER_ID;
	}

	public String getRECEIVER_NAME() {
		return RECEIVER_NAME;
	}

	public void setRECEIVER_NAME(String RECEIVER_NAME) {
		this.RECEIVER_NAME 			= RECEIVER_NAME;
	}

	public String getCONTENT() {
		return CONTENT;
	}

	public void setCONTENT(String CONTENT) {
		this.CONTENT 				= CONTENT;
	}

	public Date getWORK_ITEM_DATETIME() {
		return WORK_ITEM_DATETIME;
	}

	public void setWORK_ITEM_DATETIME(Date WORK_ITEM_DATETIME) {
		this.WORK_ITEM_DATETIME 	= WORK_ITEM_DATETIME;
	}

	public int getWORK_ITEM_STATE() {
		return WORK_ITEM_STATE;
	}

	public void setWORK_ITEM_STATE(Byte WORK_ITEM_STATE) {
		this.WORK_ITEM_STATE 		= WORK_ITEM_STATE;
	}

	public Integer getRESPONSIBLE_ID() {
		return RESPONSIBLE_ID;
	}

	public void setRESPONSIBLE_ID(Integer RESPONSIBLE_ID) {
		this.RESPONSIBLE_ID 		= RESPONSIBLE_ID;
	}

	public String getSIGN_NAME() {
		return SIGN_NAME;
	}

	public void setSIGN_NAME(String SIGN_NAME) {
		this.SIGN_NAME 				= SIGN_NAME;
	}

	public Date getSIGN_DATE() {
		return SIGN_DATE;
	}

	public void setSIGN_DATE(Date SIGN_DATE) {
		this.SIGN_DATE 				= SIGN_DATE;
	}

	public String getSIGN_OPINION() {
		return SIGN_OPINION;
	}

	public void setSIGN_OPINION(String SIGN_OPINION) {
		this.SIGN_OPINION 			= SIGN_OPINION;
	}

}

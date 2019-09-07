package cn.zup.workflow.model;


import java.sql.Date;
public class WF_ATTACH implements java.io.Serializable {

	private Integer 		ATTACH_ID;
	private int 			WORK_ITEM_ID;
	private String 			ATTACH_NAME;
	private String 			ATTACH_PATH;
	private String 			HANDLER_NAME;
	private Date 			UPLOAD_DATETIME;

	public WF_ATTACH() {
	}

	public WF_ATTACH(int WORK_ITEM_ID, Date UPLOAD_DATETIME) {
		this.WORK_ITEM_ID 		= WORK_ITEM_ID;
		this.UPLOAD_DATETIME 	= UPLOAD_DATETIME;
	}

	public WF_ATTACH(int WORK_ITEM_ID, String ATTACH_NAME, String ATTACH_PATH,
			String HANDLER_NAME, Date UPLOAD_DATETIME) {
		this.WORK_ITEM_ID 		= WORK_ITEM_ID;
		this.ATTACH_NAME 		= ATTACH_NAME;
		this.ATTACH_PATH 		= ATTACH_PATH;
		this.HANDLER_NAME 		= HANDLER_NAME;
		this.UPLOAD_DATETIME 	= UPLOAD_DATETIME;
	}

	public Integer getATTACH_ID() {
		return ATTACH_ID;
	}

	public void setATTACH_ID(Integer ATTACH_ID) {
		this.ATTACH_ID 			= ATTACH_ID;
	}

	public int getWORK_ITEM_ID() {
		return WORK_ITEM_ID;
	}

	public void setWORK_ITEM_ID(int WORK_ITEM_ID) {
		this.WORK_ITEM_ID 		= WORK_ITEM_ID;
	}

	public String getATTACH_NAME() {
		return ATTACH_NAME;
	}

	public void setATTACH_NAME(String ATTACH_NAME) {
		this.ATTACH_NAME 		= ATTACH_NAME;
	}

	public String getATTACH_PATH() {
		return ATTACH_PATH;
	}

	public void setATTACH_PATH(String ATTACH_PATH) {
		this.ATTACH_PATH 		= ATTACH_PATH;
	}

	public String getHANDLER_NAME() {
		return HANDLER_NAME;
	}

	public void setHANDLER_NAME(String HANDLER_NAME) {
		this.HANDLER_NAME 		= HANDLER_NAME;
	}

	public Date getUPLOAD_DATETIME() {
		return UPLOAD_DATETIME;
	}

	public void setUPLOAD_DATETIME(Date UPLOAD_DATETIME) {
		this.UPLOAD_DATETIME 	= UPLOAD_DATETIME;
	}

	

}

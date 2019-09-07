package cn.zup.workflow.model;


import java.beans.Transient;
import java.util.Date;

public class WF_WORK implements java.io.Serializable {

	private int 	WORK_ID;
	private int 		FLOW_ID;
	private String 		WORK_NAME;
	private int 		WORK_STATE;
	private int 		SPONSOR_ID;
	private String 		SPONSOR_NAME;
	private Date 		CREATE_DATETIME;
	private String 		MAIN_BIZ_KEY;
	private int 	PARENT_WORK_ID;
	private int 	PARENT_ACTIVITY_ID;
	
	private String WORK_STATE_NAME;
	private String FLOW_NAME;
	private Integer SYSTEM_ID;
	private String SYSTEM_NAME;
	private Integer ACTIVITY_ID;
	private String ACTIVITY_NAME;
		

	public WF_WORK() {
	}

	public WF_WORK(int FLOW_ID, byte WORK_STATE, int SPONSOR_ID, Date CREATE_DATETIME) {
		this.FLOW_ID 			= FLOW_ID;
		this.WORK_STATE 		= WORK_STATE;
		this.SPONSOR_ID 		= SPONSOR_ID;
		this.CREATE_DATETIME 	= CREATE_DATETIME;
	}

	public WF_WORK(int FLOW_ID, String WORK_NAME, byte WORK_STATE, int SPONSOR_ID,
			String SPONSOR_NAME, Date CREATE_DATETIME, String MAIN_BIZ_KEY,
			int PARENT_WORK_ID, int PARENT_ACTIVITY_ID) {
		this.FLOW_ID 				= FLOW_ID;
		this.WORK_NAME 				= WORK_NAME;
		this.WORK_STATE 			= WORK_STATE;
		this.SPONSOR_ID 			= SPONSOR_ID;
		this.SPONSOR_NAME 			= SPONSOR_NAME;
		this.CREATE_DATETIME 		= CREATE_DATETIME;
		this.MAIN_BIZ_KEY 			= MAIN_BIZ_KEY;
		this.PARENT_WORK_ID 		= PARENT_WORK_ID;
		this.PARENT_ACTIVITY_ID 	= PARENT_ACTIVITY_ID;
	}

	public int getWORK_ID() {
		return WORK_ID;
	}

	public void setWORK_ID(int WORK_ID) {
		this.WORK_ID 				= WORK_ID;
	}

	public int getFLOW_ID() {
		return FLOW_ID;
	}

	public void setFLOW_ID(int FLOW_ID) {
		this.FLOW_ID 				= FLOW_ID;
	}

	public String getWORK_NAME() {
		return WORK_NAME;
	}

	public void setWORK_NAME(String WORK_NAME) {
		this.WORK_NAME 				= WORK_NAME;
	}

	public int getWORK_STATE() {
		return WORK_STATE;
	}

	public void setWORK_STATE(int WORK_STATE) {
		this.WORK_STATE 			= WORK_STATE;
	}

	public int getSPONSOR_ID() {
		return SPONSOR_ID;
	}

	public void setSPONSOR_ID(int SPONSOR_ID) {
		this.SPONSOR_ID 			= SPONSOR_ID;
	}

	public String getSPONSOR_NAME() {
		return SPONSOR_NAME;
	}

	public void setSPONSOR_NAME(String SPONSOR_NAME) {
		this.SPONSOR_NAME 			= SPONSOR_NAME;
	}

	public Date getCREATE_DATETIME() {
		return CREATE_DATETIME;
	}

	public void setCREATE_DATETIME(Date CREATE_DATETIME) {
		this.CREATE_DATETIME 		= CREATE_DATETIME;
	}

	public String getMAIN_BIZ_KEY() {
		return MAIN_BIZ_KEY;
	}

	public void setMAIN_BIZ_KEY(String MAIN_BIZ_KEY) {
		this.MAIN_BIZ_KEY 			= MAIN_BIZ_KEY;
	}

	public int getPARENT_WORK_ID() {
		return PARENT_WORK_ID;
	}

	public void setPARENT_WORK_ID(int PARENT_WORK_ID) {
		this.PARENT_WORK_ID 		= PARENT_WORK_ID;
	}

	public int getPARENT_ACTIVITY_ID() {
		return PARENT_ACTIVITY_ID;
	}

	public void setPARENT_ACTIVITY_ID(int PARENT_ACTIVITY_ID) {
		this.PARENT_ACTIVITY_ID 	= PARENT_ACTIVITY_ID;
	}

	@Transient
	public String getWORK_STATE_NAME() {
		return WORK_STATE_NAME;
	}

	public void setWORK_STATE_NAME(String wORKSTATENAME) {
		WORK_STATE_NAME = wORKSTATENAME;
	}
	@Transient
	public String getFLOW_NAME() {
		return FLOW_NAME;
	}

	public void setFLOW_NAME(String fLOWNAME) {
		FLOW_NAME = fLOWNAME;
	}
	@Transient
	public Integer getSYSTEM_ID() {
		return SYSTEM_ID;
	}

	public void setSYSTEM_ID(Integer sYSTEMID) {
		SYSTEM_ID = sYSTEMID;
	}
	@Transient
	public String getSYSTEM_NAME() {
		return SYSTEM_NAME;
	}

	public void setSYSTEM_NAME(String sYSTEMNAME) {
		SYSTEM_NAME = sYSTEMNAME;
	}
	@Transient
	public Integer getACTIVITY_ID() {
		return ACTIVITY_ID;
	}

	public void setACTIVITY_ID(Integer aCTIVITYID) {
		ACTIVITY_ID = aCTIVITYID;
	}
	@Transient
	public String getACTIVITY_NAME() {
		return ACTIVITY_NAME;
	}

	public void setACTIVITY_NAME(String aCTIVITYNAME) {
		ACTIVITY_NAME = aCTIVITYNAME;
	}
}

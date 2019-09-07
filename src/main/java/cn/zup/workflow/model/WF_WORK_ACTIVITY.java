package cn.zup.workflow.model;


import java.sql.Date;

import javax.persistence.Transient;

public class WF_WORK_ACTIVITY implements java.io.Serializable {

	private Integer 		WORK_ACTIVITY_ID;
	private int 			WORK_ID;
	private int 			ACTIVITY_ID;
	private Integer 		WORK_ACTIVITY_STATE;
	private Date 			CREATE_DATETIME;
	private Date 			FINISHED_DATETIME;
	private String 			PRE_ACTIVITY_INFO;
	private String 			NEXT_ACTIVITY_HANDLERS;
	private String 			NEXT_ACTIVITY_CODES;
	//扩展字段
	private Integer Flow_ID;//流程id
	public WF_WORK_ACTIVITY() {
	}

	public WF_WORK_ACTIVITY(int WORK_ID, int ACTIVITY_ID, Date CREATE_DATETIME) {
		this.WORK_ID 			= WORK_ID;
		this.ACTIVITY_ID 		= ACTIVITY_ID;
		this.CREATE_DATETIME 	= CREATE_DATETIME;
	}

	public WF_WORK_ACTIVITY(int WORK_ID, int ACTIVITY_ID,
			Integer WORK_ACTIVITY_STATE, Date CREATE_DATETIME,
			Date FINISHED_DATETIME, String PRE_ACTIVITY_INFO,
			String NEXT_ACTIVITY_HANDLERS, String NEXT_ACTIVITY_CODES) {
		this.WORK_ID 				= WORK_ID;
		this.ACTIVITY_ID 			= ACTIVITY_ID;
		this.WORK_ACTIVITY_STATE 	= WORK_ACTIVITY_STATE;
		this.CREATE_DATETIME 		= CREATE_DATETIME;
		this.FINISHED_DATETIME 		= FINISHED_DATETIME;
		this.PRE_ACTIVITY_INFO 		= PRE_ACTIVITY_INFO;
		this.NEXT_ACTIVITY_HANDLERS = NEXT_ACTIVITY_HANDLERS;
		this.NEXT_ACTIVITY_CODES 	= NEXT_ACTIVITY_CODES;
	}

	public Integer getWORK_ACTIVITY_ID() {
		return WORK_ACTIVITY_ID;
	}

	public void setWORK_ACTIVITY_ID(Integer wORK_ACTIVITY_ID) {
		WORK_ACTIVITY_ID 			= wORK_ACTIVITY_ID;
	}

	public int getWORK_ID() {
		return WORK_ID;
	}

	public void setWORK_ID(int wORK_ID) {
		WORK_ID 					= wORK_ID;
	}

	public int getACTIVITY_ID() {
		return ACTIVITY_ID;
	}

	public void setACTIVITY_ID(int ACTIVITY_ID) {
		this.ACTIVITY_ID 			= ACTIVITY_ID;
	}

	public Integer getWORK_ACTIVITY_STATE() {
		return WORK_ACTIVITY_STATE;
	}

	public void setWORK_ACTIVITY_STATE(Integer WORK_ACTIVITY_STATE) {
		this.WORK_ACTIVITY_STATE 	= WORK_ACTIVITY_STATE;
	}

	public java.sql.Date getCREATE_DATETIME() {
		return CREATE_DATETIME;
	}

	public void setCREATE_DATETIME(Date CREATE_DATETIME) {
		this.CREATE_DATETIME 		= CREATE_DATETIME;
	}

	public Date getFINISHED_DATETIME() {
		return FINISHED_DATETIME;
	}

	public void setFINISHED_DATETIME(Date FINISHED_DATETIME) {
		this.FINISHED_DATETIME 		= FINISHED_DATETIME;
	}

	public String getPRE_ACTIVITY_INFO() {
		return PRE_ACTIVITY_INFO;
	}

	public void setPRE_ACTIVITY_INFO(String PRE_ACTIVITY_INFO) {
		this.PRE_ACTIVITY_INFO 		= PRE_ACTIVITY_INFO;
	}

	public String getNEXT_ACTIVITY_HANDLERS() {
		return NEXT_ACTIVITY_HANDLERS;
	}

	public void setNEXT_ACTIVITY_HANDLERS(String NEXT_ACTIVITY_HANDLERS) {
		this.NEXT_ACTIVITY_HANDLERS = NEXT_ACTIVITY_HANDLERS;
	}

	public String getNEXT_ACTIVITY_CODES() {
		return NEXT_ACTIVITY_CODES;
	}

	public void setNEXT_ACTIVITY_CODES(String NEXT_ACTIVITY_CODES) {
		this.NEXT_ACTIVITY_CODES 	= NEXT_ACTIVITY_CODES;
	}
	@Transient
	public Integer getFlow_ID() {
		return Flow_ID;
	}

	public void setFlow_ID(Integer flow_ID) {
		Flow_ID = flow_ID;
	}

}

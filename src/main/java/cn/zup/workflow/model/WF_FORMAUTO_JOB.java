package cn.zup.workflow.model;

import java.util.Date;

public class WF_FORMAUTO_JOB {
	private Integer 	JOBID;
	private String 		DATA_NAME;
	private Date 		CREATE_DATE;
	private Integer 	USER_ID;
	private String 		USER_NAME;
	private Integer 	FORM_ID;
	
	public Integer getJOBID() {
		return JOBID;
	}
	public void setJOBID(Integer jOBID) {
		JOBID = jOBID;
	}
	public String getDATA_NAME() {
		return DATA_NAME;
	}
	public void setDATA_NAME(String dATANAME) {
		DATA_NAME = dATANAME;
	}
	public Date getCREATE_DATE() {
		return CREATE_DATE;
	}
	public void setCREATE_DATE(Date cREATEDATE) {
		CREATE_DATE = cREATEDATE;
	}
	public Integer getUSER_ID() {
		return USER_ID;
	}
	public void setUSER_ID(Integer uSERID) {
		USER_ID = uSERID;
	}
	public String getUSER_NAME() {
		return USER_NAME;
	}
	public void setUSER_NAME(String uSERNAME) {
		USER_NAME = uSERNAME;
	}
	public Integer getFORM_ID() {
		return FORM_ID;
	}
	public void setFORM_ID(Integer fORMID) {
		FORM_ID = fORMID;
	}

	
	
}

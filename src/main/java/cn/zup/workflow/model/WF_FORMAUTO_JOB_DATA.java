package cn.zup.workflow.model;


public class WF_FORMAUTO_JOB_DATA {
	private Integer 	JOB_ID;
	private Integer 		CONTROL_ID;
	private String 		VALUE;	
	private String 		CONTROL_NAME;
	
	public Integer getJOB_ID() {
		return JOB_ID;
	}
	public void setJOB_ID(Integer jOBID) {
		JOB_ID = jOBID;
	}
	public Integer getCONTROL_ID() {
		return CONTROL_ID;
	}
	public void setCONTROL_ID(Integer cONTROLID) {
		CONTROL_ID = cONTROLID;
	}
	public String getVALUE() {
		return VALUE;
	}
	public void setVALUE(String vALUE) {
		VALUE = vALUE;
	}
	public String getCONTROL_NAME() {
		return CONTROL_NAME;
	}
	public void setCONTROL_NAME(String cONTROLNAME) {
		CONTROL_NAME = cONTROLNAME;
	}
}

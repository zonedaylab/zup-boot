package cn.zup.workflow.model;

import java.sql.Date;
public class WF_ENTRUST implements java.io.Serializable {

	private Integer 		ENTRUST_ID;
	private int 			ENTRUST_PEOPLE_ID;
	private String 			ENTRUST_PEOPLE_NAME;
	private int 			TRUST_PEOPLE_ID;
	private String 			TRUST_PEOPLE_NAME;
	private Date 			TIME;
	private int 			STATE;

	public WF_ENTRUST() {
	}

	public WF_ENTRUST(int ENTRUST_PEOPLE_ID, int TRUST_PEOPLE_ID, Date TIME,
			byte STATE) {
		this.ENTRUST_PEOPLE_ID 	= ENTRUST_PEOPLE_ID;
		this.TRUST_PEOPLE_ID 	= TRUST_PEOPLE_ID;
		this.TIME 				= TIME;
		this.STATE 				= STATE;
	}

	public WF_ENTRUST(int ENTRUST_PEOPLE_ID, String ENTRUST_PEOPLE_NAME,
			int TRUST_PEOPLE_ID, String TRUST_PEOPLE_NAME, Date TIME, byte STATE) {
		this.ENTRUST_PEOPLE_ID 		= ENTRUST_PEOPLE_ID;
		this.ENTRUST_PEOPLE_NAME 	= ENTRUST_PEOPLE_NAME;
		this.TRUST_PEOPLE_ID 		= TRUST_PEOPLE_ID;
		this.TRUST_PEOPLE_NAME 		= TRUST_PEOPLE_NAME;
		this.TIME 					= TIME;
		this.STATE 					= STATE;
	}

	public Integer getENTRUST_ID() {
		return ENTRUST_ID;
	}

	public void setENTRUST_ID(Integer ENTRUST_ID) {
		this.ENTRUST_ID 			= ENTRUST_ID;
	}

	public int getENTRUST_PEOPLE_ID() {
		return ENTRUST_PEOPLE_ID;
	}

	public void setENTRUST_PEOPLE_ID(int ENTRUST_PEOPLE_ID) {
		this.ENTRUST_PEOPLE_ID 		= ENTRUST_PEOPLE_ID;
	}

	public String getENTRUST_PEOPLE_NAME() {
		return ENTRUST_PEOPLE_NAME;
	}

	public void setENTRUST_PEOPLE_NAME(String ENTRUST_PEOPLE_NAME) {
		this.ENTRUST_PEOPLE_NAME 	= ENTRUST_PEOPLE_NAME;
	}

	public int getTRUST_PEOPLE_ID() {
		return TRUST_PEOPLE_ID;
	}

	public void setTRUST_PEOPLE_ID(int TRUST_PEOPLE_ID) {
		this.TRUST_PEOPLE_ID 		= TRUST_PEOPLE_ID;
	}

	public String getTRUST_PEOPLE_NAME() {
		return TRUST_PEOPLE_NAME;
	}

	public void setTRUST_PEOPLE_NAME(String TRUST_PEOPLE_NAME) {
		this.TRUST_PEOPLE_NAME 		= TRUST_PEOPLE_NAME;
	}

	public Date getTIME() {
		return TIME;
	}

	public void setTIME(Date TIME) {
		this.TIME 					= TIME;
	}

	public int getSTATE() {
		return STATE;
	}

	public void setSTATE(int STATE) {
		this.STATE 					= STATE;
	}

	

}

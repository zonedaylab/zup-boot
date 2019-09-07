package cn.zup.workflow.model;


import java.sql.Date;

public class WF_LOG implements java.io.Serializable {

	private Integer 		ID;
	private Integer 		ERROR_NUMBER;
	private Integer 		ERROR_SEVERITY;
	private String 			ERROR_STATE;
	private String 			ERROR_PROCEDURE;
	private Integer 			ERROR_LINE;
	private String 			ERROR_MESSAGE;
	private Date 			HAPPEN_DATE;

	public WF_LOG() {
	}

	public WF_LOG(Integer ERROR_NUMBER, Integer ERROR_SEVERITY, String ERROR_STATE,
			String ERROR_PROCEDURE, Integer ERROR_LINE, String ERROR_MESSAGE,
			Date HAPPEN_DATE) {
		this.ERROR_NUMBER 		= ERROR_NUMBER;
		this.ERROR_SEVERITY 	= ERROR_SEVERITY;
		this.ERROR_STATE 		= ERROR_STATE;
		this.ERROR_PROCEDURE 	= ERROR_PROCEDURE;
		this.ERROR_LINE 		= ERROR_LINE;
		this.ERROR_MESSAGE 		= ERROR_MESSAGE;
		this.HAPPEN_DATE 		= HAPPEN_DATE;
	}

	public Integer getID() {
		return ID;
	}

	public void setID(Integer ID) {
		this.ID 				= ID;
	}

	public Integer getERROR_NUMBER() {
		return ERROR_NUMBER;
	}

	public void setERROR_NUMBER(Integer ERROR_NUMBER) {
		this.ERROR_NUMBER 		= ERROR_NUMBER;
	}

	public Integer getERROR_SEVERITY() {
		return ERROR_SEVERITY;
	}

	public void setERROR_SEVERITY(Integer ERROR_SEVERITY) {
		this.ERROR_SEVERITY 	= ERROR_SEVERITY;
	}

	public String getERROR_STATE() {
		return ERROR_STATE;
	}

	public void setERROR_STATE(String ERROR_STATE) {
		this.ERROR_STATE 		= ERROR_STATE;
	}

	public String getERROR_PROCEDURE() {
		return ERROR_PROCEDURE;
	}

	public void setERROR_PROCEDURE(String ERROR_PROCEDURE) {
		this.ERROR_PROCEDURE 	= ERROR_PROCEDURE;
	}

	public Integer getERROR_LINE() {
		return ERROR_LINE;
	}

	public void setERROR_LINE(Integer ERROR_LINE) {
		this.ERROR_LINE 		= ERROR_LINE;
	}

	public String getERROR_MESSAGE() {
		return ERROR_MESSAGE;
	}

	public void setERROR_MESSAGE(String ERROR_MESSAGE) {
		this.ERROR_MESSAGE 		= ERROR_MESSAGE;
	}

	public Date getHAPPEN_DATE() {
		return HAPPEN_DATE;
	}

	public void setHAPPEN_DATE(Date HAPPEN_DATE) {
		this.HAPPEN_DATE 		= HAPPEN_DATE;
	}


}

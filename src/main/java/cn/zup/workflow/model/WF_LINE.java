package cn.zup.workflow.model;

public class WF_LINE implements java.io.Serializable {

	private Integer 	LINE_ID;
	private int 		FLOW_ID;
	private Integer 	BEGIN_CODE;
	private Integer 	END_CODE;
	private String 		LINE_CONTENT;
	private String 		LINE_INFLECTION;
	private String 		LINE_CODE;
	private String 		LINE_NAME;

	public WF_LINE() {
	}

	public WF_LINE(int LINE_ID) {
		this.LINE_ID 	= LINE_ID;
	}

	public WF_LINE(int FLOW_ID, Integer BEGIN_CODE, Integer END_CODE,
			String LINE_CONTENT) {
		this.FLOW_ID 		= FLOW_ID;
		this.BEGIN_CODE 	= BEGIN_CODE;
		this.END_CODE 		= END_CODE;
		this.LINE_CONTENT 	= LINE_CONTENT;
	}

	public Integer getLINE_ID() {
		return LINE_ID;
	}

	public void setLINE_ID(Integer LINE_ID) {
		this.LINE_ID 		= LINE_ID;
	}

	public int getFLOW_ID() {
		return FLOW_ID;
	}

	public void setFLOW_ID(int FLOW_ID) {
		this.FLOW_ID 		= FLOW_ID;
	}

	public Integer getBEGIN_CODE() {
		return BEGIN_CODE;
	}

	public void setBEGIN_CODE(Integer BEGIN_CODE) {
		this.BEGIN_CODE 	= BEGIN_CODE;
	}

	public Integer getEND_CODE() {
		return END_CODE;
	}

	public void setEND_CODE(Integer END_CODE) {
		this.END_CODE 		= END_CODE;
	}

	public String getLINE_CONTENT() {
		return LINE_CONTENT;
	}

	public void setLINE_CONTENT(String LINE_CONTENT) {
		this.LINE_CONTENT 	= LINE_CONTENT;
	}

	public void setLINE_INFLECTION(String lINE_INFLECTION) {
		LINE_INFLECTION = lINE_INFLECTION;
	}

	public String getLINE_INFLECTION() {
		return LINE_INFLECTION;
	}

	public void setLINE_CODE(String lINE_CODE) {
		LINE_CODE = lINE_CODE;
	}

	public String getLINE_CODE() {
		return LINE_CODE;
	}

	public void setLINE_NAME(String lINE_NAME) {
		LINE_NAME = lINE_NAME;
	}

	public String getLINE_NAME() {
		return LINE_NAME;
	}


}

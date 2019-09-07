package cn.zup.workflow.model;

import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import org.hibernate.annotations.GenericGenerator;

public class WF_FLOW implements java.io.Serializable {

	private int 		FLOW_ID;
	private int 		SYSTEM_ID;
	private String 			FLOW_NAME;
	private String 			FLOW_TYPE;
	private int 			FLOW_STATE;

	public WF_FLOW() {
	}

	public WF_FLOW(String FLOW_NAME, String FLOW_TYPE, byte FLOW_STATE) {
		this.FLOW_NAME 		= FLOW_NAME;
		this.FLOW_TYPE 		= FLOW_TYPE;
		this.FLOW_STATE 	= FLOW_STATE;
	}

	public WF_FLOW(int SYSTEM_ID, String FLOW_NAME, String FLOW_TYPE,
			byte FLOW_STATE) {
		this.SYSTEM_ID 		= SYSTEM_ID;
		this.FLOW_NAME 		= FLOW_NAME;
		this.FLOW_TYPE 		= FLOW_TYPE;
		this.FLOW_STATE 	= FLOW_STATE;
	}

	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public int getFLOW_ID() {
		return FLOW_ID;
	}

	public void setFLOW_ID(int FLOW_ID) {
		this.FLOW_ID 		= FLOW_ID;
	}

	public int getSYSTEM_ID() {
		return SYSTEM_ID;
	}

	public void setSYSTEM_ID(int SYSTEM_ID) {
		this.SYSTEM_ID 		= SYSTEM_ID;
	}

	public String getFLOW_NAME() {
		return FLOW_NAME;
	}

	public void setFLOW_NAME(String FLOW_NAME) {
		this.FLOW_NAME 		= FLOW_NAME;
	}

	public String getFLOW_TYPE() {
		return FLOW_TYPE;
	}

	public void setFLOW_TYPE(String FLOW_TYPE) {
		this.FLOW_TYPE 		= FLOW_TYPE;
	}

	public int getFLOW_STATE() {
		return FLOW_STATE;
	}

	public void setFLOW_STATE(int fLOWSTATE) {
		FLOW_STATE = fLOWSTATE;
	}

	

}

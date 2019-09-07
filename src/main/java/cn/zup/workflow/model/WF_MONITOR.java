package cn.zup.workflow.model;

public class WF_MONITOR implements java.io.Serializable {

	private Integer 	MONITOR_ID;
	private int 		FLOW_ID;
	private Integer 	MONITOR;
	private int 		MONITOR_TYPE;

	public WF_MONITOR() {
	}

	public WF_MONITOR(int FLOW_ID) {
		this.FLOW_ID 	= FLOW_ID;
	}

	public WF_MONITOR(int FLOW_ID, Integer MONITOR, Byte MONITOR_TYPE) {
		this.FLOW_ID 		= FLOW_ID;
		this.MONITOR 		= MONITOR;
		this.MONITOR_TYPE 	= MONITOR_TYPE;
	}

	public Integer getMONITOR_ID() {
		return MONITOR_ID;
	}

	public void setMONITOR_ID(Integer MONITOR_ID) {
		this.MONITOR_ID 	= MONITOR_ID;
	}

	public int getFLOW_ID() {
		return FLOW_ID;
	}

	public void setFLOW_ID(int FLOW_ID) {
		this.FLOW_ID 		= FLOW_ID;
	}

	public Integer getMONITOR() {
		return MONITOR;
	}

	public void setMONITOR(Integer MONITOR) {
		this.MONITOR 		= MONITOR;
	}

	public int getMONITOR_TYPE() {
		return MONITOR_TYPE;
	}

	public void setMONITOR_TYPE(int MONITOR_TYPE) {
		this.MONITOR_TYPE 	= MONITOR_TYPE;
	}


}

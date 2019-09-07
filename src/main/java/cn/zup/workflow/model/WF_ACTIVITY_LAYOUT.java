package cn.zup.workflow.model;

public class WF_ACTIVITY_LAYOUT implements java.io.Serializable {

	private int 	ACTIVITY_ID;
	private Float 	TOP_MARGIN;
	private Float 	LEFT_MARGIN;

	public WF_ACTIVITY_LAYOUT() {
	}

	public WF_ACTIVITY_LAYOUT(int ACTIVITY_ID) {
		this.ACTIVITY_ID 	= ACTIVITY_ID;
	}

	public WF_ACTIVITY_LAYOUT(int ACTIVITY_ID, Float TOP_MARGIN, Float LEFT_MARGIN) {
		this.ACTIVITY_ID 	= ACTIVITY_ID;
		this.TOP_MARGIN 	= TOP_MARGIN;
		this.LEFT_MARGIN 	= LEFT_MARGIN;
	}

	public int getACTIVITY_ID() {
		return ACTIVITY_ID;
	}

	public void setACTIVITY_ID(int ACTIVITY_ID) {
		this.ACTIVITY_ID 	= ACTIVITY_ID;
	}

	public Float getTOP_MARGIN() {
		return TOP_MARGIN;
	}

	public void setTOP_MARGIN(Float TOP_MARGIN) {
		this.TOP_MARGIN 	= TOP_MARGIN;
	}

	public Float getLEFT_MARGIN() {
		return LEFT_MARGIN;
	}

	public void setLEFT_MARGIN(Float LEFT_MARGIN) {
		this.LEFT_MARGIN 	= LEFT_MARGIN;
	}
	

}

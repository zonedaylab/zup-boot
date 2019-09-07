package cn.zup.workflow.model;

public class WF_ACTIVITY_POPEDOM_ID implements java.io.Serializable {

	private int ACTIVITY_ID;
	private int CONTROL_ID;

	public WF_ACTIVITY_POPEDOM_ID() {
	}

	public WF_ACTIVITY_POPEDOM_ID(int ACTIVITY_ID, int CONTROL_ID) {
		this.ACTIVITY_ID 	= ACTIVITY_ID;
		this.CONTROL_ID 	= CONTROL_ID;
	}

	public int getACTIVITY_ID() {
		return ACTIVITY_ID;
	}

	public void setACTIVITY_ID(int ACTIVITY_ID) {
		this.ACTIVITY_ID 	= ACTIVITY_ID;
	}

	public int getCONTROL_ID() {
		return CONTROL_ID;
	}

	public void setCONTROL_ID(int CONTROL_ID) {
		this.CONTROL_ID 	= CONTROL_ID;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof WF_ACTIVITY_POPEDOM_ID))
			return false;
		WF_ACTIVITY_POPEDOM_ID castOther = (WF_ACTIVITY_POPEDOM_ID) other;

		return (	this.getACTIVITY_ID() 		== castOther.getACTIVITY_ID())
				&& (this.getCONTROL_ID() 	== castOther.getCONTROL_ID());
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result + this.getACTIVITY_ID();
		result = 37 * result + this.getCONTROL_ID();
		return result;
	}

}

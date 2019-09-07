package cn.zup.workflow.model;

public class WF_CONFIG_ID implements java.io.Serializable {

	private int 		ID;
	private int 		SUB_ID;

	public WF_CONFIG_ID() {
	}

	public WF_CONFIG_ID(int ID, int SUB_ID) {
		this.ID 		= ID;
		this.SUB_ID 	= SUB_ID;
	}


	public int getID() {
		return ID;
	}

	public void setID(int ID) {
		this.ID 		= ID;
	}

	public int getSUB_ID() {
		return SUB_ID;
	}

	public void setSUB_ID(int SUB_ID) {
		this.SUB_ID 	= SUB_ID;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof WF_CONFIG_ID))
			return false;
		WF_CONFIG_ID castOther = (WF_CONFIG_ID) other;

		return (	this.getID() 		== castOther.getID())
				&& (this.getSUB_ID() 	== castOther.getSUB_ID());
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result + this.getID();
		result = 37 * result + this.getSUB_ID();
		return result;
	}

}

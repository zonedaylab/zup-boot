package cn.zup.workflow.model;

public class WF_RULE implements java.io.Serializable {

	private Integer 		RULE_ID;
	private int 			ACTIVITY_ID;
	private int 			GOTO_ACTIVITY;
	private int 			CONTROL_ID;
	private int 			CONDITIONS;
	private String 			JUDGE_BASIS;

	public WF_RULE() {
	}

	public WF_RULE(int ACTIVITY_ID, int GOTO_ACTIVITY, int CONTROL_ID) {
		this.ACTIVITY_ID 		= ACTIVITY_ID;
		this.GOTO_ACTIVITY 		= GOTO_ACTIVITY;
		this.CONTROL_ID 		= CONTROL_ID;
	}

	public WF_RULE(int ACTIVITY_ID, int GOTO_ACTIVITY, int CONTROL_ID,
			Byte CONDITIONS, String JUDGE_BASIS) {
		this.ACTIVITY_ID 		= ACTIVITY_ID;
		this.GOTO_ACTIVITY 		= GOTO_ACTIVITY;
		this.CONTROL_ID 		= CONTROL_ID;
		this.CONDITIONS 		= CONDITIONS;
		this.JUDGE_BASIS 		= JUDGE_BASIS;
	}

	public Integer getRULE_ID() {
		return RULE_ID;
	}

	public void setRULE_ID(Integer RULE_ID) {
		this.RULE_ID 			= RULE_ID;
	}

	public int getACTIVITY_ID() {
		return ACTIVITY_ID;
	}

	public void setACTIVITY_ID(int ACTIVITY_ID) {
		this.ACTIVITY_ID 		= ACTIVITY_ID;
	}

	public int getGOTO_ACTIVITY() {
		return GOTO_ACTIVITY;
	}

	public void setGOTO_ACTIVITY(int GOTO_ACTIVITY) {
		this.GOTO_ACTIVITY 		= GOTO_ACTIVITY;
	}

	public int getCONTROL_ID() {
		return CONTROL_ID;
	}

	public void setCONTROL_ID(int CONTROL_ID) {
		this.CONTROL_ID 		= CONTROL_ID;
	}

	public int getCONDITIONS() {
		return CONDITIONS;
	}

	public void setCONDITIONS(int CONDITIONS) {
		this.CONDITIONS 		= CONDITIONS;
	}

	public String getJUDGE_BASIS() {
		return JUDGE_BASIS;
	}

	public void setJUDGE_BASIS(String JUDGE_BASIS) {
		this.JUDGE_BASIS 		= JUDGE_BASIS;
	}


}

package cn.zup.workflow.model;

public class WF_ACTIVITY implements java.io.Serializable {

	private Integer 		ACTIVITY_ID;
	private Integer 			FLOW_ID;
	private Integer 		FORM_ID;
	private Integer 		ACTIVITY_CODE;
	private String 			ACTIVITY_NAME;
	private Integer 			ACTIVITY_TYPE;
	private String 			NEXT_ACTIVITY_CODE;
	private Integer 		SUB_FLOW_ID;
	private Integer 			REVIEW_TYPE;
	private Integer 			REJECT_ACTIVITY_CODE;
	private Integer 		BRANCH_SEL_TYPE;
	private Integer 			HANDLER_SEL_TYPE;
	private Integer 		ACTIVITY_INTERVAL;
	private Integer 		ACTIVITY_PROPERTY;
	private Integer 		RELATION_NODE;
	private String     ACTIVITY_ICON;
	
	private int ACTIVITY_LEFT;
	private int ACTIVITY_TOP;
	

	public WF_ACTIVITY() {
	}

	public WF_ACTIVITY(int FLOW_ID, int REJECT_ACTIVITY_CODE) {
		this.FLOW_ID 				= FLOW_ID;
		this.REJECT_ACTIVITY_CODE 	= REJECT_ACTIVITY_CODE;
	}

	public WF_ACTIVITY(int FLOW_ID, int FORM_ID, int ACTIVITY_CODE,
			String ACTIVITY_NAME, int ACTIVITY_TYPE, String NEXT_ACTIVITY_CODE,
			int SUB_FLOW_ID, int REVIEW_TYPE, int REJECT_ACTIVITY_CODE,
			int BRANCH_SEL_TYPE, int HANDLER_SEL_TYPE,
			int ACTIVITY_INTERVAL, int ACTIVITY_PROPERTY,
			int RELATION_NODE) {
		this.FLOW_ID 				= FLOW_ID;
		this.FORM_ID 				= FORM_ID;
		this.ACTIVITY_CODE 			= ACTIVITY_CODE;
		this.ACTIVITY_NAME 			= ACTIVITY_NAME;
		this.ACTIVITY_TYPE 			= ACTIVITY_TYPE;
		this.NEXT_ACTIVITY_CODE 	= NEXT_ACTIVITY_CODE;
		this.SUB_FLOW_ID 			= SUB_FLOW_ID;
		this.REVIEW_TYPE 			= REVIEW_TYPE;
		this.REJECT_ACTIVITY_CODE 	= REJECT_ACTIVITY_CODE;
		this.BRANCH_SEL_TYPE 		= BRANCH_SEL_TYPE;
		this.HANDLER_SEL_TYPE 		= HANDLER_SEL_TYPE;
		this.ACTIVITY_INTERVAL 		= ACTIVITY_INTERVAL;
		this.ACTIVITY_PROPERTY 		= ACTIVITY_PROPERTY;
		this.RELATION_NODE 			= RELATION_NODE;
	}

	public int getACTIVITY_ID() {
		return ACTIVITY_ID;
	}

	public void setACTIVITY_ID(int ACTIVITY_ID) {
		this.ACTIVITY_ID 			= ACTIVITY_ID;
	}

	public int getFLOW_ID() {
		return FLOW_ID;
	}

	public void setFLOW_ID(int FLOW_ID) {
		this.FLOW_ID 				= FLOW_ID;
	}

	public int getFORM_ID() {
		return FORM_ID;
	}

	public void setFORM_ID(int FORM_ID) {
		this.FORM_ID 				= FORM_ID;
	}

	public int getACTIVITY_CODE() {
		return ACTIVITY_CODE;
	}

	public void setACTIVITY_CODE(int ACTIVITY_CODE) {
		this.ACTIVITY_CODE 			= ACTIVITY_CODE;
	}

	public String getACTIVITY_NAME() {
		return ACTIVITY_NAME;
	}

	public void setACTIVITY_NAME(String ACTIVITY_NAME) {
		this.ACTIVITY_NAME 			= ACTIVITY_NAME;
	}

	public int getACTIVITY_TYPE() {
		return ACTIVITY_TYPE;
	}

	public void setACTIVITY_TYPE(int ACTIVITY_TYPE) {
		this.ACTIVITY_TYPE 			= ACTIVITY_TYPE;
	}

	public String getNEXT_ACTIVITY_CODE() {
		return NEXT_ACTIVITY_CODE;
	}

	public void setNEXT_ACTIVITY_CODE(String NEXT_ACTIVITY_CODE) {
		this.NEXT_ACTIVITY_CODE 	= NEXT_ACTIVITY_CODE;
	}

	public int getSUB_FLOW_ID() {
		return SUB_FLOW_ID;
	}

	public void setSUB_FLOW_ID(int SUB_FLOW_ID) {
		this.SUB_FLOW_ID 			= SUB_FLOW_ID;
	}

	public int getREVIEW_TYPE() {
		return REVIEW_TYPE;
	}

	public void setREVIEW_TYPE(int REVIEW_TYPE) {
		this.REVIEW_TYPE 			= REVIEW_TYPE;
	}

	public int getREJECT_ACTIVITY_CODE() {
		return REJECT_ACTIVITY_CODE;
	}

	public void setREJECT_ACTIVITY_CODE(int REJECT_ACTIVITY_CODE) {
		this.REJECT_ACTIVITY_CODE 	= REJECT_ACTIVITY_CODE;
	}

	public int getBRANCH_SEL_TYPE() {
		return BRANCH_SEL_TYPE;
	}

	public void setBRANCH_SEL_TYPE(int BRANCH_SEL_TYPE) {
		this.BRANCH_SEL_TYPE 		= BRANCH_SEL_TYPE;
	}

	public int getHANDLER_SEL_TYPE() {
		return HANDLER_SEL_TYPE;
	}

	public void setHANDLER_SEL_TYPE(int HANDLER_SEL_TYPE) {
		this.HANDLER_SEL_TYPE 		= HANDLER_SEL_TYPE;
	}

	public int getACTIVITY_INTERVAL() {
		return ACTIVITY_INTERVAL;
	}

	public void setACTIVITY_INTERVAL(int ACTIVITY_INTERVAL) {
		this.ACTIVITY_INTERVAL 		= ACTIVITY_INTERVAL;
	}

	public int getACTIVITY_PROPERTY() {
		return ACTIVITY_PROPERTY;
	}

	public void setACTIVITY_PROPERTY(int ACTIVITY_PROPERTY) {
		this.ACTIVITY_PROPERTY 		= ACTIVITY_PROPERTY;
	}

	public int getRELATION_NODE() {
		return RELATION_NODE;
	}

	public void setRELATION_NODE(int RELATION_NODE) {
		this.RELATION_NODE 			= RELATION_NODE;
	}

	public void setACTIVITY_ICON(String aCTIVITY_ICON) {
		ACTIVITY_ICON = aCTIVITY_ICON;
	}

	public String getACTIVITY_ICON() {
		return ACTIVITY_ICON;
	}

	public void setACTIVITY_LEFT(int aCTIVITY_LEFT) {
		ACTIVITY_LEFT = aCTIVITY_LEFT;
	}

	public int getACTIVITY_LEFT() {
		return ACTIVITY_LEFT;
	}

	public void setACTIVITY_TOP(int aCTIVITY_TOP) {
		ACTIVITY_TOP = aCTIVITY_TOP;
	}

	public int getACTIVITY_TOP() {
		return ACTIVITY_TOP;
	}

}

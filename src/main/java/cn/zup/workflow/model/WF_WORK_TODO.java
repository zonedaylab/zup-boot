package cn.zup.workflow.model;

import java.util.Date;

/// <summary>
/// ʵ����WF_WORK_TODO ��(����˵���Զ���ȡ��ݿ��ֶε�������Ϣ)
/// </summary>
public class WF_WORK_TODO {
	public WF_WORK_TODO() {
	}

	private Integer HANDLER_ID;
	private Integer WORK_ITEM_ID;
	private String MAIN_BIZ_KEY;
	private Integer ACTIVITY_ID;
	private Integer ACTIVITY_CODE;
	private Integer WORK_STATE;
	private Integer FLOW_ID;
	private String FLOW_NAME;
	private Integer WORK_ID;
	private String WORK_NAME;
	private Integer SYSTEM_ID;
	private String ACTIVITY_NAME;
	private Integer HANDLER;
	private Integer HANDLER_TYPE;
	private Date WORK_ITME_DATETIME;
	private String PRE_ACTIVITY_INFO;
	private String WORK_STATE_NAME;

	// / <summary>
	// /
	// / </summary>
	public void setHANDLER_ID(Integer HANDLER_ID) {
		this.HANDLER_ID = HANDLER_ID;
	}

	public Integer getHANDLER_ID() {
		return HANDLER_ID;
	}

	// / <summary>
	// /
	// / </summary>
	public void setWORK_ITEM_ID(Integer WORK_ITEM_ID) {
		this.WORK_ITEM_ID = WORK_ITEM_ID;
	}

	public Integer getWORK_ITEM_ID() {
		return WORK_ITEM_ID;
	}

	// / <summary>
	// /
	// / </summary>
	public void setMAIN_BIZ_KEY(String MAIN_BIZ_KEY) {
		this.MAIN_BIZ_KEY = MAIN_BIZ_KEY;
	}

	public String getMAIN_BIZ_KEY() {
		return MAIN_BIZ_KEY;
	}

	// / <summary>
	// /
	// / </summary>
	public void setACTIVITY_ID(Integer ACTIVITY_ID) {
		this.ACTIVITY_ID = ACTIVITY_ID;
	}

	public Integer getACTIVITY_ID() {
		return ACTIVITY_ID;
	}

	// / <summary>
	// /
	// / </summary>
	public void setACTIVITY_CODE(Integer ACTIVITY_CODE) {
		this.ACTIVITY_CODE = ACTIVITY_CODE;
	}

	public Integer getACTIVITY_CODE() {
		return ACTIVITY_CODE;
	}

	// / <summary>
	// /
	// / </summary>
	public void setWORK_STATE(Integer WORK_STATE) {
		this.WORK_STATE = WORK_STATE;
	}

	public Integer getWORK_STATE() {
		return WORK_STATE;
	}

	// / <summary>
	// /
	// / </summary>
	public void setFLOW_ID(Integer FLOW_ID) {
		this.FLOW_ID = FLOW_ID;
	}

	public Integer getFLOW_ID() {
		return FLOW_ID;
	}

	// / <summary>
	// /
	// / </summary>
	public void setFLOW_NAME(String FLOW_NAME) {
		this.FLOW_NAME = FLOW_NAME;
	}

	public String getFLOW_NAME() {
		return FLOW_NAME;
	}

	// / <summary>
	// /
	// / </summary>
	public void setWORK_ID(Integer WORK_ID) {
		this.WORK_ID = WORK_ID;
	}

	public Integer getWORK_ID() {
		return WORK_ID;
	}

	// / <summary>
	// /
	// / </summary>
	public void setWORK_NAME(String WORK_NAME) {
		this.WORK_NAME = WORK_NAME;
	}

	public String getWORK_NAME() {
		return WORK_NAME;
	}

	// / <summary>
	// /
	// / </summary>
	public void setSYSTEM_ID(Integer SYSTEM_ID) {
		this.SYSTEM_ID = SYSTEM_ID;
	}

	public Integer getSYSTEM_ID() {
		return SYSTEM_ID;
	}

	// / <summary>
	// /
	// / </summary>
	public void setACTIVITY_NAME(String ACTIVITY_NAME) {
		this.ACTIVITY_NAME = ACTIVITY_NAME;
	}

	public String getACTIVITY_NAME() {
		return ACTIVITY_NAME;
	}

	// / <summary>
	// /
	// / </summary>
	public void setHANDLER(Integer HANDLER) {
		this.HANDLER = HANDLER;
	}

	public Integer getHANDLER() {
		return HANDLER;
	}

	// / <summary>
	// /
	// / </summary>
	public void setHANDLER_TYPE(Integer HANDLER_TYPE) {
		this.HANDLER_TYPE = HANDLER_TYPE;
	}

	public Integer getHANDLER_TYPE() {
		return HANDLER_TYPE;
	}

	// / <summary>
	// /
	// / </summary>
	public void setWORK_ITME_DATETIME(Date WORK_ITME_DATETIME) {
		this.WORK_ITME_DATETIME = WORK_ITME_DATETIME;
	}

	public Date getWORK_ITME_DATETIME() {
		return WORK_ITME_DATETIME;
	}

	// / <summary>
	// /
	// / </summary>
	public void setPRE_ACTIVITY_INFO(String PRE_ACTIVITY_INFO) {
		this.PRE_ACTIVITY_INFO = PRE_ACTIVITY_INFO;
	}

	public String getPRE_ACTIVITY_INFO() {
		return PRE_ACTIVITY_INFO;
	}

	// / <summary>
	// /
	// / </summary>
	public void setWORK_STATE_NAME(String WORK_STATE_NAME) {
		this.WORK_STATE_NAME = WORK_STATE_NAME;
	}

	public String getWORK_STATE_NAME() {
		return WORK_STATE_NAME;
	}

}

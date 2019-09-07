package cn.zup.workflow.biz.component;
import cn.zup.rbac.entity.UserSession;
import cn.zup.workflow.structure.SignInfo;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;

public class Work {	
	
	private int flowID;
	private int workID;
	private int activityID;
	private String mainBizKey;
	private String workName;
	private UserSession currentHandler;
	private cn.zup.workflow.structure.SignInfo signInfo;
	private java.util.List<Integer> attachList;
	private java.util.List<cn.zup.workflow.structure.ActivityHandler> nextActivitiesHandler;
	private int parentWorkID;
	private int parentActivityID;
	private Flow m_flow;

	/**
	 * 构造函数，初始化所有需要的信息
	 */
	public  Work(
			int flowID,
			int workID,
			int activityID,
			String mainBizKey,
			String workName,
			UserSession currentHandler,
			cn.zup.workflow.structure.SignInfo signInfo,
			java.util.List<Integer> attachList,
			java.util.List<cn.zup.workflow.structure.ActivityHandler> nextActivitiesHandler,
			int parentWorkID, int parentActivityID,
			Flow flow) throws SQLException {
		
		m_flow = flow;
		
		this.flowID=flowID;
		this.workID=workID;
		this.activityID=activityID;
		this.mainBizKey=mainBizKey;
		this.workName=workName;
		this.currentHandler=currentHandler;
		this.signInfo=signInfo;
		this.attachList=attachList;
		this.nextActivitiesHandler=nextActivitiesHandler;
		this. parentWorkID=parentWorkID;
		this. parentActivityID=parentActivityID;
	}
	
	/**
	 * 当前工作活动
	 */
	private WorkActivity currentWorkActivity;

	public WorkActivity getCurrentWorkActivity() {
		return currentWorkActivity;
	}

	public void setCurrentWorkActivity(WorkActivity currentWorkActivity) {
		this.currentWorkActivity = currentWorkActivity;
	}


	public int getFlowID() {
		return flowID;
	}

	public void setFlowID(int flowID) {
		this.flowID = flowID;
	}

	public int getWorkID() {
		return workID;
	}

	public void setWorkID(int workID) {
		this.workID = workID;
	}

	public int getActivityID() {
		return activityID;
	}

	public void setActivityID(int activityID) {
		this.activityID = activityID;
	}

	public String getMainBizKey() {
		return mainBizKey;
	}

	public void setMainBizKey(String mainBizKey) {
		this.mainBizKey = mainBizKey;
	}

	public String getWorkName() {
		return workName;
	}

	public void setWorkName(String workName) {
		this.workName = workName;
	}

	public UserSession getCurrentHandler() {
		return currentHandler;
	}

	public void setCurrentHandler(UserSession currentHandler) {
		this.currentHandler = currentHandler;
	}

	public cn.zup.workflow.structure.SignInfo getSignInfo() {
		return signInfo;
	}

	public void setSignInfo(cn.zup.workflow.structure.SignInfo signInfo) {
		this.signInfo = signInfo;
	}

	public java.util.List<Integer> getAttachList() {
		return attachList;
	}

	public void setAttachList(java.util.List<Integer> attachList) {
		this.attachList = attachList;
	}

	public java.util.List<cn.zup.workflow.structure.ActivityHandler> getNextActivitiesHandler() {
		return nextActivitiesHandler;
	}

	public void setNextActivitiesHandler(java.util.List<cn.zup.workflow.structure.ActivityHandler> nextActivitiesHandler) {
		this.nextActivitiesHandler = nextActivitiesHandler;
	}

	public int getParentWorkID() {
		return parentWorkID;
	}

	public void setParentWorkID(int parentWorkID) {
		this.parentWorkID = parentWorkID;
	}

	public int getParentActivityID() {
		return parentActivityID;
	}

	public void setParentActivityID(int parentActivityID) {
		this.parentActivityID = parentActivityID;
	}

	public Flow getM_flow() {
		return m_flow;
	}

	public void setM_flow(Flow m_flow) {
		this.m_flow = m_flow;
	}
	

	
	
}

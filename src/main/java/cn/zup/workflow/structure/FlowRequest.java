package cn.zup.workflow.structure;
import cn.zup.rbac.entity.UserSession;

/**
 * 工作流请求参数
 * 当进行工作流提交保存时，需要提交给控制器的参数
 * @author Liuxf
 *
 */
public class FlowRequest {
	
/** 
 流程ID
 
*/
private String flowID;

/** 
 工作ID	 
*/
private String workID;	


/** 
 活动ID
 * @throws Exception 
 
*/
private String activityID;
/** 
 工作项ID
 
*/
private String workItemID;

/** 
 页面权限类型 
*/
private String popedomType;

/** 
 操作者信息	 
*/
private UserSession currentHandler;

/** 
  页面传递的参数信息 跳转临时变量
*/
private String paramUrlStr;

/** 
选择操作者列表字符串 用,隔开 
*/
private String activityHandlerStr;


public void setFlowID(String flowID) {
	this.flowID = flowID;
}


public String getFlowID() {
	return flowID;
}


public void setWorkID(String workID) {
	this.workID = workID;
}


public String getWorkID() {
	return workID;
}


public void setActivityID(String activityID) {
	this.activityID = activityID;
}


public String getActivityID() {
	return activityID;
}


public void setWorkItemID(String workItemID) {
	this.workItemID = workItemID;
}


public String getWorkItemID() {
	return workItemID;
}


public void setPopedomType(String popedomType) {
	this.popedomType = popedomType;
}


public String getPopedomType() {
	return popedomType;
}

public void setCurrentHandler(UserSession currentHandler) {
	this.currentHandler = currentHandler;
}

public UserSession getCurrentHandler() {
	return currentHandler;
}



public String getActivityHandlerStr() {
	return activityHandlerStr;
}


public void setActivityHandlerStr(String activityHandlerStr) {
	this.activityHandlerStr = activityHandlerStr;
}


public String getParamUrlStr() {
	return paramUrlStr;
}


public void setParamUrlStr(String paramUrlStr) {
	this.paramUrlStr = paramUrlStr;
}



}


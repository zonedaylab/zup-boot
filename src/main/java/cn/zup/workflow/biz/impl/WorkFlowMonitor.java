package cn.zup.workflow.biz.impl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.zup.rbac.entity.UserSession;
import cn.zup.workflow.biz.IWorkFlowMonitor;
import cn.zup.workflow.config.*;
import cn.zup.workflow.model.*;
import cn.zup.workflow.structure.*;
import cn.zup.workflow.util.RefObject;
import cn.zup.workflow.util.StringHelper;


/**  工作流监控服务接口实现类
 
*/
@Service("monitorService")
public class WorkFlowMonitor implements IWorkFlowMonitor{
	@Autowired
	private cn.zup.workflow.dal.WF_ACTIVITY activityDal;
	@Autowired
	private  cn.zup.workflow.dal.WF_HANDLER handlerDal;
	@Autowired
	private  cn.zup.workflow.dal.WF_MONITOR monitorDal;
	@Autowired
	private cn.zup.workflow.dal.WF_WORK_ACTIVITY workActivityDal;
	@Autowired
	private  cn.zup.workflow.dal.WF_WORK workDal;
	@Autowired
	private  cn.zup.workflow.dal.WF_WORK_ITEM workItemDal;
	@Autowired
	private  cn.zup.workflow.dal.WF_LOG logDal;
	@Autowired
	private  cn.zup.workflow.dal.WF_ATTACH attachDal;
	@Autowired
	private cn.zup.workflow.dal.WF_FORM formDal;
	@Autowired
	private cn.zup.workflow.dal.WF_WORK_MSG wfWorkMsg;

	/** 
	 获取工作信息
	 @param workID 工作ID
	 @return 
	*/
	//1
	public  cn.zup.workflow.model.WF_WORK getWorkInfo(int workID) throws SQLException {
		return workDal.GetModel(workID);
	}
	/** 
	 获取工作历史
	 @param workID 工作ID
	 @return 
	 @throws SQLException 
	*/
	//2
	public  java.util.List<cn.zup.workflow.model.WORK_HISTORY> listWorkHistory(int workID) throws SQLException{
		return workDal.WorkHistoryList(workID);
	}
	/**
	 获取工作的历史签字记录
	 @param workID 工作ID
	 @return 
	*/
	//3
	public  java.util.List<WORK_SIGN> listWorkSign(int workID){
		try {
			return workDal.WorkSignList(workID);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	/** 
	 根据当前登录者获取工作待办数
	 @param currentHandler
	 @return 
	 * @throws Exception 
	*/
	//4
	public  int getWorkTodoAmount(UserSession currentHandler) throws Exception{
		return workDal.WorkTodoAmount(currentHandler);
	}
	/** 
	  获取待办工作列表
	 @param queryParameter 查询参数
	 @param currentHandler 操作者信息
	 @param pageIndex 页码
	 @param pageSize 每页记录数
	 @return 
	 * @throws Exception 
	*/
	//5
	public  PagingData<WORK_TODO> listWork(QueryParameter queryParameter, UserSession currentHandler, int pageIndex, int pageSize) throws Exception{
		return workDal.TodoList(queryParameter, currentHandler, pageIndex, pageSize);
	}
	/** 
	 获取发起工作列表
	 @param queryParameter 查询参数
	 @param currentHandler 操作者信息
	 @param pageIndex 当前页码
	 @param pageSize 每页记录数
	 @return 
	*/
	//6
	public  PagingData<WORK_INIT> listWorkInit(QueryParameter queryParameter, UserSession currentHandler, int pageIndex, int pageSize){
		try {
			return workDal.InitList(queryParameter, currentHandler, pageIndex, pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	/** 
	 获取已办工作列表
	 @param queryParameter 查询参数
	 @param currentHandler 用户ID
	 @param pageIndex 当前页码
	 @param pageSize 每页记录数
	 @return 
	 * @throws Exception 
	*/
	//7
	public  PagingData<cn.zup.workflow.model.WORK_DEALT> listWorkDealt(QueryParameter queryParameter, UserSession currentHandler,int pageIndex, int pageSize) throws Exception{
		return workDal.DealtList(queryParameter, currentHandler, pageIndex, pageSize);
	}
	/** 
	 获取监控工作列表
	 @param queryParameter 查询参数
	 @param currentHandler 监控者信息
	 @param pageIndex 当前页码
	 @param pageSize 每页记录数
	 @return 
	*/
	//8
	public  PagingData<cn.zup.workflow.model.WORK_MONITOR> listMonitor(QueryParameter queryParameter, UserSession currentHandler, int pageIndex, int pageSize){
		String monitorIDs = monitorDal.GetMonitorQuery(currentHandler, queryParameter.getSystemID());
		try {
			return workDal.MonitorList(queryParameter, monitorIDs, pageIndex, pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		
	}
	/** 
	 获取监控工作列表
	 liudeli 20161220
	 @param queryParameter 查询参数
	 @param currentHandler 监控者信息
	 @param pageIndex 当前页码
	 @param pageSize 每页记录数
	 @return 
	*/
	//9
	public  PagingData<cn.zup.workflow.model.WF_WORK> listWorkMonitor(QueryParameter queryParameter, UserSession currentHandler, int pageIndex, int pageSize){
		try {
			return workDal.getWorkMonistorList(queryParameter, currentHandler, pageIndex, pageSize);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	/** 
	 根据工作ID、活动ID获取某节点所有经办人（实现默认经办人）
	 @param workID 工作ID
	 @param activitID 活动ID
	 @return 
	 * @throws SQLException 
	*/
	//10
	public  java.util.List<cn.zup.workflow.model.WF_HANDLER> listWorkActivityHandler(int workID, int activitID) throws SQLException{
		return workActivityDal.WorkActivityHandlerList(workID, activitID);
	}

	/** 
	 获取流程第一个活动信息
	 @param flowID 流程ID
	 @return 
	 * @throws Exception 
	*/
	//11
	public  cn.zup.workflow.model.WF_ACTIVITY getFirstActivity(int flowID) throws Exception{
		return activityDal.FirstActivityInfo(flowID);
	}
	
	/**
	 * 获取工作项对应的活动ID
	 * liuxf
	 * @param workItemID
	 * @return
	 * @throws SQLException
	 */
	//12
	public  int getAcitivityIDbyWorkItem(int workItemID) throws SQLException{
		cn.zup.workflow.model.WF_WORK_ACTIVITY workActivityModel = workActivityDal.GetModelByWorkItem(workItemID);
		if(workActivityModel==null)
			return 0;
		return workActivityModel.getACTIVITY_ID();
	}

	/** 
	 获取跳转页面信息
	 
	 @param workItemID 工作项ID
	 @param workActivityID 工作活动
	 @param popedomType 权限类型
	 @return 
	 * @throws SQLException 
	*/
	//13
	public  String getForm(Integer workItemID, Integer workActivityID, PagePopedomType popedomType) throws SQLException{
		String strTargetLink = "";
		cn.zup.workflow.model.WF_WORK_ACTIVITY workActivityModel=null;
		if (workItemID != null){
			workActivityModel = workActivityDal.GetModelByWorkItem((int)workItemID);
		}
		else if (workActivityID != null){
			workActivityModel = workActivityDal.GetModel((int)workActivityID);
		}
		if (workActivityModel != null){
			cn.zup.workflow.model.WF_FORM formModel = formDal.FormInfo(workActivityModel.getACTIVITY_ID());
			int flowID = activityDal.GetModel(workActivityModel.getACTIVITY_ID()).getFLOW_ID();
			if (formModel != null && !StringHelper.isNullOrEmpty(formModel.getURL())){
				strTargetLink = "../" + formModel.getURL() + "?FLOW_ID=" + flowID + "&ACTIVITY_ID=" + workActivityModel.getACTIVITY_ID() + "&WORK_ID=" + 
								workActivityModel.getWORK_ID() + "&WORK_ITEM_ID=" + workItemID + 
								"&POPEDOM_TYPE=" + popedomType;
			}else{
				throw new RuntimeException("表单连接异常！");
			}
		}else{
			throw new RuntimeException("工作节点异常！");
		}
		return strTargetLink;
	}

	/** 
	 获取活动信息，不需要的参数传0 
	 传参方式1-flowID ,activityCode 0，
	 传参方式2-0，0，workActivityID
	 @param flowID 流程ID
	 @param activityCode 活动序号
	 @param workActivityID 工作活动ID
	 @return 
	 * @throws SQLException 
	*/
	//14
	public  WF_ACTIVITY getActivity(int flowID, int activityCode, int workActivityID) throws SQLException{
		WF_ACTIVITY modActivity = null;
		if (flowID != 0 && activityCode != 0){
			modActivity = activityDal.GetModel(flowID, activityCode);
		}else if (workActivityID != 0){
			int activityID = workActivityDal.GetModel(workActivityID).getACTIVITY_ID();
			modActivity = activityDal.GetModel(activityID);
		}
		return modActivity;
	}
	/** 
	 获取活动列表及活动对应的操作者列表
	 @param flowID 流程ID
	 @param activityCodes 活动
	 @return 
	 * @throws SQLException 
	*/
	//15
	public  java.util.List<ActivityHandler> listActivityAndHander(int flowID, String activityCodes) throws SQLException{
		java.util.List<ActivityHandler> list = new java.util.ArrayList<ActivityHandler>();
		if (!StringHelper.isNullOrEmpty(activityCodes)){ //获取活动列表
			java.util.List<WF_ACTIVITY> activityList = activityDal.GetListArray("FlOW_ID=" + flowID + " AND ACTIVITY_CODE IN (" + activityCodes + ")");
			for (WF_ACTIVITY activity : activityList){
				ActivityHandler actHandler = new ActivityHandler();
				actHandler.setActivityID(activity.getACTIVITY_ID());
				actHandler.setActivityCode(activity.getREJECT_ACTIVITY_CODE());
				actHandler.setActivityName(activity.getACTIVITY_NAME()) ;
				actHandler.setHanderList( handlerDal.GetListArray("ACTIVITY_ID=" + activity.getFLOW_ID()));
				list.add(actHandler);
			}
		}
		return list;
	}

	/** 
	 获取当前工作项的签字信息
	 @param workItemID
	 @return 
	 * @throws SQLException 
	*/
	//16
	public  String getActivitySign(int workItemID) throws SQLException{
		WF_WORK_ITEM workItemModel = workItemDal.GetModel(workItemID);
		if (workItemModel != null){
			return workItemModel.getSIGN_OPINION();
		}else{
			return "";
		}
	}

	/** 
	 需要强制结束节点的信息
	 @param workID 工作ID
	 @return 
	 * @throws SQLException 
	*/
	//17
	public  cn.zup.workflow.structure.TerminateNode deleteTerminateActivity(int workID) throws SQLException{
		TerminateNode terminateNode = new TerminateNode();
		int activityID = 0, activityType = 0, workActivityID = 0; //声明需要获取的活动ID，活动类型，动作活动ID信息
		RefObject<Integer> tempRef_activityID = new RefObject<Integer>(activityID);
		RefObject<Integer> tempRef_activityType = new RefObject<Integer>(activityType);
		RefObject<Integer> tempRef_workActivityID = new RefObject<Integer>(workActivityID);
		activityDal.TerminateActivityInfo(workID, tempRef_activityID, tempRef_activityType, tempRef_workActivityID);
		activityID = tempRef_activityID.argvalue;
		activityType = tempRef_activityType.argvalue;
		workActivityID = tempRef_workActivityID.argvalue;
		terminateNode.setActivityID (activityID);
		terminateNode.setActivityType ( activityType);
		terminateNode.setWorkActivityID ( workActivityID);
		return terminateNode;
	}
	/** 
	  获取工作流日志
	 @param startDate 开始时间
	 @param endDate 结束时间
	 @param pageIndex 当前页码
	 @param pageSize 每页记录数
	 @return 
	 * @throws Exception 
	*/
	//18
	public  PagingData<WF_LOG> listLog(String startDate, String endDate, int pageIndex, int pageSize) throws Exception{
		return logDal.LogList(startDate, endDate, pageIndex, pageSize);
	}
	/** 
	 获取委托工作列表
	 @param queryParameter 查询条件
	 @param currentHandler 当前操作者
	 @param pageIndex 当前页码
	 @param pageSize 每页记录数
	 @return 
	 * @throws Throwable 
	*/
	//19
	public  PagingData<cn.zup.workflow.model.WORK_TODO> listWorkEntrust(QueryParameter queryParameter, UserSession currentHandler, int pageIndex, int pageSize) throws Exception{
		return workDal.EntrustList(queryParameter, currentHandler, pageIndex, pageSize);
	}
	/** 
	 签收工作通知
	 @param workMsgID 通知ID
	 * @throws SQLException 
	*/
	//20
	public  void getWorkMsgSign(int workMsgID) throws SQLException{
		wfWorkMsg.WorkMsgSign(workMsgID);
	}

	/** 
	 根据当前登录者获取工作通知总数
	 @param currentHandler 操作者信息
	 @return 
	 * @throws SQLException 
	*/
	//21
	public  int getWorkMsgAmount(UserSession currentHandler) throws SQLException{
		return wfWorkMsg.WorkMsgAmount(currentHandler);
	}
	/** 
	 获取接收的工作通知列表
	 @param queryParameter 查询条件
	 @param currentHandler 操作者信息
	 @param pageIndex 当前页码
	 @param pageSize 每页记录数
	 @return 
	 * @throws SQLException 
	*/
	//22
	public  PagingData<WORK_MSG> listWorkMsgReceive(QueryParameter queryParameter, UserSession currentHandler, int pageIndex, int pageSize) throws SQLException{
		return wfWorkMsg.WorkMsgReceiveList(queryParameter, currentHandler, pageIndex, pageSize);

	}
	/** 
	 获取工作的附件信息列表
	 @param workID
	 @return 
	 * @throws Exception 
	*/
	//23
	public  java.util.List<ATTACH> listAttach(int workID) throws Exception{
		return attachDal.AttachList(workID);
	}
	/** 
	 根据工作项ID获取附件列表
	 @param flowID 流程ID
	 @param workItemID 工作项ID
	 @param currentHandler 当前操作者
	 @return 
	 * @throws Exception 
	*/
	//24
	public  java.util.List<ATTACH> getAttachListByWorkItemID(int flowID, int workItemID, UserSession currentHandler) throws Exception{
		return attachDal.GetListArray(flowID, workItemID, currentHandler);
	}

	


		///#region 工作流引擎

	/** 
	 获取某个活动的父亲节点数量
	 
	 @param activityID
	 @return 
	 * @throws SQLException 
	*/
	public  int getActivityParentCount(int activityID) throws SQLException
	{
		WF_ACTIVITY activity = new WF_ACTIVITY();
		java.util.List<WF_ACTIVITY> activityList = new java.util.ArrayList<WF_ACTIVITY>();
		activity = activityDal.GetModel(activityID);
		activityList = activityDal.GetListArray("FLOW_ID=" + activity.getFLOW_ID());

		int parentCount = 0; //初始化父节点的数量
		for (WF_ACTIVITY model : activityList)
		{
			String nextCodes[]=model.getNEXT_ACTIVITY_CODE().split("[,]", -1);
			for(String code : nextCodes)
			{
				if(code.equals(activity.getACTIVITY_CODE()))
					parentCount++;
			}
			
		//	if (model.getNEXT_ACTIVITY_CODE().split("[,]", -1).Contains(activity.getACTIVITY_CODE().toString()))
		//	{
		//		parentCount++;
		//	}
		}
		return parentCount;
	}


	/** 
	 获取工作活动数据-AOV网
	 
	 @param flowID
	 @param workID
	 @return 
	 * @throws SQLException 
	*/
	public List<ACTIVITY_AOV> getActivityAOVNet(int flowID, int workID) throws SQLException
	{
		return workActivityDal.AOVNet(flowID, workID);
	}

	/** 
	 获取正在办理的工作
	 
	 @return 
	 * @throws SQLException 
	*/
	public  List<cn.zup.workflow.model.WF_WORK> listWorkActive() throws SQLException
	{
		return workDal.GetListArray("WORK_STATE=" + WorkState.InProgress);
	}

	/** 
	 获取正在办理的工作活动
	 
	 @return 
	 * @throws SQLException 
	*/
	public List<cn.zup.workflow.model.WORK_ACTIVITY> listWorkActivityActive() throws SQLException
	{
		return workActivityDal.WorkActivityActiveList();
	}	
	
	/**
	 * 获取监控者列表
	 */

	public List<cn.zup.workflow.model.WF_MONITOR> listWorkFlowMonitor(int flowId) throws SQLException{
		return monitorDal.GetWorkFlowMonitor(flowId);
	}
	
	
	//29  
	/** 
	获取当前工作项的工作流程信息  
	 
	 @param handlerList
	 @return 	 
	 liuxf 2019.12.8
	*/
	public FlowRequest getCurrentWorkFlow(String workItemID, String StateId) throws Exception{
		
		return  workItemDal.getCurrentWorkFlow( workItemID,  StateId) ;
	}
}

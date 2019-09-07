package cn.zup.workflow.biz;
import java.sql.SQLException;

import cn.zup.rbac.entity.UserSession;
import cn.zup.workflow.config.*;
import cn.zup.workflow.model.*;
import cn.zup.workflow.structure.*;


/** 
 工作流监控服务接口
 
*/
public interface IWorkFlowMonitor{

	/** 
	 获取工作信息
	 @param workID 工作ID
	 @return 
	 * @throws SQLException 
	*/
	//1
	WF_WORK getWorkInfo(int workID) throws SQLException;
	/** 
	 获取工作历史
	 @param workID 工作ID
	 @return 
	*/
	//2
	java.util.List<WORK_HISTORY> listWorkHistory(int workID) throws SQLException;
	/** 
	 获取工作的历史签字记录
	 @param workID 工作ID
	 @return 
	*/
	//3
	java.util.List<WORK_SIGN> listWorkSign(int workID);
	/** 
	 根据当前登录者获取工作待办数
	 @param currentHandler
	 @return 
	 * @throws Exception 
	*/
	//4
	int getWorkTodoAmount(UserSession currentHandler) throws Exception;
	/** 
	  获取待办工作列表
	 @param queryParameter 查询参数
	 @param currentHandler 操作者信息
	 @param pageIndex 当前页码
	 @param pageSize 页记录数
	 @return 
	*/
	//5
	PagingData<WORK_TODO> listWork(QueryParameter queryParameter, UserSession currentHandler, int pageIndex, int pageSize) throws Exception;
	/** 
	 获取委托工作列表
	 @param queryParameter 查询条件
	 @param currentHandler 当前操作者
	 @param pageIndex 当前页码
	 @param pageSize 每页记录数
	 @return 
	 */
	//6
	PagingData<WORK_TODO> listWorkEntrust(QueryParameter queryParameter, UserSession currentHandler, int pageIndex, int pageSize) throws Exception;
	/** 
	 获取发起工作列表
	 @param queryParameter 查询参数
	 @param currentHandler 当前操作者
	 @param pageIndex 当前页码
	 @param pageSize 每页记录数
	 @return 
	*/
	//7
	PagingData<WORK_INIT> listWorkInit(QueryParameter queryParameter, UserSession currentHandler, int pageIndex, int pageSize) throws Exception;
	/** 
	 获取已办工作列表
	 @param queryParameter 查询参数
	 @param currentHandler 当前操作者
	 @param pageIndex 当前页码
	 @param pageSize 每页记录数
	 @return 
	*/
	//8
	PagingData<WORK_DEALT> listWorkDealt(QueryParameter queryParameter, UserSession currentHandler, int pageIndex, int pageSize)  throws Exception;
	/** 
	 获取监控工作列表
	 @param queryParameter 查询参数
	 @param currentHandler 监控者信息
	 @param pageIndex 当前页码
	 @param pageSize 每页记录数
	 @return 
	*/
	//9
	PagingData<WORK_MONITOR> listMonitor(QueryParameter queryParameter, UserSession currentHandler, int pageIndex, int pageSize) throws Exception;
	/** 
	 获取监控全部的工作列表
	 liudeli20161220
	 @param queryParameter 查询参数
	 @param currentHandler 监控者信息
	 @param pageIndex 当前页码
	 @param pageSize 每页记录数
	 @return 
	*/
	//10
	PagingData<WF_WORK> listWorkMonitor(QueryParameter queryParameter, UserSession currentHandler, int pageIndex, int pageSize) throws Exception;
	/** 
	 获取跳转页面信息
	 @param workItemID 工作项ID
	 @param workActivityID 工作活动ID
	 @param popedomType 权限类型
	 @return 
	 * @throws SQLException 
	*/
	//10
	String getForm(Integer workItemID, Integer workActivityID, PagePopedomType popedomType) throws SQLException;
	/**
	 * 获取工作项对应的活动ID
	 * liuxf
	 * @param workItemID
	 * @return
	 * @throws SQLException
	 */
	//11
	int getAcitivityIDbyWorkItem(int workItemID) throws SQLException;
	/** 
	 获取流程第一个活动信息
	 @param flowID 流程ID
	 @return 
	 * @throws Exception 
	*/
	//12
	WF_ACTIVITY getFirstActivity(int flowID) throws Exception;
	/** 
	 获取活动列表及活动对应的操作者列表
	 @param flowID 流程ID
	 @param activityCodes 活动
	 @return 
	*/
	//13
	java.util.List<ActivityHandler> listActivityAndHander(int flowID, String activityCodes) throws Exception;
	/** 
	 获取活动编号对应的活动，不需要的参数传0 
	 传参方式1-flowID ,activityCode 0，
	 传参方式2-0，0，workActivityID
	 @param flowID 流程ID
	 @param code 活动序号
	 @param workActivityID 工作活动ID
	 @return 
	 * @throws SQLException 
	*/
	//14
	WF_ACTIVITY getActivity(int flowID, int code, int workActivityID) throws SQLException;
	/** 
	 获取当前工作项的签字信息
	 @param workItemID
	 @return 
	 * @throws SQLException 
	*/
	//15
	String getActivitySign(int workItemID) throws SQLException;
	/** 
	 需要强制结束节点的信息
	 @param workID 工作ID
	 @return 
	 * @throws SQLException 
	*/
	//16
	TerminateNode deleteTerminateActivity(int workID) throws SQLException;
	/** 
	 根据工作ID、活动ID获取某节点所有经办人（实现默认经办人）
	 @param workID 工作ID
	 @param activitID 活动ID
	 @return 
	*/
	//17
	java.util.List<WF_HANDLER> listWorkActivityHandler(int workID, int activitID)  throws Exception;;
	/** 
	  获取工作流日志
	 @param startDate 开始时间
	 @param endDate 结束时间
	 @param pageIndex 当前页码
	 @param pageSize 每页记录数
	 @return 
	*/
	//18
	PagingData<WF_LOG> listLog(String startDate, String endDate, int pageIndex, int pageSize) throws Exception;
	/** 
	 签收工作通知
	 @param workMsgID 通知ID
	 * @throws SQLException 
	*/
	//19
	void getWorkMsgSign(int workMsgID) throws SQLException;
	/** 
	 根据当前登录者获取工作通知总数
	 @param currentHandler 操作者信息
	 @return 
	*/
	//20
	int getWorkMsgAmount(UserSession currentHandler) throws Exception;;
	/** 
	 获取接收的工作通知列表
	 @param queryParameter 查询条件
	 @param currentHandler 操作者信息
	 @param pageIndex 当前页码
	 @param pageSize 每页记录数
	 @return 
	 * @throws SQLException 
	*/
	//21
	PagingData<WORK_MSG> listWorkMsgReceive(QueryParameter queryParameter, UserSession currentHandler, int pageIndex, int pageSize) throws SQLException;
	/** 
	 获取工作的附件信息列表
	 @param workID 工作ID
	 @return 
	*/
	//22
	java.util.List<ATTACH> listAttach(int workID) throws Exception;
	/** 
	 根据工作项ID获取附件列表
	 @param flowID 流程ID
	 @param workItemID 工作项ID
	 @param currentHandler 当前操作者
	 @return 
	*/
	//23
	java.util.List<ATTACH> getAttachListByWorkItemID(int flowID, int workItemID, UserSession currentHandler) throws Exception;
	/** 
	 获取某个活动的父亲节点数量
	 @param activityID
	 @return 
	 * @throws SQLException 
	*/
	//24
	int getActivityParentCount(int activityID) throws SQLException;
	/** 
	 获取工作活动数据-AOV网
	 @param flowID
	 @param workID
	 @return 
	*/
	//25
	java.util.List<ACTIVITY_AOV> getActivityAOVNet(int flowID, int workID) throws Exception;;
	/** 
	 获取正在办理的工作
	 @return 
	*/
	//26
	java.util.List<WF_WORK> listWorkActive() throws Exception;;
	/** 
	 获取正在办理的工作活动
	 @return 
	*/
	//27
	java.util.List<WORK_ACTIVITY> listWorkActivityActive() throws Exception;;
	/** 
	 获取监控者
	 @return 
	*/
	//28
	java.util.List<WF_MONITOR> listWorkFlowMonitor(int flowId) throws Exception;
}

package cn.zup.workflow.biz;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.List;

import cn.zup.workflow.model.ACTIVITY_POPEDOM;
import cn.zup.workflow.model.ACTIVITY_RULE;
import cn.zup.workflow.model.ENTRUST;
import cn.zup.workflow.model.FLOW_MANAGE;
import cn.zup.workflow.model.FORM_CONTROL;
import cn.zup.workflow.model.WF_ACTIVITY;
import cn.zup.workflow.model.WF_ACTIVITY_LAYOUT;
import cn.zup.workflow.model.WF_ACTIVITY_POPEDOM;
import cn.zup.workflow.model.WF_CONFIG;
import cn.zup.workflow.model.WF_ENTRUST;
import cn.zup.workflow.model.WF_FLOW;
import cn.zup.workflow.model.WF_FORM;
import cn.zup.workflow.model.WF_FORM_CONTROL;
import cn.zup.workflow.model.WF_HANDLER;
import cn.zup.workflow.model.WF_LINE;
import cn.zup.workflow.model.WF_MONITOR;
import cn.zup.workflow.model.WF_MSG_SET;
import cn.zup.workflow.model.WF_RULE;
import cn.zup.workflow.model.WF_SYSTEM;
import cn.zup.workflow.model.WF_WORK_ACTIVITY;
import cn.zup.workflow.structure.PagingData;
import cn.zup.workflow.structure.QueryParameter;

/** 
 工作流配置服务接口类
 
*/

public interface IWorkFlowConfig{
	/** 
	 获取业务系统信息
	 @param systemID 业务系统ID
	 @return 系统信息实体
	 * @throws SQLException 
	*/
	//1
	WF_SYSTEM getSystem(int systemID) throws SQLException;
	/** 
	 获取业务系统列表
	 @return 系统信息列表
	*/
	//2
	java.util.List<WF_SYSTEM> listSystem();
	/** 
	 业务系统配置保存
	 @param modSystem 系统信息实体
	 @return 自增主键值
	*/
	//3
	int saveSystem(WF_SYSTEM modSystem);
	/** 
	 删除业务系统配置
	 @param systemID 系统ID
	 * @throws SQLException 
	*/
	//4
	void deleteSystem(int systemID) throws SQLException;
	/** 
	 获取流程分页列表
	 @param queryParameter 查询参数
	 @param pageIndex 当前页码
	 @param pageSize 每页记录数
	 @return 
	 * @throws Exception 
	*/
	//5
	PagingData<FLOW_MANAGE> listFlowPaging(QueryParameter queryParameter, int pageIndex, int pageSize) throws Exception;
	/** 
	 获取流程列表
	 @param systemID 系统ID
	 @return 
	 * @throws Exception 
	*/
	//6
	java.util.List<WF_FLOW> listFlow(int systemID) throws Exception;
	/** 
	 获取流程信息
	 可根据流程ID或流程名称获取流程信息
	 @param flowID 流程ID
	 @param flowName 流程名称
	 @return 流程信息实体
	 * @throws SQLException 
	*/
	//7
	WF_FLOW getFlow(int flowID) throws SQLException;
	/** 
	 保存流程配置信息
	 @param flowModel 流程信息实体类
	 @return 自增主键值
	 * @throws SQLException 
	*/
	//8
	int saveFlow(WF_FLOW flowModel) throws SQLException;
	/** 
	 获取监控者列表
	 @param flowID 流程ID
	 @return 监控者列表
	 * @throws SQLException 
	*/
	//9
	java.util.List<WF_MONITOR> listMonitor(int flowID) throws SQLException;
	/** 
	 添加监控者配置
	 @param monitorModel 监控对象实体
	 @return 自增主键值MONITOR_ID
	 * @throws SQLException 
	*/
	//10
	int saveMonitor(WF_MONITOR monitorModel) throws SQLException;
	/** 
	 删除流程下的监控者配置
	 @param flowID 流程ID
	 * @throws Exception 
	*/
	//11
	void deleteMonitor(int flowID) throws Exception;
	/** 
	 保存表单
	 @param formModel
	 @return 
	 * @throws SQLException 
	*/
	//12
	int saveForm(WF_FORM formModel) throws SQLException;
	/** 
	 获取自定义表单内容信息
	 @param formID 表单ID
	 @return 表单对象实体
	 * @throws SQLException 
	 * @throws UnsupportedEncodingException 
	*/
	//13
	String getFormAuto(int formID) throws SQLException, UnsupportedEncodingException;
	/** 
	 获取表单信息
	 @param formID 表单ID
	 @return 表单对象实体
	 * @throws SQLException 
	*/
	//14
	WF_FORM getForm(int formID) throws SQLException;
	/** 
	 获取表单列表
	 @param systemID 系统ID，传参为0时，返回所有表单列表
	 @return 表单对象实体列表
	 * @throws SQLException 
	*/
	//15
	java.util.List<WF_FORM> listForm(int systemID) throws SQLException;
	/** 
	 获取表单列表
	 @param systemID 系统ID
	 @param parentFormID 父表单ID
	 @return 表单列表
	 * @throws SQLException 
	*/
	//16
	java.util.List<WF_FORM> listFormSub(int systemID, int parentFormID) throws SQLException;
	/** 
	 删除表单
	 @param formID 表单ID
	*/
	//17
	void deleteForm(int formID) throws SQLException;
	//18
	/** 
	 获取活动列表
	 @param flowID 流程ID
	 @return 活动列表
	*/
	//19
	java.util.List<WF_ACTIVITY> listActivity(int flowID) throws SQLException;
	/** 
	 获取活动列表
	 @param fromId 表单ID
	 @return 活动列表
	*/
	//20
	java.util.List<WF_ACTIVITY> getActivityListByFormId(int fromId) throws SQLException;
	/** 
	 获取活动列表
	 @param flowID 流程ID
	 @param activityCodes 活动编号
	 @return 活动列表
	 * @throws SQLException 
	*/
	//21
	java.util.List<WF_ACTIVITY> getActivityListByCodes(int flowID, String activityCodes) throws SQLException;
	/** 
	 获取活动信息
	 @param activityID 活动ID
	 @return 活动类对象实体
	 * @throws SQLException 
	*/
	//22
	WF_ACTIVITY getAcitivity(int activityID) throws SQLException;
	/** 
	 保存下一步骤设置
	 @param activityID 活动ID
	 @param lineModelList 连线实体列表
	 * @throws SQLException 
	*/
	//23
	void saveActivityNext(int activityID, java.util.List<WF_LINE> lineModelList) throws SQLException;
	/** 添加活动
	 @param activityModel 活动实体
	 @param lineModel 线关系实体
	 @return 
	*/
	//24
	int saveActivity(WF_ACTIVITY activityModel, WF_LINE lineModel) throws SQLException;
	/** 
	 保存活动信息
	 @param activityModel
	 @return 
	*/
	//25
	int saveActivity(WF_ACTIVITY activityModel) throws SQLException;
	/** 
	 删除活动信息
	 @param activityID 活动ID
	*/
	//26
	void deleteActivity(int activityID) throws SQLException;
	//27
	/** 
	 获取活动关系信息列表
	 @param activityID 活动ID
	 @return 活动关系列表
	*/
	//28
	java.util.List<WF_LINE> listLine(int flowID) throws SQLException;
	/** 
	  活动关系添加
	 @param lineModel 关系实体
	 @return 自增主键LINE_ID
	*/
	//29
	int saveLine(WF_LINE lineModel) throws SQLException;
	/** 
	 删除活动关系
	 @param activityID 活动ID
	*/
	//30
	void deleteLine(int activityID) throws SQLException;
	/** 
	 活动布局获取
	 @param activityID
	 @return 
	*/
	//31
	WF_ACTIVITY_LAYOUT getActivityLayout(int activityID) throws SQLException;
	/** 
	 活动布局保存
	 @param actLayoutModel
	 @return 
	*/
	//32
	void saveActivityLayout(WF_ACTIVITY_LAYOUT actLayoutModel) throws SQLException;
	//33
	/** 
	 获取通知设置列表
	 @param activityID
	 @return 
	*/
	//34
	java.util.List<WF_MSG_SET> listMsgSet(int activityID) throws SQLException;
	/** 
	 通知接收者保存
	 @param msgSetModel
	 @return 
	*/
	//35
	int saveMsgSet(WF_MSG_SET msgSetModel) throws SQLException;
	/** 
	 通知接收者
	 @param activityId
	 * @throws Exception 
	*/
	//36
	void deleteMsgSet(int activityId) throws SQLException, Exception;
	/** 
	 获取操作者列表
	 @param activityID 活动ID
	 @return 操作者对象实体列表
	*/
	//37
	java.util.List<WF_HANDLER> listHandler(int activityID) throws SQLException;
	/** 
	 *获取操作者列表
	 *@author 谢炎
	 *@date 2016-11-23 20:10:48
	 *@param activityID 活动ID
	 *@return 操作者对象实体列表
	*/
	//38
	java.util.List<Integer> getMenuFlowId(int handle, int handleType) throws SQLException;
	/** 
	 获取操作者信息
	 @param handlerID 操作者ID
	 @return 操作者对象实体
	*/
	//39
	WF_HANDLER getHandler(int handlerID) throws SQLException;
	/** 
	 保存操作者信息
	 @param handlerModel 操作者对象实体
	 @return 自增主键HANDLER_ID
	*/
	//40
	int saveHandler(WF_HANDLER handlerModel) throws SQLException;
	/** 
	 删除活动下的操作者配置
	 @param activityID 活动ID
	 * @throws Exception 
	*/
	//41
	void deleteHandler(int activityID) throws SQLException, Exception;
	/** 
	 获取活动的流转规则列表
	 @param activityID 活动ID
	 @return 流转规则对象实体
	 * @throws Exception 
	*/
	//41
	java.util.List<ACTIVITY_RULE> listRule(int activityID) throws  Exception;
	/** 
	 获取活动的流转规则
	 @param ruleID 流转规则ID
	 @return 流转规则对象实体
	*/
	//42
	WF_RULE getRule(int ruleID) throws SQLException;
	/** 
	 流转规则保存
	 @param ruleModel 流转规则类对象实体
	 @return 自增主键RULE_ID
	*/
	//43
	int saveRule(WF_RULE ruleModel) throws SQLException;
	/** 
	 流转规则删除
	 @param ruleID 活动ID
	*/
	//44
	void deleteRule(int ruleID) throws SQLException;
	//45
	/** 
	 表单组件配置列表
	 @param formID 表单ID
	 @return 表单组件类对象实体列表
	 * @throws Exception 
	*/
	//46
	java.util.List<FORM_CONTROL> listFormControl(int formID) throws SQLException, Exception;
	/** 
	 获取表单组件信息
	 @param controlID 组件ID
	 @return 表单组件类对象实体
	*/
	//47
	WF_FORM_CONTROL getFormControl(int controlID) throws SQLException;
	/** 
	 保存配置的表单组件
	 @param formControlModel 表单实体
	 @return 自增主键CONTROL_ID
	*/
	//48
	int saveFormControl(WF_FORM_CONTROL formControlModel) throws SQLException;
	/** 
	 删除表单组件配置
	 @param controlID 组件ID
	 * @throws SQLException 
	*/
	//49
	void deleteFormControl(int controlID) throws SQLException;
	/** 
	 获取组件权限列表
	 @param activityID 活动ID
	 @return 组件权限列表
	 * @throws Exception 
	*/
	//50
	java.util.List<ACTIVITY_POPEDOM> listActivityPopedom(int activityID) throws Exception;
	/** 
	 获取组件权限信息
	 @param activityID 活动ID
	 @param controlID 组件ID
	 @return 组件权限实体
	 * @throws SQLException 
	*/
	//51
	WF_ACTIVITY_POPEDOM getActivityPopedom(int activityID, int controlID) throws SQLException;
	/** 
	 保存组件权限信息
	 @param activityPopedomModel 组件权限实体
	*/
	//52
	void saveActivityPopedom(WF_ACTIVITY_POPEDOM activityPopedomModel) throws SQLException;
	/** 
	 删除组件权限信息
	 @author antsdot
	 @date 2016-12-1 16:28:51
	 @param controlId 组件id
	*/
	//53
	public void deleteActivityPopedom(int activityId, int controlId) throws SQLException;
	/** 
	 获取委托分页列表
	 @param queryParameter 查询参数
	 @param userID 用户ID
	 @param pageIndex 当前页码
	 @param pageSize 每页记录数
	 @return 分页数据
	 * @throws Exception 
	*/
	//54
	PagingData<ENTRUST> listEntrustPaging(QueryParameter queryParameter, int userID, int pageIndex, int pageSize) throws SQLException, Exception;
	/** 
	 保存委托人设置
	 @param entrustModel 委托实体
	 @return 
	*/
	//55
	int saveEntrust(WF_ENTRUST entrustModel) throws SQLException;
	/** 
	 更新委托状态
	 @param entrustID 委托ID
	 @param entrustState 委托状态
	 * @throws Exception 
	*/
	//56
	void saveEntrutState(int entrustID, int entrustState) throws SQLException, Exception;
	/** 
	 删除委托
	 @param entrustID
	 * @throws SQLException 
	*/
	//57
	void deleteEntrust(int entrustID) throws SQLException;
	//58
	/** 
	 获取工作流配置列表
	 @param ID 配置的数据字典ID
	 @return 
	 * @throws SQLException 
	*/
	//59
	java.util.List<WF_CONFIG> listConfig(int ID) throws SQLException;
	/** 
	 获取工作流配置信息
	 @param ID
	 @param subID
	 @return 
	 * @throws SQLException 
	*/
	//60
	WF_CONFIG getConfig(int ID, int subID) throws SQLException;
	/** 
	 获取工作流程第一个节点的活动id
	 @author 谢炎
	 @date 2016-12-2 16:42:28
	 @param flowId
	 @return 
	 * @throws SQLException 
	*/
	//61
	WF_ACTIVITY getFirstActivitys(int flowID) throws SQLException;
	/**
	 * 根据活动id删除活动权限表
	 * wf_activity_popedom
	 * @param activityID
	 * @throws SQLException
	 */
	//62
	void deleteWfActivityPopedom(int activityId);
	/**
	 * 根据活动id删除流转规则
	 * lixin
	 * 2017-9-13 14:21:09
	 * @param activityId
	 */
	//63
	void deleteWfRule(int activityId);
	/**
	 * 通过活动id和工作id获取工作活动集合
	 * lixin
	 * 2017-9-13 15:17:51
	 * @param activityId
	 * @param workId
	 * @return
	 */
	//64
	List<WF_WORK_ACTIVITY> listWorkActivity(int activityId,Integer workId);
	/**
	 * 删除axtivity下的workItem
	 * liixn
	 * 2017-9-14 08:20:29
	 * @param activityID
	 */
	//65
	void deleteActivitySonTable(int activityID);
	/**
	 *根据节点id删除节点
	 * @param nodeId
	 */
	//66
	void deleteWFActivity(int nodeId);
	/**
	 * 根据流程id删除所欲的监控者
	 * @param flowId
	 */
	//67
	void deleteMonitors(int flowId);
	/**
	 * 根据流程id删除所有的线
	 * @param flowId
	 */
	//68
	void deleteLineList(int flowId);
	/**
	 * 通过流程节点删除一个流程
	 * lixin
	 * 2018-3-16 17:33:33
	 * @param flowId
	 */
	//69
	void deleteFlow(int flowId);
}

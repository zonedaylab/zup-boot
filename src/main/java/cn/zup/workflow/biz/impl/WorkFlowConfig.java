package cn.zup.workflow.biz.impl;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.zup.workflow.biz.IWorkFlowConfig;
import cn.zup.workflow.config.ActivityType;
import cn.zup.workflow.model.ACTIVITY_POPEDOM;
import cn.zup.workflow.model.ENTRUST;
import cn.zup.workflow.model.FLOW_MANAGE;
import cn.zup.workflow.model.WF_ACTIVITY;
import cn.zup.workflow.model.WF_ACTIVITY_POPEDOM;
import cn.zup.workflow.model.WF_CONFIG;
import cn.zup.workflow.model.WF_ENTRUST;
import cn.zup.workflow.model.WF_FLOW;
import cn.zup.workflow.model.WF_FORM;
import cn.zup.workflow.model.WF_FORM_CONTROL;
import cn.zup.workflow.model.WF_LINE;
import cn.zup.workflow.model.WF_MONITOR;
import cn.zup.workflow.model.WF_SYSTEM;
import cn.zup.workflow.model.WF_WORK_ACTIVITY;
import cn.zup.workflow.structure.PagingData;
import cn.zup.workflow.structure.QueryParameter;
import cn.zup.workflow.util.StringHelper;

/** 
 工作流配置服务接口实现类
 
*/
@Service("configService")
public class WorkFlowConfig implements IWorkFlowConfig{
	@Autowired
	private cn.zup.workflow.dal.WF_ACTIVITY activityDal;
	@Autowired
	private cn.zup.workflow.dal.WF_FORM formDal;
	@Autowired
	private  cn.zup.workflow.dal.WF_FLOW flowDal;
	@Autowired
	private  cn.zup.workflow.dal.WF_CONFIG configDal;
	@Autowired
	private  cn.zup.workflow.dal.WF_MONITOR monitorDal;
	@Autowired
	private  cn.zup.workflow.dal.WF_LINE lineDal;
	@Autowired
	private  cn.zup.workflow.dal.WF_RULE ruleDal;
	@Autowired
	private  cn.zup.workflow.dal.WF_FORM_CONTROL formControlDal;
	@Autowired
	private  cn.zup.workflow.dal.WF_HANDLER handlerDal;
	@Autowired
	private  cn.zup.workflow.dal.WF_MSG_SET MsgSetDal;
	@Autowired
	private  cn.zup.workflow.dal.WF_ACTIVITY_POPEDOM activityPopedomDal;
	@Autowired
	private  cn.zup.workflow.dal.WF_SYSTEM systemDal;
	@Autowired	
	private  cn.zup.workflow.dal.WF_ACTIVITY_LAYOUT actLayoutDal;
	@Autowired		
	private  cn.zup.workflow.dal.WF_ENTRUST entrustDal;
	@Autowired
	private cn.zup.workflow.dal.WF_WORK_ACTIVITY wfWorkActivityDal;
	@Autowired
	private cn.zup.workflow.dal.WF_WORK_ITEM workItemDal;
	
	/** 
	 获取业务系统信息
	 @param systemID 业务系统ID
	 @return 系统信息实体
	 * @throws SQLException 
	*/
	//1
	public  WF_SYSTEM getSystem(int systemID) throws SQLException{
		return systemDal.GetModel(systemID);
	}
	/** 
	 获取业务系统列表
	 @return 系统信息列表
	*/
	//2
	public  List<WF_SYSTEM> listSystem()  {
		List<WF_SYSTEM> systemList = new ArrayList<WF_SYSTEM>();
	    try {
			systemList =  systemDal.GetListArray("");
		} catch (SQLException e) {	
			e.printStackTrace();
		}
		return systemList;
	}
	/** 
	 业务系统配置保存
	 @param modSystem 系统信息实体
	 @return 自增主键值
	*/
	//3
	public  int saveSystem(WF_SYSTEM modSystem){
		int result=0 ;
		if (modSystem.getSYSTEM_ID() != null){
			try {
				systemDal.Update(modSystem);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}else{
			try {
				result = systemDal.Add(modSystem);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	/** 
	 删除业务系统配置
	 @param systemID 系统ID
	 * @throws SQLException 
	*/
	//4
	public  void deleteSystem(int systemID) throws SQLException{
		systemDal.Delete(systemID);
	}		
	/** 
	 获取流程列表
	 @param systemID 系统ID
	 @return 
	 * @throws Exception 
	*/
	//5
	public  java.util.List<WF_FLOW> listFlow(int systemID) throws Exception{
		return flowDal.GetListArray("SYSTEM_ID="+systemID);
	}
	/** 
	 获取流程分页列表
	 @param queryParameter 查询参数
	 @param pageIndex 当前页码
	 @param pageSize 每页记录数>
	 @return 
	 * @throws Exception 
	*/
	//6
	public  PagingData<FLOW_MANAGE> listFlowPaging(QueryParameter queryParameter, int pageIndex, int pageSize) throws Exception{
		return flowDal.FlowPagingList(queryParameter, pageIndex, pageSize);
	}
	
	/** 
	 获取流程信息
	 @param formID 表单ID
	 @return 表单对象实体
	 * @throws SQLException 
	*/
	//7
	public  WF_FLOW getFlow(int flowId) throws SQLException{
		return flowDal.GetModel(flowId);
	}
	/** 
	 保存流程配置信息
	 @param flowModel 流程信息实体类
	 @return 自增主键值
	 * @throws SQLException 
	*/
	//8
	public int saveFlow(WF_FLOW flowModel) throws SQLException{
		int result = 1;	
		if(flowModel.getFLOW_ID() == 0)
			flowDal.add(flowModel);
		else
			flowDal.update(flowModel);	
		return result;
	}
	/** 
	 获取监控者列表
	 @param flowID 流程ID
	 @return 监控者列表
	 * @throws SQLException 
	*/
	//9
	public  java.util.List<WF_MONITOR> listMonitor(int flowID) throws SQLException{
		return monitorDal.GetListArray("FLOW_ID=" + flowID);
	}

	/** 
	 保存监控者配置
	 @param monitorModel 监控对象实体
	 @return 自增主键值MONITOR_ID
	*/
	//10
	public  int saveMonitor(WF_MONITOR monitorModel) throws SQLException{
		int result = 0;
		if (monitorModel.getMONITOR_ID() != 0){
			monitorDal.Update(monitorModel);
		}
		else{
			result = monitorDal.Add(monitorModel);
		}
		return result;
	}
	/** 
	 删除流程下的监控者配置
	 
	 @param flowID 流程ID
	 * @throws Exception 
	*/
	//11
	public  void deleteMonitor(int flowID) throws Exception{
		monitorDal.DeleteMonitor(flowID);
	}
	/** 
	 获取表单信息
	 @param formID 表单ID
	 @return 表单对象实体
	 * @throws SQLException 
	*/
	//12
	public  WF_FORM getForm(int formID) throws SQLException{
		return formDal.GetModel(formID);
	}
	/** 
	 获取自定义表单内容信息
	 @param formID 表单ID
	 @return 表单对象实体
	 * @throws SQLException 
	 * @throws UnsupportedEncodingException 
	*/
	//13
	public  String getFormAuto(int formID) throws SQLException, UnsupportedEncodingException{
		return formDal.GetFormAutoContent(formID);
	}
	/** 
	 获取表单列表
	 @param systemID 系统ID，传参为0时，返回所有表单列表
	 @return 表单对象实体列表
	 * @throws SQLException 
	*/
	//14
	public  java.util.List<WF_FORM> listForm(int systemID) throws SQLException{
		if (systemID != 0){
			return formDal.GetListArray("SYSTEM_ID=" + systemID);
		}else{
			return formDal.GetListArray("");
		}
	}
	/** 
	 获取表单列表
	 @param systemID 系统ID
	 @param parentFormID 父表单ID
	 @return 表单列表
	 * @throws SQLException 
	*/
	//15
	public  java.util.List<WF_FORM> listFormSub(int systemID, int parentFormID) throws SQLException{
		return formDal.GetListArray("SYSTEM_ID=" + systemID + " and PARENT_FORM_ID=" + parentFormID);
	}
	/** 
	 保存表单
	 @param formModel
	 @return 
	*/
	//16
	public  int saveForm(WF_FORM formModel) throws SQLException{
		int result = 0;
		if (formModel.getFORM_ID() != null){
			formDal.UpdateWorkForm(formModel);
		}else{
			result = formDal.AddOracle(formModel);
		}
		return result;
	}
	/** 
	 删除表单
	 @param formID 表单ID
	*/
	//17
	public  void deleteForm(int formID) throws SQLException{
		formDal.Delete(formID);
	}

	/** 
	 获取活动列表
	 @param flowID 流程ID
	 @return 活动列表
	*/
	//18
	public  java.util.List<WF_ACTIVITY> listActivity(int flowID) throws SQLException{
		return activityDal.GetListArray("FLOW_ID=" + flowID);
	}
	/** 
	 获取活动列表
	 @param fromId 表单ID
	 @return 活动列表
	*/
	//19
	public java.util.List<WF_ACTIVITY> getActivityListByFormId(int fromId) throws SQLException{
		return activityDal.GetListArray("FORM_ID=" + fromId);
	}
	/** 
	 获取活动列表
	 @param flowID 流程ID
	 @param activityCodes 活动编号
	 @return 活动列表
	*/
	//20
	public  java.util.List<WF_ACTIVITY> getActivityListByCodes(int flowID, String activityCodes) throws SQLException{
		return activityDal.GetListArray(flowID, activityCodes);
	}

	/** 
	 获取活动信息
	 @param activityID 活动ID
	 @return 活动类对象实体
	 * @throws SQLException 
	*/
	//21
	public  WF_ACTIVITY getAcitivity(int activityID) throws SQLException{
		return activityDal.GetModel(activityID);
	}
	/** 
	 保存下一步骤设置
	 @param activityID 活动ID
	 @param lineModelList 连线实体列表
	 * @throws SQLException 
	*/
	//22
	public  void saveActivityNext(int activityID, java.util.List<WF_LINE> lineModelList) throws SQLException{		
		Connection conn=null;
		try{
			try{
				//获取活动信息
				WF_ACTIVITY activityModel = activityDal.GetModel(activityID);
				//删除原有连线
				lineDal.Delete(activityModel.getFLOW_ID(), (int)activityModel.getACTIVITY_CODE());
				//添加新的连线
				String nextCodes = "";
				for (WF_LINE line : lineModelList){
					lineDal.Add(line);
					nextCodes += "," + line.getEND_CODE().toString();
				}
				//更新活动下一序号内容
				if (!StringHelper.isNullOrEmpty(nextCodes)){
					activityModel.setNEXT_ACTIVITY_CODE( nextCodes.substring(1));
				}else{
					activityModel.setNEXT_ACTIVITY_CODE(nextCodes);
				}
				activityDal.Update(activityModel);
				conn.commit();
			}
			catch (RuntimeException ex){
				conn.rollback();
				throw new RuntimeException(ex.getMessage());
			}
		}finally{
			conn.close();
		}
	}

	/** 添加活动
	 @param activityModel 活动实体
	 @param lineModel 线关系实体
	 @return 
	*/
	//23
	public  int saveActivity(WF_ACTIVITY activityModel, WF_LINE lineModel) throws SQLException{
		int result = 0;
		Connection conn=null;
		try{
			try{
				//添加新的活动
				if (activityModel.getACTIVITY_TYPE() == ActivityType.IntialStage.getValue() && activityDal.FirstActivityInfo(activityModel.getFLOW_ID()) != null){ //如果存在开始节点
					throw new RuntimeException("系统提示：已经存在开始节点！");
				}
				if (activityDal.GetModel(activityModel.getFLOW_ID(), Integer.parseInt(String.valueOf(activityModel.getACTIVITY_CODE()))) != null){
					throw new RuntimeException("系统提示：此序号已存在，请重新填写！");
				}
				result = activityDal.Add(activityModel);
				if (lineModel != null){
					//更新父活动的下一活动字段内容
					WF_ACTIVITY parentActivity = activityDal.GetModel(activityModel.getFLOW_ID(), lineModel.getBEGIN_CODE());
					String test1 = parentActivity.getACTIVITY_NAME();
					Boolean test3 =!(parentActivity.getACTIVITY_NAME() == null || parentActivity.getACTIVITY_NAME().length()<=0 );
					String test2 = !(parentActivity.getACTIVITY_NAME() == null || parentActivity.getACTIVITY_NAME().length()<=0 ) ? parentActivity.getNEXT_ACTIVITY_CODE() + "," + Integer.toString(activityModel.getACTIVITY_CODE()) : Integer.toString(activityModel.getACTIVITY_CODE());
					parentActivity.setNEXT_ACTIVITY_CODE ( !(parentActivity.getACTIVITY_NAME() == null || parentActivity.getACTIVITY_NAME().length()<=0 ) ? parentActivity.getNEXT_ACTIVITY_CODE() + "," + Integer.toString(activityModel.getACTIVITY_CODE()) : Integer.toString(activityModel.getACTIVITY_CODE()));
					activityDal.Update(parentActivity);
					//添加活动线条
					lineDal.Add(lineModel);
				}
				conn.commit();
			}catch (RuntimeException ex){
				throw new RuntimeException(ex.getMessage());
			}
		}finally{
			conn.close();
		}
		return result;
	}
	/** 
	 保存活动信息
	 @param activityModel
	 @return 
	*/
	//24
	public  int saveActivity(cn.zup.workflow.model.WF_ACTIVITY activityModel) throws SQLException{
		int result = 0;
		if (activityModel.getACTIVITY_ID() != 0){ //更新
			activityDal.Update(activityModel);
			result = activityModel.getACTIVITY_ID();
		}else{ //新增
			result = activityDal.Add(activityModel);
		}
		return result;
	}
	/** 
	 删除活动信息
	 @param activityID 活动ID
	*/
	//25
	public  void deleteActivity(int activityID) throws SQLException
	{
		activityDal.ActivityDel(activityID);

	}

	/** 
	 获取活动的下一活动列表
	 
	 @param activityID 活动ID
	 @return 下一活动列表
	 * @throws SQLException 
	*/
	public  java.util.List<cn.zup.workflow.model.WF_ACTIVITY> ActivityNextList(int activityID) throws SQLException
	{
		WF_ACTIVITY actModel = activityDal.GetModel(activityID);
		return activityDal.GetListArray("FLOW_ID=" + actModel.getFLOW_ID() + " and ACTIVITY_CODE in(" + actModel.getNEXT_ACTIVITY_CODE() + ")");
	}

	/** 
	 获取活动可设置的下一活动列表
	 
	 @param activityID 活动ID
	 @return 可选择的下一活动列表
	*/
	public  java.util.List<cn.zup.workflow.model.WF_ACTIVITY> ActivityNextSelList(int activityID) throws SQLException
	{
		WF_ACTIVITY actModel = activityDal.GetModel(activityID);
		return activityDal.GetListArray("FLOW_ID=" + actModel.getFLOW_ID() + " and ACTIVITY_CODE not in(" + actModel.getNEXT_ACTIVITY_CODE() + ")");
	}

		


		///#region 活动关系配置
	/** 
	 获取活动关系信息列表
	 
	 @param activityID 活动ID
	 @return 活动关系列表
	*/
	public  java.util.List<cn.zup.workflow.model.WF_LINE> listLine(int flowID) throws SQLException
	{
		return lineDal.GetListArray("FLOW_ID=" + flowID);
	}

	/** 
	  活动关系添加
	 
	 @param lineModel 关系实体
	 @return 自增主键LINE_ID
	*/
	public  int saveLine(cn.zup.workflow.model.WF_LINE lineModel) throws SQLException
	{
		int result = 0;
		if (lineModel.getLINE_ID()!=null&&lineModel.getLINE_ID() != 0) //更新
		{
			lineDal.Update(lineModel);
		}
		else //新增
		{
			result = lineDal.Add(lineModel);
		}
		return result;
	}

	/** 
	 删除活动关系
	 
	 @param activityID 活动ID
	*/
	public  void deleteLine(int activityID) throws SQLException
	{
		lineDal.Delete(activityID);
	}

		


		///#region 活动布局
	/** 
	 活动布局获取
	 
	 @param activityID
	 @return 
	*/
	public  cn.zup.workflow.model.WF_ACTIVITY_LAYOUT getActivityLayout(int activityID) throws SQLException
	{
		return actLayoutDal.GetModel(activityID);
	}

	/** 
	 活动布局保存
	 
	 @param actLayoutModel
	 @return 
	*/
	public  void saveActivityLayout(cn.zup.workflow.model.WF_ACTIVITY_LAYOUT actLayoutModel) throws SQLException
	{
		if (actLayoutDal.GetModel(actLayoutModel.getACTIVITY_ID()) != null)
		{
			actLayoutDal.Update(actLayoutModel);
		}
		else
		{
			actLayoutDal.Add(actLayoutModel);
		}
	}


		


		///#region 通知接收者配置

	/** 
	 获取通知设置列表
	 
	 @param activityID
	 @return 
	*/
	public  java.util.List<cn.zup.workflow.model.WF_MSG_SET> listMsgSet(int activityID) throws SQLException
	{
		return MsgSetDal.GetListArray(activityID);
	}

	/** 
	 通知接收者保存
	 
	 @param msgSetModel
	 @return 
	*/
	public  int saveMsgSet(cn.zup.workflow.model.WF_MSG_SET msgSetModel) throws SQLException
	{
		return MsgSetDal.Add(msgSetModel);
	}

	/** 
	 通知接收者
	 
	 @param activityId
	 * @throws Exception 
	*/
	public  void deleteMsgSet(int activityId) throws Exception
	{
		MsgSetDal.MsgSetDel(activityId);
	}


		


		///#region 操作者配置
	/** 
	 获取操作者列表
	 
	 @param activityID 活动ID
	 @return 操作者对象实体列表
	*/
	public  java.util.List<cn.zup.workflow.model.WF_HANDLER> listHandler(int activityID) throws SQLException
	{
		return handlerDal.GetListArray("ACTIVITY_ID=" + activityID);
	}
	
	/** 
	 *获取当前登录用户是否有权限
	 *@author 谢炎
	 *@date 2016-11-23 20:10:48
	 *@param activityID 活动ID
	 *@return 操作者对象实体列表
	 * @throws SQLException 
	*/
	public List<Integer>  getMenuFlowId(int handle, int handleType) throws SQLException{
		return handlerDal.getMenuFlowId(handle, handleType);
	}

	/** 
	 获取操作者信息
	 
	 @param handlerID 操作者ID
	 @return 操作者对象实体
	*/
	public  cn.zup.workflow.model.WF_HANDLER getHandler(int handlerID) throws SQLException
	{
		return handlerDal.GetModel(handlerID);
	}

	/** 
	 保存操作者信息
	 
	 @param handlerModel 操作者对象实体
	 @return 自增主键HANDLER_ID
	*/
	public  int saveHandler(cn.zup.workflow.model.WF_HANDLER handlerModel) throws SQLException
	{
		int result = 0;
		if (handlerModel.getHANDLER_ID() != 0) //更新
		{
			handlerDal.Update(handlerModel);
		}
		else //添加
		{
			result = handlerDal.Add(handlerModel);
		}
		return result;
	}

	/** 
	 删除操作者配置
	 
	 @param activityID 活动ID
	 * @throws Exception 
	*/
	public  void deleteHandler(int activityID) throws Exception
	{
		handlerDal.DeleteHandler(activityID);
	}


		


		///#region 流转规则配置

	/** 
	 获取活动的流转规则列表
	 
	 @param activityID 活动ID
	 @return 流转规则对象实体
	 * @throws Exception 
	*/
	public  java.util.List<cn.zup.workflow.model.ACTIVITY_RULE> listRule(int activityID) throws Exception
	{
		return ruleDal.RuleList(activityID);
	}

	/** 
	 获取活动的流转规则
	 
	 @param ruleID 流转规则ID
	 @return 流转规则对象实体
	*/
	public  cn.zup.workflow.model.WF_RULE getRule(int ruleID) throws SQLException
	{
		return ruleDal.GetModel(ruleID);
	}

	/** 
	 流转规则保存
	 
	 @param ruleModel 流转规则类对象实体
	 @return 自增主键RULE_ID
	 * @throws SQLException 
	*/
	public  int saveRule(cn.zup.workflow.model.WF_RULE ruleModel) throws SQLException
	{
		int result = 0;
		if (ruleModel.getRULE_ID()!=null&&ruleModel.getRULE_ID() != 0) //更新
		{
			ruleDal.Update(ruleModel);
		}
		else //新增
		{
			result = ruleDal.Add(ruleModel);
		}
		return result;
	}

	/** 
	 流转规则删除
	 
	 @param activityID 规则ID
	*/
	public  void deleteRule(int ruleID) throws SQLException
	{
		ruleDal.Delete(ruleID);
	}


		


		///#region 表单组件配置
	/** 
	 表单组件配置列表
	 
	 @param formID 表单ID
	 @return 表单组件类对象实体列表
	 * @throws Exception 
	*/
	public  java.util.List<cn.zup.workflow.model.FORM_CONTROL> listFormControl(int formID) throws Exception
	{
		return formControlDal.FormControlList(formID);
	}

	/** 
	 获取表单组件信息
	 
	 @param controlID 组件ID
	 @return 表单组件类对象实体
	*/
	public  cn.zup.workflow.model.WF_FORM_CONTROL getFormControl(int controlID) throws SQLException
	{
		return formControlDal.GetModel(controlID);
	}

	/** 
	 保存配置的表单组件
	 
	 @param formControlModel 表单实体
	 @return 自增主键CONTROL_ID
	*/
	public  int saveFormControl(WF_FORM_CONTROL formControlModel) throws SQLException
	{
		int result = 0;
		if (formControlModel.getCONTROL_ID()!=null&&formControlModel.getCONTROL_ID() != 0)
		{
			formControlDal.update(formControlModel);
			result = formControlModel.getCONTROL_ID();
		}
		else
		{
			result = formControlDal.add(formControlModel);
		}
		return result;
	}

	/** 
	 删除表单组件配置
	 
	 @param controlID 组件ID
	 * @throws SQLException 
	*/
	public  void deleteFormControl(int controlID) throws SQLException
	{
		formControlDal.delete(controlID);
	}


		


		///#region 组件权限配置
	/** 
	 获取组件权限列表
	 
	 @param activityID 活动ID
	 @return 组件权限列表
	 * @throws Exception 
	*/
	public  java.util.List<ACTIVITY_POPEDOM> listActivityPopedom(int activityID) throws Exception
	{
		return activityPopedomDal.ActivityPopedomList(activityID);
	}

	/** 
	 获取组件权限信息
	 
	 @param activityID 活动ID
	 @param controlID 组件ID
	 @return 组件权限实体
	 * @throws SQLException 
	*/
	public  WF_ACTIVITY_POPEDOM getActivityPopedom(int activityID, int controlID) throws SQLException
	{
		return activityPopedomDal.GetModel(activityID, controlID);
	}

	/** 
	 保存组件权限信息
	 
	 @param activityPopedomModel 组件权限实体
	*/
	public  void saveActivityPopedom(WF_ACTIVITY_POPEDOM activityPopedomModel) throws SQLException
	{
		if (activityPopedomDal.GetModel(activityPopedomModel.getACTIVITY_ID(), activityPopedomModel.getCONTROL_ID()) != null) //如果存在该条记录，则更新
		{
			activityPopedomDal.Update(activityPopedomModel);
		}
		else
		{
			activityPopedomDal.Add(activityPopedomModel);
		}
	}
	
	/** 
	 删除组件权限信息
	 @author antsdot
	 @date 2016-12-1 16:28:51
	 @param controlId 组件id
	*/
	public void deleteActivityPopedom(int activityId, int controlId) throws SQLException{
		activityPopedomDal.Delete(activityId, controlId);
	}


		///#region 委托人设置

	/** 
	 获取委托分页列表
	 
	 @param queryParameter 查询参数
	 @param userID 用户ID
	 @param pageIndex 当前页码
	 @param pageSize 每页记录数
	 @return 分页数据
	 * @throws Exception 
	*/
	public  PagingData<ENTRUST> listEntrustPaging(QueryParameter queryParameter, int userID, int pageIndex, int pageSize) throws Exception
	{
		return entrustDal.EntrustPagingList(queryParameter, userID, pageIndex, pageSize);
	}

	/** 
	 保存委托人设置
	 
	 @param entrustModel 委托实体
	 @return 
	*/
	public  int saveEntrust(WF_ENTRUST entrustModel) throws SQLException
	{
		return entrustDal.Add(entrustModel);
	}

	/** 
	 更新委托状态
	 
	 @param entrustID 委托ID
	 @param entrustState 委托状态
	 * @throws Exception 
	*/
	public  void saveEntrutState(int entrustID, int entrustState) throws Exception
	{
		entrustDal.UpdateEntrustState(entrustID, entrustState);
	}

	/** 
	 删除委托
	 
	 @param entrustID
	 * @throws SQLException 
	*/
	public  void deleteEntrust(int entrustID) throws SQLException
	{
	   entrustDal.Delete(entrustID);
	}
	/** 
	 获取工作流配置信息列表
	 
	 @param ID
	 @return 
	 * @throws SQLException 
	*/
	public  java.util.List<WF_CONFIG> listConfig(int ID) throws SQLException{
		return configDal.GetListArray("ID=" + ID);
	}

	/** 
	 获取工作流配置信息
	 
	 @param ID
	 @param subID
	 @return 
	 * @throws SQLException 
	*/
	public  WF_CONFIG getConfig(int ID, int subID) throws SQLException{
		return configDal.GetModel(ID, subID);
	}
	
	/** 
	 获取工作流程第一个节点的活动id
	 @author 谢炎
	 @date 2016-12-2 16:42:28
	 @param flowId
	 @return 
	 * @throws SQLException 
	*/
	public  WF_ACTIVITY getFirstActivitys(int flowID) throws SQLException{
		return activityDal.getFirstActivitys("FLOW_ID=" + flowID);
	}

	@Override
	public void deleteWfActivityPopedom(int activityId) {
		try {
			activityPopedomDal.deleteWfActivityPopedom(activityId);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public void deleteWfRule(int activityId) {
		try {
			ruleDal.deleteWfRule(activityId);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 通过活动id和工作id获取工作活动集合
	 * lixin
	 * 2017-9-13 15:17:51
	 * @param activityId
	 * @param workId
	 * @return
	 * @throws SQLException 
	 */
	@Override
	public List<WF_WORK_ACTIVITY> listWorkActivity(int activityId,Integer workId){
		List<WF_WORK_ACTIVITY> list=null;
		try {
			list= wfWorkActivityDal.getWorkActivityList(activityId, workId);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	/**
	 * 删除axtivity下的workItem
	 * liixn
	 * 2017-9-14 08:20:29
	 * @param activityID
	 */
	@Override
	public void deleteActivitySonTable(int activityID) {
		//删除workItem表
		workItemDal.deleteActivitySonTable(activityID);
		//删除workActivity
		wfWorkActivityDal.deleteActivitySonTable(activityID);
	}

	@Override
	public void deleteWFActivity(int nodeId) {
		wfWorkActivityDal.deleteWFActivity(nodeId);
	}

	@Override
	public void deleteMonitors(int flowId) {
		try {
			monitorDal.DeleteMonitor(flowId);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteLineList(int flowId) {
		lineDal.deleteLineList(flowId);		
	}

	@Override
	public void deleteFlow(int flowId) {
		try {
			flowDal.Delete(flowId);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
		
}

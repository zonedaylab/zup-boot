package cn.zup.workflow.biz.impl;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;
import cn.zup.rbac.entity.UserInfo;
import cn.zup.rbac.entity.UserSession;
import cn.zup.workflow.biz.IWorkFlowConfig;
import cn.zup.workflow.biz.IWorkFlowControl;
import cn.zup.workflow.biz.IWorkFlowMonitor;
import cn.zup.workflow.biz.WorkflowDispatchService;
import cn.zup.workflow.biz.impl.WorkParameter;
import cn.zup.workflow.config.ActivityProperty;
import cn.zup.workflow.config.ActivityType;
import cn.zup.workflow.config.BranchSelType;
import cn.zup.workflow.config.CommitFlag;
import cn.zup.workflow.config.HandlerAndMonitorType;
import cn.zup.workflow.model.FORM_CONTROL;
import cn.zup.workflow.model.WF_ACTIVITY;
import cn.zup.workflow.model.WF_HANDLER;
import cn.zup.workflow.structure.ActivityHandler;
import cn.zup.workflow.structure.FlowParameter;
import cn.zup.workflow.structure.FlowRequest;
import cn.zup.workflow.structure.SignInfo;
import cn.zup.workflow.util.*;


/**
 * 工作流调度服务，为业务控制器所调用
 * @author Administrator
 *
 */
@Service("workflowDispatchService")
public  class WorkflowDispathServiceImpl implements WorkflowDispatchService
{
	
	/** 
	 配置	 
	*/
	@Autowired
	private IWorkFlowConfig configService;
	/** 
	 监控	 
	*/
	@Autowired
	private IWorkFlowMonitor monitorService;
	/** 
	 流转控制	 
	*/
	@Autowired
	private IWorkFlowControl controler;
	/**
     * 业务回滚委托
     */	
	private Event bizRollbackEvent;
	//1
		 public String saveWorkflowDispatch(String actionType,FlowRequest flowRequest, SignInfo signInfo,List<Event> listEvent) throws SQLException, Exception {
			 /***********只添加的是this.signInfo = signInfo;***********/
			 //默认第一个event
			 Event event=listEvent.get(0);		 
			 String result="";
			 if (actionType.equals("Save"))
				result = workSave(flowRequest,signInfo,event);
	         else if (actionType.equals("Commit"))        	
	        	result = workCommit(flowRequest,signInfo,null,null,event);
	         else if (actionType.equals("Reject"))
	        	result = ActivityReject(flowRequest,signInfo);    
	         else 
	        	throw new RuntimeException("操作方法为 Save,Commit,Reject，请检查！");
	         return result;
		 }
		/**
		 * 联合消息策略重载工作流
		 * lixin
		 * 2016-12-20 10:27:37
		 * @param actionType
		 * @param flowRequest
		 * @param signInfo
		 * @param userList
		 * @return
		 * @throws SQLException
		 * @throws Exception
		 * 保存工作，同时获取下一个节点的id，并设置下一个节点的操作者为userList
		 */
		 //2
		 public String saveWorkflowDispatch(String actionType,FlowRequest flowRequest, SignInfo signInfo,List<UserInfo> userList,Integer operateFlag,List<Event> eventList) throws SQLException, Exception{
			 /***********只添加的是this.signInfo = signInfo;***********/
			 //默认第一个event
			 Event event=eventList.get(0);
			 String result="";
			 if (actionType.equals("Save") )
				result = workSave(flowRequest,signInfo,event);
	         else if (actionType.equals("Commit"))
	        	result = workCommit(flowRequest,signInfo,userList,operateFlag,event);  //
	         else if (actionType.equals("Reject"))
	        	result = ActivityReject(flowRequest,signInfo);    
	         else 
	        	throw new RuntimeException("操作方法为 Save,Commit,Reject，请检查！");
	         return result;
		 }
		 /**
		 * 强制终止工作,同时进行业务操作	
		 * @param flowID
		 * @param workID
		 * @param deleteWorkFlow
		 * @return
		 * @throws SQLException
		 * @throws Exception
		 * 返回删除业务的URL
		 */
		//3
	    public String deleteTerminationWork(int flowID, int workID,boolean deleteWorkFlow) throws SQLException, Exception	{		
			 String deleteActionName="";
	         //获取第一个节点的formid,并找到form下配置的组件类型为删除业务员数据的ActionName
	         int formID=(int)monitorService.getFirstActivity(flowID).getFORM_ID();
	         List<FORM_CONTROL> list= configService.listFormControl(formID);         
	         if (list.size() > 0){
	            // var control = list.Find(o => o.CONTROL_MEANING == (int)Zone.WorkFlow.Contracts.Setting.ControlMeaning.删除业务员数据);
	            // if (control != null)
	            //   deleteActionName = control.CONTROL_NAME;
	         }
	         else{//by liuxf ,直接进行约定。 ActionName 为 业务表单名字+WorkTerminate 2015/10/30
	            String formName=configService.getForm(formID).getURL();
	            deleteActionName = formName + "WorkTerminate";               
	         }
	         String mainBizKey = monitorService.getWorkInfo(workID).getMAIN_BIZ_KEY();//获取业务主键
	         Boolean success=true;
	         if (deleteWorkFlow)//删除工作流 
	              controler.deleteWork(workID);
	         else
	              success = controler.updateWorkTerminate(workID);//强制结束工作，只是设置状态，并不删除
	         if (success && !StringHelper.isNullOrEmpty(deleteActionName))  {//工作执行成功且能找到一个活动的页面
	             return deleteActionName + "?mainBizKey="  + mainBizKey;
	         }
	         return "";				
		}
		/** 
		    获取业务主键
		* @throws SQLException 
		*/
		//4
		public  String getMainBizKey(FlowRequest flowRequest) throws SQLException{
			int workID=getWorkID(flowRequest);
			if (workID != 0)
				return monitorService.getWorkInfo(workID).getMAIN_BIZ_KEY();
			else
				return "";
		}
		
		/**
		* 加载业务表单
		* @return
		* @throws Exception 
		* @throws SQLException 
		*/
		//5
		public ModelAndView getBizForm(FlowRequest flowRequest) throws SQLException, Exception{
			String url ="";
			int activityID=getActivityID(flowRequest);
			if(activityID>0){
				WF_ACTIVITY wfActivityModel=configService.getAcitivity(activityID);
				url = configService.getForm(wfActivityModel.getFORM_ID()).getURL();
			}
			else{
				throw new Exception("在加载表单时发现活动ID为空，请检查参数");	
			}
			ModelAndView mav = new ModelAndView(url);//实例化一个VIew的ModelAndView实例
			mav.addObject("FLOW_ID",  getFlowID(flowRequest));
		  return mav;
		}
	
		/**
		 * 具体提交业务所调用的方法
		 * @param flowRequest
		 * @param flowParam
		 * @return
		 * @throws Exception
		 */
		//6
	    public  ModelAndView saveCommitReal(FlowRequest flowRequest,FlowParameter flowParam) throws Exception {
	        try{    
	            if (flowParam.getActivityHandlerList() == null)
	                throw new Exception("没有下步骤活动信息！请检查配置");  
	            if (flowParam.getActivityHandlerList() == null)
	                throw new Exception("没有下步骤活动信息！可能是同部门约束，没有同部门审批者！");               
	            CommitFlag flag = controler.saveWorkCommit(flowParam.getFlowID(), flowParam.getWorkID(),
						flowParam.getActivityID(), flowParam.getMainBizKey(), flowParam.getWorkName(), 
						flowParam.getCurrentHandler(), flowParam.getSignInfo(), flowParam.getAttachList(), flowParam.getActivityHandlerList());
	            if (flag != CommitFlag.Success){ //工作保存失败，回滚业务
					if (flag == CommitFlag.Fail){
						bizRollback(flowParam.getMainBizKey());						
					}				
					throw new RuntimeException("工作保存失败,已经回滚业务");
				}
	            ActivityProperty actPro=ActivityProperty.forValue(
	            configService.getAcitivity(flowParam.getActivityID()).getACTIVITY_PROPERTY());
				if (getActivityType(flowRequest) ==ActivityType.IntialStage.getValue()&&actPro== ActivityProperty.BatchHandle){ //需要做批量处理的开始节点不跳转到代办
					String url = configService.getForm(new Integer(monitorService.getFirstActivity(flowParam.getFlowID()).getFORM_ID())).getURL();
					ModelAndView mav = new ModelAndView(url);//实例化一个VIew的ModelAndView实例
					mav.addObject("FLOW_ID",  getFlowID(flowRequest));
				    return mav;
				}
				else{
					return  new ModelAndView(PageUrlSetting(PageUrlType.WorkListUrl));
				}	
	        }
	        catch (Exception ex) {     
	            throw new Exception("工作提交失败：" +ex.getMessage());
	        }
	    }
	
	
	
	//==========================================================================
	//public 1
	public  boolean isNullOrEmpty(Object object){
		return object == null || object.equals("");
	}
	/** 
	根据flowRequest获取 操作者信息	 
	*/	
	//public 2
	public  UserSession getCurrentHandler(FlowRequest flowRequest){
		return flowRequest.getCurrentHandler();	
	}
	//public 3
	public void setBizRollbackEvent(Event event){
		bizRollbackEvent=event;				
	}
    /**
     *  todo：跳转节点选择界面
     * @param flowParam
     * @param selType
     * @return
     */
	//public 4
    public String  ActivitySel(FlowParameter flowParam, BranchSelType selType) {
        String url = PageUrlSetting(PageUrlType.ActivitySelUrl);      
		JSONObject json = new JSONObject();
		json.put("result", "nodesel");
		json.put("url", url);
		json.put("FlowID", flowParam.getFlowID());
		json.put("WorkID", flowParam.getWorkID());
		json.put("ActivityID", flowParam.getActivityID());
		json.put("MainBizKey", flowParam.getMainBizKey());
		json.put("SignOpinion", flowParam.getSignInfo().getSignOpinion());
		json.put("BranchSelType", selType);     
		return json.toString();
    }
	/** 
	 配置页面类型
	 
	*/
    //public 5
	public enum PageUrlType{
		/** 
		 代办工作
		*/
		WorkListUrl,
		/** 
		 活动选择
		*/
		ActivitySelUrl;
		public int getValue(){
			return this.ordinal();
		}
		public static PageUrlType forValue(int value){
			return values()[value];
		}
	}
	
	

	
	/** 
	根据flowRequest 获取流程信息
	*/
	//private 1
	private int getFlowID(FlowRequest flowRequest){
		String flowID =flowRequest.getFlowID();
		if (!isNullOrEmpty(flowID)){
			return Integer.parseInt(flowID.toString());
		}
		return 0;
	}
	/** 
	 根究flowRequest获取工作ID	 
	*/
	//private 2
	private int getWorkID(FlowRequest flowRequest){	
		String workID =flowRequest.getWorkID();
		if (!isNullOrEmpty(workID)){
			return Integer.parseInt(workID.toString());
		}
		return 0;
	}
	/** 
	 根据 flowRequest获取活动ID
	 * @throws Exception 
	*/
	//private 3
	private  int getActivityID(FlowRequest flowRequest) throws Exception{	
		String object=flowRequest.getActivityID();
		if (!isNullOrEmpty(object)){
			return Integer.parseInt(object.toString());
		}else if(this.getWorkItemID(flowRequest)!=0){
			return monitorService.getAcitivityIDbyWorkItem(this.getWorkItemID(flowRequest));
		}else{		
			return monitorService.getFirstActivity(getFlowID(flowRequest)).getACTIVITY_ID();	
		}
	}
	/**
	 *根据 flowRequest获取活动节点类型
	 * 当前多动对应的活动类型
	 * @throws Exception 
	 * @throws SQLException 
	*/
	//private 4
	private  int getActivityType(FlowRequest flowRequest) throws SQLException, Exception{
		return configService.getAcitivity(getActivityID(flowRequest)).getACTIVITY_TYPE();
	}
	/** 
	根据flowRequest获取 工作项ID
	*/
	//private 5
	private  int getWorkItemID(FlowRequest flowRequest){
		Object object=flowRequest.getWorkItemID();		
		if (!isNullOrEmpty(object)){
			return Integer.parseInt(object.toString());
		}
		else		
			return 0;
	}	

	/** 
	根据 flowRequest获取页面权限类型
	*/
	//private 6
	private  int getPopedomType(FlowRequest flowRequest){
		Object object=flowRequest.getPopedomType();
		if (!isNullOrEmpty(object)){
			return Integer.parseInt(object.toString());
		}
		else		
			return 0;		
	}
	
	/**
	 * 业务保存委托 
	 * 工作流活动保存。需要在子类中实现调用，如果该类不能满足子类的要求，
	 * 可以在子类中进行重载
	 * 注意保存活动ID为当前活动ID，不进行步骤地转移 以及经办人员的删除工作	 
	 */
	//private 7
	private WorkParameter bizSave(Event event) throws Exception{
		if(event==null)
			throw new RuntimeException("请进行业务委托！");
		else{
			WorkParameter workParam =(WorkParameter) event.invoke(); //保存业务数据
			if (workParam == null) //提醒，未保存业务			
				throw new RuntimeException("未保存业务,请检查！");
			return workParam;
		}
	}
	
	//private 8
	private void bizRollback(String mainBizKey) throws Exception{
		if(bizRollbackEvent!=null){			
			bizRollbackEvent.setParam(mainBizKey);
			bizRollbackEvent.invoke();
		}		
	}
	
	/**
	 * 工作保存
	 * @return
	 * @throws SQLException
	 * @throws Exception
	 */
	//private 9
	private String workSave(FlowRequest flowRequest, SignInfo signInfo,Event event) throws SQLException, Exception{	
		try{
			WorkParameter workParam=bizSave(event);//执行业务			
			java.util.ArrayList<Integer> attachList = AttachList();			
			//保存工作
			CommitFlag flag = controler.saveWorkSave(getFlowID(flowRequest), getWorkID(flowRequest), getActivityID(flowRequest),
					workParam.getBizKey(), workParam.getWorkName(), getCurrentHandler(flowRequest),	signInfo, attachList);
			
			if (flag != CommitFlag.Success){ //工作保存失败，回滚业务	
				if (flag == CommitFlag.Fail){	
					bizRollback(workParam.getBizKey());
				}
				throw new RuntimeException("工作保存失败"+workParam.getBizKey()+workParam.getWorkName());
			}			
			ActivityProperty actProperty=ActivityProperty.forValue(configService.getAcitivity(getActivityID(flowRequest)).getACTIVITY_PROPERTY());
			if (getActivityType(flowRequest) == ActivityType.IntialStage.getValue()&& actProperty==ActivityProperty.BatchHandle) {//需要做批量处理的开始节点不跳转到代办
				String url = configService.getForm(new Integer(monitorService.getFirstActivity(getFlowID(flowRequest)).getFORM_ID())).getURL();
			    //如果是需要集中频繁发起的工作，需要停留在发起流程页面					 
			    JSONObject json = new JSONObject();
				json.put("result", "SuccessAndRedo");
				json.put("url", url);	
				json.put("FLOW_ID",  getFlowID(flowRequest));
				return json.toString();
			}
			else{					  
				JSONObject json = new JSONObject();
				json.put("result", "Success");
				json.put("url", PageUrlSetting(PageUrlType.WorkListUrl));
				return json.toString();
			}
		}
		catch (RuntimeException ex){
			ex.printStackTrace();
			throw new RuntimeException("工作保存失败"+ex.getMessage());
		}			
	}
	
	/** 
	 扩展事务提交，工作流存储业务主表的主键值，
	 lixin
	 2016-12-26 09:05:33
	 联合消息策略为提交事务的方法增加了userlist参数
	 userlist 是一个人员列表，增加了可选办理工作的人员。
	 @param sender
	 @param e
	 * @throws Exception 
	 * @throws SQLException 
	*/
	//private 10
	private String workCommit(FlowRequest flowRequest, SignInfo signInfo,List<UserInfo> userList,Integer operateFlag,Event event) throws SQLException, Exception{
		WorkParameter workParam =bizSave(event); //保存业务
		FlowParameter flowParam = new FlowParameter();  //实体		
		java.util.ArrayList<Integer> attachList = AttachList();
		flowParam.setFlowID ( getFlowID(flowRequest));
		flowParam.setActivityID ( getActivityID(flowRequest));
		flowParam.setWorkID ( getWorkID(flowRequest));
		flowParam.setWorkName ( workParam.getWorkName());
		flowParam.setMainBizKey ( workParam.getBizKey());
		flowParam.setCurrentHandler ( getCurrentHandler(flowRequest));
		flowParam.setSignInfo ( signInfo);
		flowParam.setAttachList ( attachList);
		WF_ACTIVITY wfActivityModel=configService.getAcitivity(getActivityID(flowRequest));
		
		if(wfActivityModel==null)
			throw new SQLException("workCommit时获取当前活动ID为空，ActivityID="+getActivityID(flowRequest));
		
		BranchSelType branchSelType=BranchSelType.forValue(wfActivityModel.getBRANCH_SEL_TYPE());
		switch (branchSelType){
			case Default:				
				List<ActivityHandler> activityHandlerList = JudgeFlowRules(flowRequest);
				//只处理下一活动为一个的情况,针对消息策略
				if(activityHandlerList.size()==1){	
					if(userList!=null&&operateFlag==-1)	{//针对告警任务，操作者去重		
						for (int i = 0; i < userList.size(); i++) {
							for(int j=0;j<activityHandlerList.size();j++){
								if(activityHandlerList.get(0).getHanderList().get(j).getHANDLER()!=userList.get(i).getUserId()){//接收者去重
									WF_HANDLER wfhandler = new WF_HANDLER();  //实体
									wfhandler.setACTIVITY_ID(activityHandlerList.get(0).getActivityID());//下一个节点的activityID
									wfhandler.setHANDLER(userList.get(i).getUserId());
									wfhandler.setHANDLER_TYPE(HandlerAndMonitorType.User.getValue()); 
									wfhandler.setHANDLER_NAME(userList.get(i).getRealName());
									activityHandlerList.get(0).getHanderList().add(wfhandler);
								}
							}
						}
					}else if(userList!=null&&operateFlag==1){//针对售电不同公司审核流程，操作者求交集
						List<WF_HANDLER> handlerList=new ArrayList<WF_HANDLER>();
						Map<Integer,Integer> mapUser=new HashMap<Integer, Integer>();
						for (int i = 0; i < userList.size(); i++) {
							mapUser.put(userList.get(i).getUserId(), userList.get(i).getUserId());
						}
						for(int j=0;j<activityHandlerList.get(0).getHanderList().size();j++){
							if(mapUser.containsKey(activityHandlerList.get(0).getHanderList().get(j).getHANDLER())){
								handlerList.add(activityHandlerList.get(0).getHanderList().get(j));
							}
						}
						activityHandlerList.get(0).setHanderList(handlerList);
					}				
				}
				flowParam.setActivityHandlerList (activityHandlerList);						
				if (flowParam.getActivityHandlerList() == null ){
					throw new RuntimeException("流程节点没有配置好，没有下步骤活动信息！");
				}
				else if(flowParam.getActivityHandlerList().size()>0){//存在下一个活动节点
					if(flowParam.getActivityHandlerList().get(0).getHanderList().size()==0){
						JSONObject json = new JSONObject();
						json.put("result", "noHandler");//提示下一个活动节点，没有配置本公司的接收人，请先配置该公司的任务审核人
						return json.toString();
					}
				}
				CommitFlag flag = controler.saveWorkCommit(flowParam.getFlowID(), flowParam.getWorkID(),
						flowParam.getActivityID(), flowParam.getMainBizKey(), flowParam.getWorkName(), 
						flowParam.getCurrentHandler(), flowParam.getSignInfo(), flowParam.getAttachList(), flowParam.getActivityHandlerList());
				if (flag != CommitFlag.Success){ //工作保存失败，回滚业务	
					if (flag == CommitFlag.Fail){
						bizRollback(flowParam.getMainBizKey());				
					}				
					throw new RuntimeException("工作保存失败,已经回滚业务");
				}
				ActivityProperty actPro=ActivityProperty.forValue(configService.getAcitivity(flowParam.getActivityID()).getACTIVITY_PROPERTY());
				if (getActivityType(flowRequest) ==ActivityType.IntialStage.getValue()&&actPro== ActivityProperty.BatchHandle){ //需要做批量处理的开始节点不跳转到代办				    
					String url = configService.getForm(monitorService.getFirstActivity(flowParam.getFlowID()).getFORM_ID()).getURL();					
					JSONObject json = new JSONObject();
					json.put("result", "SuccessAndRedo");
					json.put("url", url);	
					json.put("FLOW_ID",  getFlowID(flowRequest));
					return json.toString();
				}
				else{					
					JSONObject json = new JSONObject();
					json.put("result", "Success");
					json.put("url", PageUrlSetting(PageUrlType.WorkListUrl));	
					return json.toString();
				}	
			 case Multiple:
                 return ActivitySel(flowParam, BranchSelType.Multiple);
             case Single:
                 return ActivitySel(flowParam, BranchSelType.Single);
             default:
                 return ActivitySel(flowParam, BranchSelType.Multiple);
		}
	}

    /**
     * 根据设置条件获取转向步骤
     * @param flowRequest
     * @return
     * @throws Exception
     */
	//private 11
    private List<ActivityHandler> JudgeFlowRules(FlowRequest flowRequest) throws Exception {
        try{
            List<ActivityHandler> activityHandlerList = new ArrayList<ActivityHandler>();
            WF_ACTIVITY wfActModel=configService.getAcitivity(getActivityID(flowRequest));
            String nextActivitiyCodes = wfActModel.getNEXT_ACTIVITY_CODE();
            if(wfActModel.getACTIVITY_TYPE()!=ActivityType.TerminateStage.getValue()&&nextActivitiyCodes==null)
            	throw new Exception("JudgeFlowRules，当前活动ID为["+wfActModel.getACTIVITY_ID()+"]不存在下一个活动编号NEXT_ACTIVITY_CODE，无法进行流转，请检查流程设计");
            if (!StringHelper.isNullOrEmpty(nextActivitiyCodes)) {
                //获取配置活动中符合流转规则的活动
                char[] charsToTrim = { ',', ' ' };
                nextActivitiyCodes = StringHelper.trimEnd(nextActivitiyCodes, ',');
                String[] activityCodeArray = nextActivitiyCodes.split(",");
                List<String> activityCodeList =Arrays.asList(activityCodeArray);   
                List<String> allowActivityCodes = activityCodeList;//最终结果集暂时存储默认配置节点

                //#region 根据条件跳转，依赖前台控件，暂不实现
                //List<Zone.WorkFlow.Entities.ACTIVITY_RULE> ruleList = config.RuleList(ActivityID);
                //if (ruleList != null && ruleList.Count > 0)
                //{
                //    //根据规则判断的需要流转的活动
                //    List<int> confirmActivityCodes = new List<int>();//符合流转条件的节点编号

                //    foreach (Zone.WorkFlow.Entities.ACTIVITY_RULE rule in ruleList)
                //    {
                //        //需要传递过来
                //        if (rule.JUDGE_BASIS.Length == 0)
                //            continue;
                //        string actrualValue = ControlValue(config.FormControlInfo(rule.CONTROL_ID).CONTROL_NAME);//获取配置控件的值
                //        if (string.IsNullOrEmpty(actrualValue))//若无法获取值则跳过
                //            continue;

                //        double value;//数值型判断条件
                //        switch (rule.CONDITIONS)
                //        {
                //            case (int)ConditionType.MoreThan:                                       //1.大于
                //                if (double.TryParse(actrualValue, out value))//若能转换double型
                //                    if (value > double.Parse(rule.JUDGE_BASIS))//默认配置的时候是下拉选择
                //                        confirmActivityCodes.Add(rule.GOTO_ACTIVITY);
                //                break;
                //            case (int)ConditionType.MoreThanOrEqual:                                //2.大于且等于
                //                if (double.TryParse(actrualValue, out value))//若能转换double型
                //                    if (value >= double.Parse(rule.JUDGE_BASIS))
                //                        confirmActivityCodes.Add(rule.GOTO_ACTIVITY);
                //                break;
                //            case (int)ConditionType.Equal:                                          //3.等于
                //                if (double.TryParse(actrualValue, out value))//若能转换double型
                //                    if (value == double.Parse(rule.JUDGE_BASIS))
                //                        confirmActivityCodes.Add(rule.GOTO_ACTIVITY);
                //                break;
                //            case (int)ConditionType.LessThan:                                       //4.小于
                //                if (double.TryParse(actrualValue, out value))//若能转换double型
                //                    if (value < double.Parse(rule.JUDGE_BASIS))
                //                        confirmActivityCodes.Add(rule.GOTO_ACTIVITY);
                //                break;
                //            case (int)ConditionType.LessThanOrEqual:                                //5.小于且等于
                //                if (double.TryParse(actrualValue, out value))//若能转换double型
                //                    if (value <= double.Parse(rule.JUDGE_BASIS))
                //                        confirmActivityCodes.Add(rule.GOTO_ACTIVITY);
                //                break;
                //            case (int)ConditionType.Contain:                                        //6.包含
                //                if (actrualValue.Contains(rule.JUDGE_BASIS))
                //                    confirmActivityCodes.Add(rule.GOTO_ACTIVITY);
                //                break;
                //            case (int)ConditionType.NoContain:                                      //7.不包含
                //                if (!actrualValue.Contains(rule.JUDGE_BASIS))
                //                    confirmActivityCodes.Add(rule.GOTO_ACTIVITY);
                //                break;
                //        }
                //    }
                //    allowActivityCodes = (from confirmActivityCode in confirmActivityCodes
                //                          join nextActivityCode in activityCodeList on confirmActivityCode equals nextActivityCode
                //                          select confirmActivityCode).ToList();
                //}
                //#endregion

                //返回节点经办人信息
                ActivityHandler activityHandler;
                WF_ACTIVITY activityInfo;
                for (int i=0;i< allowActivityCodes.size();i++){
                	int code=Integer.parseInt(allowActivityCodes.get(i));
                    activityInfo = monitorService.getActivity(getFlowID(flowRequest), code, 0);
                    if(activityInfo==null)
                    	throw new Exception("JudgeFlowRules中获取activityInfo为空,FlowID"+getFlowID(flowRequest)+"activity_code"+code);
                    activityHandler = new ActivityHandler();
                    activityHandler.setActivityCode(code);
                    activityHandler.setActivityID(activityInfo.getACTIVITY_ID());
                    activityHandler.setActivityName( activityInfo.getACTIVITY_NAME());
                    activityHandler.setHanderList(configService.listHandler(activityInfo.getACTIVITY_ID()));
                    activityHandlerList.add(activityHandler);
                }
            }
            return activityHandlerList;
        }
        catch (Exception ex){
            throw new Exception(ex.getMessage());
        }
    }   

    
	/** 
	 工作流活动回退方法。需要在子类中实现调用，如果
	 该类不能满足子类的要求，可以在子类中进行重载
	 * @return 
	 
	 @return 
	 * @throws Exception 
	 * @throws SQLException 
	*/
    //private 12
	private String ActivityReject(FlowRequest flowRequest,SignInfo signInfo) throws SQLException, Exception{
		try{
			//if (this.bizReject()) //驳回业务
				//判断是否详细填写驳回意见
				if (signInfo.getSignOpinion().length() < 10){
					JSONObject json = new JSONObject();
					json.put("result", "error");
					json.put("reason", "请详细填写驳回审批意见"); 
					return json.toString();
				}else{
					controler.getWorkReject(getFlowID(flowRequest), getWorkID(flowRequest),
							getActivityID(flowRequest), getCurrentHandler(flowRequest), signInfo); //执行工作驳回，
					JSONObject json = new JSONObject();
					json.put("result", "Success");
					json.put("url", PageUrlSetting(PageUrlType.WorkListUrl));
					return json.toString();
				}
		}
		catch (RuntimeException ex){
			//todo：提醒和日志
		}		
		return "Success";
	}
	/** 
	 获取代办页面位置
	 <p>配置名称为AppSettings中WorkListUrl和ActivitySelUrl</p>
	 @param type
	*/
	//private 13
	private String PageUrlSetting(PageUrlType type){
		String url = "";
		switch (type){
			case WorkListUrl:
				url = AppSettingInfo(PageUrlType.WorkListUrl.toString());
				break;
			case ActivitySelUrl:
				url = AppSettingInfo(PageUrlType.ActivitySelUrl.toString());
				break;
		}
		return url;
	}	

	/** 
	 获取上传附件列表
	 @return 
	*/
	//private 14
	private java.util.ArrayList<Integer> AttachList(){
		java.util.ArrayList<Integer> attactList = new java.util.ArrayList<Integer>();
		/*System.Web.UI.Control c = this.FindControl("SwfUploadControl");
		if (c != null){
			System.Web.UI.Control cSon = c.FindControl("gvwFile");
			if (cSon != null)	{
				java.lang.Class type = cSon.getClass();
				if (type == GridView.class){
					GridView gvwFile = (GridView)((cSon instanceof GridView) ? cSon : null);
					for (GridViewRow row : gvwFile.Rows){
						if (gvwFile.DataKeys[row.RowIndex].Values["WORK_ITEM_ID"].toString().equals("0"))
						{
							attactList.add(Integer.parseInt(gvwFile.DataKeys[row.RowIndex].Values["ATTACH_ID"].toString()));
						}
					}
				}
			}
		}*/
		return attactList;
	}

	/** 
	 获取配置信息
	 @param key 键
	 @return 
	*/
	//private 15
	private String AppSettingInfo(String key){
		if(key.equals(PageUrlType.WorkListUrl.toString()))
			return "rest/workflow/workPersonal/workList";
		else if(key.equals(PageUrlType.ActivitySelUrl.toString()))
			return "rest/workflow/workPersonal/nextActivitySelect";
		return "";
	}
}


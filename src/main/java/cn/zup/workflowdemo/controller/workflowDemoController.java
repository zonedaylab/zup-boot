package cn.zup.workflowdemo.controller;


import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import cn.zup.framework.aop.service.BusLog;
import cn.zup.framework.json.JsonDateValueProcessor;
import cn.zup.rbac.entity.Organ;
import cn.zup.rbac.entity.UserInfo;
import cn.zup.rbac.entity.UserSession;
import cn.zup.rbac.service.CodeConfigService;
import cn.zup.rbac.service.MerchantService;
import cn.zup.rbac.service.OrganPostService;
import cn.zup.rbac.service.UserService;
import cn.zup.workflow.biz.IWorkFlowConfig;
import cn.zup.workflow.biz.WorkflowDispatchService;
import cn.zup.workflow.biz.impl.WorkParameter;
import cn.zup.workflow.config.ActivityType;
import cn.zup.workflow.model.WF_ACTIVITY;
import cn.zup.workflow.structure.FlowRequest;
import cn.zup.workflow.structure.SignInfo;
import cn.zup.workflow.util.Event;
import cn.zup.workflowdemo.model.DemoSampleReceiveRegister;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import org.springframework.web.servlet.ModelAndView;

import cn.zup.rbac.entity.Menu;
import cn.zup.rbac.service.ResourceService;
import cn.zup.workflow.biz.IWorkFlowControl;
import cn.zup.workflow.biz.IWorkFlowMonitor;
import cn.zup.workflow.biz.impl.WorkFlowConfig;
import cn.zup.workflow.biz.impl.WorkFlowControl;
import cn.zup.workflow.biz.impl.WorkFlowMonitor;
import cn.zup.workflow.biz.impl.WorkflowDispathServiceImpl;
import cn.zup.workflow.structure.QueryParameter;
import cn.zup.workflowdemo.biz.DemoSampleService;
import cn.zup.workflowdemo.biz.impl.DemoSampleServiceImpl;
import cn.zup.workflowdemo.model.DemoSampleReceiveRegister;

/**
 * workflowDemo
 * lxf
 * 2019.09.27
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/rest/workflowdemo/demo")
public class workflowDemoController {
	@Resource
	private CodeConfigService codeConfigService;
	@Resource
	private MerchantService merchantService;
	@Resource
	private WorkflowDispatchService workflowDispatchService;
	@Resource
	private IWorkFlowConfig configService;
	@Resource
	private UserService userService;
	@Resource
	private OrganPostService organPostService;	
	@Resource
	private BusLog busLog;
	@Resource
	ResourceService resourceServie;
	@Resource
	private DemoSampleService demoSampleService; 

	/**
	 * 保存一个需求计划
	 * @param actionType
	 * @param flowRequest
	 * @param signInfo
	 * @param saleDemandPlan
	 * @param amounts
	 * @param request
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/saveWorkFlowDemo")
	@ResponseBody
	private String saveWorkFlowDemo(String actionType,FlowRequest flowRequest,SignInfo signInfo,
			DemoSampleReceiveRegister demoSampleReceiveRegister,
			HttpServletRequest request) throws Exception{
		
		UserSession userSession = (UserSession) request.getSession().getAttribute("usersession");
		List<UserInfo> userList=null;
		int activityId = 0;
		if(flowRequest.getActivityID() == null||flowRequest.getActivityID()==""){
			try {
				activityId =  configService.getFirstActivitys(Integer.parseInt(flowRequest.getFlowID())).getACTIVITY_ID();
			} catch (NumberFormatException e) {
				e.printStackTrace();
				busLog.addErrorLog("保存异常", "configService.AcitivityInfo("+activityId+")");
				throw new Exception("@保存异常，请及时联系管理员解决问题。");
			} catch (SQLException e) {
				e.printStackTrace();
				busLog.addErrorLog("保存异常", "configService.AcitivityInfo("+activityId+")");
				throw new Exception("@保存异常，请及时联系管理员解决问题。");
			}
		}else{
			activityId = Integer.parseInt(flowRequest.getActivityID());
		}
		//判断该节点是否为最后一个节点，确定是否修改审核状态
		WF_ACTIVITY activity=new WF_ACTIVITY();
		try {
			activity = configService.getAcitivity(activityId);
		} catch (SQLException e) {
			e.printStackTrace();
			busLog.addErrorLog("sql错误", "configService.AcitivityInfo("+activityId+")");
			throw new Exception("@sql异常，请及时联系管理员解决问题。");
		}
		//需要在工作流中加入枚举类型
		if( activity.getACTIVITY_TYPE() == ActivityType.TerminateStage.getValue() &&
				"Commit".equals(actionType) ){
			
			//saleDemandPlan.setCheck_State(CheckStateEnum.CHECKED.getValue());
		}
		if(activity.getACTIVITY_TYPE() == ActivityType.IntialStage.getValue()){
			//saleDemandPlan.setPurchaser_Id(organTemp.getOrganId());
			
		}
		//执行判断，为flowRequest为空赋值为0
		if("".equals(flowRequest.getWorkID())){
			flowRequest.setWorkID("0");
		}
		if("".equals(flowRequest.getWorkItemID())){
			flowRequest.setWorkItemID("0");
		}
		//封装业务数据
		
		//设置业务执行函数,myBizSave对应具体的业务函数，请根据情况进行修改
		Event event=new Event();
		event.setMethodName("myBizSave");
		event.setObject(this);
		event.setParam(demoSampleReceiveRegister);
		List<Event>listEvent=new ArrayList<Event>();
		listEvent.add(event);
		event=new Event();
		event.setMethodName("myBizRollbak");
		event.setObject(this);		
		listEvent.add(event);
		flowRequest.setCurrentHandler(userSession);	
		
		//1 取当前售电公司的人员和任何人取交集
		//用枚举
		String result="";
		try {
			result = workflowDispatchService.saveWorkflowDispatch(actionType,flowRequest, signInfo,userList,1,listEvent);
		} catch (Exception e) {
			e.printStackTrace();
			busLog.addErrorLog("保存异常", "configService.AcitivityInfo("+activityId+")");
			throw new Exception("@保存异常，请及时联系管理员解决问题。");
		}
		return result;
	}
	
	/**
	 * 业务处理函数
	 * @author liuxf
	 * @Date 2019.09.29 
	 * @return
	 */	
	@SuppressWarnings("unused")
	public WorkParameter myBizSave(DemoSampleReceiveRegister demoSampleReceiveRegister) throws SQLException
	{		
		/**书写自己的业务函数
		 * 
		 */
		//业务主键写入工作流
		int mainBizKey = 0;
		if(demoSampleReceiveRegister.getMainBizkey().length() > 1 ){
			mainBizKey = demoSampleService.UpdateSamleInfo(demoSampleReceiveRegister, demoSampleReceiveRegister.getMainBizkey());
		}else{
			mainBizKey = demoSampleService.SaveSamleInfo(demoSampleReceiveRegister);
		}
		/**
		 * 返回参数
		 */
		WorkParameter workParam=new WorkParameter();
		workParam.setBizKey(mainBizKey+"");
		String workName="工作流测试"+mainBizKey;
		workParam.setWorkName(workName);		 
		return workParam;		
	}
	/**
	 * 根据业务主键获取业务信息
	 * 
	 * 2019.11l.25
	 * @param mainBizKey
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getMainBizInfo")
	@ResponseBody 
	public String getMainBizInfo(String mainBizKey,HttpServletRequest request) throws Exception{
		UserSession userSession = (UserSession) request.getSession().getAttribute("usersession");
		Organ organ = merchantService.getMyCompany(userSession.getUserId());	
		
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String nowTime=sdf.format(new Date());
		JSONObject json = new JSONObject();
			
		if(mainBizKey!=null && mainBizKey!=""){
			//根据业务主键获取需求订单信息			
			DemoSampleReceiveRegister demo = demoSampleService.getSamleInfo(mainBizKey);			
			JSONArray jsonarr = JSONArray.fromObject(demo); 
			json.put("demo", jsonarr);			
			return json.toString();
		}else{
			throw new Exception("错误的工作流业务主键信息");
		}
	}
	
}
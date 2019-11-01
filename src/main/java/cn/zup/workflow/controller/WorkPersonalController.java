package cn.zup.workflow.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import cn.zup.framework.json.JsonDateValueProcessor;
import cn.zup.framework.util.AjaxJson;
import cn.zup.rbac.entity.System;
import cn.zup.rbac.entity.UserInfo;
import cn.zup.rbac.entity.UserSession;
import cn.zup.rbac.service.ResourceService;
import cn.zup.rbac.service.UserService;
import cn.zup.workflow.biz.IWorkFlowConfig;
import cn.zup.workflow.biz.IWorkFlowControl;
import cn.zup.workflow.biz.IWorkFlowMonitor;
import cn.zup.workflow.biz.WorkflowDispatchService;
import cn.zup.workflow.config.ConfigList;
import cn.zup.workflow.config.WorkState;
import cn.zup.workflow.controller.ViewEntity.Line;
import cn.zup.workflow.controller.ViewEntity.Node;
import cn.zup.workflow.dal.WF_WORK_ITEM;
import cn.zup.workflow.model.WF_ACTIVITY;
import cn.zup.workflow.model.WF_CONFIG;
import cn.zup.workflow.model.WF_FLOW;
import cn.zup.workflow.model.WF_FORM;
import cn.zup.workflow.model.WF_HANDLER;
import cn.zup.workflow.model.WF_LINE;
import cn.zup.workflow.model.WF_MONITOR;
import cn.zup.workflow.model.WF_WORK;
import cn.zup.workflow.model.WORK_DEALT;
import cn.zup.workflow.model.WORK_INIT;
import cn.zup.workflow.model.WORK_MONITOR;
import cn.zup.workflow.model.WORK_SIGN;
import cn.zup.workflow.model.WORK_TODO;
import cn.zup.workflow.structure.ActivityHandler;
import cn.zup.workflow.structure.FlowParameter;
import cn.zup.workflow.structure.FlowRequest;
import cn.zup.workflow.structure.PagingData;
import cn.zup.workflow.structure.QueryParameter;
import cn.zup.workflow.structure.SignInfo;
import cn.zup.workflow.util.StringHelper;
import cn.zup.workflow.biz.SampleReceiveRegisterService;

@Controller
@RequestMapping("rest/workflow/workPersonal")
public class WorkPersonalController {
	@Resource
	private ResourceService resourceService;
	@Resource
	private UserService userService;
	@Resource
	private IWorkFlowConfig configService;
	@Resource
	private SampleReceiveRegisterService demoSampleReceiveRegisterService; 
	@Resource
	private WorkflowDispatchService workflowDispatchService;
	@Resource
	private IWorkFlowControl controler;
	@Resource
	private IWorkFlowMonitor monitorService;
	@Resource
	private WF_WORK_ITEM item;
	
	/**
	 * 
	 * 已办理工作页面
	 * @author 谢炎
	 * @date 2016-8-16 15:34:01
	 * 
	 * */
	@RequestMapping("/WorkFinish")
	public ModelAndView WorkFinish(HttpServletRequest request){
		return new ModelAndView("workflow/wfWorkFinish");
	}
	
	/**
	 * 加载已办理工作列表
	 * 
	 * @param parameters
	 * @param flowName
	 * @param flowState
	 * @return
	 * @throws Exception 
	 * @throws Exception
	 */
	@RequestMapping("/WorkFinish/WorkFinishQuery")
	@ResponseBody
	public  String WorkFinishQuery(QueryParameter queryParameter, int page, int rows, HttpServletRequest request) throws Exception{
		PagingData<WORK_DEALT> pageData = monitorService.listWorkDealt(queryParameter, userService.getCurrentHandler(request), page, rows);

		JSONObject json = new JSONObject();
		json.put("rows", rows);
		json.put("page", page);
		json.put("total", pageData.getAmount());
		json.put("data", pageData.getData());
		return json.toString();
	}
	
	/**
	 * 查看详情事件
	 * @author 谢炎
	 * @date 2016-9-6 01:15:04
	 * */
	@RequestMapping("/WorkFinishDetail")
	public ModelAndView WorkFinishDetail(FlowRequest flowRequest, String statId, HttpServletRequest request) throws SQLException, Exception
	{
		if(!"".equals(flowRequest.getWorkItemID()) && flowRequest.getWorkItemID() != null){
			flowRequest = demoSampleReceiveRegisterService.getWorkItemActivety(flowRequest.getWorkItemID(), statId);
		}
		String mainBizKey=workflowDispatchService.getMainBizKey(flowRequest);
		int formID = configService.listActivity(Integer.parseInt(flowRequest.getFlowID())).get(0).getFORM_ID();
		String content = configService.getFormAuto(formID);
		if(content!=null){
			if(content.length() == 0){
				ModelAndView mv=workflowDispatchService.getBizForm(flowRequest);
				mv.addObject("formID", formID);
				mv.addObject("mainBizKey", mainBizKey);
				mv.addObject("flowRequest", flowRequest);
				mv.addObject("id", "check");
				mv.addObject("flag", "2");
				return mv;	
			}
			else{
				ModelAndView mv = new ModelAndView("workflow/wfWorkFormAuto");
				mv.addObject("formID", formID);
				mv.addObject("mainBizKey", mainBizKey);
				mv.addObject("html", content);
				mv.addObject("flowRequest", flowRequest);
				mv.addObject("id", "check");
				mv.addObject("flag", "2");
				return mv;	
			}
		}
		else{
			ModelAndView mv = new ModelAndView("workflow/wfWorkFormAuto");
			mv.addObject("formID", formID);
			mv.addObject("mainBizKey", mainBizKey);
			mv.addObject("html", content);
			mv.addObject("flowRequest", flowRequest);
			mv.addObject("id", "check");
			mv.addObject("flag", "2");
			return mv;	
		}
	}
	
	/**
	 * 
	 * 流程图查看页面
	 * 
	 * */
	@RequestMapping("/WorkFlowView")
	public ModelAndView WorkFlowView(HttpServletRequest request){
		return new ModelAndView("workflow/workFlowView");
	}
	
	/**
	 * 获取流程图人员
	 * Author：谢炎
	 * Date:2016-9-5 14:40:28
	 * @param workID
	 **/
	@RequestMapping("/WorkFlowViewPersion")
	@ResponseBody
	public AjaxJson WorkFlowViewPersion(int workID) throws SQLException
	{
		WF_WORK workInfo = monitorService.getWorkInfo(workID);
		int flowID = workInfo.getFLOW_ID();
	    List<WF_ACTIVITY> listWFActivity = configService.listActivity(flowID);
	    List<WF_LINE> 	  listWFLine = configService.listLine(flowID);
	    WF_FLOW modWFFlow = configService.getFlow(flowID);
	    
	    Map<String,List<Map<String,?>>> map=new HashMap<String, List<Map<String,?>>>();
		List<Map<String,?>> listNode=new ArrayList<Map<String,?>>();
	    List<Map<String,?>> listLine=new ArrayList<Map<String,?>>();
        for (int i = 0; i < listWFActivity.size(); i++){
    		Map<String,Node> childNodeMap=new HashMap<String, Node>();
	        WF_ACTIVITY activity=listWFActivity.get(i);
        	Node node = new Node();
        	node.setName(activity.getACTIVITY_NAME());
        	node.setLeft(activity.getACTIVITY_LEFT());
        	node.setTop(activity.getACTIVITY_TOP());
        	node.setType(activity.getACTIVITY_ICON());
        	node.setNodeId(activity.getACTIVITY_ID());
        	node.setState(0);
        	childNodeMap.put(String.valueOf(activity.getACTIVITY_ID()), node);
        	listNode.add(childNodeMap);
        }
        for (int i = 0; i < listWFLine.size(); i++)
        {
    		Map<String,Line> childLineMap=new HashMap<String, Line>();
        	WF_LINE wfLine=listWFLine.get(i);
        	Line line = new Line();
        	line.setType("");
        	line.setLineid(wfLine.getLINE_ID());
        	//line.setM(GetInflection(wfLine.getLINE_INFLECTION()));
        	line.setFrom(String.valueOf(wfLine.getBEGIN_CODE()));
        	line.setTo(String.valueOf(wfLine.getEND_CODE()));
        	//line.setName(wfLine.getLINE_NAME());
        	line.setMarked("");
        	childLineMap.put(String.valueOf(wfLine.getLINE_ID()), line);
        	listLine.add(childLineMap);
        }
		map.put("nodes", listNode);
		map.put("lines", listLine);
		Map<String, Object> mapObject = new HashMap<String, Object>();
		mapObject.put("data", map);
		AjaxJson j = new AjaxJson();
		j.setAttributes(mapObject);
		return j;
	}
	
	/**
	 * 获取流程图操作者信息
	 * Author：谢炎
	 * Date:2016-8-23 10:44:12
	 * @param workID
	 **/
	@RequestMapping("/GetMonitorInfo")
	@ResponseBody
	public String GetMonitorInfo(int workID) throws SQLException
	{
		WF_WORK workInfo = monitorService.getWorkInfo(workID);
		int flowID = workInfo.getFLOW_ID();
		List<WF_MONITOR> FlowPicList = configService.listMonitor(flowID);
		List<String> list = new ArrayList<String>();
		for(int i=0; i<FlowPicList.size(); i++){
			WF_CONFIG monitorInfo = configService.getConfig(ConfigList.HandlerAndMonitorType.getValue(), FlowPicList.get(i).getMONITOR());
			list.add(monitorInfo.getSUB_NAME());
		}
		JSONObject json = new JSONObject();
		json.put("data", list);
		return json.toString();
	}
	
	/**
	 * 审批过程页面显示
	 * Author：谢炎
	 * Date: 2016-8-23 11:39:40
	 * @param 
	 * @throws UnsupportedEncodingException 
	 **/
	@RequestMapping("/WorkFlowCheckView")
	public ModelAndView WorkFlowCheckView(HttpServletRequest request) throws UnsupportedEncodingException{
		ModelAndView mv = new ModelAndView("workflow/workFlowWorkHistoryInfo");
		java.lang.System.err.println(URLDecoder.decode(request.getParameter("title") , "UTF-8"));
		mv.addObject("title", URLDecoder.decode(request.getParameter("title") , "UTF-8"));
		return mv;
	}

	/**
	 * 获取审批流程 
	 * Author：谢炎
	 * Date:2016.8.10 
	 * @param 
	 **/
	@RequestMapping("/getWorkFlowCheckInfo")
	@ResponseBody
	public AjaxJson GetWorkFlowData(int workID) throws SQLException
	{
		WF_WORK workInfo = monitorService.getWorkInfo(workID);
		int flowID = workInfo.getFLOW_ID();
	    List<WF_ACTIVITY> listWFActivity = configService.listActivity(flowID);
	    List<WF_LINE> 	  listWFLine = configService.listLine(flowID);
	    WF_FLOW modWFFlow = configService.getFlow(flowID);
	    
	    Map<String,List<Map<String,?>>> map=new HashMap<String, List<Map<String,?>>>();
		List<Map<String,?>> listNode=new ArrayList<Map<String,?>>();
	    List<Map<String,?>> listLine=new ArrayList<Map<String,?>>();
		
        for (int i = 0; i < listWFActivity.size(); i++){
    		Map<String,Node> childNodeMap=new HashMap<String, Node>();
	        WF_ACTIVITY activity=listWFActivity.get(i);
        	Node node = new Node();
        	node.setName(activity.getACTIVITY_NAME());
        	node.setLeft(activity.getACTIVITY_LEFT());
        	node.setTop(activity.getACTIVITY_TOP());
        	node.setType(activity.getACTIVITY_ICON());
        	node.setNodeId(activity.getACTIVITY_ID());
    		List<cn.zup.workflow.model.WF_WORK_ITEM> workItem = item.GetListArray(workID, activity.getACTIVITY_ID());
        	if(workItem.size() > 0)
        		node.setState(workItem.get(0).getWORK_ITEM_STATE());
        	childNodeMap.put(String.valueOf(activity.getACTIVITY_ID()), node);
        	listNode.add(childNodeMap);
        }

        for (int i = 0; i < listWFLine.size(); i++)
        {
    		Map<String,Line> childLineMap=new HashMap<String, Line>();
        	WF_LINE wfLine=listWFLine.get(i);
        	Line line = new Line();
        	line.setType("");
        	line.setLineid(wfLine.getLINE_ID());
        	//line.setM(GetInflection(wfLine.getLINE_INFLECTION()));
        	line.setFrom(String.valueOf(wfLine.getBEGIN_CODE()));
        	line.setTo(String.valueOf(wfLine.getEND_CODE()));
        	//line.setName(wfLine.getLINE_NAME());
        	line.setMarked("");
        	childLineMap.put(String.valueOf(wfLine.getLINE_ID()), line);
        	listLine.add(childLineMap);
        }
		map.put("nodes", listNode);
		map.put("lines", listLine);
		
		Map<String, Object> mapObject = new HashMap<String, Object>();
		mapObject.put("data", map);
		AjaxJson j = new AjaxJson();
		j.setAttributes(mapObject);
		return j;
	}
	
	/**
	 * 获取活动信息
	 * Author：谢炎
	 * Date:2016-8-23 10:44:12
	 * @param workID
	 **/
	@RequestMapping("/GetActivityInfo")
	@ResponseBody
	public String GetActivityInfo(int activityID, int workID) throws SQLException
	{
		List<cn.zup.workflow.model.WF_WORK_ITEM> acitivityInfo = item.GetListArray(workID, activityID);
		JSONObject json = new JSONObject();
		json.put("data", acitivityInfo);
		return json.toString();
		
	}
	
	/**
	 * 打印模板显示
	 * @author 谢炎
	 * @date 2016-9-6 16:00:52
	 * */
	@RequestMapping("/WorkFlowPrint")
	public ModelAndView WorkFlowPrint(HttpServletRequest request) throws SQLException, Exception{
		return new ModelAndView("workflow/wfWorkFlowPrint");
	}
	
	/**
	 * 工作流签字打印
	 * 
	 * */
	@RequestMapping("/workflowSignPrint")
	@ResponseBody
	public String workflowSignPrint(String WORK_ID) {
		int workID = Integer.parseInt(WORK_ID);
		List<WORK_SIGN> workSign = monitorService.listWorkSign(workID);
		/*
		 * var signDetail = from sign in workSign select new {
		 * ACTIVITY_NAME=sign.ACTIVITY_NAME, SIGN_DATE =sign.SIGN_DATE,
		 * SIGN_NAME =sign.SIGN_NAME, SIGN_OPINION =sign.SIGN_OPINION,
		 * WORK_NAME=monitorService.WorkInfo(workID).WORK_NAME };
		 */
		/*StringBuilder jsondata = new StringBuilder();
		jsondata.append("{");
		jsondata.append("\"Recordset\":");
		// jsondata.append(JSON.Serialize(signDetail));
		jsondata.append("}");*/
		JSONObject json = new JSONObject();
		//日期类型转换
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(Date.class,new JsonDateValueProcessor("yyyy-MM-dd HH:mm:ss"));
		JSONArray jsonArray = JSONArray.fromObject(workSign,jsonConfig);
		json.put("data", jsonArray);
		return json.toString();
	}
	
	
	
	
	/**
	 * 
	 * 监控页面
	 * @author 谢炎
	 * @date 2016-8-16 15:34:01
	 * 
	 * */
	@RequestMapping("/WorkMonitor")
	public ModelAndView WorkMonitor(HttpServletRequest request){
		return new ModelAndView("workflow/wfWorkMonitor");
	}
	
	/**
	 * 加载监控工作列表
	 * 
	 * @param parameters
	 * @param flowName
	 * @param flowState
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/WorkMonitor/WorkMonitorQuery")
	@ResponseBody
	public  String WorkMonitorQuery(QueryParameter queryParameter, int page, int rows, HttpServletRequest request)
			throws Exception {
		PagingData<WORK_MONITOR> pageData = monitorService.listMonitor(queryParameter, userService.getCurrentHandler(request), page, rows);

		JSONObject json = new JSONObject();
		json.put("rows", rows);
		json.put("page", page);
		json.put("total", pageData.getAmount());
		json.put("data", pageData.getData());
		return json.toString();
	}
	
	
	/**
	 * 简单版本加载监控工作列表
	 * 刘德丽20161220
	 * @param parameters
	 * @param flowName
	 * @param flowState
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/WorkMonitor/getWorkMonitorQuery")
	@ResponseBody
	public  String getWorkMonitorQuery(QueryParameter queryParameter, int page, int rows, HttpServletRequest request)
			throws Exception {
		PagingData<WF_WORK> pageData = monitorService.listWorkMonitor(queryParameter, userService.getCurrentHandler(request), page, rows);

		JSONObject json = new JSONObject();
		JsonConfig jsonConfig = new JsonConfig();	
		jsonConfig.registerJsonValueProcessor(Date.class,new JsonDateValueProcessor());
		JSONArray jsonArray = JSONArray.fromObject(pageData.getData(),jsonConfig);
		json.put("rows", rows);
		json.put("page", page);
		json.put("total", pageData.getAmount());
		json.put("data", jsonArray);
		return json.toString();
	}
	
	
	
	
	/**
	 * 
	 * 代办工作页面
	 * @author 谢炎
	 * @date s2016-8-16 10:27:27
	 * 
	 * */
	@RequestMapping("/workList")
	public ModelAndView workList(HttpServletRequest request){
		return new ModelAndView("workflow/wfWorkList");
	}
	/**
	 * 
	 * 代办工作页面
	 * @author 谢炎
	 * @date s2016-8-16 10:27:27
	 * 
	 * */
	@RequestMapping("/mobileworkList")
	public ModelAndView mobileworkList(HttpServletRequest request){
		return new ModelAndView("workflow/mobilewfWorkList");
	}
	/**
	 * 手机端已办工作
	 * 2016-12-5 17:30:50
	 * lixin
	 * @param request
	 * @return
	 */
	@RequestMapping("/mobileworkListFinish")
	public ModelAndView mobileworkListFinish(HttpServletRequest request){
		return new ModelAndView("workflow/mobilewfWorkListFinish");
	}
	/**
	 * 加载待办工作列表
	 * 
	 * @param parameters
	 * @param flowName
	 * @param flowState
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/workList/workListQuery")
	@ResponseBody
	public  String WorkListQuery(QueryParameter queryParameter, int page, int rows, HttpServletRequest request){
		PagingData<WORK_TODO> pageData = null;
		try{
			pageData = monitorService.listWork(queryParameter, userService.getCurrentHandler(request), page,rows);
		}catch(Exception ex){
			ex.printStackTrace();
		}
		JSONObject json = new JSONObject();
		json.put("rows", rows);
		json.put("page", page);
		json.put("total", pageData.getAmount());		
		json.put("data", pageData.getData());
		return json.toString();
	}
	
	

	/**
	 * 
	 * 绑定系统名字
	 * 
	 * @author liuxf
	 * @date：2016.07.28
	 * @return 系统 信息列表
	 * @throws SQLException
	 */
	@RequestMapping("/SystemName")
	@ResponseBody
	public String systemNameBind() {
		List<System> system = resourceService.getSystemList();
		JSONObject json = new JSONObject();
		json.put("system", system);
		return json.toString();
	}

	/**
	 * 删除我发起的工作
	 * 同时需要删除业务数据，调用form表单中存储的业务删除控制层的删除方法
	 * @param workID
	 * @return
	 * @throws IOException
	 * @throws Exception
	 */
	@RequestMapping("/WorkFlowDel")
	@ResponseBody
	public  String WorkFlowDel(@RequestParam("workIds[]") String[] workIDs, HttpServletRequest request, HttpServletResponse response)throws Exception {
		JSONObject json = new JSONObject();
		for(int i=0; i<workIDs.length; i++){
			int activityID = monitorService.deleteTerminateActivity(Integer.parseInt(workIDs[i])).getActivityID();
			try {
				if (configService.getAcitivity(activityID).getACTIVITY_TYPE() != 1) {  //只有保存的工作才能删除
					json.put("result", "error");
					json.put("reson", "工作在发起节点的时候才能删除");
					throw new RuntimeException("@只有在工作在发起节点的时候才能删除");
				}
				WF_WORK work = monitorService.getWorkInfo(Integer.parseInt(workIDs[i]));   //只是通过workId删除一条工作
				if (work.getWORK_STATE() == WorkState.InProgress.getValue()) {
					String url = workflowDispatchService.deleteTerminationWork(work.getFLOW_ID(), work.getWORK_ID(), true);
					if(url.length() > 0){
						//删除业务数据1：通过form获取所属的controller，后边加del后缀，代表在此调用删除业务数据方法。
						int formID=(int)monitorService.getFirstActivity(work.getFLOW_ID()).getFORM_ID();
						WF_FORM form=configService.getForm(formID);
						if(form!=null){
							String bizController=form.getFORM_DELBIZ_CONTROLLER();
							json.put("result", "success");
							json.put("reson", "工作删除成功");
							json.put("deleteBiz","false");
							if(bizController!=null){
								json.put("delUrl", bizController+"/deleteBizData?mainBizKey="+work.getMAIN_BIZ_KEY());
								json.put("deleteBiz","true");
							}
							return json.toString();
						}
					}else{
						json.put("result", "error");
						json.put("reson", "删除失败");
						return json.toString();
					}
				} else {
					json.put("result", "error");
					json.put("reson", "只能删除正在办理的工作");
					throw new RuntimeException("@只能删除正在办理的工作");
				}
			}catch (RuntimeException ex) {
				json.put("result", "error");
				json.put("reson", "删除失败" + ex.getMessage());
				return json.toString();
			}
		}
		return json.toString();
	}

	/**
	 * 加载发起工作列表
	 * 
	 * @param parameters
	 * @param flowName
	 * @param flowState
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/WorkInitQuery")
	@ResponseBody
	public String WorkInitQuery(String systemID, String workName,
			String flowName, String activityName, String workDateStat,
			String workDateEnd, int page, int rows, HttpServletRequest request)
			throws Exception {

		QueryParameter queryParameter = new QueryParameter();
		// 查询参数赋值
		if (!StringHelper.isNullOrEmpty(systemID)) {
			queryParameter.setSystemID(Integer.parseInt(systemID));
		}
		if (!StringHelper.isNullOrEmpty(flowName)) {
			queryParameter.setFlowName(flowName);
		}
		if (!StringHelper.isNullOrEmpty(workName)) {
			queryParameter.setWorkName(workName);
		}
		if (!StringHelper.isNullOrEmpty(activityName)) {
			queryParameter.setActivityName(activityName);
		}
		if (!StringHelper.isNullOrEmpty(workDateStat)) {
			queryParameter.setFromDate(workDateStat);
		}
		if (!StringHelper.isNullOrEmpty(workDateEnd)) {
			queryParameter.setToDate(workDateEnd);
		}

		PagingData<WORK_INIT> pageData = monitorService.listWorkInit(
				queryParameter, userService.getCurrentHandler(request), page,
				rows);

		JSONObject json = new JSONObject();
		json.put("rows", rows);
		json.put("page", page);
		json.put("total", pageData.getAmount());
		java.lang.System.out.println("====================="
				+ pageData.getAmount());
		json.put("data", pageData.getData());
		return json.toString();

	}

	

	/**
	 * 暂停工作
	 * 
	 * @param workID
	 * @return
	 * @throws SQLException
	 * @throws
	 */

	@RequestMapping("/WorkFlowPause")
	@ResponseBody
	public  String WorkFlowPause(String workID) throws Exception {
		if (StringHelper.isNullOrEmpty(workID)) {
			JSONObject json = new JSONObject();
			json.put("result", "error");
			json.put("reson", "请选择工作");
			return json.toString();
		}

		controler.updateWorkPause(Integer.parseInt(workID));
		JSONObject json = new JSONObject();
		json.put("result", "success");
		return json.toString();

	}

	/**
	 * 重启工作
	 * 
	 * @param workID
	 * @return
	 * @throws Exception
	 * @throws
	 */

	@RequestMapping("/WorkFlowReLaunch")
	@ResponseBody
	public  String WorkFlowReLaunch(String workID) throws Exception {
		if (StringHelper.isNullOrEmpty(workID)) {
			JSONObject json = new JSONObject();
			json.put("result", "error");
			json.put("reson", "请选择工作");
			return json.toString();
		}
		controler.updateWorkRelaunch(Integer.parseInt(workID));
		JSONObject json = new JSONObject();
		json.put("result", "success");
		return json.toString();

	}

	/**
	 * 强制结束工作
	 * 
	 * @param workID
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/WorkFlowForceStop")
	@ResponseBody
	public  String WorkFlowForceStop(String workID,
			HttpServletResponse response) throws Exception {
		try {
			if (StringHelper.isNullOrEmpty(workID)) {
				JSONObject json = new JSONObject();
				json.put("result", "error");
				json.put("reson", "请选择工作");
				return json.toString();
			}
			WF_WORK work = monitorService.getWorkInfo(Integer
					.parseInt(workID));
			if (work.getWORK_STATE() == WorkState.InProgress.getValue()) {
				String url = workflowDispatchService.deleteTerminationWork(work
						.getFLOW_ID(), work.getWORK_ID(), true);
				response.sendRedirect(url);
			} else {
				JSONObject json = new JSONObject();
				json.put("result", "error");
				json.put("reson", "只能强制结束正在办理的工作");
				return json.toString();
			}
		}

		catch (RuntimeException ex) {
			JSONObject json = new JSONObject();
			json.put("result", "error");
			json.put("reson", "删除失败!");
			return json.toString();
		}
		JSONObject json = new JSONObject();
		json.put("result", "success");
		return json.toString();
	}

	/**
	 * 下一个节点选择
	 * 
	 * @param FlowID
	 * @param WorkID
	 * @param ActivityID
	 * @param MainBizKey
	 * @param WorkName
	 * @param SignOpinion
	 * @param BranchSelType
	 * @return
	 */
	@RequestMapping("/nextActivitySelect")
	public ModelAndView NextActivitySelect(String FlowID, String WorkID,
			String ActivityID, String MainBizKey, String WorkName,
			String SignOpinion, String BranchSelType, HttpServletRequest request) {
		FlowParameter flowParameter = new FlowParameter();
		flowParameter.setWorkID(Integer.parseInt(WorkID));
		flowParameter.setFlowID(Integer.parseInt(FlowID));
		flowParameter.setMainBizKey(MainBizKey);
		flowParameter.setWorkName(WorkName);
		flowParameter.setActivityID(Integer.parseInt(ActivityID));

		UserSession userSession = userService.getCurrentHandler(request);
		flowParameter.setCurrentHandler(userSession);
		flowParameter.setAttachList(new java.util.ArrayList<Integer>());

		SignInfo tempVar2 = new SignInfo();
		tempVar2.setSignOpinion(SignOpinion);
		tempVar2.setSignUserID(flowParameter.getCurrentHandler().getUserId());
		tempVar2.setSignUserName(flowParameter.getCurrentHandler()
				.getRealName());
		flowParameter.setSignInfo(tempVar2);

		ModelAndView mv = new ModelAndView("workflow/nextActivitySelect");
		mv.addObject("flowParameter", flowParameter);
		mv.addObject("BranchSelType", BranchSelType);
		mv.addObject("SignOpinion", SignOpinion);
		return mv;
	}

	/**
	 * 绑定Checkbox
	 * 
	 * @param sender
	 * @param e
	 * @throws Exception 
	 */
	@RequestMapping("/gvwActivitySel_onDataBound")
	@ResponseBody
	public String gvwActivitySel_onDataBound(String ActivityID, String FlowID,HttpServletRequest request) throws Exception {

		String nextActivityCodes = "";
		

		// 存储每一次查询的活动对象
		List<WF_ACTIVITY> activityList = new java.util.ArrayList<WF_ACTIVITY>();

		// 存储每次查询的操作员
		List<WF_HANDLER> handlerList = new java.util.ArrayList<WF_HANDLER>();

		// 存储最终查询所有操作员排序
		List<ArrayList<WF_HANDLER>> ResultList = new ArrayList<ArrayList<WF_HANDLER>>();

		WF_ACTIVITY wfAcitivity = configService.getAcitivity(Integer
				.parseInt(ActivityID));

		if (wfAcitivity != null
				&& wfAcitivity.getNEXT_ACTIVITY_CODE().length() > 0) {
			nextActivityCodes = wfAcitivity.getNEXT_ACTIVITY_CODE().substring(
					0, wfAcitivity.getNEXT_ACTIVITY_CODE().length());
		}
		List<ActivityHandler> activityHandlerList = new ArrayList<ActivityHandler>();
		activityList = configService.getActivityListByCodes(Integer.parseInt(FlowID), nextActivityCodes );
		for (WF_ACTIVITY activity : activityList) {
			ActivityHandler activityHandler = new ActivityHandler();
			// 判断如果是同部门约束过滤操作者
			handlerList = GetNextActivityHandlerOfSameOrgan(
					String.valueOf(wfAcitivity.getHANDLER_SEL_TYPE()),
					activity.getACTIVITY_ID(),request);
			if (handlerList.size() > 0)// 将每次查询的操作人员集合存储到集合				
			{
				ResultList.add((ArrayList<WF_HANDLER>) handlerList);
			}
			activityHandler.setHanderList(handlerList);
			activityHandler.setActivityID(activity.getACTIVITY_ID());
			activityHandler.setActivityCode(activity.getACTIVITY_CODE());
			activityHandler.setActivityName(activity.getACTIVITY_NAME());
			activityHandlerList.add(activityHandler);
		}	
		JSONObject json = new JSONObject();
		json.put("data", activityHandlerList);			
		return json.toString();		
	
	}

	// 同部门约束
	public  List<WF_HANDLER> GetNextActivityHandlerOfSameOrgan(String handlerSetType,
			int activityID,HttpServletRequest request) throws Exception
	{
		List<WF_HANDLER> handlerList = configService.listHandler(activityID);
		if (Integer.parseInt(handlerSetType) == 2) //同部门选择
		{			
			//获取本部门所有用户
			UserSession userSession=userService.getCurrentHandler(request);			
			Integer organID=userSession.getOrganId();
			List<UserInfo> listUser = userService.getUserList(organID, null, null, null);

			java.util.ArrayList<WF_HANDLER> listHandler = new java.util.ArrayList<WF_HANDLER>();
			for (WF_HANDLER item : handlerList)
			{
				WF_HANDLER handler = configService.getHandler(item.getHANDLER_ID());
				
				for(UserInfo user :listUser)
				{
					if(user.getUserId()==handler.getHANDLER())
						listHandler.add(handler);					
				}			
			}
			return listHandler;
		}
		else
		{
			return handlerList;
		}
	}

	/**
	 * 获取当前活动的所有分支活动列表
	 * 
	 * @param strActivity
	 *            分支活动列表
	 * @throws SQLException 
	 * @throws NumberFormatException 
	 */
	@RequestMapping("/gvwDataBind")
	@ResponseBody
	public  String gvwDataBind(String ActivityID, String FlowID) throws NumberFormatException, SQLException {
		
		WF_ACTIVITY wfAcitivity = configService.getAcitivity(Integer.parseInt(ActivityID));
		String nextActivityCodes = "";
		if (wfAcitivity != null
				&& wfAcitivity.getNEXT_ACTIVITY_CODE().length() > 0) {
			nextActivityCodes = wfAcitivity.getNEXT_ACTIVITY_CODE().substring(0,
					wfAcitivity.getNEXT_ACTIVITY_CODE().length() - 1);
		}
		List<WF_ACTIVITY> activityList = configService.getActivityListByCodes(Integer.parseInt(FlowID),
				""+ nextActivityCodes + "");
		
		JSONObject json = new JSONObject();
		json.put("data", activityList);			
		return json.toString();		

	}

}

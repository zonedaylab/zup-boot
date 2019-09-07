package cn.zup.workflow.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.apache.poi.hwpf.usermodel.DateAndTime;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.zup.framework.json.JsonDateValueProcessor;
import cn.zup.framework.util.AjaxJson;   
import cn.zup.rbac.controller.ViewEntity.TreeView;
import cn.zup.rbac.controller.ViewEntity.TreeViewChecked;
import cn.zup.rbac.controller.ViewEntity.WFActivityModel;
import cn.zup.rbac.entity.Account;
import cn.zup.rbac.entity.Menu;
import cn.zup.rbac.entity.Organ;
import cn.zup.rbac.entity.Post;
import cn.zup.rbac.entity.UserInfo;
import cn.zup.rbac.entity.UserSession;
import cn.zup.rbac.service.OrganPostService;
import cn.zup.rbac.service.UserService;
import cn.zup.workflow.biz.IWorkFlowConfig;
import cn.zup.workflow.biz.IWorkFlowMonitor;
import cn.zup.workflow.biz.impl.WorkFlowConfig;
import cn.zup.workflow.biz.impl.WorkFlowMonitor;
import cn.zup.workflow.config.ConfigList;
import cn.zup.workflow.config.ControlType;
import cn.zup.workflow.config.HandlerAndMonitorType;
import cn.zup.workflow.controller.ViewEntity.Line;
import cn.zup.workflow.controller.ViewEntity.Node;
import cn.zup.workflow.dal.WF_WORK_ACTIVITY;
import cn.zup.workflow.dal.WF_WORK_ITEM;
import cn.zup.workflow.model.ACTIVITY_POPEDOM;
import cn.zup.workflow.model.ACTIVITY_RULE;
import cn.zup.workflow.model.FORM_CONTROL;
import cn.zup.workflow.model.WF_ACTIVITY;
import cn.zup.workflow.model.WF_ACTIVITY_POPEDOM;
import cn.zup.workflow.model.WF_CONFIG;
import cn.zup.workflow.model.WF_FLOW;
import cn.zup.workflow.model.WF_HANDLER;
import cn.zup.workflow.model.WF_LINE;
import cn.zup.workflow.model.WF_MONITOR;
import cn.zup.workflow.model.WF_MSG_SET;
import cn.zup.workflow.model.WF_RULE;
import cn.zup.workflow.model.WF_WORK;
import cn.zup.workflow.model.WF_WORK_MSG;



@Controller
@RequestMapping("rest/workflow/WorkHistoryInfo")
public class WorkFlowWorkHistoryInfoController {

	@Resource
	private IWorkFlowConfig configService;
	@Resource
	private IWorkFlowMonitor monitorService;
	@Resource
	private WF_WORK_ITEM item;

	/**
	 * 审批过程页面显示
	 * Author：谢炎
	 * Date: 2016-8-23 11:39:40
	 * @param 
	 * @throws UnsupportedEncodingException 
	 **/
	@RequestMapping("")
	public ModelAndView index(HttpServletRequest request) throws UnsupportedEncodingException{
		ModelAndView mv = new ModelAndView("workflow/workFlowWorkHistoryInfo");
		mv.addObject("title", URLDecoder.decode(request.getParameter("title") , "UTF-8"));
		return mv;
	}

	/**
	 * 获取审批流程 
	 * Author：samson
	 * Date:2016.8.10 
	 * @param 
	 **/
	@RequestMapping("/getWorkHistoryInfo")
	@ResponseBody
	public AjaxJson GetWorkFlowData(int workID) throws SQLException{
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
    		if(workItem.size() > 0){
    			node.setState(workItem.get(0).getWORK_ITEM_STATE());
	        	childNodeMap.put(String.valueOf(activity.getACTIVITY_ID()), node);
	        	listNode.add(childNodeMap);
    		}
        }

        for (int i = 0; i < listWFLine.size(); i++){
    		Map<String,Line> childLineMap=new HashMap<String, Line>();
        	WF_LINE wfLine=listWFLine.get(i);
        	Line line = new Line();
        	line.setType("");
        	line.setLineid(wfLine.getLINE_ID());
        	line.setFrom(String.valueOf(wfLine.getBEGIN_CODE()));
        	line.setTo(String.valueOf(wfLine.getEND_CODE()));
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
	public String GetActivityInfo(int activityID, int workID) throws SQLException{
		List<cn.zup.workflow.model.WF_WORK_ITEM> acitivityInfo = item.GetListArray(workID, activityID);
		JSONObject json = new JSONObject();
		//日期类型转换
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(Date.class,new JsonDateValueProcessor("yyyy-MM-dd HH:mm:ss"));
		JSONArray jsonArray = JSONArray.fromObject(acitivityInfo,jsonConfig);
		json.put("data", jsonArray);
		return json.toString();
	}
	
}

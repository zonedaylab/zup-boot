package cn.zup.workflow.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;




import net.sf.json.JSONObject;
import net.sf.json.JSONArray;




import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;





import cn.zup.rbac.controller.ViewEntity.TreeView;
import cn.zup.rbac.controller.ViewEntity.TreeViewChecked;
import cn.zup.rbac.entity.Menu;
import cn.zup.rbac.entity.MenuRoleEx;
import cn.zup.rbac.entity.Organ;
import cn.zup.rbac.entity.Post;
import cn.zup.rbac.entity.System;
import cn.zup.rbac.entity.UserInfo;
import cn.zup.rbac.service.OrganPostService;
import cn.zup.rbac.service.ResourceService;
import cn.zup.rbac.service.UserService;
import cn.zup.workflow.biz.IWorkFlowConfig;
import cn.zup.workflow.biz.IWorkFlowControl;
import cn.zup.workflow.biz.IWorkFlowMonitor;
import cn.zup.workflow.biz.impl.WorkFlowConfig;
import cn.zup.workflow.config.ConfigList;
import cn.zup.workflow.config.HandlerAndMonitorType;
import cn.zup.workflow.model.WF_ACTIVITY;
import cn.zup.workflow.model.WF_ACTIVITY_LAYOUT;
import cn.zup.workflow.model.WF_CONFIG;
import cn.zup.workflow.model.WF_FLOW;
import cn.zup.workflow.model.FLOW_MANAGE;
import cn.zup.workflow.model.WF_LINE;
import cn.zup.workflow.model.WF_MONITOR;
import cn.zup.workflow.model.WF_WORK;



import cn.zup.workflow.structure.PagingData;
import cn.zup.workflow.structure.QueryParameter;

/**
 * 
 * 流程配置页面控制器
 * @author 谢炎
 * @date 2016-8-12 09:22:47
 * 
 * */	
@Controller
@RequestMapping("rest/workflow/wfConfigManage")
public class WorkFlowConfigController {
	@Resource
	private IWorkFlowConfig configService;
	@Resource
	private IWorkFlowMonitor monitorService;
	@Resource
	private ResourceService resourceService;	//从rbac引入
	@Resource
	private OrganPostService organPostService;  //从rbac引入
	@Resource
	private UserService userService;            //从rbac引入
	@Resource
	private IWorkFlowControl IWorkFlowService;            //从rbac引入
	
	/**
	 * 
	 * 流程配置页面
	 * @author 谢炎
	 * @date 2016-8-12 09:22:47
	 * 
	 * */
	@RequestMapping("")
	public ModelAndView index(HttpServletRequest request){
		return new ModelAndView("workflow/wfFlowConfigManage");
	}
	
	
	/** 
	 *说明：加载流程列表
	 *@author: 谢炎
	 *@date ：2016-8-11 16:26:39
	 *@param flowName 流程名字
	 *@param flowState 流程状态
	 *@param page  第几页
	 *@param rows  每页行数
	 *@return 	 流程列表
	 * @throws Exception 
	*/
	@RequestMapping("/getFlowConfig")
	@ResponseBody
	public String  getFlowConfig(FLOW_MANAGE flow_Manage, int page,int rows,HttpServletRequest request) throws Exception
	{
		QueryParameter queryParameter = new  QueryParameter();
		queryParameter.setFlowName(flow_Manage.getFLOW_NAME());	
		queryParameter.setFlowState(flow_Manage.getFLOW_STATE());	
		queryParameter.setSystemID(flow_Manage.getSYSTEM_ID());		
		PagingData<FLOW_MANAGE> flowPageList = configService.listFlowPaging(queryParameter,page,rows);
			
		JSONObject json = new JSONObject();
		json.put("rows", rows);
		json.put("page", page);
		json.put("total", flowPageList.getAmount());	
		java.lang.System.out.println("====================="+flowPageList.getAmount());	
		json.put("data", flowPageList.getData());
		return json.toString();
	}
	
	/** 
	 * 绑定流程状态下拉框
	 * @author liuxf
	 * @date：2016.07.28
	 * @return 流程状态
	 * @throws SQLException 
	*/
	@RequestMapping("/flowState")
	@ResponseBody
	public String flowStateBind() throws SQLException
	{
		java.util.List<WF_CONFIG> flowStateList = configService.listConfig(ConfigList.FlowState.getValue());		
		JSONObject json = new JSONObject();	
		json.put("flowstate", flowStateList);
		return json.toString();
	}
	
	/** 
	 * 绑定系统名字
	 * @author liuxf
	 * @date：2016.07.28
	 
	@return 系统 信息列表
	 * @throws SQLException 
	*/
	@RequestMapping("/SystemName")
	@ResponseBody
	public  String systemNameBind()
	{	
		List<System> system = resourceService.getSystemList();
		JSONObject json = new JSONObject();
		json.put("system", system);
		return json.toString();
	}
	
	/** 
	 * 添加流程
	 * @author 谢炎
	 * @date：2016-8-12 08:55:27
	 * @return string
	 * @throws SQLException 
	*/
	@RequestMapping("/addFlow")
	@ResponseBody
	public String addFlow(WF_FLOW wf_Flow){
		JSONObject json = new JSONObject();
		String result = null;
		try{
			configService.saveFlow(wf_Flow);
			result = "success";
		}catch(Exception ex){
			result = "error，添加失败";
			json.put("error", ex);
		}
		json.put("result", result);
		return json.toString();
	}
	
	/** 
	 * 获取流程
	 * @author 谢炎
	 * @date：2016-8-12 09:48:58
	 * @return string
	 * @throws SQLException 
	 * @throws Exception 
	*/
	@RequestMapping("/getFlow")
	@ResponseBody
	public String getFlow(int flowId) throws Exception{
		JSONObject json = new JSONObject();
		WF_FLOW wf_flow = configService.getFlow(flowId);
		JSONArray jsonArray = JSONArray.fromObject(wf_flow);
		List<WF_MONITOR> wfMonitorList = monitorService.listWorkFlowMonitor(flowId);
		String monitorList = "";
		if(wfMonitorList.size()==1) {
			monitorList =  String.valueOf(wfMonitorList.get(0).getMONITOR());
		}else if(wfMonitorList.size()>1) {
			for(int i=0;i<wfMonitorList.size()-1;i++) {
			monitorList = monitorList + wfMonitorList.get(i).getMONITOR() + ",";
			}
			monitorList = monitorList + wfMonitorList.get(wfMonitorList.size()-1).getMONITOR();
		}
		json.put("result", jsonArray);
		json.put("monitor", monitorList);
		return json.toString();
	}
	
	/** 
	 * 编辑流程
	 * @author 谢炎
	 * @date：2016-8-12 09:48:58
	 * @return string
	 * @throws SQLException 
	*/
	@RequestMapping("/editFlow")
	@ResponseBody
	public String editFlow(WF_FLOW wf_Flow){
		JSONObject json = new JSONObject();
		String result = null;
		try{
			configService.saveFlow(wf_Flow);
			result = "success";
		}catch(Exception ex){
			result = "error，更新失败fromId为："+wf_Flow.getFLOW_ID();
			json.put("error", ex);
		}
		json.put("result", result);
		return json.toString();
	}
	
	
	/** 
	 * 删除流程
	 * @author 谢炎
	 * @date：2016-8-12 08:55:27
	 * @return string
	 * @throws SQLException 
	 *同时删除该流程下所有的工作和节点
	 *lixin
	 *2017-9-14 09:06:32
	*/
	@RequestMapping("/delFlow")
	@ResponseBody
	public String delFlow(@RequestParam("flowIds[]") String[] flowIds){
		JSONObject json = new JSONObject();
		for(int i=0; i<flowIds.length; i++){
			try{
				//1删除工作：根据流程获取所有的工作
				IWorkFlowService.deleteWorkList(Integer.parseInt(flowIds[i]));
				//2 删除监控者
				configService.deleteMonitors(Integer.parseInt(flowIds[i]));
				//3 删除wf_line
				configService.deleteLineList(Integer.parseInt(flowIds[i]));
				//4 删除wfactivity:根据流程获取所有的wfactivity：循环activity删除子表信息
				List<WF_ACTIVITY> activityList=configService.listActivity(Integer.parseInt(flowIds[i]));
				//5 删除 wf_activityPope
				//7 删除操作者
				//8 删除干工作项
				//9 删除工作活动
				for(WF_ACTIVITY wfActivity:activityList){
					//1 先删除操作者
					configService.deleteHandler(wfActivity.getACTIVITY_ID());
					//2 在删除活动权限表
					configService.deleteWfActivityPopedom(wfActivity.getACTIVITY_ID());
					//4 查询工作活动 list此时需要全部删除
					configService.deleteActivitySonTable(wfActivity.getACTIVITY_ID());
					//5 删除节点
				    configService.deleteWFActivity(wfActivity.getACTIVITY_ID());
				}
				//删除流程
				configService.deleteFlow(Integer.parseInt(flowIds[i]));
			}catch(Exception e){
			}
		}
		json.put("info", "success");
		return json.toString();
	
	}

	/**
	 * 
	 * desc:获取用户
	 * Author：谢炎
	 * Date: 2016-8-12 14:15:00
	 * @throws SQLException 
	 * 
	 * */
	@RequestMapping("/getUserTree")
	@ResponseBody
	public String getUserTree(int parentMenuId, int systemId, int postMark, int FLOW_ID) throws SQLException{
		JSONObject json = new JSONObject();
		List<TreeView> treeList = new ArrayList<TreeView>();
		if(parentMenuId == -1){
			TreeView treeParent = new TreeView();
			treeParent.setId(0);
			treeParent.setName("用户管理");
			treeParent.setType("folder");
			treeParent.setPostMark(0);
			treeList.add(treeParent);
		}else if(parentMenuId == 0){
			List<Organ> listOrgan = organPostService.getSubOrganList(parentMenuId);  //获取所有节点  
			for(int i =0;i<listOrgan.size();i++){
				TreeView t = new TreeView();
				Organ organ = listOrgan.get(i);
				t.setId(organ.getOrganId());
				t.setName(organ.getOrganName());
				List<Post> listChild = organPostService.getOrganPostList(organ.getOrganId());
				java.lang.System.out.println("组织下岗位为================"+listChild.size());
				if(listChild.size() <= 0){
					t.setType("item");
				}else{
					t.setType("folder");
					t.setPostMark(1010);
				}
				treeList.add(t);
			}
		}else if(postMark == 1010){ 
			List<Post> listPost = organPostService.getOrganPostList(parentMenuId);  //获取所有节点  
			for(int i =0;i<listPost.size();i++){
				TreeView t = new TreeView();
				Post post = listPost.get(i);
				t.setId(post.getPostId());
				t.setName(post.getPostName());
				List<UserInfo> userList = userService.getPostUserList(post.getPostId());
				java.lang.System.out.println(post.getPostName()+"岗位中人员为================"+userList.size());
				if(userList.size() <= 0){
					t.setType("item");
					List<WF_MONITOR> monitorList = configService.listMonitor(FLOW_ID);
					if(monitorList.size() > 0){
						if(monitorList.size() > 0){
							for(int j=0; j<monitorList.size(); j++){
								java.lang.System.out.println(post.getPostId()+"======================="+monitorList.get(j).getMONITOR());
								if(post.getPostId().intValue() == monitorList.get(j).getMONITOR().intValue()){
									TreeViewChecked tc = new TreeViewChecked();
									tc.setId(monitorList.get(j).getMONITOR());
									tc.setItem_selected(true);
									t.setAdditionalParameters(tc);
								}
							}
						}
					}
				}else{
					t.setType("folder");
					t.setPostMark(0);
				}
				treeList.add(t);
			}
		}else{
			treeList.clear();
			List<UserInfo> userList = userService.getPostUserList(parentMenuId);
			for(int i=0; i<userList.size(); i++){
				TreeView treeChild = new TreeView();
				UserInfo user = userList.get(i);
				treeChild.setId(user.getUserId());
				treeChild.setName(user.getRealName());
				treeChild.setType("item");
				List<WF_MONITOR> monitorList = configService.listMonitor(FLOW_ID);
				if(monitorList.size() > 0){
					for(int j=0; j<monitorList.size(); j++){
						java.lang.System.out.println(user.getUserId()+"======================="+monitorList.get(j).getMONITOR());
						if(monitorList.get(j).getMONITOR().intValue() == user.getUserId().intValue()){
							TreeViewChecked tc = new TreeViewChecked();
							tc.setId(user.getUserId());
							tc.setItem_selected(true);
							treeChild.setAdditionalParameters(tc);
						}
					}
				}
				treeList.add(treeChild);
			}
		}
		json.put("data", treeList);
		String s = json.toString();
		s=s.replace('_','-');
		
		return s;
	}
	
	/** 
	 * 添加检查者
	 * @author 谢炎
	 * @date：2016-8-12 08:55:27
	 * @return string
	 * @throws SQLException 
	 * @throws Exception 
	*/
	@RequestMapping("/addUser")
	@ResponseBody
	public String addUser(@RequestParam("MONITORs[]") String[] MONITORs, int FLOW_ID) throws Exception{		
		if(FLOW_ID != 0){
			configService.deleteMonitor(FLOW_ID);
		}
		WF_MONITOR wf_monitor = new WF_MONITOR();
		String returnCode = "";
		for(int i=0; i<MONITORs.length; i++){
			wf_monitor.setMONITOR(Integer.parseInt(MONITORs[i]));
			wf_monitor.setMONITOR_TYPE(HandlerAndMonitorType.User.getValue());
			wf_monitor.setFLOW_ID(FLOW_ID);
			List<WF_MONITOR> monitorList = configService.listMonitor(FLOW_ID);
			if(monitorList.size() == 0){
				wf_monitor.setMONITOR_ID(0);
			}
			int result = configService.saveMonitor(wf_monitor);
			if(result <= 0)
				returnCode += MONITORs[i]+",";
		}
		JSONObject json = new JSONObject();
		String result = null;
		if(returnCode != ""){
			json.put("info", returnCode);
			return json.toString(); 
		}else{
			json.put("info", "success");
			return json.toString();
		}
	}


}

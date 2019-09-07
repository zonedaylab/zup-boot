package cn.zup.workflow.controller;

import java.sql.SQLException;
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

import org.jeecgframework.minidao.pojo.MiniDaoPage;
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
import cn.zup.rbac.entity.Role;
import cn.zup.rbac.entity.UserInfo;
import cn.zup.rbac.entity.UserSession;
import cn.zup.rbac.service.AccountRoleService;
import cn.zup.rbac.service.MerchantService;
import cn.zup.rbac.service.OrganPostService;
import cn.zup.rbac.service.UserService;
import cn.zup.rbac.service.settings.ConfigSetting;
import cn.zup.workflow.biz.IWorkFlowConfig;
import cn.zup.workflow.biz.impl.WorkFlowConfig;
import cn.zup.workflow.config.ConfigList;
import cn.zup.workflow.config.ControlType;
import cn.zup.workflow.config.HandlerAndMonitorType;
import cn.zup.workflow.controller.ViewEntity.Line;
import cn.zup.workflow.controller.ViewEntity.Node;
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
import cn.zup.workflow.model.WF_WORK_ACTIVITY;
import cn.zup.workflow.model.WORK_ACTIVITY;

@Controller
@RequestMapping("rest/workflow/design")
public class WorkFlowDesignController {
	@Resource
	private IWorkFlowConfig configService;
	@Resource
	private OrganPostService organPostService;  //从rbac引入
	@Resource
	private UserService userService;            //从rbac引入
	@Resource
	private MerchantService merchantService;    //从rbac引入
	@Resource
	private AccountRoleService accountRoleService;
	/**
	 * 工作流设计
	 * Author：samson
	 * Date:2016.8.10
	 * @param 
	 **/
	@RequestMapping("")
	public ModelAndView index(HttpServletRequest request){
		return new ModelAndView("workflow/workFlowDesign");
	}

	/**
	 * 工作流加载 
	 * Author：samson
	 * Date:2016.8.10 
	 * @param 
	 **/
	@RequestMapping("/getWorkFlowData")
	@ResponseBody
	public AjaxJson GetWorkFlowData(int flowID) throws SQLException{
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
        	childNodeMap.put(String.valueOf(activity.getACTIVITY_ID()), node);
        	listNode.add(childNodeMap);
        }

        for (int i = 0; i < listWFLine.size(); i++){
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
	 * 图形数据保存或更新
	 * Author：samson
	 * Date:2016.8.10
	 *  lixin
	 * 先判断节点的个数，若
	 * @param 
	 **/
	@RequestMapping("saveWorkFlowData")
	@ResponseBody
	public String saveWorkFlowData(int flowID, String arrNodes, String arrLines) throws SQLException{
		JSONObject json=new JSONObject();
		String result = "";
	    JSONArray jsonArray = JSONArray.fromObject(arrNodes);  
	    List<WF_ACTIVITY> listWFActivity = (List)JSONArray.toList(jsonArray, WF_ACTIVITY.class); 
	    jsonArray = JSONArray.fromObject(arrLines); 
	    List<WF_LINE> listWFLine = (List)JSONArray.toList(jsonArray, WF_LINE.class);     
	    for(int i=0;i<listWFActivity.size();i++){       
	    	WF_ACTIVITY activityNew=listWFActivity.get(i);
	    	WF_ACTIVITY activity = configService.getAcitivity(activityNew.getACTIVITY_CODE());    	
	        if (activity != null){        	
	        	activity.setACTIVITY_NAME(activityNew.getACTIVITY_NAME());
	        	activity.setACTIVITY_CODE(activityNew.getACTIVITY_CODE());
	        	activity.setACTIVITY_LEFT(activityNew.getACTIVITY_LEFT());
	        	activity.setACTIVITY_TOP(activityNew.getACTIVITY_TOP());
	        	activity.setACTIVITY_ICON(activityNew.getACTIVITY_ICON());  
	        	//获取下一节点
	        	String nextCode = "";
                for (int j = 0; j < listWFLine.size(); j++){
                    if (listWFLine.get(j).getBEGIN_CODE().equals(activity.getACTIVITY_CODE())){
                    	nextCode+=listWFLine.get(j).getEND_CODE()+",";
                    } 
                } 
                nextCode = nextCode.equals("") ? "": nextCode.substring(0,nextCode.length()-1);
	        	activity.setNEXT_ACTIVITY_CODE(nextCode);  
                
	            configService.saveActivity(activity);
	        }else{
	        	int activityCode = activityNew.getACTIVITY_CODE();
	        	activityNew.setACTIVITY_CODE(0);
	        	int activityId = configService.saveActivity(activityNew); 
	            //线条Begin/End替换  以及配置下一节点 
                for (int j = 0; j < listWFLine.size(); j++){
                    if (listWFLine.get(j).getBEGIN_CODE().equals(activityCode)){
                    	listWFLine.get(j).setBEGIN_CODE(activityId);
                    }
                    if (listWFLine.get(j).getEND_CODE().equals(activityCode)){
                    	listWFLine.get(j).setEND_CODE(activityId);
                    }
                }
	        }
	    }
	    
	    for(int i=0;i<listWFLine.size();i++){
	    	WF_LINE line=listWFLine.get(i);        
	    	configService.saveLine(line);
	    }    
	    json.put("result","success");
	    return json.toString();
	}
	
	/**
	 * 
	 * desc:获取某个活动信息
	 * Author：samson
	 * Date: 2016.08.15
	 * @param activityId
	 * @throws SQLException 
	 * 
	 * */
	@RequestMapping("/getActivityInfo")
	@ResponseBody
	public String getActivityInfo(int activityId) throws SQLException{
		System.out.println("活动标示"+activityId);

        WFActivityModel model = new WFActivityModel();
	    WF_ACTIVITY activityInfo = configService.getAcitivity(activityId);   
	    model.setFlowId(activityInfo.getFLOW_ID());
	    model.setActivityId(activityInfo.getACTIVITY_ID());
	    model.setActivityCode(Integer.toString(activityInfo.getACTIVITY_CODE()));
	    model.setActivityName(activityInfo.getACTIVITY_NAME());
	    model.setActivityProperty(activityInfo.getACTIVITY_PROPERTY()); 
	    model.setFormId(activityInfo.getFORM_ID());
        model.setFormName(activityInfo.getFORM_ID()==0?"":configService.getForm(activityInfo.getFORM_ID()).getFORM_NAME());
        model.setActivityType(activityInfo.getACTIVITY_TYPE());
        model.setReviewType(activityInfo.getREVIEW_TYPE());
        model.setBranchSelType(activityInfo.getBRANCH_SEL_TYPE());
        model.setRelationNode(activityInfo.getRELATION_NODE());
        model.setActivityInterval(activityInfo.getACTIVITY_INTERVAL()); 
        model.setHandlerSelType(activityInfo.getHANDLER_SEL_TYPE());
		JSONObject json = new JSONObject();
		JSONArray jsonArr = JSONArray.fromObject(model); 
		json.put("data", jsonArr);
		//获取该节点的操作者
		String operatorString="";
		List<WF_HANDLER> handlerList=configService.listHandler(activityId);
		for(int i=0;i<handlerList.size();i++){
			operatorString+=handlerList.get(i).getHANDLER()+",";
		}
		if(operatorString.lastIndexOf(",")>0){
			operatorString=operatorString.substring(0, operatorString.lastIndexOf(","));
		}
		json.put("operator", operatorString);
		return json.toString();
	}
	
	/**
	 * 
	 * desc:编辑某个活动信息
	 * Author：samson
	 * Date: 2016.08.15
	 * @param activity
	 * @throws SQLException 
	 * 
	 * */
	@RequestMapping("/editActivityInfo")
	@ResponseBody
	public String editActivityInfo(WF_ACTIVITY activity, HttpServletRequest request) throws SQLException{
		JSONObject json = new JSONObject();
	    WF_ACTIVITY activityInfo = configService.getAcitivity(activity.getACTIVITY_ID());   
	    if (activityInfo == null){
	    	activityInfo = activity;
        }else{ 
        	activityInfo.setFORM_ID(activity.getFORM_ID());
        	activityInfo.setACTIVITY_CODE(activity.getACTIVITY_CODE());
        	activityInfo.setACTIVITY_NAME(activity.getACTIVITY_NAME());
        	activityInfo.setACTIVITY_TYPE(activity.getACTIVITY_TYPE());
        	activityInfo.setACTIVITY_PROPERTY(activity.getACTIVITY_PROPERTY());
        	activityInfo.setREVIEW_TYPE(activity.getREVIEW_TYPE());
        	activityInfo.setBRANCH_SEL_TYPE(activity.getBRANCH_SEL_TYPE());
        	activityInfo.setRELATION_NODE(activity.getRELATION_NODE());
        	activityInfo.setACTIVITY_INTERVAL(activity.getACTIVITY_INTERVAL()); 
        	
        }
		configService.saveActivity(activityInfo); 
		json.put("result", "success");
		return json.toString();
	} 
	
	/**
	 * 
	 * desc:获取活动类型
	 * Author：samson
	 * Date: 2016.08.10 
	 * @throws SQLException 
	 * 
	 * */ 
	@RequestMapping("/getActivityType")
	@ResponseBody
	public String getActivityType() throws SQLException{
        List<WF_CONFIG> listActivityType  = configService.listConfig(ConfigList.ActivityType.getValue());
		JSONObject json = new JSONObject();
		json.put("data", listActivityType);
		return json.toString();
	}

	/**
	 * 
	 * desc:获取评审模式
	 * Author：samson
	 * Date: 2016.08.10 
	 * @throws SQLException 
	 * 
	 * */ 
	@RequestMapping("/getReviewType")
	@ResponseBody
	public String getReviewType() throws SQLException{
        List<WF_CONFIG> listReviewType  = configService.listConfig(ConfigList.ReviewType.getValue());
		JSONObject json = new JSONObject();
		json.put("data", listReviewType);
		return json.toString();
	}

	/**
	 * 
	 * desc:获取活动属性
	 * Author：samson
	 * Date: 2016.08.10 
	 * @throws SQLException 
	 * 
	 * */ 
	@RequestMapping("/getActivityProperty")
	@ResponseBody
	public String getActivityProperty() throws SQLException{
        List<WF_CONFIG> listActivityProperty  = configService.listConfig(ConfigList.ActivityProperty.getValue());
		JSONObject json = new JSONObject();
		json.put("data", listActivityProperty);
		return json.toString();
	}

	/**
	 * 
	 * desc:获取分支选择模式
	 * Author：samson
	 * Date: 2016.08.10 
	 * @throws SQLException 
	 * 
	 * */ 
	@RequestMapping("/getBranchSelType")
	@ResponseBody
	public String getBranchSelType() throws SQLException{
        List<WF_CONFIG> listBranchSelType  = configService.listConfig(ConfigList.BranchSelType.getValue());
		JSONObject json = new JSONObject();
		json.put("data", listBranchSelType);
		return json.toString();
	}

	/**
	 * 
	 * desc:获取选择操作者关联节点
	 * Author：samson
	 * Date: 2016.08.10 
	 * @throws SQLException 
	 * 
	 * */ 
	@RequestMapping("/getRelationNode")
	@ResponseBody
	public String getRelationNode(int flowID, String activityCode) throws SQLException{
        List<WF_ACTIVITY> listRelationNode  = configService.listActivity(flowID);
		JSONObject json = new JSONObject();
		json.put("data", listRelationNode);
		return json.toString();
	}
	

	/**
	 * 
	 * desc:获取账号的列表
	 * Author：samson
	 * Date: 2016.08.15 
	 * @param organid
	 * @throws Exception 
	 * 
	 * */
	@RequestMapping("/gridRule")
	@ResponseBody 
	public String gridRule(int activityId, int page, int rows,HttpServletRequest request) throws Exception {
		java.lang.System.out.println("成功进入账号controller");		
		List<ACTIVITY_RULE>  listRule = configService.listRule(activityId);		
		JSONObject json = new JSONObject(); 
		json.put("rows", rows);
		json.put("page", 1);
		json.put("total",listRule.size());		
		//日期类型的json转换
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor());		
		JSONArray jsonArray = JSONArray.fromObject(listRule, jsonConfig);  
		json.put("data", jsonArray);		
		return json.toString();  
	}	

	/**
	 * 
	 * desc:添加账号
	 * Author：samson
	 * Date: 2016.08.15 
	 * @param Rule
	 * @throws SQLException 
	 * 
	 * */
	@RequestMapping("/addRule")
	@ResponseBody
	public String addRule(WF_RULE wfRule) throws SQLException{
		JSONObject json = new JSONObject();
		configService.saveRule(wfRule);
		json.put("result", "success");
		return json.toString();
		
	}

	/**
	 * 
	 * desc:账号信息
	 * Author：samson
	 * Date: 2016.08.15 
	 * @param RuleId
	 * @throws SQLException 
	 * 
	 * */
	@RequestMapping("/getRuleInfo")
	@ResponseBody
	public String getRuleInfo(int ruleId, HttpServletRequest request) throws SQLException{
		JSONObject json = new JSONObject(); 
		WF_RULE wfRule = configService.getRule(ruleId);
		JSONArray jsonArr = JSONArray.fromObject(wfRule); 
		json.put("data", jsonArr);
		return json.toString();
	}
	
	/**
	 * 
	 * desc:编辑账号
	 * Author：samson
	 * Date: 2016.08.15 
	 * @param user
	 * @throws SQLException 
	 * 
	 * */
	@RequestMapping("/editRuleInfo")
	@ResponseBody
	public String editRuleInfo(WF_RULE wfRule, HttpServletRequest request) throws SQLException{		
		JSONObject json = new JSONObject(); 
		configService.saveRule(wfRule);
		json.put("result", "success");
		return json.toString();
	}
	
	/**
	 * 
	 * desc:流转规则删除
	 * Author：samson
	 * Date: 2016.08.15 
	 * @param Ruleid
	 * @throws SQLException 
	 * 
	 * */
	@RequestMapping("/delRuleInfo")
	@ResponseBody
	public String delRuleInfo(int ruleId) throws SQLException{		
		JSONObject json = new JSONObject(); 
		configService.deleteRule(ruleId);
		json.put("result", "success");
		return json.toString();
	}	
	 
	/**
	 * 
	 * desc:获取 绑定组件
	 * Author：samson
	 * Date: 2016.08.10 
	 * @throws Exception 
	 * 
	 * */ 
	@RequestMapping("/getControl")
	@ResponseBody
	public String getControl(int activityId) throws Exception{
		WF_ACTIVITY activity = configService.getAcitivity(activityId);
        List<FORM_CONTROL> control  = configService.listFormControl(activity.getFORM_ID());
		JSONObject json = new JSONObject();
		json.put("data", control);
		return json.toString();
	}
 
	/**
	 * 
	 * desc:获判断条件
	 * Author：samson
	 * Date: 2016.08.10 
	 * @throws SQLException  
	 * 
	 * */ 
	@RequestMapping("/getCondition")
	@ResponseBody
    public String getCondition() throws SQLException{
        List<WF_CONFIG> config = configService.listConfig(ConfigList.ConditionType.getValue());
		JSONObject json = new JSONObject();
		json.put("data", config);
		return json.toString();
    }

	/**
	 * 
	 * desc:获判断条件
	 * Author：samson
	 * Date: 2016.08.10 
	 * @throws SQLException 
	 * @throws Exception 
	 * 
	 * */ 
	@RequestMapping("/getGotoActivity")
	@ResponseBody
    public String getGotoActivity(int activityId) throws SQLException{
		WF_ACTIVITY activity = configService.getAcitivity(activityId);
        List<WF_ACTIVITY> listActivity  = configService.listActivity(activity.getFLOW_ID());
		JSONObject json = new JSONObject();
		json.put("data", listActivity);
		return json.toString();
    }
	

	/**
	 * 
	 * desc:获取操作者选择模式 
	 * Author：samson
	 * Date: 2016.08.10 
	 * @throws SQLException 
	 * 
	 * */ 
	@RequestMapping("/getHandlerSetType")
	@ResponseBody
	public String getHandlerSetType() throws SQLException{
        List<WF_CONFIG> listHandlerSelMode  = configService.listConfig(ConfigList.HandlerSelMode.getValue());
		JSONObject json = new JSONObject();
		json.put("data", listHandlerSelMode);
		return json.toString();
	}

	/**
	 * 
	 * desc:获取用户
	 * Author：samson
	 * Date: 2016-8-15 14:15:00
	 * @throws SQLException 
	 * 
	 * */
	@RequestMapping("/getOperatorUserTree")
	@ResponseBody
	public String getOperatorUserTree(int parentMenuId, int systemId, int postMark, int modelMark,int activityId) throws SQLException{
		JSONObject json = new JSONObject();
		List<TreeView> treeList = new ArrayList<TreeView>();
		if(parentMenuId == -1){
			treeList.clear();
			TreeView treeParent = new TreeView();
			TreeViewChecked tv = new TreeViewChecked();
			treeParent.setAdditionalParameters(tv);
			treeParent.setId(0);
			treeParent.setName("用户管理");
			treeParent.setType("folder");
			treeParent.setPostMark(0);
			treeList.add(treeParent);
		}else if(parentMenuId == 0){
			List<Organ> listOrgan = organPostService.getSubOrganList(parentMenuId);  //获取所有节点  
			if(listOrgan.size()>0){
				for(int i =0;i<listOrgan.size();i++){
					TreeView t = new TreeView();
					Organ organ = listOrgan.get(i);
					t.setId(organ.getOrganId());
					t.setName(organ.getOrganName());					
					List<Organ> listChild = organPostService.getSubOrganList(organ.getOrganId());  //获取所有节点  
					if(listChild.size() <= 0){
						List<Post> postChild = organPostService.getOrganPostList(organ.getOrganId());
						if(postChild.size()>0){
							t.setType("folder");
							t.setModelMark(1);//标志该加载岗位
						}else{
							t.setType("item");	
						}
				    }									
					else{
						t.setType("folder");
						t.setPostMark(1010);
						t.setModelMark(2);//标志继续加载组织机构
					}
					treeList.add(t);
				}
			}
		}else if(parentMenuId != 0){
				if(modelMark==1){
					List<Post> listPost = organPostService.getOrganPostList(parentMenuId);  //获取所有节点  
					for(int i =0;i<listPost.size();i++){
						TreeView t = new TreeView();
						Post post = listPost.get(i);
						t.setId(post.getPostId());
						t.setName(post.getPostName());
						List<UserInfo> userList = userService.getPostUserList(post.getPostId());
						java.lang.System.out.println(post.getPostName()+"岗位中人员为================"+userList.size());
						if(userList.size() <= 0)
							t.setType("item");				
						else{
							t.setType("folder");
							t.setModelMark(3);
						}
						treeList.add(t);
					}
				}else if (modelMark==2){
					List<Organ> listChild = organPostService.getSubOrganList(parentMenuId);  //获取所有节点 
					if(listChild.size()>0){
						for(int i =0;i<listChild.size();i++){
							TreeView t = new TreeView();
							Organ organ = listChild.get(i);
							t.setId(organ.getOrganId());
							t.setName(organ.getOrganName());					
							List<Organ> listChildOrgan = organPostService.getSubOrganList(organ.getOrganId());  //获取所有节点  
							if(listChildOrgan.size() <= 0){
								List<Post> postChild = organPostService.getOrganPostList(organ.getOrganId());
								if(postChild.size()>0){
									t.setType("folder");
									t.setModelMark(1);//标志该加载岗位
								}else{
									//treeList.clear();
									List<UserInfo> userList = userService.getPostUserList(parentMenuId);//加载人员
									if(userList.size()>0){
										t.setType("folder");
										t.setModelMark(3);
									}else{
										t.setType("item");
									}
								}
						    }									
							else{
								t.setType("folder");
								t.setPostMark(1010);
								t.setModelMark(2);
							}
							treeList.add(t);
						}
					}
				}else if (modelMark==3){
					treeList.clear();
					List<UserInfo> userList = userService.getPostUserList(parentMenuId);
					List<WF_HANDLER> handlerList = configService.listHandler(activityId);
					for(int i=0; i<userList.size(); i++){
						TreeView treeChild = new TreeView();
						UserInfo user = userList.get(i);
						treeChild.setId(user.getUserId());
						treeChild.setName(user.getRealName()); 
						treeChild.setType("item");
						if(handlerList.size() > 0){
							for(int j=0; j<handlerList.size(); j++){
								java.lang.System.out.println(user.getUserId()+"======================="+handlerList.get(j).getHANDLER());
								if(handlerList.get(j).getHANDLER() == user.getUserId().intValue()){
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
		}
		json.put("data", treeList);
		String s = json.toString();
		s=s.replace('_','-');
		return s;
	}

	/** 
	 * 保存操作者
	 * @author samson
	 * @date：2016-8-15 08:55:27
	 * @return string
	 * @throws SQLException 
	 * @throws Exception 
	
	@RequestMapping("/addOperatorUser")
	@ResponseBody
	public String addOperatorUser(@RequestParam("handlers[]") String[] handlers, int activityId,int handlerSetType, @RequestParam("handlerName[]") String[] handlerName) throws Exception{		
		//保存操作者选择模式
		WF_ACTIVITY activity = configService.AcitivityInfo(activityId);
		if(activity!=null)
		{
			activity.setHANDLER_SEL_TYPE(handlerSetType);
			configService.ActivitySave(activity);
		}
		
		//保存操作者
		if(activityId != 0){
			configService.HandlerDel(activityId);
		}
		String returnCode = "";
		for(int i=0; i<handlers.length; i++){
			WF_HANDLER wfhandler = new WF_HANDLER();
			wfhandler.setACTIVITY_ID(activityId);
			wfhandler.setHANDLER(Integer.parseInt(handlers[i]));
			wfhandler.setHANDLER_TYPE(HandlerAndMonitorType.User.getValue()); 
			wfhandler.setHANDLER_NAME(handlerName[i]);
			int result = configService.HandlerSave(wfhandler);
			if(result <= 0)
				returnCode += handlers[i]+",";
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
	}*/
	/**
	 * 添加操作者信息
	 * 先删除，后添加
	 */
	@RequestMapping("/addOperatorUser")
	@ResponseBody
	public String addOperatorUser( String handlerString, int activityId,int handlerSetType) throws Exception{		
		JSONObject json = new JSONObject();
		//保存操作者选择模式
		WF_ACTIVITY activity = configService.getAcitivity(activityId);
		if(activity!=null)
		{
			activity.setHANDLER_SEL_TYPE(handlerSetType);
			configService.saveActivity(activity);
		}
		//删除原有操作者
		if(activityId != 0){
			configService.deleteHandler(activityId);
		}
		//添加新的操作者
		String returnCode = "";
		if(handlerString!=null){
			String[] handlers=handlerString.split(",");
			for(int i=0; i<handlers.length; i++){
				//获取操作者名称
				UserInfo user=userService.getUserInfo(Integer.parseInt(handlers[i]));
				if(user!=null){
					WF_HANDLER wfhandler = new WF_HANDLER();
					wfhandler.setACTIVITY_ID(activityId);
					wfhandler.setHANDLER(Integer.parseInt(handlers[i]));
					wfhandler.setHANDLER_TYPE(HandlerAndMonitorType.User.getValue()); 
					wfhandler.setHANDLER_NAME(user.getRealName());
					int result = configService.saveHandler(wfhandler);
					if(result <= 0)
						returnCode += handlers[i]+",";
				}
			}
			if(returnCode != ""){
				json.put("info", returnCode);
			}else{
				json.put("info", "success");
			}
		}
		else{
			json.put("info", "operator");
		}
		return json.toString();
		
	}

	/**
	 * 
	 * desc:获取通知者用户
	 * Author：samson
	 * Date: 2016-8-15 14:15:00
	 * @throws SQLException 
	 * 
	 * */
	@RequestMapping("/getMsgUserTree")
	@ResponseBody
	public String getMsgUserTree(int parentMenuId, int systemId, int postMark, int activityId) throws SQLException{
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
				if(listChild.size() <= 0)
					t.setType("folder");				
				else{
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
				if(userList.size() <= 0)
					t.setType("folder");				
				else{
					t.setType("folder");
					t.setPostMark(0);
				}
				treeList.add(t);
			}
		}else{
			treeList.clear();
			List<UserInfo> userList = userService.getPostUserList(parentMenuId);
			List<WF_MSG_SET> listMsg = configService.listMsgSet(activityId);
			for(int i=0; i<userList.size(); i++){
				TreeView treeChild = new TreeView();
				UserInfo user = userList.get(i);
				treeChild.setId(user.getUserId());
				treeChild.setName(user.getRealName()); 
				treeChild.setType("item");
				if(listMsg.size() > 0){
					for(int j=0; j<listMsg.size(); j++){
						java.lang.System.out.println(user.getUserId()+"======================="+listMsg.get(j).getRECEIVER_ID());
						if(listMsg.get(j).getRECEIVER_ID() == user.getUserId().intValue()){
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
	@RequestMapping("/getChildNode")
	@ResponseBody
	private String getChildNode(int parentOrganId){
		JSONObject json = new JSONObject();
		List<TreeView> tree = new ArrayList<TreeView>();
		//根节点的ID=1，parentOrganId = -1
		if(parentOrganId == -1){
			TreeView ts = new TreeView();
			ts.setId(0);
			ts.setName("组织机构");
			ts.setType("folder");
			tree.add(ts);
		}
		else{
			List<Organ> listOrgan = organPostService.getSubOrganList(parentOrganId);  //获取所有节点  
			for(int i =0;i<listOrgan.size();i++){
				TreeView t = new TreeView();
				Organ organ = listOrgan.get(i);
				t.setId(organ.getOrganId());
				t.setName(organ.getOrganName());
				List<Organ> listChild = organPostService.getSubOrganList(organ.getOrganId());
				if(listChild.size() <= 0)
					t.setType("item");				
				else
					t.setType("folder");							
				tree.add(t);
			}
		}
		json.put("data", tree);
		return json.toString();
	}
	/** 
	 * 保存通知者
	 * @author samson
	 * @date：2016-8-15 08:55:27
	 * @return string
	 * @throws SQLException 
	 * @throws Exception 
	*/
	@RequestMapping("/addMsgUser")
	@ResponseBody
	public String addMsgUser(@RequestParam("msgs[]") String[] msgs, int activityId) throws Exception{	
		//保存通知者
		if(activityId != 0){
			configService.deleteHandler(activityId);
		}
		String returnCode = "";
		for(int i=0; i<msgs.length; i++){
			WF_MSG_SET msgSet = new WF_MSG_SET();
			msgSet.setACTIVITY_ID(activityId);
			msgSet.setRECEIVER_ID(Integer.parseInt(msgs[i]));
			msgSet.setRECEIVER_TYPE(HandlerAndMonitorType.User.getValue()); 
			int result = configService.saveMsgSet(msgSet);
			if(result <= 0)
				returnCode += msgs[i]+",";
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
	

	/**
	 * 可写字段 
	 * Author：samson
	 * Date:2016.8.16 
	 * @param 
	 * @throws Exception 
	 **/
	@RequestMapping("activityPermissionSet")
	public ModelAndView activityPermissionSet(int activityId,HttpServletRequest request) throws Exception {  
		WF_ACTIVITY activity = configService.getAcitivity(activityId);
		List<ACTIVITY_POPEDOM> listFormControl = new ArrayList<ACTIVITY_POPEDOM>();
		List<ACTIVITY_POPEDOM> listFormControlGrid = new ArrayList<ACTIVITY_POPEDOM>();
		
		List<FORM_CONTROL> listControl =  configService.listFormControl(activity.getFORM_ID());
		List<ACTIVITY_POPEDOM> listPopedoms = configService.listActivityPopedom(activityId);
		for(int i=0;i<listControl.size();i++){ 
			for(int j=0;j<listPopedoms.size();j++){ 
				if(listPopedoms.get(j).getCONTROL_ID()==listControl.get(i).getCONTROL_ID() &&
						listControl.get(i).getCONTROL_TYPE() == ControlType.GirdView.getValue()){
					listFormControlGrid.add(listPopedoms.get(i));
				}else if(listPopedoms.get(j).getCONTROL_ID()==listControl.get(i).getCONTROL_ID() &&
						listControl.get(i).getCONTROL_TYPE() != ControlType.GirdView.getValue()){
					listFormControl.add(listPopedoms.get(i));
				}
			}
		} 
		JSONObject json = new JSONObject();
		json.put("listFormControlGrid", listFormControlGrid); 
		request.setAttribute("listFormControl",listFormControl);
	    return new ModelAndView("workflow/activityPermissionSet");
	}
	

	/**
	 * 控件保存或更新
	 * Author：samson
	 * Date:2016.8.15 
	 * @param 
	 **/
	@RequestMapping("saveControlData")
	@ResponseBody
	public String saveControlData(int activityId, String arrControls,
			String arrControlGrids) throws SQLException{
	    String result = "";
	    JSONArray jsonArray = JSONArray.fromObject(arrControls);  
	    List<ACTIVITY_POPEDOM> listControl = (List)JSONArray.toList(jsonArray, ACTIVITY_POPEDOM.class); 
	    
	    jsonArray = JSONArray.fromObject(arrControlGrids); 
	    List<ACTIVITY_POPEDOM> listControlGrid = (List)JSONArray.toList(jsonArray, ACTIVITY_POPEDOM.class);     
	    //保存非grid的字段 
	    for(int i=0;i<listControl.size();i++){
            WF_ACTIVITY_POPEDOM activityPopedomGrid = new WF_ACTIVITY_POPEDOM();
		    WF_ACTIVITY_POPEDOM activityPopedom = configService.getActivityPopedom(activityId, listControl.get(i).getCONTROL_ID());
		    if(activityPopedom!=null){
		    	activityPopedomGrid = activityPopedom;
	            activityPopedomGrid.setSTATE(listControl.get(i).getSTATE()); 
		    }else{ 
		    	activityPopedomGrid.setCONTROL_ID(listControl.get(i).getCONTROL_ID());
		    	activityPopedomGrid.setACTIVITY_ID(listControl.get(i).getACTIVITY_ID());
	            activityPopedomGrid.setSTATE(listControl.get(i).getSTATE());  
		    }
            configService.saveActivityPopedom(activityPopedomGrid);
	    } 
	    
	    //保存grid字段 
	    for(int i=0;i<listControlGrid.size();i++){
	    	WF_ACTIVITY_POPEDOM activityPopedomGrid = new WF_ACTIVITY_POPEDOM();
		    WF_ACTIVITY_POPEDOM activityPopedom = configService.getActivityPopedom(activityId, listControlGrid.get(i).getCONTROL_ID());
		    if(activityPopedom!=null){
		    	activityPopedomGrid = activityPopedom;
	            activityPopedomGrid.setGRID_COLUMN_DISPLAY(listControl.get(i).getGRID_COLUMN_DISPLAY()); 
		    }else{ 
		    	activityPopedomGrid.setCONTROL_ID(listControl.get(i).getCONTROL_ID());
		    	activityPopedomGrid.setACTIVITY_ID(listControl.get(i).getACTIVITY_ID());
	            activityPopedomGrid.setGRID_COLUMN_DISPLAY(listControl.get(i).getGRID_COLUMN_DISPLAY());  
		    }
            configService.saveActivityPopedom(activityPopedomGrid);
	    } 
	    
	    result = "{\"result\":\"保存成功\"}";
	    return result.toString();
	}
	/**
	 * 获取待分配的操作者信息
	 * 和获取已经分配权限的操作者信息
	 * lixin2017-7-20 17:21:48
	 * @param organId
	 * @param userIds
	 * @return
	 */
	@RequestMapping("/getUserInfoByOrganId")
	@ResponseBody
	public String getUserInfoByOrganId(Integer organId, String userIds,Integer postId,Integer roleId,Integer operateFlag){
		List<UserInfo> userlist =new ArrayList<>();
		//如果是通过部门过滤，
		if(operateFlag==1){
			userlist = userService.getOrganUserList(organId);
		}else if(operateFlag==2){//如果是通过岗位过滤，
			userlist=userService.getPostUserList(postId);
		}else if(operateFlag==3){//如果是通过角色过滤
			userlist=userService.getRoleUserList(roleId);
		}
		return getUserlist(userlist,userIds);
	}
	private String getUserlist(List<UserInfo> userlist ,String userIds){
		JSONObject json = new JSONObject();
		List<UserInfo> userlistSe = new ArrayList<UserInfo>();
		String[] userId = userIds.split(",");
		if(userIds != ""){
			for (int i = 0; i < userId.length; i++) {
				UserInfo user = userService.getUserInfo(Integer.parseInt(userId[i]));
				userlistSe.add(user);
				for (int j=0; j< userlist.size(); j++) {	
					if(userlist.get(j).getUserId() == Integer.parseInt(userId[i])){
						userlist.remove(j);
					}
				}
			}
		}
		json.put("data", userlist);
		json.put("dataSe", userlistSe);
		return json.toString();
	}
	/**
	 * 删除节点和线
	 * lixin
	 * 2017-9-14 10:30:56
	 * @param nodeId
	 * @param arrLines
	 * @return
	 */
	@RequestMapping("/delNodesAndLines")
	@ResponseBody
	public String delNodesAndLines(int nodeId,String arrLines)
	{ 
	  	 //删除连线 
		 JSONArray lineJson = JSONArray.fromObject(arrLines);
		 List<WF_LINE> wfLineList= JSONArray.toList(lineJson, WF_LINE.class);
		 if(wfLineList.size()>0){
			 for(int i=0;i<wfLineList.size();i++){
				 WF_LINE wfLine = new WF_LINE();
				 wfLine.setLINE_ID(wfLineList.get(i).getLINE_ID());
				 try {
					configService.deleteLine(nodeId);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			 }
		 }
	  	//删除节点 
		
			//1 先删除操作者
				try {
					configService.deleteHandler(nodeId);
				} catch (Exception e) {
					e.printStackTrace();
				}
				//2 在删除活动权限表
				configService.deleteWfActivityPopedom(nodeId);
				//3 删除流转规则
				//configService.deleteWfRule(nodeId);
				//4 查询工作活动 list此时需要全部删除
				configService.deleteActivitySonTable(nodeId);
				//5 删除节点
			    configService.deleteWFActivity(nodeId);
		
		return "success";
	} 
	/**
	 * 过滤工作流节点配置的操作者使用
	 * 需要展示权限范围内的用户
	 * 
	 * liixn
	 * 2018-2-7 09:35:38
	 * @param request
	 * @return
	 */
	@RequestMapping("/getMyUserList")
	@ResponseBody
	public String getMyUserList(HttpServletRequest request){
		UserSession userSession = (UserSession) request.getSession().getAttribute("usersession");
		//获取当前登录用户权限范围内的组织机构
		String mySubOrganIds=merchantService.getMySubOrganIds(userSession);
		//获取当前登录用户权限范围内的用户集合eg：（144,146）
		String mySubUserIds=userService.getSubUserIds(mySubOrganIds);
		//去掉括号
		 String userIds=mySubUserIds.replace("(",""); 
		 userIds=userIds.replace(")","");
		JSONObject json = new JSONObject();
		json.put("data", userIds);
		return json.toString();
	}
	/**
	 * 获取当前登录用户应该展示的组织结构，用于    售电公司
	 * lixins
	 * 2018-1-25 14:08:59
	 * 
	 * @param parentOrganId
	 * @return
	 */
	@RequestMapping("/getMyChildOrgan")
	@ResponseBody
	public String getMyChildOrgan(int parentOrganId,HttpServletRequest request){
		JSONObject json = new JSONObject();
		List<TreeView> tree = new ArrayList<TreeView>();
		UserSession userSession = (UserSession)request.getSession().getAttribute("usersession");
		String myOrganIds=merchantService.getMyOrganIds(userSession);
		tree=getMyOrganTree(parentOrganId, myOrganIds);
		json.put("data", tree);
		return json.toString();
	}
	
	@RequestMapping("/treeReceiverPost")
	@ResponseBody
	public String treeReceiverPost(int parentOrganId,HttpServletRequest request){
		JSONObject json = new JSONObject();
		List<TreeView> tree = new ArrayList<TreeView>();
		UserSession userSession = (UserSession)request.getSession().getAttribute("usersession");
		String myOrganIds=merchantService.getMyOrganIds(userSession);
		tree=treeReceiverPost(parentOrganId, myOrganIds);
		json.put("data", tree);
		return json.toString();
	}
	public List<TreeView> treeReceiverPost(int parentOrganId,String myOrganIds){
		List<TreeView> tree = new ArrayList<TreeView>();
		if(parentOrganId == -1){
			TreeView ts = new TreeView();
			ts.setId(0);
			ts.setName("组织机构");
			ts.setType("folder");
			tree.add(ts);
		}
		else{
			List<Organ> listOrgan =new ArrayList<Organ>();
			if(parentOrganId==0){//获取第一层所有的组织机构
				listOrgan = organPostService.getMySubOrganList(parentOrganId,myOrganIds);  //获取所有节点  
				for(int i =0;i<listOrgan.size();i++){
					TreeView t = new TreeView();
					Organ organ = listOrgan.get(i);
					t.setId(organ.getOrganId());
					t.setName(organ.getOrganName());
					t.setType("folder");							
					tree.add(t);
				}
			}else{//去掉右括号
				myOrganIds=myOrganIds.substring(0, myOrganIds.length()-1);
				myOrganIds= myOrganIds +","+parentOrganId+")";
				List<Post> listPost = organPostService.getTreeReceiverPost(parentOrganId,myOrganIds);
				//根据parentOrganId获取该组织机构下的所有子组织，并查询所有子组织下所有的岗位
				for(int i =0;i<listPost.size();i++){
					TreeView t = new TreeView();
					Post post = listPost.get(i);
					t.setId(post.getPostId());
					t.setName(post.getPostName());
					t.setType("item");				
					tree.add(t);
				}
			}
		}
		return tree;
	}
	/**
	 * 加载所有的角色
	 * lixin
	 * 2018-3-28 08:48:10
	 * @param parentOrganId
	 * @param myOrganIds
	 * @return
	 */
	@RequestMapping("/treeReceiverRole")
	@ResponseBody
	public String treeReceiverRole(){
		JSONObject json = new JSONObject();
		List<TreeView> tree = new ArrayList<TreeView>();
		Role role=new Role();
		 MiniDaoPage<Role> roleList=accountRoleService.getRolePagingList(role, 1, 999999);
		 for(int i =0;i<roleList.getResults().size();i++){
				TreeView t = new TreeView();
				Role roleTree = roleList.getResults().get(i);
				t.setId(roleTree.getRoleId());
				t.setName(roleTree.getRoleName());
				t.setType("item");							
				tree.add(t);
			}
		json.put("data", tree);
		return json.toString();
	}
	/**
	 * 根据父组织id和要获取的组织id的集合，获取属于当前公司的组织机构
	 * liixn
	 * 2018-2-1 08:38:56
	 * @param parentOrganId
	 * @param myOrganIds
	 * @return
	 */
	public List<TreeView> getMyOrganTree(int parentOrganId,String myOrganIds){
		List<TreeView> tree = new ArrayList<TreeView>();
		if(parentOrganId == -1){
			TreeView ts = new TreeView();
			ts.setId(0);
			ts.setName("组织机构");
			ts.setType("folder");
			tree.add(ts);
		}
		else{
			List<Organ> listOrgan =new ArrayList<Organ>();
			if(parentOrganId==0){
				listOrgan = organPostService.getMySubOrganList(parentOrganId,myOrganIds);  //获取所有节点  
			}else{
				listOrgan = organPostService.getSubOrganList(parentOrganId);  //获取所有节点  
			}
			for(int i =0;i<listOrgan.size();i++){
				TreeView t = new TreeView();
				Organ organ = listOrgan.get(i);
				t.setId(organ.getOrganId());
				t.setName(organ.getOrganName());
				List<Organ> listChild = organPostService.getSubOrganList(organ.getOrganId());
				if(listChild.size() <= 0)
					t.setType("item");				
				else
					t.setType("folder");							
				tree.add(t);
			}
		}
		return tree;
	}
}

package cn.zup.workflow.wfInterface.wfController;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import cn.zup.rbac.controller.ViewEntity.TreeView;
import cn.zup.rbac.entity.Organ;
import cn.zup.rbac.entity.Post;
import cn.zup.rbac.entity.Role;
import cn.zup.rbac.entity.UserInfo;
import cn.zup.rbac.entity.UserSession;
import cn.zup.rbac.service.AccountRoleService;
import cn.zup.rbac.service.MerchantService;
import cn.zup.rbac.service.OrganPostService;
import cn.zup.rbac.service.UserService;
import cn.zup.workflow.biz.IWorkFlowConfig;
import cn.zup.workflow.model.ACTIVITY_POPEDOM;
import cn.zup.workflow.model.WF_ACTIVITY;
import cn.zup.workflow.model.WF_FORM;
import cn.zup.workflow.model.WF_FORM_CONTROL;
import cn.zup.workflow.model.WF_HANDLER;
import cn.zup.workflow.structure.FlowRequest;
import net.sf.json.JSONObject;
import cn.zup.workflow.config.HandlerAndMonitorType;
import cn.zup.workflow.wfInterface.wfService.WorkFormAccessService;
/**
 * 内控系统调用工作流
 * @date 2018-4-2 10:21:05
 * 
 * */
@Controller
@RequestMapping("/rest/workflow/WorkFormAccessController")
public class WorkFormAccessController {
	@Resource
	private IWorkFlowConfig iWorkFlowConfig;
	@Resource
	private WorkFormAccessService workFormAccessService;
	@Resource
	private OrganPostService  organPostService;
	
	@Resource
	private AccountRoleService  accountRoleService;
	
	@Resource
	private UserService userService;            //从rbac引入
	@Resource
	private MerchantService merchantService;    //从rbac引入
	/**
	 * @throws Exception 
	 *
	 * */
	public List<ACTIVITY_POPEDOM> getActivityFormControlPopedom(FlowRequest flowRequest) throws Exception{
		int activityId = 0;
		if(flowRequest.getActivityID() == null){
			activityId =  iWorkFlowConfig.getFirstActivitys(Integer.parseInt(flowRequest.getFlowID())).getACTIVITY_ID();
		}else{
			activityId = Integer.parseInt(flowRequest.getActivityID());
		}
		return iWorkFlowConfig.listActivityPopedom(activityId);
	}
	/**
	 * 当前登录用户有权限的表单控件
	 * lixin
	 * '2018-4-2 16:25:27
	 * @param formId
	 * @param userId
	 * @return
	 */
	public List<WF_FORM_CONTROL> getWfFormControl(int formId){
		return workFormAccessService.getWfFormControl(formId);
	}
	
	/**
	 * 获取表单列表
	 * lixin
	 * 2018-4-2 15:18:17
	 * @param parentMenuId
	 * @param systemId
	 * @return
	 * @throws SQLException
	 */
	@RequestMapping("/getFormList")//getSonNode
	@ResponseBody
	private String getFormList(int parentFormId){
		JSONObject json = new JSONObject();
		List<TreeView> treeList = new ArrayList<TreeView>();
		if(parentFormId == -1){
			TreeView treeParent = new TreeView();
			treeParent.setId(0);
			treeParent.setName("表单列表");
			treeParent.setType("folder");
			treeList.add(treeParent);
		}else{
			treeList.clear();
			List<WF_FORM> wfforms = workFormAccessService.listFormSub(parentFormId);
			for(WF_FORM  form : wfforms){
				TreeView tree = new TreeView();
				tree.setId(form.getFORM_ID());
				tree.setName(form.getFORM_NAME());
				List<WF_FORM> childList = workFormAccessService.listFormSub(form.getFORM_ID());
				if(childList.size() <= 0){
					tree.setType("item");
				}else{
					tree.setType("folder");
				}
				treeList.add(tree); 
			}
		}
		json.put("data", treeList);
		String s = json.toString();
		s=s.replace('_','-');
		return s;
	}
	/**
	 * 通过一个父级组织id，获取该组织机构下所有的组织机构
	 * lixin
	 * 2018-4-2 15:27:18
	 * @param parentOrganId
	 * @return
	 */
	@RequestMapping("/getOrganTree")
	@ResponseBody
	public String getOrganTree(int parentOrganId){
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
			//todo:del
			//List<Organ> listOrgan = workFormAccessService.getSubOrganList(parentOrganId);  //获取所有节点
			
			List<Organ> listOrgan =organPostService.getSubOrganList(parentOrganId);
			for(int i =0;i<listOrgan.size();i++){
				TreeView t = new TreeView();
				Organ wfOrgan = listOrgan.get(i);
				t.setId(wfOrgan.getOrganId());
				t.setName(wfOrgan.getOrganName());
				if(wfOrgan.getChildCounts() <= 0)
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
	 * 通过一个组织机构id获取该组织下的全部岗位
	 * lixin
	 * 2018-4-2 16:05:44
	 * @param parentOrganId
	 * @param request
	 * @return
	 */
	@RequestMapping("/getPostTree")
	@ResponseBody
	public String getPostTree(int parentOrganId,HttpServletRequest request){
		JSONObject json = new JSONObject();
		List<TreeView> tree = new ArrayList<TreeView>();
		tree=treeReceiverPost(parentOrganId);
		json.put("data", tree);
		return json.toString();
	}
	public List<TreeView> treeReceiverPost(int parentOrganId){
		List<TreeView> tree = new ArrayList<TreeView>();
		if(parentOrganId == -1){
			TreeView ts = new TreeView();
			ts.setId(0);
			ts.setName("组织机构");
			ts.setType("folder");
			tree.add(ts);
		}
		else{
			 
			if(parentOrganId==0){//获取第一层所有的组织机构
				//todo:del
				//listOrgan = workFormAccessService.getSubOrganList(parentOrganId);  //获取所有节点  
				List<Organ>listOrgan =organPostService.getSubOrganList(parentOrganId);
				for(int i =0;i<listOrgan.size();i++){
					TreeView t = new TreeView();
					Organ wfOrgan = listOrgan.get(i);
					t.setId(wfOrgan.getOrganId());
					t.setName(wfOrgan.getOrganName());
					t.setType("folder");							
					tree.add(t);
				}
			}else{//去掉右括号
				
				//List<IPost> listPost = workFormAccessService.getPostList(parentOrganId);
				
				List<Post> listPost=organPostService.getTreeReceiverPost(parentOrganId,null);
				//根据parentOrganId获取该组织机构下的所有子组织，并查询所有子组织下所有的岗位
				for(int i =0;i<listPost.size();i++){
					TreeView t = new TreeView();
					Post wfPost = listPost.get(i);
					t.setId(wfPost.getPostId());
					t.setName(wfPost.getPostName());
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
	@RequestMapping("/getRoleTree")
	@ResponseBody
	public String getRoleTree(){
		JSONObject json = new JSONObject();
		List<TreeView> tree = new ArrayList<TreeView>();
		Role role=new Role();
		//todo:del
		// List<IRole> roleList=workFormAccessService.getRoleList(role);  		
		List<Role> roleList=accountRoleService.getRolePagingList(role,1, 900000).getResults();;
		 for(int i =0;i<roleList.size();i++){
				TreeView t = new TreeView();
				Role roleTree = roleList.get(i);
				t.setId(roleTree.getRoleId());
				t.setName(roleTree.getRoleName());
				t.setType("item");							
				tree.add(t);
			}
		json.put("data", tree);
		return json.toString();
	}
	/**
	 * 不同部门、岗位、角色获取人员信息
	 * lixin
	 * 2018-4-2 15:38:34
	 * @param organId：部门id
	 * @param postId：岗位id
	 * @param roleId：角色id
	 * @param operateFlag：操作标志：1：同部门过滤；2：同岗位过滤：3：同角色过滤
	 * @param userIds：已经配置的用户ids
	 * @return
	 */
	@RequestMapping("/getUserInfo")
	@ResponseBody
	public String getUserInfo(Integer organId, Integer postId,Integer roleId,Integer operateFlag,String userIds){
		List<UserInfo> userlist =new ArrayList<>();
		//如果是通过部门过滤，
		if(operateFlag==1){
			//todo:del
			//userlist = workFormAccessService.getOrganUserList(organId);
			userlist=userService.getOrganUserList(organId);
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
				UserInfo wfUserInfo = userService.getUserInfo(Integer.parseInt(userId[i]));
				userlistSe.add(wfUserInfo);
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
	 * 添加操作者信息
	 * 先删除，后添加
	 */
	@RequestMapping("/addOperatorUser")
	@ResponseBody
	public String addOperatorUser( String handlerString, int activityId,int handlerSetType) throws Exception{		
		JSONObject json = new JSONObject();
		//保存操作者选择模式
		WF_ACTIVITY activity = iWorkFlowConfig.getAcitivity(activityId);
		if(activity!=null)
		{
			activity.setHANDLER_SEL_TYPE(handlerSetType);
			iWorkFlowConfig.saveActivity(activity);
		}
		//删除原有操作者
		if(activityId != 0){
			iWorkFlowConfig.deleteHandler(activityId);
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
					int result = iWorkFlowConfig.saveHandler(wfhandler);
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
	@RequestMapping("/getMyUserList")
	@ResponseBody
	public String getMyUserList(HttpServletRequest request){
		UserSession userSession = (UserSession) request.getSession().getAttribute("usersession");
		//获取当前登录用户权限范围内的组织机构
		//todo:del
		//String userIds =workFormAccessService.getMyUserList(userSession);
		
		String mySubOrganIds=merchantService.getMySubOrganIds(userSession);
		//获取当前登录用户权限范围内的用户集合eg：（144,146）
		String userIds=userService.getSubUserIds(mySubOrganIds);
		//去掉括号
		userIds=userIds.replace("(",""); 
		userIds=userIds.replace(")","");
		JSONObject json = new JSONObject();
		json.put("data", userIds);
		return json.toString();
	}
}

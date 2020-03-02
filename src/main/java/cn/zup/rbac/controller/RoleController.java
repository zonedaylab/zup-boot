package cn.zup.rbac.controller;

import cn.zup.rbac.controller.ViewEntity.RoleDataViewModel;
import cn.zup.rbac.controller.ViewEntity.TreeView;
import cn.zup.rbac.entity.*;
import cn.zup.rbac.service.*;
import cn.zup.rbac.service.settings.ConfigSetting;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.lang.System;

@Controller
@RequestMapping("/rest/rbac/roleController")
public class RoleController
{

	@Resource
	private AccountRoleService accountRoleService;
	@Resource
	ResourcePermissionService resourcepermission;
	@Resource
	ResourcePermissionService resourcePermissionService;
	@Resource
	ResourceService resourceService;
	@Resource
	private ConfigurationService configurationService; 
	@Resource
	private UserService userService; 
	
	/**
	 * 
	 * 角色权限管理页面
	 * @author 谢炎
	 * @date 2016-7-27 11:18:19
	 * 
	 * */
	@RequestMapping("")
	public ModelAndView index(HttpServletRequest request){
		return new ModelAndView("rbac/roleManage");
	}
	
	/**
	 * 获取角色信息
	 * 
	 * */
	@RequestMapping("/getRoleInfo")
	@ResponseBody
	public String getRoleInfo(Role role, int page, int rows, HttpServletRequest request){		
		role.setRoleTypeConfig(ConfigSetting.RoleType.getValue());
		MiniDaoPage<Role>  roleInfo = accountRoleService.getRolePagingList(role, page, rows);
		JSONObject json = new JSONObject();
		json.put("rows", rows);
		json.put("page", roleInfo.getPages());
		json.put("total", roleInfo.getTotal());
		JSONArray jsonarr = JSONArray.fromObject(roleInfo.getResults());  
		json.put("data", jsonarr);
		return json.toString();
	}
	/**
	 * 获取数据信息
	 * 
	 * */
	@RequestMapping("/getRoleDataInfo")
	@ResponseBody
	public String getRoleDataInfo(RoleDataViewModel roledata, int page, int rows, HttpServletRequest request){
		roledata.setDataPermissionConfig(ConfigSetting.DataPermissionType.getValue());
		MiniDaoPage<RoleDataViewModel>  dataInfo = accountRoleService.getDataInfo(roledata, page, rows);
		JSONObject json = new JSONObject();
		json.put("rows", rows);
		json.put("page", dataInfo.getPages());
		json.put("total", dataInfo.getTotal());
		JSONArray jsonArr = JSONArray.fromObject(dataInfo.getResults());  
		json.put("data", jsonArr);
		return json.toString();
	}
	/**
	 * 单选框自动填充
	 * @param menuId
	 * @param roleId
	 * @return
	 * 
	 */
	@RequestMapping("/getMenuPermission")
	@ResponseBody
	public String getMenuPermission(int menuId,int roleId){
		JSONObject json=new JSONObject();
		
		if(resourceService.getMenuPermission(menuId, roleId)){
			json.put("data", "true");
		}
		else{
			json.put("data", "false");
		}
		return json.toString();
	}
	
	/** 
	 *角色详情页面
	 *
	 *@param roleID
	 *@return 
	*/
	@RequestMapping("/lookRoleInfo")
	@ResponseBody
	public String lookRoleInfo(int roleId)
	{
		JSONObject json = new JSONObject();
		Role roleinfo = accountRoleService.getRoleInfo(roleId);
		JSONArray jsonarr = JSONArray.fromObject(roleinfo); 
		json.put("roleInfo", jsonarr);
		return json.toString();
	}
	/** 
	 *添加菜单权限
	 *
	 *@param menuID
	 *@return 
	*/
	@RequestMapping("/addMenuRole")
	@ResponseBody 
	public String addMenuRole(int menuIds,int roleId)
	{
		JSONObject json=new JSONObject();
		
		//先删除角色下 所有菜单权限
		RoleMenu roleMenu = new RoleMenu();
		roleMenu.setMenuId(menuIds);
		roleMenu.setRoleId(roleId);
		
		if(resourcepermission.getMenuPermissionInfo(roleId, menuIds) != null){
			resourcepermission.deleteMultMenuPermission(roleMenu); 
			json.put("data", "delete");
			
		}else{
			roleMenu.setMenuPermission(1); //1代码新增的角色菜单有效 
			resourcepermission.addMenuPermission(roleMenu);
			json.put("data", "add");
		}
		return json.toString();
	}
	/** 
	 *获取未分配账户
	 *
	 *@param organid
	 *@param name
	 *@return 
	*/
	@RequestMapping("/getNoAccount")
	@ResponseBody
	public String getNoAccount(Integer organId, String accountName){
		List<Account> lists = accountRoleService.getAccountName(organId, accountName);
		JSONObject json = new JSONObject();		
		json.put("data", lists);
		if(lists.size()==0){
			json.put("none", "yes");
		}
		return json.toString();
	}
	//加载数据操作项列表
		@RequestMapping("/getOperationSignList")
		@ResponseBody
		public String getOperationSignList(Action action,Integer page,Integer rows,HttpServletRequest request)
		{
			MiniDaoPage<Action> actionList = resourceService.getOperationSignList(action, page, rows);
			JSONObject json = new JSONObject();
			json.put("rows", rows);
			json.put("page", actionList.getPages());
			json.put("total", actionList.getTotal());
			JSONArray jsonArray = JSONArray.fromObject(actionList.getResults());  
			json.put("data", jsonArray);
			return json.toString();
		}
	/**
	 * 获取已分配账户 
	 */
	@RequestMapping("/getAssignedAccountInit")
	@ResponseBody
	public String getAssignedAccountInit(Integer roleId)
	{
		JSONObject json = new JSONObject();
		List<Account> listAccount = accountRoleService.getRoleAccountList(roleId);
		Map<Integer, Map> data = new HashMap<Integer, Map>();
		for(int i=0; i<listAccount.size(); i++){
			Map<String, String> mapdata = new HashMap<String, String>();
			mapdata.put("id", listAccount.get(i).getAccountId()+"");
			mapdata.put("text", listAccount.get(i).getAccountName());
			data.put(i+1, mapdata);
		}		
		//JSONArray jsonarr = JSONArray.fromObject(listAccountRole); 
		json.put("data", data);
		return json.toString();		
	}

	@RequestMapping("/getAssignedAccount")
	@ResponseBody
	public String getAssignedAccount(Integer roleId)
	{
		JSONObject json = new JSONObject();
		List<Account> listAccount = accountRoleService.getRoleAccountList(roleId);		
		json.put("data", listAccount);
		return json.toString();		
	}
	
	/** 
	 *添加分配账户
	 *
	 * @param accountid
	 * @param roleid
	 * @date 2016-7-28 09:20:41
	*/
	@RequestMapping("/addAccountRole")
	@ResponseBody
	public boolean addAccountRole(@RequestParam("accountIds[]") String[] accountIds,int roleId)
	{
		//先做删除操作，再做添加操作
		//根据角色id获取所有的account集合遍历集合删除
		List<Account> listAccount=accountRoleService.getRoleAccountList(roleId);
		if(listAccount!=null && listAccount.size()!=0){
			for(int i=0;i<listAccount.size();i++){
				AccountRole accountrole=new AccountRole();
				accountrole.setAccountId(listAccount.get(i).getAccountId());
				accountrole.setRoleId(roleId);
				accountRoleService.deleteAccountRole(accountrole);
			}
		}						
		//添加accountrole
		if(!accountIds[0].equals("-1")){
			for(int j=0;j<accountIds.length;j++){
				AccountRole accountrole2=new AccountRole();
				accountrole2.setAccountId(Integer.parseInt(accountIds[j]));
				accountrole2.setRoleId(roleId);
				accountRoleService.addAccountRole(accountrole2);
			}
		}
		return true;
	}
	
	/** 
	 * 新增角色
	 * @param role  角色实体
	 * @date 2016-7-28 09:07:46
    */
	@RequestMapping("/addRole")
	@ResponseBody
	public boolean addRole(Role role)
	{
		if(accountRoleService.getRoleRepeatVerify(null, role.getRoleName())){
			return false;
		}else{
			accountRoleService.addRole(role);
			return true;
		}	
	}
	
	/** 
	 *删除角色
	 *
	 *@param role  角色实体
	 *@date 2016-7-28 09:07:52
	*/
	@RequestMapping("/delRole")
	@ResponseBody
	public String delRole(@RequestParam("roleIds[]") String[] roleIds)
	{
		//判断角色是否跟其他表有关联关系
		JSONObject json = new JSONObject();
		String returnRoleId="";
		for(int i=0; i<roleIds.length; i++){	
			if(accountRoleService.getRoleSonTable(Integer.parseInt(roleIds[i])).size()>0&&accountRoleService.getRoleSonTable(Integer.parseInt(roleIds[i]))!=null){
				returnRoleId += roleIds[i]+",";
				json.put("info",returnRoleId);
				json.put("result", "error");				
			}
			else
			{
				Role role=new Role();
				role.setRoleId(Integer.parseInt(roleIds[i]));
				accountRoleService.deleteRole(role);
				json.put("result", "success");
			}
		}		
		return json.toString();
	}
	/** 
	 * 编辑角色
	 *
	 * @param role  角色实体
	*/
	@RequestMapping("/editRole")
	@ResponseBody
	public boolean editRole(Role role)
	{
		if(accountRoleService.getRoleRepeatVerify(role.getRoleId(), role.getRoleName())){
			return false;
		}else{
			accountRoleService.updateRole(role);
			return true;
		}	
	}
	

	/**
	 * 
	 * desc: 保存操作项按钮 默认权限为1 
	 * Author：samson
	 * Date: 2016.07.30 
	 * 
	 * */ 
	@RequestMapping("/saveActionDatas")
	@ResponseBody
	public boolean saveActionDatas(@RequestParam("actionIds[]") String[] actionIds,int roleId)
	{  
		for(int i = 0;i<actionIds.length;i++)
		{ 
			RoleAction roleAction = new RoleAction();
			roleAction.setActionId(Integer.valueOf(actionIds[i]));
			roleAction.setRoleId(roleId);
			roleAction.setActionPermission(1); //1代码新增的角色操作项有效 
			resourcePermissionService.addActionPermission(roleAction);  
		}  
		return true;
	}

	/**
	 * 
	 * desc: 保存操作项按钮 参数权限由页面参数决定
	 * Author：samson
	 * Date: 2019.08.19 
	 * 
	 * */ 
	@RequestMapping("/saveActionDataPermission")
	@ResponseBody
	public boolean saveActionDataPermission(@RequestParam("actionIds[]") String[] actionIds,@RequestParam("actionPermissions[]") String[] actionPermissions,int roleId)
	{  
		for(int i = 0;i<actionIds.length;i++)
		{ 
			RoleAction roleAction = new RoleAction();
			roleAction.setActionId(Integer.valueOf(actionIds[i]));
			roleAction.setRoleId(roleId);
			roleAction.setActionPermission(1); //1代码新增的角色操作项有效 
			
			//判断如果带有操作项的显隐性参数则存储--实现按钮的显隐性
			if(actionPermissions !=null && actionPermissions.length == actionIds.length)
			{
				roleAction.setActionPermission(Integer.valueOf(actionPermissions[i])); //元素权限
			}
			resourcePermissionService.addActionPermission(roleAction);  
		}  
		return true;
	}


	/**
	 * 
	 * desc:删除角色操作项数据
	 * Author：samson
	 * Date: 2016.07.30 
	 * 
	 * */ 
	@RequestMapping("/delRoleActionDatas")
	@ResponseBody
	public boolean delRoleActionDatas(@RequestParam("actionIds[]") String[] actionIds,int roleId)
	{  
		for(int i = 0;i<actionIds.length;i++)
		{
			RoleAction roleAction = new RoleAction();
			roleAction.setActionId(Integer.valueOf(actionIds[i]));
			roleAction.setRoleId(roleId); 
			resourcePermissionService.deleteActionPermission(roleAction); 
		}  
		return true;
	}

	/** 
	 *获取角色操作项详情
	 *
	 *@param menuID
	 *@return 
	*/
	@RequestMapping("/getRoleActionList")
	@ResponseBody
	public String getRoleActionList(Action action,Integer page,Integer rows,HttpServletRequest request,int roleId)
	{
		MiniDaoPage<ActionPermission> actionList = resourceService.getRolePermitAction(null, roleId, page, rows);
		JSONObject json = new JSONObject(); 
		json.put("rows", rows);
		json.put("page", actionList.getPages());
		json.put("total", actionList.getTotal());
		JSONArray jsonArr = JSONArray.fromObject(actionList.getResults());  
		json.put("data", jsonArr);
		return json.toString(); 
	}
	/** 
	 *获取未分配菜单详情
	 *
	 *@param menuID
	 *@return 
	*/
	@RequestMapping("/getUnSignedActionList")
	@ResponseBody
	public String getActionList(Action action,Integer page,Integer rows,Integer roleId,HttpServletRequest request)
	{
		MiniDaoPage<ActionPermission> actionList = resourceService.getRolePermitActionAdd(action.getMenuId(), roleId, page, rows);
		JSONObject json = new JSONObject();
		json.put("rows", rows);
		json.put("page", actionList.getPages());
		json.put("total", actionList.getTotal());
		JSONArray jsonArray = JSONArray.fromObject(actionList.getResults());  
		json.put("data", jsonArray);
		return json.toString();
	}
	/** 
	 *获取已分配菜单详情
	 *
	 *@param menuID
	 *@return 
	*/
	@RequestMapping("/getSignedActionList")
	@ResponseBody
	public String getSignedActionList(Action action,Integer page,Integer rows,Integer roleId,HttpServletRequest request)
	{
		MiniDaoPage<ActionPermission> actionList = resourceService.getAlreadyRolePermitActionAdd(action.getMenuId(), roleId, page, rows);
		JSONObject json = new JSONObject();
		json.put("rows", rows);
		json.put("page", actionList.getPages());
		json.put("total", actionList.getTotal());
		JSONArray jsonArray = JSONArray.fromObject(actionList.getResults());  
		json.put("data", jsonArray);
		return json.toString();
	}
	
	/** 
	 角色数据保存
	*/
	@RequestMapping("/addDataMenuRole")
	@ResponseBody
	public boolean RoleDataSaveOrUpdate(RoleData roleData){
		resourcepermission.addDataPermission(roleData);
		return true;
	}
	/**
	 * 
	 * desc:获取有角色类型下拉菜单
	 * Author：lixin
	 * Date: 2016.08.11 
	 * 
	 * */ 
	@RequestMapping("/getRoleType")
	@ResponseBody
	public String getRoleType(){		
		Config config = new  Config();
		config.setConfigid(ConfigSetting.RoleType.getValue());		
		List<Config> listRoleType =configurationService.getConfigInfo(config);
		JSONObject json = new JSONObject();
		json.put("data", listRoleType);		
		return json.toString();
	}
	/**
	 * 获取数据权限类型
	 * lixin
	 * 2016/08/11
	 * @return
	 */
	@RequestMapping("/getDataType")
	@ResponseBody
	public String getDataType(){
		Config config = new  Config();
		config.setConfigid(ConfigSetting.DataPermissionType.getValue());
		System.out.println("测试获取的数据权限类型相对应的configId"+config.getConfigid());
		List<Config> listDataPermissionType =configurationService.getConfigInfo(config);
		JSONObject json = new JSONObject();
		json.put("data", listDataPermissionType);
		return json.toString();
	}
	/**
	 * 获取角色账户列表
	 * @param roleId
	 * @return
	 */
	@RequestMapping("/getAccountSource")
	@ResponseBody
	public String getAccountSource(int roleId){		
		//String accountnames="";
		//List<Account> listAccount = accountRoleService.getRoleAccountList(roleId);	
		List<Account> listAccount = accountRoleService.getRoleAccountList(roleId);
		JSONObject json = new JSONObject(); 	
		JSONArray jsonArr = JSONArray.fromObject(listAccount);  
		json.put("data", jsonArr);
		return json.toString(); 
	}
	/**
	 * 删除角色数据
	 * @param dataIds
	 * @return
	 */
	@RequestMapping("/delRoleData")
	@ResponseBody
	public String deleteRoleData(@RequestParam("dataIds[]") String[] dataIds)
	{
		JSONObject json = new JSONObject();		
		for(int i=0; i<dataIds.length; i++){
			RoleData roleData=new RoleData();
			roleData.setDataId(Integer.parseInt(dataIds[i]));
			resourcePermissionService.deleteDataPermission(roleData);
				json.put("result", "success");				
			}
		return json.toString();
	}
	
	/**
	 * 获取有权限的 菜单
	 * 
	 * */
	@RequestMapping("/getRoleActionTree")
	@ResponseBody
	private String getChildNode(Integer parentMenuId, Integer systemId, Integer roleId, HttpServletRequest request){
		JSONObject json = new JSONObject();
		UserSession userSession = (UserSession)request.getSession().getAttribute("usersession");
		List<TreeView> treeList = new ArrayList<TreeView>();
		if(parentMenuId == -1){
			TreeView treeParent = new TreeView();
			treeParent.setId(0);
			treeParent.setName("菜单管理");
			treeParent.setType("folder");
			treeList.add(treeParent);
		}else{
			treeList.clear();
			List<Menu> menuList =  resourceService.getRoleActionTree(systemId, parentMenuId, roleId);//获取所有节点  
			for(int i =0;i<menuList.size();i++){
				TreeView treeChild = new TreeView();
				Menu menu = menuList.get(i);
				treeChild.setId(menu.getMenuId());
				treeChild.setName(menu.getMenuName());
				List<Menu> childList = resourceService.getMenuList(menu.getMenuId());
				if(childList.size() <= 0){
					treeChild.setType("item");
				}else{
					treeChild.setType("folder");
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
	 * 获取登录用户的角色id
	 * xgy
	 * 2018年9月25日
	 * @param request
	 * @return
	 */
	@RequestMapping("/getAccountRoleId")
	@ResponseBody
	public Integer getAccountRoleId(HttpServletRequest request){
		//获取当前登录用户信息
		UserSession user = (UserSession)request.getSession().getAttribute("usersession");
		if(user == null){
			return null;
		}
		//通过accountId获取用户的角色ID
		List<AccountRole> roles = accountRoleService.getAccountRoleInfoByAccountId(user.getAccountId());
		if(roles.size() > 0){
			return roles.get(0).getRoleId();
		} else {
			return null;
		}
	}
}

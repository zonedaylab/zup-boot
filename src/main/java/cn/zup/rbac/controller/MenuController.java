package cn.zup.rbac.controller;

import cn.zup.rbac.controller.ViewEntity.TreeView;
import cn.zup.rbac.controller.ViewEntity.TreeViewChecked;
import cn.zup.rbac.entity.Config;
import cn.zup.rbac.entity.Menu;
import cn.zup.rbac.entity.MenuRoleEx;
import cn.zup.rbac.entity.System;
import cn.zup.rbac.service.AccountRoleService;
import cn.zup.rbac.service.ConfigurationService;
import cn.zup.rbac.service.ResourceService;
import cn.zup.rbac.service.settings.ConfigSetting;
import cn.zup.workflow.biz.IWorkFlowConfig;
import cn.zup.workflow.model.WF_FLOW;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * 菜单管理页面
 * @author 谢炎
 * @date 2016-7-28 19:28:54
 * 
 * 
 * */
@Controller
@RequestMapping("/rest/rbac/menuController")
public class MenuController{
	
	@Resource
	ResourceService resourceServie;
	@Resource
	AccountRoleService accountRoleService;
	@Resource
	private ConfigurationService configurationService; 
	@Resource
	private IWorkFlowConfig configService;
	@Resource
	private ResourceService resourceService;	
	
	/**
	 * 菜单管理页面
	 * @author 谢炎
	 * @data 2016-7-27 10:46:12
	 * 
	 **/
	@RequestMapping("")
	public ModelAndView index(HttpServletRequest request) {  
	    return new ModelAndView("rbac/menuManage");
	}
	
	/** 
	 * 系统列表
	 * @author 谢炎
	 * @data 2016-7-27 10:46:12
	*/
	@RequestMapping("/getSystemList")
	@ResponseBody
	public String getSystemList()
	{
		List<System> systemList = resourceServie.getSystemList();
		JSONObject json = new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(systemList);
		json.put("systemList", jsonArray);
		return json.toString();
	}

	/** 
	 *初始化菜单树
	 * @author 谢炎
	 * @param systemId 系统id   parentMenuId 父菜单id 
	 * @data 2016-7-29 08:53:36
	 *  
	*/
	@RequestMapping("/getChildNode")//getSonNode
	@ResponseBody
	private String getChildNode(int parentMenuId, int systemId, boolean rootOnly){
		JSONObject json = new JSONObject();
		List<TreeView> treeList = new ArrayList<TreeView>();
		if(parentMenuId == -1){
			TreeView treeParent = new TreeView();
			treeParent.setId(0);
			treeParent.setName("菜单管理");
			treeParent.setType("folder");
			treeList.add(treeParent);
		}else{
			treeList.clear();
			List<Menu> menuList =  resourceServie.getSystemMenuList(systemId, parentMenuId, rootOnly);//获取所有节点  
			for(int i =0;i<menuList.size();i++){
				TreeView treeChild = new TreeView();
				Menu menu = menuList.get(i);
				treeChild.setId(menu.getMenuId());
				treeChild.setName(menu.getMenuName());
				List<Menu> childList = resourceServie.getMenuList(menu.getMenuId());
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
	 *获取菜单详情
	 *
	 *@param menuID  菜单ＩＤ
	 *@date 2016-7-29 08:53:50
	*/
	@RequestMapping("/getMenu")
	@ResponseBody
	public String getMenu(int menuId)
	{
		Menu menu = resourceServie.getMenuInfo(menuId);
		JSONObject json = new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(menu);  
		json.put("data", jsonArray);
		return json.toString();
	}
	
	/** 
	 *菜单保存
	 *@param menu 菜单实体
	 *@data 2016-7-27 10:46:12 
	*/
	@RequestMapping("/addMenu")
	@ResponseBody
	public boolean addMenu(Menu menu)
	{
		if(resourceServie.getMenuRepeatVerify(null, menu.getSystemId(),menu.getParentMenuId(),menu.getMenuName()))
		{
			return false;
		}else{
			resourceServie.addMenu(menu);
			return true;
		}	
	}
	
	/** 
	 *菜单信息编辑
	 *
	 *@param menu 菜单实体
	 *@data 2016-7-27 10:46:12
	*/
	@RequestMapping("/editMenu")
	@ResponseBody
	public boolean editMenuInfo(Menu menu)
	{
		if(resourceServie.getMenuRepeatVerify(menu.getMenuId(), menu.getSystemId(),menu.getParentMenuId(),menu.getMenuName()))
		{
			return false;
		}else{
			resourceServie.updateMenu(menu);
			return true;
		}	
	}

	/** 
	 *删除菜单信息
	 *
	 *@param menu　　菜单实体
	 *@data 2016-7-27 10:46:12
	 *
	*/
	@RequestMapping("/delMenu")
	@ResponseBody
	public boolean delMenu(Menu menu)
	{
		try{
			resourceServie.deleteMenu(menu);
		}catch(Exception e){
			return false;
		}
		return true;
	}
	

	/** 
	 *初始化菜单树
	 * @author samson 
	 * @param systemId 系统id   parentMenuId 父菜单id 
	 * @data 2016-7-29  
	 *  
	*/
	@RequestMapping("/getMenuAndActionNode")//getSonNode
	@ResponseBody
	private String getMenuAndActionNode(int parentMenuId, int systemId,int roleId, boolean rootOnly){
		JSONObject json = new JSONObject();
		List<TreeView> treeList = new ArrayList<TreeView>();
		if(parentMenuId == -1){
			TreeView treeParent = new TreeView();
			treeParent.setId(0);
			treeParent.setName("菜单管理");
			treeParent.setType("folder");
			treeList.add(treeParent);
		}else{
			treeList.clear();
			List<MenuRoleEx> menuList =  resourceServie.getRolePermitChildMenu(roleId,systemId,parentMenuId);
			for(int i =0;i<menuList.size();i++){
				TreeView treeChild = new TreeView();
				MenuRoleEx menu = menuList.get(i);
				treeChild.setId(menu.getMenuId());
				treeChild.setName(menu.getMenuName());
				List<Menu> childList = resourceServie.getMenuList(menu.getMenuId());
				if(childList.size() <= 0){
					treeChild.setType("item");
					if(menu.getMenurole()!=0){
						TreeViewChecked tc = new TreeViewChecked();
						tc.setId(menu.getMenuId());
						tc.setItem_selected(true);
						treeChild.setAdditionalParameters(tc);
					}
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
	 * 根据菜单id获取相应的工作流id
	 * @param menuId
	 * @return
	 */
	@RequestMapping("/getWorkflow")
	@ResponseBody
	public String getWorkflow(int systemId){
		List<WF_FLOW> flowlist;
		JSONObject json = new JSONObject();
		try {
			flowlist = configService.listFlow(systemId);
			
			json.put("data", flowlist);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return json.toString();
	}
	
	/**根据配置信息
	 * 获取mobileFlag标识
	 * @return
	 */
	@RequestMapping("/getMobileFlag")
	@ResponseBody
	public String getValidFlag(){
		Config config = new  Config();
		config.setConfigid(ConfigSetting.MobileFlagType.getValue());
		List<Config> mobileFlag =configurationService.getConfigInfo(config);
		JSONObject json = new JSONObject();
		json.put("data", mobileFlag);
		return json.toString();
	}
	
}

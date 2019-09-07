package cn.zup.rbac.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.zup.rbac.entity.Action;
import cn.zup.rbac.service.ConfigurationService;
import cn.zup.rbac.service.ResourcePermissionService;
import cn.zup.rbac.service.ResourceService;
import cn.zup.rbac.service.settings.ConfigSetting;

/**
 * 
 * 菜单操作项控制器
 * @author 谢炎
 * @date 2016-7-27 10:59:42
 * 
 * */
@Controller
@RequestMapping("rest/rbac/menuActionController")
public class MenuActionController{
	
	@Resource
	ResourceService resourceService;
	@Resource
	ResourcePermissionService resourcePermissionService;
	
	/**
	 * 
	 * 菜单操作项页面
	 * @author 谢炎
	 * @date 2016-7-27 10:59:42
	 * 
	 * */
	@RequestMapping("")
	public ModelAndView index(HttpServletRequest request){
		return new ModelAndView("rbac/menuActionManage");
	}
	
	/** 
	 *获取菜单详情
	 *
	 *@param menuID
	 *@return 
	*/
	@RequestMapping("/getActionList")
	@ResponseBody
	public String getActionList(Action action,Integer page,Integer rows,HttpServletRequest request)
	{
		MiniDaoPage<Action> actionList = resourceService.getActionPagingList(action, page, rows);
		JSONObject json = new JSONObject();
		json.put("rows", rows);
		json.put("page", actionList.getPages());
		json.put("total", actionList.getTotal());
		JSONArray jsonArray = JSONArray.fromObject(actionList.getResults());  
		json.put("data", jsonArray);
		return json.toString();
	}
	
	
	/** 
	 * 添加操作项信息
	 * 		
	 * @param action 操作项实体
	 * 
	*/
	@RequestMapping("/addAction")
	@ResponseBody
	private boolean addAction(Action action)
	{
		if(resourceService.getActionRepeatVerify(null,action.getMenuId(),action.getActionName())){
			return false;
		}else{
			resourceService.addAction(action);
			return true;
		}	
	}
	/** 
	 * 
	 *  菜单操作项编辑
	 *  
	 *  @param action  操作项实体
	*/
	@RequestMapping("/editAction")
	@ResponseBody
	public boolean editAction(Action action, HttpServletRequest request)
	{
		if(resourceService.getActionRepeatVerify(action.getActionId(),action.getMenuId(),action.getActionName())){
			return false;
		}else{
			resourceService.updateAction(action);
			return true;
		}	
	}
	/** 
	* 菜单操作项查看
	*@param actionId  操作项id
	*@return 
	*/
	@RequestMapping("/getAction")
	@ResponseBody
	public String getAction(int actionId, HttpServletRequest request)
	{
		JSONObject json = new JSONObject();
		Action actionInfo = resourceService.getActionInfo(actionId);
		JSONArray jsonArray = JSONArray.fromObject(actionInfo); 
		json.put("actioninfo", jsonArray);
		return json.toString();
	}
	/** 
	*删除操作项 
    *@param actionId  操作项id
	*@return 
	*/
	@RequestMapping("/deleteAction")
	@ResponseBody
	public String deleteAction(@RequestParam("actionIds[]") String[] actionIds)
	{
		String returnCode = "";
		JSONObject json = new JSONObject();	
		for(int i=0; i<actionIds.length; i++){				
				//判断该操作项是否有关联子表(roleaction)数据				
				if(resourcePermissionService.getRoleActionFromAction(Integer.parseInt(actionIds[i])).size()==0){
					resourceService.deleteAction(Integer.parseInt(actionIds[i]));
					json.put("result", "success");
				}
				else{
					returnCode += actionIds[i]+",";				
					json.put("result", "error");
					json.put("info", returnCode);
				}
			}
		return json.toString();	
	}
}

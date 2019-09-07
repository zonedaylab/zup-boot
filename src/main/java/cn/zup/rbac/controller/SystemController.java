package cn.zup.rbac.controller;

import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import cn.zup.rbac.controller.ViewEntity.TreeView;
import cn.zup.rbac.entity.System;
import cn.zup.rbac.service.ResourceService;

/**
 * 用于系统管理中相关操作的控制
 * 
 * @author 李欣 time：2016/7/27
 * 
 */
 @Controller
 @RequestMapping("/rest/rbac/systemController")
 public class SystemController {
	@Resource
	private ResourceService resourceService;
	
	
	/**
	 * 用于通过controller访问systemManage.jsp
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("")
	public ModelAndView index(HttpServletRequest request) {
		return new ModelAndView("rbac/systemManage");
	}

	/**
	 * 加载左侧树结构
	 * 
	 * @return
	 */
	@RequestMapping("/getSystemTree")
	@ResponseBody
	private String getSystemTree() {
		JSONObject json = new JSONObject();
		List<TreeView> tree = new ArrayList<TreeView>();
		List<System> listSystem = resourceService.getSystemList(); // 获取所有节点
		for (int i = 0; i < listSystem.size(); i++) {
			TreeView t = new TreeView();
			System system = listSystem.get(i);
			t.setId(system.getSystemId());
			t.setName(system.getSystemName());
			tree.add(t);
		}
		json.put("data", tree);
		return json.toString();
	}

	/**
	 * 点击节点，获取相应system信息
	 * 
	 * @param systemid
	 * @param request
	 * @return
	 */
	@RequestMapping("/getSystem")
	@ResponseBody
	public String getSystem(Integer systemId, HttpServletRequest request) {
		System listSystem = resourceService.getSystemInfo(systemId);
		JSONArray jsonarr = JSONArray.fromObject(listSystem);
		JSONObject json = new JSONObject();		
		json.put("data", jsonarr);
		return json.toString();
	}

	/**
	 * 系统添加
	 * 
	 * @param post
	 * @return
	 */
	@RequestMapping("/addSystem")
	@ResponseBody
	public String addSystem(System system) {
		JSONObject json = new JSONObject();			
		if(!resourceService.getSystemRepeatVerify(null, system.getSystemName())){
			resourceService.addSystem(system);
			json.put("result", "success");
		}
		else 
			json.put("result", "error");
			
		return json.toString();
	}

	/**
	 * 删除系统
	 * 
	 * @param system
	 * @return
	 */
	@RequestMapping("/deleteSystem")
	@ResponseBody
	public String deleteSystem(System system) {		
		JSONObject json = new JSONObject();		
		// 判断该系统是否与菜单表有关联关系		
		List<System> listSystem = resourceService.getSystemSonTable(system.getSystemId());		
		if (listSystem.size()== 0) {
			resourceService.deleteSystem(system);
			json.put("result", "success");			
		} else {
			json.put("result", "error");			
		}
		return json.toString();
	}

	/**
	 * 系统编辑
	 * 
	 * @param post
	 * @return
	 */
	@RequestMapping("/editSystem")
	@ResponseBody
	public String editSystem(System system) {
		JSONObject json = new JSONObject();
		java.lang.System.out.println("测试系统名称是否重复"+resourceService.getSystemRepeatVerify(null, system.getSystemName()));
		if(!resourceService.getSystemRepeatVerify(system.getSystemId(), system.getSystemName())){
			resourceService.updateSystem(system);
			json.put("result", "success");
		}
		else 
			json.put("result", "error"); 
		return json.toString();
	}
}

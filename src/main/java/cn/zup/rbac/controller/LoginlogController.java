package cn.zup.rbac.controller;

import java.util.Date;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.zup.framework.json.JsonDateValueProcessor;
import cn.zup.rbac.entity.Config;
import cn.zup.rbac.entity.LoginLog;
import cn.zup.rbac.entity.System;
import cn.zup.rbac.entity.UserSession;
import cn.zup.rbac.service.LoginLogService;
import cn.zup.rbac.service.MerchantService;
import cn.zup.rbac.service.ResourceService;
import cn.zup.rbac.service.UserService;
import cn.zup.rbac.service.settings.ConfigSetting;
import cn.zup.rbac.service.settings.LoginLogType;

/**
 * 用于登录日志中相关操作的控制
 * @author 李欣
 * time：2016/7/27
 *
 */
@Controller
@RequestMapping("/rest/rbac/loginlogController")
public class LoginlogController {
	@Resource
	private LoginLogService loginlogService;
	@Resource
	private MerchantService merchantService;
	@Resource
	private UserService userService;
	
	/**
	 * 通过controller访问loginlog.jsp
	 * @param request
	 * @return
	 */
	@RequestMapping("")
	public ModelAndView index(HttpServletRequest request) {  
	    return new ModelAndView("rbac/loginlog");
	 }
	
	/**
	 * 显示相关登录日志的信息
	 * @param username
	 * @param startLogDateTime
	 * @param endLogDateTime
	 * @param logtype
	 * @param systemid
	 * @param page
	 * @param rows
	 * @param request
	 * @return
	 */
	@RequestMapping("/gird")
	@ResponseBody 
	public String getgrid(LoginLog loginlog, int page, int rows,HttpServletRequest request) {	
		UserSession userSession = (UserSession)request.getSession().getAttribute("usersession");
		//获取当前登录用户权限范围内的组织机构
		String mySubOrganIds=merchantService.getMySubOrganIds(userSession);
		String mySubUserIds=userService.getSubUserIds(mySubOrganIds);
		if(mySubUserIds!=""){
			loginlog.setUserIds(mySubUserIds);
		}
		MiniDaoPage<LoginLog> pageopers = loginlogService.getLoginLogPagingList(loginlog,page, rows);
		JSONObject json = new JSONObject(); 
		json.put("rows", rows);
		json.put("page", pageopers.getPages());
		json.put("total",pageopers.getTotal());
		
		//日期类型的json转换
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor());		
		JSONArray jsonarray = JSONArray.fromObject(pageopers.getResults(), jsonConfig);  
		json.put("data", jsonarray);
		return json.toString();  
	}
	
	/**
	 * 在登录日志页面中请求的系统下拉菜单
	 */
	@Resource
	private ResourceService resourcesystem;
	@RequestMapping("/loadSystem")
	@ResponseBody
	public String getLoadSystem(){
		List<System> system1 = resourcesystem.getSystemList();
		//日期类型的json转换
		JSONObject json = new JSONObject(); 
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor());		
		JSONArray jsonarray = JSONArray.fromObject(system1, jsonConfig);  
		json.put("data", jsonarray);
		return json.toString();
	}
	
	@RequestMapping("/loadLoginResult")
	@ResponseBody
	public String loadLoginResuly(){
		LoginLog loginLog = new LoginLog();
		loginLog.setLogTypeConfig(ConfigSetting.LoginLogType.getValue());
		List<Config> list = loginlogService.getLoginLogResult(loginLog);
		JSONObject json = new JSONObject();
		json.put("data", list);
		return json.toString();
		
	}
}

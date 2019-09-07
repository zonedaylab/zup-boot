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
import cn.zup.rbac.entity.OperateLog;
import cn.zup.rbac.service.ConfigurationService;
import cn.zup.rbac.service.MerchantService;
import cn.zup.rbac.service.OperateLogService;
import cn.zup.rbac.service.ResourceService;
import cn.zup.rbac.service.UserService;
import cn.zup.rbac.service.settings.ConfigSetting;
import cn.zup.rbac.entity.System;
import cn.zup.rbac.entity.UserSession;

/**
 * 
 * 操作日志 页面
 * @author 谢炎
 * @date 2016-7-29 13:37:45
 * 
 * */
@Controller
@RequestMapping("/rest/rbac/operateLogControaller")
public class OperateLogController {
	@Resource
	private OperateLogService operateLogService;
	@Resource
	private ResourceService resourcesystem;
	@Resource
	ConfigurationService configurationService;
	@Resource
	private MerchantService merchantService;
	@Resource
	private UserService userService;
	/**
	 * 
	 * 操作日志管理页面
	 * @author 谢炎
	 * @date 2016-7-27 11:18:19
	 * 
	 * */
	@RequestMapping("")
	public ModelAndView index(HttpServletRequest request){
		return new ModelAndView("rbac/operateLog");
	}
	
	/**
	 * 
	 * 获取操作日志信息
	 * @author 谢炎
	 * @date 2016-7-28 11:18:19
	 * 
	 * */
	@RequestMapping("/getGird")
	@ResponseBody 
	public String getGrid(OperateLog operateLog,Integer page,Integer rows,HttpServletRequest request) {
		operateLog.setLogLevelConfig(ConfigSetting.LogLevelType.getValue());
		UserSession userSession = (UserSession)request.getSession().getAttribute("usersession");
		//获取当前登录用户权限范围内的组织机构
		String mySubOrganIds=merchantService.getMySubOrganIds(userSession);
		String mySubUserIds=userService.getSubUserIds(mySubOrganIds);
		if(mySubUserIds!=""){
			operateLog.setUserIds(mySubUserIds);
		}
		MiniDaoPage<OperateLog> pageOpers = operateLogService.getOperateLogPagingList(operateLog, page, rows);
		JSONObject json = new JSONObject(); 
		json.put("rows", rows);
		json.put("page", pageOpers.getPages());
		json.put("total",pageOpers.getTotal());
		//日期类型的json转换
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor());
		//实体类类型json转换
		JSONArray jsonArray = JSONArray.fromObject(pageOpers.getResults(), jsonConfig);  
		json.put("data", jsonArray);
		return json.toString();  
	}
	
	/**
	 * 
	 * 获取系统信息
	 * @author 谢炎
	 * @date 2016-7-28 11:18:19
	 * 
	 * */
	@RequestMapping("/loadSystem")
	@ResponseBody
	public JSONObject LoadSystem(){
		List<System> system = resourcesystem.getSystemList();
		JSONObject json = new JSONObject();
		json.put("data", system);
		return json;
	}
	
	/**
	 * 
	 * desc:获取操作日志等级
	 * Author：谢炎
	 * Date: 2016-8-1 11:02:24
	 * 
	 * */ 
	@RequestMapping("/getLogLevel")
	@ResponseBody
	public String getLogLevel(){
		Config config = new  Config();
		config.setConfigid(ConfigSetting.LogLevelType.getValue());
		List<Config> logLevel =configurationService.getConfigInfo(config);
		JSONObject json = new JSONObject();
		json.put("data", logLevel);
		return json.toString();
	}
	
}

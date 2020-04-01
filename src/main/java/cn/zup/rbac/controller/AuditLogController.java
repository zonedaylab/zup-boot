package cn.zup.rbac.controller;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.hibernate.validator.constraints.Range;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.zup.framework.json.JsonDateValueProcessor;
import cn.zup.framework.util.HttpRequestUtils;
import cn.zup.framework.util.IPAddressUtils;
import cn.zup.rbac.entity.AuditLog;
import cn.zup.rbac.entity.UserSession;
import cn.zup.rbac.service.AuditLogService;
import cn.zup.rbac.service.MerchantService;
import cn.zup.rbac.service.UserService;
import cn.zup.rbac.service.settings.ConfigSetting;
import cn.zup.wechat.util.GlobalConstants;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

/**
 * 审计日志
 * @author Andot
 * @date 2018-1-22 14:21:58
 * 
 * */
@Controller
@RequestMapping("/rest/rbac/auditLogController")
public class AuditLogController {
	
	@Resource
	private AuditLogService auditLogService;
	@Resource
	private MerchantService merchantService;
	@Resource
	private UserService userService;
	
	public static String URL = GlobalConstants.getString("AMapIPUrl");
	public static String KEY = GlobalConstants.getString("AMapWebAPIKey");
	
	/**
	 * 首页
	 * @author Andot
	 * @date 2018-1-22 14:21:58
	 * 
	 * */
	@RequestMapping("")
	public ModelAndView index(HttpServletRequest request){
		return new ModelAndView("rbac/auditLog");
	}
	
	/**
	 * 添加审计日志
	 * @author Andot
	 * @date 2018-1-22 14:21:58
	 * 
	 * */
	@RequestMapping("/addAuditLog")
	@ResponseBody
	public String addAuditLog(AuditLog auditLog, HttpServletRequest request, HttpServletResponse response){
		HttpSession session = request.getSession();
		UserSession us = (UserSession)session.getAttribute("usersession");
		if(us==null)
			return "addAuditlog 出错，userSession为空，请重新登录!";
		auditLog.setUserIp(request.getRemoteAddr());
		String url = URL+"key="+KEY+"&ip="+auditLog.getUserIp()+"&output=JSON";
		try {
			JSONObject ipaddr = HttpRequestUtils.HTTPPostRequest(url);
			auditLog.setIpAddr(ipaddr.getString("province")+" "+ipaddr.getString("city"));
		} catch (Exception e) {
			auditLog.setIpAddr("IP地址不合法");
		}
		auditLog.setUserId(us.getUserId());
		auditLog.setSystemId(us.getSystemId());
		auditLog.setAuditDate(new Date());
		auditLogService.addAuditLog(auditLog);
		return "";
	}
	
	/**
	 * 获取审计日志列表
	 * @author Andot
	 * @date 2018-1-22 14:21:58
	 * 
	 * */
	@RequestMapping("/getAuditLogByList")
	@ResponseBody
	public String getAuditLogByList(AuditLog auditLog, Integer page, Integer rows, HttpServletRequest request){
		auditLog.setAuditLevelName(ConfigSetting.LogLevelType.getValue()+"");
		UserSession userSession = (UserSession)request.getSession().getAttribute("usersession");
		//获取当前登录用户权限范围内的组织机构
		String mySubOrganIds=merchantService.getMySubOrganIds(userSession);
		String mySubUserIds=userService.getSubUserIds(mySubOrganIds);
		if(mySubUserIds!=""){
			auditLog.setUserIds(mySubUserIds);
		}
		MiniDaoPage<AuditLog> minidaoList = auditLogService.getAuditLogList(auditLog, page, rows);
		JSONObject json = new JSONObject(); 
		json.put("rows", rows);
		json.put("page", minidaoList.getPages());
		json.put("total",minidaoList.getTotal());
		//日期类型的json转换
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor());
		//实体类类型json转换
		JSONArray jsonArray = JSONArray.fromObject(minidaoList.getResults(), jsonConfig);  
		json.put("data", jsonArray);
		return json.toString();
	}
	
}

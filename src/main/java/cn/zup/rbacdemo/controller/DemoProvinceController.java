package cn.zup.rbacdemo.controller;

import java.util.ArrayList;
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
import cn.zup.framework.util.DateUtil;
import cn.zup.framework.util.DateUtils;
import cn.zup.rbac.entity.Action;
import cn.zup.rbac.entity.OperateLog;
import cn.zup.rbac.entity.RoleData;
import cn.zup.rbac.entity.UserSession;
import cn.zup.rbac.service.OperateLogService;
import cn.zup.rbac.service.ResourcePermissionService;
import cn.zup.rbac.service.ResourceService;
import cn.zup.rbac.service.settings.DataPermissionType;
import cn.zup.rbac.service.settings.OperateLogType;
import cn.zup.rbacdemo.entity.DemoProvince;
import cn.zup.rbacdemo.service.DemoProvinceService;

@Controller
@RequestMapping("/rest/rbac/demo")
public class DemoProvinceController {

	@Resource
	private DemoProvinceService demoProvinceService;
	
	//数据权限services
	@Resource
	private ResourcePermissionService resourcePermissionService;
	
	//操作项权限services
	@Resource
	private ResourceService resourceService;
	
	//操作日志Services
	@Resource
	private OperateLogService operateLogService;

	/**
	 * 
	 * demo首页面
	 * @author 韩圣传
	 * @date 2016-8-3
	 * 
	 * */
	@RequestMapping("")
	public ModelAndView index(HttpServletRequest request){
		int menuId = Integer.parseInt(request.getParameter("menuid"));
		UserSession userSession = (UserSession)request.getSession().getAttribute("usersession");
		int accountId = userSession.getAccountId();
		//读取本页面含有的操作项权限
		List<Action> actions = resourceService.getActionListByMenuAndAccount(menuId,accountId);
		List<String> actionNames = new ArrayList<String>();
		for(Action ac :actions){
			actionNames.add(ac.getActionName());
		}
	
		request.setAttribute("actionNames", actionNames);
		
		return new ModelAndView("rbac/demoProvinceManage");
	}
	
	/**
	 * 
	 * 获取demo信息
	 * @author 韩圣传
	 * @date 2016-8-3
	 * 
	 * */
	@RequestMapping("/getGird")
	@ResponseBody 
	public String getGrid(DemoProvince demoProvince,Integer page,Integer rows,HttpServletRequest request) {
		
		//读取数据权限
		UserSession userSession = (UserSession)request.getSession().getAttribute("usersession");
		int accountId = userSession.getAccountId();
		int menuId = Integer.parseInt(request.getParameter("menuId"));
		
		List<RoleData> roledata = resourcePermissionService.getAccountDataPermissionList(accountId,menuId,DataPermissionType.OrganPermission);
		
		MiniDaoPage<DemoProvince> pageOpers = demoProvinceService.getProvincePagingList(demoProvince, page, rows,roledata);
		
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
	 * 增加demo信息
	 * @author 韩圣传
	 * @date 2016-8-3
	 * 
	 * */
	@RequestMapping("/addDemo")
	@ResponseBody 
	public String addDemoProvince(DemoProvince demoProvince,HttpServletRequest request) {
		UserSession userSession = (UserSession)request.getSession().getAttribute("usersession");
		int userId = userSession.getUserId();
		//操作日志
		OperateLog log = new OperateLog();
		log.setSystemId(1);
		log.setUserId(userId);
		log.setPageName("数据权限示例");
		log.setLogInfo("增加操作");
		log.setLogDate(DateUtils.getDate());
		log.setLogLevel(OperateLogType.info.getValue());
		log.setLogSql("Hibernate:insert into OperateLog");
		log.setUserName(userSession.getRealName());
		log.setSystemName("Zup平台");
		
		operateLogService.addOperateLog(log);
		
		demoProvinceService.add(demoProvince);
		JSONObject json = new JSONObject();
		json.put("result", "success");
		return json.toString();  
	}

}

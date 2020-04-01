package cn.zup.rbac.controller;

 
import cn.zup.rbac.entity.LoginLog;
import cn.zup.rbac.entity.Organ;
import cn.zup.rbac.entity.UserSession;
import cn.zup.rbac.service.*;
import cn.zup.rbac.service.settings.LoginLogType;
import cn.zup.rbacmap.entity.DomainSystem;
import cn.zup.wechat.util.GlobalConstants;
import net.sf.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;

@Controller
@RequestMapping("/rest/rbac/loginController")
public class LoginController { 
	@Resource
	private UserService userService;
	@Resource
	private LoginLogService loginlogService;
	@Resource
	private ResourceService resourceService;
	@Resource
	private MerchantService merchantService;
	@Resource
	private AccountRoleService accountRoleService;
	
	Logger log = LoggerFactory.getLogger(LoginController.class);
	
	/**
	 * main首页面
	 * Author：韩圣传
	 * @param 
	 **/
	@RequestMapping("")
	public ModelAndView index(HttpServletRequest request) {
	    return new ModelAndView("rbac/login");
	}
	/**
	 * 微信登录的请求以及页面
	 * @param request
	 * @return
	 */
	@RequestMapping("/wxLogin")
	public ModelAndView weiXinLogin(HttpServletRequest request) { 
		ModelAndView mv = new ModelAndView();
		mv.addObject("userName", request.getParameter("userName"));
		mv.addObject("password", request.getParameter("password"));
		if(request.getParameter("mark")!=null){
			mv.addObject("mark", request.getParameter("mark"));
		}
		System.out.println("李欣2017-1-5 12:29:30查看mark值"+request.getParameter("mark"));
		mv.setViewName("rbac/wxlogin");
	    return mv;
	}
	@RequestMapping("/wxlogins")
	@ResponseBody 
	public String wxlogins(String accountname,String password,HttpServletRequest request) {
		//根据accountname和password获取accountid 
		UserSession userSession=userService.getUserSessionInfo(accountname,password);	
		UserSession userNameValid=userService.getUserSessionInfo(accountname,null);			
		HttpSession session=request.getSession();		
		LoginLog loginLog = new LoginLog(); 
		Date nowTime = new Date(System.currentTimeMillis()); 
		loginLog.setLogdatetime(nowTime);
		loginLog.setLogip(request.getRemoteAddr()); 
		loginLog.setRetrycount(1);
		loginLog.setSystemid(1);
		loginLog.setSystemname("微信登录光伏运维平台");
		JSONObject json = new JSONObject(); 
		if(userSession!=null){
			loginLog.setLogtype(LoginLogType.success.getValue());  //登录类型为成功 
			loginLog.setAccountid(userSession.getAccountId());
			loginLog.setUserid(userSession.getUserId());
			loginLog.setUsername(userSession.getRealName()); 
			session.setAttribute("usersession", userSession); 
			json.put("msg", "success");
			loginlogService.addLoginLog(loginLog); //记录登录日志信息 
		} else if(userSession==null && userNameValid!=null){
			loginLog.setLogtype(LoginLogType.fail.getValue());  //登录类型为成失败 
			loginLog.setAccountid(userNameValid.getAccountId());
			loginLog.setUsername(userNameValid.getRealName());
			loginLog.setUserid(userNameValid.getUserId());
			json.put("msg", "pswFail");
			loginlogService.addLoginLog(loginLog); //记录登录日志信息 
		} else {
			json.put("msg", "fail"); 
		}
		return json.toString();
	}
	
	/**
	 * 售电微信端登录
	 * 谢关云 2018年2月8日23:19:44
	 * @param accountname
	 * @param password
	 * @param request
	 * @return
	 */
	@RequestMapping("/esaleCommonCompanyAPPLogin")
	@ResponseBody 
	public String esaleCommonCompanyAPPLogin(String accountname,String password,HttpServletRequest request) {
		//根据accountname和password获取accountid 
		UserSession userSession=userService.getUserSessionInfo(accountname,password);	
		UserSession userNameValid=userService.getUserSessionInfo(accountname,null);			
		HttpSession session=request.getSession();
		LoginLog loginLog = new LoginLog(); 
		Date nowTime = new Date(System.currentTimeMillis()); 
		loginLog.setLogdatetime(nowTime);
		loginLog.setLogip(request.getRemoteAddr()); 
		loginLog.setRetrycount(1);
		loginLog.setSystemid(1);
		loginLog.setSystemname("售电APP登录");
		JSONObject json = new JSONObject();
		if(userSession!=null){
			Organ organ = merchantService.getMyCompany(userSession.getUserId());
			loginLog.setLogtype(LoginLogType.success.getValue());  //登录类型为成功 
			loginLog.setAccountid(userSession.getAccountId());
			loginLog.setUserid(userSession.getUserId());
			loginLog.setUsername(userSession.getRealName()); 
			session.setAttribute("usersession", userSession); 
			json.put("msg", "success");
			loginlogService.addLoginLog(loginLog); //记录登录日志信息 
		} else if(userSession==null && userNameValid!=null){
			loginLog.setLogtype(LoginLogType.fail.getValue());  //登录类型为成失败 
			loginLog.setAccountid(userNameValid.getAccountId());
			loginLog.setUsername(userNameValid.getRealName());
			loginLog.setUserid(userNameValid.getUserId());
			json.put("msg", "pswFail");
			loginlogService.addLoginLog(loginLog); //记录登录日志信息 
		} else {
			json.put("msg", "fail"); 
		}
		return json.toString();
	}
	
	
	/**
	 * 用户登录验证
	 * Author：samson 
	 * Date：2016.7.28 
	 * @param accountname
	 * @param password
	 * @param randCode
	 * @param request
	 * @return
	 */
	@RequestMapping("/login")
	@ResponseBody 
	public String login(String accountname,String password,String randCode,HttpServletRequest request) {
		//根据accountname和password获取accountid 
		JSONObject json = new JSONObject();
		
		UserSession userSessionRevify = (UserSession)request.getSession().getAttribute("usersession");
	    if (userSessionRevify != null) {
	      //json.put("have", "you have login");
	      json.put("msg", "success");
	    } 
	    else if(!FilterUrl(accountname)) //验证accountName
	    {
			json.put("msg", "fail");
	    }
	    else {
			UserSession userSession=userService.getUserSessionInfo(accountname,password);	
			UserSession userNameValid=userService.getUserSessionInfo(accountname,null);			
			HttpSession session=request.getSession();	
			DomainSystem domainSystem=new DomainSystem();
			if(request.getParameter("Esale")!=null && "true".equals(request.getParameter("Esale"))){
					domainSystem=resourceService.getDomainSystemByDomain("Esale");
			}else if(request.getParameter("Sitai")!=null && "true".equals(request.getParameter("Sitai"))){
					domainSystem=resourceService.getDomainSystemByDomain("Sitai");
			}else if(request.getParameter("Hongjialou")!=null && "true".equals(request.getParameter("Hongjialou"))){
					domainSystem=resourceService.getDomainSystemByDomain("Hongjialou");
			}
			else if(request.getParameter("fund")!=null && "true".equals(request.getParameter("fund"))){
				domainSystem=resourceService.getDomainSystemByDomain("fundHomeController");
			}
			else{//默认济南光伏 homeController
				//改为资金fundHome Controller
				domainSystem=resourceService.getDomainSystemByDomain("homeController");
			}
			LoginLog loginLog = new LoginLog(); 
			Date nowTime = new Date(System.currentTimeMillis()); 
			loginLog.setLogdatetime(nowTime);
			loginLog.setLogip(request.getRemoteAddr()); 
			loginLog.setRetrycount(1);
			
			if (GlobalConstants.getString("profiles").equals("dev")) {
				if(userSession!=null) {
					userSession.setSystemId(domainSystem.getSystem_Id());
					loginLog.setLogtype(LoginLogType.success.getValue());  //登录类型为成功 
					loginLog.setAccountid(userSession.getAccountId());
					loginLog.setUserid(userSession.getUserId());
					loginLog.setUsername(userSession.getRealName());
					int sessionFailureTime = 0;
					try {
						sessionFailureTime = GlobalConstants.getInt("sessionFailureTime");
					} catch (Exception e) {
						log.error("session 获取异常"+e.getMessage()+"； 采用默认时间为：10800秒， 三个小时。");
						sessionFailureTime = 10800;
					}
					session.setAttribute("usersession", userSession); 
					session.setMaxInactiveInterval(sessionFailureTime);    //设置session最大失效时间，用秒作为单位
					json.put("msg", "success");
					loginlogService.addLoginLog(loginLog); //记录登录日志信息 
				} else if(userSession==null && userNameValid!=null) {
					loginLog.setLogtype(LoginLogType.fail.getValue());  //登录类型为成失败 
					loginLog.setAccountid(userNameValid.getAccountId());
					loginLog.setUsername(userNameValid.getRealName());
					loginLog.setUserid(userNameValid.getUserId());
					json.put("msg", "pswFail");
					loginlogService.addLoginLog(loginLog); //记录登录日志信息 
				} else {
					json.put("msg", "fail"); 
				}
			} else {
				if(domainSystem!=null){
					loginLog.setSystemid(domainSystem.getSystem_Id());
					loginLog.setSystemname(domainSystem.getSystem_Name());
				}
				if(session.getAttribute("randCode") ==null || (session.getAttribute("randCode")).toString().equalsIgnoreCase(randCode)){//验证码正确  增加验证码为空情况，则表示手机端app登录
					if(userSession!=null) {
						userSession.setSystemId(domainSystem.getSystem_Id());
						loginLog.setLogtype(LoginLogType.success.getValue());  //登录类型为成功 
						loginLog.setAccountid(userSession.getAccountId());
						loginLog.setUserid(userSession.getUserId());
						loginLog.setUsername(userSession.getRealName());
						int sessionFailureTime = 0;
						try {
							sessionFailureTime = GlobalConstants.getInt("sessionFailureTime");
						} catch (Exception e) {
							log.error("session 获取异常"+e.getMessage()+"； 采用默认时间为：10800秒， 三个小时。");
							sessionFailureTime = 10800;
						}
						session.setAttribute("usersession", userSession); 
						session.setMaxInactiveInterval(sessionFailureTime);    //设置session最大失效时间，用秒作为单位
						json.put("msg", "success");
						loginlogService.addLoginLog(loginLog); //记录登录日志信息 
					} else if(userSession==null && userNameValid!=null) {
						loginLog.setLogtype(LoginLogType.fail.getValue());  //登录类型为成失败 
						loginLog.setAccountid(userNameValid.getAccountId());
						loginLog.setUsername(userNameValid.getRealName());
						loginLog.setUserid(userNameValid.getUserId());
						json.put("msg", "pswFail");
						loginlogService.addLoginLog(loginLog); //记录登录日志信息 
					} else {
						json.put("msg", "fail"); 
					}
				}
				else{//验证码不正确
					json.put("msg", "randCode");
				}
			}
	    }
		return json.toString();
	}

    /// <summary>
    /// 过滤特殊字符
    /// </summary>
    /// <param name="url"></param>
    /// <returns></returns>
    private Boolean FilterUrl(String str)
    {
        String replaceStr = str;

        if (!(str == null || "".equals(str)))
        {
            boolean bInvalidChar = false;
            replaceStr = replaceStr.toLowerCase();
            bInvalidChar = replaceStr.contains(">"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("<"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains(">"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("|"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("#"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("having"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("-"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("\""); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("'"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("%"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains(";"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("("); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains(")"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("+"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("script"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("alert"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("select"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("update"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("insert"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("like"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("applet"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("body"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("embed"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("frame"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("html"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("iframe"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("img"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("style"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("layer"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("link"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("ilayer"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("meta"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("or"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains(" "); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("="); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("\\"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("/"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains(";"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("master"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("truncate"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("declare"); if (bInvalidChar) return false;
            bInvalidChar = replaceStr.contains("drop"); if (bInvalidChar) return false;
            return true;
        }
        else
;        	return false;
    }
	
	/**
	 * 用户退出登录
	 * Author：韩圣传 
	 * Date：2016.8.3 
	 * @return
	 */
	@RequestMapping("/logout")
	public ModelAndView logout(HttpSession session) {
		session.invalidate();
		return new ModelAndView("rbac/login");
	}
	
	/**
	 * 前后端分离 退出时清除session
	 * xgy
	 * 2018年8月3日14:48:14
	 * @param session
	 * @return
	 */
	@RequestMapping("/frontLogout")
	@ResponseBody
	public String frontLogout(HttpSession session) {
		session.invalidate();
		JSONObject json = new JSONObject();
		json.put("success", true);
		json.put("msg", "退出成功！");
		return json.toString();
	}
	
}

	

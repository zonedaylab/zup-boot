package cn.zup.wechat.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.zup.rbac.entity.UserSession;
import cn.zup.rbac.service.UserService;
import cn.zup.wechat.common.AdvancedUtil;
import cn.zup.wechat.entity.WechatRegister;
import cn.zup.wechat.entity.WechatServer;
import cn.zup.wechat.entity.WechatSystem;
import cn.zup.wechat.service.BindWechatService;
import cn.zup.wechat.service.WechatServerService;
import cn.zup.wechat.util.GlobalConstants;
import cn.zup.wechat.wechatpojo.WeixinOauth2Token;

/**
 * 微信绑定系统账号
 * @author hans
 *
 */
@Controller
@RequestMapping("/wechat/bind")
public class BindWeChatController {
	
	private static Logger logger = Logger.getLogger(BindWeChatController.class);
	
	@Resource
	private BindWechatService bindService;
	@Resource
	private UserService userService;
	@Resource
	private WechatServerService wechatServerService;
	
	@RequestMapping("/openid")
	public ModelAndView gotobiz(HttpServletRequest request,HttpServletResponse response) throws IOException {
		//获取用户请求系统的ID
		Object companyIds = request.getParameter("companyId");
		String[] args = companyIds.toString().split("-");
		Integer companyId = 0;
		if(companyIds != null){
			companyId = Integer.parseInt(args[0]);
		}
		//谢炎修改，这样可以如果需要跳转不同页面，可以直接传地址进行跳转
		String urlTemp = "";
		if(args.length > 1){
			urlTemp = args[1];
		}
		logger.info("当前您传输了跳转了一个url======》"+urlTemp);
		HttpSession session = request.getSession();
		// 用户同意授权后，能获取到code
		String code = request.getParameter("code");
		logger.info("获取code："+code);
		
		// 用户同意授权
		if (!"authdeny".equals(code)) {
			WechatSystem wsa = new WechatSystem();
			wsa.setCompany_Id(companyId);
			WechatSystem wsainfo = bindService.getSystemInfo(wsa);
			WechatServer wsv = new WechatServer();
			wsv.setService_ID(wsainfo.getService_ID());
			WechatServer wscinfo = wechatServerService.getWechatService(wsv);
			// 获取网页授权access_token
			WeixinOauth2Token weixinOauth2Token = AdvancedUtil.getOauth2AccessToken(wscinfo.getAppid(), wscinfo.getAppsecret(), code);
			logger.info("AppID="+wscinfo.getAppid()+"====scr="+wscinfo.getAppsecret());
			// 网页授权接口访问凭证
			String accessToken = weixinOauth2Token.getAccessToken();
			// 用户标识OpenID
			String openId = weixinOauth2Token.getOpenId();
			// 设置要传递的参数  --------------------------------
			session.setAttribute("openid", openId);
			logger.info("获取openid:"+openId);
			
			//封装到WechatRegister
			WechatRegister wr = new WechatRegister();
			wr.setSystemId(companyId);
			wr.setWxAccount(openId);
			//获取用户名及密码信息
			wr = bindService.getRegisters(wr);
			
			//取到用户信息之后
			if(wr.getRegisterId() != null && wr.getRegisterName().length() > 0){
				
				String name = wr.getRegisterName();
				String pwd = wr.getRegisterPwd();
				
				WechatSystem ws = new WechatSystem();
				ws.setCompany_Id(companyId);
				ws = bindService.getSystem(ws);
				String urlRequest = ws.getSystem_Url();
				
				urlRequest = urlRequest.replace("register_name", name);
				urlRequest = urlRequest.replace("register_pwd", pwd);
				
				logger.info("viewmenu中url："+urlRequest);
				
				if(urlTemp != ""){//若是告警点击进来，则跳转到该用户的待办工作
					urlRequest += "&mark=" + urlTemp;
					logger.info("点击进来需要跳转的url是："+urlTemp);
				}
				request.setAttribute("url", urlRequest);
				return new ModelAndView("wechat/bindgoto");
			}else if(args.length == 3){
				if(urlTemp != ""){//若是告警点击进来，则跳转到该用户的待办工作
					if(openId != null){
						logger.info("公开版点击进来需要跳转的url是："+urlTemp);
						request.setAttribute("url", urlTemp);
					}else{
						request.setAttribute("url", "/m404.jsp");
					}
					return new ModelAndView("wechat/bindgoto");
				}
			}
		}
		WechatSystem ws = new WechatSystem();
		if(args.length <= 3){ //既保留初心，也完成张朝阳需求
			ws.setCompany_Id(companyId);
		}
		List<WechatSystem> systems = bindService.getSystemLists(ws);
		request.setAttribute("systems", systems);
		return new ModelAndView("wechat/bdUser");
	}
	
	@RequestMapping("/register")
	@ResponseBody
	public String register(HttpServletRequest request,HttpServletResponse response) throws IOException {
		String register_name = request.getParameter("register_name");
		String register_pwd = request.getParameter("register_pwd");
		String system_id = request.getParameter("system_id");
		register_pwd = cn.zup.framework.util.MD5Base.md5AddCode(register_pwd);
		//获取微信账号
		String wx_account = request.getParameter("openid");
		logger.info("openid ============== "+wx_account);
		
		//检测账户是否已经绑定
		WechatRegister wrs = new WechatRegister();
		wrs.setRegisterName(register_name);
		String flag = "";
		
		if(wx_account == null){
			return "false";
		}else{
			if(bindService.getRegister(wrs) != null){
				System.err.println("有此用户");
				flag = "yes";
			}else{
				System.err.println("没有此用户");
				WechatRegister wr = new WechatRegister();
				wr.setRegisterName(register_name);
				wr.setRegisterPwd(register_pwd);
				wr.setWxAccount(wx_account);
				wr.setSystemId(Integer.parseInt(system_id));
				Date nowDate = new Date();
				wr.setBindDate(nowDate);
				//判断用户名和密码是否正确
				UserSession userSession = userService.getUserSessionInfo(register_name, register_pwd);
				if(userSession != null){
					bindService.addRegister(wr);
					flag = "true";
				}else{
					flag = "no";
				}
			}
			return flag;
		}
	}

}

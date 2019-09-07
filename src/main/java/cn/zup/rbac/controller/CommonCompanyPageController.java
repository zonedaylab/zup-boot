package cn.zup.rbac.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jeecgframework.minidao.hibernate.dao.IGenericBaseCommonDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.zup.framework.aop.service.SysLog;

/**
 * 公共注册页面，所有公司通过配置走这个地方
 * @author Andot
 * @date 2017-12-26 08:20:32
 * 
 * */
@Controller
public class CommonCompanyPageController {
	
	@Autowired
	private SysLog sysLog;
	
	@RequestMapping("/{code}/login")
	public ModelAndView login(@PathVariable("code") String code, HttpServletRequest request, HttpServletResponse response) throws Exception{
		sysLog.debug();
		
		String logInfo = "当前用户正在进入登录页面，公司代码为：" + code + "; 登录IP地址为：" + request.getRemoteAddr();
		sysLog.addInfoLog(logInfo, "");
		ModelAndView mv = new ModelAndView();
		if(code != null){
			if(code.length() <= 25){
				if (code.equals("admin")) {
					sysLog.addInfoLog(logInfo, "当前用户正在进入系统选择页面，登录IP地址为：" + request.getRemoteAddr());
					mv.setViewName("/404");
				}else if(code.equals("esale"))
				mv.addObject("title", "积成能源售电公司");
				mv.addObject("logo", "plug-in/login/esale/images/logo.png");
				mv.addObject("code", "JCNY");
				mv.addObject("bgimg", "plug-in/login/newLogin/bg.jpg");
				mv.addObject("copyright", "2017 版权归积成能源有限公司所有");
				mv.setViewName("common/SolarLogin");
			}else{
				logInfo = "此用户登录异常，因为他传入的公司代码超出长度25个字符，公司代码为：" + code + "; 登录IP地址为：" + request.getRemoteAddr();
				sysLog.addErrorLog(logInfo, "");
				throw new Exception("@你的操作异常，请重新操作！");
			}
		}else{
			logInfo = "此用户没有传输code，已将他送到404页面; 登录IP地址为：" + request.getRemoteAddr();
			sysLog.addErrorLog(logInfo, "");
			mv.setViewName("/404");
		}
		return mv;
	}
	
	/**
	 * 注册页面
	 * 
	 * */
	@RequestMapping("/{code}/sign")
	public ModelAndView sign(@PathVariable("code") String code, HttpServletRequest request, HttpServletResponse response) throws Exception{
		sysLog.debug();
		String logInfo = "当前用户正在进入注册页面，公司代码为：" + code + "; 登录IP地址为：" + request.getRemoteAddr();
		sysLog.addInfoLog(logInfo, "");
		ModelAndView mv = new ModelAndView();
		if(code != null){
			if(code.length() <= 25){
				mv.setViewName("common/CommonSign");
			}else{
				logInfo = "此用户注册异常，因为他传入的公司代码超出长度25个字符，公司代码为：" + code + "; 登录IP地址为：" + request.getRemoteAddr();
				sysLog.addErrorLog(logInfo, "");
				throw new Exception("@你的操作异常，请重新操作！");
			}
		}else{
			logInfo = "此用户没有传输code，已将他送到404页面; 登录IP地址为：" + request.getRemoteAddr();
			sysLog.addErrorLog(logInfo, "");
			mv.setViewName("/404");
		}
		return mv;
	}
	
	/**
	 * 首页面
	 * 
	 * */
	@RequestMapping("/{code}/main")
	public ModelAndView main(@PathVariable("main") String code, HttpServletRequest request, HttpServletResponse response) throws Exception{
		sysLog.debug();
		String logInfo = "当前用户正在进入首页面，公司代码为：" + code + "; 登录IP地址为：" + request.getRemoteAddr();
		sysLog.addInfoLog(logInfo, "");
		ModelAndView mv = new ModelAndView();
		if(code != null){
			if(code.length() <= 25){
				mv.setViewName("common/CommonMain");
			}else{
				logInfo = "此用户首页异常，因为他传入的公司代码超出长度25个字符，公司代码为：" + code + "; 登录IP地址为：" + request.getRemoteAddr();
				sysLog.addErrorLog(logInfo, "");
				throw new Exception("@你的操作异常，请重新操作！");
			}
		}else{
			logInfo = "此用户没有传输code，已将他送到404页面; 登录IP地址为：" + request.getRemoteAddr();
			sysLog.addErrorLog(logInfo, "");
			mv.setViewName("/404");
		}
		return mv;
	}
}

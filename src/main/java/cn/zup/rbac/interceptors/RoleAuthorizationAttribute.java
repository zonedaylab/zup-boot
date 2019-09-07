package cn.zup.rbac.interceptors;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import cn.zup.framework.util.UrlRedirect;
import cn.zup.rbac.entity.UserSession;
import cn.zup.rbac.service.ResourceService;

/**
 * 权限拦截，拦截所有的controller及jsp
 * @author 韩圣传
 * @version v1.0
 * @date 2016-7-25
 */
public class RoleAuthorizationAttribute extends HandlerInterceptorAdapter {
	
	private static final Logger logger = Logger.getLogger(RoleAuthorizationAttribute.class);
	private final static String[] agent = { "Android", "iPhone", "iPod","iPad", "Windows Phone", "MQQBrowser" };
	
	@Autowired
	ResourceService resourceService;
	
	//xml中配置的不拦截的url地址
	private List<String> excludeUrls;
	
	public List<String> getExcludeUrls() {
		return excludeUrls;
	}

	public void setExcludeUrls(List<String> excludeUrls) {
		this.excludeUrls = excludeUrls;
	}


	/**
	 * 在业务处理器处理请求之前被调用 如果返回false 从当前的拦截器往回执行所有拦截器的afterCompletion(),再退出拦截器链
	 * 如果返回true 执行下一个拦截器,直到所有的拦截器都执行完毕 再执行被拦截的Controller 然后进入拦截器链,
	 * 从最后一个拦截器往回执行所有的postHandle() 接着再从最后一个拦截器往回执行所有的afterCompletion()
	 */
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {

		String requestUri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String url = requestUri.substring(contextPath.length()+1);
		logger.info("url:---" + url);

		//包含被排除的url资源
		if(excludeUrls.contains(url))
			return true;
		
		//使用restful风格，如果后面是数字的话，替换成d。分别考虑到xxx/1234及xxx/1234/edit
		url = url.replaceFirst("/[0-9]*$", "/d").replaceFirst("/[0-9]*/", "/d/");
		
		HttpSession session = request.getSession();
		Object obj = session.getAttribute("usersession");

		if (obj == null) {
			logger.info("Interceptor:---跳转到login页面！");
			String ua = request.getHeader("User-Agent");
			if(checkAgentIsMobile(ua)){
				UrlRedirect.sendUrl("/m404.jsp", response);
			}else
				UrlRedirect.sendUrl("/rest/rbac/loginController", response);
			return false;
		} else{
			UserSession user = (UserSession)obj;
			//1：判断url为menu或者action操作项//2：menu是否含有权限//3：操作项是否含有权限
			//合并到一个方法中
			boolean b  = resourceService.getUrlRoleVerify(url, user.getAccountId());
			if(b)
				return true;
			else{
				UrlRedirect.sendUrl("/role.jsp", response);
				return false;
			}
		}
	}
	
	/**
	* 判断User-Agent 是不是来自于手机
	* @param ua
	* @return
	*/
	public static boolean checkAgentIsMobile(String ua) {
		boolean flag = false;
		if (!ua.contains("Windows NT") || (ua.contains("Windows NT") && ua.contains("compatible; MSIE 9.0;"))) {
			// 排除 苹果桌面系统
			if (!ua.contains("Windows NT") && !ua.contains("Macintosh")) {
				for (String item : agent) {
					if (ua.contains(item)) {
						flag = true;
						break;
					}
				}
			}
		}
		return flag;
	}

	/**
	 * 在业务处理器处理请求执行完成后,生成视图之前执行的动作 可在modelAndView中加入数据，比如当前时间
	 */
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	/**
	 * 在DispatcherServlet完全处理完请求后被调用,可用于清理资源等
	 * 
	 * 当有拦截器抛出异常时,会从当前拦截器往回执行所有的拦截器的afterCompletion()
	 */
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}
}

package cn.zup.framework.aop.interception;

import java.lang.reflect.Method;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import cn.zup.framework.aop.annotations.Auzs;
import cn.zup.framework.util.UrlRedirect;
import cn.zup.rbac.entity.UserSession;

/**
 * 	系统首页路由拦截器 简化系统丢失session之后系统首页跳转问题
 *  SystemHomeRoute
 *  @author Andot
 *  @date 2017-12-19 13:39:25
 *  @param value:传入要跳转的路径（页面地址路径）
 * */

public class AuzsInterception extends HandlerInterceptorAdapter {

	private static Logger log = Logger.getLogger(AuzsInterception.class);

	/**
	 * 在执行目标方法之前执行
	 * 
	 * */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//将handler强制转换为handlerMethod
		HandlerMethod handlerMethod = (HandlerMethod)handler;
		//从方法中获取出要调用的方法
		Method method = handlerMethod.getMethod();
		//获取出方法上的Auzs注解，获取出你这个拦截器要拦截的注解
		Auzs auzs =method.getAnnotation(Auzs.class);
		//如果注解为空，就表示此方法上没有这个注解，就不需要拦截，返回为true就放过了
		if(auzs != null){
			//获取注解的参数
			String url = auzs.value();
			log.info("登录拦截器："+method.getName() + " url = " + url); 
			if(url.length() > 0){
				ServletRequestAttributes attr = (ServletRequestAttributes)RequestContextHolder.currentRequestAttributes();
				HttpSession session = attr.getRequest().getSession(true);
				Object obj = session.getAttribute("usersession");
				if(obj == null){
					UrlRedirect.sendUrl(url, response);
				}else{
					return true;
				}
			}
		}else{
			return true;
		}
		return false;
	}

	/**
	 * 在执行目标方法之后执行
	 * 
	 * */
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	/**
	 * 整个请求完成，即视图渲染结束后调用，这个时候可以做些资源清理工作，或日志记录等
	 * 
	 * */
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}

	/**
	 * HandlerInterceptorAdapter多了一个实现方法afterConcurrentHandlingStarted()，
	 * 它来自HandlerInterceptorAdapter的直接实现类AsyncHandlerInterceptor,
	 * AsyncHandlerInterceptor接口直接继承了HandlerInterceptor，
	 * 并新添了afterConcurrentHandlingStarted()方法用于处理异步请求，
	 * 当Controller中有异步请求方法的时候会触发该方法时，异步请求先支持preHandle、然后执行afterConcurrentHandlingStarted
	 * 
	@Override
	public void afterConcurrentHandlingStarted(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.err.println("afterConcurrentHandlingStarted");
	}*/
}

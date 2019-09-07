package cn.zup.framework.aop.interception;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

/**
 * springmvc拦截器，代码实现方法，与zup-mvc的配置效果一样
 * 
 * */
@Configuration
public class InterceptionConfig extends WebMvcConfigurerAdapter {

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new AuzsInterception()).addPathPatterns("/rest/**");
	}

}

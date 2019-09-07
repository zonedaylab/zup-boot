package cn.zup.framework.aop.filter;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

import cn.zup.framework.aop.utils.CharacterFilter;

@Configuration
public class WebInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {

	/**
	 * 用于配置最先执行的一些配置文件，如RootConfig.java 比如自定义的filter
	 * 多个
	 * */
	@Override
	protected Class<?>[] getRootConfigClasses() {
		Class<?>[] clas = {CharacterFilter.class};
		return clas;
	}

	/**
	 * 这个文件是用于配置welcomefilelist 前置目录+后缀 error-page等
	 * 
	 * */
	@Override
	protected Class<?>[] getServletConfigClasses() {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * 在这里用于配置过滤器 如编码过滤
	 * 
	 * */
	@Override
	protected String[] getServletMappings() {
		// TODO Auto-generated method stub
		return null;
	}
	
}

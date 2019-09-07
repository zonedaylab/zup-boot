package cn.zup.framework.aop.annotations;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 	系统首页路由 简化系统丢失session之后系统首页跳转问题
 *  SystemHomeRoute
 *  @author Andot
 *  @date 2017-12-19 11:10:23
 *  @param value:传入要跳转的路径（Controller路径）
 * */
@Target({ ElementType.METHOD })
@Retention(RetentionPolicy.RUNTIME)
public @interface Auzs {
	/**
	 * 获取被注解方法的参数
	 * 
	 * */
	String value() default "";
}

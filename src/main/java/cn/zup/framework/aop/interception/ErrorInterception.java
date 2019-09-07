package cn.zup.framework.aop.interception;

import org.springframework.boot.context.embedded.ConfigurableEmbeddedServletContainer;
import org.springframework.boot.context.embedded.EmbeddedServletContainerCustomizer;
import org.springframework.boot.web.servlet.ErrorPage;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;

@Configuration
public class ErrorInterception {
	
	@Bean
	public EmbeddedServletContainerCustomizer containerCustomizer(){
		return new EmbeddedServletContainerCustomizer() {
			
			@Override
			public void customize(ConfigurableEmbeddedServletContainer container) {
				container.addErrorPages(new ErrorPage(HttpStatus.INTERNAL_SERVER_ERROR, "/500.jsp"));
				container.addErrorPages(new ErrorPage(HttpStatus.NOT_FOUND, "/404.jsp"));
				container.addErrorPages(new ErrorPage(HttpStatus.BAD_REQUEST, "/500.jsp"));
				container.addErrorPages(new ErrorPage(HttpStatus.FORBIDDEN, "/role.jsp"));
				container.addErrorPages(new ErrorPage(Exception.class, "/500.jsp"));
			}
		};
	}

}

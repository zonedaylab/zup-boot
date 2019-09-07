	
package cn.zup.rbac.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import cn.zup.framework.util.UrlRedirect;

@RestController
public class IndexController {
	
	/**
	 * 跳转首页面
	 * @author Andot
	 * @date 2018-2-7 14:18:49
	 * 
	 * */
	@RequestMapping("/")
	public void index(HttpServletResponse response) throws IOException{
		UrlRedirect.sendUrl("/index.jsp", response);
	}
}
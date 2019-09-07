package cn.zup.framework.util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

/**
 * 强制页面进行跳转，不会出现Iframe嵌套问题
 * @author Andot
 * @date 2018-1-23 09:22:34
 * 
 * */
public class UrlRedirect {
	
	/**
	 * 页面跳转
	 * @author Andot
	 * @param url 跳转的地址
	 * @param response HttpServletResponse
	 * @throws IOException 
	 * */
	public static void sendUrl(String url, HttpServletResponse response) throws IOException{
		response.setContentType("text/html; charset=UTF-8"); //转码
	    PrintWriter out = response.getWriter();
	    out.flush();
	    out.println("<script>");
	    out.println("parent.location.href='"+url+"';");
	    out.println("</script>");
	}
}

package cn.zup.bi.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/rest/bi/BIIndexController")
public class BIIndex {
	
	/**
	 * BI框架首页
	 * 入口
	 * 
	 * */
	@RequestMapping("")
	public ModelAndView index(HttpServletRequest request){
		return new ModelAndView("bi/biIndex");
	}
}

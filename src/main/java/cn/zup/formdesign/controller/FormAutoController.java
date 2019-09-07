package cn.zup.formdesign.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.zup.formdesign.entity.FormAuto;
import cn.zup.formdesign.entity.FormControl;

/**
 * 表单管理controller
 * @author 韩圣传
 * @date 2016-8-13
 */
@Controller
@RequestMapping("/rest/formdesign/designer")
public class FormAutoController {
	/**
	 * main首页面
	 * Author：韩圣传
	 * @param 
	 **/
	@RequestMapping("")
	public ModelAndView index(HttpServletRequest request) {
		
		ModelAndView mv=new ModelAndView();	
		
		String originalHtml = "";
		
		FormAuto f = new FormAuto();
		f.setId(1);
		f.setFieldNum(1);
		f.setOriginalHtml(originalHtml);
		
		mv.addObject("form",f);	
	    return new ModelAndView("formdesign/formDesigner");
	}
	
	/**
	 * 保存页面
	 * Author：韩圣传
	 * @param 
	 **/
	@RequestMapping("/save")
	@ResponseBody
	public String save(@RequestParam("parse_form") String html) {
		
		JSONObject jsonObj =  JSONObject.fromObject(html);
		String form = jsonObj.get("template").toString();
		
		String data = jsonObj.get("data").toString();
		JSONArray jsonarray = JSONArray.fromObject(data);  
        System.out.println(jsonarray);  
        List<FormControl> list = (List)JSONArray.toList(jsonarray);
        
        System.out.println(list.size());
		
		System.out.println(form);
		
		JSONObject json = new JSONObject();
		json.put("result","success");
		return json.toString();	
	}
	
}

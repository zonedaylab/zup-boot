package cn.zup.bi.controller;

import cn.zup.bi.entity.*;
import cn.zup.bi.service.*;
import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.converter.json.MappingJacksonValue;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.sql.*;
import java.util.*;

@Slf4j
@Controller
@RequestMapping("/Bi")
public class BIShowPageController {
	
	@Resource
	private BIPageService biPageService;
	@Resource
	private BIShowEngineService biShowEngineService;
	@Resource
	private BIDimService biDimService;
	@Resource
	private BIScreenService biScreenService;

	
	@RequestMapping("/{id}")
	public ModelAndView index(@PathVariable("id") Integer id) {
		ModelAndView mv = new ModelAndView();
		BI_Page biPage = new BI_Page();
		biPage.setMenu_Id(id);
		BI_Page bi_Page = biPageService.getBiPage(biPage);
		mv.setViewName(bi_Page.getPage_Url());
		mv.addObject("pageType", bi_Page.getPage_Type());
		mv.addObject("pageTitle", bi_Page.getPage_Title());
		mv.addObject("pageId", bi_Page.getBi_Page_Id());
		BI_Screen biScreen = new BI_Screen();
		biScreen.setPage_Id(bi_Page.getBi_Page_Id());
		List<BI_Screen> screenList = biScreenService.getBiScreenList(biScreen);
		JSONArray screenArr = JSONArray.fromObject(screenList);
		mv.addObject("screen", screenArr);
		return mv;
	}
	
	/**
	 * 关联菜单的地址
	 * @throws Exception 
	 * 
	 * */
	@RequestMapping("/MenuShow")
	public ModelAndView indexMenu(Integer menuid) throws Exception{
		BI_Page biPage = new BI_Page();
		biPage.setMenu_Id(menuid);
		BI_Page bi_Page = biPageService.getBiPage(biPage);
		if(bi_Page == null){
			throw new Exception("BI/MenuShow:请去BI--表单管理--菜单中进行表单与此菜单绑定！");
		}
		ModelAndView mv = new ModelAndView();
		mv.setViewName(bi_Page.getPage_Url());
		mv.addObject("pageType", bi_Page.getPage_Type());
		mv.addObject("pageTitle", bi_Page.getPage_Title());
		mv.addObject("pageId", bi_Page.getBi_Page_Id());
		BI_Screen biScreen = new BI_Screen();
		biScreen.setPage_Id(bi_Page.getBi_Page_Id());
		List<BI_Screen> screenList = biScreenService.getBiScreenList(biScreen);
		JSONArray screenArr = JSONArray.fromObject(screenList);
		mv.addObject("screen", screenArr);
		return mv;
	}
	/**
	 * pageid获取对应的页面进行展示，用于进行页面的预览工作。
	 * by liuxf
	 * @throws Exception
	 *
	 * */
	@RequestMapping("/BIPageShow")
	public ModelAndView BIPageShow(Integer pageId) throws Exception{
		BI_Page biPage = new BI_Page();
		biPage.setBi_Page_Id(pageId);
		BI_Page bi_Page = biPageService.getBiPage(biPage);
		if(bi_Page == null){
			throw new Exception("BI/BIPageShow:请传入对应的页面id！");
		}
		ModelAndView mv = new ModelAndView();
		mv.setViewName(bi_Page.getPage_Url());
		mv.addObject("pageType", bi_Page.getPage_Type());
		mv.addObject("pageTitle", bi_Page.getPage_Title());
		mv.addObject("pageId", bi_Page.getBi_Page_Id());
		BI_Screen biScreen = new BI_Screen();
		biScreen.setPage_Id(bi_Page.getBi_Page_Id());
		List<BI_Screen> screenList = biScreenService.getBiScreenList(biScreen);
		JSONArray screenArr = JSONArray.fromObject(screenList);
		mv.addObject("screen", screenArr);
		return mv;
	}
	/**
	 * 显示这个页面上的这一屏的报表数据
	 * @author 谢炎
	 * 
	 * */
	@RequestMapping("/getReportData")
	@ResponseBody
	public Object getReportData(@RequestBody V_ReportData vreportData, String callback) throws Exception {

		List<Map<String, Object>> list  =biShowEngineService.getBIPageService(vreportData);

		JSONObject json = new JSONObject();
		json.put("msg", "success");
		json.put("data", list);
		MappingJacksonValue mappingJacksonValue = new MappingJacksonValue(json);
		mappingJacksonValue.setJsonpFunction(callback);
		return mappingJacksonValue;
	}

	/**
	 * 获取报表的筛选字段
	 * @author 谢炎
	 * */

	@RequestMapping("/getDimData")
	@ResponseBody
	public JSONObject getDimData(Integer reportId) throws Exception, ClassNotFoundException{

		JSONObject json = new JSONObject();
		Map<String, Object> mapResult = biShowEngineService.showDimField(reportId);
		json.put("msg", "success");
		json.put("data", mapResult);
		return json;
	}
	
	/**
	 * 获取过滤条件的数据
	 * @throws ClassNotFoundException 
	 * @throws SQLException 
	 * 
	 * */
	@Autowired
	JdbcTemplate jdbcTemplate_bidata;

	@RequestMapping(value="/getFilterValue", method=RequestMethod.GET)
	@ResponseBody
	public JSONObject getFilterValue(String filterName, Integer areaId) throws  SQLException{

		List<BI_DIM> dimList = biDimService.getDimFilter(filterName);
		Map<String, Object> map = new HashMap<String, Object>();

		String sql = "";
        System.err.println("filterName:"+filterName);

		//此处需要进一步理清，传递过来的filternmae 如果不包含_
		if(!filterName.contains("_")){
			String id = filterName.substring(0, filterName.lastIndexOf("_"));
			if(dimList.size()>0) {//判断是否关联维度表 liuxf
				sql = "SELECT " + id + "," + filterName + " from " + dimList.get(0).getBiz_Table_Name() + " GROUP BY " + id + "," + filterName;
				 jdbcTemplate_bidata.query(sql, new ResultSetExtractor<List>() {
					@Override
					public List extractData(ResultSet rs)
							throws SQLException, DataAccessException {
						List result = new ArrayList();
						while(rs.next()) {
							map.put(rs.getString(filterName), rs.getInt(id));
							result.add(map);
						}
						return result;
					}
				 });
			}
		}
		System.err.println("===>Filter SQL:"+sql);
		JSONObject json = new JSONObject();
		json.put("data", map);
		return json;
	}
}

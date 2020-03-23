package cn.zup.bi.controller;

import cn.zup.bi.entity.*;
import cn.zup.bi.service.*;
import cn.zup.bi.utils.DatabaseParamBuilder;
import cn.zup.bi.utils.BIConnection;
import cn.zup.framework.json.JsonDateValueProcessor;
import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import org.springframework.http.converter.json.MappingJacksonValue;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.sql.*;
import java.util.Date;
import java.util.*;

@Slf4j
@Controller
@RequestMapping("/Bi")
public class BIShowPageController {
	
	@Resource
	private BIPageService biPageService;
	@Resource
	private BIPageBlockService biPageBlockService;
	@Resource
	private BIShowEngineService biShowEngineService;
	@Resource
	private BIDimService biDimService;
	@Resource
	private TopicFieldService biTopicFieldService;
	@Resource
	private TopicService topicService;
	@Resource
	private ReportService biReportService;
	@Resource
	private BIScreenService biScreenService;
	@Resource
	private BIDatasourceService biDatasourceService;
	
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
	 * 显示这个页面上的这一屏的报表数据
	 * @author 谢炎
	 * 
	 * */
	@RequestMapping("/getReportData")
	@ResponseBody
	public Object getReportData(@RequestBody V_ReportData vreportData, String callback) throws Exception {

		List<Map<String, Object>> list  =biShowEngineService.getReport(vreportData);

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
	public JSONObject getDimData(Integer reportId) throws SQLException, ClassNotFoundException{
		List<String> sqlList = biShowEngineService.showDimField(reportId);
		JSONObject json = new JSONObject();
		Class.forName(BIConnection.CLASSNAME);
		Connection conn = DriverManager.getConnection(BIConnection.URL, BIConnection.USERNAME, BIConnection.PASSWORD);
		PreparedStatement ps = null;
		ResultSet rs = null;
		Map<String, Object> mapResult = new HashMap<String, Object>();
		for (String sql : sqlList) {
			String[] sqls = sql.split("&");
			ps = conn.prepareStatement(sqls[0]);
			rs = ps.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData();
			int count = rsmd.getColumnCount();
			List<Map<String, Object>> listMap = new ArrayList<Map<String, Object>>();
			while (rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				for (int i = 1; i <= count; i++) {
					map.put(rsmd.getColumnLabel(i).toLowerCase(), rs.getObject(i));
				}
				listMap.add(map);
			}
			mapResult.put(sqls[1], listMap);
		}
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
	@RequestMapping(value="/getFilterValue", method=RequestMethod.GET)
	@ResponseBody
	public JSONObject getFilterValue(String filterName, Integer areaId) throws ClassNotFoundException, SQLException{
		List<BI_DIM> dimList = biDimService.getDimFilter(filterName);
		Class.forName(BIConnection.CLASSNAME);
		Connection conn = DriverManager.getConnection(BIConnection.URL, BIConnection.USERNAME, BIConnection.PASSWORD);
		PreparedStatement ps = null;
		ResultSet rs = null;
		Map<String, Object> map = new HashMap<String, Object>();
		String sql = "";
		System.err.println(filterName.indexOf("nm") > -1 || filterName.indexOf("name") > -1);

        System.err.println("filterName:"+filterName);

		if(filterName.equals("province") || filterName.equals("city")  || filterName.equals("county")){  //字典表插叙条件
			String where = "";
			int len = areaId.toString().length();
			if(areaId == 0){
				len = 0;
			} else {
				where = " AND LEFT(vd.AREA_NUM, "+len+") = "+areaId;
			}
			sql = "SELECT LEFT(vd.AREA_NUM, "+(len+2)+") AREA_ID, vd."+filterName+" from v_dicarea vd WHERE 1=1 "+where+" GROUP BY vd."+filterName;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				map.put(rs.getString(filterName), rs.getInt("AREA_ID"));
			}
		}else if(filterName.equals("year") ){  //调查年份
			sql = "SELECT "+filterName+" from "+dimList.get(0).getBiz_Table_Name()+" GROUP BY "+filterName;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				map.put(filterName+"_"+rs.getInt(filterName), rs.getInt(filterName));
			}
		}else{

			//此处需要进一步理清，传递过来的filternmae 如果不包含_
			if(!filterName.contains("_")){
				String id = filterName.substring(0, filterName.lastIndexOf("_"));
				if(dimList.size()>0) {//判断是否关联维度表 liuxf
					sql = "SELECT " + id + "," + filterName + " from " + dimList.get(0).getBiz_Table_Name() + " GROUP BY " + id + "," + filterName;
					ps = conn.prepareStatement(sql);
					rs = ps.executeQuery();
					while (rs.next()) {
						map.put(rs.getString(filterName), rs.getInt(id));
					}
				}
			}
		}
		//System.err.println("===>Filter SQL:"+sql);
		JSONObject json = new JSONObject();
		json.put("data", map);
		return json;
	}
}

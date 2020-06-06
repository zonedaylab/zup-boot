package cn.zup.bi.controller;

import cn.zup.bi.entity.BI_REPORT;
import cn.zup.bi.entity.BI_REPORT_FIELD;
import cn.zup.bi.service.ReportFieldService;
import cn.zup.bi.service.ReportService;
import cn.zup.framework.common.vo.CommonResult;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author gavin
 */
@Controller
@RequestMapping("/rest/bi/biReportController")
public class BIReportController {
	@Resource
	private ReportService reportService;

	@Resource
	private ReportFieldService reportFieldService;

	/**
	 * 返回首页
	 * @author 谢炎
	 * */
	@RequestMapping("")
	public ModelAndView index(HttpServletRequest request){
		//需要优化pageId为空
				String pageId = request.getParameter("pageId");
				ModelAndView mv = new ModelAndView("bi/biReportManage");
				mv.addObject("pageId", pageId);
				return mv;
	    //return new ModelAndView("bi/biReportManage");
	}
	
	/**
	 * 
	 * 获取主题字段数据
	 * @author 谢炎
	 * */
//	@RequestMapping("/getFieldData")
//	@ResponseBody
//	public String getFieldData(Integer topic_Id){
//		List<BI_TOPIC_FIELD> list = topicFieldService.getTopicFields(topic_Id);
//
//
//		List<BI_TOPIC_FIELD_VIEW> viewList = new ArrayList<BI_TOPIC_FIELD_VIEW>();
//		for (int i = 0; i < list.size(); i++) {
//			BI_TOPIC_FIELD_VIEW view = new BI_TOPIC_FIELD_VIEW();
//			view.setField(list.get(i));
//			viewList.add(view);
//		}
//		JSONObject json = new JSONObject();
//		json.put("data", viewList);
//		return json.toString();
//	}
	
	/**
	 * 保存报表
	 * @author 谢炎
	 * */
	@RequestMapping("/saveReport")
	@ResponseBody
	public String saveReport(BI_REPORT report){
		report.setCreate_Date(new Date());
		int r = reportService.saveReport(report);
		JSONObject json = new JSONObject();
		if(r!=0) {
			json.put("data", "success");
		}else {
			json.put("data", "error");
		}
		return json.toString();
	}
	
	/**
	 * 更新报表
	 * @author 谢炎
	 * */
	@RequestMapping("/updateReport")
	@ResponseBody
	public String updateReport(BI_REPORT report){

		int r = reportService.saveReport(report);
		JSONObject json = new JSONObject();
		if(r!=0) {
			json.put("data", "success");
		}else {
			json.put("data", "error");
		}
		return json.toString();
	}
	
	/**
	 * 删除报表
	 * @author 谢炎
	 * */
	@RequestMapping("/deleteReport")
	@ResponseBody
	public String deleteReport(@RequestParam("report_Ids[]")Integer[] report_Id){
		JSONObject json = new JSONObject();
		String arrs = "";
		int a = 0;
		for (int i = 0; i < report_Id.length; i++) {
			int r = reportService.deleteReport(report_Id[i]);
			if(r==1 && a == 0){
				json.put("data", "success");
			}else{
				arrs += report_Id[i] + ", ";
				json.put("data", "error");
				json.put("info", arrs);
				a++;
			}
		}
		return json.toString();
	}
	
	/**
	 * 获取报表信息
	 * @author 谢炎
	 * */
	@RequestMapping("/getReportInfo")
	@ResponseBody
	public String getReportInfo(BI_REPORT report){
		BI_REPORT biReport = reportService.getReportInfo(report.getReport_Id());
		JSONObject json = new JSONObject();
		json.put("data", biReport);
		return json.toString();
	}
	
	/**
	 * 获取报表列表
	 * @author 谢炎
	 * */
	@RequestMapping("/getReportList")
	@ResponseBody
	public CommonResult getReportList(BI_REPORT report, int rows, int page){
		List<BI_REPORT> list = reportService.getReportPagingList(report);
		return CommonResult.successPage(list, page, rows);
	}
	
	/**
	 * 根据页面id和屏幕索引查询报表列表
	 * @author 谢炎
	 * */
	@RequestMapping("/getReportListByPageId")
	@ResponseBody
	public String getReportListByPageId(Integer pageId, Integer screenIndex){
		List<BI_REPORT> list = reportService.getReportListByPageId(pageId, screenIndex);
		JSONObject json = new JSONObject();
		json.put("data", list);
		json.put("msg", "success");
		return json.toString();
	}


	/**
	 * 获取报表列表
	 * @author 段延玉  郑晖改
	 * */
	@RequestMapping("/getTableName")
	@ResponseBody
	public String getTableName(BI_REPORT report){
		List<BI_REPORT> biReports = reportService.getReportPagingList(report);

		Map<String,List<BI_REPORT_FIELD>> maps = new HashMap<>();

		Map<String,Map<String,String>> mapMap = new HashMap<>();

		biReports.stream().forEach(br -> {

			BI_REPORT_FIELD reportField = new BI_REPORT_FIELD();
			reportField.setReport_Id(br.getReport_Id());

			List<BI_REPORT_FIELD> biReportFields = reportFieldService.getReportFieldList(reportField, 0, 0);
			Map<String,String> m = new HashMap<>();

			biReportFields.stream().forEach(brf->{
				m.put(brf.getField_Name(),brf.getField_Name());
			});

			//用于前台过滤比较
			mapMap.put(br.getReport_Id()+"",m);

			//每一个key都是Report_Id
			maps.put(br.getReport_Id()+"",biReportFields);

		});


		JSONObject json = new JSONObject();
		json.put("biReportLists", biReports);
		json.put("biReportFieldMaps", maps);
		json.put("mapMap", mapMap);

		return json.toString();
	}

}

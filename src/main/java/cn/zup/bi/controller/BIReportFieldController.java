package cn.zup.bi.controller;

import cn.zup.bi.entity.BI_DIM;
import cn.zup.bi.entity.BI_REPORT_FIELD;
import cn.zup.bi.service.BIDimService;
import cn.zup.bi.service.ReportFieldService;
import cn.zup.bi.service.ReportService;
//import cn.zup.bi.service.TopicFieldService;
import cn.zup.bi.service.settings.MgeidsConfig;
import cn.zup.framework.common.vo.CommonResult;
import cn.zup.rbac.service.ConfigurationService;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import cn.zup.rbac.entity.Config;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/rest/bi/biReportFieldController")
public class BIReportFieldController {
//	@Resource
//	private TopicFieldService topicFieldService;
	@Resource
	private ReportService reportService;
	@Resource
	private ReportFieldService reportFieldService;
	@Resource
	private ConfigurationService configurationService;
	@Resource
	private BIDimService biDimService;

	/**
	 * 返回首页
	 * @author 谢炎
	 * */
	@RequestMapping("")
	public ModelAndView index(HttpServletRequest request){
		return new ModelAndView("bi/biReportFieldManage");
	}
	
	/**
	 * 保存报表字段
	 * @author 谢炎
	 * */
	@RequestMapping("/saveReportField")
	@ResponseBody
	public String saveReportField(BI_REPORT_FIELD reportField){
		int r = reportFieldService.saveReportField(reportField);
		JSONObject json = new JSONObject();
		if(r==1)
			json.put("data", "success");
		else
			json.put("data", "error");
		return json.toString();
	}

	/**
	 * 获取数据类型
	 *
	 * */
	@RequestMapping("/getDataType")
	@ResponseBody
	public String getDataType() {
		Config config = new  Config();
		config.setConfigid(MgeidsConfig.DataType.getValue());
		List<Config> fieldType = configurationService.getConfigInfo(config);
		JSONObject json = new JSONObject();
		json.put("data", fieldType);
		return json.toString();
	}
	/**
	 * 获取字段类型
	 *
	 * */
	@RequestMapping("/getFieldType")
	@ResponseBody
	public String getFieldType(){
		Config config = new  Config();
		config.setConfigid(MgeidsConfig.FieldType.getValue());
		List<Config> fieldType = configurationService.getConfigInfo(config);
		JSONObject json = new JSONObject();
		json.put("data", fieldType);
		return json.toString();
	}

	/**
	 * 获取维表名称
	 * @author antsdot
	 * @date 2016-10-10 10:47:30
	 *
	 * */
	@RequestMapping("/getBiDimName")
	@ResponseBody
	public String getBiDimName(){
		JSONObject json = new JSONObject();
		List<BI_DIM> list = biDimService.getBiDimName();
		json.put("data", list);
		return json.toString();
	}

	/**
	 * 更新报表字段
	 * @author 谢炎
	 * */
	@RequestMapping("/updateReportField")
	@ResponseBody
	public String updateReportField(BI_REPORT_FIELD reportField){
		int r = reportFieldService.saveReportField(reportField);
		JSONObject json = new JSONObject();
		if(r==1)
			json.put("data", "success");
		else
			json.put("data", "error");
		return json.toString();
	}
	
	/**
	 * 删除报表字段
	 * @author 谢炎
	 * */
	@RequestMapping("/deleteReportField")
	@ResponseBody
	public String deleteReportField(@RequestParam("report_Field_Ids[]") Integer[] ids){
		for (int i = 0; i < ids.length; i++) {
			reportFieldService.deleteRpoetField(ids[i]);
		}
		JSONObject json = new JSONObject();
		json.put("data", "success");
		return json.toString();
	}
	
	/**
	 * 获取报表字段
	 * @author 谢炎
	 * */
	@RequestMapping("/getReportField")
	@ResponseBody
	public String getReportField(BI_REPORT_FIELD reportField){
		BI_REPORT_FIELD result = reportFieldService.getReportFieldInfo(reportField);
		JSONObject json = new JSONObject();
		json.put("data", result);
		return json.toString();
	}
	
	/**
	 * 获取报表字段分页
	 * @author 谢炎
	 * */
	@RequestMapping("/getReportFieldList")
	@ResponseBody
	public CommonResult getReportFieldList(BI_REPORT_FIELD reportField, int rows, int page){
		List<BI_REPORT_FIELD> list = reportFieldService.getReportFieldList(reportField, rows, page);
		return CommonResult.successPage(list, page, rows);
	}
	
	/**
	 * 获取主题字段列表
	 * @author 谢炎
	 * */
//	@RequestMapping("/getTopicFieldList")
//	@ResponseBody
//	public String getTopicFieldList(int reportId){
//		BI_REPORT report = new BI_REPORT();
//		report.setReport_Id(reportId);
//		BI_REPORT biReport = reportService.getReportInfo(reportId);
//		List<BI_TOPIC_FIELD> list = topicFieldService.getTopicFields(biReport.getTopic_Id());
//		JSONObject json = new JSONObject();
//		json.put("data", list);
//		return json.toString();
//	}
}

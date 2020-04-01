package cn.zup.bi.controller;

import cn.zup.bi.entity.*;
import cn.zup.bi.service.BIDimService;
import cn.zup.bi.service.TopicFieldService;
import cn.zup.bi.service.TopicService;
import cn.zup.bi.service.settings.MgeidsConfig;
import cn.zup.bi.utils.BIConnection;
import cn.zup.framework.common.vo.CommonResult;
import cn.zup.rbac.entity.Config;
import cn.zup.rbac.service.ConfigurationService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@Controller
@RequestMapping("/rest/bi/BITopicFiledController")
public class BITopicFieldController {
	
	@Resource
	private TopicFieldService topicFieldService;
	@Resource
	private BIDimService biDimService;
	@Resource
	private TopicService topicService;
	@Resource
	private ConfigurationService configurationService;
	
	/** 
	* 主题字段设置页面
	* @author 谢炎
	* @date 2016-10-5 11:35:44
	*/
	@RequestMapping("")
	public ModelAndView index(HttpServletRequest request){
		String topicId = request.getParameter("topicId");
		ModelAndView mv = new ModelAndView("bi/biTopicFieldManage");
		mv.addObject("topicId", topicId);
		return mv;
	}
	
	/** 
	* 主题列表获取
	* @author 谢炎
	* @date 2016-10-5 11:36:11
	*/
	@RequestMapping("/girdTopicFieldList")
	@ResponseBody 
	public CommonResult getGrid(Integer topicId,Integer page,Integer rows,HttpServletRequest request) {
		BI_TOPIC_FIELD topicField = new BI_TOPIC_FIELD();
		topicField.setTopic_Id(topicId);
		topicField.setField_Type(MgeidsConfig.FieldType.getValue());
		List<BI_TOPIC_FIELD> pagetopicField = topicFieldService.getTopicFieldPagingList(topicField);
		return CommonResult.successPage(pagetopicField, page, rows);
	}
	
	/** 
	* 主题数据编辑
	* @author 谢炎
	* @date 2016-10-5 11:36:11
	*/
	@RequestMapping("/editTopicFieldData")
	@ResponseBody
	public String getTopicData(BI_TOPIC_FIELD topicField, HttpServletRequest request) {
		JSONObject json = new JSONObject(); 
		int flag = topicFieldService.updateTopicData(topicField);
		if(flag != 0){
			json.put("data", "success");
		}else{
			json.put("data", "error");
		}
		return json.toString();
	}
	
	/** 
	* 主题数据添加
	* @author 谢炎
	* @date 2016-10-5 11:36:11
	*/
	@RequestMapping("/addTopicFieldData")
	@ResponseBody
	public String addTopicData(BI_TOPIC_FIELD topicField, HttpServletRequest request) {
		JSONObject json = new JSONObject(); 
		int flag = topicFieldService.addTopicData(topicField);
		if(flag != 0){
			json.put("data", "success");
		}else{
			json.put("data", "error");
		}
		return json.toString();
	}
	
	/** 
	* 主题数据删除
	* @author 谢炎
	* @date 2016-10-5 16:33:54
	*/
	@RequestMapping("/deleteTopicFieldData")
	@ResponseBody
	public String deleteTopicData(@RequestParam("titleIds[]") String[] titleIds, HttpServletRequest request) {
		JSONObject json = new JSONObject(); 
		String errorId = "";
		for (int i = 0; i < titleIds.length; i++) {
			try{
				topicFieldService.deleteTopicData(Integer.parseInt(titleIds[i]));
				errorId = "success";
			}catch(Exception e){
				if(i == titleIds.length-1){
					errorId += titleIds[i];
				}else{
					errorId += titleIds[i]+",";
				}
			}
		}
		json.put("data", errorId);
		return json.toString();
	}
	
	/** 
	* 主题列表数据获取 编辑框填充的数据
	* @author 谢炎
	* @date 2016-10-5 11:36:11
	*/
	@RequestMapping("/getTopicFieldData")
	@ResponseBody
	public String editTopicData(Integer topic_Id, Integer field_Id, HttpServletRequest request) {
		BI_TOPIC_FIELD topicFieldData = topicFieldService.getTopicFieldData(topic_Id, field_Id);
		JSONObject json = new JSONObject(); 
		JSONArray jsonarr = JSONArray.fromObject(topicFieldData);
		json.put("data", jsonarr);
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
	 * 获取数据库表的所有字段
	 * @author 谢炎
	 * @throws SQLException 
	 * @date 2016-10-12 10:52:00
	 * 
	 * */
	@RequestMapping("/getDBField")
	@ResponseBody
	public String getDBField(Integer dimId) throws SQLException{
		List<BI_DIM_ATTRIBUTE> list = biDimService.getDimInInfo(dimId);
		JSONObject json = new JSONObject();
		json.put("data", list);
		return json.toString();
	}
	
	/**
	 * 获取数据库表的所有字段(聚合字段)
	 * @author 谢炎
	 * @throws SQLException 
	 * @date 2016-10-12 10:52:00
	 * 
	 * */
	@RequestMapping("/getAggregateField")
	@ResponseBody
	public String getAggreField(Integer topic_Id) throws SQLException{
		JSONObject json = new JSONObject();
		Connection conn = BIConnection.OpenConn();
		BI_TOPIC topic = topicService.getTopicData(topic_Id);
		List<BI_DIM_FIELD> list = biDimService.getColumnNameList(conn, topic.getBiz_Table_Name());
		json.put("data", list);
		BIConnection.CloseConn(conn);
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
	 * 获取是否字段
	 * 
	 * */
	@RequestMapping("/getShiFou")
	@ResponseBody
	public String getShiFou(){
		Config config = new  Config();
		config.setConfigid(MgeidsConfig.ShiFou.getValue());
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
}

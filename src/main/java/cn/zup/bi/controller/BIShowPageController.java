package cn.zup.bi.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.http.converter.json.MappingJacksonValue;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.zup.bi.entity.BIDimData;
import cn.zup.bi.entity.BIShowField;
import cn.zup.bi.entity.BI_Block_Info;
import cn.zup.bi.entity.BI_Page;
import cn.zup.bi.entity.BI_REPORT;
import cn.zup.bi.entity.BI_Screen;
import cn.zup.bi.entity.V_ReportData;
import cn.zup.bi.service.BIDimService;
import cn.zup.bi.service.BIPageBlockService;
import cn.zup.bi.service.BIPageService;
import cn.zup.bi.service.BIScreenService;
import cn.zup.bi.service.BIShowEngineService;
import cn.zup.bi.service.ReportFieldService;
import cn.zup.bi.service.ReportService;
import cn.zup.bi.service.TopicFieldService;
import cn.zup.bi.utils.PropertiesUtil;
import cn.zup.framework.json.JsonDateValueProcessor;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

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
	private ReportFieldService biReportFieldService;
	@Resource
	private BIDimService biDimService;
	@Resource
	private TopicFieldService biTopicFieldService;
	@Resource
	private ReportService biReportService;
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
			throw new Exception("请去BI页面管理中绑定此菜单");
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
	public Object getReportData(@RequestBody V_ReportData vreportData, String callback) throws SQLException, ClassNotFoundException{
		//获取一个页面、一个屏幕上的所有div
		if(vreportData.getBlock_Id() == 0){
			vreportData.setBlock_Id(null);
		}
		List<BI_Block_Info> blockList = biPageBlockService.getPageBlockByPageId(vreportData.getBi_Page_Id(), vreportData.getScreen_Index(), vreportData.getBlock_Id());
		JSONObject json = new JSONObject();
		Class.forName(PropertiesUtil.CLASSNAME);
		Connection conn = DriverManager.getConnection(PropertiesUtil.URL, PropertiesUtil.USERNAME, PropertiesUtil.PASSWORD);
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		for (BI_Block_Info bi_Block_Info : blockList) {
			Map<String, Object> resultMap = new HashMap<String, Object>();
			//获取div上绑定的报表的数据
			String sql = biShowEngineService.showReport(bi_Block_Info.getReport_Id(), vreportData.getKey(), vreportData.getValue());
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData();
			int count = rsmd.getColumnCount();
			List<Map<String, Object>> listMap = new ArrayList<Map<String, Object>>();
			//从数据库中查询出来放入map中
			while (rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				for (int i = 1; i <= count; i++) {
					if(vreportData.getBlock_Type() == 1 
							&& (rsmd.getColumnLabel(i).toLowerCase().equals("province") 
							|| rsmd.getColumnLabel(i).toLowerCase().equals("city") 
							|| rsmd.getColumnLabel(i).toLowerCase().equals("county")))
						map.put(rsmd.getColumnLabel(i).toLowerCase(), rs.getObject(i)+"-"+rs.getInt("areaId"));
					else
						map.put(rsmd.getColumnLabel(i).toLowerCase(), rs.getObject(i));
				}
				listMap.add(map);
			}
			
			//获取指标
			List<String> topicList = new ArrayList<String>();
			List<String> topicNameList = new ArrayList<String>();
			List<String> topicUnitList = new ArrayList<String>();
			List<BIShowField> topicFieldList = biTopicFieldService.getTopicFieldList(bi_Block_Info.getReport_Id());
			for (BIShowField biShowField : topicFieldList) {
				topicList.add(biShowField.getField_Caption().toLowerCase());
				topicNameList.add(biShowField.getField_Title());
				topicUnitList.add(biShowField.getField_Unit());
			}
			
			List<List<String>> tableHeaderList = new ArrayList<List<String>>();
			List<String> lieDimFields = new ArrayList<String>();
			List<String> hangDimFields = new ArrayList<String>();
			
			//获取维度的字段
			List<BIShowField> dimFieldList = biDimService.getDimFieldList(bi_Block_Info.getReport_Id(), vreportData.getKey(), vreportData.getValue());
			List<Map<String, Object>> dimTopicTableHeader = new ArrayList<Map<String, Object>>();
			for (int i = 0; i < dimFieldList.size(); i++) {
				BIShowField dimField = dimFieldList.get(i);
				Map<String, Object> dimTopicTableHeaderMap = new HashMap<String, Object>();
				if(dimField.getField_Location() == 1){
					List<String> dimRowList = new ArrayList<String>();
					for (int k = 0; k < listMap.size(); k++) {
						if(dimField.getDrill_Type() != 3) {
							if(!dimRowList.contains(listMap.get(k).get(dimField.getText_Field().toLowerCase()).toString()))
								dimRowList.add(listMap.get(k).get(dimField.getText_Field().toLowerCase()).toString());
							if(!hangDimFields.contains(dimField.getText_Field().toLowerCase()))
								hangDimFields.add(dimField.getText_Field().toLowerCase());
						} else {
							if(vreportData.getKey().size() > 0) {
								int lc = (vreportData.getValue()+"").length()/2-1;
								if(listMap.get(k).get(dimField.getDrill_Info().split("-")[lc].toLowerCase()) != null){
									if(!dimRowList.contains(listMap.get(k).get(dimField.getDrill_Info().split("-")[lc].toLowerCase()).toString())) {
										dimRowList.add(listMap.get(k).get(dimField.getDrill_Info().split("-")[lc].toLowerCase()).toString());
									}
								}
								if(!hangDimFields.contains(dimField.getDrill_Info().split("-")[lc].toLowerCase()))
									hangDimFields.add(dimField.getDrill_Info().split("-")[lc].toLowerCase());
							} else {
								if(listMap.get(k).get(dimField.getDrill_Info().split("-")[0].toLowerCase()) != null){
									if(!dimRowList.contains(listMap.get(k).get(dimField.getDrill_Info().split("-")[0].toLowerCase()).toString())) {
										dimRowList.add(listMap.get(k).get(dimField.getDrill_Info().split("-")[0].toLowerCase()).toString());
									}
								}
								if(!hangDimFields.contains(dimField.getDrill_Info().split("-")[0].toLowerCase()))
									hangDimFields.add(dimField.getDrill_Info().split("-")[0].toLowerCase());
							}
						}
						tableHeaderList.add(dimRowList);
					}
					dimTopicTableHeaderMap.put(dimField.getText_Field().toLowerCase(), dimFieldList.get(i).getDim_Order());
					dimTopicTableHeader.add(dimTopicTableHeaderMap);
				}else if(dimFieldList.get(i).getField_Location() == 2){
					if(dimField.getDrill_Type() != 3) {
						if(!lieDimFields.contains(dimField.getText_Field().toLowerCase()))
							lieDimFields.add(dimField.getText_Field().toLowerCase());
					} else {
						if(vreportData.getKey().size() > 0) {
							int lc = (vreportData.getValue()+"").length()/2-1;
							if(!lieDimFields.contains(dimField.getDrill_Info().split("-")[lc].toLowerCase()))
								lieDimFields.add(dimField.getDrill_Info().split("-")[lc].toLowerCase());
						} else {
							if(!lieDimFields.contains(dimField.getDrill_Info().split("-")[0].toLowerCase()))
								lieDimFields.add(dimField.getDrill_Info().split("-")[0].toLowerCase());
						}
					}
				}
			}
			
			//表格数据清洗
			if(vreportData.getBlock_Type() == 1){
				//列维 行维    数据格式  <"2017-集体-云南省", "494">
				Map<String,String> mapIndicatorData = new HashMap<String,String>();
				for (Map<String, Object> map : listMap) {
					String xkey = "";
					String xvalue = "";
					for (int j = 0; j < map.size(); j++) {
						String rowK = "";
						String celK = "";
						String valK = "";
						for (int i = 0; i < lieDimFields.size(); i++) {   //判断是否为列
							if(map.containsKey(lieDimFields.get(i)))
								celK += map.get(lieDimFields.get(i))+",";
						}
						for (int i = 0; i < hangDimFields.size(); i++) { //判断是否为行维
							if(map.containsKey(hangDimFields.get(i)))
								rowK += map.get(hangDimFields.get(i))+",";
						}
						for (int i = 0; i < topicList.size(); i++) { //判断是否为指标
							if(map.containsKey(topicList.get(i)))
								valK += map.get(topicList.get(i))+",";
						}
	
						xkey = celK + "" + rowK;
						xvalue = valK;
						if(xkey.lastIndexOf(",") > -1){
							xkey = xkey.substring(0, xkey.length()-1);
						}
						if(xvalue.lastIndexOf(",") > -1){
							xvalue = xvalue.substring(0, xvalue.length()-1);
						}
						mapIndicatorData.put(xkey, xvalue);  // 数据格式  <"2017-集体-云南省", "494">
					}
				}
				//创建列维度集合
				List<BIDimData> BIColDimDatas=new  ArrayList<BIDimData>();
				for (int i = 0; i < lieDimFields.size(); i++) {					
					BIDimData data=new BIDimData();
					data.setListData(new ArrayList<String>());
					BIColDimDatas.add(data);				
				}
				for (Map<String, Object> map : listMap) {
					for (int i = 0; i < lieDimFields.size(); i++) {						
						List<String>listData=BIColDimDatas.get(i).getListData();
						String value=map.get(lieDimFields.get(i)).toString();
						if(!listData.contains(value))
							listData.add(value);					
					}
				}
				//创建行维度集合
				List<BIDimData> BIRowDimDatas=new  ArrayList<BIDimData>();
				for (int i = 0; i < hangDimFields.size(); i++) {					
					BIDimData data=new BIDimData();
					data.setListData(new ArrayList<String>());
					BIRowDimDatas.add(data);				
				}			
				for (Map<String, Object> map : listMap) {
					for (int i = 0; i < hangDimFields.size(); i++) {						
						List<String>listData=BIRowDimDatas.get(i).getListData();
						String value=map.get(hangDimFields.get(i)).toString();
						if(!listData.contains(value))
							listData.add(value);
					}
				}
				
				//---------------------创建表格-----------------------
				//1---创建表头  上面创建
				List<List<String>> listRowCells = new ArrayList<List<String>>();
				int allLoopCount  = 1;  //总循环次数
				for (int i = 0; i < BIRowDimDatas.size(); i++) {
					allLoopCount *= BIRowDimDatas.get(i).getListData().size();
				}
				for (int i = 0; i < BIRowDimDatas.size(); i++) {
					List<String> listRowCell = new ArrayList<String>();
					int loopCount = 0; //重复个数
					for (int j = 0; j < allLoopCount; j++) {
						if(loopCount < BIRowDimDatas.get(i).getListData().size()) {
							listRowCell.add(BIRowDimDatas.get(i).getListData().get(loopCount));
							loopCount++;
						}else
							loopCount = 0;
						
					}
					if(i != BIRowDimDatas.size()-1)
						Collections.sort(listRowCell);  
					listRowCells.add(listRowCell);
				}
				
				//2---创建数据行
				String colsNames="";
				List<String> listRows = new ArrayList<String>();
				GeneReportData(0, BIColDimDatas , colsNames, BIColDimDatas.size(), listRows);
				List<String> listCells =  new ArrayList<String>();  //循环遍历行
				String rowsNames="";
				GeneReportCellsData(0, BIRowDimDatas , rowsNames, BIRowDimDatas.size(), listCells);
				
				List<List<String>> listRowData=new ArrayList<List<String>>();
				for(int i=0;i<listRows.size();i++) {	
					String rowValue=listRows.get(i);
					for (int j = 0; j < listCells.size(); j++) {
						String keyName=listRows.get(i)+",";
						keyName += listCells.get(j);
						rowValue+=",";
						if(mapIndicatorData.containsKey(keyName))
							rowValue+=mapIndicatorData.get(keyName);
					}

					List<String> rowValueList = Arrays.asList(rowValue.split(","));
					listRowData.add(rowValueList);	
				}
				resultMap.put("tableData", listRowData);
				resultMap.put("dimFieldHeader", listRowCells);
			}else{
				resultMap.put("data", listMap);
			}
			
			//获取报表信息
			BI_REPORT reportInfo = biReportService.getReportInfo(bi_Block_Info.getReport_Id());
			JsonConfig jsonConfig = new JsonConfig();
			jsonConfig.registerJsonValueProcessor(Date.class,new JsonDateValueProcessor("yyyy-MM-dd HH:mm:ss"));
			JSONObject jsonArray = JSONObject.fromObject(reportInfo, jsonConfig);
			resultMap.put("reportInfo", jsonArray);
			
			resultMap.put("dimHeader", hangDimFields);
			resultMap.put("topicField", topicList);
			lieDimFields.removeAll(hangDimFields);
			resultMap.put("dimField", lieDimFields);
			resultMap.put("topicFieldName", topicNameList);
			resultMap.put("unit", topicUnitList);			
			resultMap.put("flList", dimTopicTableHeader);
			resultMap.put("blockInfo", bi_Block_Info);
			
			list.add(resultMap);
		}
		json.put("msg", "success");
		json.put("data", list);
		
		MappingJacksonValue mappingJacksonValue = new MappingJacksonValue(json);
		mappingJacksonValue.setJsonpFunction(callback);
		return mappingJacksonValue;
	}
	
	/*
	 * dimCol 列维序号
	 * BIColDimDatas 列维度数据
	 * colsNames 一行的列维字符串‘
	 * colSize  列维的数量
	 * listRows 生成的数据行数
	 */
	private void GeneReportData(int dimCol, List<BIDimData> BIColDimDatas , String colsNames, int colSize, List<String> listRows) {
		List<String> listData = BIColDimDatas.get(dimCol).getListData();
		if(dimCol == colSize-1){	
			for(int j=0;j<listData.size();j++) {
				String mycolNames = "";
				if(colsNames == "")
					mycolNames = listData.get(j);
				else
					mycolNames = colsNames+","+listData.get(j);
				//指标数据
				listRows.add(mycolNames);				
			}
		} else{
			dimCol++;
			for(int j=0;j<listData.size();j++) {				
				String mycolNames="";
				if(colsNames == "")
					mycolNames = listData.get(j);
				else
					mycolNames = colsNames+","+listData.get(j);
				//指标数据
				GeneReportData(dimCol, BIColDimDatas, mycolNames, colSize, listRows);
			}
		}
	}
	
	private void GeneReportCellsData(int dimCol, List<BIDimData> BIColDimDatas , String colsNames, int colSize, List<String> listCells) {
		List<String> listData = BIColDimDatas.get(dimCol).getListData();
		if(dimCol == colSize-1){	
			for(int j=0;j<listData.size();j++) {
				String mycolNames = "";
				if(colsNames == "")
					mycolNames = listData.get(j);
				else
					mycolNames = colsNames+","+listData.get(j);
				//指标数据
				listCells.add(mycolNames);				
			}
		} else{
			dimCol++;
			for(int j=0;j<listData.size();j++) {				
				String mycolNames="";
				if(colsNames == "")
					mycolNames = listData.get(j);
				else
					mycolNames = colsNames+","+listData.get(j);
				//指标数据
				GeneReportCellsData(dimCol, BIColDimDatas, mycolNames, colSize, listCells);
			}
		}
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
		Class.forName(PropertiesUtil.CLASSNAME);
		Connection conn = DriverManager.getConnection(PropertiesUtil.URL, PropertiesUtil.USERNAME, PropertiesUtil.PASSWORD);
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
}

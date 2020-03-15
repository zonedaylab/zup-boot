package cn.zup.bi.controller;

import cn.zup.bi.entity.*;
import cn.zup.bi.service.*;
import cn.zup.bi.utils.DatabaseParamBuilder;
import cn.zup.bi.utils.PropertiesUtil;
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
	public Object getReportData(@RequestBody V_ReportData vreportData, String callback) throws Exception {
		//获取一个页面、一个屏幕上的所有div
		if(vreportData.getBlock_Id() == 0){
			vreportData.setBlock_Id(null);
		}
		List<BI_Block_Info> blockList = biPageBlockService.getPageBlockByPageId(vreportData.getBi_Page_Id(), vreportData.getScreen_Index(), vreportData.getBlock_Id());
		JSONObject json = new JSONObject();

		Connection conn = null;
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		if(blockList.size() > 0) {
			Integer reportId = blockList.get(0).getReport_Id();
			BI_REPORT bi_report = biReportService.getReportInfo(reportId);
			BI_TOPIC bi_topic = topicService.getTopicData(bi_report.getTopic_Id());
			if(bi_topic==null)
			{
				biPageBlockService.deleteBlock(blockList.get(0).getBlock_Id());

			}
			BI_Datasource biDatasource = biDatasourceService.getDatasourceInfo(bi_topic.getDs_id());
			Class.forName(DatabaseParamBuilder.getClassName(biDatasource.getDs_attr()));
			conn = DriverManager.getConnection(DatabaseParamBuilder.getUrl(biDatasource.getDs_ip()
					, biDatasource.getDs_port(), biDatasource.getDs_name()
					, biDatasource.getDs_attr()), biDatasource.getDs_username(), biDatasource.getDs_password());


			PreparedStatement ps = null;
			ResultSet rs = null;
			for (BI_Block_Info bi_Block_Info : blockList) {
				Map<String, Object> resultMap = new HashMap<String, Object>();
				//获取div上绑定的报表的数据
				ConditionTransfer conditionTransfer = new ConditionTransfer();
				conditionTransfer.setDrill_Name(vreportData.getDrill_Name());
				conditionTransfer.setDrill_Value(vreportData.getDrill_Value());
				conditionTransfer.setKey(vreportData.getKey());
				conditionTransfer.setValue(vreportData.getValue());
				conditionTransfer.setReport_Id(bi_Block_Info.getReport_Id());
				conditionTransfer.setIndex(vreportData.getIndex());
				conditionTransfer.setType(vreportData.getBlock_Type());
				String sql = biShowEngineService.showReport(conditionTransfer);
				ps = conn.prepareStatement(sql);
				rs = ps.executeQuery();
				ResultSetMetaData rsmd = rs.getMetaData();
				int count = rsmd.getColumnCount();
				List<Map<String, Object>> listMap = new ArrayList<Map<String, Object>>();//数据
				//从数据库中查询出来放入map中
				while (rs.next()) {
					Map<String, Object> map = new HashMap<String, Object>();
					for (int i = 1; i <= count; i++) {
						if (vreportData.getBlock_Type() == 1
								&& (rsmd.getColumnLabel(i).toLowerCase().equals("province")
								|| rsmd.getColumnLabel(i).toLowerCase().equals("city")
								|| rsmd.getColumnLabel(i).toLowerCase().equals("county")))
							map.put(rsmd.getColumnLabel(i).toLowerCase(), rs.getObject(i) + "-" + rs.getInt("areaId"));
						else {
							Object obj = rs.getObject(i);
							if (obj != null) {
								if (obj instanceof Integer) {
									map.put(rsmd.getColumnLabel(i).toLowerCase(), rs.getInt(i));
								} else if (obj instanceof Float) {
									map.put(rsmd.getColumnLabel(i).toLowerCase(), rs.getFloat(i));
								} else if (obj instanceof BigDecimal) {
									map.put(rsmd.getColumnLabel(i).toLowerCase(), rs.getBigDecimal(i).toPlainString());
								} else if (obj instanceof Double) {
									map.put(rsmd.getColumnLabel(i).toLowerCase(), rs.getDouble(i));
								} else {
									map.put(rsmd.getColumnLabel(i).toLowerCase(), rs.getObject(i));
								}
							} else {
								if (obj instanceof Integer || obj instanceof Double)
									map.put(rsmd.getColumnLabel(i).toLowerCase(), 0);
								else
									map.put(rsmd.getColumnLabel(i).toLowerCase(), "");
							}

						}
					}
					listMap.add(map);
				}

				//获取指标
				List<String> topicList = new ArrayList<String>();
				List<String> topicNameList = new ArrayList<String>();
				List<String> topicUnitList = new ArrayList<String>();
				List<BIShowField> topicFieldList = biTopicFieldService.getTopicFieldList(bi_Block_Info.getReport_Id());
				boolean ub = false; //判断是否切换指标
				for (BIShowField biShowField : topicFieldList) {
					if (vreportData.getIndex() == null || vreportData.getIndex().equals(biShowField.getField_Id())) {
						if (vreportData.getBlock_Type() == 1) {
							if (ub)
								continue;
						}
						topicList.add(biShowField.getField_Caption().toLowerCase());
						topicNameList.add(biShowField.getField_Title());
						topicUnitList.add(biShowField.getField_Unit());
						ub = true;
					}
				}

				//List<List<String>> tableHeaderList = new ArrayList<List<String>>();//这个没有用到  liuxf
				List<String> lieDimFields = new ArrayList<String>(); //行维  右上为行维度。 by liuxf
				List<String> hangDimFields = new ArrayList<String>();//列维 左侧为列维度

				//获取维度的字段
				List<BIShowField> dimFieldList = biDimService.getDimFieldList(conditionTransfer);
				List<Map<String, Object>> dimTopicTableHeader = new ArrayList<Map<String, Object>>();
				for (int i = 0; i < dimFieldList.size(); i++) {
					BIShowField dimField = dimFieldList.get(i);
					Map<String, Object> dimTopicTableHeaderMap = new HashMap<String, Object>();
					if (dimField.getField_Location() == 1) {        //针对行维度,  右侧的为行维度。
						List<String> dimRowList = new ArrayList<String>();
						for (int k = 0; k < listMap.size(); k++) {
							if (dimField.getDrill_Type() == null) {

							/*  加入行数据,生成行维度，例如by liuxf
								dimName=行业种类
								dimValue= 电力/ 服务/水务等
								维度横向生成
							*   电力 服务   水务   。。。。。。
							 */
								String dimName = dimField.getField_Name().toLowerCase();
								String dimVaue = listMap.get(k).get(dimName).toString();
								if (!dimRowList.contains(dimVaue))
									dimRowList.add(dimVaue);

								//加入维度的名字，例如 "行业种类"
								if (!hangDimFields.contains(dimName))//加入行维度
									hangDimFields.add(dimName);

								//tableHeaderList.add(dimRowList);
								continue;
							}
							if (dimField.getDrill_Type() != 3) {
								if (!dimRowList.contains(listMap.get(k).get(dimField.getText_Field().toLowerCase()).toString()))
									dimRowList.add(listMap.get(k).get(dimField.getText_Field().toLowerCase()).toString());
								if (!hangDimFields.contains(dimField.getText_Field().toLowerCase()))
									hangDimFields.add(dimField.getText_Field().toLowerCase());
							} else {
								if (vreportData.getDrill_Name() != null) {
									int lc = (vreportData.getDrill_Value() + "").length() / 2;
									if (listMap.get(k).get(dimField.getDrill_Info().split("-")[lc].toLowerCase()) != null) {
										if (!dimRowList.contains(listMap.get(k).get(dimField.getDrill_Info().split("-")[lc].toLowerCase()).toString())) {
											dimRowList.add(listMap.get(k).get(dimField.getDrill_Info().split("-")[lc].toLowerCase()).toString());
										}
										if (!hangDimFields.contains(dimField.getDrill_Info().split("-")[lc].toLowerCase()))
											hangDimFields.add(dimField.getDrill_Info().split("-")[lc].toLowerCase());
									}
								} else {
									if (!hangDimFields.contains(dimField.getDrill_Info().split("-")[0].toLowerCase()))
										hangDimFields.add(dimField.getDrill_Info().split("-")[0].toLowerCase());
								}
							}
							//tableHeaderList.add(dimRowList);
						}
						if (dimField.getDrill_Type() != null)
							dimTopicTableHeaderMap.put(dimField.getText_Field().toLowerCase(), dimFieldList.get(i).getDim_Order());
						else
							dimTopicTableHeaderMap.put(dimField.getField_Name().toLowerCase(), dimFieldList.get(i).getDim_Order());
						dimTopicTableHeader.add(dimTopicTableHeaderMap);
					} else if (dimFieldList.get(i).getField_Location() == 2) {
						/*
						 * 列维度
						 * 例如 dimName="省份" dimValue=山东省/河南省/....
						 * 纵向排列：
						 *
						 * 山东省
						 * 河南省
						 * 河北省
						 * ......
						 * */
						if (dimField.getDrill_Type() == null) {
							//列维度 例如 河南省 山东省
							if (!lieDimFields.contains(dimField.getField_Name().toLowerCase()))
								lieDimFields.add(dimField.getField_Name().toLowerCase());
							continue;
						}
						if (dimField.getDrill_Type() != 3) {
							if (!lieDimFields.contains(dimField.getText_Field().toLowerCase()))
								lieDimFields.add(dimField.getText_Field().toLowerCase());
						} else {
							if (vreportData.getDrill_Name() != null) {
								int lc = (vreportData.getDrill_Value() + "").length() / 2;
								if (!lieDimFields.contains(dimField.getDrill_Info().split("-")[lc].toLowerCase()))
									lieDimFields.add(dimField.getDrill_Info().split("-")[lc].toLowerCase());
							} else {
								if (!lieDimFields.contains(dimField.getDrill_Info().split("-")[0].toLowerCase()))
									lieDimFields.add(dimField.getDrill_Info().split("-")[0].toLowerCase());
							}
						}
					}
				}

				//表格数据清洗
				if (vreportData.getBlock_Type() == 1) {

					//列维 行维    数据格式  <"2017-集体-云南省", "494">
					Map<String, String> mapIndicatorData = new HashMap<String, String>();
					for (Map<String, Object> map : listMap) {
						String xkey = "";
						String xvalue = "";
						for (int j = 0; j < map.size(); j++) {
							String rowK = "";
							String celK = "";
							String valK = "";
							for (int i = 0; i < lieDimFields.size(); i++) {   //判断是否为列
								if (map.containsKey(lieDimFields.get(i)))
									celK += map.get(lieDimFields.get(i)) + ",";
							}
							for (int i = 0; i < hangDimFields.size(); i++) { //判断是否为行维
								if (map.containsKey(hangDimFields.get(i)))
									rowK += map.get(hangDimFields.get(i)) + ",";
							}
							for (int i = 0; i < topicList.size(); i++) { //判断是否为指标
								if (map.containsKey(topicList.get(i)))
									valK += map.get(topicList.get(i)) + ",";
							}

							xkey = celK + "" + rowK;
							xvalue = valK;
							if (xkey.lastIndexOf(",") > -1) {
								xkey = xkey.substring(0, xkey.length() - 1);
							}
							if (xvalue.lastIndexOf(",") > -1) {
								xvalue = xvalue.substring(0, xvalue.length() - 1);
							}
							mapIndicatorData.put(xkey, xvalue);  // 数据格式  <"2017-集体-云南省", "494">
						}
					}
					//创建列维度集合
					List<BIDimData> BIColDimDatas = new ArrayList<BIDimData>();
					for (int i = 0; i < lieDimFields.size(); i++) {
						BIDimData data = new BIDimData();
						data.setListData(new ArrayList<String>());
						BIColDimDatas.add(data);
					}
					for (Map<String, Object> map : listMap) {
						for (int i = 0; i < lieDimFields.size(); i++) {
							List<String> listData = BIColDimDatas.get(i).getListData();
							String value = map.get(lieDimFields.get(i)).toString();
							if (!listData.contains(value))
								listData.add(value);
						}
					}
					//创建行维度集合
					List<BIDimData> BIRowDimDatas = new ArrayList<BIDimData>();
					for (int i = 0; i < hangDimFields.size(); i++) {
						BIDimData data = new BIDimData();
						data.setListData(new ArrayList<String>());
						BIRowDimDatas.add(data);
					}
					for (Map<String, Object> map : listMap) {
						for (int i = 0; i < hangDimFields.size(); i++) {
							List<String> listData = BIRowDimDatas.get(i).getListData();
							String value = map.get(hangDimFields.get(i)).toString();
							if (!listData.contains(value))
								listData.add(value);
						}
					}

					//---------------------创建表格-----------------------
					//1---创建表头  上面创建
					List<List<String>> listRowCells = new ArrayList<List<String>>();
					int allColsCount = 1;  //需要展示的列数
					for (int i = 0; i < BIRowDimDatas.size(); i++) {
						allColsCount *= BIRowDimDatas.get(i).getListData().size();
					}
					int loopCount = allColsCount;
					for (int i = 0; i < BIRowDimDatas.size(); i++) {//生成 行表头
						List<String> listRowCell = new ArrayList<String>();//  表示一行数据，

						loopCount /= BIRowDimDatas.get(i).getListData().size(); //重复个数
						int currentColCnt = 0;
						int dataIndex = 0; //当前显示列对应的数据索引
						while (currentColCnt < allColsCount) {
							for (int j = 0; j < loopCount; j++) {
								listRowCell.add(BIRowDimDatas.get(i).getListData().get(dataIndex));
							}
							dataIndex++;
							dataIndex = dataIndex % BIRowDimDatas.get(i).getListData().size();
							currentColCnt += loopCount;
						}

						if (i != BIRowDimDatas.size() - 1)
							Collections.sort(listRowCell);
						listRowCells.add(listRowCell);
					}
					//2---创建数据行
					String colsNames = "";
					List<String> listRows = new ArrayList<String>();
					GeneReportData(0, BIColDimDatas, colsNames, BIColDimDatas.size(), listRows);
					List<String> listCells = new ArrayList<String>();  //循环遍历行
					String rowsNames = "";
					GeneReportCellsData(0, BIRowDimDatas, rowsNames, BIRowDimDatas.size(), listCells);

					List<List<String>> listRowData = new ArrayList<List<String>>();
					for (int i = 0; i < listRows.size(); i++) {
						String rowValue = listRows.get(i);
						for (int j = 0; j < listCells.size(); j++) {
							String keyName = listRows.get(i) + ",";
							keyName += listCells.get(j);
							rowValue += ",";
							if (mapIndicatorData.containsKey(keyName)) {
								rowValue += mapIndicatorData.get(keyName);
							} else {
								rowValue += "0";
							}
						}
						List<String> rowValueList = Arrays.asList(rowValue.split(","));
						listRowData.add(rowValueList);
					}
					resultMap.put("tableData", listRowData);
					resultMap.put("dimFieldHeader", listRowCells);
				} else {
					resultMap.put("data", listMap);
				}

				//获取报表信息
				BI_REPORT reportInfo = biReportService.getReportInfo(bi_Block_Info.getReport_Id());
				JsonConfig jsonConfig = new JsonConfig();
				jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor("yyyy-MM-dd HH:mm:ss"));
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
		if(BIColDimDatas != null && BIColDimDatas.size() > 0){
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
	}
	
	private void GeneReportCellsData(int dimCol, List<BIDimData> BIColDimDatas , String colsNames, int colSize, List<String> listCells) {
		if(BIColDimDatas != null && BIColDimDatas.size() > 0) {
			List<String> listData = BIColDimDatas.get(dimCol).getListData();
			if (dimCol == colSize - 1) {
				for (int j = 0; j < listData.size(); j++) {
					String mycolNames = "";
					if (colsNames == "")
						mycolNames = listData.get(j);
					else
						mycolNames = colsNames + "," + listData.get(j);
					//指标数据
					listCells.add(mycolNames);
				}
			} else {
				dimCol++;
				for (int j = 0; j < listData.size(); j++) {
					String mycolNames = "";
					if (colsNames == "")
						mycolNames = listData.get(j);
					else
						mycolNames = colsNames + "," + listData.get(j);
					//指标数据
					GeneReportCellsData(dimCol, BIColDimDatas, mycolNames, colSize, listCells);
				}
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
		Class.forName(PropertiesUtil.CLASSNAME);
		Connection conn = DriverManager.getConnection(PropertiesUtil.URL, PropertiesUtil.USERNAME, PropertiesUtil.PASSWORD);
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

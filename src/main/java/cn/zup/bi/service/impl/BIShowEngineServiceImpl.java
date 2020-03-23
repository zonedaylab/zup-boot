package cn.zup.bi.service.impl;

import cn.zup.bi.dao.BIShowEngineDao;
import cn.zup.bi.dao.DimDao;
import cn.zup.bi.dao.ReportFieldDao;
import cn.zup.bi.entity.*;
import cn.zup.bi.service.*;
import cn.zup.bi.utils.BIConnection;
import cn.zup.framework.json.JsonDateValueProcessor;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.*;

@Service("biShowEngineService")
public class BIShowEngineServiceImpl implements BIShowEngineService {
	
	@Autowired
	private ReportFieldDao reportFieldDao;
	@Autowired
	private BIShowEngineDao biShowEngineDao;
	@Autowired
	private DimDao dimDao;
	@Resource
	private BIPageBlockService biPageBlockService;
	@Resource
	private BIDimService biDimService;
	@Resource
	private TopicFieldService biTopicFieldService;
	@Resource
	private TopicService topicService;
	@Resource
	private ReportService biReportService;

	private  List<Map<String, Object>> getReportDirect(V_ReportData vreportData) throws Exception {
		//获取一个页面、一个屏幕上的所有div
		if(vreportData.getBlock_Id() == 0){
			vreportData.setBlock_Id(null);
		}
		List<BI_Block_Info> blockList = biPageBlockService.getPageBlockByPageId(vreportData.getBi_Page_Id(),
				vreportData.getScreen_Index(), vreportData.getBlock_Id());
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		if(blockList.size() > 0) {

			BI_REPORT bi_report = biReportService.getReportInfo(blockList.get(0).getReport_Id());
			if( topicService.getTopicData(bi_report.getTopic_Id())==null){//遇到错误数据
				biPageBlockService.deleteBlock(blockList.get(0).getBlock_Id());
			}


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
				conditionTransfer.setBlock_type(vreportData.getBlock_Type());

				//1.从数据库中获取报表数据
				List<Map<String, Object>> listDataMap = getReportDataFromDB(conditionTransfer);


				//获取维度与指标数据
				List<BIShowField> topicFieldList = biTopicFieldService.getTopicFieldList(bi_Block_Info.getReport_Id());
				List<BIShowField> dimFieldList = biDimService.getDimFieldList(conditionTransfer);

				List<String> topicList = new ArrayList<String>();
				List<String> topicNameList = new ArrayList<String>();
				List<String> topicUnitList = new ArrayList<String>();

				List<String> colDimFields = new ArrayList<String>(); //列维列表，包含的维度名字如“省份”，“种类”。 左侧为列维度
				List<String> rowDimFields = new ArrayList<String>(); //行维列表  右上为行维度。 by liuxf

				List<Map<String, Object>> dimTopicTableHeader = new ArrayList<Map<String, Object>>();

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

				/*2.获取维度对应的数据信息

				 */
				for (int i = 0; i < dimFieldList.size(); i++) {
					BIShowField dimField = dimFieldList.get(i);
					Map<String, Object> dimTopicTableHeaderMap = new HashMap<String, Object>();//表头

					String dimFieldName = dimField.getField_Name().toLowerCase();
					if (dimField.getField_Location() == 1) {        //针对行维度,  右侧的为行维度。

						List<String> dimRowDataList = new ArrayList<String>(); //行数据

						for (int k = 0; k < listDataMap.size(); k++) {
							if (dimField.getDrill_Type() == null) {

							/*  加入行数据,生成行维度，例如by liuxf
								dimName=行业种类
								dimValue= 电力/ 服务/水务等
								维度横向生成
							*   电力 服务   水务   。。。。。。
							 */
								String dimVaue = listDataMap.get(k).get(dimFieldName).toString();
								if (!dimRowDataList.contains(dimVaue))//没有用到，需要删除
									dimRowDataList.add(dimVaue);
								//加入维度的名字，例如 "行业种类"
								if (!rowDimFields.contains(dimFieldName))//加入行维度
									rowDimFields.add(dimFieldName);
								continue;
							}
							if (dimField.getDrill_Type() != 3) {
								if (!dimRowDataList.contains(listDataMap.get(k).get(dimFieldName).toString()))
									dimRowDataList.add(listDataMap.get(k).get(dimFieldName).toString());
								if (!rowDimFields.contains(dimFieldName))
									rowDimFields.add(dimFieldName);
							} else {
								if (vreportData.getDrill_Name() != null) {
									int lc = (vreportData.getDrill_Value() + "").length() / 2;
									if (listDataMap.get(k).get(dimField.getDrill_Info().split("-")[lc].toLowerCase()) != null) {
										if (!dimRowDataList.contains(listDataMap.get(k).get(dimField.getDrill_Info().split("-")[lc].toLowerCase()).toString())) {
											dimRowDataList.add(listDataMap.get(k).get(dimField.getDrill_Info().split("-")[lc].toLowerCase()).toString());
										}
										if (!rowDimFields.contains(dimField.getDrill_Info().split("-")[lc].toLowerCase()))
											rowDimFields.add(dimField.getDrill_Info().split("-")[lc].toLowerCase());
									}
								} else {
									if (!rowDimFields.contains(dimField.getDrill_Info().split("-")[0].toLowerCase()))
										rowDimFields.add(dimField.getDrill_Info().split("-")[0].toLowerCase());
								}
							}
						}
						dimTopicTableHeaderMap.put(dimFieldName, dimFieldList.get(i).getDim_Order());
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
						if (dimField.getDrill_Type() == null||dimField.getDrill_Type() != 3) {
							//列维度
							if (!colDimFields.contains(dimFieldName))
								colDimFields.add(dimFieldName);
						}
						else {
							if (vreportData.getDrill_Name() != null) {
								int lc = (vreportData.getDrill_Value() + "").length() / 2;
								if (!colDimFields.contains(dimField.getDrill_Info().split("-")[lc].toLowerCase()))
									colDimFields.add(dimField.getDrill_Info().split("-")[lc].toLowerCase());
							} else {
								if (!colDimFields.contains(dimField.getDrill_Info().split("-")[0].toLowerCase()))
									colDimFields.add(dimField.getDrill_Info().split("-")[0].toLowerCase());
							}
						}
					}
				}

				//业务数据转换洗
				if (vreportData.getBlock_Type() == 1) {

					/*
					3.创建指标数据
					数据格式：
					列维 行维    数据格式  <"2017-集体-云南省", "494">    指标数据

					*/
					Map<String, String> mapIndicatorData = new HashMap<String, String>();

					for (Map<String, Object> map : listDataMap) {//获取数据
						String xkey = "";
						String xvalue = "";
						for (int j = 0; j < map.size(); j++) {
							String rowK = "";
							String colK = "";
							String valK = "";

							for (int i = 0; i < colDimFields.size(); i++) {   //判断是否为列
								if (map.containsKey(colDimFields.get(i)))
									colK += map.get(colDimFields.get(i)) + ",";
							}
							for (int i = 0; i < rowDimFields.size(); i++) { //判断是否为行维
								if (map.containsKey(rowDimFields.get(i)))
									rowK += map.get(rowDimFields.get(i)) + ",";
							}
							for (int i = 0; i < topicList.size(); i++) { //判断是否为指标
								if (map.containsKey(topicList.get(i)))
									valK += map.get(topicList.get(i)) + ",";
							}

							xkey = colK + "" + rowK;
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

					//4.创建列维度数据集合。
					List<BIDimData> BIColDimDatas = new ArrayList<BIDimData>();
					for (int i = 0; i < colDimFields.size(); i++) {
						BIDimData data = new BIDimData();
						data.setListData(new ArrayList<String>());
						BIColDimDatas.add(data);
					}
					for (Map<String, Object> map : listDataMap) {
						for (int i = 0; i < colDimFields.size(); i++) {

							List<String> listData = BIColDimDatas.get(i).getListData();
							String value = map.get(colDimFields.get(i)).toString();
							if (!listData.contains(value))
								listData.add(value);
						}
					}

					//5.创建行维度数据集合,需要展示的列数量。
					List<BIDimData> BIRowDimDatas = new ArrayList<BIDimData>();
					for (int i = 0; i < rowDimFields.size(); i++) {
						BIDimData data = new BIDimData();
						data.setListData(new ArrayList<String>());
						BIRowDimDatas.add(data);
					}
					for (Map<String, Object> map : listDataMap) {
						for (int i = 0; i < rowDimFields.size(); i++) {
							List<String> listData = BIRowDimDatas.get(i).getListData();
							String value = map.get(rowDimFields.get(i)).toString();//包含这个维度
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
					//2---创建数据行与单元格
					String colsNames = "";
					List<String> listRows = new ArrayList<String>();

					GeneTableRow(0, BIColDimDatas, colsNames, BIColDimDatas.size(), listRows);
					List<String> listCols = new ArrayList<String>();  //循环遍历行
					String rowsNames = "";
					GeneTableCol(0, BIRowDimDatas, rowsNames, BIRowDimDatas.size(), listCols);

					//3.向生成的单元格里设置业务数据
					List<List<String>> listRowData = new ArrayList<List<String>>();
					for (int i = 0; i < listRows.size(); i++) {

						String rowValue = listRows.get(i);

						for (int j = 0; j < listCols.size(); j++) {
							String keyName = listRows.get(i) + ",";
							keyName += listCols.get(j);
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
					resultMap.put("data", listDataMap);
				}

				//获取报表信息
				BI_REPORT reportInfo = biReportService.getReportInfo(bi_Block_Info.getReport_Id());
				JsonConfig jsonConfig = new JsonConfig();
				jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor("yyyy-MM-dd HH:mm:ss"));
				JSONObject jsonArray = JSONObject.fromObject(reportInfo, jsonConfig);
				resultMap.put("reportInfo", jsonArray);

				resultMap.put("dimHeader", rowDimFields);//行维度
				resultMap.put("topicField", topicList);
				colDimFields.removeAll(rowDimFields);
				resultMap.put("dimField", colDimFields);
				resultMap.put("topicFieldName", topicNameList);
				resultMap.put("unit", topicUnitList);
				resultMap.put("flList", dimTopicTableHeader);
				resultMap.put("blockInfo", bi_Block_Info);

				list.add(resultMap);
			}
		}
		return  list;
	}


	@Override
	public  List<Map<String, Object>> getReport(V_ReportData vreportData) throws Exception {
		//获取一个页面、一个屏幕上的所有div
		if(vreportData.getBlock_Id() == 0){
			vreportData.setBlock_Id(null);
		}
		List<BI_Block_Info> blockList = biPageBlockService.getPageBlockByPageId(vreportData.getBi_Page_Id(),
				vreportData.getScreen_Index(), vreportData.getBlock_Id());
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		if(blockList.size() > 0) {

			BI_REPORT bi_report = biReportService.getReportInfo(blockList.get(0).getReport_Id());
			if( topicService.getTopicData(bi_report.getTopic_Id())==null){//遇到错误数据
				biPageBlockService.deleteBlock(blockList.get(0).getBlock_Id());
			}


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
				conditionTransfer.setBlock_type(vreportData.getBlock_Type());

				//1.从数据库中获取报表数据
				List<Map<String, Object>> listDataMap = getReportDataFromDB(conditionTransfer);

				//获取维度与指标数据
				List<BIShowField> topicFieldList = biTopicFieldService.getTopicFieldList(bi_Block_Info.getReport_Id());
				List<BIShowField> dimFieldList = biDimService.getDimFieldList(conditionTransfer);

				List<String> topicList = new ArrayList<String>();
				List<String> topicNameList = new ArrayList<String>();
				List<String> topicUnitList = new ArrayList<String>();

				List<String> colDimFields = new ArrayList<String>(); //列维列表，包含的维度名字如“省份”，“种类”。 左侧为列维度
				List<String> rowDimFields = new ArrayList<String>(); //行维列表  右上为行维度。 by liuxf

				List<Map<String, Object>> dimTopicTableHeader = new ArrayList<Map<String, Object>>();

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

				/*2.获取维度对应的数据信息

				*/
				for (int i = 0; i < dimFieldList.size(); i++) {
					BIShowField dimField = dimFieldList.get(i);
					Map<String, Object> dimTopicTableHeaderMap = new HashMap<String, Object>();//表头

					String dimFieldName = dimField.getField_Name().toLowerCase();
					if (dimField.getField_Location() == 1) {        //针对行维度,  右侧的为行维度。

						List<String> dimRowDataList = new ArrayList<String>(); //行数据

						for (int k = 0; k < listDataMap.size(); k++) {
							if (dimField.getDrill_Type() == null) {

							/*  加入行数据,生成行维度，例如by liuxf
								dimName=行业种类
								dimValue= 电力/ 服务/水务等
								维度横向生成
							*   电力 服务   水务   。。。。。。
							 */
								String dimVaue = listDataMap.get(k).get(dimFieldName).toString();
								if (!dimRowDataList.contains(dimVaue))//没有用到，需要删除
									dimRowDataList.add(dimVaue);
								//加入维度的名字，例如 "行业种类"
								if (!rowDimFields.contains(dimFieldName))//加入行维度
									rowDimFields.add(dimFieldName);
								continue;
							}
							if (dimField.getDrill_Type() != 3) {
								if (!dimRowDataList.contains(listDataMap.get(k).get(dimFieldName).toString()))
									dimRowDataList.add(listDataMap.get(k).get(dimFieldName).toString());
								if (!rowDimFields.contains(dimFieldName))
									rowDimFields.add(dimFieldName);
							} else {
								if (vreportData.getDrill_Name() != null) {
									int lc = (vreportData.getDrill_Value() + "").length() / 2;
									if (listDataMap.get(k).get(dimField.getDrill_Info().split("-")[lc].toLowerCase()) != null) {
										if (!dimRowDataList.contains(listDataMap.get(k).get(dimField.getDrill_Info().split("-")[lc].toLowerCase()).toString())) {
											dimRowDataList.add(listDataMap.get(k).get(dimField.getDrill_Info().split("-")[lc].toLowerCase()).toString());
										}
										if (!rowDimFields.contains(dimField.getDrill_Info().split("-")[lc].toLowerCase()))
											rowDimFields.add(dimField.getDrill_Info().split("-")[lc].toLowerCase());
									}
								} else {
									if (!rowDimFields.contains(dimField.getDrill_Info().split("-")[0].toLowerCase()))
										rowDimFields.add(dimField.getDrill_Info().split("-")[0].toLowerCase());
								}
							}
						}
						dimTopicTableHeaderMap.put(dimFieldName, dimFieldList.get(i).getDim_Order());
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
						if (dimField.getDrill_Type() == null||dimField.getDrill_Type() != 3) {
							//列维度
							if (!colDimFields.contains(dimFieldName))
								colDimFields.add(dimFieldName);
						}
						else {
							if (vreportData.getDrill_Name() != null) {
								int lc = (vreportData.getDrill_Value() + "").length() / 2;
								if (!colDimFields.contains(dimField.getDrill_Info().split("-")[lc].toLowerCase()))
									colDimFields.add(dimField.getDrill_Info().split("-")[lc].toLowerCase());
							} else {
								if (!colDimFields.contains(dimField.getDrill_Info().split("-")[0].toLowerCase()))
									colDimFields.add(dimField.getDrill_Info().split("-")[0].toLowerCase());
							}
						}
					}
				}

				//业务数据转换洗
				if (vreportData.getBlock_Type() == 1) {

					/*
					3.创建指标数据
					数据格式：
					列维 行维    数据格式  <"2017-集体-云南省", "494">    指标数据

					*/
					Map<String, String> mapIndicatorData = new HashMap<String, String>();

					for (Map<String, Object> map : listDataMap) {//获取数据
						String xkey = "";
						String xvalue = "";
						for (int j = 0; j < map.size(); j++) {
							String rowK = "";
							String colK = "";
							String valK = "";

							for (int i = 0; i < colDimFields.size(); i++) {   //判断是否为列
								if (map.containsKey(colDimFields.get(i)))
									colK += map.get(colDimFields.get(i)) + ",";
							}
							for (int i = 0; i < rowDimFields.size(); i++) { //判断是否为行维
								if (map.containsKey(rowDimFields.get(i)))
									rowK += map.get(rowDimFields.get(i)) + ",";
							}
							for (int i = 0; i < topicList.size(); i++) { //判断是否为指标
								if (map.containsKey(topicList.get(i)))
									valK += map.get(topicList.get(i)) + ",";
							}

							xkey = colK + "" + rowK;
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

					//4.创建列维度数据集合。
					List<BIDimData> BIColDimDatas = new ArrayList<BIDimData>();
					for (int i = 0; i < colDimFields.size(); i++) {
						BIDimData data = new BIDimData();
						data.setListData(new ArrayList<String>());
						BIColDimDatas.add(data);
					}
					for (Map<String, Object> map : listDataMap) {
						for (int i = 0; i < colDimFields.size(); i++) {

							List<String> listData = BIColDimDatas.get(i).getListData();
							String value = map.get(colDimFields.get(i)).toString();
							if (!listData.contains(value))
								listData.add(value);
						}
					}

					//5.创建行维度数据集合
					List<BIDimData> BIRowDimDatas = new ArrayList<BIDimData>();
					for (int i = 0; i < rowDimFields.size(); i++) {
						BIDimData data = new BIDimData();
						data.setListData(new ArrayList<String>());
						BIRowDimDatas.add(data);
					}
					for (Map<String, Object> map : listDataMap) {
						for (int i = 0; i < rowDimFields.size(); i++) {
							List<String> listData = BIRowDimDatas.get(i).getListData();
							String value = map.get(rowDimFields.get(i)).toString();
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
					//2---创建数据行与单元格
					String colsNames = "";
					List<String> listRows = new ArrayList<String>();

					GeneTableRow(0, BIColDimDatas, colsNames, BIColDimDatas.size(), listRows);
					List<String> listCols = new ArrayList<String>();  //循环遍历行
					String rowsNames = "";
					GeneTableCol(0, BIRowDimDatas, rowsNames, BIRowDimDatas.size(), listCols);

					//3.向生成的单元格里设置业务数据
					List<List<String>> listRowData = new ArrayList<List<String>>();
					for (int i = 0; i < listRows.size(); i++) {

						String rowValue = listRows.get(i);

						for (int j = 0; j < listCols.size(); j++) {
							String keyName = listRows.get(i) + ",";
							keyName += listCols.get(j);
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
					resultMap.put("data", listDataMap);
				}

				//获取报表信息
				BI_REPORT reportInfo = biReportService.getReportInfo(bi_Block_Info.getReport_Id());
				JsonConfig jsonConfig = new JsonConfig();
				jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor("yyyy-MM-dd HH:mm:ss"));
				JSONObject jsonArray = JSONObject.fromObject(reportInfo, jsonConfig);
				resultMap.put("reportInfo", jsonArray);

				resultMap.put("dimHeader", rowDimFields);//行维度
				resultMap.put("topicField", topicList);
				colDimFields.removeAll(rowDimFields);
				resultMap.put("dimField", colDimFields);
				resultMap.put("topicFieldName", topicNameList);
				resultMap.put("unit", topicUnitList);
				resultMap.put("flList", dimTopicTableHeader);
				resultMap.put("blockInfo", bi_Block_Info);

				list.add(resultMap);
			}
		}
		return  list;
	}
	/*
	根据列维度递生成行数据 liuxf
	 * dimCol 列维序号
	 * BIColDimDatas 列维度数据（如列维度为省， 则数据为 山东省 河南省
	  * 列维度
			 * 例如 dimName="省份" dimValue=山东省/河南省/....
			 * 纵向排列，例如：
			 *
			 * 山东省
			 * 河南省
			 * 河北省
			 * 山东省
			 * ...
	 * colsNames 一行的列维字符串
	 * colSize  列维的数量
	 * listRows 生成的数据行数  返回数据
	 */
	private void GeneTableRow(int dimCol, List<BIDimData> BIColDimDatas , String colsNames, int colSize, List<String> listRows) {
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
					GeneTableRow(dimCol, BIColDimDatas, mycolNames, colSize, listRows);
				}
			}
		}
	}

	/**
	 * 根据行维度生成列信息
	 * @param dimCol
	 * @param BIColDimDatas
	 * @param colsNames
	 * @param colSize
	 * @param listCells
	 */

	private void GeneTableCol(int dimRow, List<BIDimData> BIRowDimDatas , String rowsNames, int rowSize, List<String> listCols) {
		if(BIRowDimDatas != null && BIRowDimDatas.size() > 0) {
			List<String> listData = BIRowDimDatas.get(dimRow).getListData();
			if (dimRow == rowSize - 1) {
				for (int j = 0; j < listData.size(); j++) {
					String mycolNames = "";
					if (rowsNames == "")
						mycolNames = listData.get(j);
					else
						mycolNames = rowsNames + "," + listData.get(j);
					//指标数据
					listCols.add(mycolNames);
				}
			} else {
				dimRow++;
				for (int j = 0; j < listData.size(); j++) {
					String mycolNames = "";
					if (rowsNames == "")
						mycolNames = listData.get(j);
					else
						mycolNames = rowsNames + "," + listData.get(j);
					//指标数据
					GeneTableCol(dimRow, BIRowDimDatas, mycolNames, rowSize, listCols);
				}
			}
		}
	}

	private List<Map<String, Object>> getReportDataFromDB(ConditionTransfer conditionTransfer) throws Exception {
		List<String> key = new ArrayList<String>(conditionTransfer.getKey());
		List<Object> value = new ArrayList<Object>(conditionTransfer.getValue());
		List<BI_REPORT_FIELD> reportFieldList = reportFieldDao.getReportFieldByReportId(conditionTransfer.getReport_Id());

		String rowDimFieldIds = "";  //行维度字段
		String colDimFieldIds = "";  //列维度字段
		String topicFieldIds = "";   //指标字段

		//第一步遍历获取到对应的主题字段，分为维表和指标
		for (int i = 0; i < reportFieldList.size(); i++) {
			if(reportFieldList.get(i).getField_Location() == 1){
				rowDimFieldIds += reportFieldList.get(i).getField_Id()+", ";
			}else if(reportFieldList.get(i).getField_Location() == 2){
				colDimFieldIds += reportFieldList.get(i).getField_Id()+", ";
			}else if(reportFieldList.get(i).getField_Location() == 3){
				topicFieldIds += reportFieldList.get(i).getField_Id()+", ";
			}
		}
		String dimFieldIds = "";
		if(rowDimFieldIds.indexOf(",") > -1)//行维
			rowDimFieldIds = rowDimFieldIds.substring(0, rowDimFieldIds.length()-2);

		if(colDimFieldIds.indexOf(",") > -1)//列维
			colDimFieldIds = colDimFieldIds.substring(0, colDimFieldIds.length()-2);

		if(topicFieldIds.indexOf(",") > -1)//指标
			topicFieldIds = topicFieldIds.substring(0, topicFieldIds.length()-2);
		
		if(rowDimFieldIds.length() == 0)
			dimFieldIds = colDimFieldIds;
		else if(colDimFieldIds.length() == 0)
			dimFieldIds = rowDimFieldIds;
		else
			dimFieldIds = rowDimFieldIds+","+colDimFieldIds;
		conditionTransfer.setKey(key);
		conditionTransfer.setValue(value);
		String sql = this.produceSql(conditionTransfer, dimFieldIds, topicFieldIds);

		//修改，直接获取dbproperties的数据源，不在使用数据库中配置数据表信息。
		Connection conn = BIConnection.OpenConn();
		PreparedStatement ps ;
		ResultSet rs ;
		ps = conn.prepareStatement(sql);
		rs = ps.executeQuery();
		ResultSetMetaData rsmd = rs.getMetaData();
		int colCount = rsmd.getColumnCount();//列数量

		List<Map<String, Object>> listdDataMap = new ArrayList<Map<String, Object>>();//数据
		//key_row,key_col,value;
		Map<String, HashMap<String, String>> mapBizdata=new HashMap<String, HashMap<String, String>>();

		//从数据库中查询出来放入map中
		while (rs.next()) {
			Map<String, Object> map = new HashMap<String, Object>();

			for (int i = 1; i <= colCount; i++) {

				if (conditionTransfer.getBlock_type() == 1
						&& (rsmd.getColumnLabel(i).toLowerCase().equals("province")
						|| rsmd.getColumnLabel(i).toLowerCase().equals("city")
						|| rsmd.getColumnLabel(i).toLowerCase().equals("county")))
					map.put(rsmd.getColumnLabel(i).toLowerCase(),
							rs.getObject(i) + "-" + rs.getInt("areaId"));

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
			listdDataMap.add(map);
		}
		
		return listdDataMap;
	}
	
	/**
	 * 通过主题字段id进行生产SQL语句
	 * dimFields       维度
	 * topicFielIds   指标。 liuxf
	 * @author Andot
	 * 
	 * */
	private String produceSql(ConditionTransfer conditionTransfer, String dimFieldIds, String topicFieldIds) throws Exception {


		String join = " ";
		String from = " from ";
		String groupby =  " group by ";
		String where = " where 1=1 ";


		String showTopicFields = "" ;//显示的指标字段
		String showDimFields = ""; //需要显示的维度字段


		/*================获取维度字段===============*/
		List<BIShowField> biShowDimFieldList = biShowEngineDao.getReportDimInfo(dimFieldIds, conditionTransfer.getReport_Id());
		String lastDimTable=null;
		for (int i = 0; i < biShowDimFieldList.size(); i++) {

			BIShowField biShowField = biShowDimFieldList.get(i);

			//判断是否有对应的维度表 add by liuxf
			Integer drillType=biShowField.getDrill_Type();
			groupby+=biShowField.getField_Name()+",";

			if(drillType==null||drillType==0){//如果没有对应的维度表，则直接获取主题表中的维度字段

				showDimFields += biShowField.getTopic_Table() + "." + biShowField.getField_Name() + ",";
				continue;
			}

			switch (drillType) {//分段信息
				case 1:  //DRILL_NONE

					showDimFields += biShowField.getDim_Table() + "." + biShowField.getText_Field() +" AS "+ biShowField.getField_Name()+ ",";

					if(conditionTransfer.getKey().size() > 0){
						for (int j = 0; j < conditionTransfer.getKey().size(); j++) {
							if(conditionTransfer.getValue().get(j).toString().indexOf(",") > -1){
								where += " AND " + conditionTransfer.getKey().get(j) + " IN (" + conditionTransfer.getValue().get(j)+")";
							}else{
								where += " AND " + conditionTransfer.getKey().get(j) + " = " + conditionTransfer.getValue().get(j);
							}
						}
					}
					System.err.println("DRILL_NONE");
					break;
				case 2://DRILL_SEGMENT
					System.err.println("分段");
					break;
				case 3://DRILL_PATH
					System.err.println("钻取");
					//开始钻取条件判断
					String[] areas = biShowField.getDrill_Info().split("-");
					if(conditionTransfer.getDrill_Name() != null){
						int x = (conditionTransfer.getDrill_Value()+"").length()/2;
						for (int j2 = 0; j2 < areas.length; j2++) {
							if(conditionTransfer.getDrill_Name().equals(areas[j2].toLowerCase())){
								showDimFields += biShowField.getDim_Table() + "." + areas[x] + ", " + biShowField.getTopic_Table() + "." + areas[x] + " AS areaId,";
								if(conditionTransfer.getDrill_Value().toString().indexOf(",") > -1){
									where += " AND " + biShowField.getTopic_Table() + "." + conditionTransfer.getDrill_Name() + " IN (" + conditionTransfer.getDrill_Value()+")";
								}else{
									where += " AND " + biShowField.getTopic_Table() + "." + conditionTransfer.getDrill_Name() + "=" + conditionTransfer.getDrill_Value();
								}
								break;
							}
						}
					}else{
						showDimFields += biShowField.getDim_Table() + "." + areas[0] + ", " + biShowField.getTopic_Table() + "." + areas[0] + " AS areaId,";
					}
					break;
			}
			if(i == 0){
				join += " JOIN " + biShowField.getDim_Table() + " ON " +
						biShowField.getTopic_Table() + "." + biShowField.getField_Name() + " = " +
						biShowField.getDim_Table()+ "." + biShowField.getId_Field();
			}else if(lastDimTable==null|| !lastDimTable.equals(biShowField.getDim_Table())){//不是同一个DIM数据表
				join += "\n JOIN " + biShowField.getDim_Table() + " ON " +
						biShowField.getTopic_Table() + "." + biShowField.getField_Name() + " = " +
						biShowField.getDim_Table()+ "." + biShowField.getId_Field();
			}
			lastDimTable=biShowField.getDim_Table();
		}

		showDimFields=trimComma(showDimFields);

		/*================指标===============*/
		List<BIShowField> biShowTopicFieldList = biShowEngineDao.getReportTopicInfo(topicFieldIds, conditionTransfer.getReport_Id());

		if(biShowTopicFieldList.size()==0) {
			throw new Exception("当前主题指标字段为空，请检查配置");
		}

		boolean b = false;
		for (int i = 0; i < biShowTopicFieldList.size(); i++) {
			BIShowField biShowField = biShowTopicFieldList.get(i);

			if(conditionTransfer.getIndex() == null || conditionTransfer.getIndex().equals(biShowField.getField_Id())){
				if(conditionTransfer.getBlock_type() == 1){  //图表类型：为了防止表格，表格只能有一个指标
					if(b) continue;
				}
				showTopicFields += biShowField.getAggregate_Type() + "("+ biShowField.getTopic_Table() + "." +
									biShowField.getField_Name() +") AS "+ biShowField.getField_Caption() +", ";
				b = true;
			}
			if(i == 0){
				from += biShowField.getTopic_Table() + " ";
			}
		}
		showTopicFields=trimComma(showTopicFields);

		//if(showDimFields.length() > 0)//group by 维度；
		//	groupby = " group by " + showDimFields.replace(" AS areaId", "");
		groupby=trimComma(groupby);

		//需要查询的字段，包括所有的维度和指标。
		String showFields = showDimFields + ", " + showTopicFields; //维度  +  指标

		String sql = "select "+ showFields+ from + join + where + groupby +";";
		System.err.println(sql);
		return sql;
	}
    private String trimComma(String source){
		source=source.trim();
		if(source.lastIndexOf(",") > -1)
			return source.substring(0, source.length()-1);
		return source;
	}
	/**
	 * 获取到这个报表的维表中的所有字段作为筛选条件
	 * 
	 * */
	@Override
	public List<String> showDimField(Integer reportId) {
		List<String> list = new ArrayList<String>();
		List<BI_DIM> dimList = dimDao.getDimField(reportId);
		for (BI_DIM bi_DIM : dimList) {
			if(bi_DIM.getBiz_Table_Name().equals("dicarea") || bi_DIM.getBiz_Table_Name().equals("v_dicarea"))
				continue;
			String sql = "SELECT " + bi_DIM.getText_Field() +" FROM " + bi_DIM.getBiz_Table_Name() + " GROUP BY " + bi_DIM.getText_Field()+"; &"+bi_DIM.getDim_Name();
			list.add(sql);
		}
		return list;
	}

}

package cn.zup.bi.service.impl;

import cn.zup.bi.dao.BIShowEngineDao;
import cn.zup.bi.dao.DimDao;
import cn.zup.bi.dao.ReportFieldDao;
import cn.zup.bi.entity.*;
import cn.zup.bi.service.*;
import cn.zup.bi.utils.BIConfig;
import cn.zup.bi.utils.BIConnection;
import cn.zup.framework.json.JsonDateValueProcessor;
import com.mysql.jdbc.RowData;
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

	/*
	* 传入参数:
	* var data={
			bi_Page_Id: pageid,
			screen_Index: screenIndex,
			block_Id: 0,
			key: keys,
			value: values,
			block_Type: 1,
			drill_Name: drill_Name,
			drill_Value: drill_Value
		}
		*
		*
		*
		针对不同的钻取类型（在维度表中dim_table中drill_type），不同的配置如下：

	    1. ---------drill_type=DRILL_TYPE_NONE=1;   NONE-------------
		如: province维度对应的字符串： {山东省,河南省，河北省，山西省}

		2.---------drill_type=int DRILL_TYPE_SEG=2; 分段--------------

		3.---------drill_type=int DRILL_TYPE_PATH=3; 3.路径-----------

			在维度表中dim_table中，drill_info 配置 对应不同的维度字段，例如 province-city-country,表示对应维度表中不同的维度文本信息。
			dim_table 一般配置为  ：area (id ,province,city,country,name)
			构建的colName 如下
			[dim_data -  drill_name]

			example:
			[山东省 -  city] 表示当前需要从province 下转到city[drill_name], 下钻过滤语句为 '山东省'[drill_value ]

			当前的维度 字段序号

		4.---------drill_type=int DRILL_TYPE_DIFF_TOPIC=4;不同主题-----

		  a.维度配置：

		  针对维度字段，如果为不同的主题钻取，则drill_info 设置如下：
		  drill_info :     topicTable1,filterField1  -  topicTable2,filterField2  -  topicTable3,filterField3........
		  example:
		  v_fund_province, parent_code   -   v_fund_city ,province_code  -  v_fund_country  ,city_code.

		  点击山东省，则进行主题[topicTable2]的钻取,  filterField2表示主题的过滤字段。
		  dim_data 是text_code ,filter_condition是id_code.
		  例如 dim_data='山东省'  filter_condition='37'


		  b.根据配置生成前端格式数据。维度数据- 对应主题表

		  [dim_data - dim_name - current_topicTable_index] 分别对应维度数据，维度名字，当前主题表索引

		   --->exmaple  [山东省 - area_dim - 1]

		   dimName  topicTable

		 c.前端接收到维度配置信息
		   利用dim_data展示维度数据，
		   getList(dim_name - current_topic_index,  dim_data) 生成连接进行钻取。

		 d.前端发送请求

		   drill_name---->   dim_name - current_topic_index
		   					维度名称    -  当前主题表索引index；
		   					表示要钻取的维度；主题表索引index=0表示第一个主题表；index=1表示第二个主题表
		   drill_value----> dim_data    当前维度对应的数据值

         e.后台接收后，构建查询语句 例如

	 		 drill_name= 维度名称:主题表索引index； 表示要钻取的维度；主题表索引index=1表示第一个主题表；index=2表示第二个主题表
			 drill_value= 该维度对应的值；
			 后台接收后，构建查询语句 例如
			 drill_name="organ_code-1"
			 drill_value="山东省"
		     drill_info :     topicTable1,filterField1  -  topicTable2,filterField2-topicTable3,filterField3........
			 NextTopicTableIndex=currentTopicTableIndex+1
			 通过dill_info ,NextTopicTableIndex获取  nextTopicTableName,nextFilterFied
			 过滤条件  filter_condition =drill_value=山东省
		  构建子主题查询：
		  select * from  [nextTopicTableName] where  [nextFilterFied]=[filter_condition]

		例如：
		  select * from  [view_city] where  [parent_provice]=[filter_condition]

		  只需要将主题序号插入到客户端就可以了()
	*/
	@Override
	public  List<Map<String, Object>> getBIPageService(V_ReportData vreportData) throws Exception {
		//获取一个页面、一个屏幕上的所有div
		List<Map<String, Object>> listReturnData = new ArrayList<Map<String, Object>>();

		List<BI_REPORT>listBIReport = biReportService.getReportListByPageId(vreportData.getBi_Page_Id(),
				vreportData.getScreen_Index());

		for (BI_REPORT bi_report : listBIReport) {
			Map<String, Object> resultMap = new HashMap<String, Object>();
			//获取div上绑定的报表的数据
			ConditionTransfer conditionTransfer = new ConditionTransfer();
			conditionTransfer.setDrill_Name(vreportData.getDrill_Name());
			conditionTransfer.setDrill_Value(vreportData.getDrill_Value());
			conditionTransfer.setKey(vreportData.getKey());
			conditionTransfer.setValue(vreportData.getValue());
			conditionTransfer.setReport_Id(bi_report.getReport_Id());
			conditionTransfer.setIndex(vreportData.getIndex());
			conditionTransfer.setBlock_type(vreportData.getBlock_Type());

			//1.从数据库中获取报表数据
			List<Map<String, Object>> listDataMap = getReportDataFromDB(conditionTransfer);

			//获取维度与指标数据
			List<BIShowField> dimFieldList = biDimService.getDimFieldList(conditionTransfer);
			List<BIShowField> topicFieldList = biTopicFieldService.getTopicFieldList(bi_report.getReport_Id());

			List<String> topicList = new ArrayList<String>();
			List<String> topicNameList = new ArrayList<String>();
			List<String> topicUnitList = new ArrayList<String>();

			List<String> colDimFields = new ArrayList<String>(); //列维表，包含的维度名字如“省份”，“种类”。 左侧为列维度
			List<String> rowDimFields = new ArrayList<String>(); //行维表  右上为行维度。 by liuxf

			List<BIDimData> BIColDimDatas = new ArrayList<BIDimData>();//列维数据列表
			List<BIDimData> BIRowDimDatas = new ArrayList<BIDimData>();//行维数据列表

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
			钻取方式：
			1.NONE
			2.分段
			3.路径
			4. 主题
			*/
			for (int i = 0; i < dimFieldList.size(); i++) {
				BIShowField dimField = dimFieldList.get(i);

				Map<String, Object> dimTopicTableHeaderMap = new HashMap<String, Object>();//表头
				String dimFieldName = dimField.getField_Name().toLowerCase();
				if (dimField.getField_Location() == BIConfig.FIELD_TYPE.ROW_DIM) {        //针对行维度,  右侧的为行维度。
					/*  加入行数据,生成行维度，例如by liuxf
						dimName=行业种类
						dimValue= 电力/ 服务/水务等
						维度横向生成
					*   电力 服务   水务   。。。。。。
					 */
					if (dimField.getDrill_Type() == null) {
						//加入行维度，加入维度的名字，例如 "行业种类"
						AddDimFieldToList(dimField,rowDimFields, BIRowDimDatas);
						continue;
					}
					if (dimField.getDrill_Type() != BIConfig.DRILL_TYPE.DRILL_TYPE_PATH) {
						AddDimFieldToList(dimField,rowDimFields, BIRowDimDatas);
					} else {
						if (vreportData.getDrill_Name() != null) {
							int lc = (vreportData.getDrill_Value() + "").length() / 2;//如果为6位，则lc=3,表示县级单位，
							String dimSub=dimField.getDrill_Info().split("-")[lc].toLowerCase();
							dimField.setField_Name(dimSub);
							AddDimFieldToList(dimField,rowDimFields, BIRowDimDatas);
						} else {
							String dimSub=dimField.getDrill_Info().split("-")[0].toLowerCase();
							dimField.setField_Name(dimSub);
							AddDimFieldToList(dimField,rowDimFields, BIRowDimDatas);
							rowDimFields.add(dimSub);
						}
					}
					//维度名字，维度序号。
					dimTopicTableHeaderMap.put(dimFieldName, dimFieldList.get(i).getDim_Order());
					dimTopicTableHeader.add(dimTopicTableHeaderMap);
				} else if (dimFieldList.get(i).getField_Location() == BIConfig.FIELD_TYPE.COL_DIM) {
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
					if (dimField.getDrill_Type() == null||
							dimField.getDrill_Type() == BIConfig.DRILL_TYPE.DRILL_TYPE_NONE||
							dimField.getDrill_Type() == BIConfig.DRILL_TYPE.DRILL_TYPE_SEG) {
						AddDimFieldToList(dimField,colDimFields, BIColDimDatas);//列维度
					}
					else if(dimField.getDrill_Type()==BIConfig.DRILL_TYPE.DRILL_TYPE_PATH){
						if (vreportData.getDrill_Name() != null) {
							int lc = (vreportData.getDrill_Value() + "").length() / 2;
							dimField.setField_Name(dimField.getDrill_Info().split("-")[lc].toLowerCase());
							AddDimFieldToList(dimField,colDimFields, BIColDimDatas);

						} else {
							dimField.setField_Name(dimField.getDrill_Info().split("-")[0].toLowerCase());
							AddDimFieldToList(dimField,colDimFields, BIColDimDatas);
						}
					}
					else if(dimField.getDrill_Type()==BIConfig.DRILL_TYPE.DRILL_TYPE_DIFF_TOPIC){//主题表
						AddDimFieldToList(dimField,colDimFields, BIColDimDatas);
						//drill_name 主题表 drill_value 过滤值  形成过滤条件 where dimFieldName=Drill_value

					}
				}
			}

			//业务数据转换洗
			if (vreportData.getBlock_Type() == BIConfig.BLOCK_TYPE.TABLE) {//数据表格

				//--------------4.创建列维度数据集合。-------------------------
				for (Map<String, Object> map : listDataMap) {
					for (int i = 0; i < colDimFields.size(); i++) {
						List<String> listData = BIColDimDatas.get(i).getListData();
						String value = map.get(colDimFields.get(i)).toString();
						if (!listData.contains(value))//value表示某个维度包含的具体业务数据，例如维度为province ,则 value 为山东省，河南省，山西省......
							listData.add(value);
					}
				}
				//----------5.创建行维度数据集合（一个元素代表一个维度）-------------
				for (Map<String, Object> map : listDataMap) {
					for (int i = 0; i < rowDimFields.size(); i++) {
						List<String> listData = BIRowDimDatas.get(i).getListData();
						String value = map.get(rowDimFields.get(i)).toString();//
						if (!listData.contains(value))//value表示该维度包含的具体业务数据，例如维度为province ,则 value 为山东省，河南省，山西省......
							listData.add(value);
					}
				}

				/*
				3.创建指标数据
				数据格式：
				列维 行维    数据格式  <"2017-集体-云南省", "494">    指标数据
				*/
				Map<String, String> mapIndicatorData = new HashMap<String, String>();

				for (Map<String, Object> map : listDataMap) {//获取数据

					String xkey = "", xvalue = "", // 数据格式  <"2017-集体-云南省", "494">
							rowK = "", //xkey=rowK_colK; 行维度_列维度
							colK = "",
							valK = "";

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
					xkey = trimComma(colK + "" + rowK,",");
					xvalue =  trimComma(valK,",");
					mapIndicatorData.put(xkey, xvalue);  // 数据格式  <"2017-集体-云南省", "494">
				}

				//---------------------开始创建展示表格-----------------------
				/*
				* 6.创建表头。这个应该是我写的，我自己看了半天,需要注释。  liuxf
				* row1   山东 山东 山东
				* row2    集体 私有  国家
				*/
				List<List<String>> listRowHeader = new ArrayList<List<String>>();
				int allColsCount = 1;  //需要展示的列数
				//获取每个维度的数据 如维度1，4个数据；维度2，3个数据，则生成12列数据
				for (int i = 0; i < BIRowDimDatas.size(); i++) {
					allColsCount *= BIRowDimDatas.get(i).getListData().size();
				}
				int loopCount = allColsCount;//重复次数,表示当前维度每个维度数据包含的列数

				for (int i = 0; i < BIRowDimDatas.size(); i++) {//生成 行表头
					List<String> listRowCell = new ArrayList<String>();//  表示一行数据，

					loopCount /= BIRowDimDatas.get(i).getListData().size();


					int dataIndex = 0; //当前显示列对应的数据索引

					int currentColCnt = 0;
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
					listRowHeader.add(listRowCell);
				}


				//7.创建单元格，填充数据。递归遍历，获取对应的行数据维度。列数据维度。
				String colsNames = "";
				List<String> listRows = new ArrayList<String>();
				GeneTableRows(0, BIColDimDatas, colsNames, BIColDimDatas.size(), listRows);

				String rowsNames = "";
				List<String> listCols = new ArrayList<String>();  //循环遍历行
				GeneTableCols(0, BIRowDimDatas, rowsNames, BIRowDimDatas.size(), listCols);

				//8.向生成的单元格里设置业务数据
				List<List<String>> listRowData = new ArrayList<List<String>>();

				if(listRows.size()==0) {//没有列维度，则不会生成行数.只有一行数据。
				  listRows.add("");
				}
				if(listCols.size()==0){//没有行维度，则只有一列数据
					listCols.add("");
				}
				int[] arrColDataCount=new int[listCols.size()];
				for (int i = 0; i < listRows.size(); i++) {

					String rowDatas = listRows.get(i);//行数据  维度1，维度2，值1 ，值2 ，值3.........
					if(rowDatas.length()>0)
						rowDatas+=",";
					int rowDataCount=0;//测试本行数据有效条数，如果==0说明没有数据
					for (int j = 0; j < listCols.size(); j++) {
						String keyName ="";
						if(listRows.size()>1)//如果只有一行数据，说明没有列维度
							keyName+=listRows.get(i);
						if(listCols.size()>1) {//如果只有一列数据，说明没有行维度
							keyName+=keyName.length()>0?"," + listCols.get(j):listCols.get(j);
						}

						if (mapIndicatorData.containsKey(keyName)) {
							rowDatas += mapIndicatorData.get(keyName);
							rowDataCount++;
							arrColDataCount[j]++;
						} else {
							rowDatas += "";
						}
						rowDatas += ",";
					}
					if(rowDataCount>0) {//本行数据有效
						rowDatas=trimComma(rowDatas,",");
						List<String> rowValueList = new ArrayList<String>();
						rowValueList.addAll(Arrays.asList(rowDatas.split(",")));
						listRowData.add(rowValueList);
					}
				}
				//判断列数据是否有效,无效的进行删除  2020.3.23 by liuxf
				int row=0;
				int dimColCount=colDimFields.size();
				for(int j=arrColDataCount.length-1;j>=0;j--){//删除无效列，一定要从后向前删除
					if(arrColDataCount[j]==0){
						//删除header对应的列信息
						for(row=0;row<listRowHeader.size();row++) {
							listRowHeader.get(row).remove(j);
						}
						//删除数据对应的列信息
						for(row=0;row<listRowData.size();row++) {
							int index=j+dimColCount;
							if(listRowData.get(row).size()-1>=index)
								listRowData.get(row).remove(index);
						}
					}
				}
				resultMap.put("tableData", listRowData);
				resultMap.put("dimFieldHeader", listRowHeader);
			}else {
				resultMap.put("data", listDataMap);
			}

			//获取报表信息
			JsonConfig jsonConfig = new JsonConfig();
			jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor("yyyy-MM-dd HH:mm:ss"));
			JSONObject jsonArray = JSONObject.fromObject(bi_report, jsonConfig);
			resultMap.put("reportInfo", jsonArray);

			resultMap.put("dimHeader", rowDimFields);//行维度
			resultMap.put("topicField", topicList);
			colDimFields.removeAll(rowDimFields);
			resultMap.put("dimField", colDimFields);

			resultMap.put("topicFieldName", topicNameList);
			resultMap.put("unit", topicUnitList);
			resultMap.put("flList", dimTopicTableHeader);

			//下发具体维度信息，便于钻取
			resultMap.put("BIColDimDatas",BIColDimDatas);
			resultMap.put("BIRowDimDatas",BIRowDimDatas);

			listReturnData.add(resultMap);
		}

		return  listReturnData;
	}

	/*
	添加维度到列表
	BIShowField  dimField,  维度字段
	List<String> dimFields,  维度列表  行维度列表/列维度列表  用来传送到前端
	List<BIDimData> BIColDimDatas  维度列表 包含了每个维度的具体信息一级对应的数据 ，
	 */
	void AddDimFieldToList(BIShowField  dimField, List<String> dimFields, List<BIDimData> BIColDimDatas ){
		String dimFieldName=dimField.getField_Name().toLowerCase();
		dimFields.add(dimFieldName);
		BIDimData dimData=new BIDimData();
		dimData.setDrill_Type(dimField.getDrill_Type());
		dimData.setField_Name(dimFieldName);
		dimData.setListData(new ArrayList<String>());
		BIColDimDatas.add(dimData);
	}
	/*
	帮助参见readme.md文件 cn.zup.bi.readme.md。
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
			 * 山西省
			 * ...
	 * colsNames 一行的列维，如: province维度对应的字符串： {山东省,河南省，河北省，山西省}
	 * colSize  列维的数量

	 * listRows 生成的数据行数  [返回数据]

	  colNames  为列维度信息的组合  维度1，维度2，维度3，.......
	  建设维度1为province，则对应的字符串： {山东省,河南省，河北省，山西省}


	 */
	private void GeneTableRows(int dimCol, List<BIDimData> BIColDimDatas , String colsNames, int colSize, List<String> listRows) {
		if(BIColDimDatas != null && BIColDimDatas.size() > 0){
			List<String> listData = BIColDimDatas.get(dimCol).getListData();

			if(dimCol == colSize-1){
				for(int j=0;j<listData.size();j++) {

					String mycolNames =  colsNames==""?	listData.get(j): colsNames+","+listData.get(j);
					listRows.add(mycolNames);
				}
			} else{
				dimCol++;
				for(int j=0;j<listData.size();j++) {

					String mycolNames =  colsNames==""?	listData.get(j): colsNames+","+listData.get(j);
					//获取下一列的维度数据
					GeneTableRows(dimCol, BIColDimDatas, mycolNames, colSize, listRows);
				}
			}
		}
	}

	/**
	 * 根据行维度生成列信息,返回值为listCols，为总共要生成的列的数量，每列的信息格式为  dim1name,dim2name,dim3name,....
	 * 例如行维度为 类型（饮料 膨化食品 矿泉水），品牌（可口可乐 哇哈哈），
	 * 则格式为
	 *   第一列			| 第二列			|第三列				|。。。。。。
	 * 饮料，可口可来    | 饮料，哇哈哈    |膨化食品，可口可乐，

	 */

	private void GeneTableCols(int dimRow, List<BIDimData> BIRowDimDatas , String rowsNames, int rowSize, List<String> listCols) {
		if(BIRowDimDatas != null && BIRowDimDatas.size() > 0) {
			List<String> listData = BIRowDimDatas.get(dimRow).getListData();
			if (dimRow == rowSize - 1) {
				for (int j = 0; j < listData.size(); j++) {
					String myrowNames =  rowsNames==""?	listData.get(j): rowsNames+","+listData.get(j);
					listCols.add(myrowNames);
				}
			} else {
				dimRow++;
				for (int j = 0; j < listData.size(); j++) {
					String myrowNames =  rowsNames==""?	listData.get(j): rowsNames+","+listData.get(j);
					GeneTableCols(dimRow, BIRowDimDatas, myrowNames, rowSize, listCols);//递归生成下一个维度的数据
				}
			}
		}
	}

	private List<Map<String, Object>> getReportDataFromDB(ConditionTransfer conditionTransfer) throws Exception {


		//1.获取报表中的字段，判断行维度，列维度，指标字段
		String dimFieldIds = "";//维度字段（行维度+列维度）
		String rowDimFieldIds = "";  //行维度字段
		String colDimFieldIds = "";  //列维度字段
		String topicFieldIds = "";   //指标字段
		List<BI_REPORT_FIELD> reportFieldList = reportFieldDao.getReportFieldByReportId(conditionTransfer.getReport_Id());
		for (int i = 0; i < reportFieldList.size(); i++) {//第一步遍历获取到对应的主题字段，分为维表和指标
			if(reportFieldList.get(i).getField_Location() == BIConfig.FIELD_TYPE.ROW_DIM){
				rowDimFieldIds += reportFieldList.get(i).getField_Id()+", ";
			}else if(reportFieldList.get(i).getField_Location() == BIConfig.FIELD_TYPE.COL_DIM){
				colDimFieldIds += reportFieldList.get(i).getField_Id()+", ";
			}else if(reportFieldList.get(i).getField_Location() == BIConfig.FIELD_TYPE.INDICATOR){
				topicFieldIds += reportFieldList.get(i).getField_Id()+", ";
			}
		}

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

		List<String> key = new ArrayList<String>(conditionTransfer.getKey());
		List<Object> value = new ArrayList<Object>(conditionTransfer.getValue());
		conditionTransfer.setKey(key);
		conditionTransfer.setValue(value);
		String sql = this.produceSql(conditionTransfer, dimFieldIds, topicFieldIds);

		//修改，直接获取dbproperties的数据源，不在使用数据库中配置数据表信息。
		PreparedStatement ps = BIConnection.OpenConn().prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		ResultSetMetaData rsmd = rs.getMetaData();
		int colCount = rsmd.getColumnCount();//列数量
		List<Map<String, Object>> listDataMap = new ArrayList<Map<String, Object>>();//数据
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
			listDataMap.add(map);
		}
		
		return listDataMap;
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

		String topicTableName="";
		String topicTableNameTemp="?";


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
				case BIConfig.DRILL_TYPE.DRILL_TYPE_NONE:  //DRILL_NONE

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
				case BIConfig.DRILL_TYPE.DRILL_TYPE_SEG://DRILL_SEGMENT
					System.err.println("分段");
					break;
				case BIConfig.DRILL_TYPE.DRILL_TYPE_PATH://DRILL_PATH
					System.err.println("钻取");
					/*comment by liuxf
					DRILL_PATH 按照路径进行钻取。
					drill_name 为city,针对city 对应的drill_value 为具体的城市编码 入3101济南；drill_value 针对drill_name具体编码.

					drill_name =province  drill_value=37 山东省
					drill_name =city  drill_value=3701 济南市
					drill_name =country  drill_value=370101 历下区
					drill_info 钻取信息，对应的维度表字段province-city-country，分别对应drill_name。通过传递过来的drill_name,判断
					钻取到的位置。

					通过drill_value进行定位。
					2字节--> province
					4字节---> city
					6字节--> contry

					int x = (conditionTransfer.getDrill_Value()+"").length()/2;
					x表示索引  1  2   3

					例如：
					<--1-->drill_name=provice ,形成以下语句：
					drill_value=37
					x==(conditionTransfer.getDrill_Value()+"").length()/2    =   1
					areas[x=1]==city.
					showDimFields=   dd_area.city,biz_table.city as areaId,
					where=           biz_table.provice in(37)   形成过滤语句。

					<--2-->drill_name=null，默认取dill_info的第一个字段
					showDimFields=   dd_area.province,biz_table.province as areaId,

					*/
					String[] areas = biShowField.getDrill_Info().split("-");// id1-id2-id3？是这样吗 province-city-country
					if(conditionTransfer.getDrill_Name() != null){
						int x = (conditionTransfer.getDrill_Value()+"").length()/2;
						//drill_name 为provice |city|country，
						for (int j2 = 0; j2 < areas.length; j2++) {
							if(conditionTransfer.getDrill_Name().equals(areas[j2].toLowerCase())){

								//例如dd_area.city,biz_table.city as areaId,
								showDimFields += biShowField.getDim_Table() + "." + areas[x] + ", " +
										biShowField.getTopic_Table() + "." + areas[x] + " AS areaId,";
								// biz_table.city in( 3701)
								if(conditionTransfer.getDrill_Value().toString().indexOf(",") > -1){
									where += " AND " + biShowField.getTopic_Table() + "." + conditionTransfer.getDrill_Name() +
											" IN (" + conditionTransfer.getDrill_Value()+")";
								}else{
									where += " AND " + biShowField.getTopic_Table() + "." + conditionTransfer.getDrill_Name()
											+ "=" + conditionTransfer.getDrill_Value();
								}
								break;
							}
						}
					}else{
						//表示字段从第一个开始 ，例如 province-city-country ； 取第一个。 dd_area.province, topictale.province
						showDimFields += biShowField.getDim_Table() + "." + areas[0] + ", " + biShowField.getTopic_Table() + "." + areas[0] + " AS areaId,";
					}
					break;
				case BIConfig.DRILL_TYPE.DRILL_TYPE_DIFF_TOPIC://不同主题


					showDimFields += biShowField.getDim_Table() + "." + biShowField.getText_Field() +" AS "+ biShowField.getField_Name()+ ",";

					/*
					 drill_name= 维度名称:主题表索引index； 表示要钻取的维度；主题表索引index=1表示第一个主题表；index=2表示第二个主题表
					 drill_value= 该维度对应的值；
					 后台接收后，构建查询语句 例如
					 drill_name="organ_code-1"
					 drill_value="山东省"

					 drill_info :     topicTable1,filterField1  -  topicTable2,filterField2-topicTable3,filterField3........
					 NextTopicTableIndex=currentTopicTableIndex+1
					 通过dill_info ,NextTopicTableIndex获取  nextTopicTableName,nextFilterFied
					 过滤条件  filter_condition =drill_value=山东省
					 构建子主题查询：
					  select * from  [nextTopicTableName] where  [nextFilterFied]=[filter_condition]

					  例如：
					  select * from  [view_city] where  [parent_provice]=[filter_condition]
					*/
					String[] topoicTables = biShowField.getDrill_Info().split("-");
					if(conditionTransfer.getDrill_Name()==null){
						break;
					}
					String []arrDrillName=conditionTransfer.getDrill_Name().split("-");
					if(arrDrillName.length<=1)
						break;
					String drillDimName=arrDrillName[0];
					int topicTableIndex=Integer.parseInt(arrDrillName[1])+1;//报表索引
					if(drillDimName == biShowField.getField_Name() ) {
						String []arrtopicTable=topoicTables[topicTableIndex].split(",");
						topicTableName=arrtopicTable[0];
						String filterName=arrtopicTable[1];
						//形成过滤语句
						where += " AND " + topicTableNameTemp + "." + filterName
								+ "=" + conditionTransfer.getDrill_Value();
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

		showDimFields=trimComma(showDimFields,",");

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
				if(biShowField.getAggregate_Type()==null)
					throw new  Exception(String.format("biShowField指标 %s 没有设置聚合字符，如count sum 等",biShowField.getField_Name()));
				String AggregateType=trimComma(biShowField.getAggregate_Type(),"_"); //
				showTopicFields +=  AggregateType + "("+ biShowField.getTopic_Table() + "." +
									biShowField.getField_Name() +") AS "+ biShowField.getField_Caption() +", ";
				if(biShowField.getAggregate_Type()==null){
					throw new Exception("显示字段Aggregate_Type为空，请检查配置,语句:<!--"+showTopicFields+"-->");
				}
				b = true;
			}
			if(i == 0){
				from += biShowField.getTopic_Table() + " ";
			}
		}
		showTopicFields=trimComma(showTopicFields,",");

		//if(showDimFields.length() > 0)//group by 维度；
		//	groupby = " group by " + showDimFields.replace(" AS areaId", "");
		groupby=trimComma(groupby,",");

		//需要查询的字段，包括所有的维度和指标。
		String showFields = showDimFields + ", " + showTopicFields; //维度  +  指标

		String sql = "select "+ showFields+ from + join + where + groupby +";";
		if(topicTableName!=""){
			sql=sql.replace("？",topicTableName);
		}
		System.err.println(sql);
		return sql;
	}
    private String trimComma(String source,String comma){
		source=source.trim();
		if(source.lastIndexOf(comma) > -1)
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

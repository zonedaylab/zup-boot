package cn.zup.bi.service.impl;

import cn.zup.bi.dao.BIShowEngineDao;
import cn.zup.bi.dao.DimDao;
import cn.zup.bi.entity.*;
import cn.zup.bi.service.*;
import cn.zup.bi.utils.BIConfig;
import cn.zup.framework.json.JsonDateValueProcessor;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.*;
import java.math.BigDecimal;
import java.sql.*;
import java.util.*;
import java.util.Date;


@Service("biShowEngineService")
public class BIShowEngineServiceImpl implements BIShowEngineService {

	@Autowired
	private BIShowEngineDao biShowEngineDao;
	@Autowired
	private DimDao dimDao;
	@Resource
	private BIDimService biDimService;
	@Resource
	private TopicFieldService biTopicFieldService;
	@Resource
	private ReportService biReportService;
	@Resource
	private BIPageService biPageService;
	@Autowired
	JdbcTemplate jdbcTemplate_bidata;

	List<BIShowField> m_biDimFieldList;
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
		针对不同的钻取类型（在维度表中dim_table中drill_type），参见Readme.md.

	*/

	@Override
	//获取一个页面、一个屏幕上的所有div
	public  List<Map<String, Object>> getBIPageService(V_ReportData vreportData) throws Exception {

		/*------------------------------------------------------------------------
		*
		* 1.获取所有的报表
		*
		* 需要修改：获取Biz_Table_Name
		* */

		List<BI_REPORT>listBIReport = biReportService.getReportListByPageId(vreportData.getBi_Page_Id(),
				vreportData.getScreen_Index());
		if(listBIReport.size()==0)
			throw new  Exception("报表没有配置，请检查配置。bi_page_id=" +vreportData.getBi_Page_Id());

		/*--------------------------------------------------------------------
		*
		* 2.获取维度配置信息
		*
		* */

		Integer reportID=listBIReport.get(0).getReport_Id();

		//获取维度与指标数据
		m_biDimFieldList = biDimService.getDimFieldList(vreportData,reportID);

		List<BIShowField> measureFieldList = biTopicFieldService.getTopicFieldList(reportID);


		List<Map<String, Object>> listDataMap = getReportDataFromDB(vreportData,listBIReport.get(0));//1.从数据库中获取报表数

		if(listDataMap.size()==0)
			throw new Exception("报表查询业务数据为空，请检查配置,bi_page_id="+vreportData.getBi_Page_Id()+";reportID="+reportID);


		List<String> measureCaptionList = new ArrayList<String>();
		List<String> measureUnitList = new ArrayList<String>();

		//列维表，包含的维度名字如“省份”，“种类”。 左侧为列维度
		List<BIDimData> BIColDimDatas = new ArrayList<BIDimData>();//列维数据列表
		List<BIDimData> BIRowDimDatas = new ArrayList<BIDimData>();//行维数据列表


		for (BIShowField biShowField : measureFieldList) {
			measureCaptionList.add(biShowField.getField_Caption().toLowerCase());//度量别名， select  as caption之意也
			measureUnitList.add(biShowField.getField_Unit()); //指标单位
		}

		/*2.1.获取维度对应的成员信息
		钻取方式：1.NONE		2.分段		3.路径		4. 主题
		*/
		for (int i = 0; i < m_biDimFieldList.size(); i++) {
			BIShowField dimField = m_biDimFieldList.get(i);

			if (dimField.getField_Location() == BIConfig.FIELD_TYPE.ROW_DIM) {        //针对行维度,  右侧的为行维度。
				/*  加入行数据,生成行维度，例如by liuxf
					dimName=行业种类
					dimValue= 电力/ 服务/水务等
					维度横向生成
				*   电力 服务   水务   。。。。。。
				 */

				AddDimFieldToList(dimField,vreportData, BIRowDimDatas);

			}
			else if (m_biDimFieldList.get(i).getField_Location() == BIConfig.FIELD_TYPE.COL_DIM) {
				/*
				 * 列维度
				 * 例如 dimName="省份" dimValue=山东省/河南省/....     纵向排列：
				 * 山东省
				 * 河南省
				 * 河北省
				 * ......
				 * */
				AddDimFieldToList(dimField, vreportData,BIColDimDatas);//列维度
			}
		}

		//----------4.创建行维度数据集合（一个元素代表一个维度）-------------
		for (Map<String, Object> map : listDataMap) {
			for (int i = 0; i < BIRowDimDatas.size(); i++) {
				List<String> listData = BIRowDimDatas.get(i).getListData();
				if(map.get(BIRowDimDatas.get(i).getField_Name())!=null) {
					String value = map.get(BIRowDimDatas.get(i).getField_Name()).toString();//
					if (!listData.contains(value))//value表示该维度包含的具体业务数据，例如维度为province ,则 value 为山东省，河南省，山西省......
						listData.add(value);
				}
				List<String> listDataCode = BIRowDimDatas.get(i).getListDataCode();
				if(map.get(BIRowDimDatas.get(i).getFieldNameCode())!=null) {
					String value = map.get(BIRowDimDatas.get(i).getFieldNameCode()).toString();//
					if (!listDataCode.contains(value))//value表示该维度包含的具体业务数据，例如维度为province ,则 value 为山东省，河南省，山西省......
						listDataCode.add(value);
				}



			}
		}
		//--------------5.创建列维度数据集合。-------------------------
		for (Map<String, Object> map : listDataMap) {
			for (int i = 0; i < BIColDimDatas.size(); i++) {
				List<String> listData = BIColDimDatas.get(i).getListData();
				if(map.get(BIColDimDatas.get(i).getField_Name())!=null) {
					String value = map.get(BIColDimDatas.get(i).getField_Name()).toString();
					if (!listData.contains(value))//value表示某个维度包含的具体业务数据，例如维度为province ,则 value 为山东省，河南省，山西省......
						listData.add(value);
				}
				List<String> listDataCode = BIColDimDatas.get(i).getListDataCode();
				if(map.get(BIColDimDatas.get(i).getFieldNameCode())!=null) {
					String value = map.get(BIColDimDatas.get(i).getFieldNameCode()).toString();
					if (!listDataCode.contains(value))//value表示某个维度包含的具体业务数据，例如维度为province ,则 value 为山东省，河南省，山西省......
						listDataCode.add(value);
				}
			}
		}

		/*--------------------------------------------------------------------------------
		3.创建度量数据
		前提：一个页面包含多个报表，每个报表的维度完全一样。

		列维 行维    数据格式
		<"2017,集体,云南省", "report1-value;report2-value;report3-value">
		<"2017,集体,云南省", "494;492">

		 */
		Map<String, String[]> mapMeasureData = new HashMap<String, String[]>();
		for (int reportIndex=0;reportIndex<listBIReport.size();reportIndex++) {

			BI_REPORT bi_report =listBIReport.get(reportIndex);
			List<Map<String, Object>> listDataMapTemp = getReportDataFromDB(vreportData, bi_report);//1.从数据库中获取报表数据

			if (vreportData.getBlock_Type() == BIConfig.BLOCK_TYPE.TABLE) {//数据表格

				for (Map<String, Object> map : listDataMapTemp) {//获取数据

					String xkey = "",
							xvalue = "", // 数据格式  <"2017-集体-云南省", "494">
							rowKey = "", //xkey=rowK_colK; 行维度_列维度
							colKey = "",
							measureKey = ""; //对应的度量数据

					for (int i = 0; i < BIColDimDatas.size(); i++) {   //判断是否为列
						if (map.containsKey(BIColDimDatas.get(i).getField_Name()))
							colKey += map.get(BIColDimDatas.get(i).getField_Name()) + ",";
					}
					for (int i = 0; i < BIRowDimDatas.size(); i++) { //判断是否为行维
						if (map.containsKey(BIRowDimDatas.get(i).getField_Name()))
							rowKey += map.get(BIRowDimDatas.get(i).getField_Name()) + ",";
					}
					for (int i = 0; i < measureCaptionList.size(); i++) { //判断是否为度量值
						if (map.containsKey(measureCaptionList.get(i)))
							measureKey += map.get(measureCaptionList.get(i)) + ",";
					}
					xkey = trimComma(colKey + "" + rowKey, ",");
					xvalue = trimComma(measureKey, ",");
					String []measures;//度量值
					if(mapMeasureData.containsKey(xkey)){
						measures=mapMeasureData.get(xkey);
						measures[reportIndex] = xvalue;
						mapMeasureData.replace(xkey, measures);
					}else{
						measures=new String[listBIReport.size()];
						Arrays.fill(measures,"");
						measures[reportIndex]=xvalue;
						mapMeasureData.put(xkey,measures);  // 数据格式  <"2017-集体-云南省", "494;495;456">
					}

				}
			}
		}


		/*---------------------------------------------------------
		 *4. 开始创建展示表格--
		 * 4.1.创建表头。这个应该是我写的，我自己看了半天,需要注释。  liuxf
		 * row1   山东 山东 山东
		 * row2    集体 私有  国家
		 */

		/*
		*	生成结果： dim1_m1表示维度dim1的成员m1。
		*   行维度1：  dim1_m1 dim1_m1 dim1_m1  dim1_m2 dim1_m2  dim1_m2
		*   行维度2：  dim2_m1 dim2_m2 dim2_m3  dim2_m1 dim2_m2  dim2_m3
		* */
		List<List<String>> listTableHeader = new ArrayList<List<String>>(); //根据行维度生成表头

		int allColsCount = 1;  //需要展示的列数，如上所示，则为2*3=6列
		//获取每个维度的数据 如维度1，4个数据；维度2，3个数据，则生成12列数据
		for (int i = 0; i < BIRowDimDatas.size(); i++) {
			allColsCount *= BIRowDimDatas.get(i).getListData().size();
		}
		int loopCount = allColsCount;//重复次数,表示当前维度每个维度数据包含的列数

		for (int i = 0; i < BIRowDimDatas.size(); i++) {//生成 行表头
			List<String> listRowCell = new ArrayList<String>();//  表示一行数据，

			if(BIRowDimDatas.get(i).getListData().size()==0)
				throw new Exception(BIRowDimDatas.get(i).getField_Name()  + "维度没有数据成员，");
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
			listTableHeader.add(listRowCell); 		//一行代表一个维度
		}


		//4.2.创建单元格，填充数据。递归遍历，获取对应的行数据维度。列数据维度。
		String colsNames = "";
		List<String> listRows = new ArrayList<String>();   //列维度生成行数据(维度成员) listColDimMembers
		GeneTableRows(0, BIColDimDatas, colsNames, BIColDimDatas.size(), listRows);

		String rowsNames = "";
		List<String> listCols = new ArrayList<String>();  //循环遍历行  listRowDimMembers
		GeneTableCols(0, BIRowDimDatas, rowsNames, BIRowDimDatas.size(), listCols);


		int reportCount=listBIReport.size();//报表数量
		//4.3.向生成的单元格里设置业务数据
		List<List<String>> listTableData = new ArrayList<List<String>>();

		if(listRows.size()==0) {//没有列维度，则不会生成行数.只有一行数据。
			listRows.add("");
		}
		if(listCols.size()==0){//没有行维度，则只有一列数据
			listCols.add("");
		}
		int[] arrColDataCount=new int[listCols.size()*reportCount];//度量数据的列数,横向平铺
		for (int i = 0; i < listRows.size(); i++) {
			String rowDatas = listRows.get(i);//行数据  维度1，维度2，值1 ，值2 ，值3.........
			if(rowDatas.length()>0)
				rowDatas+=",";
			int rowDataCount=0;//测试本行数据有效条数，如果==0说明没有数据，进行删除。

			for(int reportIndex=0;reportIndex<reportCount;reportIndex++) {
				for (int j = 0; j < listCols.size(); j++) {
					String keyName = "";
					//此处有问题。可能就是只有一行数据.应该通过BIColDimDatas.size()>0解决  by liuxf 20200703
					//if (listRows.size() >= 1
					if (BIColDimDatas.size()>0)//如果只有一行数据，说明没有列维度.此处有问题。可能就是只有一行数据
						keyName += listRows.get(i);
					//listCols.size() >= 1 同理
					if ( BIRowDimDatas.size()>0) {//如果只有一列数据，说明没有行维度
						keyName += keyName.length() > 0 ? "," + listCols.get(j) : listCols.get(j);
					}
					if (mapMeasureData.containsKey(keyName)) {
						String strValue =  mapMeasureData.get(keyName)[reportIndex];
						rowDatas += strValue;
                        if(!strValue.equals("")) {
                            rowDataCount++;
                            arrColDataCount[reportIndex * listCols.size() + j]++;
                        }
					} else {
						rowDatas += "";
					}
					rowDatas += ",";
				}
			}

			if(rowDataCount>0) {//本行数据有效
				rowDatas=trimComma(rowDatas,",");
				List<String> rowValueList = new ArrayList<String>();
				rowValueList.addAll(Arrays.asList(rowDatas.split(",")));
				listTableData.add(rowValueList);
			}
		}

		//根据报表数量扩展行维度的列数
		List<List<String>> listTableHeaderBak = deepCopy(listTableHeader);
		for (int i=1;i<reportCount;i++){
			for(int j = 0; j< listTableHeader.size(); j++)
				listTableHeaderBak.get(j).addAll(listTableHeader.get(j));
		}
		listTableHeader=listTableHeaderBak;

		List<String>listTableHeaderTitle=new ArrayList<String>();
		for (int i=0;i<reportCount;i++){
			for(int j=0;j<allColsCount;j++){
				listTableHeaderTitle.add(listBIReport.get(i).getReport_Name());
			}
		}
		listTableHeader.add(listTableHeaderTitle);

		//判断列数据是否有效,无效的进行删除  2020.3.23 by liuxf
		int row=0;
		int dimColCount=BIColDimDatas.size();
		for(int j=arrColDataCount.length-1;j>=0;j--){//删除无效列，一定要从后向前删除
			if(arrColDataCount[j]==0){
				//删除header对应的列信息
				for(row=0; row< listTableHeader.size(); row++) {
					listTableHeader.get(row).remove(j);
				}
				//删除数据对应的列信息
				for(row=0;row<listTableData.size();row++) {
					int index=j+dimColCount;
					if(listTableData.get(row).size()-1>=index)
						listTableData.get(row).remove(index);
				}
			}
		}
		Map<String, Object> resultMap = new HashMap<String, Object>();
		JsonConfig jsonConfig = new JsonConfig(); //报表信息
		jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor("yyyy-MM-dd HH:mm:ss"));
		JSONObject jsonArray = JSONObject.fromObject(listBIReport.get(0), jsonConfig);
		resultMap.put("reportInfo", jsonArray);

		//下发具体维度信息，便于钻取
		resultMap.put("BIRowDimDatas",BIRowDimDatas);
		resultMap.put("BIColDimDatas",BIColDimDatas);

		resultMap.put("tableHeader", listTableHeader);
		resultMap.put("tableData", listTableData);
		resultMap.put("unit", measureUnitList); //指标数据：单位信息

		List<Map<String, Object>> listData = new ArrayList<Map<String, Object>>();
		listData.add(resultMap);
		return  listData;
	}

	//深度复制函数
	public static <T> List<T> deepCopy(List<T> src) throws IOException, ClassNotFoundException, IOException {
		ByteArrayOutputStream byteOut = new ByteArrayOutputStream();
		ObjectOutputStream out = new ObjectOutputStream(byteOut);
		out.writeObject(src);
		ByteArrayInputStream byteIn = new ByteArrayInputStream(byteOut.toByteArray());
		ObjectInputStream in = new ObjectInputStream(byteIn);
		@SuppressWarnings("unchecked")
		List<T> dest = (List<T>) in.readObject();
		return dest;
	}
	/*
	添加维度到列表
	BIShowField  dimField,  维度字段
	List<String> dimFields,  维度列表  行维度列表/列维度列表  用来传送到前端
	List<BIDimData> BIDimDatas  维度列表 包含了每个维度的具体信息一级对应的数据 ，
	 */
	void AddDimFieldToList(BIShowField  dimField, V_ReportData reportData, List<BIDimData> BIDimDatas ){
		String dimFieldName=dimField.getField_Name().toLowerCase();
		BIDimData dimData=new BIDimData();
		dimData.setDrill_Type(dimField.getDrill_Type());
		dimData.setField_Name(dimFieldName);
		dimData.setListData(new ArrayList<String>());
		dimData.setListDataCode(new ArrayList<String>());
		dimData.setCurrentReportIndex(dimField.getCurrentShowReportIndex());

		if(dimField.getDrill_Type()!=null) {

			if (dimField.getDrill_Type() == BIConfig.DRILL_TYPE.DRILL_TYPE_PATH) {//
				if (reportData.getDrill_Name() != null) {
					int lc = (reportData.getDrill_Value() + "").length() / 2;
					dimField.setField_Name(dimField.getDrill_Info().split("-")[lc].toLowerCase());
				} else {
					dimField.setField_Name(dimField.getDrill_Info().split("-")[0].toLowerCase());

				}
			} else if (dimField.getDrill_Type() == BIConfig.DRILL_TYPE.DRILL_TYPE_DIFF_TOPIC) {//主题表  不同主题的钻取
				dimData.setCurrentReportIndex(dimData.getCurrentReportIndex() + 1);
			}
		}
		BIDimDatas.add(dimData);
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


	/*
	* map 为一条数据记录。格式 字段1：value1；字段2：value2....
	* */

	private List<Map<String, Object>> getReportDataFromDB(V_ReportData reportData,BI_REPORT biReport)  throws Exception {

		//1.获取报表中的字段，判断行维度，列维度，指标字段
		List<String> key = new ArrayList<String>(reportData.getKey());
		List<Object> value = new ArrayList<Object>(reportData.getValue());
		reportData.setKey(key);
		reportData.setValue(value);
		Connection conn=jdbcTemplate_bidata.getDataSource().getConnection();
		List<Map<String, Object>> listDataMap = new ArrayList<Map<String, Object>>();//数据
		try {
            ResultSet rs=null;
            DatabaseMetaData meta = conn.getMetaData();
            // 第一个参数catalog在MySQL中对应数据库名：
            ResultSet rsTables = meta.getTables(null, null,"", new String[] {"TABLE","VIEW"});

            boolean isTable=rsTables.next();
            if(!rsTables.next()){   //存储过程

                String procsql="{CALL " +biReport.getBiz_Table_Name() + "(" ; //判断是否有参数，此处

				for (int i = 0; i < m_biDimFieldList.size(); i++) {
					BIShowField biShowField = m_biDimFieldList.get(i);
					//判断是否有对应的维度表 add by liuxf
					Integer drillType = biShowField.getDrill_Type();
					switch (drillType) {//分段信息

						case BIConfig.DRILL_TYPE.DRILL_TYPE_DIFF_TOPIC://不同主题
							if (reportData.getDrill_Value() != null)
								procsql+="?";

					}
				}
                procsql+=")}";
                // 创建CallableStatement对象
                CallableStatement clbStmt = conn.prepareCall(procsql);  //"{CALL proc_search_user(?,?,?,?)}");
				for (int i = 0; i < m_biDimFieldList.size(); i++) {
					BIShowField biShowField = m_biDimFieldList.get(i);
					//判断是否有对应的维度表 add by liuxf
					Integer drillType = biShowField.getDrill_Type();
					switch (drillType) {//分段信息

						case BIConfig.DRILL_TYPE.DRILL_TYPE_DIFF_TOPIC://不同主题
							if (reportData.getDrill_Value() != null)
								clbStmt.setInt(i+1, (int)reportData.getValue().get(i)); // 设置输入参数
					}
				}
				// 执行调用存储过程，并获取结果集
                rs = clbStmt.executeQuery();

            }
            else {
                String sql = this.produceSql(reportData, biReport);
                //修改，直接获取dbproperties的数据源，不在使用数据库中配置数据表信息。
                PreparedStatement ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();
            }
			ResultSetMetaData rsmd = rs.getMetaData();
			int colCount = rsmd.getColumnCount();//列数量
			//从数据库中查询出来放入map中
			while (rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();

				for (int i = 1; i <= colCount; i++) {

					if (reportData.getBlock_Type() == 1
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
		}
		catch (Exception ex){
			throw new Exception(ex.getMessage());
		}
		finally {
			conn.close();
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
	private String produceSql(V_ReportData reportData, BI_REPORT biReport ) throws Exception {


		String join = " ";
		String from = " from ";
		String groupby =  " group by ";
		String where = " where 1=1 ";

		String showMeasureFields = "" ;//显示的指标字段
		String showDimFields = ""; //需要显示的维度字段

		String topicTableName=biReport.getBiz_Table_Name();  //主题表的名字
		String topicTableNamePlaceholder="'?'";

		m_biDimFieldList = biDimService.getDimFieldList(reportData,biReport.getReport_Id());
		/*================获取维度字段===============*/

		String lastDimTable=null;
		for (int i = 0; i < m_biDimFieldList.size(); i++) {

			BIShowField biShowField = m_biDimFieldList.get(i);

			//判断是否有对应的维度表 add by liuxf
			Integer drillType=biShowField.getDrill_Type();
			groupby+=biShowField.getField_Name()+",";

			if(drillType==null||drillType==0){//没有对应维度表，则直接获取主题表中的维度字段

				showDimFields += topicTableNamePlaceholder + "." + biShowField.getField_Name() + ",";    //as getFieldNameChinese
				continue;
			}

			switch (drillType) {//分段信息
				case BIConfig.DRILL_TYPE.DRILL_TYPE_NONE:  //DRILL_NONE

					showDimFields += biShowField.getDim_Table() + "." + biShowField.getText_Field() +" AS "+ biShowField.getField_Name()+ ",";//as getFieldNameChinese

					if(reportData.getKey().size() > 0){
						for (int j = 0; j < reportData.getKey().size(); j++) {
							if(reportData.getValue().get(j).toString().indexOf(",") > -1){
								where += " AND " + reportData.getKey().get(j) + " IN (" + reportData.getValue().get(j)+")";
							}else{
								where += " AND " + reportData.getKey().get(j) + " = " + reportData.getValue().get(j);
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
					if(reportData.getDrill_Name() != null){
						int x = (reportData.getDrill_Value()+"").length()/2;
						//drill_name 为provice |city|country，
						for (int j2 = 0; j2 < areas.length; j2++) {
							if(reportData.getDrill_Name().equals(areas[j2].toLowerCase())){

								//例如dd_area.city,biz_table.city as areaId,
								showDimFields += biShowField.getDim_Table() + "." + areas[x] + ", " +
										topicTableNamePlaceholder+ "." + areas[x] + " AS areaId,";
								// biz_table.city in( 3701)
								if(reportData.getDrill_Value().toString().indexOf(",") > -1){
									where += " AND " + topicTableNamePlaceholder + "." + reportData.getDrill_Name() +
											" IN (" + reportData.getDrill_Value()+")";
								}else{
									where += " AND " + topicTableNamePlaceholder + "." + reportData.getDrill_Name()
											+ "=" + reportData.getDrill_Value();
								}
								break;
							}
						}
					}else{
						//表示字段从第一个开始 ，例如 province-city-country ； 取第一个。 dd_area.province, topictale.province
						showDimFields += biShowField.getDim_Table() + "." + areas[0] + ", " +topicTableNamePlaceholder+ "." + areas[0] + " AS areaId,";
					}
					break;
				case BIConfig.DRILL_TYPE.DRILL_TYPE_DIFF_TOPIC://不同主题

					showDimFields += biShowField.getDim_Table() + "." + biShowField.getText_Field() +" AS "+ biShowField.getField_Name()+ ",";

					showDimFields += biShowField.getDim_Table() + "." + biShowField.getId_Field() +" AS "+ biShowField.getFieldNameCode()+ ","; //根据Id进行过滤

					groupby +=  biShowField.getFieldNameCode() +",";

					topicTableName=biShowField.getNextTopicTableName();
					String filterName=biShowField.getNextFilterName();
					//形成过滤语句
					if(reportData.getDrill_Value()!=null)
						where += " AND " + topicTableNamePlaceholder + "." + filterName
								+ "=" + reportData.getDrill_Value();
					break;
			}
			if(i == 0){
				join += " JOIN " + biShowField.getDim_Table() + " ON " +
						topicTableNamePlaceholder + "." + biShowField.getField_Name() + " = " +
						biShowField.getDim_Table()+ "." + biShowField.getId_Field();
			}else if(lastDimTable==null|| !lastDimTable.equals(biShowField.getDim_Table())){//不是同一个DIM数据表
				join += "\n JOIN " + biShowField.getDim_Table() + " ON " +
						topicTableNamePlaceholder + "." + biShowField.getField_Name() + " = " +  //field_name 指主题表中的字段信息
						biShowField.getDim_Table()+ "." + biShowField.getId_Field(); //id字段信息
			}
			lastDimTable=biShowField.getDim_Table();
		}

		showDimFields=trimComma(showDimFields,",");

		/*================度量值==============*/
		List<BIShowField> biMeasureFieldList = biShowEngineDao.getReportTopicInfo( biReport.getReport_Id());

		if(biMeasureFieldList.size()==0) {
			throw new Exception("当前主题度量字段为空，请检查配置");
		}

		boolean b = false;
		for (int i = 0; i < biMeasureFieldList.size(); i++) {
			BIShowField biMeasureField = biMeasureFieldList.get(i);

			if(reportData.getBlock_Type() == 1){  //图表类型：为了防止表格，表格只能有一个指标
				if(b)
					continue;
			}
			if(biMeasureField.getAggregate_Type()==null||biMeasureField.getAggregate_Type().length()<3)
				throw new  Exception(String.format("biMeasureField 度量值 %s 没有设置聚合字符，如count sum 等",biMeasureField.getField_Name()));
			String AggregateType=trimComma(biMeasureField.getAggregate_Type(),"_"); //
			showMeasureFields +=  AggregateType + "("+ topicTableNamePlaceholder + "." +
								biMeasureField.getField_Name() +") AS "+ biMeasureField.getField_Caption() +", ";
			if(biMeasureField.getAggregate_Type()==null){
				throw new Exception("显示字段Aggregate_Type为空，请检查配置,语句:<!--"+showMeasureFields+"-->");
			}
			b = true;

			if(i == 0){
				from += topicTableNamePlaceholder + " ";//此处需要修改
			}
		}
		showMeasureFields=trimComma(showMeasureFields,",");

		groupby=trimComma(groupby,",");

		//需要查询的字段，包括所有的维度和指标。
		String showFields = showDimFields + ", " + showMeasureFields; //维度  +  指标

		String sql = "select "+ showFields+ from + join + where + " "+ groupby +";";
		sql=sql.replace(topicTableNamePlaceholder,"`"+topicTableName+"`");

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
	public Map<String, Object> showDimField(Integer reportId) throws Exception {

		Connection conn =null;
		Map<String, Object> mapResult = new HashMap<String, Object>();
		try {
			conn = jdbcTemplate_bidata.getDataSource().getConnection();
			List<BI_DIM> dimList = dimDao.getDimField(reportId);
			PreparedStatement ps = null;
			ResultSet rs = null;
			for (BI_DIM bi_DIM : dimList) {
				if (bi_DIM.getBiz_Table_Name().equals("dicarea") || bi_DIM.getBiz_Table_Name().equals("v_dicarea"))
					continue;
				String sql = "SELECT " + bi_DIM.getText_Field() + " FROM " + bi_DIM.getBiz_Table_Name() + " GROUP BY " + bi_DIM.getText_Field() + "; &" + bi_DIM.getDim_Name();

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
		}
		catch (Exception ex){
			throw new Exception(ex.getMessage());
		}
		finally {
			conn.close();
		}
		return mapResult;
	}
}

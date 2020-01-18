package cn.zup.bi.service.impl;

import cn.zup.bi.dao.BIShowEngineDao;
import cn.zup.bi.dao.DimAttributeDao;
import cn.zup.bi.dao.DimDao;
import cn.zup.bi.dao.ReportFieldDao;
import cn.zup.bi.entity.*;
import cn.zup.bi.service.BIDimService;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Service("biDimService")
public class BIDimServiceImpl implements BIDimService {
	
	@Autowired
	private DimDao dimDao;
	@Autowired
	private BIShowEngineDao biShowEngineDao;
	@Autowired
	private ReportFieldDao reportFieldDao;
	@Autowired
	private DimAttributeDao dimAttributeDao;
	
	/**
	 * 获取所有的数据库表名
	 * @author antsdot
	 * @date 2016-10-9 14:31:21
	 * 
	 * */
	public List<String> getTableNameList(Connection conn) throws SQLException {
		ResultSet rs = null;
		List<String> tables = new ArrayList<String>();
		try{
			DatabaseMetaData metaData = conn.getMetaData();
			String url = metaData.getURL();
			String schema = null;
			if (url.toLowerCase().contains("oracle")) {
				schema = metaData.getUserName();
			}
			rs = metaData.getTables(null, schema, "%", new String[] { "TABLE","VIEW" });
			while (rs.next()) {
				tables.add(rs.getString("TABLE_NAME"));
			}
		}catch(Exception ex){
			System.err.println(ex.getMessage());
		}finally{
			try {
				rs.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return tables;
	}
	
	/**
	 * 维度分页列表
	 * 
	 * @param dim 维度实体
	 * @param rows：分页行数
	 * @return
	 */
	public MiniDaoPage<cn.zup.bi.entity.BI_DIM> getDimPagingList(BI_DIM dim, int page, int rows){
		MiniDaoPage<cn.zup.bi.entity.BI_DIM> minidaoPage = dimDao.getDimPagingList(dim, page, rows);
        return minidaoPage;
	}
	
	
	/**
	 * 获取数据表中所有列的列名，并添加到列表结构中
	 * @author 谢炎
	 * @date 2016-10-9 14:31:21
	 * 
	 * */
	public List<BI_DIM_FIELD> getColumnNameList(Connection conn, String tableName) throws SQLException{
		DatabaseMetaData dbmd = conn.getMetaData();
		ResultSet rs = dbmd.getColumns(null, "%", tableName, "%");
		List<BI_DIM_FIELD> list = new ArrayList<BI_DIM_FIELD>();
		
		while (rs.next()) {
			BI_DIM_FIELD biDimField = new BI_DIM_FIELD();
			biDimField.setDim_Field_Name(rs.getString("COLUMN_NAME")); //列名
			biDimField.setField_Decimal(rs.getString("DECIMAL_DIGITS")); //小数位数
			biDimField.setField_Length(rs.getString("CHAR_OCTET_LENGTH")); //字段长度
			biDimField.setField_Desc(rs.getString("REMARKS"));   //列注释
			biDimField.setField_Type(rs.getString("TYPE_NAME"));  //字段类型
			list.add(biDimField);
		}
		return list;
	}
	
	/**
	 * 获取数据表中所有列的列名，并添加到列表结构中
	 * @author 谢炎 
	 * @date 2016-10-9 14:31:21
	 * @throws SQLException 
	 * 
	 * */
	public String getPrimaryKey(Connection conn, String tableName) throws SQLException{
		DatabaseMetaData dbmd = conn.getMetaData();
		ResultSet pk = dbmd.getPrimaryKeys(null, null, tableName);
		String pks = null;
		while (pk.next()) {
	       System.out.println("COLUMN_NAME:"+pk.getObject(4));
	       pks = pk.getObject(4).toString();
		}
		return pks;
	}

	/**
	 * 保存维表数据
	 * @author antsdot（谢炎的电脑名称）
	 * @date 2016-10-10 09:51:29
	 * @prams BI_DIM 维表实体
	 * 
	 * */
	public int saveDimData(BI_DIM biDim) {
		int dimId = 0;
		try{
			dimDao.saveByHiber(biDim);
			dimId = biDim.getDim_Id();
		}catch(Exception e){
			e.printStackTrace();
		}
		return dimId;
	}
	
	/**
	 * 保存维表属性数据
	 * @author antsdot
	 * @date 2016-10-10 10:40:18
	 * @prams BI_DIM 维表属性实体
	 * 
	 * */
	public int saveDimAttribute(BI_DIM_ATTRIBUTE biDimAttribute){
		try{
			dimAttributeDao.saveByHiber(biDimAttribute);
		}catch(Exception e){
			return 0;
		}
		return 1;
	}
	
	/**
	 * 保存维表数据
	 * @author antsdot（谢炎的电脑名称）
	 * @date 2016-10-10 09:51:29
	 * @prams BI_DIM 维表实体
	 * 
	 * */
	public int updateDimData(BI_DIM biDim) {
		int dimId = 0;
		try{
			dimDao.updateByHiber(biDim);
			dimId = biDim.getDim_Id();
		}catch(Exception e){
			e.printStackTrace();
		}
		return dimId;
	}
	
	/**
	 * 保存维表属性数据
	 * @author antsdot
	 * @date 2016-10-10 10:40:18
	 * @prams BI_DIM 维表属性实体
	 * 
	 * */
	public int updateDimAttribute(BI_DIM_ATTRIBUTE biDimAttribute){
		try{
			dimAttributeDao.updateByHiber(biDimAttribute);
		}catch(Exception e){
			return 0;
		}
		return 1;
	}
	/**
	 * 删除维表属性
	 * @author
	 * @date 2
	 *
	 * */
	public void deleteDimAttribute(BI_DIM_ATTRIBUTE biDimAttribute){
		try{
			dimAttributeDao.deleteByHiber(biDimAttribute);
		}catch(Exception e){

		}
	}

	/**
	 * 删除维表数据
	 * @author zzy
	 * @date 2016-10-10 10:40:18
	 * @prams BI_DIM_ATTRIBUTE 维表属性实体
	 *
	 * */
	public void deleteDimData(Integer dimid){
		try{
			BI_DIM dim = new BI_DIM();
			dim.setDim_Id(dimid);
			dimDao.deleteDim(dimid);
		}catch(Exception e){

		}
	}
	/**
	 * 获取维表名称
	 * @author antsdot
	 * @date 2016-10-10 10:47:30
	 * 
	 * */
	public List<BI_DIM> getBiDimName(){
		BI_DIM biDim = new BI_DIM();
		return dimDao.listByHiber(biDim);
	}
	
	/**
	 * 获取维表钻取类型
	 * @author antsdot
	 * @date 2016-10-10 10:47:30
	 * 
	 * */
	public BI_DIM getBiOpenType(int dimId){
		return dimDao.getByIdHiber(BI_DIM.class, dimId);
	}
	
	/**
	 * 获取维表数据
	 * @author antsdot
	 * @date 22016-10-14 23:50:47
	 * 
	 * */
	public BI_DIM getDimInfo(String biz_Table_Name){
		BI_DIM dim = new BI_DIM();
		dim.setBiz_Table_Name(biz_Table_Name);
		return dimDao.getByEntityHiber(dim);
	}
	
	/**
	 * 获取维表属性数据
	 * @author antsdot
	 * @date 22016-10-14 23:50:47
	 * 
	 * */
	public List<BI_DIM_ATTRIBUTE> getDimInInfo(int dimId){
		BI_DIM_ATTRIBUTE dimField = new  BI_DIM_ATTRIBUTE();
		dimField.setDim_Id(dimId);
		return dimAttributeDao.listByHiber(dimField);
	}
	
	public BI_DIM_ATTRIBUTE getBiDimAttribute(int attribute_Id){
		return dimAttributeDao.getByIdHiber(BI_DIM_ATTRIBUTE.class, attribute_Id);
	}

	@Override
	public BI_DIM getDimInfo(int dimId) {
		return dimAttributeDao.getByIdHiber(BI_DIM.class, dimId);
	}

	@Override
	public List<BIShowField> getDimFieldList(ConditionTransfer conditionTransfer) {
		List<String> key = new ArrayList<String>(conditionTransfer.getKey());
		List<Object> value = new ArrayList<Object>(conditionTransfer.getValue());
		List<BI_REPORT_FIELD> reportFieldList = reportFieldDao.getReportFieldByReportId(conditionTransfer.getReport_Id());
		String hdimFieldIds = "";
		String ldimFieldIds = "";
		//第一步遍历获取到对应的主题字段，分为维表和指标
		for (int i = 0; i < reportFieldList.size(); i++) {
			if(reportFieldList.get(i).getField_Location() == 1){
				hdimFieldIds += reportFieldList.get(i).getField_Id()+", ";
			}else if(reportFieldList.get(i).getField_Location() == 2){
				ldimFieldIds += reportFieldList.get(i).getField_Id()+", ";
			}
		}
		String dimFieldIds = hdimFieldIds + ldimFieldIds;
		dimFieldIds = dimFieldIds.substring(0, dimFieldIds.length()-2);
		
		List<BIShowField> biShowDimFieldList = biShowEngineDao.getReportDimInfo(dimFieldIds, conditionTransfer.getReport_Id());
		
		//查询的列，无需做不同表进行匹配
		for (int i = 0; i < biShowDimFieldList.size(); i++) {
			//分段信息
			switch (biShowDimFieldList.get(i).getDrill_Type()) {
				case 3:
					System.err.println("钻取");
					String[] areas = biShowDimFieldList.get(i).getDrill_Info().split("-");
					if(conditionTransfer.getDrill_Name() != null){
						for (int j2 = 0; j2 < areas.length; j2++) {
							if(conditionTransfer.getDrill_Name().equals(areas[j2].toLowerCase())){
								int x = (conditionTransfer.getDrill_Value()+"").length()/2;
								biShowDimFieldList.get(i).setText_Field(areas[x]);
								break;
							}
						}
					}
//					if(key.size() > 0)
//						for (int j = 0; j < key.size(); j++) {
//							biShowDimFieldList.get(i).setText_Field(key.get(j));
//						}
					break;
			}
		}
		
		return biShowDimFieldList;
	}

	/**
	 * 获取这个报表下的行维有几行
	 * 
	 * */
	@Override
	public int getDimCount(Integer report_Id) {
		return reportFieldDao.getReportDimCount(report_Id);
	}

	@Override
	public List<BI_DIM> getDimFilter(String filterName) {
		return dimDao.getDimFilter(filterName);
	}
}

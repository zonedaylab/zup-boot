package cn.zup.bi.service.impl;

import cn.zup.bi.dao.BIShowEngineDao;
import cn.zup.bi.dao.DimDao;
import cn.zup.bi.dao.ReportFieldDao;
import cn.zup.bi.entity.BIShowField;
import cn.zup.bi.entity.BI_DIM;
import cn.zup.bi.entity.BI_REPORT_FIELD;
import cn.zup.bi.entity.ConditionTransfer;
import cn.zup.bi.service.BIShowEngineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("biShowEngineService")
public class BIShowEngineServiceImpl implements BIShowEngineService {
	
	@Autowired
	private ReportFieldDao reportFieldDao;
	@Autowired
	private BIShowEngineDao biShowEngineDao;
	@Autowired
	private DimDao dimDao;

	@Override
	public String showReport(ConditionTransfer conditionTransfer) {
		List<String> key = new ArrayList<String>(conditionTransfer.getKey());
		List<Object> value = new ArrayList<Object>(conditionTransfer.getValue());
		List<BI_REPORT_FIELD> reportFieldList = reportFieldDao.getReportFieldByReportId(conditionTransfer.getReport_Id());
		String hdimFieldIds = "";
		String ldimFieldIds = "";
		String topicFieldIds = "";
		//第一步遍历获取到对应的主题字段，分为维表和指标
		for (int i = 0; i < reportFieldList.size(); i++) {
			if(reportFieldList.get(i).getField_Location() == 1){
				hdimFieldIds += reportFieldList.get(i).getField_Id()+", ";
			}else if(reportFieldList.get(i).getField_Location() == 2){
				ldimFieldIds += reportFieldList.get(i).getField_Id()+", ";
			}else if(reportFieldList.get(i).getField_Location() == 3){
				topicFieldIds += reportFieldList.get(i).getField_Id()+", ";
			}
		}
		String dimFieldIds = "";
		if(hdimFieldIds.indexOf(",") > -1)
			hdimFieldIds = hdimFieldIds.substring(0, hdimFieldIds.length()-2);
		if(ldimFieldIds.indexOf(",") > -1)
			ldimFieldIds = ldimFieldIds.substring(0, ldimFieldIds.length()-2);
		if(topicFieldIds.indexOf(",") > -1)
			topicFieldIds = topicFieldIds.substring(0, topicFieldIds.length()-2);
		
		if(hdimFieldIds.length() == 0)
			dimFieldIds = ldimFieldIds;
		else if(ldimFieldIds.length() == 0)
			dimFieldIds = hdimFieldIds;
		else
			dimFieldIds = hdimFieldIds+","+ldimFieldIds;
			
		conditionTransfer.setKey(key);
		conditionTransfer.setValue(value);
		String sql = this.produceSql(conditionTransfer, dimFieldIds, topicFieldIds);
		
		return sql;
	}
	
	/**
	 * 通过主题字段id进行生产SQL语句
	 * @author Andot
	 * 
	 * */
	private String produceSql(ConditionTransfer conditionTransfer, String dimFieldIds, String topicFieldIds){
		StringBuffer sql = new StringBuffer();
		String showField = "";
		String join = "";
		String from = " FROM ";
		String groupby = "";
		String where = " WHERE 1=1 ";
		
		/*================维度===============*/
		List<BIShowField> biShowDimFieldList = biShowEngineDao.getReportDimInfo(dimFieldIds, conditionTransfer.getReport_Id());
		for (int i = 0; i < biShowDimFieldList.size(); i++) {
			BIShowField biShowField = biShowDimFieldList.get(i);
			//查询的列，无需做不同表进行匹配
			//分段信息
			switch (biShowField.getDrill_Type()) {
				case 1:
					showField += biShowField.getDim_Table() + "." + biShowField.getText_Field() + ",";
					if(conditionTransfer.getKey().size() > 0){
						for (int j = 0; j < conditionTransfer.getKey().size(); j++) {
							if(conditionTransfer.getValue().get(j).toString().indexOf(",") > -1){
								where += " AND " + conditionTransfer.getKey().get(j) + " IN (" + conditionTransfer.getValue().get(j)+")";
							}else{
								where += " AND " + conditionTransfer.getKey().get(j) + " = " + conditionTransfer.getValue().get(j);
							}
						}
					}
					System.err.println("无结构");
					break;
				case 2:
					System.err.println("分段");
					break;
				case 3:
					System.err.println("钻取");
					//开始钻取条件判断
					String[] areas = biShowField.getDrill_Info().split("-");
					if(conditionTransfer.getDrill_Name() != null){
						int x = (conditionTransfer.getDrill_Value()+"").length()/2;
						for (int j2 = 0; j2 < areas.length; j2++) {
							if(conditionTransfer.getDrill_Name().equals(areas[j2].toLowerCase())){
								showField += biShowField.getDim_Table() + "." + areas[x] + ", " + biShowField.getTopic_Table() + "." + areas[x] + " AS areaId,";
								if(conditionTransfer.getDrill_Value().toString().indexOf(",") > -1){
									where += " AND " + biShowField.getTopic_Table() + "." + conditionTransfer.getDrill_Name() + " IN (" + conditionTransfer.getDrill_Value()+")";
								}else{
									where += " AND " + biShowField.getTopic_Table() + "." + conditionTransfer.getDrill_Name() + "=" + conditionTransfer.getDrill_Value();
								}
								break;
							}
						}
					}else{
						showField += biShowField.getDim_Table() + "." + areas[0] + ", " + biShowField.getTopic_Table() + "." + areas[0] + " AS areaId,";
					}
//					if(conditionTransfer.getKey().size() > 0)
//						for (int j = 0; j < conditionTransfer.getKey().size(); j++) {
//							showField += biShowField.getDim_Table() + "." + conditionTransfer.getKey().get(j) + ", " + biShowField.getTopic_Table() + "." + conditionTransfer.getKey().get(j) + " AS areaId,";
//							where += " AND " + biShowField.getDim_Table() + "." + conditionTransfer.getKey() + "=" + conditionTransfer.getValue().get(j);
//						}
					break;
					//开始查询条件判断
//					if(conditionTransfer.getKey().size() > 0){
//						for (int j = 0; j < areas.length; j++) {
//							where += " AND " + conditionTransfer.getKey().get(j) + "=" + conditionTransfer.getValue().get(j);
//						}
//					}
			}
			
			if(i == 0){
				join += " JOIN " + biShowField.getDim_Table() + " ON " + 
						biShowField.getTopic_Table() + "." + biShowField.getField_Name() + " = " +
						biShowField.getDim_Table()+ "." + biShowField.getId_Field();
			}else{  //第二开始，和上一值对比，如果相同，就代表是同一张数据表，不同则是新表
				if(!biShowDimFieldList.get(i-1).getDim_Table().equals(biShowField.getDim_Table())){
					join += "\n JOIN " + biShowField.getDim_Table() + " ON " + 
							biShowField.getTopic_Table() + "." + biShowField.getField_Name() + " = " +
							biShowField.getDim_Table()+ "." + biShowField.getId_Field();
				}else{
					
				}
			}
		}
		
		if(showField.length() > 0 && showField.indexOf(",") > -1)
			showField = showField.substring(0, showField.length()-1);
		
		if(showField.length() > 0)
			groupby = " GROUP BY " + showField.replace(" AS areaId", "");
		
		/*================指标===============*/
		String topicFields = "", baseTopicFields = "";
		List<BIShowField> biShowTopicFieldList = biShowEngineDao.getReportTopicInfo(topicFieldIds, conditionTransfer.getReport_Id());
		boolean b = false;
		for (int i = 0; i < biShowTopicFieldList.size(); i++) {
			BIShowField biShowField = biShowTopicFieldList.get(i);
			if(conditionTransfer.getIndex() == null || conditionTransfer.getIndex().equals(biShowField.getField_Id())){
				if(conditionTransfer.getType() == 1){  //为了防止表格，表格只能有一个指标
					if(b){
						continue;
					}
				}
				if(biShowField.getField_Type() == 3){
					topicFields += biShowField.getAggregate_Type() + "("+ biShowField.getTopic_Table() + "." + biShowField.getField_Name() +") AS "+ biShowField.getField_Caption() +", ";
				}else{
					baseTopicFields += biShowField.getField_Name() + ", ";
				}
				b = true;
			}
			if(i == 0){
				from += biShowField.getTopic_Table() + " ";
			}
		}
		
		topicFields += baseTopicFields;
		if(topicFields.length() > 0 && topicFields.indexOf(",") > -1)
			topicFields = topicFields.trim().substring(0, topicFields.length()-1);
		if(baseTopicFields.length() > 0 && baseTopicFields.indexOf(",") > -1)
			groupby += ", "+ baseTopicFields.trim().substring(0, baseTopicFields.trim().length()-1);
		String col = "";
		if(showField.length() > 0)
			col = showField + ", " + topicFields;
		else
			col = topicFields;
		if(col.lastIndexOf(",") > -1)
			col = col.substring(0, col.length()-1);
		
		sql.append(" SELECT ");
		sql.append(col);
		sql.append(from);
		sql.append(join);
		sql.append(where);
		sql.append(groupby);
		sql.append(";");
		System.err.println(sql.toString());
		
		return sql.toString();
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

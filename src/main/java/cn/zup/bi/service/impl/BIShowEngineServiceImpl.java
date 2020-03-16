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
	public String showReport(ConditionTransfer conditionTransfer) throws Exception {
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
		if(hdimFieldIds.indexOf(",") > -1)//行维
			hdimFieldIds = hdimFieldIds.substring(0, hdimFieldIds.length()-2);
		if(ldimFieldIds.indexOf(",") > -1)//列维
			ldimFieldIds = ldimFieldIds.substring(0, ldimFieldIds.length()-2);
		if(topicFieldIds.indexOf(",") > -1)//指标
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
	 * dimFields       维度
	 * topicFielIds   指标。 liuxf
	 * @author Andot
	 * 
	 * */
	private String produceSql(ConditionTransfer conditionTransfer, String dimFieldIds, String topicFieldIds) throws Exception {
		StringBuffer sql = new StringBuffer();
		String showField = "";
		String join = "";
		String from = " FROM ";
		String groupby = "";
		String where = " WHERE 1=1 ";
		
		/*================维度===============*/
		List<BIShowField> biShowDimFieldList = biShowEngineDao.getReportDimInfo(dimFieldIds, conditionTransfer.getReport_Id());
		String lastDimTable=null;
		for (int i = 0; i < biShowDimFieldList.size(); i++) {

			BIShowField biShowField = biShowDimFieldList.get(i);

			//判断是否有对应的维度表 add by liuxf
			Integer drillType=biShowField.getDrill_Type();
			if(drillType==null||drillType==0){//如果没有对应的维度表，则直接获取主题表中的维度字段

				showField += biShowField.getTopic_Table() + "." + biShowField.getField_Name() + ",";
				continue;
			}

			switch (drillType) {//分段信息
				case 1:  //DRILL_NONE

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

		if(showField.length() > 0 && showField.indexOf(",") > -1)
			showField = showField.substring(0, showField.length()-1);
		

		/*================指标===============*/
		String topicFields = "" ;
		String 	baseTopicFields = "";  //基本维度？
		List<BIShowField> biShowTopicFieldList = biShowEngineDao.getReportTopicInfo(topicFieldIds, conditionTransfer.getReport_Id());
		if(biShowTopicFieldList.size()==0) {
			throw new Exception("当前主题指标字段为空，请检查配置");
		}
		boolean b = false;
		for (int i = 0; i < biShowTopicFieldList.size(); i++) {

			BIShowField biShowField = biShowTopicFieldList.get(i);

			if(conditionTransfer.getIndex() == null || conditionTransfer.getIndex().equals(biShowField.getField_Id())){
				if(conditionTransfer.getType() == 1){  //图表类型：为了防止表格，表格只能有一个指标
					if(b){
						continue;
					}
				}
				if(biShowField.getField_Type() == 3){//1.行维度 2.列维度 3.指标
					topicFields += biShowField.getAggregate_Type() + "("+ biShowField.getTopic_Table() + "." +
									biShowField.getField_Name() +") AS "+ biShowField.getField_Caption() +", ";
				}else{
					baseTopicFields += biShowField.getField_Name() + ", ";//维度，这个永远没有意义把，不是获取指标吗？
				}
				b = true;
			}
			if(i == 0){
				from += biShowField.getTopic_Table() + " ";
			}
		}

		//感觉 topicFields 代表指标字段；baseTopicFields 代表 维度字段； showFields 代表有维度表对应的维度。
		topicFields += baseTopicFields;
		if(topicFields.length() > 0 && topicFields.indexOf(",") > -1)
			topicFields = topicFields.trim().substring(0, topicFields.length()-1);

		//group by 维度；
		if(showField.length() > 0)
			groupby = " GROUP BY " + showField.replace(" AS areaId", "");

		//目测没有用 liuxf
		if(baseTopicFields.length() > 0 && baseTopicFields.indexOf(",") > -1)
			groupby += ", "+ baseTopicFields.trim().substring(0, baseTopicFields.trim().length()-1);

		//需要查询的字段，包括所有的维度和指标。
		String col = "";
		if(showField.length() > 0) //这是废话 liuxf
			col = showField + ", " + topicFields; //维度  +  指标
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

package cn.zup.bi.service.impl;

import cn.zup.bi.dao.BIShowEngineDao;
import cn.zup.bi.dao.DimDao;
import cn.zup.bi.dao.ReportFieldDao;
import cn.zup.bi.dao.TopicFieldDao;
import cn.zup.bi.entity.BIShowField;
import cn.zup.bi.entity.BI_REPORT_FIELD;
import cn.zup.bi.entity.BI_TOPIC_FIELD;
import cn.zup.bi.service.TopicFieldService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("topicFieldService")
public class TopicFieldServiceImpl implements TopicFieldService {
	
	@Autowired
	private TopicFieldDao topicFieldDao; 
	@Autowired
	private BIShowEngineDao biShowEngineDao;
	@Autowired
	private ReportFieldDao reportFieldDao;
	
	@Autowired
	private DimDao dimDao; 
	
	/**
	 * 主题字段分页列表
	 *
	 * @return 
	 */
	@Override
	public List<BI_TOPIC_FIELD> getTopicFieldPagingList(BI_TOPIC_FIELD topicField){
		List<BI_TOPIC_FIELD> list = topicFieldDao.getTopictopicFieldPagingList(topicField);
        return list;
	}

	/**
	 * 
	 * 主题字段数据获取
	 * @date 2016-10-6 09:32:51
	 * 
	 * */
	@Override
	public BI_TOPIC_FIELD getTopicFieldData(Integer topic_Id, Integer field_Id){
		return topicFieldDao.getTopicFieldData(topic_Id, field_Id);
	}
	
	/**
	 * 
	 * 主题字段数据删除
	 * @date 2016-10-6 09:32:51
	 * 
	 * */
	@Override
	public void deleteTopicData(Integer field_Id){
		BI_TOPIC_FIELD topicField = new BI_TOPIC_FIELD();
		topicField.setField_Id(field_Id);
		topicFieldDao.deleteTopicFieldData(field_Id);
	}
	
	/**
	 * 
	 * 主题字段数据添加
	 * @date 2016-10-6 09:32:51
	 * 
	 * */
	@Override
	public int addTopicData(BI_TOPIC_FIELD topicField){
		try{
			topicFieldDao.save(topicField);
		}catch(Exception e){
			e.printStackTrace();
			return 0;
		}
		return 1;
	}
	
	/**
	 * 
	 * 主题字段数据编辑
	 * @date 2016-10-6 09:32:51
	 * 
	 * */
	@Override
	public int updateTopicData(BI_TOPIC_FIELD topicField){
		try{
			topicFieldDao.updateTopicFieldData(topicField);
		}catch(Exception e){
			return 0;
		}
		return topicField.getField_Id();
	}

	/**
	 * 
	 * 主题字段数据获取
	 * @date 2016-10-11 11:09:01
	 * 
	 * */
	@Override
	public List<BI_TOPIC_FIELD> getTopicFields(Integer topicId){
		BI_TOPIC_FIELD topicField = new BI_TOPIC_FIELD();
		topicField.setTopic_Id(topicId);
		return topicFieldDao.getTopicFieldList(topicField);
	}

	/**
	 *
	 * 主题字段数据获取
	 * @date 2016-10-11 11:09:01
	 *
	 * */
	@Override
	public List<BI_TOPIC_FIELD> getTopicFieldList(BI_TOPIC_FIELD topicField){
		return topicFieldDao.getTopicFieldList(topicField);
	}
	/**
	 * 获取配置的维表的字段名称
	 * 
	 * */
	@Override
	public String getTopicFieldAName(int topicId){
		return topicFieldDao.getTopicFieldName(topicId);
	}
	
	@Override
	public List<BIShowField> getTopicFieldList(Integer report_Id) {

		
		List<BIShowField> biShowTopicFieldList = biShowEngineDao.getReportTopicInfo( report_Id);
		return biShowTopicFieldList;
	}
}

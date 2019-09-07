package cn.zup.bi.service;

import java.util.List;

import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.bi.entity.BIShowField;
import cn.zup.bi.entity.BI_TOPIC_FIELD;

public interface TopicFieldService {
	/**
	 * 主题字段分页列表
	 * 
	 * @param Topic 主题实体
	 * @param pageSize：分页行数
	 * @param pageination：页码
	 * @return 
	 */
	MiniDaoPage<BI_TOPIC_FIELD> getTopicFieldPagingList(BI_TOPIC_FIELD topicField, int page, int rows);
	
	/**
	 * 
	 * 主题字段数据获取
	 * @param Topic 主题实体
	 * @date 2016-10-6 09:32:51
	 * 
	 * */
	BI_TOPIC_FIELD getTopicFieldData(Integer topic_Id, Integer field_Id);
	
	/**
	 * 
	 * 主题字段数据删除
	 * @param Topic 主题实体
	 * @date 2016-10-6 09:32:51
	 * 
	 * */
	void deleteTopicData(Integer TITLE_FIELD_ID);
	
	/**
	 * 
	 * 主题字段数据添加
	 * @param Topic 主题实体
	 * @date 2016-10-6 09:32:51
	 * 
	 * */
	int addTopicData(BI_TOPIC_FIELD topicField);
	
	/**
	 * 
	 * 主题字段数据编辑
	 * @param Topic 主题实体
	 * @date 2016-10-6 09:32:51
	 * 
	 * */
	int updateTopicData(BI_TOPIC_FIELD topicField);
	
	/**
	 * 
	 * 主题字段数据获取
	 * @date 2016-10-11 11:09:01
	 * 
	 * */
	public List<BI_TOPIC_FIELD> getTopicFields(Integer topicId);
	
	/**
	 * 获取配置的维表的字段名称
	 * 
	 * */
	public String getTopicFieldAName(int topicId);
	
	List<BIShowField> getTopicFieldList(Integer report_Id);
	
}

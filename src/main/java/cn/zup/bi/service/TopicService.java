package cn.zup.bi.service;

import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.bi.entity.BI_TOPIC;

public interface TopicService {
	/**
	 * 主题分页列表
	 * 
	 * @param Topic 主题实体
	 * @param pageSize：分页行数
	 * @param pageination：页码
	 * @return 
	 */
	MiniDaoPage<BI_TOPIC> getTopicPagingList(BI_TOPIC topic, int page, int rows);
	
	/**
	 * 
	 * 主题数据获取
	 * @param Topic 主题实体
	 * @date 2016-10-5 15:30:13
	 * 
	 * */
	BI_TOPIC getTopicData(Integer topicId);
	
	/**
	 * 
	 * 主题数据删除
	 * @param Topic 主题实体
	 * @date 2016-10-5 15:30:13
	 * 
	 * */
	void deleteTopicData(Integer TOPIC_ID);
	
	/**
	 * 
	 * 主题数据添加
	 * @param Topic 主题实体
	 * @date 2016-10-5 15:30:13
	 * 
	 * */
	int addTopicData(BI_TOPIC topic);
	
	/**
	 * 
	 * 主题数据编辑
	 * @param Topic 主题实体
	 * @date 2016-10-5 15:30:13
	 * 
	 * */
	int editTopicData(BI_TOPIC topic);
}

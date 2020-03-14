package cn.zup.bi.service;

import cn.zup.bi.entity.BI_TOPIC;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import java.util.List;

public interface TopicService {
	/**
	 * 主题分页列表
	 * 
	 * @param topic 主题实体
	 * @return 
	 */
	List<BI_TOPIC> getTopicPagingList(BI_TOPIC topic);
	
	/**
	 * 
	 * 主题数据获取
	 * @date 2016-10-5 15:30:13
	 * 
	 * */
	BI_TOPIC getTopicData(Integer topicId);
	
	/**
	 * 
	 * 主题数据删除
	 * @date 2016-10-5 15:30:13
	 * 
	 * */
	void deleteTopicData(Integer TOPIC_ID);

	
	/**
	 * 
	 * 主题数据添加
	 * @param topic 主题实体
	 * @date 2016-10-5 15:30:13
	 * 
	 * */
	int addTopicData(BI_TOPIC topic);
	
	/**
	 * 
	 * 主题数据编辑
	 * @param topic 主题实体
	 * @date 2016-10-5 15:30:13
	 * 
	 * */
	int updateTopicData(BI_TOPIC topic);
}

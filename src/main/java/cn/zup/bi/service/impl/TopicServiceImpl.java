package cn.zup.bi.service.impl;

import cn.zup.bi.dao.TopicDao;
import cn.zup.bi.entity.BI_TOPIC;
import cn.zup.bi.service.TopicService;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("topicService")
public class TopicServiceImpl implements TopicService{
	
	@Autowired
	private TopicDao topicDao; 
	
	/**
	 * 主题分页列表
	 * 
	 * @param Topic 主题实体
	 * @param pageSize：分页行数
	 * @param pageination：页码
	 * @return 
	 */
	public MiniDaoPage<BI_TOPIC> getTopicPagingList(BI_TOPIC topic, int page, int rows){
		MiniDaoPage<BI_TOPIC> minidaoPage = topicDao.getTopicPagingList(topic, page, rows);         
        return minidaoPage;
	}
	
	/**
	 * 
	 * 主题数据获取
	 * @param Topic 主题实体
	 * @date 2016-10-5 15:30:13
	 * 
	 * */
	public BI_TOPIC getTopicData(Integer topicId){
		return topicDao.getTopic(topicId);
	}
	
	/**
	 * 
	 * 主题数据删除
	 * @param Topic 主题实体
	 * @date 2016-10-5 15:30:13
	 * 
	 * */
	public void deleteTopicData(Integer topicid){
		BI_TOPIC topic = new BI_TOPIC();
		topic.setTopic_Id(topicid);
		topicDao.deleteTopic(topicid);
	}
	
	/**
	 * 
	 * 主题数据添加
	 * @param Topic 主题实体
	 * @date 2016-10-5 15:30:13
	 * 
	 * */
	public int addTopicData(BI_TOPIC topic){
		try{
			topicDao.saveByHiber(topic);
		}catch(Exception e){
			return 0;
		}
		return topic.getTopic_Id();
	}
	
	/**
	 * 
	 * 主题数据编辑
	 * @param Topic 主题实体
	 * @date 2016-10-5 15:30:13
	 * 
	 * */
	public int updateTopicData(BI_TOPIC topic){
		try{
			topicDao.updateTopic(topic);
		}catch(Exception e){
			return 0;
		}
		return 1;
	}
}

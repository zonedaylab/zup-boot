package cn.zup.bi.service.impl;

import cn.zup.bi.dao.TopicDao;
import cn.zup.bi.dao.TopicFieldDao;
import cn.zup.bi.entity.BI_TOPIC;
import cn.zup.bi.service.TopicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("topicService")
public class TopicServiceImpl implements TopicService{
	
	@Autowired
	private TopicDao topicDao;
	@Autowired
	private TopicFieldDao topicFieldDao;
	
	/**
	 * 主题分页列表
	 * 
	 * @param topic 主题实体
	 * @return 
	 */
	@Override
	public List<BI_TOPIC> getTopicPagingList(BI_TOPIC topic){
		List<BI_TOPIC> minidaoPage = topicDao.getTopicPagingList(topic);
        return minidaoPage;
	}
	
	/**
	 * 
	 * 主题数据获取
	 * @param topicId
	 * @date 2016-10-5 15:30:13
	 * 
	 * */
	@Override
	public BI_TOPIC getTopicData(Integer topicId){
		return topicDao.getTopic(topicId);
	}
	
	/**
	 * 
	 * 主题数据删除
	 * @param topicid
	 * @date 2016-10-5 15:30:13
	 * 
	 * */
	@Override
	public void deleteTopicData(Integer topicid){

		//删除主题字段
		topicFieldDao.deleteTopicFieldDatabyTopic(topicid);

		BI_TOPIC topic = new BI_TOPIC();
		topic.setTopic_Id(topicid);
		topicDao.deleteTopic(topicid);

	}
	
	/**
	 * 
	 * 主题数据添加
	 * @param topic 主题实体
	 * @date 2016-10-5 15:30:13
	 * 
	 * */
	@Override
	public int addTopicData(BI_TOPIC topic){
		try{
			topicDao.save(topic);
		}catch(Exception e){
			return 0;
		}
		return topic.getTopic_Id();
	}
	
	/**
	 * 
	 * 主题数据编辑
	 * @param topic 主题实体
	 * @date 2016-10-5 15:30:13
	 * 
	 * */
	@Override
	public int updateTopicData(BI_TOPIC topic){
		try{
			topicDao.updateTopic(topic);
		}catch(Exception e){
			e.printStackTrace();
			return 0;
		}
		return 1;
	}
}

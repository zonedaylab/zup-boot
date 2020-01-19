package cn.zup.bi.dao;

import cn.zup.bi.entity.BI_TOPIC;
import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

@MiniDao
public interface TopicDao extends MiniDaoSupportHiber<BI_TOPIC>{
	@Arguments({"topic","page", "rows"})
	@ResultType(BI_TOPIC.class)
	MiniDaoPage<BI_TOPIC> getTopicPagingList(BI_TOPIC topic, int page, int rows);
	
	@Arguments({"topic"})
	void updateTopic(BI_TOPIC topic);
	
	@Arguments({"topicId"})
	void deleteTopic(int topicId);
	
	@Arguments({"topicId"})
	@ResultType(BI_TOPIC.class)
	BI_TOPIC getTopic(int topicId);
}

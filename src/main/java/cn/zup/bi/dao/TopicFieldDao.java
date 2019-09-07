package cn.zup.bi.dao;

import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.bi.entity.BI_TOPIC_FIELD;

@MiniDao
public interface TopicFieldDao extends MiniDaoSupportHiber<BI_TOPIC_FIELD>{
	@Arguments({"topicField","page", "rows"})
	@ResultType(BI_TOPIC_FIELD.class)
	public MiniDaoPage<BI_TOPIC_FIELD> getTopictopicFieldPagingList(BI_TOPIC_FIELD topicField, int page,int rows);
	
	@Arguments({"topicId"})
	public String getTopicFieldAName(int topicId);
	
	@Arguments({"topicField"})
	void updateTopicFieldData(BI_TOPIC_FIELD topicField);
	
	@Arguments({"titleFieldId"})
	void deleteTopicFieldData(int titleFieldId);
	
	@Arguments({"topic_Id", "field_Id"})
	@ResultType(BI_TOPIC_FIELD.class)
	BI_TOPIC_FIELD getTopicFieldData(Integer topic_Id, Integer field_Id);
	
}

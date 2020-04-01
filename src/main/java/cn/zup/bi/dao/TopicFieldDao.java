package cn.zup.bi.dao;

import cn.zup.bi.entity.BI_TOPIC_FIELD;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author gavin
 */
@Repository
public interface TopicFieldDao{

	List<BI_TOPIC_FIELD> getTopictopicFieldPagingList(@Param("topicField") BI_TOPIC_FIELD topicField);

	String getTopicFieldName(@Param("topicId") int topicId);


	void updateTopicFieldData(@Param("topicField") BI_TOPIC_FIELD topicField);


	void deleteTopicFieldData(@Param("titleFieldId") int titleFieldId);

	void deleteTopicFieldDatabyTopic(@Param("topic_Id") Integer topic_Id);


	BI_TOPIC_FIELD getTopicFieldData(@Param("topic_Id") Integer topic_Id, @Param("field_Id") Integer field_Id);

	void save(@Param("topicField") BI_TOPIC_FIELD topicField);

	List<BI_TOPIC_FIELD> getTopicFieldList(@Param("topicField") BI_TOPIC_FIELD topicField);
}

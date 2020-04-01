package cn.zup.bi.dao;

import cn.zup.bi.entity.BI_TOPIC;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author gavin
 */
@Repository
public interface TopicDao{

	List<BI_TOPIC> getTopicPagingList(@Param("topic") BI_TOPIC topic);

	void updateTopic(@Param("topic") BI_TOPIC topic);

	void deleteTopic(@Param("topicId") int topicId);


	BI_TOPIC getTopic(@Param("topicId") int topicId);

	void save(@Param("topic") BI_TOPIC topic);
}

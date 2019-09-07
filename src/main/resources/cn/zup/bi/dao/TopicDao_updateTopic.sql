UPDATE bi_topic bt SET
	
<#if topic.topic_Caption?exists>
	bt.TOPIC_CAPTION = '${topic.topic_Caption}',
</#if>

<#if topic.biz_Table_Name?exists>
	bt.BIZ_TABLE_NAME = '${topic.biz_Table_Name}',
</#if>

<#if topic.topic_Name?exists>
	bt.TOPIC_NAME = '${topic.topic_Name}'
</#if>

	WHERE bt.TOPIC_ID = ${topic.topic_Id}
	
	
	
	
select count(*) from bi_report where 1=1
  <#if topic_Id?exists>
	and topic_id = ${ topic_Id}
  </#if>
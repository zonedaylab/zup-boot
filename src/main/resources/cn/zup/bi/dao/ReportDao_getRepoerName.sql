 select report_id, report_name  from bi_report where 1=1
   <#if topic_Id?exists>
	and topic_id = ${ topic_Id}
  </#if>
 order  by report_id DESC
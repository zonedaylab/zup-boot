SELECT 
	br.PAGE_ID, br.CREATE_DATE, br.REPORT_ID, 
	br.REPORT_NAME, br.REPORT_TITLE, br.TOPIC_ID ,
	bt.TOPIC_NAME topic_Name, bp.PAGE_NAME page_Name
FROM bi_report br 
JOIN bi_topic bt ON br.TOPIC_ID = bt.TOPIC_ID
JOIN bi_page bp ON br.PAGE_ID = bp.BI_PAGE_ID 
WHERE 1=1

<#if biReport.page_Id?exists>
	AND br.PAGE_ID = ${ biReport.page_Id}
</#if>

<#if biReport.report_Name?exists>
	AND br.REPORT_NAME LIKE '${ biReport.report_Name}%'
</#if>

<#if biReport.caeate_Date?exists>
	AND br.CREATE_DATE = date_format('${ biReport.create_Date}','%Y-%m-%d') 
</#if>

<#if biReport.topic_Id?exists>
	AND br.TOPIC_ID = ${ biReport.topic_Id}
</#if>

<#if biReport.report_Title?exists>
	AND br.REPORT_TITLE LIKE '${ biReport.report_Title}%';
</#if>

ORDER BY br.REPORT_ID desc
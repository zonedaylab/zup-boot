SELECT 
	*
FROM bi_report_field brf
WHERE 1=1
<#if reportId?exists>
	AND brf.REPORT_ID = ${ reportId}
</#if>



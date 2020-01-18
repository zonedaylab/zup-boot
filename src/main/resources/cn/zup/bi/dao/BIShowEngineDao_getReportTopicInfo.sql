SELECT distinct
	btf.FIELD_ID, btf.FIELD_NAME, btf.FIELD_TITLE, btf.FIELD_CAPTION, btf.AGGREGATE_TYPE,
	btf.FIELD_TYPE, bt.BIZ_TABLE_NAME AS TOPIC_TABLE, bt.TOPIC_CAPTION, bt.TOPIC_NAME, 
	btf.FIELD_UNIT, brf.FIELD_LOCATION, brf.DIM_ORDER, brf.FIELD_ID
FROM bi_topic_field btf 
JOIN bi_topic bt ON bt.TOPIC_ID = btf.TOPIC_ID
JOIN bi_report_field brf ON btf.FIELD_ID = brf.FIELD_ID
WHERE 1=1
<#if ids?exists>
	AND btf.FIELD_ID IN (${ids})
</#if>
AND brf.DISPLAY = 1
AND brf.REPORT_ID = ${report_Id};
SELECT 
	*
FROM bi_report_field brf
WHERE 1=1
<#if reportField.report_Field_Id?exists>
	AND brf.REPORT_FIELD_ID = ${reportField.report_Field_Id}
</#if>
<#if reportField.report_Field_Id?exists>
	AND brf.REPORT_ID = ${ reportField.report_Id}
</#if>
<#if reportField.field_Id?exists>
	AND brf.FIELD_ID = ${reportField.field_Id}
</#if>


UPDATE bi_report_field brf 
SET 
<#if reportField.dim_Order?exists>
	brf.DIM_ORDER = ${ reportField.dim_Order},
</#if>

<#if reportField.field_Location?exists>
	brf.FIELD_LOCATION = ${ reportField.field_Location},
</#if>

<#if reportField.field_Id?exists>
	brf.FIELD_ID = ${ reportField.field_Id}
</#if>

WHERE brf.REPORT_FIELD_ID = ${ reportField.report_Field_Id} 
AND brf.REPORT_ID = ${ reportField.report_Id}
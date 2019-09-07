UPDATE bi_topic_field btf SET

<#if topicField.aggregate_Type?exists>
	btf.AGGREGATE_TYPE = '${topicField.aggregate_Type}',
</#if>

<#if topicField.dim_Id?exists>
	btf.DIM_ID = ${topicField.dim_Id},
</#if>

<#if topicField.field_Caption?exists>
	btf.FIELD_CAPTION = '${topicField.field_Caption}',
</#if>

<#if topicField.field_Decimal?exists>
	btf.FIELD_DECIMAL = ${topicField.field_Decimal},
</#if>

<#if topicField.field_Identity?exists>
	btf.FIELD_IDENTITY = ${topicField.field_Identity},
</#if>

<#if topicField.field_Length?exists>
	btf.FIELD_LENGTH = ${topicField.field_Length},
</#if>

<#if topicField.field_Title?exists>
	btf.FIELD_TITLE = '${topicField.field_Title}',
</#if>

<#if topicField.field_Type?exists>
	btf.FIELD_TYPE = ${topicField.field_Type},
</#if>

<#if topicField.field_Null?exists>
	btf.field_Null = ${topicField.field_Null},
</#if>

<#if topicField.field_Name?exists>
	btf.field_Name = '${topicField.field_Name}',
</#if>

<#if topicField.data_Type?exists>
	btf.data_Type = ${topicField.data_Type},
</#if>

<#if topicField.field_Unit?exists>
	btf.field_Unit = '${topicField.field_Unit}',
</#if>

	btf.TOPIC_ID = ${topicField.topic_Id}

WHERE btf.field_Id = ${topicField.field_Id}
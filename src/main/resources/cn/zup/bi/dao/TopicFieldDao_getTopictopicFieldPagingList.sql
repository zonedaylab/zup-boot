select 
  dtCon.SUBNAME as data_Type_Str, nullCon.SUBNAME AS field_Null_Str,
  wyCon.SUBNAME as field_Identity_Str, ftCon.SUBNAME AS field_Type_Str,
  aggregate_type, field_id, topic_id, field_type, field_length, field_decimal, 
  field_null, field_identity, field_name, field_caption, 
	field_title, bi_topic_field.DIM_ID , bd.DIM_NAME, field_Unit
from bi_topic_field
LEFT JOIN config dtCon ON dtCon.SUBID = DATA_TYPE AND dtCon.CONFIGID = 77
LEFT JOIN config nullCon ON nullCon.SUBID = FIELD_NULL AND nullCon.CONFIGID = 78
LEFT JOIN config wyCon ON wyCon.SUBID = FIELD_IDENTITY AND wyCon.CONFIGID = 78
LEFT JOIN config ftCon ON ftCon.SUBID = FIELD_TYPE AND ftCon.CONFIGID = 79
LEFT JOIN bi_dim bd ON bi_topic_field.DIM_ID = bd.DIM_ID
WHERE 1=1
<#if topicField.topic_Id?exists>
	and TOPIC_ID = ${topicField.topic_Id}
</#if>
ORDER BY FIELD_ID DESC
select *  from bi_dim_attribute where dim_id=${ dimId}
  <#if drill?exists>
	and ATTRIBUTE_CAPTION_FIELD = '${ drill}'
 </#if>
select *  from bi_dim_attribute  where dim_id=${ dimId} 
<#if caption?exists>
	and ATTRIBUTE_CAPTION_FIELD = '${ caption}'
</#if>
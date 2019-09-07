select * from organ where 1=1  
<#if organId ?exists>
	and organId != ${organId}
</#if>
<#if parentOrganId ?exists>
	and parentOrganId = ${parentOrganId}
</#if>
<#if organName ?exists>
	and organName = '${organName}'
</#if> 


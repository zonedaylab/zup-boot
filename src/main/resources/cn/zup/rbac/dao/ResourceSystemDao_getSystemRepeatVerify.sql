select * from  `system` where 1=1 
<#if systemId ?exists>
	and systemid != ${systemId}
</#if>
<#if systemName ?exists>
	and systemName = '${systemName}'
</#if>

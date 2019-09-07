select * from Action where 1=1 
<#if actionId ?exists>
	and actionId !=${actionId}
</#if>
<#if menuId ?exists>
	and menuId =${menuId}
</#if>
<#if actionName ?exists>
	and actionname ='${actionName}'
</#if>



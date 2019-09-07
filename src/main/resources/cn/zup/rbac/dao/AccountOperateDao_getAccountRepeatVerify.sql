select * from account where 1=1 			
<#if accountId ?exists>
	and accountId != ${accountId}
</#if>
<#if accountName ?exists>
	and accountName = '${accountName}'
</#if>
<#if userId ?exists>
	and userId = ${userId}
</#if>

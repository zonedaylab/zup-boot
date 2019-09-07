select * from Account where 1=1 
<#if account.accountId?exists>
	and accountid = ${account.accountId}
</#if>
<#if account.accountName?exists>
	and accountname = '${account.accountName}'
</#if>

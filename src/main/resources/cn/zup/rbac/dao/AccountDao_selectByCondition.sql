select * from Account where 1=1 
<#if account.accountId ?exists>
	and AccountId = ${account.accountId}
</#if>
<#if account.accountName ?exists>
	and AccountName = '${account.accountName}'
</#if>
<#if account.userId ?exists>
	and userid = ${account.userId}
</#if>


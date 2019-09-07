select * from Account where 1=1 
<#if accountId ?exists>
	and accountid = ${accountId}
</#if>
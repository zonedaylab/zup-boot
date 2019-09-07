select accountid from Account where 1=1 
<#if accountName ?exists>
	and accountname = '${accountName}'
</#if>
<#if passWord ?exists>
	and password = '${passWord}'
</#if>
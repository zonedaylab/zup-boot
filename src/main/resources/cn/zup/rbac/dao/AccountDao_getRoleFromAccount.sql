select * from accountrole where 1=1 
<#if accountId ?exists>
	and accountid = ${accountId}
</#if>
select accountrole.roleid from accountrole  
 left join account on account.accountId= accountRole.accountId
 where 1=1 
<#if account.accountId ?exists>
	and account.accountId = ${account.accountId}
</#if>

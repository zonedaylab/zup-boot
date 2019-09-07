select  actionname  from action join roleaction on action.actionid = roleaction.actionid
	join accountrole on roleaction.roleid = accountrole.roleid 
	where  1=1  
<#if menuId ?exists>
	and menuid = ${menuId}
</#if>
<#if accountId ?exists>
	and accountrole.accountid = ${accountId}
</#if>
select * from action
	join roleaction on roleaction.actionid=action.actionid
	join accountrole on accountrole.roleid=roleaction.roleid
 where 1=1 
<#if account ?exists>
	and accountid = ${account}
</#if>
<#if permissionCode ?exists>
	and actioncode ='${permissionCode}'
</#if>

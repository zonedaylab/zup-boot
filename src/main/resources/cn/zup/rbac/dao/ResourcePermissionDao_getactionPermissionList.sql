select ActionName,ActionType,ActionPermission as Permission from Action
	join roleAction on  roleaction.actionid=action.actionid
	join  accountrole on  accountrole.roleid=roleaction.roleid
			where 1=1 			
<#if account ?exists>
	and accountid = ${account}
</#if>
<#if menu ?exists>
	and menuid = ${menu}
</#if>

			
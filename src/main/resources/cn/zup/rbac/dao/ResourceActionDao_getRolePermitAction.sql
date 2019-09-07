select  action.actionId,action.menuId,actionName,actionType,actionpermission,actionCode,menuName,caption
  	from action 
	left join roleaction on action.actionid=roleaction.actionid			
	left join menu on menu.menuid = action.menuid 
	where 1=1 		 
<#if menuId ?exists>
	and action.menuId = ${menuId}
</#if>
<#if roleId ?exists>
	and roleid = ${roleId}
</#if>

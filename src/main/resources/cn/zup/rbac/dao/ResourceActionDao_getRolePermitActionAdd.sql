select  action.actionId,action.menuId,actionName,actionType,actionpermission,config.subname as actionpermissionName,actionCode,menuName ,action.caption
  	from action 
	left join roleaction on action.actionid=roleaction.actionid		
	<#if roleId ?exists>
		and roleaction.roleId = ${roleId}
	</#if>
	left join menu on menu.menuid = action.menuid 
	left join config on roleaction.actionpermission = config.subid and config.configid = 1000  
	where 1=1 		 
<#if menuId ?exists>
	and action.menuId = ${menuId}
</#if>
<#if roleId ?exists>
	and IFNULL(roleId,0) != ${roleId}
</#if>

select menu.menuId,menu.mobileflag,menu.systemId,menu.parentMenuId,menu.menuName,menu.orderCode,menu.iconStyle,menu.nameSpace,menu.urlAddress,menu.formAddress,menu.flowId from menu 
	left join menu submenu on submenu.parentmenuid = menu.menuid 
	inner join rolemenu on rolemenu.menuid=(case when submenu.menuid is null then menu.menuid else submenu.menuid end) 
	join accountrole on accountrole.roleid=rolemenu.roleid		
	where 1=1 and menu.parentmenuid = 0 	
<#if accountId ?exists>
	and accountid = ${accountId}
</#if>
<#if systemId ?exists>
	and menu.systemid in( 0,${systemId} )
</#if> 
<#if mobileFlag ?exists>
	and menu.mobileFlag = ${mobileFlag} 
</#if>
group by menu.menuId,menu.mobileflag,menu.systemId,menu.parentMenuId,menu.menuName,menu.orderCode,menu.iconStyle,menu.nameSpace,menu.urlAddress,menu.formAddress,menu.flowId
order by PARENTMENUID,ORDERCODE
			
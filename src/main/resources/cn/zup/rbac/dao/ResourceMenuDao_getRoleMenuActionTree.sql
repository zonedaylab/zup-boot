select menu.menuId,menu.mobileflag,menu.systemId,menu.parentMenuId,menu.menuName,menu.orderCode,menu.iconStyle,menu.nameSpace,menu.urlAddress,menu.formAddress,menu.flowId from menu 
  left join menu submenu on submenu.parentmenuid = menu.menuid 
  inner join rolemenu on rolemenu.menuid=(case when submenu.menuid is null then menu.menuid else submenu.menuid end) 
  join accountrole on accountrole.roleid=rolemenu.roleid    
  where 1=1
 <#if parentMenuId ?exists>
	and menu.parentMenuId = ${ parentMenuId} 
</#if>

<#if roleId ?exists>
	and accountrole.roleid = ${ roleId} 
</#if> 

<#if systemId ?exists>
	and menu.systemid = ${ systemId} 
</#if>


group by menu.menuId,menu.mobileflag,menu.systemId,menu.parentMenuId,menu.menuName,menu.orderCode,menu.iconStyle,menu.nameSpace,menu.urlAddress,menu.formAddress,menu.flowId
order by menu.systemId,menu.mobileflag desc,ORDERCODE
select menu.menuId,systemId,parentMenuId,menuName,orderCode,iconStyle,nameSpace,urlAddress,formAddress,ifnull(rolemenu.menuId,0) as menurole ,menu.mobileFlag from menu 
left join 
(
	select * from rolemenu  
	WHERE 1=1 
	<#if roleId ?exists>
		and roleId = ${roleId}
	</#if> 
) rolemenu on rolemenu.menuid=menu.menuid						
	where 1=1 	 
<#if systemId ?exists>
	and systemid = ${systemId}
</#if>
<#if parentMenuId ?exists>
	and parentMenuId = ${parentMenuId}
</#if>
order by systemId,menu.mobileFlag desc,orderCode
	
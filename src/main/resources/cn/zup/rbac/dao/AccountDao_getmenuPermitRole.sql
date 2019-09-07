select * from Role 
	join rolemenu on rolemenu.roleid=role.roleid
 where 1=1 
<#if menuId ?exists>
	and menuid = ${menuId}
</#if>



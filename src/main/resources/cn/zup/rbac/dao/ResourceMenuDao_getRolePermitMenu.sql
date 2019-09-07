select * from menu 
	join rolemenu on rolemenu.menuid=menu.menuid						
	where 1=1 			
<#if roleId ?exists>
	and roleid = ${roleId}
</#if>
<#if systemId ?exists>
	and systemid = ${systemId}
</#if>

			
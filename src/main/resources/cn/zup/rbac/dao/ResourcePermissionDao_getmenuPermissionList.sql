select menu.menuid,menuname,parentmenuid,ordercode,iconstyle,menupermission  from Menu 
	join rolemenu on  rolemenu.menuid=menu.menuid
where 1=1
<#if role ?exists>
	and roleid = ${role}
</#if>
<#if system1 ?exists>
	and systemid =${system1}
</#if>

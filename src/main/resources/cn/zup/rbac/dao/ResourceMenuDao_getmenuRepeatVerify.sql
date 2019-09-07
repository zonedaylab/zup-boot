select * from menu where 1=1 
<#if menu ?exists>
	and menuId != ${menu}
</#if>
<#if system ?exists>
	and systemid = ${system}
</#if>
<#if parentMenu ?exists>
	and parentMenuid = ${parentMenu}
</#if>
<#if menuName ?exists>
	and menuName = '${menuName}'
</#if>
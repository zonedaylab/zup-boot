select * from role where 1=1 
<#if parentRole ?exists>
	and parentRoleid = ${parentRole}
</#if>

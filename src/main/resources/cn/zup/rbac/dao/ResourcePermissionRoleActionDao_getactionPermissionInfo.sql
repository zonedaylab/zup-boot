select * from roleaction where 1=1 
<#if role ?exists>
	and roleid = ${role}
</#if>
<#if action ?exists>
	and actionid =${action}
</#if>

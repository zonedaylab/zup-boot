select * from role where 1=1 
<#if roleName ?exists>
	and roleName = '${roleName}'
</#if>
<#if roleType ?exists>
	and roleType = ${roleType}
</#if>
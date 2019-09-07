select * from Role where 1=1 
<#if roleId ?exists>
	and roleid != ${roleId}
</#if>
<#if roleName ?exists>
	and roleName = '${roleName}'
</#if>


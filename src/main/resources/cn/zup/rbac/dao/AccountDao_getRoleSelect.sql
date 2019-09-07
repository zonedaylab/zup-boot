select * from role where 1=1 
<#if roleId ?exists>
	and roleId = ${roleId}
</#if>

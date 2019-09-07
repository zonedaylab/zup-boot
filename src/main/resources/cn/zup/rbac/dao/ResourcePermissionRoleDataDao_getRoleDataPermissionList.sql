select * from roledata 
	
where 1=1 
<#if role ?exists>
	and roleid = ${role}
</#if>


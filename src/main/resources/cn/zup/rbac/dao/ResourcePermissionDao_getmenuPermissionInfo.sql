select * from rolemenu where 1=1 
<#if role ?exists>
	and roleid = ${role}
</#if>
<#if menu ?exists>
	and menuid =${menu}
</#if>

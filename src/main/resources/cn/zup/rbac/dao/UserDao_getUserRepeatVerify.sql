select * from userinfo where 1=1 			
<#if userId ?exists>
	and userId != ${userId}
</#if>
<#if realName ?exists>
	and realName = '${realName}'
</#if>


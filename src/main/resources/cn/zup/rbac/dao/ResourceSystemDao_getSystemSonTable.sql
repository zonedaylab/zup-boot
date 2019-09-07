select menuid,operateid from  `system` 
 inner join operatelog on system.systemid=operatelog.systemid
 inner join menu on system.systemid=menu.systemid
 where 1=1 
<#if systemId ?exists>
	and system.systemid = ${systemId}
</#if>

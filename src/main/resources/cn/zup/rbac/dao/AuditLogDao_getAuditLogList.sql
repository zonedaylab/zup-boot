 select u.REALNAME userName, sys.SYSTEMNAME systemName, auditLevelconfig.SUBNAME auditLevelName, 
	al.auditEvent, al.auditPage, al.userIp, al.ipAddr, al.auditDate, al.memo
 FROM auditlog al 
 LEFT JOIN system sys ON al.SYSTEMID = sys.SYSTEMID 
 LEFT JOIN userinfo u ON al.USERID = u.USERID 
 LEFT JOIN config auditLevelconfig ON auditLevelconfig.subid = al.auditLevel
 AND auditLevelConfig.configid =  ${auditLog.auditLevelName}
 WHERE 1=1
<#if auditLog.systemId ?exists>
	AND al.systemId = ${auditLog.systemId}
</#if>
<#if auditLog.userId ?exists>
	AND al.userId = ${auditLog.userId}
</#if>

<#if auditLog.auditPage ?exists>
	AND al.auditPage LIKE '%${auditLog.auditPage}%'
</#if>

<#if auditLog.systemName ?exists>
	AND sys.systemName LIKE '%${auditLog.systemName}%'
</#if>

<#if auditLog.auditDateEnd ?exists>
	AND date_format (al.auditDate,'%Y-%c-%d %H:%i:%s') <= date_format ('${auditLog.auditDateEnd} 23:59:59','%Y-%c-%d %H:%i:%s')
</#if>

<#if auditLog.auditDateStart ?exists>
	AND date_format (al.auditDate,'%Y-%c-%d %H:%i:%s') >= date_format ('${auditLog.auditDateStart} 00:00:00','%Y-%c-%d %H:%i:%s')
</#if>

<#if auditLog.auditLevel ?exists>
	AND al.auditLevel = ${auditLog.auditLevel}
</#if>

<#if auditLog.userName ?exists>
	AND u.REALNAME LIKE '%${auditLog.userName}%'
</#if>

<#if auditLog.userIds ?exists>
	AND al.userId IN ${auditLog.userIds}
</#if>

 ORDER BY al.auditDate DESC
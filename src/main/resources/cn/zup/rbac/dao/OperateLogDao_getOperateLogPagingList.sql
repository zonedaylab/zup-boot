select OPERATEID,oper.SYSTEMID, oper.USERID,PAGENAME,LOGINFO,LOGDATE,
 loglevelconfig.subname logLevelString,logsql, u.REALNAME USERNAME, sys.SYSTEMNAME SYSTEMNAME 
 from OPERATELOG oper 
LEFT JOIN system sys ON oper.SYSTEMID = sys.SYSTEMID 
LEFT JOIN userinfo u ON oper.USERID = u.USERID 
left join config loglevelconfig on loglevelconfig.subid = oper.logLevel
<#if operatelog.logLevelConfig ?exists>
	and logLevelConfig.configid =  ${operatelog.logLevelConfig}
</#if>
 where 1=1
<#if operatelog.systemId ?exists>
	and oper.systemid = ${operatelog.systemId}
</#if>
<#if operatelog.userId ?exists>
	and oper.userid = ${operatelog.userId}
</#if>

<#if operatelog.pageName ?exists>
	and oper.pagename = '${operatelog.pageName}'
</#if>

<#if operatelog.systemName ?exists>
	and sys.systemname like '%${operatelog.systemName}%'
</#if>

<#if operatelog.logDate ?exists>
	and date_format (LOGDATE,'%Y-%c-%d %H:%i:%s') <= date_format ('${operatelog.logLevelString} 23:59:59','%Y-%c-%d %H:%i:%s')
and date_format (LOGDATE,'%Y-%c-%d %H:%i:%s') >= date_format ('${operatelog.logLevelString} 00:00:00','%Y-%c-%d %H:%i:%s')
</#if>

<#if operatelog.logLevel ?exists>
	and oper.loglevel = ${operatelog.logLevel}
</#if>

<#if operatelog.userName ?exists>
	and u.REALNAME like '%${operatelog.userName}%'
</#if>
<#if operatelog.userIds ?exists>
	and oper.userId in ${operatelog.userIds}
</#if>


ORDER BY LOGDATE DESC
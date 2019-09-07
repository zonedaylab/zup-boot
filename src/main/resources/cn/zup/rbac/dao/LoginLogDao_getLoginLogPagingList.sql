select loginlogid,loginlog.accountid,loginlog.userid,logdatetime,retrycount,
 logtype,logTypeConfig.SUBNAME  logtypestring,
 logip,systemname,systemid,username,account.accountname from loginlog 
  join account on account.accountid=loginlog.accountid
  left join config logTypeConfig on logtypeConfig.subid = loginlog.logType
  <#if loginLog.logTypeConfig?exists>
   	and logTypeConfig.configid=${loginLog.logTypeConfig}
  </#if>
where 1=1 
  <#if loginLog.username ?exists>
   	and username like '%${loginLog.username}%'
  </#if>
  <#if loginLog.systemid ?exists>
   	and systemid=${loginLog.systemid}
  </#if>
  <#if loginLog.logtype ?exists>
   	and logtype=${loginLog.logtype}
  </#if>
  <#if loginLog.endLogDateTime ?exists>
   	and date_Format(logdatetime,'%Y-%m-%d %H:%i:%s')<=date_format ('${loginLog.endLogDateTime} 23:59:59','%Y-%m-%d %H:%i:%s') 
  </#if>
   <#if loginLog.startLogDateTime ?exists>
   	and date_Format(logdatetime,'%Y-%m-%d %H:%i:%s')>=date_format ('${loginLog.startLogDateTime} 00:00:00','%Y-%m-%d %H:%i:%s')
  </#if>
  <#if loginLog.userIds ?exists>
	AND loginlog.userid IN ${loginLog.userIds}
  </#if>
  order by logdatetime desc
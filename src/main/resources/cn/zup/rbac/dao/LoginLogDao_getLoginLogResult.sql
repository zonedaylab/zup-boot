select * from config where 1=1
<#if loginLog.logTypeConfig ? exists>
   	and CONFIGID = ${loginLog.logTypeConfig}
  </#if>
select accountId,acounttable.userId,accountName,passWord,accountUsed,
 validflagconfig.subname validFlagString from Account as acounttable
 left join config validFlagConfig on validFlagConfig.subid=acounttable.validFlag 
<#if account.validFlagConfig ?exists>
	and validFlagConfig.configid = ${account.validFlagConfig}
</#if> 
left join userinfo on userinfo.USERID = acounttable.USERID 
 where 1=1 
<#if account.userId ?exists>
	and acounttable.userId = ${account.userId}
</#if> 
<#if account.validFlag ?exists>
	and acounttable.validFlag = ${account.validFlag}
</#if> 
<#if account.ACCOUNTNAME ?exists>
	and acounttable.ACCOUNTNAME like '${account.ACCOUNTNAME}'
</#if> 
<#if organId ?exists>
	and userinfo.organid = ${organId} 
</#if> 
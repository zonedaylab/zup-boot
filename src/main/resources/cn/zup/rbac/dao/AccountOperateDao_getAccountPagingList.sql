select accountId,userId,accountName,passWord,
 validflagconfig.subname validFlagString from Account
 left join config validFlagConfig on validFlagConfig.subid=account.validFlag 
<#if account.validFlagConfig ?exists>
	and validFlagConfig.configid = ${account.validFlagConfig}
</#if> 
 where 1=1 
<#if account.userId ?exists>
	and account.userId = ${account.userId}
</#if> 
<#if account.validFlag ?exists>
	and account.validFlag = ${account.validFlag}
</#if> 
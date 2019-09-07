select accountid,userid,accountname,password
  from Account
 where 1=1 
<#if userId ?exists>
	and userid = ${userId}
</#if> 
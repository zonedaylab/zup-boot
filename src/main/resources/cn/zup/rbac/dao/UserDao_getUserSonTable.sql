select operateid,accountid from userinfo
 inner join operatelog on userinfo.userId=operatelog.userId
 inner join account on userinfo.userId=account.userId
 where 1=1
<#if userId ?exists>
and  userinfo.userId=${userId}
</#if>
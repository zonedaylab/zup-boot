select accountname,userinfo.realname from account
 left join userinfo on userinfo.userId=account.userId
 left join accountrole on accountrole.accountId=account.accountId
 where 1=1
<#if roleId ?exists>
 and accountrole.roleId=${roleId}
</#if>
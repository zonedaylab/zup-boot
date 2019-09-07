select accountname,account.accountid from AccountRole 
 join account on account.accountid=accountrole.accountid 
 where 1=1
<#if roleId ?exists>
 and accountrole.roleId=${roleId}
</#if>
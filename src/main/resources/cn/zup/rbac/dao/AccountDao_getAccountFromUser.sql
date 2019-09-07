select * from role
	join accountrole on accountrole.roleid=role.roleid
	join account on account.accountid=accountrole.accountid
 where 1=1 
<#if userId ?exists>
	and userid = ${userId}
</#if>

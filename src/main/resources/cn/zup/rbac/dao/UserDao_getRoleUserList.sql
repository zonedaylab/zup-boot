SELECT u.USERID,u.REALNAME from userinfo u 
 LEFT JOIN account a on a.USERID=u.USERID
 LEFT JOIN accountRole ar on ar.ACCOUNTID=a.ACCOUNTID
  where 1=1 
	<#if roleId ?exists>
		and ar.ROLEID = ${roleId}
	</#if>
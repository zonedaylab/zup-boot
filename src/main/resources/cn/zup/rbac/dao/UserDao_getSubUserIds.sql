SELECT GROUP_CONCAT(u.USERID,'') as userIds from userInfo u where 1=1
<#if mySubOrganIds ?exists>
	and u.ORGANID in  ${mySubOrganIds}
</#if>

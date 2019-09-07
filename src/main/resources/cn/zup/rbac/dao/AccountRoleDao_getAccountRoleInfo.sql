select * from Accountrole where 1=1 
<#if account ?exists>
	and AccountId = ${account}
</#if>
<#if roleId ?exists>
	and roleid = ${roleId}
</#if>

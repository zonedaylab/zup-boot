select * from Account 
	join userinfo on userinfo.userid=account.userid
where 1=1 
<#if organId ?exists>
	and organid = ${organId}
</#if>

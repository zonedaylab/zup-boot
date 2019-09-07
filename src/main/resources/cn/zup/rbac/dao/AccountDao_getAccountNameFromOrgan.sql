select account.userid,account.accountid,account.accountname,organ.organid,userinfo.userid,userinfo.organid 
from ACCOUNT
 join userinfo on userinfo.userid=account.userid 
 join organ on organ.organid=userinfo.organid  
where 1=1 
<#if accountName ?exists>
	and account.accountname like '%${accountName}%'
</#if>
<#if organId ?exists>
	and organ.organid = ${organId}
</#if>
and account.accountid not in(select accountrole.accountid from accountrole)
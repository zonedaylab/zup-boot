 select organ.ORGANID,organ.ORGANNAME,organ.PARENTORGANID,organ.organtype from Account 
	join userinfo on userinfo.userid=account.userid 
	join organ on organ.ORGANID = userinfo.ORGANID 
where 1=1  
<#if parentOrganId ?exists>
	and organ.PARENTORGANID= ${parentOrganId}
</#if>
<#if usedStr ?exists>
	and CONCAT(account.accountUsed,',')  like '%${usedStr},%'
</#if> 
group by organ.ORGANID

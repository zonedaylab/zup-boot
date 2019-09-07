select postid,post.organId,postname,postduty, standardnumber,organ.organName,
validflagconfig.subname validFlagString from post
left join organ on post.organId=organ.organId
left join config validflagconfig on validflagconfig.subid = post.validflag
<#if post.validFlagConfig ?exists>
	and validFlagConfig.configid = ${post.validFlagConfig}
</#if> 
where 1=1
<#if post.organId ?exists>
	and post.organid = ${post.organId}
</#if>
<#if post.postName ?exists>
	and postname like '%${post.postName}%'
</#if>
<#if post.validFlag ?exists>
	and post.validflag =  ${post.validFlag}
</#if>
<#if post.myOrganIds ?exists>
	and post.organId in ${post.myOrganIds}
</#if>
ORDER BY postid DESC


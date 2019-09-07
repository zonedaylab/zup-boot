select * from UserInfo where 1=1 
<#if organId ?exists>
	and organid = ${organId}
</#if>
<#if postId ?exists>
	and postid =${postId}
</#if>
<#if realName ?exists>
	and realName ='${realName}'
</#if>
<#if validFlag ?exists>
	and validFlag = ${validFlag}
</#if>

select * from Post where 1=1 
<#if postId ?exists>
	and postid != ${postId}
</#if>
<#if organId ?exists>
	and organid = ${organId}
</#if>
<#if postName ?exists>
	and postName = '${postName}'
</#if>


 select * from post
 where 1=1
	<#if organId ?exists>
		and post.organid = ${organId}
	</#if>
	<#if postName ?exists>
		and postname like '%${postName}%'
	</#if>
	ORDER BY postid DESC


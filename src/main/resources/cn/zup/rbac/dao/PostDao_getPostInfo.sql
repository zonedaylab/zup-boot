select postid,post.organid,postname,postduty,standardnumber,
	validFlagConfig.subname validFlagString,organ.organName from Post
	left join organ on organ.organId=post.organId
	left join config validFlagConfig on validflagConfig.subid=post.validFlag
	<#if post.validFlagConfig ?exists>
		and validflagconfig.configid =  ${post.validFlagConfig}
	</#if>
 where 1=1 
<#if postId ?exists>
	and postid = ${postId}
</#if>



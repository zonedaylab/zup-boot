select  userinfo.organid,userinfo.postid,userinfo.realname,userinfo.userid,
		contractTypeConfig.subname contractTypeString,
 		sexconfig.subname sexstring,
		date_format(userinfo.birthday, '%Y-%m-%d') birthdayString,userinfo.identitycard,userinfo.nativeplace, userinfo.address,userinfo.phone,userinfo.cellphone,
 		educationConfig.subname educationString,
 		userinfo.graduationdate,
 		politicsstatusconfig.subname politicsstatusString, 				
 		userinfo.professionalinfo,
    	validflagconfig.subname validflagstring ,organ.organname,post.postname from userinfo 
left join organ on organ.organid=userinfo.organid
left join post on post.postid =userinfo.postid 
left join config educationConfig on educationConfig.subid=userinfo.education
<#if user.educationConfig ?exists>
	and educationConfig.configid =  ${user.educationConfig}
</#if>
left join config contractTypeConfig on contractTypeConfig.subid=userinfo.contractType
<#if user.contractTypeConfig ?exists>
	and contractTypeConfig.configid =  ${user.contractTypeConfig}
</#if>
left join config  politicsstatusconfig  on politicsstatusconfig.subid=userinfo.politicsStatus 
<#if user.politicsStatusConfig ?exists>
	and politicsStatusConfig.configid =  ${user.politicsStatusConfig}
</#if>
left join config  sexconfig  on sexconfig.subid=userinfo.sex 
<#if user.sexConfig ?exists>
	and sexconfig.configid =  ${user.sexConfig}
</#if>
left join config validflagconfig on validflagconfig.subid=userinfo.validFlag 
<#if user.validFlagConfig ?exists>
	and validflagconfig.configid =  ${user.validFlagConfig}
</#if>
where 1=1 
<#if user.organId ?exists>
	and userinfo.organid = ${user.organId}
</#if>
and 1=1 
<#if user.postId ?exists>
	and userinfo.postid = ${user.postId}
</#if>
<#if user.realName ?exists>
	and userinfo.realname like '%${user.realName}%'
</#if>
and 1=1 
<#if user.validFlag ?exists>
	and userinfo.validflag = ${user.validFlag}
</#if>
<#if user.sex ?exists>
	and userinfo.sex = ${user.sex}
</#if>
<#if user.organIds ?exists>
	and userinfo.organid in ${user.organIds}
</#if>
<#if user.userIds ?exists>
	and userinfo.userid in ${user.userIds}
</#if>




select systemid,systemname,systemurl,imgpath,
validflagconfig.subname validflagstring  from `system`
left join config validflagconfig on validflagconfig.subid=system.validFlag 
<#if validFlag ?exists>
	and validflagconfig.configid =  ${validFlag}
</#if>
order by systemId
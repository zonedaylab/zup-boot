 select systemid,systemname,systemurl,imgpath,
	validflagconfig.subname validflagstring  from  `system` 
	left join config validflagconfig on validflagconfig.subid=system.validFlag 
	<#if validFlag ?exists>
		and validflagconfig.configid =  ${validFlag}
	</#if>
	where 1=1
	<#if systemTemp.systemId ?exists>
		and systemid=${systemTemp.systemId}
	</#if>
	<#if systemTemp.systemName ?exists>
		and systemName like '%${systemTemp.systemName}%'
	</#if>

select systemid,systemname,systemurl,imgpath,validFlag,
validflagconfig.subname validflagstring  from  `system` 
left join config validflagconfig on validflagconfig.subid=system.validFlag 
<#if validFlag ?exists>
	and validflagconfig.configid =  ${validFlag}
</#if>
where 1=1
<#if systemId ?exists>
	and systemid=${systemId}
</#if>

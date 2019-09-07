select organId,parentOrganId,organCode,organName,shortName,orderCode,governor,validFlag,organType,
 validflagconfig.subname validflagstring,
 organtypeconfig.subname organtypestring  from organ
 left join config validflagconfig on validflagconfig.subid=organ.validFlag 
<#if organ.validFlagConfig ?exists>
	and validFlagConfig.configid =  ${organ.validFlagConfig}
</#if>
 left join config organtypeconfig on organtypeconfig.subid=organ.organType
<#if organ.organTypeConfig ?exists>
	and organTypeConfig.configid =  ${organ.organTypeConfig}
</#if>
 where 1=1
<#if organ.organId ?exists>
	and organId =  ${organ.organId}
</#if>

select organid,parentOrganId,organCode,organName,shortName,orderCode,governor,
	validFlagConfig.subname validFlagString,
	organTypeConfig.subname organTypeString  
	from organ
left join config validFlagConfig on  validFlagConfig.subid=organ.validFlag 
<#if organ.validFlagConfig ?exists>
	and validFlagConfig.configid =  ${organ.validFlagConfig}
</#if>
left join config organTypeConfig on  organTypeConfig.subid=organ.organType
<#if organ.organTypeConfig ?exists>
	and organTypeConfig.configid =  ${organ.organTypeConfig}
</#if>
where 1=1
<#if organ.parentOrganId ?exists>
	and parentOrganId =  ${organ.parentOrganId}
</#if>
<#if organ.organType?exists>
	and organType =  ${organ.organType}
</#if>
order by orderCode

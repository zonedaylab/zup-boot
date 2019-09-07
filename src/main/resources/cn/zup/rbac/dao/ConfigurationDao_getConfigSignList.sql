select CONFIGID,SUBID,NAME,SUBNAME from CONFIG
where 1=1
<#if config.subname ?exists>
	and SUBNAME = '${config.subname}'
</#if>
<#if config.configid ?exists>
	and CONFIGID = ${config.configid}
</#if>
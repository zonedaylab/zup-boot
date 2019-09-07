select * from config where 1=1
<#if config.configid ?exists>
and configid=${config.configid}
</#if>
<#if config.subid ?exists>
and subid=${config.subid}
</#if>
<#if config.name ?exists>
and name='${config.name}'
</#if>
<#if config.subname ?exists>
and subname='${config.subname}'
</#if>

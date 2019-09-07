select * from config where 1=1
<#if configName ?exists>
and name='${configName}'
</#if>
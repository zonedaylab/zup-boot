 select * from CodeConfig where 1=1 
<#if codeconfig.configCode ?exists>
	and configcode = '${codeconfig.configCode}'
</#if>
<#if codeconfig.memo ?exists>
	and memo like '%${codeconfig.memo}%'
</#if>
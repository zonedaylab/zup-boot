select * from DEMOIBATIS where 1=1 
<#if demo.id ?exists>
	and id = ${demo.id}
</#if>
<#if demo.name ?exists>
	and name = '${demo.name}'
</#if>

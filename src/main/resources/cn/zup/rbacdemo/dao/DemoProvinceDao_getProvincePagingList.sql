select * from demoprovince where 1=1  
<#if demoProvince.name ?exists>
	and name = '${demoProvince.name}'
</#if>
<#if demoProvince.code ?exists>
	and code = '${demoProvince.code}'
</#if>
<#if sql ?exists>
	 ${sql}
</#if>
	ORDER BY id 
select * from DOMAIN_SYSTEM t where 1=1
	<#if domainSystem.relation_Id ?exists>
		and t.relation_Id =${domainSystem.relation_Id}
	</#if>
	<#if domainSystem.system_Id ?exists>
		and t.system_Id =${domainSystem.system_Id}
	</#if>
	<#if domainSystem.system_Name ?exists>
		and t.system_Name ='${domainSystem.system_Name}'
	</#if>
	<#if domainSystem.domain ?exists>
		and t.domain ='${domainSystem.domain}'
	</#if>
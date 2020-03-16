 select * from domain_system t  where 1=1
	<#if domain ?exists>
		and t.domain =  '${domain}'
	</#if>
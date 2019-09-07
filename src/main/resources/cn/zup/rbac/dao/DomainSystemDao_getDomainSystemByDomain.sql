 select * from DOMAIN_SYSTEM t  where 1=1 
	<#if domain ?exists>
		and t.domain =  '${domain}'
	</#if>
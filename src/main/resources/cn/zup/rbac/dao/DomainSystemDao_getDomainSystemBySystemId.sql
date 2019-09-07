select * from DOMAIN_SYSTEM t  where 1=1 
	<#if systemId ?exists>
		and t.system_Id =${systemId}
	</#if>
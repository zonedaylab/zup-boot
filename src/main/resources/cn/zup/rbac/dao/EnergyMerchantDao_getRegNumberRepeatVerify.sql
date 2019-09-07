select * from ENERGY_MERCHANT where 1=1  
<#if organId ?exists>
	and organid != ${organId}
</#if>
<#if regNumber ?exists>
	and reg_Number = '${regNumber}'
</#if> 


select * from ENERGY_MERCHANT where 1=1  
<#if organId ?exists>
	and organid != ${organId}
</#if>
<#if merchantName ?exists>
	and merchant_Name = '${merchantName}'
</#if> 


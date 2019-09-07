select rm.region_market_id,rm.region_Code,rm.market_id ,r.region_Name from region_market as rm 
	LEFT JOIN energy_region as r on r.REGION_CODE = rm.region_code
	where 1=1
<#if regionMarket.market_Id ?exists>
	and rm.market_id = ${regionMarket.market_Id}
</#if>
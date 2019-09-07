delete from region_market 
<#if regionMarket.market_Id ?exists>
	where market_id = ${regionMarket.market_Id}
</#if>
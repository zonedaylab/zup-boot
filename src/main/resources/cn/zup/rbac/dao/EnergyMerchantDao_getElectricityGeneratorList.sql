 select * from energy_Merchant e 
  left join organ o on o.ORGANID=e.ORGANID
 where 1=1
	and o.organType=1
	and e.merchant_Type=3
 <#if energyMerchant.merchant_Name? exists>
	and e.merchant_Name like '%${energyMerchant.merchant_Name}%'
 </#if> 
 
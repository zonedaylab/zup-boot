 select * from energy_merchant WHERE 1=1 
  <#if energyMerchant.merchant_Type?exists>
  	and merchant_Type = ${energyMerchant.merchant_Type}
  </#if>
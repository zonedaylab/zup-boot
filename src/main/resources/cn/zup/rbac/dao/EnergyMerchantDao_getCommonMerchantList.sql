 select e.organid,e.region_Code,e.merchant_Name,e.merchant_Code,e.merchant_Type,e.check_State,e.reg_Number,e.reg_Capital,e.legal_Person,
  	e.phone,e.fax,e.credit,e.postcode,e.public_Number,e.deposit_Bank,e.email,e.bank_Accout,e.account_Name,e.industry_Category,e.trade_Flag,
  	e.latitude,e.longitude,e.merchant_Scale,e.energy_Property,e.reg_User_Id,e.reg_User_Name,e.reg_Date,
  	merchantTypeConfig.subname merchantTypeString,
  	energyPropertyConfig.subname energyPropertyString,
  	tradeFlagConfig.subname tradeFlagString,
  	checkStateConfig.subname checkStateString,
  	date_format(e.reg_Date,'%Y-%c-%d') regDateString,
  	replace(e.address,'*','') as address
  	from energy_merchant e
    left join config 	merchantTypeConfig on merchantTypeConfig.subid=e.merchant_Type
  <#if energyMerchant.merchantTypeConfig?exists>
  	and merchantTypeConfig.configid=${energyMerchant.merchantTypeConfig}
  </#if>
  left join config energyPropertyConfig on energyPropertyConfig.subid=e.energy_Property
  <#if energyMerchant.energyPropertyConfig?exists>
	and energyPropertyConfig.configid=${energyMerchant.energyPropertyConfig}
	</#if>
	 left join config tradeFlagConfig on tradeFlagConfig.subid=e.trade_Flag
  <#if energyMerchant.tradeFlagConfig?exists>
	and tradeFlagConfig.configid=${energyMerchant.tradeFlagConfig}
	</#if>
	 left join config checkStateConfig on checkStateConfig.subid=e.check_State
  <#if energyMerchant.checkStateConfig?exists>
	and checkStateConfig.configid=${energyMerchant.checkStateConfig}
	</#if>
  join organ o on e.organid = o.organid 
   join energy_relation r on r.common_organ_id =e.organid 
  where 1=1
	<#if organId?exists>
 		and r.department_id=${organId}
 	</#if>
 	<#if energyMerchant.merchant_Name?exists>
 		and e.merchant_Name '%${energyMerchant.merchant_Name}%'
 	</#if>
 	<#if energyMerchant.merchant_Type?exists>
 		and e.merchant_Type =${energyMerchant.merchant_Type}
 	</#if>
 	<#if energyMerchant.trade_Flag?exists>
 		and e.trade_Flag =${energyMerchant.trade_Flag}
 	</#if>
 	<#if energyMerchant.summaryMerchantIds?exists>
 		and e.organid not in ${energyMerchant.summaryMerchantIds}
 	</#if>
 	order by e.reg_Date desc
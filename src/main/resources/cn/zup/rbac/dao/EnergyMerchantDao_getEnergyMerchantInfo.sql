  select t.organid,t.region_Code,t.merchant_Name,t.merchant_Code,t.merchant_Type,t.check_State,t.reg_Number,t.reg_Capital,t.legal_Person,
  	t.phone,t.fax,t.credit,t.postcode,t.public_Number,t.deposit_Bank,t.email,t.bank_Accout,t.account_Name,t.industry_Category,t.trade_Flag,
  	t.address,t.latitude,t.longitude,t.merchant_Scale,t.energy_Property,t.reg_User_Id,t.reg_User_Name,t.reg_Date,
  	merchantTypeConfig.subname merchantTypeString,
  	energyPropertyConfig.subname energyPropertyString,
  	tradeFlagConfig.subname tradeFlagString,
  	checkStateConfig.subname checkStateString,
  	date_format(t.reg_Date,'%Y-%c-%d') regDateString
   from ENERGY_MERCHANT t
  left join config 	merchantTypeConfig on merchantTypeConfig.subid=t.merchant_Type
  <#if energyMerchant.merchantTypeConfig?exists>
  	and merchantTypeConfig.configid=${energyMerchant.merchantTypeConfig}
  </#if>
  left join config energyPropertyConfig on energyPropertyConfig.subid=t.energy_Property
  <#if energyMerchant.energyPropertyConfig?exists>
	and energyPropertyConfig.configid=${energyMerchant.energyPropertyConfig}
	</#if>
	 left join config tradeFlagConfig on tradeFlagConfig.subid=t.trade_Flag
  <#if energyMerchant.tradeFlagConfig?exists>
	and tradeFlagConfig.configid=${energyMerchant.tradeFlagConfig}
	</#if>
	 left join config checkStateConfig on checkStateConfig.subid=t.energy_Property
  <#if energyMerchant.checkStateConfig?exists>
	and checkStateConfig.configid=${energyMerchant.checkStateConfig}
	</#if>
 where 1=1 
 <#if energyMerchant.organid?exists>
 	and t.organid=${energyMerchant.organid}
 </#if>
 
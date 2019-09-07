  select park_Id, supply_Location,voltage_Class,energy_Property,volume,price_Mode,capacity_Price,catalog_Price,peak_Price,flat_Price,valley_Price,
  	voltageClassConfig.subname voltageClassString,
  	energyPropertyConfig.subname energyPropertyString,
  	priceModeConfig.subname priceModeString
  
  from energy_Consume_Conf 
  left join config voltageClassConfig on voltageClassConfig.subid=energy_Consume_Conf.voltage_Class
  <#if energyConsume.voltageClassConfig ?exists>
  	and voltageClassConfig.configid=${energyConsume.voltageClassConfig}
  </#if>
   left join config energyPropertyConfig on energyPropertyConfig.subid=energy_Consume_Conf.energy_Property
  <#if energyConsume.energyPropertyConfig ?exists>
  	and energyPropertyConfig.configid=${energyConsume.energyPropertyConfig}
  </#if>
   left join config priceModeConfig on priceModeConfig.subid=energy_Consume_Conf.price_Mode
  <#if energyConsume.priceModeConfig ?exists>
  	and priceModeConfig.configid=${energyConsume.priceModeConfig}
  </#if>
  
  where 1=1
  	<#if energyConsume.park_Id ?exists>
  		and energy_Consume_Conf.park_Id=${energyConsume.park_Id}
  	</#if>
  	<#if energyConsume.parkIds ?exists>
  		and energy_Consume_Conf.park_Id in ${energyConsume.parkIds}
  	</#if>
  	<#if energyConsume.supply_Location ?exists>
  		and energy_Consume_Conf.supply_Location like '%${energyConsume.supply_Location}%'
  	</#if>
  	<#if energyConsume.energy_Property ?exists>
  		and energy_Consume_Conf.energy_Property=${energyConsume.energy_Property}
  	</#if>
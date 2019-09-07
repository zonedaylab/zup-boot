  select park_Id,store_Id,region_Id,department_Id,sale_Supply_Area_Id,park_Name,parent_Park_Id,park_Type,power_Company,park_Address,scada_Park_Id,
  	parkTypeConfig.subname parkTypeString, park_longitude, park_latitude
   from ENERGY_Park 
   left join config parkTypeConfig on parkTypeConfig.subid=ENERGY_Park.park_Type
   <#if energyPark.parkTypeConfig ?exists>
   		and parkTypeConfig.configid=${energyPark.parkTypeConfig}
   	</#if>
   where 1=1
    <#if energyPark.department_Id ?exists>
    	and ENERGY_Park.department_Id=${energyPark.department_Id}
    </#if>
    <#if energyPark.park_Name ?exists>
    	and ENERGY_Park.park_Name like'%${energyPark.park_Name}%'
    </#if>
    <#if energyPark.park_Type ?exists>
    	and ENERGY_Park.park_Type=${energyPark.park_Type}
    </#if>
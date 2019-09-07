	select t1.REALNAME,t1.CELLPHONE,t3.PARK_NAME stationName,t3.CITY_NAME town,t3.PROVINCE_NAME county 
	from userinfo t1 inner join  
	(select * from scada_organ where SCADA_REGION_ID in (${stationIds}) and REGION_TYPE=5) t2 
	on t1.ORGANID=t2.organ_id 
	 inner join pm_park_group_item t3 on t3.PARK_ID=t2.scada_region_id 
	 <#if realName ?exists>
		where realName like '%${realName}%'
	</#if> 
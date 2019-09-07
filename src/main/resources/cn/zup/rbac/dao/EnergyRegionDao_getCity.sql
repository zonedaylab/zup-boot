  select * from energy_region b 
 where 1=1 
  <#if provinceCode ?exists>
     and substring(b.region_code,1,2)=substring(${provinceCode},1,2)
  </#if>
 and substring(b.region_code,3,2)!='00' and substring(b.region_code,5,2)='00'
 group by b.region_code,b.region_name,b.address
select a.region_code,a.region_name,a.address
 from energy_region a
 where substring(a.region_code,-4)='0000'
 group by a.region_code,a.region_name,a.address
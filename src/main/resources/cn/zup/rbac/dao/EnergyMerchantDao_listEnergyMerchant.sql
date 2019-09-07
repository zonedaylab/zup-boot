select * from energy_merchant m
 where 1=1
 and m.MERCHANT_TYPE =1
 <#if departmentId?exists>
	and m.ORGANID in ( 
		SELECT r.COMMON_ORGAN_ID 
		 from energy_relation r 
		 where r.department_Id = ${departmentId}
	)
 </#if>
 
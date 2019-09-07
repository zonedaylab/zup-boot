 SELECT * from energy_relation r 
 where 1=1 
 
  <#if energyRelation.department_Id ?exists>
     and department_Id=${energyRelation.department_Id}
  </#if>
   <#if energyRelation.common_Organ_Id ?exists>
     and common_Organ_Id=${energyRelation.common_Organ_Id}
  </#if>
  

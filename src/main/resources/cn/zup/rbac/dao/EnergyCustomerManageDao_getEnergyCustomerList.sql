select customer_Id,region_Code,check_State,customer_Name,customer_Type,rge_Number,voltage_Class,year_Quantity,reg_Capital,legal_Person,phone,fax,credit,project_Situation,postcode,public_Number,deposit_Bank,email,bank_Account,account_Name,industry_Category,trade_Flag,address,latitude,longitude,customer_Scale,energy_Property,reg_User_Id,reg_User_Name,reg_Date 
  from energy_customer 
  where 1=1
  <#if energyCustomer.customer_Id?exists>
  	and customer_Id=${energyCustomer.customer_Id}
  </#if>
  <#if energyCustomer.startDate?exists>
  	and date_Format(reg_Date,'%Y-%m-%d %H:%i:%s')>=date_format ('${energyCustomer.startDate} 23:59:59','%Y-%m-%d %H:%i:%s') 
  </#if>
  <#if energyCustomer.endDate?exists>
  	and date_Format(reg_Date,'%Y-%m-%d %H:%i:%s')<=date_format ('${energyCustomer.endDate} 00:00:00','%Y-%m-%d %H:%i:%s') 
  </#if>
  <#if energyCustomer.reg_User_Name?exists>
  	and reg_User_Name=${energyCustomer.reg_User_Name}
  </#if>
  <#if energyCustomer.check_State?exists>
  	and check_State=${energyCustomer.check_State}
  </#if>

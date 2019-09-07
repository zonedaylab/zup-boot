 update ENERGY_MERCHANT 
    set organid = ${energyMerchant.organid}
    <#if energyMerchant.region_Code?exists>
        ,region_Code = '${ energyMerchant.region_Code}' 
    </#if>   
    <#if energyMerchant.merchant_Name?exists>
       ,merchant_Name ='${energyMerchant.merchant_Name}'
    </#if>   
    <#if energyMerchant.merchant_Code?exists>
        ,merchant_Code = '${energyMerchant.merchant_Code}' 
    </#if>   
    <#if energyMerchant.merchant_Type?exists>
        ,merchant_Type = ${energyMerchant.merchant_Type} 
    </#if>   
    <#if energyMerchant.check_State?exists>
        ,check_State = ${energyMerchant.check_State} 
    </#if>   
    <#if energyMerchant.reg_Number?exists>
        ,reg_Number = '${energyMerchant.reg_Number}' 
    </#if> 
    <#if energyMerchant.reg_Capital?exists>
        ,reg_Capital = ${energyMerchant.reg_Capital}
    </#if>  
     
    <#if energyMerchant.legal_Person?exists>
        ,legal_Person = '${energyMerchant.legal_Person}' 
    </#if>   
    <#if energyMerchant.phone?exists>
        ,phone = '${energyMerchant.phone}'
     </#if>  
    <#if energyMerchant.fax?exists>
        ,fax = '${energyMerchant.fax}' 
    </#if>   
    <#if energyMerchant.credit?exists>                      
        ,credit = ${energyMerchant.credit}
     </#if>  
    <#if energyMerchant.postcode?exists>                     
        ,postcode = '${energyMerchant.postcode}' 
    </#if>   
    <#if energyMerchant.public_Number?exists>                      
        ,public_Number = '${energyMerchant.public_Number}' 
    </#if>   
    <#if energyMerchant.deposit_Bank?exists>
        ,deposit_Bank = '${energyMerchant.deposit_Bank}' 
    </#if>   
    <#if energyMerchant.email?exists>
        ,email = '${energyMerchant.email}' 
    </#if>   
    <#if energyMerchant.bank_Accout?exists>
        ,bank_Accout = '${energyMerchant.bank_Accout}' 
    </#if>   
    <#if energyMerchant.account_Name?exists>
        ,account_Name = '${energyMerchant.account_Name}' 
    </#if>   
    <#if energyMerchant.industry_Category?exists>
        ,industry_Category = ${energyMerchant.industry_Category} 
    </#if>   
    <#if energyMerchant.trade_Flag?exists>
        ,trade_Flag =${energyMerchant.trade_Flag}
    </#if>   
    <#if energyMerchant.address?exists> 
        ,address = '${energyMerchant.address}' 
    </#if>   
    <#if energyMerchant.latitude?exists>
        ,latitude = '${energyMerchant.latitude}' 
     </#if>  
    <#if energyMerchant.longitude?exists>
        ,longitude = '${energyMerchant.longitude}' 
    </#if>   
    <#if energyMerchant.merchant_Scale?exists>
       , merchant_Scale = ${energyMerchant.merchant_Scale}
    </#if>   
    <#if energyMerchant.energy_Property?exists>
        ,energy_Property = ${energyMerchant.energy_Property} 
    </#if>   
    <#if energyMerchant.reg_User_Id?exists>
        ,reg_User_Id = ${energyMerchant.reg_User_Id} 
    </#if>   
    <#if energyMerchant.reg_User_Name?exists>
        ,reg_User_Name = '${energyMerchant.reg_User_Name}' 
    </#if>   
     <#if energyMerchant.regDateString?exists>
        ,reg_Date =  date_format('${ energyMerchant.regDateString}' ,'%Y-%c-%d %H:%i:%s')
    </#if>   
   where organid = ${energyMerchant.organid}
   
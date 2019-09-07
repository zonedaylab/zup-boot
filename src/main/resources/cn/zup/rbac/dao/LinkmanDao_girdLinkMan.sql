    select
        a.link_man_id link_man_Id,
        a.organid,
        a.linkman_name linkman_Name,
        a.mobile_phone mobile_Phone,
        a.phone,
        a.email,
        a.address,
        a.fax,
        a.post,
        a.wechat_num wechat_Num,
        a.memo 
    from
        energy_merchant_linkman a 
    where
        1=1 
    <#if energyMerchantLinkman.organid?exists>
         and a.organid=${energyMerchantLinkman.organid} 
    </#if>
     <#if energyMerchantLinkman.phone?exists>
         and a.phone like '%${energyMerchantLinkman.phone}%' 
    </#if>
     <#if energyMerchantLinkman.linkman_Name?exists>
         and a.linkman_Name like '%${energyMerchantLinkman.linkman_Name}%' 
    </#if>
    ORDER BY
        a.link_man_id desc
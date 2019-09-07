 select * 
 from wechat_system sys
 where 1=1

<#if wechatSystem.company_Id?exists>
	and sys.company_id = ${wechatSystem.company_Id}
</#if>

<#if wechatSystem.system_Id?exists>
	and sys.system_id = ${wechatSystem.system_Id}
</#if>



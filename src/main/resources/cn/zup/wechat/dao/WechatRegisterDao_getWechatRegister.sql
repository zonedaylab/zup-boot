select * from  wechat_register where 1=1
<#if wechatRegister.registerId ? exists>
	and register_id = ${ wechatRegister.registerId}
</#if>
<#if wechatRegister.systemId ? exists>
	and company_id = ${ wechatRegister.systemId}
</#if>
<#if wechatRegister.registerName ? exists>
	and register_name = '${ wechatRegister.registerName}'
</#if>
<#if wechatRegister.registerPwd ? exists>
	and register_pwd = '${ wechatRegister.registerPwd}'
</#if>
<#if wechatRegister.wxAccount ? exists>
	and wx_account = '${ wechatRegister.wxAccount}'
</#if>

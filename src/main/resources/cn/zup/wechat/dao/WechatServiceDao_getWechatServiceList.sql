select ws.SERVICE_ID,ws.SERVICE_NAME,ws.SERVICE_ACCOUNT,ws.APPID,ws.APPSECRET,ws.ORIGINAL_ID,
ws.TOKEN_NAME,configvf.SUBNAME validFlagStr from wechat_server ws 
join config configvf on  ws.VALIDFLAG = configvf.SUBID 
where 1=1 
and configvf.CONFIGID = ${ ws.validFlagStr} 
<#if ws.service_Name ? exists>
	and ws.SERVICE_NAME like '%${ ws.service_Name}%'
</#if>
<#if ws.service_Account ? exists>
	and ws.SERVICE_ACCOUNT like '%${ ws.service_Account}%'
</#if>
<#if ws.validFlag ? exists>
	and ws.VALIDFLAG = '${ ws.validFlag}'
</#if>
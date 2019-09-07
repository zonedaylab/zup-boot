SELECT 
ws.APPID,ws.APPSECRET,ws.SERVICE_ID,ws.TOKEN_NAME,ws.VALIDFLAG,
wt.REQUEST_URL,wt.SKIP_URL,wt.TEMPLATE_ID,wt.TEMP_ID,wt.TOP_COLOR,
wsys.COMPANY_ID,wsys.IMG_URL,wsys.REGION_ID,wsys.SYSTEM_ID,wsys.SYSTEM_URL 
FROM wechat_template wt 
JOIN wechat_server ws ON wt.SERVICE_ID = ws.SERVICE_ID
JOIN wechat_system wsys ON ws.SERVICE_ID = wsys.SERVICE_ID
 WHERE 1=1

<#if wsys.system_Id?exists>
	AND wsys.SYSTEM_ID = ${ wsys.system_Id}
</#if>
<#if wsys.region_Id?exists>
	AND wsys.REGION_ID = ${ wsys.region_Id}
</#if>
<#if wsys.tempId?exists>
	AND wt.TEMP_ID = ${ wsys.tempId}
</#if>

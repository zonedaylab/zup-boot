select sys.SYSTEM_URL,sys.REGION_ID,sys.IMG_URL,s.SYSTEMNAME SYSTEM_NAME, ws.SERVICE_NAME,sys.COMPANY_ID,sys.COMPANY_NAME
from wechat_system sys
JOIN wechat_server ws ON sys.SERVICE_ID = ws.SERVICE_ID
JOIN system s ON sys.SYSTEM_ID = s.SYSTEMID
where 1=1

<#if wsys.service_ID?exists>
	and sys.SERVICE_ID = ${wsys.service_ID}
</#if>
<#if wsys.system_Id?exists>
	and sys.SYSTEM_ID = ${wsys.system_Id}
</#if>
<#if wsys.company_Name?exists>
	and sys.COMPANY_NAME like '%${wsys.company_Name}%'
</#if>
<#if wsys.region_Id?exists>
	and sys.REGION_ID = ${wsys.region_Id}
</#if>

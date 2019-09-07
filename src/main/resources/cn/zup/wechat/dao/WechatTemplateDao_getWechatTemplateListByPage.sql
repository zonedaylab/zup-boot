select wt.TEMP_ID,wt.TEMP_NAME,wt.TEMPLATE_ID,wt.SKIP_URL,wt.REQUEST_URL,wt.TOP_COLOR,wt.SERVICE_ID ,ws.SERVICE_NAME
  from wechat_template wt 
 join wechat_server ws on  wt.SERVICE_ID = ws.SERVICE_ID 

where 1=1  
<#if wt.temp_NAME?exists>
	and wt.TEMP_NAME like '%${ wt.temp_NAME}%'
</#if>
<#if wt.service_Id?exists>
	and wt.SERVICE_ID = ${ wt.service_Id}
</#if>
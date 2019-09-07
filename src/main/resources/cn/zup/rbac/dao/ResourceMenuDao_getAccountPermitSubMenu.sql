select  menu.menuid,menu.mobileflag, menu.systemid, menu.flowid, menu.parentmenuid, menu.menuname, menu.iconstyle, menu.ORDERCODE,menu.namespace,menu.urladdress,menu.formaddress,rolemenu.menupermission  from menu 
left join rolemenu on menu.menuid=rolemenu.menuid	
left join accountrole on accountrole.roleid=rolemenu.roleid		
	where 1=1 			
<#if accountId ?exists>
	and accountid = ${accountId}
</#if>
<#if parentMenuId ?exists>
	and parentMenuid = ${parentMenuId} 
</#if>
<#if mobileFlag ?exists>
	and menu.mobileFlag = ${mobileFlag} 
</#if>
group by  menu.menuid,menu.mobileflag,menu.flowid, menu.systemid, menu.parentmenuid, menu.menuname, menu.iconstyle, menu.ORDERCODE,menu.namespace,menu.urladdress,menu.formaddress,rolemenu.menupermission
order by   PARENTMENUID,ORDERCODE
			
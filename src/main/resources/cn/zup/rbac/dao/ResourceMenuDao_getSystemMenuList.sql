select * from menu where 1=1
 <#if menu.menuId ?exists>
	and menuId = ${menu.menuId} 
 </#if> 
 <#if menu.systemId ?exists>
	and systemId = ${menu.systemId} 
 </#if>
 <#if menu.parentMenuId ?exists>
	and parentMenuId = ${menu.parentMenuId} 
 </#if>
 <#if menu.menuName ?exists>
	and menuName = '${menu.menuName}' 
 </#if>
 <#if menu.orderCode ?exists>
	and orderCode = ${menu.orderCode} 
 </#if>
  <#if menu.nameSpace ?exists>
	and nameSpace = '${menu.nameSpace}' 
 </#if> 
 <#if menu.urlAddress ?exists>
	and urlAddress = '${menu.urlAddress}' 
 </#if>
 <#if menu.formAddress ?exists>
	and formAddress = '${menu.formAddress}' 
 </#if>
 <#if menu.flowId ?exists>
	and flowId  = ${menu.flowId} 
 </#if>
 <#if menu.mobileFlag ?exists>
	and mobileFlag = ${menu.mobileFlag} 
 </#if>
 order by systemId,mobileFlag desc,orderCode
 

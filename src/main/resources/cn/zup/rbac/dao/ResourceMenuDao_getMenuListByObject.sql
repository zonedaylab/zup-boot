	SELECT m.* FROM menu m
	JOIN rolemenu rm ON m.MENUID = rm.MENUID
	JOIN accountrole ar ON rm.ROLEID = ar.ROLEID
	JOIN account a ON ar.ACCOUNTID = a.ACCOUNTID
	WHERE 1=1
	<#if accountId ?exists>
		AND a.ACCOUNTID = ${accountId}
	</#if>
	<#if menu.menuId ?exists>
		AND m.MENUID = ${menu.menuId}
	</#if>
	<#if menu.systemId ?exists>
		AND m.SYSTEMID = ${menu.systemId}
	</#if>
	<#if menu.parentMenuId ?exists>
		AND m.PARENTMENUID = ${menu.parentMenuId}
	</#if>
	<#if menu.menuName ?exists>
		AND m.MENUNAME LIKE '${menu.menuName}%'
	</#if>
	<#if menu.orderCode ?exists>
		AND m.ORDERCODE = ${menu.orderCode}
	</#if>
	<#if menu.iconStyle ?exists>
		AND m.ICONSTYLE LIKE '${menu.iconStyle}%'
	</#if>
	<#if menu.nameSpace ?exists>
		AND m.NAMESPACE LIKE '${menu.nameSpace}%'
	</#if>
	<#if menu.urlAddress ?exists>
		AND m.URLADDRESS LIKE '${menu.urlAddress}%'
	</#if>
	<#if menu.formAddress ?exists>
		AND m.FORMADDRESS LIKE '${menu.formAddress}%'
	</#if>
	<#if menu.flowId ?exists>
		AND m.FLOWID = ${menu.flowId}
	</#if>
	<#if menu.mobileFlag ?exists>
		AND m.MOBILEFLAG = ${menu.mobileFlag}
	</#if>
	
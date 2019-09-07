select * from Action where 1=1 
<#if action.menuId ?exists>
	and menuid =${action.menuId}
</#if>
ORDER BY actionid DESC

select *
from action
where 1=1
<#if action.menuId ?exists >
   and menuid = ${action.menuId}
</#if>
<#if action.actionCode ?exists>
   and actioncode like '%${action.actionCode}%'
</#if>

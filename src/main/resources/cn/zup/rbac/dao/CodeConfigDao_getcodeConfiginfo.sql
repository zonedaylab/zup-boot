select * from codeconfig where 1=1
<#if configID ?exists >
and configID=${configID}
</#if>
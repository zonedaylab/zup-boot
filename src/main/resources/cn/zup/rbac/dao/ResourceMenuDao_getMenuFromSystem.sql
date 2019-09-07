select * from menu where 1=1
<#if system ?exists>
and systemid=${system}
</#if>
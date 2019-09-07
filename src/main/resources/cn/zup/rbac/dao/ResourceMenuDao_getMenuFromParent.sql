select * from menu where 1=1
<#if parentMenu ?exists>
and parentMenuid=${parentMenu}
</#if>
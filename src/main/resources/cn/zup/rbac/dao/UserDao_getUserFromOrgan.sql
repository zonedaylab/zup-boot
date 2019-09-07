select * from userinfo where 1=1
<#if organId ?exists>
and  organId=${organId}
</#if>
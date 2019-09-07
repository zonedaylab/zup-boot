
select o.* 
from Organ o 
inner join UserInfo u on o.organid=u.organid
 where 1=1
<#if ui.userId ?exists>
	and u.userid =${ui.userId}
</#if>










select t.CONFIGID,t.SUBID,t.NAME,t.SUBNAME from CONFIG t
where 1=1
<#if config.name ?exists>
	and t.NAME like '%${config.name}%'
</#if>
<#if config.subname ?exists>
	and t.SUBNAME like '%${config.subname}%'
</#if>
order by t.CONFIGID desc
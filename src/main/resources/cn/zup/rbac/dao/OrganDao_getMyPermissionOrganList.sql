select count(b.oid) childCounts,organ.GOVERNOR,organ.ORDERCODE,organ.ORGANCODE,organ.ORGANID,organ.ORGANNAME,organ.ORGANTYPE,organ.PARENTORGANID,organ.SHORTNAME,organ.VALIDFLAG,
validflagconfig.subname validflagstring,
organtypeconfig.subname organtypestring  from organ
left join config validflagconfig on  validflagconfig.subid=organ.validFlag 
<#if validFlag ?exists>
	and validflagconfig.configid =  ${validFlag}
</#if>
left join config organtypeconfig on  organtypeconfig.subid=organ.organType
<#if organType ?exists>
	and organtypeconfig.configid =  ${organType}
</#if>
LEFT JOIN (
	SELECT
		ORGANID AS oid,
		PARENTORGANID AS parid
	FROM
		organ
) AS B ON organ.ORGANID = B.parid
where 1=1
<#if parentOrganId ?exists>
	and parentOrganId =  ${parentOrganId}
</#if>
<#if myOrganIds ?exists>
	and organ.ORGANID in  ${myOrganIds}
</#if>
<#if excludeOrganIds ?exists>
	and organ.ORGANID not in  ${excludeOrganIds}
</#if>
GROUP BY
	organ.GOVERNOR,
	organ.ORDERCODE,
	organ.ORGANCODE,
	organ.ORGANID,
	organ.ORGANNAME,
	organ.ORGANTYPE,
	organ.PARENTORGANID,
	organ.SHORTNAME,
	organ.VALIDFLAG,
	validflagconfig.subname,
	organtypeconfig.subname

order by orderCode

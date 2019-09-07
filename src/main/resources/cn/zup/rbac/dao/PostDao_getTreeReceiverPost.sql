SELECT postid,postname from post p where 1=1 
 and p.ORGANID in(
		SELECT o.ORGANID from organ o where 1=1 
		<#if parentOrganId ?exists>
	       and o.PARENTORGANID = ${parentOrganId}
        </#if>
)


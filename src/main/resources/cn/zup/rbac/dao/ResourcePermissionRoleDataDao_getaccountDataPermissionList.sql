select * from roledata 
	join accountrole on accountrole.roleid=roledata.roleid
where 1=1 
<#if account ?exists>
	and accountid = ${account}
</#if>
<#if menu ?exists>
	and menuid =${menu}
</#if>
<#if type ?exists>
	and datapermissiontype =${type.value}
</#if>

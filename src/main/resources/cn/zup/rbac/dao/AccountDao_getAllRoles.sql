select distinct role.roleid,parentroleid,rolename,rolelimit,
 roletypeconfig.subname roleTypeString from role
 left join config roleTypeConfig on roleTypeConfig.subid=role.roleType
<#if role.roleTypeConfig ?exists>
	and roleTypeConfig.configid = ${role.roleTypeConfig}
</#if> 
 left join accountrole ar on ar.roleid = role.roleid 
    left join account a on ar.accountid = a.accountid
  where 1=1 
<#if role.roleName ?exists>
	and rolename like '%${role.roleName}%'
</#if>
<#if role.roleType ?exists>
	and roletype = ${role.roleType}
</#if>

<#if role.accountName ?exists>
	and a.accountname like '%${role.accountName}%'
</#if>
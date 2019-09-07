select actionid,rolemenu.menuid,dataid,accountid from role
inner join roleaction on role.roleId =roleaction.roleid 
inner join rolemenu on role.roleId= rolemenu.roleid
inner join roledata on role.roleId =roledata.roleid
inner join accountrole on role.roleId =accountrole.roleid
  where 1=1 
<#if role.roleId ?exists>
	and role.roleId = ${role.roleId}
</#if>
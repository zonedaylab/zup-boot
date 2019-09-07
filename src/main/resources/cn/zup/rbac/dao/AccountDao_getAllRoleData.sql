

select roledata.menuid,roledata.dataid,roledata.roleid,
 roledata.datapermissiontype,
 roledata.datapermission,menu.menuname ,
config.SUBNAME  datapermissiontypestring
  from roledata join menu on menu.menuid=roledata.menuid  
join config on  roledata.datapermissiontype = config.SUBID
  where 1=1 and config.CONFIGID = ${dataPermissionType}
<#if roledata.roleId ?exists>
	and roledata.roleid = ${roledata.roleId}
</#if>
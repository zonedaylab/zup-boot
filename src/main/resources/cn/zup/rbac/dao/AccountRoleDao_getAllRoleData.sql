select roledata.menuId,roledata.dataId,roledata.roleId,
 dataPermissionConfig.subname datapermissionstring,
 roledata.dataPermission,menu.menuName 
  from roledata
  left join config datapermissionconfig on datapermissionconfig.subid=roledata.dataPermissionType
  <#if roledata.dataPermissionConfig ?exists>
  	and dataPermissionConfig.configid=${roledata.dataPermissionConfig}
  </#if>
   join menu on menu.menuId=roledata.menuId  
  where 1=1 
<#if roledata.roleId ?exists>
	and roledata.roleId = ${roledata.roleId}
</#if>
<#if roledata.dataPermissionType ?exists>
	and roledata.dataPermissionType = ${roledata.dataPermissionType}
</#if>
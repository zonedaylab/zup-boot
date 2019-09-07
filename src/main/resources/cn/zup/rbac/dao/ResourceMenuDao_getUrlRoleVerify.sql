select count(*)  from menu join rolemenu on menu.menuid = rolemenu.menuid
       join accountrole on rolemenu.roleid = accountrole.roleid 
       where accountrole.accountid = ${accountid}  and menu.urladdress = '${url}'
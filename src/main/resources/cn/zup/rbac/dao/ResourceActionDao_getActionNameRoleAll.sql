select actionname from action join roleaction on action.actionid = roleaction.actionid
       join accountrole on accountrole.roleid = roleaction.roleid
       where action.menuid = ${menuid} and accountrole.accountid = ${accountid}
       
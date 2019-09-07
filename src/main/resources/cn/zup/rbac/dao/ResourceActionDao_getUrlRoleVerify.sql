select count(*)  from action join roleaction on roleaction.actionid = action.actionid
       join accountrole on roleaction.roleid = accountrole.roleid 
       where accountrole.accountid= ${accountId}  and action.actioncode = '${url}'
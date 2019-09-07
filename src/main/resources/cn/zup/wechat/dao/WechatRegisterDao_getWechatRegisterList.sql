select 
w.register_id,
w.register_name,
w.bind_date,
s.systemname registerPwd,
u.realname wx_account
 from  wechat_register w 
 join  WECHAT_SYSTEM ws on w.company_id = ws.company_id
 join system s  on ws.system_id  = s.systemid
 join account a on w.register_name = a.accountname
 join userinfo u on a.userid = u.userid
 where 1=1
<#if wr.systemId?exists>
	 and company_id = ${ wr.systemId}
</#if>
<#if wr.registerName?exists>
	and register_name like '%${ wr.registerName}%'
</#if>
<#if wr.wxAccount?exists>
	and wx_account = '${ wr.wxAccount}'
</#if>
<#if wr.registerPwd?exists>
	and w.bind_date <= date_format('${ wr.registerPwd} 23:59:59', '%Y-%c-%d %H:%i:%s')
	and w.bind_date >= date_format('${ wr.registerPwd} 00:00:00', '%Y-%c-%d %H:%i:%s')
</#if>


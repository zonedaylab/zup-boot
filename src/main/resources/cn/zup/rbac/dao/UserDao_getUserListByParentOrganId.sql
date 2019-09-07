select * from userinfo u where u.ORGANID in (  
  SELECT o.ORGANID  from organ o where o.PARENTORGANID =${organId}
  ) 

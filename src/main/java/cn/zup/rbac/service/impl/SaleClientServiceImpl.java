package cn.zup.rbac.service.impl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.zup.rbac.dao.SaleClientDao;
import cn.zup.rbac.entity.SaleClient;
import cn.zup.rbac.service.SaleClientService;


@Service("saleClientService")
public class SaleClientServiceImpl implements SaleClientService{
	@Autowired
	public SaleClientDao saleClientDao;
	
	public List<SaleClient> getSaleClientList(SaleClient saleClient) throws SQLException{
		return saleClientDao.getSaleClientList(saleClient);
	}

}

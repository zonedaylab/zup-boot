package cn.zup.rbac.service;

import java.sql.SQLException;
import java.util.List;

import cn.zup.rbac.entity.SaleClient;

public interface SaleClientService {
	
	public List<SaleClient> getSaleClientList(SaleClient saleClient) throws SQLException;
}

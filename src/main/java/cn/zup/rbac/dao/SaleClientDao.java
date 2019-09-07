package cn.zup.rbac.dao;

import java.util.List;

import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import cn.zup.rbac.entity.SaleClient;

@MiniDao
public interface SaleClientDao {
	@Arguments({"entity"})
	@ResultType(SaleClient.class)
	public List<SaleClient> getSaleClientList(SaleClient entity);
}
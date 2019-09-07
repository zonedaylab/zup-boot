package cn.zup.rbac.dao;

import java.util.List;

import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;

import cn.zup.rbac.entity.DomainSystem;
import cn.zup.rbac.entity.Organ;


@MiniDao
public interface DomainSystemDao extends MiniDaoSupportHiber<DomainSystem>{
	@Arguments({"domain"})
	DomainSystem getDomainSystemByDomain(String domain);
	@Arguments({"systemId"})
	DomainSystem getDomainSystemBySystemId(Integer systemId);
	@Arguments({"domainSystem"})
	List<DomainSystem> getDomainSystemList(DomainSystem domainSystem); 
	
			
}

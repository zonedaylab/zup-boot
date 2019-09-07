package cn.zup.rbac.dao;
import java.util.List;

import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.rbac.controller.ViewEntity.RoleDataViewModel;
import cn.zup.rbac.entity.Account;
import cn.zup.rbac.entity.AccountRole;
import cn.zup.rbac.entity.RoleData;

@MiniDao
public interface AccountRoleDao extends MiniDaoSupportHiber<AccountRole> {
	@Arguments({"account","role"})
	List<AccountRole> getAccountRoleInfo(Integer accountId, Integer role);
	@Arguments({"roledata","page", "rows"})
	@ResultType(RoleDataViewModel.class)
	public MiniDaoPage<RoleDataViewModel> getAllRoleData(RoleData roledata, int page, int rows);
		

}

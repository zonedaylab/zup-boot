package cn.zup.rbac.dao;
import cn.zup.rbac.controller.ViewEntity.RoleDataViewModel;
import cn.zup.rbac.entity.AccountRole;
import cn.zup.rbac.entity.RoleData;
import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import java.util.List;

@MiniDao
public interface AccountRoleDao extends MiniDaoSupportHiber<AccountRole> {
	@Arguments({"account","role"})
	List<AccountRole> getAccountRoleInfo(Integer account, Integer role);
	@Arguments({"roledata","page", "rows"})
	@ResultType(RoleDataViewModel.class)
	public MiniDaoPage<RoleDataViewModel> getAllRoleData(RoleData roledata, int page, int rows);
		

}

package cn.zup.rbac.dao;

import cn.zup.rbac.entity.Account;
import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import java.util.List;

@MiniDao
public interface AccountOperateDao extends MiniDaoSupportHiber<Account> {
	@Arguments({"account"})
	List<Account> getAccountSonTable(Account account);
	@Arguments({"accountId","userId","accountName"})
	List<Account> getAccountRepeatVerify(Integer accountId, Integer userId, String accountName);
	@Arguments({"account","page", "rows"})
	@ResultType(Account.class)
	public MiniDaoPage<Account> getAccountPagingList(Account account, int page, int rows);
	@Arguments("roleId")
	List<Account> getRoleAccountList(int roleId);
	@Arguments({"account","organId","page", "rows"})
	@ResultType(Account.class)
	public MiniDaoPage<Account> getAccountByOrganPagingList(Account account, Integer organId, int page, int rows);
}

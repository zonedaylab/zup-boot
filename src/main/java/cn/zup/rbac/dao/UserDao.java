package cn.zup.rbac.dao;

import cn.zup.rbac.entity.Account;
import cn.zup.rbac.entity.UserInfo;
import cn.zup.rbac.entity.UserSession;
import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import java.util.List;

@MiniDao
public interface UserDao extends MiniDaoSupportHiber<UserInfo>{

	@Arguments({"accountName","passWord"})
	public List<UserSession> getUserSessionInfo(String accountName, String passWord);
	@Arguments({"accountId"})
	public Account getUserFromAccount(int accountId);
	@Arguments({"userId"})
	public List<UserInfo> getUserSonTable(Integer userId);
	
	@Arguments({"organId","postId","realName","validFlag"})
	public List<UserInfo> getUserListByCondition(Integer organId, Integer postId, String realName, Integer validFlag);
	@Arguments({"organId"})
	public List<UserInfo> getUserFromOrgan(int organId);
	@Arguments({"postId"})
	public List<UserInfo> getUserFromPost(int postId);
	@Arguments({"accountName","passWord"})
	public List<Account> getUserFromAccount(String accountName, String passWord);
	@Arguments({"accountName","passWord"})
	public List<UserSession> getUserSession(String accountName, String passWord);
	@Arguments({"accountId"})
	public List<UserSession> getUserSessionByAccountid(int accountId);
	@Arguments({"organId"})
	public List<Account> getorganAccountList(int organId);
	@Arguments({"userId"})
	public void deleteUserFromAccount(int userId);
	@Arguments({"userId"})
	public void deleteUserFromOperatelog(int userId);
	@Arguments({"user","page", "rows"})
	@ResultType(UserInfo.class)
	public MiniDaoPage<UserInfo> getAllUsers(UserInfo user, int page, int rows);
	@Arguments({"accountName","passWord"})
	public Integer getAccountId(String accountName, String passWord);
	@Arguments({"userId","realName"})
	List<UserInfo> getUserRepeatVerify(Integer userId, String realName);
	@Arguments({"password","accountId"})
	public int updatePassword(String password, Integer accountId);
	@Arguments({"stationIds","realName"})
	public List<UserInfo> getUserInfoList(String stationIds, String realName);
	@Arguments({"organId"})
	@ResultType(UserInfo.class)
	public List<UserInfo> getUserListByParentOrganId(Integer organId);
	@Arguments({"mySubOrganIds"})
	@ResultType(UserInfo.class)
	public UserInfo getSubUserIds(String mySubOrganIds);
	@Arguments({"roleId"})
	@ResultType(UserInfo.class)
	public List<UserInfo> getRoleUserList(Integer roleId);
	
	
}

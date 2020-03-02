package cn.zup.rbac.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.rbac.entity.*;

public interface UserService {
	
	/**
	 * 获取当前用户信息
	 * @Author liuxf
	 * @Date   20160730
	 * @param request
	 * @return
	 */
	public  UserSession getCurrentHandler(HttpServletRequest request);
	/**
	 * 通过账户名和密码获取用户会话信息
	 * 
	 * @param accountName
	 *            账户名称
	 * @param password
	 *            密码
	 * @return
	 */
	
	UserSession getUserSessionInfo(String accountName, String passWord);

	/**
	 * 通过账户id获取用户会话信息
	 * 
	 * @param account
	 *            账户ID
	 * @return
	 */
	
	UserSession getUserSessionInfoByAccountID(int accountId);

	/**
	 * 添加用户
	 * 
	 * @param user
	 *            用户信息
	 */
	
	int addUser(UserInfo user);

	/**
	 * 删除用户
	 * 
	 * @param user
	 *            用户
	 * @param physicalDelete
	 *            物理删除标识，TURE为物理删除
	 */
	
	void deleteUser(UserInfo user, boolean physicalDelete);

	/**
	 * 更新用户
	 * 
	 * @param user
	 *            用户信息
	 */
	
	void updateUser(UserInfo user);

	/**
	 * 验证用户重复(或是否与其他重复)，true为重复
	 * 
	 * @param user
	 *            用户ID，可为空
	 * @param realName
	 *            用户名称
	 */
	
	boolean getUserRepeatVerify(Integer userId, String realName);

	/**
	 * 获取用户信息
	 * 
	 * @param user
	 *            用户ID
	 * @return
	 */
	
	UserInfo getUserInfo(int userId);

	/**
	 * 获取账户对应的用户信息
	 * 
	 * @param account
	 *            账户ID
	 * @return
	 */
	
	UserInfo getAccountUserInfo(int accountId);

	/**
	 * 获取条件下用户列表
	 * 
	 * @param organ
	 *            组织ID，可为空
	 * @param post
	 *            岗位ID，可为空
	 * @param realName
	 *            用户姓名
	 * @param valueFlag
	 *            有效性，可为空
	 * @return
	 */
	
	List<UserInfo> getUserList(Integer organId, Integer postId, String realName, Integer validFlag);
	/**
	 * 根据userid获取用户关联的的子表关系
	 * @param userId
	 * @return
	 */
	List<UserInfo> getUserSonTable(Integer userId);
	/**
	 * 用户分页列表
	 * 
	 * @param organ
	 *            组织ID，可为空
	 * @param post
	 *            岗位ID，可为空
	 * @param realName
	 *            用户姓名
	 * @param valueFlag
	 *            有效性，可为空
	 * @param pageSize
	 *            分页行数
	 * @param pageination
	 *            页码
	 * @return
	 */
	
	MiniDaoPage<UserInfo> getUserPagingList(UserInfo user, int page, int rows);

	/**
	 * 获取组织下用户列表
	 * 
	 * @param organ
	 *            组织
	 * @return
	 */
	
	List<UserInfo> getOrganUserList(int organId);

	/**
	 * 获取岗位下用户列表
	 * 
	 * @param post
	 *            岗位
	 * @return
	 */
	
	List<UserInfo> getPostUserList(int postId);
	/**
	 * 根据账户id修改账户密码
	 * @param accountId
	 * @param password
	 */
	int updatePassword(String password, int accountId);
	
	List<UserInfo> getUserInfoList(String stationIds, String realName);
	/**
	 * 获取给定一个organId下所有的包括子组织下的所有的用户集合
	 * lixin
	 * 2017-9-22 16:04:53
	 * @param organId
	 * @return
	 */
    List<UserInfo> getUserListByParentOrganId(Integer organId);
    /**
     * 通过当前登录人所属的公司类型，获取权限范围内的所有的用户集合
     * 电力用户操作者审核人配置时，售电公司可以接受电力用户的工作使用
     * lixin
     * 2018-2-6 15:03:58
     * @param organ
     * @return
     */
    List<UserInfo> getMyUserListCheck(Organ organ);
    /**
     * 根据权限内的组织机构，获取权限内的人员
     * lixin
     * 2018-2-6 16:35:33
     * 过滤操作日志使用
     * @param mySubOrganIds
     * @return
     */
	public String getSubUserIds(String mySubOrganIds);
	/**
	 * 通过角色查询所有用户
	 * lixin
	 * 2018-3-28 10:00:22
	 * 工作流操作者同角色过滤用户使用
	 * @param roleId
	 * @return
	 */
	public List<UserInfo> getRoleUserList(Integer roleId);
}

package cn.zup.rbac.service;

import cn.zup.rbac.entity.Organ;
import cn.zup.rbac.entity.Post;
import cn.zup.rbac.entity.UserInfo;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import java.util.HashMap;
import java.util.List;
/**
 * OrganPostService接口
 * @author 李欣
 * time：2016/07/29
 *
 */
public interface OrganPostService {
	
	/**
	 * 添加组织
	 * 
	 * @param organ:organ实体
	 *      
	 */	
	int addOrgan(Organ organ);

	/**
	 * 删除组织
	 * 
	 * @param organ:organ实体
	 *           
	 */	
	 void deleteOrgan(Organ organ);

	/**
	 * 更新组织
	 * 
	 * @param organ:organ实体
	 *           
	 */	
	void updateOrgan(Organ organ);

	/**
	 * 组织重复验证(获取其他重复)，true为重复
	 * 
	 * @param organId:组织ID，可为空
	 * @param parentOrganId:父组织
	 * @param organName:组织名称
	 * @return
	 */	
	boolean getOrganRepeatVerify(Integer organId, Integer parentOrganId, String organName);
	/**
	 * 组织排序号重复验证
	 * @param organId
	 * @param parentOrganId
	 * @param organCode
	 * @return
	 */
	boolean getOrderCodeRepeatVerify(Integer organId, Integer ParentOrganId, Integer orderCode);
	/**
	 * 组织信息
	 * 
	 * @param organId：组织id
	 * 
	 * @return
	 */
	Organ getOrganInfo(int organId);
	
	/**
	 * 获取全部组织列表
	 * 
	 * @return
	 */	
	List<Organ> getOrganList();

	/**
	 * 获取子级组织列表
	 * 
	 * @param parentOrganId  父级组织
	 * @return
	 */
	List<Organ> getSubOrganList(int parentOrganId);

	/**
	 * 添加岗位
	 * 
	 * @param post：岗位实体
	 */
	
	
	int addPost(Post post);

	/**
	 * 删除岗位
	 * 
	 * @param post：岗位实体
	 *          
	 */
	void deletePost(int postId);

	/**
	 * 更新岗位
	 * 
	 * @param post：岗位实体
	 */
	void updatePost(Post post);

	/**
	 * 岗位重复验证(获取其他重复)，true为重复
	 * 
	 * @param postId：岗位ID,可为空
	 * @param organId: 组织ID
	 * @param postName:岗位名称
	 * @return
	 */
	boolean getPostRepeatVerify(Integer postId, Integer organId, String postName);

	/**
	 * 获取岗位详情
	 * 
	 * @param postId：岗位ID,
	 *            
	 * @return
	 */
	Post getPostInfo(int postId);

	/**
	 * 获取条件下的岗位信息
	 * 
	 * @param organId：组织ID
	 * @param postName：岗位名称
	 * @param validFlag：有效性
	 * @return
	 */
	List<Post> getPostList(Integer organId, String postName, Integer validFlag);

	/**
	 * 岗位分页列表
	 * 
	 * @param post：岗位实体
	 * @param pageSize：分页行数
	 * @param pageination：页码
	 * @return
	 */
	MiniDaoPage<Post> getPostPagingList(Post post, int page, int rows);

	/**
	 * 获取组织下岗位列表
	 * 
	 * @param organId：组织id
	 *            
	 * @return
	 */
	List<Post> getOrganPostList(int organId);
	
	/**
	 * 获取组织下有效的岗位列表
	 * 
	 * @param organId：组织id
	 *            
	 * @return
	 */
	List<Post> getOrganPostFlagList(int organId);
	/**
	 * pms和zup数据表分开，
	 * 2017-7-17 11:00:20
	 * @param ui
	 * @return
	 */
	Organ getOrganName(UserInfo ui);
	/**
	 * 针对售电平台，根据权限加载组织机构
	 * lixin
	 * 2018-1-26 14:37:55
	 * @param parentOrganId
	 * @param myOrganIds
	 * @return
	 */
	List<Organ> getMySubOrganList(int parentOrganId, String myOrganIds);
	/**
	 * 根据一个组织机构，获取该组织机构下所有的岗位
	 * @param parentOrganId
	 * @param myOrganIds
	 * @return
	 */
	List<Post> getTreeReceiverPost(int parentOrganId, String myOrganIds);
	
	/***
	 * 通过部件ID获取所有部件
	 * @param organId
	 * @return
	 */
	String getMySubOrganIdsAll(int organId);
	
	/***
	 * 获取某几个层级的组织机构
	 * @param organId  根级别
	 * @param level  获取第2层的数据
	 * @param organType 是否获取某些特点类型的组织机构  如果0 则不额外增加 解决某些特殊组织类型的如 单列市
	 * @return
	 */
	List<Organ> getOrganLevel(int organId, int level, int organType);
	
	/***
	 * 获取某几个层级的组织机构
	 * @param organId  根级别
	 * @param level  获取几层
	 * @param organType 是否获取某些特点类型的组织机构  如果0 则不额外增加 解决某些特殊组织类型的如 单列市
	 * @param excludeOrganIds 去除的组织 逗号隔开 如 1,2,3
	 * @param flag 是否包含传递组织单位的这一条数据
	 * @return
	 */
	List<Organ> getOrganForLevel(int organId, int level, int organType, String excludeOrganIds, boolean flag);
	

	/**
	 * 3	通过组织ID、职能、级别获取组织列表
	 * @param organId  本级organId
	 * @param used 财务职能
	 * @param levelType 1 本级 2上级（一层） 3 下级（一层）
	 * @return
	 */
	List<Organ> GetOrganUsed(int organId, int used, int levelType);
	
	/***
	 * 通过职能获取下级相同职能的组织列表
	 * @param parentOrganId 父ID
	 * @param usedStr 职能字符串 如1,2
	 * @return
	 */
	List<Organ> getSubOrganByUsedList(int parentOrganId, String usedStr);

	/***
	 * 获取organ列表
	 * @param organ
	 * @return
	 */
	public List<Organ> getOrganList(Organ organ);
	/**
	 * 获取所有组织所有子节点 返回值Map
	 *
	 * @return
	 */
	public HashMap<Long, List<Integer>> getOrganSubNodeList(Integer organId);

	/**
	 * 获取某个组织所有子节点 返回值List
	 *
	 * @return
	 */
	public String getMySubOrganIds(int organId);
	
}

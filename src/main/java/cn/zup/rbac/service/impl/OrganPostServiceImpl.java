package cn.zup.rbac.service.impl;

import java.util.List;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.zup.rbac.dao.OrganDao; 
import cn.zup.rbac.dao.PostDao; 
import cn.zup.rbac.entity.*;
import cn.zup.rbac.service.*;
import cn.zup.rbac.service.settings.ConfigOrganType;
import cn.zup.rbac.service.settings.ConfigSetting;

/**
 * OrganPostService的实现类
 * @author 李欣
 * time:2016/7/29
 *
 */
	@Service("organPostService")
	public class OrganPostServiceImpl implements OrganPostService {
		@Autowired
		private OrganDao organDao;
		@Autowired
		private PostDao postDao; 

	/**
	 * 添加组织
	 * 
	 * @param organ
	 */
	public int addOrgan(Organ organ) {		
		organDao.saveByHiber(organ);		
		return organ.getOrganId();
	}
	
	/**
	 * 删除组织
	 * 
	 * @param organ
	 *          
	 */
	public void deleteOrgan(Organ organ) {
		organDao.deleteByHiber(organ);			
	}

	/**
	 * 更新组织
	 * 
	 * @param organ
	 *            
	 */
	public  void updateOrgan(Organ organ) {
		organDao.updateByHiber(organ);
	}

	/**
	 * 组织重复验证(获取其他重复)，true为重复
	 * 
	 * @param organId：组织ID，可为空 如果 不为空则标识判断时候不包含改id
	 * @param parentOrganId：父组织
	 * @param organName： 组织名称
	 * @return
	 */
	public boolean getOrganRepeatVerify(Integer organId, Integer parentOrganId,String organName) {	 
		List<Organ> listOrgan = organDao.getOrganRepeatVerify(organId, parentOrganId, organName);
		if(listOrgan!=null&&listOrgan.size()>0)
			return true;
		else
			return false;
	}
	/**
	 * 判断组织排序号是否重复
	 * @param organId
	 * @param parentOrganId
	 * @param orderCode
	 * @return
	 */
	public boolean getOrderCodeRepeatVerify(Integer organId,Integer parentOrganId, Integer orderCode) {	 
		List<Organ> listOrgan = organDao.getOrderCodeRepeatVerify(organId,  parentOrganId,orderCode);		
		if(listOrgan!=null&&listOrgan.size()>0)
			return true;
		else
			return false;
	}

	/**
	 * 获取组织信息
	 * 
	 * @param organ
	 *          
	 * @return
	 */
	public Organ getOrganInfo(int organId) {
		int validFlagConfig=ConfigSetting.ValigFlag.getValue();
		int organTypeConfig=ConfigSetting.OrganType.getValue();
		Organ organ =new Organ();
		organ.setValidFlagConfig(validFlagConfig);
		organ.setOrganId(organId);
		organ.setOrganTypeConfig(organTypeConfig);
		return organDao.getOrganInfo(organ);
	}	

	/**
	 * 获取全部组织列表
	 * 
	 * @return
	 */
	public List<Organ> getOrganList(){	
		Organ organ=new Organ();
		return organDao.listByHiber(organ);
	}

	/**
	 * 获取子级组织列表
	 * 
	 * @param parentOrganId:父级组织id
	 * @return
	 */
	public List<Organ> getSubOrganList(int parentOrganId) {	
		int validFlag=ConfigSetting.ValigFlag.getValue();
		int orgaType=ConfigSetting.OrganType.getValue();
		return organDao.getSubOrganList(parentOrganId,validFlag,orgaType);
	}

	
	

	/**
	 * 删除岗位
	 * 
	 * @param post
	 *            岗位
	 */
	public void deletePost(int postId) {
		Post post = new Post();
		post.setPostId(postId);
		postDao.deleteByHiber(post);
	}

	/**
	 * 更新岗位
	 * 
	 * @param post
	 *            岗位
	 */
	public void updatePost(Post post) {
		postDao.updateByHiber(post);
	}

	/**
	 * 岗位重复验证(获取其他重复)，true为重复
	 * 
	 * @param postId:组织ID,可为空
	 * @param organId:组织ID
	 * @param postName:岗位名称
	 * @return
	 */
	public  boolean getPostRepeatVerify(Integer postId, Integer organId,String postName) {
		List<Post> list =  postDao.getPostRepeatVerify(postId, organId,postName);		
		if(list.size() > 0)
			return true;
		else
			return false;
	}

	/**
	 * 岗位信息
	 * 
	 * @param postId:岗位ID
	 * @return
	 */
	public Post getPostInfo(int postId) {
		return postDao.getByIdHiber(Post.class, postId);
	}

	/**
	 * 获取条件下的岗位信息
	 * 
	 * @param organ
	 *            组织ID
	 * @param postName
	 *            岗位名称
	 * @param validFlag
	 *            有效性
	 * @return
	 */
	public List<Post> getPostList(Integer organId,String postName, Integer validFlag) {
		return postDao.getPostListByCondition(organId,postName,validFlag);
	}

	/**
	 * 岗位分页列表
	 * 
	 * @param post
	 * 			  岗位实体         
	 * @param pageSize
	 *            分页行数
	 * @param pagination
	 *            页码
	 * @return
	 */
	public  MiniDaoPage<Post> getPostPagingList(Post post, int page,int rows) {
		MiniDaoPage<Post> minidaoPage=postDao.getPostPagingList(post, page, rows);         
        return minidaoPage;
	}

	/**
	 * 获取组织下岗位列表
	 * 
	 * @param organ
	 *          
	 * @return
	 */
	public List<Post> getOrganPostList(int organId) {
		Post post=new Post();
		post.setOrganId(organId);				
		return postDao.listByHiber(post);
	}
	
	/**
	 * 获取组织下有效的岗位列表
	 * 
	 * @param organId：组织id
	 *            
	 * @return
	 */
	public List<Post> getOrganPostFlagList(int organId){
		Post post=new Post();
		if(organId == 0){
			post.setOrganId(null);
		}else{
			post.setOrganId(organId);
		}
		post.setValidFlag(1);
		return postDao.listByHiber(post);
	}
	/**
	 * 添加岗位
	 * 
	 * @param post
	 *         
	 */
	
	@Override
	public int addPost(Post post) {
		postDao.saveByHiber(post);
		return post.getPostId();
	}

	@Override
	public Organ getOrganName(UserInfo ui) {
		return organDao.getOrganName(ui);
	}

	@Override
	public List<Organ> getMySubOrganList(int parentOrganId, String myOrganIds) {
		int validFlag=ConfigSetting.ValigFlag.getValue();
		int orgaType=ConfigSetting.OrganType.getValue();
		return organDao.getMySubOrganList(validFlag,orgaType,parentOrganId,myOrganIds);
	}

	@Override
	public List<Post> getTreeReceiverPost(int parentOrganId, String myOrganIds) {
		return postDao.getTreeReceiverPost(parentOrganId,myOrganIds);
	}

	@Override
	public String getMySubOrganIdsAll(int organId) {
		String myOrganIds="";
		List<Organ> mySubOrganList=getSubOrganList(organId);
		for(int i=0;i<mySubOrganList.size();i++){
			myOrganIds+=mySubOrganList.get(i).getOrganId()+",";
		}
		return myOrganIds;
	}


	
}

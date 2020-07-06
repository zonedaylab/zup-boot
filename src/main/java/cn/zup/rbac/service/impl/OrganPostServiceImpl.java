package cn.zup.rbac.service.impl;

import cn.zup.rbac.dao.OrganDao;
import cn.zup.rbac.dao.PostDao;
import cn.zup.rbac.dao.UserDao;
import cn.zup.rbac.entity.*;
import cn.zup.rbac.service.OrganPostService;
import cn.zup.rbac.service.settings.ConfigSetting;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.lang.System;
import java.util.*;
import java.util.Map.Entry;

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
		@Autowired
		private UserDao userdao;

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
		//获取所有organ 放置map中
		List<Organ> organList = getSubOrganList(organId);
        Map<Integer,Integer> map = new HashMap<Integer,Integer>();
		for (Organ organ : organList) {
			if(organ.getParentOrganId()!=null)
				map.put(organ.getOrganId(), organ.getParentOrganId());
			else
				map.put(organ.getOrganId(), 0);
		}
		String organIds = organId+",";
		organIds = getOrganIds(map,organId,organIds);
		if(organIds.indexOf(",")>0)
			organIds=organIds.substring(0,organIds.length()-1);
		return organIds;
//		String myOrganIds=String.valueOf(organId);
//		List<Organ> mySubOrganList=getSubOrganList(organId);
//		for(int i=0;i<mySubOrganList.size();i++){
//			myOrganIds += ","+getMySubOrganIdsAll(mySubOrganList.get(i).getOrganId()); 
//		}
//		return myOrganIds;
		
	}
	
	private String getOrganIds(Map map,Integer value,String organIds){

        ArrayList<Integer>  re1 = getKey(map, value);
        for (Integer organId : re1) {
            organIds += organId+",";
            organIds = getOrganIds(map,organId,organIds);
        }
        return organIds;
    }
	
	private ArrayList<Integer> getKey(Map map, Integer value){
        Set set = map.entrySet(); //通过entrySet()方法把map中的每个键值对变成对应成Set集合中的一个对象
        Iterator<Entry<Integer, Integer>> iterator = set.iterator();
        ArrayList<Integer> arrayList = new ArrayList();
        while(iterator.hasNext()){
            //Map.Entry是一种类型，指向map中的一个键值对组成的对象
            Entry<Integer, Integer> entry = iterator.next();
            if(entry.getValue().equals(value)){
                arrayList.add(entry.getKey());
            }
        }
        return arrayList;
    }

	@Override
	public List<Organ> getOrganLevel(int organId,int level,int organType){
		//获取level级别下的值
		Integer levelCur = new Integer(0);
		List<Organ> organList = getOrganList();
		
        Map<Integer,Integer> map = new HashMap<Integer,Integer>();
		for (Organ organ : organList) {
			//去除单列市
			if(organ.getOrganType()==null || organ.getOrganType() != 5)
				map.put(organ.getOrganId(), organ.getParentOrganId());
		}
		String organIds = "";
		//找到所有organId下的第一层的子节点
        ArrayList<Integer>  re1 = getKey(map, organId);
        //遍历第一层节点获取第二层节点并放到organIds字符串中
        for (Integer integer : re1) {
            ArrayList<Integer>  reSecond = getKey(map, integer);
            for (Integer id : reSecond) {
            	organIds += id+",";
			}
		}
        //获取单列市
        if(organType!=0)
		{
			Organ organParam = new Organ();
//			organParam.setParentOrganId(organId);
			organParam.setValidFlagConfig(ConfigSetting.ValigFlag.getValue());
			organParam.setOrganTypeConfig(ConfigSetting.OrganType.getValue());
			organParam.setOrganType(organType);
			List<Organ> organTypeList = organDao.getOperateOrganList(organParam);
			
			for (Organ organ : organTypeList) {
				organIds += organ.getOrganId()+",";
			}
		}
		if(organIds.indexOf(",")>0)
			organIds=organIds.substring(0,organIds.length()-1);
		organIds = "("+organIds+")";
		//通过部门ID和
		List<Organ> organSubList = organDao.getMySubOrganList(ConfigSetting.ValigFlag.getValue(),ConfigSetting.OrganType.getValue(),null,organIds);
		return organSubList;
	}
	
	@Override
	public List<Organ> getOrganForLevel(int organId,int level,int organType,String excludeOrganIds,boolean flag){

		//获取level级别下的值
		Integer levelCur = new Integer(0);
		List<Organ> organList = getOrganList();
        Map<Integer,Integer> map = new HashMap<Integer,Integer>();
		for (Organ organ : organList) {
			map.put(organ.getOrganId(), organ.getParentOrganId());
		}
		String organIds = "";
		
		if(flag)
			organIds += organId+",";
		
		organIds = getLevelOrganIds(map,organId,organIds,level,levelCur);
		

		if(organType!=0)
		{
			Organ organParam = new Organ();
//			organParam.setParentOrganId(organId);
			organParam.setValidFlagConfig(ConfigSetting.ValigFlag.getValue());
			organParam.setOrganTypeConfig(ConfigSetting.OrganType.getValue());
			organParam.setOrganType(organType);
			List<Organ> organTypeList = organDao.getOperateOrganList(organParam);
			for (Organ organ : organTypeList) {
				organIds += organ.getOrganId()+",";
			}
		}
		if(organIds.indexOf(",")>0)
			organIds=organIds.substring(0,organIds.length()-1);
		
		if(organIds.equals(""))
			organIds = null;
		else
			organIds = "("+organIds+")";
		
		if(excludeOrganIds.equals(""))
			excludeOrganIds = null;
		else
			excludeOrganIds = "("+excludeOrganIds+")";
		//通过部门ID和
		List<Organ> organSubList = organDao.getMyPermissionOrganList(ConfigSetting.ValigFlag.getValue(),ConfigSetting.OrganType.getValue(),null,organIds,excludeOrganIds);
		return organSubList;
	}
	private String getLevelOrganIds(Map map,Integer value,String organIds,int level,Integer levelCurs){

		levelCurs++;
        if(levelCurs > level)
        	return organIds;
        ArrayList<Integer>  re1 = getKey(map, value);
        for (Integer organId : re1) {
            organIds += organId+",";
            organIds = getLevelOrganIds(map,organId,organIds,level,levelCurs);
        }
        return organIds;
    }
	/**
	 * 3	通过组织ID、职能、级别获取组织列表
	 * @param organId  本级organId
	 * @param used 财务职能
	 * @param levelType 1 本级 2上级（一层） 3 下级（一层）
	 * @return
	 */
	public List<Organ> GetOrganUsed(int organId,int used,int levelType){
		//获取部门信息
		List<Organ> organUsedList = new ArrayList<Organ>();
		Organ organ = getOrganInfo(organId);
		if(levelType == 1){//本级
			//获取当前部门下的所以账号
			List<Account> accoundList = userdao.getorganAccountList(organId);
			for (Account account : accoundList) {
				if(account.getAccountUsed()!=null)
				{
					String usedStrs = account.getAccountUsed()+",";
					String usedStr = used+",";
					if (usedStrs.indexOf(usedStr)!=-1)
					{
						organ.setOrganUsed(String.valueOf(used));
						organUsedList.add(organ);
						return organUsedList;
					}
				}
			}
		}else if(levelType==2){//上级
			//获取当前部门下的所以账号
			List<Account> accoundList = userdao.getorganAccountList(organ.getParentOrganId());
			organ = getOrganInfo(organ.getParentOrganId());
			for (Account account : accoundList) {
				if(account.getAccountUsed()!=null)
				{
					String usedStrs = account.getAccountUsed()+",";
					String usedStr = used+",";
					if (usedStrs.indexOf(usedStr)!=-1)
					{
						organ.setOrganUsed(String.valueOf(used));
						organUsedList.add(organ);
						return organUsedList;
					}
				}
			}
		}else if(levelType==3){ //下级
			return getSubOrganByUsedList(organ.getOrganId(),String.valueOf(used));
		}
		return organUsedList;
	}
	
	/***
	 * 通过职能获取下级相同职能的组织列表
	 * @param parentOrganId 父ID
	 * @param usedStr 职能字符串 如1,2
	 * @return
	 */
	public List<Organ> getSubOrganByUsedList(int parentOrganId,String usedStr) {
		return organDao.getSubOrganByUsedList(parentOrganId,usedStr);
	}

    /**
     * 获取全部组织列表
     *
     * @return
     */
    public List<Organ> getOrganList(Organ organ){
        return organDao.listByHiber(organ);
    }
	/**
	 * 获取组织所有子节点 返回值Map
	 *
	 * @return
	 */
    public HashMap<Long, List<Integer>> getOrganSubNodeList(Integer organId){
		//获取所有组织

		List<Organ> listOrgan = getOrganList();
		Map<Integer,Integer> map = new HashMap<Integer,Integer>();
		for (Organ organ : listOrgan) {
			map.put(organ.getOrganId(), organ.getParentOrganId());
		}
		OrganSubNode root = new OrganSubNode();
		root.setOrganId(organId.longValue());
		initEntity(map,root);

		HashMap<Long, List<Integer>> mapRoot = new HashMap<>();
		HashMap<Long, List<Integer>> mapLeaf = new HashMap<>();
		preOrder(root,mapRoot,mapLeaf);
		mapRoot.putAll(mapLeaf);
    	return mapRoot;
	}
	private void preOrder(OrganSubNode root,HashMap<Long, List<Integer>> map,HashMap<Long, List<Integer>> mapLeaf) {
		if(root != null){
			if(root.getChildren() != null){
				List<Integer> list = new ArrayList<>();
				for (int i = 0; i < root.getChildren().size(); i++) {
					preOrder(root.getChildren().get(i),map,mapLeaf);
					System.out.print(root.getChildren().get(i).getOrganId() + " ");
					list.add(root.getChildren().get(i).getOrganId().intValue());
					if(map.get(root.getChildren().get(i).getOrganId())!=null){
						list.addAll(map.get(root.getChildren().get(i).getOrganId()));
					}
				}
				map.put(root.getOrganId(),list);
			}
			else{
				mapLeaf.put(root.getOrganId(),null);
			}
		}
	}

	private void initEntity(Map map,OrganSubNode entity){
		ArrayList<Integer> re1 = getKey(map, entity.getOrganId().intValue());
		for (Integer organId : re1) {
			List<OrganSubNode> children = new ArrayList<OrganSubNode>();
			OrganSubNode child = new OrganSubNode();
			child.setOrganId(organId.longValue());
			children.add(child);
			if(entity.getChildren()==null){
				entity.setChildren(children);
			}
			else
			{
				children.addAll(entity.getChildren());
				entity.setChildren(children);
			}
		}
		if(entity.getChildren()!=null){
			for (int i = 0; i < entity.getChildren().size(); i++) {
				initEntity(map,entity.getChildren().get(i));
			}
		}
	}

    public String getMySubOrganIds(int organId) {
        //获取所有organ 放置map中
        List<Organ> organList = getOrganList();
        Map<Integer,Integer> map = new HashMap<Integer,Integer>();
        for (Organ organ : organList) {
            if(organ.getParentOrganId()!=null)
                map.put(organ.getOrganId(), organ.getParentOrganId());
            else
                map.put(organ.getOrganId(), 0);
        }
        String organIds="";
        organIds = getOrganIds(map,organId,organIds);
        if(organIds.indexOf(",")>0)
            organIds=organIds.substring(0,organIds.length()-1);
        return organIds;
    }
	
}

package cn.zup.wechat.dao;

import java.util.List;

import cn.zup.wechat.entity.ReferrerEntity;

/**
 * 微信推荐人操作dao层
 * 
 * */
public interface ReferrerDao {
	
	boolean addRefrrer(ReferrerEntity entity);
	
	boolean updateRefrrer(ReferrerEntity entity);
	
	boolean deleteRefrrer(ReferrerEntity entity);
	
	ReferrerEntity getRefrrer(ReferrerEntity entity);
	
	List<ReferrerEntity> getRefrrerList(ReferrerEntity entity);
}

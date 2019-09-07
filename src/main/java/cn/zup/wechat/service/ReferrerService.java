package cn.zup.wechat.service;

import java.util.List;

import cn.zup.wechat.entity.ReferrerEntity;

public interface ReferrerService {
	
	boolean addRefrrer(ReferrerEntity entity);
	
	boolean updateRefrrer(ReferrerEntity entity);
	
	boolean deleteRefrrer(ReferrerEntity entity);
	
	ReferrerEntity getRefrrer(ReferrerEntity entity);
	
	List<ReferrerEntity> getRefrrerList(ReferrerEntity entity);
}

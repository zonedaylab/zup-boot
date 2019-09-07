package cn.zup.wechat.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.zup.wechat.dao.ReferrerDao;
import cn.zup.wechat.entity.ReferrerEntity;

@Service("referrerService")
public class ReferrerServiceImpl implements cn.zup.wechat.service.ReferrerService {
	
	@Autowired
	private ReferrerDao referrerDao;

	@Override
	public boolean addRefrrer(ReferrerEntity entity) {
		return referrerDao.addRefrrer(entity);
	}

	@Override
	public boolean updateRefrrer(ReferrerEntity entity) {
		return referrerDao.updateRefrrer(entity);
	}

	@Override
	public boolean deleteRefrrer(ReferrerEntity entity) {
		return referrerDao.deleteRefrrer(entity);
	}

	@Override
	public ReferrerEntity getRefrrer(ReferrerEntity entity) {
		return referrerDao.getRefrrer(entity);
	}

	@Override
	public List<ReferrerEntity> getRefrrerList(ReferrerEntity entity) {
		return referrerDao.getRefrrerList(entity);
	}

}

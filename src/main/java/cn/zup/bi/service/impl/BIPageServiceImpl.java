package cn.zup.bi.service.impl;

import cn.zup.bi.dao.BIMenuDao;
import cn.zup.bi.dao.BIPageDao;
import cn.zup.bi.entity.BI_Page;
import cn.zup.bi.entity.BiMenu;
import cn.zup.bi.service.BIPageService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("biPageService")
public class BIPageServiceImpl implements BIPageService {

	@Autowired
	private BIPageDao biPageDao;
	@Autowired
	private BIMenuDao biMenuDao;

	private Logger log = LoggerFactory.getLogger(BIPageServiceImpl.class);

	@Override
	public int updatePageInfo(BI_Page biPage) {
		try {
			if(biPage.getBi_Page_Id() != null) {
				biPageDao.update(biPage);
			}else {
				biPageDao.save(biPage);
			}
			return 1;
		} catch (Exception e) {
			log.error(e.getMessage());
			return 0;
		}
	}

	@Override
	public int deletePageInfo(int bi_Page_Id) {
		try {
			biPageDao.deletePageById(bi_Page_Id);
			return 1;
		} catch (Exception e) {
			log.error(e.getMessage());
			return 0;
		}
	}

	@Override
	public BI_Page getBiPage(BI_Page biPage) {
		if (biPage.getBi_Page_Id() != null) {
			return biPageDao.getBIPageById(biPage.getBi_Page_Id());
		} else {
			return biPageDao.getBIPageInfo(biPage);
		}
	}

	@Override
	public List<BI_Page> getBiPageList(BI_Page biPage) {
		List<BI_Page> list = biPageDao.getBIPageList(biPage);
		return list;
	}

	@Override
	public List<BI_Page> getBIPageListPage(BI_Page biPage, int page, int rows) {
		return biPageDao.getBIPageListPage(biPage);
	}

	@Override
	public List<BiMenu> getMenuList(Integer accountId) {
		return biMenuDao.getBiMenuList(accountId);
	}


}

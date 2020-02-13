package cn.zup.bi.service.impl;

import cn.zup.bi.dao.BIScreenDao;
import cn.zup.bi.entity.BI_Screen;
import cn.zup.bi.service.BIScreenService;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("biScreenService")
public class BIScreenServiceImpl implements BIScreenService {
	
	@Autowired
	private BIScreenDao biScreenDao;

	private Logger log = LoggerFactory.getLogger(BIScreenServiceImpl.class);

	@Override
	public int updateScreenInfo(BI_Screen biScreen) {
		try {
			if(biScreen.getScreen_Id() != null) {
				biScreenDao.update(biScreen);
			} else {
				biScreenDao.save(biScreen);
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			return 0;
		}
	}

	@Override
	public int deleteScreenInfo(int screen_Id) {
		try {
			biScreenDao.deleteScreenById(screen_Id);
			return 1;
		} catch (Exception e) {
			log.error(e.getMessage());
			return 0;
		}
	}

	@Override
	public BI_Screen getBiScreen(BI_Screen biScreen) {
		return biScreenDao.getById(biScreen.getScreen_Id());
	}

	@Override
	public List<BI_Screen> getBiScreenList(BI_Screen biScreen) {
		List<BI_Screen> list = biScreenDao.getBiScreenList(biScreen);
		return list;
	}

	@Override
	public List<BI_Screen> getBIScreenListPage(BI_Screen biScreen, int page, int rows) {
		return biScreenDao.getBiScreenListPage(biScreen);
	}
}

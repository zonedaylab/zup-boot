package cn.zup.bi.service.impl;

import cn.zup.bi.dao.BIPageBlockDao;
import cn.zup.bi.entity.BI_Block_Info;
import cn.zup.bi.service.BIPageBlockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("biPageBlockService")
	public class BIPageBlockServiceImpl implements BIPageBlockService {

		@Autowired
		private BIPageBlockDao biPageBlockDao;

		@Override
		public Integer saveBlock(BI_Block_Info bi_Block_Info) {
			try {
				biPageBlockDao.save(bi_Block_Info);
				return bi_Block_Info.getBlock_Id();
			} catch (Exception e) {
				return 0;
			}
		}

	@Override
	public boolean updateBlock(BI_Block_Info bi_Block_Info) {
		try {
			biPageBlockDao.update(bi_Block_Info);
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	@Override
	public boolean deleteBlock(Integer bi_Block_Id) {
		try {
			biPageBlockDao.deleteBlockById(bi_Block_Id);
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	@Override
	public BI_Block_Info getBlockInfo(Integer bi_Block_Id) {
		BI_Block_Info bi_Block_Info = new BI_Block_Info();
		bi_Block_Info.setBi_Page_Id(bi_Block_Id);
		try {
			return biPageBlockDao.getBIBlockInfo(bi_Block_Id);
		} catch (Exception e) {
			return null;
		}
	}

	@Override
	public List<BI_Block_Info> getBlockList(BI_Block_Info bi_Block_Info) {
		try {
			return biPageBlockDao.getBIBlockList(bi_Block_Info);
		} catch (Exception e) {
			return null;
		}
	}

	@Override
	public List<BI_Block_Info> getBlockListByPage(BI_Block_Info bi_Block_Info, int rows, int page) {
		try {
			return biPageBlockDao.getBIBlockList(bi_Block_Info);
		} catch (Exception e) {
			return null;
		}
	}

	@Override
	public List<BI_Block_Info> getPageBlockByPageId(Integer bi_Page_Id, Integer screen_Index, Integer block_Id) {
		return biPageBlockDao.getPageBlockByPageId(bi_Page_Id, screen_Index, block_Id);
	}

	@Override
	public boolean deleteBlockByPageId(Integer page_Id) {
		try {
			biPageBlockDao.deleteBlockByPageId(page_Id);
			return true;
		} catch (Exception e) {
			return false;
		}
		
	}

}

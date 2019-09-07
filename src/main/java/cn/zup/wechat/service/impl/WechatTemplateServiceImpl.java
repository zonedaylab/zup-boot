package cn.zup.wechat.service.impl;

import java.util.List;

import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.zup.wechat.dao.WechatTemplateDao;
import cn.zup.wechat.entity.WechatTemplate;
import cn.zup.wechat.service.WechatTemplateService;

@Service("wechatTemplateService")
public class WechatTemplateServiceImpl implements WechatTemplateService {
	@Autowired
	private WechatTemplateDao wechatTemplateDao;
	
	/**
	 * 
	 * 获取列表
	 */
	@Override
	public MiniDaoPage<WechatTemplate> getWechatTemplateListByPage(WechatTemplate wt, Integer rows, Integer page){
		return wechatTemplateDao.getWechatTemplateListByPage(wt, rows, page);
	}

	
	/**
	 * 
	 * 添加
	 */
	@Override
	public Integer addWechatTemplate(WechatTemplate wt) {
		int re = 0;
		try {
			wechatTemplateDao.addWechatTemplate(wt);
			re = 1;
		} catch (Exception e) {
			re = 0;
			System.err.println(e.getMessage());
		}
		return re;
	}
	/**
	 * 
	 * 删除
	 */
	@Override
	public Integer deleteWechatTemplate(WechatTemplate wt) {
		int re = 0;
		try {
			wechatTemplateDao.deleteWechatTemplate(wt);
			re = 1;
		} catch (Exception e) {
			re = 0;
			System.err.println(e.getMessage());
		}
		return re;
	}
	
	

	/**
	 * 
	 * 更新
	 */
	@Override
	public Integer updateWechatTemplate(WechatTemplate wt) {
		int re = 0;
		try {
			wechatTemplateDao.updateWechatTemplate(wt);
			re = 1;
		} catch (Exception e) {
			re = 0;
			System.err.println(e.getMessage());
		}
		return re;
	}
	
	@Override
	public WechatTemplate getWechatTemplate(WechatTemplate wt) {
		return wechatTemplateDao.getWechatTemplate(wt);
	}
	
	@Override
	public List<WechatTemplate> getWechatTemplateList(WechatTemplate wt) {
		return wechatTemplateDao.getWechatTemplateList(wt);
	}
}

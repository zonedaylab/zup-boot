package cn.zup.wechat.service.impl;

import java.util.List;

import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.zup.wechat.dao.WechatServiceDao;
import cn.zup.wechat.entity.WechatServer;
import cn.zup.wechat.service.WechatServerService;

@Service("wechatServerService")
public class WechatServerServiceImpl implements WechatServerService {
	@Autowired
	private WechatServiceDao wechatServiceDao;
	
	@Override
	public MiniDaoPage<WechatServer> getWechatServiceListByPage(WechatServer ws, Integer rows, Integer page){
		return wechatServiceDao.getWechatServiceList(ws, rows, page);
	}

	@Override
	public Integer addWechatService(WechatServer ws) {
		int re = 0;
		try {
			wechatServiceDao.addWechatService(ws);
			re = 1;
		} catch (Exception e) {
			re = 0;
			System.err.println(e.getMessage());
		}
		return re;
	}

	@Override
	public Integer deleteWechatService(WechatServer ws) {
		int re = 0;
		try {
			wechatServiceDao.deleteWechatService(ws);
			re = 1;
		} catch (Exception e) {
			re = 0;
			System.err.println(e.getMessage());
		}
		return re;
	}

	@Override
	public WechatServer getWechatService(WechatServer ws) {
		return wechatServiceDao.getWechatService(ws);
	}

	@Override
	public Integer updateWechatService(WechatServer ws) {
		int re = 0;
		try {
			wechatServiceDao.updateWechatService(ws);
			re = 1;
		} catch (Exception e) {
			re = 0;
			System.err.println(e.getMessage());
		}
		return re;
	}

	@Override
	public List<WechatServer> getWechatServiceList(WechatServer ws) {
		return wechatServiceDao.getWechatServiceList(ws);
	}
}

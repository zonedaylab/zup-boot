package cn.zup.wechat.service;

import java.util.List;

import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.wechat.entity.WechatServer;

public interface WechatServerService {
	
	MiniDaoPage<WechatServer> getWechatServiceListByPage(WechatServer ws, Integer rows, Integer page);
	
	Integer addWechatService(WechatServer ws);
	
	Integer deleteWechatService(WechatServer ws);
	
	Integer updateWechatService(WechatServer ws);
	
	WechatServer getWechatService(WechatServer ws);
	
	List<WechatServer> getWechatServiceList(WechatServer ws);
}

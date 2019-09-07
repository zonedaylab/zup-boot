package cn.zup.wechat.service;

import java.util.List;

import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.wechat.entity.WechatTemplate;

public interface WechatTemplateService {
	
	MiniDaoPage<WechatTemplate> getWechatTemplateListByPage(WechatTemplate wt, Integer rows, Integer page);
	
	Integer addWechatTemplate(WechatTemplate wt);
	
	Integer deleteWechatTemplate(WechatTemplate wt);
	
	Integer updateWechatTemplate(WechatTemplate wt);
	
	WechatTemplate getWechatTemplate(WechatTemplate wt);
	/**
	 * 发送告警消息时需要的字段
	 * 
	 * */
	List<WechatTemplate> getWechatTemplateList(WechatTemplate wt);
}

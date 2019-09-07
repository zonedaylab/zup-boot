package cn.zup.wechat.dao;

import java.util.List;

import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.wechat.entity.WechatServer;

public interface WechatServiceDao {
	
	/**
	 * 获取微信公众号列表
	 * 
	 * 
	 * */
	MiniDaoPage<WechatServer> getWechatServiceList(WechatServer ws, Integer rows, Integer page);
	
	/**
	 * 添加微信公众号列表
	 * 
	 * 
	 * */
	public Integer addWechatService(WechatServer ws);

	/**
	 * 删除微信公众号
	 * 
	 * 
	 * */
	public Integer deleteWechatService(WechatServer ws);

	/**
	 * 获取微信公众号
	 * 
	 * 
	 * */
	public WechatServer getWechatService(WechatServer ws);

	/**
	 * 更新微信公众号
	 * 
	 * 
	 * */
	public Integer updateWechatService(WechatServer ws);

	/**
	 * 获取微信公众号列表
	 * 
	 * 
	 * */
	public List<WechatServer> getWechatServiceList(WechatServer ws);
}

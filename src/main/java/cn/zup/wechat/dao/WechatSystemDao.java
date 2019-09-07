package cn.zup.wechat.dao;

import java.util.List;

import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.wechat.entity.ServerTempView;
import cn.zup.wechat.entity.WechatServer;
import cn.zup.wechat.entity.WechatSystem;

public interface WechatSystemDao{

	/**
	 * 获取微信绑定系统列表不分页
	 * 
	 * */
	List<WechatSystem> getWechatSystemLists(WechatSystem wechatSystem);
	
	
	/**
	 * 获取微信绑定系统列表
	 * 
	 * */
	MiniDaoPage<WechatSystem> getWechatSystemList(WechatSystem wsys, Integer rows, Integer page);
	
	/**
	 * 删除微信绑定系统
	 * 
	 * */
	void deleteSystem(WechatSystem wsys);

	/**
	 * 获取所有微信公众号
	 * 
	 * */
	List<WechatServer> getAllService();

	
	/**
	 * 获取微信模板
	 * 
	 * */
	List<ServerTempView> getServerTemp(WechatSystem wsys);
	
	/**
	 * 添加微信系统
	 * 
	 * */
	public int addSystem(WechatSystem wsys);

	/**
	 * 更新微信系统
	 * 
	 * */
	public int updateSystem(WechatSystem wsys);

	/**
	 * 获取微信系统
	 * 
	 * */
	public WechatSystem getSystemInfo(WechatSystem ws);

	/**
	 * 获取所有微信系统
	 * 
	 * */
	public List<WechatSystem> getAllSystem();
}


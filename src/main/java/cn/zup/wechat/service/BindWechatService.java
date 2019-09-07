package cn.zup.wechat.service;

import java.util.List;

import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.rbac.entity.Account;
import cn.zup.wechat.entity.ServerTempView;
import cn.zup.wechat.entity.WechatRegister;
import cn.zup.wechat.entity.WechatServer;
import cn.zup.wechat.entity.WechatSystem;

public interface BindWechatService {
	
	public WechatRegister getRegister (WechatRegister wr);
	
	public WechatRegister getRegisters(WechatRegister wr);
	
	public void addRegister (WechatRegister wr);
	
	public int delRegister (WechatRegister wr);
	
	/**
	 * 获取所有集合
	 * @author andot
	 * @date 2017-5-3 15:37:13
	 * */
	public MiniDaoPage<WechatRegister>  getRegisterList(WechatRegister wr, int rows, int page);
	
	public MiniDaoPage<WechatSystem> getSystemList(WechatSystem wsys, int rows, int page);
	
	public WechatSystem getSystem(WechatSystem ws);
	
	public List<WechatSystem> getAllSystem();
	
	public int addSystem (WechatSystem wsys);
	
	public int deleteSystem (WechatSystem wsys);
	
	public int updateSystem (WechatSystem wsys);
	
	public List<WechatServer> getAllService();
	
	WechatSystem getSystemInfo(WechatSystem ws);
	
	List<ServerTempView> getServerTemp(WechatSystem wsys);
	
	List<WechatSystem> getSystemLists(WechatSystem ws);
	
	/**
	 * 根据用户获取账户信息
	 * */
	public List<Account> getAccountInfoByUserId(Integer userId);
	
}

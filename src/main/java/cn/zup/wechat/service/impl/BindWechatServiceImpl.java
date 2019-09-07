package cn.zup.wechat.service.impl;
 

import java.util.List;

import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.zup.rbac.entity.Account;
import cn.zup.wechat.dao.WechatRegisterDao;
import cn.zup.wechat.dao.WechatSystemDao;
import cn.zup.wechat.entity.ServerTempView;
import cn.zup.wechat.entity.WechatRegister;
import cn.zup.wechat.entity.WechatServer;
import cn.zup.wechat.entity.WechatSystem;
import cn.zup.wechat.service.BindWechatService;


@Service("bindService")
public class BindWechatServiceImpl implements BindWechatService{

	@Autowired
	private WechatRegisterDao wrdao;
	@Autowired
	private WechatSystemDao wsdao;
	
	
	@Override
	public WechatRegister getRegister(WechatRegister wr) {
		// TODO Auto-generated method stub
		List<WechatRegister> list = wrdao.getUserInfoList(wr);
		if(list.size()>0)
			return list.get(0);
		else
			return null;
	}

	@Override
	public WechatSystem getSystem(WechatSystem ws) {
		List<WechatSystem> list = wsdao.getWechatSystemLists(ws);
		if(list.size()>0)
			return list.get(0);
		else
			return null;
	}

	@Override
	public void addRegister(WechatRegister wr) {
		// TODO Auto-generated method stub
		wrdao.addRegister(wr);
	}

	@Override
	public int delRegister(WechatRegister wr) {
		try{
			wrdao.delRegister(wr);
		}catch(Exception ex){
			return 0;
		}
		return 1;
	}
	
	/**
	 * 获取所有集合
	 * @author andot
	 * @date 2017-5-3 15:37:13
	 * */
	@Override
	public MiniDaoPage<WechatRegister> getRegisterList(WechatRegister wr, int rows, int page){
		return wrdao.getWechatRegisterList(wr, rows, page);
	}
	
	/**
	 * 获取所有集合
	 * @author andot
	 * @date 2017-5-3 15:37:13
	 * */
	@Override
	public MiniDaoPage<WechatSystem> getSystemList(WechatSystem wsys, int rows, int page){
		return wsdao.getWechatSystemList(wsys, rows, page);
	}

	@Override
	public int deleteSystem(WechatSystem wsys) {
		int re = 0;
		try {
			wsdao.deleteSystem(wsys);
			re = 1;
		} catch (Exception e) {
			re = 0;
			System.err.println(e.getMessage());
		}
		return re;
	}
	
	@Override
	public List<WechatServer> getAllService() {
		List<WechatServer> wserList = wsdao.getAllService();
		return wserList;
	}

	@Override
	public List<ServerTempView> getServerTemp(WechatSystem wsys) {
		return wsdao.getServerTemp(wsys);
	}

	@Override
	public List<WechatSystem> getSystemLists(WechatSystem ws) {
		return wsdao.getWechatSystemLists(ws);
	}

	@Override
	public WechatRegister getRegisters(WechatRegister wr) {
		return wrdao.getWechatRegister(wr);
	}
	
	@Override
	public int addSystem(WechatSystem wsys) {
		int re = 0;
		try {
			wsdao.addSystem(wsys);
			re = 1;
		} catch (Exception e) {
			re = 0;
		}
		return re;
	}

	@Override
	public int updateSystem(WechatSystem wsys) {
		int re = 0;
		try {
			wsdao.updateSystem(wsys);
			re = 1;
		} catch (Exception e) {
			re = 0;
		}
		return re;
	}
	
	@Override
	public WechatSystem getSystemInfo(WechatSystem ws) {
		WechatSystem wsinfo = wsdao.getSystemInfo(ws);
		return wsinfo;
	}
	
	@Override
	public List<WechatSystem> getAllSystem() {
		return wsdao.getAllSystem();
	}

	@Override
	public List<Account> getAccountInfoByUserId(Integer userId) {
		return wrdao.getAccountInfoByUserId(userId);
	}
	
}

package cn.zup.wechat.dao;

import java.util.List;

import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.rbac.entity.Account;
import cn.zup.wechat.entity.WechatRegister;

public interface WechatRegisterDao{
	
	/**
	 * 获取用户列表
	 * 
	 * */
	List<WechatRegister> getUserInfoList(WechatRegister wechatRegister);
	
	/**
	 * 获取微信绑定用户列表
	 * 
	 * */
	MiniDaoPage<WechatRegister> getWechatRegisterList(WechatRegister wr, int rows, int page);
	

	/**
	 * 获取微信绑定用户信息
	 * 
	 * */
	WechatRegister getWechatRegister(WechatRegister wechatRegister);
	
	/**
	 * 保存用户绑定
	 * 
	 * */
	public void addRegister(WechatRegister wr);
	
	/**
	 * 解绑用户
	 * 
	 * */
	public Integer delRegister(WechatRegister wr);
	
	/**
	 * 根据用户获取账户信息
	 * */
	public List<Account> getAccountInfoByUserId(Integer userId);
}


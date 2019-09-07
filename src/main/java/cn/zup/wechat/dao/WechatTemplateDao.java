package cn.zup.wechat.dao;

import java.util.List;

import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.wechat.entity.WechatTemplate;


public interface WechatTemplateDao {
	
	/**
	 * 获取微信模板列表
	 * 
	 * */
	MiniDaoPage<WechatTemplate> getWechatTemplateListByPage(WechatTemplate wt, Integer rows, Integer page);
	
	/**
	 * 
	 * 添加
	 */
	public Integer addWechatTemplate(WechatTemplate wt);
	
	/**
	 * 
	 * 删除
	 */
	public Integer deleteWechatTemplate(WechatTemplate wt);
	
	/**
	 * 
	 * 更新
	 */
	public Integer updateWechatTemplate(WechatTemplate wt);
	

	public WechatTemplate getWechatTemplate(WechatTemplate wt);
	

	public List<WechatTemplate> getWechatTemplateList(WechatTemplate wt);
}

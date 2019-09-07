package cn.zup.rbac.junit;

import java.util.List;

import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.junit.Test;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import cn.zup.rbac.entity.EnergyMerchant;
import cn.zup.rbac.entity.EnergyTradeCategory;
import cn.zup.rbac.service.MerchantService;
import cn.zup.rbac.service.settings.ConfigSetting;

public class EnergyMerchantJunit{
	/**
	 * 获取用电商户集合
	 */
	@Test
	public void getCommonMerchantList(){
		BeanFactory factory = new ClassPathXmlApplicationContext("zup-minidao.xml");
		MerchantService merchantService = (MerchantService) factory.getBean("merchantService");	
		  EnergyMerchant energyMerchant = new EnergyMerchant();
	        energyMerchant.setCheckStateConfig(Integer.valueOf(ConfigSetting.checkState.getValue()));
	        energyMerchant.setEnergyPropertyConfig(Integer.valueOf(ConfigSetting.EnergyProperty.getValue()));
	        energyMerchant.setMerchantTypeConfig(Integer.valueOf(ConfigSetting.MerchantType.getValue()));
	        energyMerchant.setTradeFlagConfig(Integer.valueOf(ConfigSetting.TradeFlag.getValue()));
	        energyMerchant.setMerchant_Type(Integer.valueOf(1));
	        
	        energyMerchant.setMarketId(107);
	        //energyMerchant.setSummaryMerchantIds();
	        Integer userId=144;
	        Integer marketId=107;
	       // String summaryMerchantIds="";
	        List<EnergyMerchant> list =merchantService.getCommonMerchantList(userId, marketId, null);
	        for(int i=0;i<list.size();i++){
	        	System.err.println(list.get(i).getMerchant_Name());
	        }
	}
	
}


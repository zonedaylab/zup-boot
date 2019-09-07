package cn.zup.rbac.service.impl;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.List;

import org.apache.taglibs.standard.tag.common.fmt.FormatDateSupport;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Service;

import cn.zup.framework.util.DateUtil;
import cn.zup.rbac.dao.CodeConfigDao;
import cn.zup.rbac.dao.CodeSerialDao;
import cn.zup.rbac.entity.*;
import cn.zup.rbac.service.*;
@Service("codeConfigService")
public class CodeConfigServiceImpl implements CodeConfigService {
	@Autowired
	private CodeConfigDao codeconfigDao;
	@Autowired
	private CodeSerialDao codeserialDao;
	
	/**
	 * 添加编码规则
	 * 
	 * @param CodeConfig
	 *            编码规则
	 */
	public void addCodeConfig(CodeConfig CodeConfig) {
		codeconfigDao.saveByHiber(CodeConfig);
	}

	/**
	 * 更新编码规则
	 * 
	 * @param CodeConfig
	 *            编码规则
	 */
	public  void updateCodeConfig(CodeConfig CodeConfig) {
		codeconfigDao.updateByHiber(CodeConfig);
	}

	/**
	 * 删除编码规则
	 * 
	 * @param CodeConfig
	 *            编码规则
	 */
	public void deleteCodeConfig(CodeConfig CodeConfig) {
		codeconfigDao.deleteByHiber(CodeConfig);
	}

	/**
	 * 获取编码规则列表
	 * 
	 * @param configCode
	 *            编码规则
	 * @param memo
	 *            备注
	 * @param pageSize
	 *            分页数量
	 * @param pageination
	 *            页码
	 * @return
	 */
	public MiniDaoPage<CodeConfig> getCodeConfigList(CodeConfig codeconfig, int page, int rows) {
		MiniDaoPage<CodeConfig> minidaoPage=codeconfigDao.getAllCodeConfigs(codeconfig,page,rows);		
         
         return minidaoPage;
	}

	/**
	 * 获取编码规则实体信息
	 * 
	 * @param configID
	 * @return
	 */
	public  CodeConfig getCodeConfigInfo(int configID) {
		return codeconfigDao.getByIdHiber(CodeConfig.class, configID);
	}
	/**
	 * 根据编码配置ID获取编码,
	 * 
	 * @param configID
	 *            配置ID
	 * @param codeParams
	 *            编码配置： [常量][系统变量][参变量][流水]
	 * 
	 *            0-常量：例如AP LW 
	 *            1-系统变量：[YYYY]表示年 [YYYYMM]表示年月 [YYYYMMDD]表示年月日
	 *            2-参变量：[Param0] [Param1] [Param2]
	 *            3-流水：两种表示 -x -4 表示4位流水 -3
	 *            表示三位流水 [XXXXX]5位流水 [XXX]3位流水 例如 AP[YYYYMMDD][XXXX] --->
	 *            AP201210020001
	 * @return 流水号
	 */
	
	public String getCodeInfo(int configID, List<String> codeParams){
		String codeConfig = "";//配置流水号
		CodeConfig CodeConfiglist = getCodeConfigInfo(configID);//获取流水号
		if (CodeConfiglist!=null && (CodeConfiglist.getConfigcode())!=null){//若流水号不为空	
			codeConfig = CodeConfiglist.getConfigcode();//根据编码规则实体类获取编码规则
			//系统变量生成 -年月日
			java.util.Date now = new java.util.Date();			
			codeConfig = codeConfig.replace("[YY]", DateUtil.formatdate(now,"yy"));			
			codeConfig = codeConfig.replace("[YYYY]", DateUtil.formatdate(now,"yyyy"));			
			codeConfig = codeConfig.replace("[YYYYMM]",DateUtil.formatdate(now,"yyyyMM"));		
			codeConfig = codeConfig.replace("[YYYYMMDD]",DateUtil.formatdate(now,"yyyyMMdd"));
			String strSerialCount = ""; //当CodeConfig中未配置流水号的位数，则默认为0位
			
			int codeCount = codeConfig.length() - 2;
			for (int i = 0; i < codeCount; i++) {
				strSerialCount += "0";
				codeConfig = codeConfig.replace("[X]", "");
			}
			
			
			if (codeConfig.contains("[XXXXX]")){
				strSerialCount = "00000";
				codeConfig = codeConfig.replace("[XXXXX]", "");
			}
			else if (codeConfig.contains("[XXXX]")){
				strSerialCount = "0000";
				codeConfig = codeConfig.replace("[XXXX]", "");
			}
			else if (codeConfig.contains("[XXX]")){
				strSerialCount = "000";
				codeConfig = codeConfig.replace("[XXX]", "");
			}
			else if (codeConfig.contains("[XX]")){
				strSerialCount = "00";
				codeConfig = codeConfig.replace("[XX]", "");
			}
			else if (codeConfig.contains("[X]")){
				strSerialCount = "0";
				codeConfig = codeConfig.replace("[X]", "");
			}
			//在获取流水号时，只能在执行参变量生成之前
			else if (codeConfig.contains("-")){
				strSerialCount = codeConfig.substring(codeConfig.indexOf("-") + 1);
				codeConfig = codeConfig.substring(0, codeConfig.indexOf("-"));
			}
			//参变量生成，最终产生的流水号
			if (codeParams != null){
				for (int i = 0; i < codeParams.size(); i++){
					String Param = "[Param" + (new Integer(i)).toString() + "]";
					codeConfig = codeConfig.replace(Param, codeParams.get(i));
				}
			}
			String codetypestr2= codeConfig+configID;
			List<CodeSerial>  list=codeserialDao.getFromCodeSerial(codetypestr2);
			return updateCodeSerial(list,codetypestr2,strSerialCount,codeConfig);
		}
		return codeConfig;
	}
	
	/**
	 * codeCount 根据这个参数返回生成几位的序列号
	 * 
	 * */
	public String getCodeInfo(int configID, List<String> codeParams, int codeCount){
		String codeConfig = "";//配置流水号
		CodeConfig CodeConfiglist = getCodeConfigInfo(configID);//获取流水号
		if (CodeConfiglist!=null && (CodeConfiglist.getConfigcode())!=null){//若流水号不为空	
			codeConfig = CodeConfiglist.getConfigcode();//根据编码规则实体类获取编码规则
			String strSerialCount = ""; //当CodeConfig中未配置流水号的位数，则默认为0位
			String x = "[";
			for (int i = 0; i < codeCount; i++) {
				strSerialCount += "0";
				x += "X";
			}
			x += "]";
			
			if (codeConfig.contains(x)){
				codeConfig = codeConfig.replace(x, "");
			}
			//在获取流水号时，只能在执行参变量生成之前
			else if (codeConfig.contains("-")){
				strSerialCount = codeConfig.substring(codeConfig.indexOf("-") + 1);
				codeConfig = codeConfig.substring(0, codeConfig.indexOf("-"));
			}
			//参变量生成，最终产生的流水号
			if (codeParams != null){
				for (int i = 0; i < codeParams.size(); i++){
					String Param = "[Param" + (new Integer(i)).toString() + "]";
					codeConfig = codeConfig.replace(Param, codeParams.get(i));
				}
			}
			String codetypestr2= codeConfig+configID;
			List<CodeSerial> list=codeserialDao.getFromCodeSerial(codetypestr2);
			return updateCodeSerial(list,codetypestr2,strSerialCount,codeConfig);
		}
		return codeConfig;
	}

	public String updateCodeSerial(List<CodeSerial>  list,String codetypestr,String strSerialCount,String codeConfig){
		if(list.size()==0){//没有则插入数据，并且将serial设置为2
			CodeSerial codeserial2=new CodeSerial();
			codeserial2.setCodeType(codetypestr);
			codeserial2.setSerial(2);
			codeserialDao.saveByHiber(codeserial2);
			DecimalFormat f = new DecimalFormat(strSerialCount);
			String str = f.format(1);
			return codeConfig + str;
		}else{//有则将serial更新为加1
			CodeSerial codeserial=new CodeSerial();
			int temp=list.get(0).getSerial();	
			codeserial.setSerial(temp+1);
			codeserial.setCodeType(list.get(0).getCodeType());
			codeserialDao.updateCodeSerial(codeserial);
			DecimalFormat f = new DecimalFormat(strSerialCount);
			String str = f.format(temp);
			return codeConfig+str;
		}		
	}
	
}

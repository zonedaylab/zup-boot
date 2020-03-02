package cn.zup.rbac.dao;


import cn.zup.rbac.entity.CodeConfig;
import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import java.util.List;


@MiniDao
public interface CodeConfigDao extends MiniDaoSupportHiber<CodeConfig>{
	@Arguments("configID")
	List<CodeConfig> getcodeConfiginfo(int configID);
	
	@Arguments({"codeconfig","page", "rows"})
	@ResultType(CodeConfig.class)
	public MiniDaoPage<CodeConfig> getAllCodeConfigs(CodeConfig codeconfig, int page, int rows);

}

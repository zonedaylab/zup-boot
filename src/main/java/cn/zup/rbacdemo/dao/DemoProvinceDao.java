package cn.zup.rbacdemo.dao;

import java.util.List;

import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.annotation.Sql;
import org.jeecgframework.minidao.hibernate.MiniDaoSupportHiber;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

import cn.zup.rbacdemo.entity.DemoProvince;

@MiniDao
public interface DemoProvinceDao extends MiniDaoSupportHiber<DemoProvince>{
	
	@Arguments({ "demoProvince", "page", "rows" ,"sql"})
	@ResultType(DemoProvince.class)
	public MiniDaoPage<DemoProvince> getProvincePagingList(DemoProvince demoProvince, int page, int rows,String sql );
}

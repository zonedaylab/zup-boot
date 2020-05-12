package cn.zup.rbacmap.datasource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;

import javax.sql.DataSource;

public interface BaseRbacMapDataSource {
	/**
	 * 创建数据源
	 * 
	 * */
	DataSource baseRbacDataSource();
	
	/**
	 * 创建sqlsession工程
	 * 
	 * */
	SqlSessionFactory baseRbacSqlSessionFactory(DataSource baseDataSource);
	
	/**
	 * 创建数据源事务
	 * 
	 * */
	DataSourceTransactionManager baseRbacDataSourceTransactionManager(DataSource baseDataSource);
	
	/**
	 * 创建SqlSession工程的SqlSession模板
	 * 
	 * */
	SqlSessionTemplate baseRbacSqlSessionTemplate(SqlSessionFactory baseSqlSessionFactory);
}

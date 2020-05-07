package cn.zup.bi.datasource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;

import javax.sql.DataSource;

public interface BaseRbacDataSource {
	/**
	 * 创建数据源
	 * 
	 * */
	DataSource baseDataSource();
	
	/**
	 * 创建sqlsession工程
	 * 
	 * */
	SqlSessionFactory baseSqlSessionFactory(DataSource baseDataSource);
	
	/**
	 * 创建数据源事务
	 * 
	 * */
	DataSourceTransactionManager baseDataSourceTransactionManager(DataSource baseDataSource);
	
	/**
	 * 创建SqlSession工程的SqlSession模板
	 * 
	 * */
	SqlSessionTemplate baseSqlSessionTemplate(SqlSessionFactory baseSqlSessionFactory);
}

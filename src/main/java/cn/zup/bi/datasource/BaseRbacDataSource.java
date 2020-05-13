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
	DataSource baseBIDataSource();
	
	/**
	 * 创建sqlsession工程
	 * 
	 * */
	SqlSessionFactory baseBISqlSessionFactory(DataSource baseDataSource);
	
	/**
	 * 创建数据源事务
	 * 
	 * */
	DataSourceTransactionManager baseBIDataSourceTransactionManager(DataSource baseDataSource);
	
	/**
	 * 创建SqlSession工程的SqlSession模板
	 * 
	 * */
	SqlSessionTemplate baseBISqlSessionTemplate(SqlSessionFactory baseSqlSessionFactory);
}

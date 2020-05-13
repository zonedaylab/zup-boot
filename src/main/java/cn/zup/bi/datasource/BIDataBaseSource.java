package cn.zup.bi.datasource;

import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.jdbc.DataSourceBuilder;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;

import javax.sql.DataSource;
import java.io.IOException;

@Configuration
@MapperScan(
		basePackages = {"cn.zup.bi.dao"},
		sqlSessionFactoryRef="biSqlSessionFactory",
		sqlSessionTemplateRef="biSqlSessionTemplate")
@Slf4j()
public class BIDataBaseSource implements BaseRbacDataSource {

	@Bean("biDataSource")
	@ConfigurationProperties(prefix="spring.datasource.bi")
	@Override
	public DataSource baseBIDataSource() {
		return DataSourceBuilder.create().build();
	}

	@Bean("biSqlSessionFactory")
	@Override
	public SqlSessionFactory baseBISqlSessionFactory(@Qualifier("biDataSource") DataSource baseDataSource) {
		SqlSessionFactoryBean bean = new SqlSessionFactoryBean();
		try {
			bean.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:cn/zup/mapper/bi/*Mapper.xml"));
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		bean.setDataSource(baseDataSource);
		SqlSessionFactory sqlSessionFactory = null;
		try {
			sqlSessionFactory = bean.getObject();
		} catch (Exception e) {
//			log.error("数据库工厂创建失败："+e.getMessage());
		}
		return sqlSessionFactory;
	}

	@Bean("biDataSourceTransactionManager")
	@Override
	public DataSourceTransactionManager baseBIDataSourceTransactionManager(@Qualifier("biDataSource") DataSource baseDataSource) {
		return new DataSourceTransactionManager(baseDataSource);
	}

	@Bean("biSqlSessionTemplate")
	@Override
	public SqlSessionTemplate baseBISqlSessionTemplate(@Qualifier("biSqlSessionFactory") SqlSessionFactory baseSqlSessionFactory) {
		return new SqlSessionTemplate(baseSqlSessionFactory);
	}
}

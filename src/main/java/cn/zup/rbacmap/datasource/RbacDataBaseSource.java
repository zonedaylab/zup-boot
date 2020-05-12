package cn.zup.rbacmap.datasource;

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
		basePackages = {"cn.zup.rbacmap.dao"},
		sqlSessionFactoryRef="rbacmapSqlSessionFactory",
		sqlSessionTemplateRef="rbacmapSqlSessionTemplate")
@Slf4j()
public class RbacDataBaseSource implements BaseRbacMapDataSource {

	@Bean("rbacmapDataSource")
	@ConfigurationProperties(prefix="spring.datasource.rbacmap")
	@Override
	public DataSource baseRbacDataSource() {
		return DataSourceBuilder.create().build();
	}

	@Bean("rbacmapSqlSessionFactory")
	@Override
	public SqlSessionFactory baseRbacSqlSessionFactory(@Qualifier("rbacmapDataSource") DataSource baseDataSource) {
		SqlSessionFactoryBean bean = new SqlSessionFactoryBean();
		try {
			bean.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:cn/zup/mapper/rbacmap/*Mapper.xml"));
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

	@Bean("rbacmapDataSourceTransactionManager")
	@Override
	public DataSourceTransactionManager baseRbacDataSourceTransactionManager(@Qualifier("rbacmapDataSource") DataSource baseDataSource) {
		return new DataSourceTransactionManager(baseDataSource);
	}

	@Bean("rbacmapSqlSessionTemplate")
	@Override
	public SqlSessionTemplate baseRbacSqlSessionTemplate(@Qualifier("rbacmapSqlSessionFactory") SqlSessionFactory baseSqlSessionFactory) {
		return new SqlSessionTemplate(baseSqlSessionFactory);
	}
}

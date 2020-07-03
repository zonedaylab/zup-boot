package cn.zup.bi.utils;

import org.springframework.boot.autoconfigure.jdbc.DataSourceBuilder;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

@Component
@Configuration
public class BIBizConnection {
//    @ConfigurationProperties(prefix="spring.datasource.bi_bizds")
//    @Bean(name = "getDataSource")
//    public DataSource getDataSource()  {
//        return DataSourceBuilder.create().build();
//    }
//
//    public  Connection getConnection() throws SQLException {
//        return this.getDataSource().getConnection();
//    }
}

package cn.zup;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.boot.web.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ImportResource;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

/**
 * @author andot
 * ZUP 主入口
 */
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class})
@ImportResource("classpath:zup-*.xml")
@ComponentScan({"cn.zup.*"})
//@MapperScan({"cn.zup.bi.dao","cn.zup.rbacmap.dao"})
@ServletComponentScan
@EnableSwagger2
public class ZupApplication extends SpringBootServletInitializer {
	public static void main(String[] args) {
		SpringApplication.run(ZupApplication.class, args);
	}
}

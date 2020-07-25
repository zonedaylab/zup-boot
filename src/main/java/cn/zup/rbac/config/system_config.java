package cn.zup.rbac.config;
import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;
//系统配置，表示当前采用哪个系统
/**
 * 将配置文件中配置的每一个属性的值，映射到这个组件中
 * @ConfigurationProperties：告诉SpringBoot将本类中的所有属性和配置文件中相关的配置进行绑定；
 *      prefix = "spring.system_config"：配置文件中哪个下面的所有属性进行一一映射(yml文件中的参数名要和JavaBean中的属性名保持一致)
 *
 * 只有这个组件是容器中的组件，才能容器提供的@ConfigurationProperties功能；
 *
 */
@Component
@ConfigurationProperties(prefix = "spring.system_config")
@Data
public class system_config {
    private String name;
}

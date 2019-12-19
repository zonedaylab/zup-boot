## ZUPBoot
### 信息化软件统一开发平台。

> 基于SpringBoot+SpringMVC+Mysql进行开发，包括功能

#### 1. 组织结构

#### 2. 权限管理

#### 3. 微信公众号管理

#### 4. 工作流

#### 5. BI可视化

### Use desc

> 1. git clone https://github.com/zonedaylab/zup-boot.git

> 2. Open project in Idea & Eclipse

> 3. 在项目中查找 zup-boot/src/main/resources/sql/zup.sql & zupwf.sql
导入到MySQL数据库中（MySQL数据库支持5.6及以上版本）
    导入SQL文件：mysql -u root -p 123456 < zup.sql
    导入SQL文件：mysql -u root -p 123456 < zupwf.sql
    
> 4. 右键zup-boot\src\main\java\cn\zup\ZupApplication.java Run Application

> 5. Chrome 游览器打开localhost:8083

数据库配置文件：
zup-boot\src\main\resources\application.yml
zup-boot\src\main\resources\dbconfig.properties


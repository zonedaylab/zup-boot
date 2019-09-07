package cn.zup.rbac.interceptors;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class MySQLJDBCConn {
    // MySQL的JDBC URL编写方式：jdbc:mysql://主机名称：连接端口/数据库的名称?参数=值
    // 避免中文乱码要指定useUnicode和characterEncoding
    // 执行数据库操作之前要在数据库管理系统上创建一个数据库，名字自己定，
    // 下面语句之前就要先创建javademo数据库
    private static String url = "jdbc:mysql://192.168.10.21:3306/jeewx-os?" + "user=root&password=iesapp&useUnicode=true&characterEncoding=UTF8";
    public static int getMysqlConn(String sql, String accountName) throws SQLException{
    	Connection conn = null;
        int result = 0;
        String sqls;
    	try {
            // 之所以要使用下面这条语句，是因为要使用MySQL的驱动，所以我们要把它驱动起来，
            // 可以通过Class.forName把它加载进去，也可以通过初始化来驱动起来，下面三种形式都可以
            Class.forName("com.mysql.jdbc.Driver");// 动态加载mysql驱动
            // or:
            // com.mysql.jdbc.Driver driver = new com.mysql.jdbc.Driver();
            // or：
            // new com.mysql.jdbc.Driver();

            System.out.println("成功加载MySQL驱动程序");
            // 一个Connection代表一个数据库连接
            conn = DriverManager.getConnection(url);
            // Statement里面带有很多方法，比如executeUpdate可以实现插入，更新和删除等
            Statement stmt = conn.createStatement();
            System.err.println("=================mysql jeewx连接成功=======================");
            sqls = "select count(*) from zoneday_register where register_name='"+accountName+"'";
            ResultSet rs = stmt.executeQuery(sqls);  
            while(rs.next()){
            	result = rs.getInt("count(*)");
            }
            if(result > 0){  //为什么有两个sql语句，是因为如果用户没有手机端绑定过账号，就msql内会没有账户，判断下有会执行更新密码，没有也不会更新
	            System.err.println("================="+sql+"=======================");
	            result = stmt.executeUpdate(sql);// executeUpdate语句会返回一个受影响的行数，如果返回-1就没有成功
            }else{
            	result = -1;
            }
        } catch (Exception ex) {
            System.out.println("MySQL操作错误");
            ex.printStackTrace();
        }finally {
            conn.close();
        }
        return result;
    }
}

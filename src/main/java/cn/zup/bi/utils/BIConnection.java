package cn.zup.bi.utils;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * 读取Properties文件的例子，根据properties返回Connection
 * @author han
 */
public final class BIConnection {
	public static String URL;
	public static String USERNAME;
	public static String PASSWORD;
	public static String CLASSNAME;

	static {
		Properties prop = new Properties();
		InputStream in = BIConnection.class.getResourceAsStream("/dbconfig.properties");
		try {
			prop.load(in);
			URL = prop.getProperty("jdbc.url.mysql.bi").trim();
			USERNAME = prop.getProperty("jdbc.username.mysql.bi").trim();   //toLowerCase();
			PASSWORD = prop.getProperty("jdbc.password.mysql.bi").trim();
			CLASSNAME = prop.getProperty("jdbc.driverClassName.mysql.bi").trim();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 私有构造方法，不需要创建对象
	 */
	private BIConnection() {
	}

	/**
	 * 根据读取的Properties文件返回Connection
	 * @return Connection
	 */
	public static Connection OpenConn() {
		Connection conn = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	/**
	 * 关闭Connection链接
	 * @return void
	 */
	public static  void CloseConn(Connection conn) {
		try {
			if(conn!=null)
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String args[]) {
		System.out.println(USERNAME);
	}
	
	public static String getOwnerName() {
		return USERNAME;
	}
}

package cn.zup.bi.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public final class KeepConnUtils {
	
	private static Connection conn = null;
	private static String urlName = "jdbc:mysql://192.168.10.216:3306/mgeids?useUnicode=true&characterEncoding=UTF-8";
	private static String userName = "root";
	private static String pwdName = "andot";
	private static String className ="com.mysql.jdbc.Driver";
	
	private static Logger log= LoggerFactory.getLogger(KeepConnUtils.class);

	public static Connection openConn() {
		try {
			Class.forName(className);
			conn = DriverManager.getConnection(urlName, userName, pwdName);
		} catch (ClassNotFoundException | SQLException e) {
			log.error(e.getMessage());
			try {
				conn.close();
			} catch (SQLException e1) {
				log.error(e1.getMessage());
			}
		}
		return conn;
	}
	
	public static void closeConn() {
		try {
			conn.close();
		} catch (SQLException e1) {
			log.error(e1.getMessage());
		}
	}
}

package cn.zup.bi.utils;

/**
 * @author gavin
 * 组装数据库连接属性
 */
public class DatabaseParamBuilder {
    /**
     * 根据类型获取数据库驱动类
     * @param type
     * @return
     */
    public static String getClassName(String type){
        if(type.toLowerCase().equals("mysql")){
            return "com.mysql.jdbc.Driver";
        }
        return "";
    }

    /**
     * 根据数据类型获取数据库连接URL
     * @param ip
     * @param port
     * @param dsName
     * @param type
     * @return
     */
    public static String getUrl(String ip, Integer port, String dsName, String type){
        if(type.toLowerCase().equals("mysql")){
            return "jdbc:mysql://"+ip+":"+port+"/"+dsName+"?useUnicode=true&characterEncoding=UTF-8";
        }
        return "";
    }
}

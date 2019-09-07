package cn.zup.workflow.database;

import java.io.FileInputStream;
import java.util.Locale;
import java.util.Properties;
import java.util.ResourceBundle;


public class SystemConfig {
    static String configFile = "workflow";
    public static String getConfigInfomation(String itemIndex) {
        try {
        	Locale locale = Locale.getDefault();
            ResourceBundle resource = ResourceBundle.getBundle(configFile,locale,Thread.currentThread().getContextClassLoader());
            if(resource==null){
            	resource = ResourceBundle.getBundle(configFile,locale,SystemConfig.class.getClassLoader());
            }
            if(resource==null){
            	resource = ResourceBundle.getBundle(configFile);
            }
            return resource.getString(itemIndex);
        	
        	
        } catch (Exception e) {
            return "";
        }
    }
}
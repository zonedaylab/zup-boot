package cn.zup.framework.util;
import java.io.IOException;
import java.net.URLDecoder;

import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import net.sf.json.JSONObject;

/**
 * Java对URL发送Http请求
 * @author Andot
 * @date 2018-1-22 14:09:27
 * 
 * */
public class HttpRequestUtils {
	
    private static Logger logger = LoggerFactory.getLogger(HttpRequestUtils.class);
    
    /**  
     * 发送Post请求
     * @author andot
     * @return 
     */  
    public static JSONObject HTTPPostRequest(String url) { 
    	JSONObject jsonResult = new JSONObject();
    	DefaultHttpClient httpClient = new DefaultHttpClient();
    	HttpPost method = new HttpPost(url);
    	try {
            HttpResponse result = httpClient.execute(method);
            url = URLDecoder.decode(url, "UTF-8");
            System.out.println(url);
            /**请求发送成功，并得到响应**/
            if (result.getStatusLine().getStatusCode() == 200) {
                String str = "";
                try {
                    /**读取服务器返回过来的json字符串数据**/
                    str = EntityUtils.toString(result.getEntity());
                    /**把json字符串转换成json对象**/
                    jsonResult = JSONObject.fromObject(str);
                    System.out.println(str);
                } catch (Exception e) {
                    logger.error("post请求提交失败:" + url, e);
                }
            }
        } catch (IOException e) {
            logger.error("post请求提交失败:" + url, e);
        }
        return jsonResult;
    }  
    
    
    /**
     * 发送get请求
     * @param url 路径
     * @return
     */
    public static JSONObject HTTPGetRequest(String url){
        //get请求返回结果
    	JSONObject jsonResult = new JSONObject();
    	//发送get请求
        HttpGet method = new HttpGet(url);
        try {
            DefaultHttpClient client = new DefaultHttpClient();
            HttpResponse response = client.execute(method);
            /**请求发送成功，并得到响应**/
            if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
                /**读取服务器返回过来的json字符串数据**/
                String strResult = EntityUtils.toString(response.getEntity());
                /**把json字符串转换成json对象**/
                jsonResult = JSONObject.fromObject(strResult);
                url = URLDecoder.decode(url, "UTF-8");
            } else {
                logger.error("get请求提交失败:" + url);
            }
        } catch (IOException e) {
            logger.error("get请求提交失败:" + url, e);
        }
        return jsonResult;
    }
}

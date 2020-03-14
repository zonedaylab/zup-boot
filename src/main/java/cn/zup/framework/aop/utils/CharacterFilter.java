package cn.zup.framework.aop.utils;

import java.io.IOException;
import java.util.Enumeration;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.jasper.tagplugins.jstl.core.ForEach;
import org.apache.log4j.Logger;

import cn.zup.framework.aop.service.BusLog;

/**
 * 字符串特殊字符过滤器
 * @author Andot
 * @date 2017-12-18 08:27:03
 * 
 * */
@WebFilter(urlPatterns = "/*",filterName = "myfilter")
public class CharacterFilter  implements Filter {

	private static Logger log = Logger.getLogger(CharacterFilter.class);
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	 public void doFilter(ServletRequest args0, ServletResponse args1,
	            FilterChain chain) throws IOException, ServletException {
		System.out.println("进入过滤器>>>>>>>>>>>");
        HttpServletRequest req=(HttpServletRequest)args0;
        HttpServletResponse res=(HttpServletResponse)args1;
        System.err.println(req.getRequestURL());
        // 去掉RBAC系统管理界面的SQL过滤，因为rbac只有管理员本人才会使用，所以不会出现问题，也是添加菜单什么的也得需要特殊字符
        if(req.getRequestURL().indexOf("rest/rbac/") == -1){
            //获得所有请求参数名
            Enumeration params = req.getParameterNames();
            String sql = "";
            while (params.hasMoreElements()) {
                //得到参数名
                String name = params.nextElement().toString();
                //System.out.println("name===========================" + name + "--");
                //得到参数对应值
                String[] value = req.getParameterValues(name);
                for (int i = 0; i < value.length; i++) {
                    sql = sql + " "+value[i];
                }
            }
            sql=sql.trim();
            System.out.println("============================SQL"+sql);
            if (sql.equals(""))
                chain.doFilter(args0,args1);
            else{
                String[] words= sql.trim().toLowerCase().split("\\s+");
                if (sqlValidate(words)) {
                    throw new IOException("您发送请求中的参数中含有非法字符："+ sql);//有sql关键字，跳转到error.html
                } else {
                    chain.doFilter(args0,args1);
                }
            }
        }else{
            chain.doFilter(args0,args1);
        }
    }
     
    //效验
    protected static boolean sqlValidate(String[] words) {
        //统一转为小写
        String badStr = "'|and|exec|execute|insert|select|delete|update|count|drop|*|chr|mid|master|truncate|" +
                "char|declare|sitename|net user|xp_cmdshell|;|or|like'|and|exec|execute|insert|create|drop|sleep|" +
                "from|grant|use|group_concat|column_name|" +
                "information_schema.columns|table_schema|union|where|select|delete|update|order|by|count|*|" +
                "chr|mid|master|truncate|char|declare|or|;|--|++|like|#";//过滤掉的sql关键字，可以手动添加
        for(int i=0;i<words.length;i++){
            String word = "|" + words[i] + "|";
            if(badStr.indexOf(word)>=0)
                return true;
        }
        return false;
    }

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}

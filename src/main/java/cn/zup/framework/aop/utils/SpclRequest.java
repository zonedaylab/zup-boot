package cn.zup.framework.aop.utils;

import java.util.Enumeration;
import java.util.Map;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

/**
 * 特殊的请求，过滤字符串逻辑
 * @author Andot
 * @date 2017-12-16
 * 
 * */
public class SpclRequest extends HttpServletRequestWrapper {
	private Map params;
	 
    public SpclRequest(HttpServletRequest request, Map newParams) {
         super(request);
         this.params = newParams;
    }

    public Map getParameterMap() {
          return params ;
    }

    public Enumeration getParameterNames() {
             Vector l = new Vector( params.keySet());
             return l.elements();
   }

    public String[] getParameterValues(String name) {
        Object v = params.get(name);
         if (v == null ) {
                   return null ;
        } else if (v instanceof String[]) {
                  String[] value = (String[]) v;
                   for (int i = 0; i < value.length; i++) {
                           value[i] = value[i].replaceAll( "<", "&lt;" );
                           value[i] = value[i].replaceAll( ">", "&gt;" );
                  }
                   return (String[]) value;
        } else if (v instanceof String) {
                  String value = (String) v;
                  value = value.replaceAll( "<", "&lt;" );
                  value = value.replaceAll( ">", "&gt;" );
                   return new String[] { (String) value };
        } else {
                   return new String[] { v.toString() };
        }
    }

    public String getParameter(String name) {
        Object v = params.get(name);
         if (v == null ) {
                   return null ;
        } else if (v instanceof String[]) {
                  String[] strArr = (String[]) v;
                   if (strArr.length > 0) {
                           String value = strArr[0];
                           value = value.replaceAll( "<", "&lt;" );
                           value = value.replaceAll( "<", "&gt;" );
                            return value;
                  } else {
                            return null ;
                  }
        } else if (v instanceof String) {
                  String value = (String) v;
                  value = value.replaceAll( "<", "&lt;" );
                  value = value.replaceAll( ">", "&gt;" );
                   return (String) value;
        } else {
                   return v.toString();
        }
    }
}

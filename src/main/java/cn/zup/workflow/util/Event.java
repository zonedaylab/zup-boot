package cn.zup.workflow.util;  
import java.lang.reflect.Method;    
import java.util.Date;    
public class Event{    
    //要执行方法的对象    
    private Object object;    
    //要执行的方法名称    
    private String methodName;    
    //要执行方法的参数    
    private Object[] params;    
    //要执行方法的参数类型    
    @SuppressWarnings("rawtypes")
	private Class[] paramTypes;             
    public Event(){    
            
    }    
    public Event(Object object,String methodName){    
        this.object=object;    
        this.setMethodName(methodName);    
    }    
    public Event(Object object,String methodName,Object...args){    
        this.object=object;    
        this.setMethodName(methodName);    
        this.params=args;    
        contractParamTypes(this.params);    
    }    
    //根据参数数组生成参数类型数组    
    private void contractParamTypes(Object[] params){    
        this.paramTypes=new Class[params.length];    
        for(int i=0;i<params.length;i++){    
            this.paramTypes[i]=params[i].getClass();    
        }    
    } 
    
    //设置参数
    public void setParam(Object...args)
    {    
    	this.params=args;    
        contractParamTypes(this.params); 
    }        
    
    public Object getObject() {    
        return object;    
    }    
           
    public void setObject(Object obj)
    {
    	object=obj;
    }
    public void setParamTypes(@SuppressWarnings("rawtypes") Class[] paramTypes) {    
        this.paramTypes = paramTypes;    
    }   	
    
    public String getMethodName() {
		return methodName;
	}
	public void setMethodName(String methodName) {
		this.methodName = methodName;
	}   
    //执行该 对象的该方法    
    public Object invoke() throws Exception{    
        Method method=object.getClass().getMethod(this.getMethodName(), this.paramTypes);    
        if(null==method){    
            return null;    
        }    
        return method.invoke(this.getObject(), this.params);    
    }
    

  
}   
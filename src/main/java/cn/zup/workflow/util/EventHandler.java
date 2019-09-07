package cn.zup.workflow.util;

import java.util.ArrayList;    
import java.util.List;    
   
public class EventHandler {    
    //是用一个List    
    private List<Event> objects;    
    private List<Object>retValues;
        
    public EventHandler(){    
        objects=new ArrayList<Event>();  
        retValues=new ArrayList<Object>();
    }    
    //添加某个对象要执行的事件，及需要的参数    
    public void addEvent(Object object,String methodName,Object...args){    
        objects.add(new Event(object,methodName,args));    
    }    
    //通知所有的对象执行指定的事件    
    public List<Object> Excute() throws Exception{    
        for(Event e : objects){    
        	retValues.add( e.invoke());    
        }  
        return retValues;
    } 
    //返回值
    public List<Object> getRetValues()
    {
    	return retValues;
    }
}   
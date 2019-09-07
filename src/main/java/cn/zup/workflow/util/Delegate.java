package cn.zup.workflow.util;
import java.util.List;

public  class Delegate {   
    private EventHandler eventHandler=new EventHandler();            
    public EventHandler getEventHandler() {    
        return eventHandler;    
    }    
    public void setEventHandler(EventHandler eventHandler) {    
        this.eventHandler = eventHandler;    
    }       
    public  void addListener(Object object,String methodName,Object...args)
    {
    	 this.getEventHandler().addEvent(object, methodName, args);    
    }
    public  List<Object>  Excute() throws Exception
    {
    	return this.getEventHandler().Excute();  
    	 
    }
}   
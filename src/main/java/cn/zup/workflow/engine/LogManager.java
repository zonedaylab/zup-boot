package cn.zup.workflow.engine;

import cn.zup.workflow.engine.settings.DataBaseActionEnum;

public final class LogManager{
	public static final String LoggerName = "WFService";
	//public static final ILog Logger = log4net.LogManager.GetLogger(LoggerName);



	/**         
	 Add a error log        
	 @param errorMessage        
	*/
	public static void AddError(String errorMessage){
		//Logger.Error(errorMessage);
	}

	/**         
	 Add a error log with an exception        
	 @param errorMessage       
	 @param ex        
	*/
	public static void AddError(String errorMessage, RuntimeException ex){
		//Logger.Error(errorMessage + System.lineSeparator() + ex.getMessage() + System.lineSeparator() + ex.toString());
	}

	/**         
	 Add a warning log        
	 @param warnMessage        
	*/
	public static void AddWarn(String warnMessage){
	//	Logger.Warn(warnMessage + "\n");
	}

	/**         
	 @param warnMessage        
	 @param ex        
	*/
	public static void AddWarn(String warnMessage, RuntimeException ex){
		//Logger.Warn(warnMessage + System.lineSeparator() + ex.getMessage() + System.lineSeparator() + ex.toString());
	}

	/**         
	 Add a info log        
	 @param infoMessage        
	*/
	public static void AddInfo(String infoMessage){
		//Logger.Info(infoMessage + "\n\t");
	}

	/**         
	 Add a info log with an exception        
	 @param infoMessage        
	 @param ex        
	*/
	public static void AddInfo(String infoMessage, RuntimeException ex){
		//Logger.Info(infoMessage + System.lineSeparator() + ex.getMessage() + System.lineSeparator() + ex.toString());
	}

	/**         
	 Add a debug log        
	 @param debugMessage       
	*/
	public static void AddDebug(String debugMessage){
		//Logger.Debug(debugMessage);
	}

	/**         
	 Add a debug log with an exception        
	 @param debugMessage        
	 @param ex        
	*/
	public static void AddDebug(String debugMessage, RuntimeException ex){
		//Logger.Debug(debugMessage + System.lineSeparator() + ex.getMessage() + System.lineSeparator() + ex.toString());
	}
	/**         
	 Add a database error log         
	 @param objectName table or view name        
	 @param dbAction either retrieve, update, delete       
	 @param ex        
	*/
	public static void AddDatabaseError(String objectName, int dbAction, RuntimeException ex){
		String logMessage = "";
			if(dbAction==DataBaseActionEnum.Select.getValue()){
				logMessage = "Error occurred when retrieve data from table " + objectName;
			}else if(dbAction== DataBaseActionEnum.Insert.getValue()){
				logMessage = "Error occurred when insert data to table " + objectName;
			}else if(dbAction == DataBaseActionEnum.Update.getValue()){
				logMessage = "Error occurred when update data to table " + objectName;
			}else if(dbAction== DataBaseActionEnum.Delete.getValue()) {
				logMessage = "Error occurred when delete data from table " + objectName;
			}
		AddError(logMessage, ex);
	}
}

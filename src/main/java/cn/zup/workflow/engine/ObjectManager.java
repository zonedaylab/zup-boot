package cn.zup.workflow.engine;

import java.util.*;

import com.sun.corba.se.impl.orbutil.concurrent.Mutex;

import cn.zup.workflow.engine.settings.LogInfoEnum;
import cn.zup.workflow.engine.settings.ThreadFlagEnum;
import cn.zup.workflow.model.WF_WORK_ACTIVITY;


/**
 * 将在第一次引用类的任何成员时创建实例。公共语言运行库负责处理变量初始化。
 * 该类标记为 sealed 以阻止发生派生，而派生可能会增加实例。有关将类标记为 
   该实现与前面的示例类似，不同之处在于它依赖公共语言运行库来初始化变量。
 * 它仍然可以用来解决 Singleton 模式试图解决的两个基本问题：全局访问和
 * 实例化控制。公共静态属性为访问实例提供了一个全局访问点。此外，由于
 * 构造函数是私有的，因此不能在类本身以外实例化 Singleton 类；因此，
 * 变量引用的是可以在系统中存在的唯一的实例。 
 */

public   class ObjectManager{
	private ArrayList<SWork> sWorkList = new ArrayList<SWork>();
	private Mutex mutex = new Mutex();
	private Mutex mutexTest = new Mutex();
	private FlowThread flowThread = new FlowThread("工作流线程");
	private GetWorkThread getWorkThread = new GetWorkThread("获取工作线程");
	private ArrayList<ThreadBase> threadBaseList = new ArrayList<ThreadBase>(); //线程队列
	private HashMap<Integer, SWorkActivity> dicWorkList = new HashMap<Integer, SWorkActivity>(); //work_id ,最大时间
	private boolean mTest;	//测试标志用来遍历所有的工作
	public  ObjectManager objectManager = new ObjectManager();

	public void Init(){
		this.flowThread.StartThread();
		this.getWorkThread.StartThread();
		threadBaseList.add(flowThread);
		threadBaseList.add(getWorkThread);
		mTest = false;
		String strLog = "工作流引擎启动...";
		ShowLog(strLog,LogInfoEnum.INFO_COMMON.getValue());
	}

	
	public void setTestFlag(boolean value) throws InterruptedException{
		this.mutexTest.wait();
		mTest = value;
		this.mutexTest.release();
	}
	public boolean getTestFlag() throws InterruptedException{
		boolean flag = false;
		this.mutexTest.wait();
		flag = mTest;
		//this.m_MutexTest.ReleaseMutex();
		this.mutexTest.release();
		return flag;
	}




	  public   boolean GetWork(SWork data) throws InterruptedException{
				boolean flag = false;
				//data.argValue = new SWork();
				this.mutex.wait();
				if (this.sWorkList.size() > 0){
					data= this.sWorkList.get(0);
					this.sWorkList.remove(data);
					flag = true;
				}
				this.mutex.release();
				return flag;
	  }
	 public   boolean IsWorkEmpty(){
		if (this.sWorkList.size() > 0){
			return false;
		}
		return true;
	 }
	 public   void PushWork(SWork data) throws InterruptedException{
		this.mutex.wait();
		this.sWorkList.add(data);
		this.mutex.release();
	 }
			/** 
			 遍历工作活动，获取需要推动的活动
			*/
			public   void TraverseWorkActivity(){
				try{
					SWork sWork;
					 List<WF_WORK_ACTIVITY> listActivity = WfDal.WF_GetWorkActivity();
					for (int i=0;i<listActivity.size();i++){
						boolean bGeneFlag = false;
						sWork = new SWork();
						sWork.nFlowID =listActivity.get(i).getFlow_ID();
						sWork.nWorkID = listActivity.get(i).getWORK_ID();
						Date dtFinished = listActivity.get(i).getFINISHED_DATETIME();
						int WorkActivityID = listActivity.get(i).getWORK_ACTIVITY_ID();
						if (dicWorkList.keySet().contains(sWork.nWorkID)){
							if (WorkActivityID != dicWorkList.get(sWork.nWorkID).nWorkActivityID){
								if (dtFinished.compareTo(dicWorkList.get(sWork.nWorkID).dtMaxFinishedDateTime) > 0){
									dicWorkList.get(sWork.nWorkID).dtMaxFinishedDateTime = dtFinished;
									dicWorkList.get(sWork.nWorkID).nWorkActivityID = WorkActivityID;
									dicWorkList.get(sWork.nWorkID).dicActivitys.clear();
									bGeneFlag = true;
								}else if (dtFinished.equals(dicWorkList.get(sWork.nWorkID).dtMaxFinishedDateTime)){
									//可能存在同一个时间点完成的活动
									HashMap<Integer, Date> test = dicWorkList.get(sWork.nWorkID).dicActivitys;
									if (!(dicWorkList.get(sWork.nWorkID).dicActivitys.keySet().contains(WorkActivityID))){
										dicWorkList.get(sWork.nWorkID).dicActivitys.put(WorkActivityID, dtFinished);
										bGeneFlag = true;
									}
								}
							}
						}else{
							SWorkActivity sWorkActivity = new SWorkActivity();
							sWorkActivity.dicActivitys = new HashMap<Integer, Date>();
							sWorkActivity.nWorkActivityID = WorkActivityID;
							sWorkActivity.dtMaxFinishedDateTime = dtFinished;
							dicWorkList.put(sWork.nWorkID, sWorkActivity);
							bGeneFlag = true;
						}
						if (bGeneFlag){
						   try {
							PushWork(sWork);
						} catch (InterruptedException e) {
							e.printStackTrace();
						}
						}
					}
				}catch (RuntimeException ex){
					ShowLogError("获取数据库激活工作出错", ex);
				}
			}
			/** 
			 显示工作缓存区信息
			*/
			public   void ListWorkCache(){
				String strMsg;
				for (int item : dicWorkList.keySet()){
					strMsg = String.format("WorkID=%1$s,WorkActivityID=%2$s,DateTime=%3$s,<<", item, dicWorkList.get(item).nWorkActivityID, dicWorkList.get(item).dtMaxFinishedDateTime.toString());
					for (int activiyID : dicWorkList.get(item).dicActivitys.keySet()){
					   strMsg = strMsg + String.valueOf(activiyID) + "  " +String.valueOf(dicWorkList.get(item).dicActivitys.get(activiyID)) + ";";
					}
					strMsg += ">>";
				}
			}


	public   class RefObject<T>{
		public T argValue;
		public RefObject(T refArg){
			argValue = refArg;
		}
	}
	  /** 
	   
	   
	   @param strLog
	   @param bInfoLevel 信息级别
	  */
		public   void ShowLog(String strLog, int Level){
			if (Level == LogInfoEnum.INFO_CRITICAL.getValue()){
				//Log.AddWarn(strLog);
			}else{
				//Log.AddInfo(strLog);
			}
		}

		public   void ShowLogError(String errorMessage, RuntimeException ex){
		   String strLog = errorMessage + System.lineSeparator() + ex.getMessage() + System.lineSeparator() + ex.toString();
		}
		public   void ShowLogError(String errorMessage){
			String strLog = errorMessage + System.lineSeparator() + System.lineSeparator();
		}
		public   void StopThread(){
			for (int i = 0; i < this.threadBaseList.size(); i++){
				threadBaseList.get(i).setThreadFlag((int) ThreadFlagEnum.NEED_QUIT.getValue());
			}
			while (true){
				boolean bQuit = true;
				for (int i = 0; i < this.threadBaseList.size(); i++){
				   if (threadBaseList.get(i).getThreadFlag()!= (int)ThreadFlagEnum.FLAG_QUIT.getValue()){
					   bQuit = false;
					   break;
				   }
				}
				if (bQuit){
					break;
				}else{
				try {
					Thread.sleep(1000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				}
			}

		}
		// Properties
		public  ObjectManager getInstance(){
			return objectManager;
		}
	}

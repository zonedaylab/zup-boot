package cn.zup.workflow.engine;

import cn.zup.workflow.engine.settings.ThreadFlagEnum;

/*************************************************************************
* Copyright (c) 2009,电力研究所     All rights reserved.
* 项目名称： PowerCL
* 文件名称： BaseThread.cs
* 描    述： 线程基类
* 
* 
* V1.0，2009.7.12 1:52，liuxf
************************************************************************/

public abstract class ThreadBase{
	private Thread mThread; //线程控制对象
	private String mName; //线程名字
	private int threadFlag;
	
	public ThreadBase(){

	}
	//构造函数
	public ThreadBase(String name){
		mName = name;
		mThread = new Thread(){
		public void run(){
			Run();
		}
		};
	}
	//线程启动函数
	public final void StartThread(){
		setThreadFlag(ThreadFlagEnum.RUNNING.getValue());
		mThread.start();

	}
	//线程运行函数
	public abstract void Run();
	
	//getSet方法
	public final String getName(){
		return mName;
	}
	public final void setName(String value){
		mName = value;
	}
	public final int getThreadFlag(){
		return threadFlag;
	}
	public final void setThreadFlag(int value){
		threadFlag = value;
	}
}

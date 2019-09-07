package cn.zup.workflow.engine;

import java.sql.SQLException;
import cn.zup.workflow.engine.settings.ThreadFlagEnum;

/**
 * 工作流引擎
 * */



public class FlowThread extends ThreadBase{
	private WfEngie wfEngine;
	private FlowThread flowThread;
	private ObjectManager objectManager;
	public FlowThread(String name){
		super(name);
		wfEngine = new WfEngie();
	}

	@Override
	public void Run(){
		SWork data = null;
		while (flowThread.getThreadFlag() == (int)ThreadFlagEnum.RUNNING.getValue()){
			  SWork tempRef_data = new SWork();
			  try {
				if (objectManager.GetWork(tempRef_data)){
					  data = tempRef_data;
					  if (wfEngine.InitAOV(data.nFlowID, data.nWorkID)){
						  try {
							wfEngine.BFS();
						} catch (SQLException e) {
							e.printStackTrace();
						}
					  } else{
						  String strMsg = String.format("错误的流程ID[%1$s]，工作ID[%2$s],请检查数据库", data.nFlowID, data.nWorkID);
						  objectManager.ShowLogError(strMsg);
					  }
				  }else{
				  data = tempRef_data;
  }
			} catch (InterruptedException e1) {
				e1.printStackTrace();
			}
			  try {
				Thread.sleep(10);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		//线程退出
		flowThread.setThreadFlag(ThreadFlagEnum.FLAG_QUIT.getValue());
	}
}


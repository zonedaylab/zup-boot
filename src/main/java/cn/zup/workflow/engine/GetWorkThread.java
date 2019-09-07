package cn.zup.workflow.engine;

import java.util.List;

import cn.zup.workflow.engine.settings.ThreadFlagEnum;
import cn.zup.workflow.model.WF_WORK;

/** 
 获取工作线程
 
 
*/

public class GetWorkThread extends ThreadBase{
	private ObjectManager objectManager;
	private ThreadBase threadBase;
	public GetWorkThread(String name){
		super(name);
	}

	@Override
	public void Run(){
		SWork sWork;
		while (threadBase.getThreadFlag() == (int)ThreadFlagEnum.RUNNING.getValue()){
			java.time.LocalDateTime datetime = java.time.LocalDateTime.now();
			if (!objectManager.IsWorkEmpty()){
				try {
					Thread.sleep(10);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				continue;
			}
			//清除缓存
			if (datetime.getMinute() % 10 == 0 && datetime.getSecond() == 0){

			}
			try {
				if (objectManager.getTestFlag()){
					try{
						objectManager.setTestFlag(false);
						List<WF_WORK> list= WfDal.WF_GetActiveWork();
						for (int i=0;i<list.size();i++){
							sWork = new SWork();
							sWork.nFlowID = list.get(i).getFLOW_ID();
							sWork.nWorkID =list.get(i).getWORK_ID();
							objectManager.PushWork(sWork);
						}
					}
					catch (RuntimeException ex){
						objectManager.ShowLogError("获取数据库激活工作出错", ex);

					}
					try {
						Thread.sleep(1000);
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}else{
					objectManager.TraverseWorkActivity();
					try {
						Thread.sleep(1000);
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
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
		threadBase.setThreadFlag(ThreadFlagEnum.FLAG_QUIT.getValue());
	}
}
package cn.zup.workflow.engine;

import java.util.ArrayList;
import java.util.HashMap;

import cn.zup.workflow.engine.settings.ActivityNodeTypeEnum;
/**
 * 
	 * 节点状态：0 休眠 1 激活状态  3 完成状态 4僵死状态
	 * 0 休眠状态Sleep。
	 *  一 如果父亲节点休眠数量+激活数量>0, 则保持原状态。
	 *  二 如果父亲节点已经全部僵死，父亲节点数量=父节点僵死数量，则转化为僵死状态，
	 *     并更新自己的子节点父亲僵死数目。
	 *  三 如果父亲节点完成数量>0,即：父亲节点数量=父节点完成数量+父节
	 *     点僵死数量，则跳转到2激活状态。更新子节点的父亲分支激活数目
	 * 1 激活状态,不做处理
	 * 2 完成状态  
	 * 首先要判断子节点的僵死分支与该节点是否相同，
	 * 不相同则更新子节点的父分支完成数目++（休眠--）
	 * 3 僵死状态
	 * 更新子节点的父分支僵死数目（休眠--）
	 * 此处的依据包括
	 * 1 激活状态 完成状态不会相互转换
	 * 2只有休眠状态向激活状态的转换
 * @author Administrator
 *
 */
public class ActivityNode{
	public String  nActivityCode; //活动序号，对应WF_ACTIVITY--> ACTIVITY_CODE
	public Integer nAcitivityID; //活动ID
	public Integer workActivityID; //工作活动ID
	public String  strResponsible; //当前活动经办人
	public String  strRealNextResponsibles; //子节点实际经办人
	public Integer byMergeType;/*节点汇聚类型,从数据库中取出 0-串行节点 1-并发汇聚  2-分支汇聚  3-异步汇聚*/
	public Integer byBranchType;/*节点分支类型 * 0-串行节点* 1-并行分叉 * 2-多路选择 * 3-排他选择 */
	public String  strDiedParentBranchs;
	public String  strNextActivityCodes;
	public String  strActiveNextActivityCodes; //实际激活的Branch
	public boolean bNeedActive;
	public Integer nParentCount;
	public Integer nParentBranchActiveCount;
	public Integer nParentBranchDiedCount;//注：nParentBranchSleepCount不是自变量，而是因变量。最初数目等于父节点的数量
	public Integer byActivityNodeType;//节点状态：0 休眠 1 激活状态  3 完成状态 4僵死状态
	public Integer inEdges; //入度域
	
	
	public  int getnParentBranchSleepCount(){
		return nParentCount - nParentBranchDiedCount - nParentBranchActiveCount;
	}
	//初始化
	public  void Init(){
		nParentCount = 0;
		nParentBranchDiedCount = 0;
		inEdges = 0;
		bNeedActive = false;
		byActivityNodeType = ActivityNodeTypeEnum.SLEEP.getValue();
		byMergeType = 0;
		byBranchType = 0;
		strNextActivityCodes = "";
		strActiveNextActivityCodes = "";
	}
	/*
	 * 用于遍历所有节点，构建支撑网络
	 * 循环检测邻接表入度为0的活动，并将其压栈，同期入栈中的为并行活动
	 * 初始化时等于父亲节点数量
	 */
	
	public ArrayList<ActivityNode> listChildren = new ArrayList<ActivityNode>();
	
	public  void ChangeActivityProperty(HashMap<String, ActivityNode> listAOV){
		String[] nextAllBraches = this.strNextActivityCodes.split("[,]", -1);
		//休眠状态	
		if(byActivityNodeType==ActivityNodeTypeEnum.SLEEP.getValue()){
			if (nParentCount > 0){
				//如果父分支休眠数量>0, 更新子节点状态为SLEEP
				if (getnParentBranchSleepCount() > 0){
					if (strNextActivityCodes.length() > 0){
						for (String branch : nextAllBraches){
							listAOV.get(branch).byActivityNodeType = ActivityNodeTypeEnum.SLEEP.getValue();
						}
					}
					return;
				}
				//如果父分支已经全部僵死，则转化为僵死状态，并更新自己的子节点父分支僵死数目。
				if (nParentBranchDiedCount == nParentCount){
					byActivityNodeType = ActivityNodeTypeEnum.DIED.getValue();
					if (strNextActivityCodes.length() > 0){ //没有子节点
						for (String branch : nextAllBraches){
							listAOV.get(branch).nParentBranchDiedCount++;
						}
					}
				}
				//三 如果父分支节点休眠数量=0，激活数量>0,即：父亲分支数量=父分支激活数量+父分支,僵死数量，则跳转到2激活状态
				else if (this.nParentBranchActiveCount > 0){
					bNeedActive = true;
				}
		  }
	   }
		//激活状态
		if(byActivityNodeType==ActivityNodeTypeEnum.ACTIVE.getValue()){
			//设置分支仍然处于休眠状态
			if (strNextActivityCodes.length() > 0){
				for (String branch : nextAllBraches){
					listAOV.get(branch).byActivityNodeType = ActivityNodeTypeEnum.SLEEP.getValue();
				}
			}
		}
		//完成状态
		if(byActivityNodeType==ActivityNodeTypeEnum.FINISHED.getValue()){
			if (strNextActivityCodes.length() == 0){ //没有子节点
				//break;
			}
			//父亲节点完成，子分支可能会转化为僵死或者激活状态
			String[] nextActiveBraches = strActiveNextActivityCodes.split("[,]", -1);
			HashMap<String, String> dicActiveBraches = new HashMap<String, String>();
			for (String activeBranch : nextActiveBraches){
				dicActiveBraches.put(activeBranch, activeBranch);
			}
			if (nextActiveBraches.length > 0){ //说明已经流转
				for (String branch : nextAllBraches){
					if (dicActiveBraches.containsKey(branch)){
						listAOV.get(branch).nParentBranchActiveCount++;
					}else{
						listAOV.get(branch).nParentBranchDiedCount++;
					}
					/*TODO:
					 * 此处需要强烈测试                                                                
					 * 此处需要判断子分支如果已经处于完成状态的情况，由于工作流驳回的缺陷
					 * 说明完成不是真正完成。只有比父亲节点大的节点如果完成，才是真正地完成。
					 * 子分支的WORK_ACTIVITY_ID永远要大于父分支的WORK_ACTIVITY_ID.如果小于
					 * 则说明属于驳回的分支节点，应该被滤除。
					 * by liuxf 2012.08.24
					 */
					if (listAOV.get(branch).byActivityNodeType == (byte)ActivityNodeTypeEnum.FINISHED.getValue() && listAOV.get(branch).workActivityID < this.workActivityID){
						listAOV.get(branch).byActivityNodeType =  ActivityNodeTypeEnum.SLEEP.getValue();
					}
				}
		  }
	   }
	  //僵死状态
	  if(byActivityNodeType==ActivityNodeTypeEnum.DIED.getValue()){
		if (strNextActivityCodes.length() > 0){
			for (String branch : nextAllBraches){
				listAOV.get(branch).nParentBranchDiedCount++;
			}
		}
	  }
	}
}





package cn.zup.workflow.engine;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Stack;
import cn.zup.workflow.engine.settings.ActivityNodeTypeEnum;
import cn.zup.workflow.model.ACTIVITY_AOV;

public class WfEngie{
	///#region 基于AOV网的广度优先搜索算法
	private ObjectManager objectManager;
	private HashMap<String, ActivityNode> listAOV = new HashMap<String, ActivityNode>();
	private int nWorkId;
	private int nFlowId;
	public final boolean InitAOV(int nWorkId, int nWorkID){
		nWorkId = nWorkID;
		nFlowId = nWorkId;
		try{
			List<ACTIVITY_AOV> list = WfDal.WF_GetAOVNet(nWorkId, nWorkID);
			if (list.size() == 0){
				return false;
			}
			listAOV.clear();
			ActivityNode node;
			for (int i=0;i<list.size();i++){
				node = new ActivityNode();
				node.Init();
				node.nActivityCode = String.valueOf(list.get(i).getACTIVITY_CODE());
				//初始化僵死分支
				node.nParentCount = WfDal.WF_GetActivityParentCount(list.get(i).getACTIVITY_ID()); //调用存储过程
				node.inEdges = node.nParentCount;
				node.byMergeType = 0;
				//怎么找到第一个僵死点
				switch (list.get(i).getFINISH_FLAG()){
					case 0:
						node.byActivityNodeType = ActivityNodeTypeEnum.SLEEP.getValue();
						break;
					case 1:
						node.byActivityNodeType =ActivityNodeTypeEnum.ACTIVE.getValue();
						break;
					case 2:
						node.byActivityNodeType = ActivityNodeTypeEnum.FINISHED.getValue();
						break;
				}
				if (list.get(i).getNEXT_ACTIVITY_CODE()!= null){
					node.strNextActivityCodes = String.valueOf(list.get(i).getNEXT_ACTIVITY_CODE());
					if (!StringHelper.isNullOrEmpty(node.strNextActivityCodes) &&node.strNextActivityCodes.substring(node.strNextActivityCodes.length() - 1, 1) == ","){
						node.strNextActivityCodes = node.strNextActivityCodes.substring(node.strNextActivityCodes.length() - 1, 1);
					}
				}
				if (list.get(i).getREAL_NEXT_ACTIVITY_CODES()!= null){
						node.strActiveNextActivityCodes = list.get(i).getREAL_NEXT_ACTIVITY_CODES();
				 }
				if (list.get(i).getACTIVITY_ID()!=0){
					node.nAcitivityID = list.get(i).getACTIVITY_ID();
				}
				if (list.get(i).getWORK_ACTIVITY_ID()!= null){
				  node.workActivityID =list.get(i).getWORK_ACTIVITY_ID();
				}
				//实际下一个节点的经办人
				String nActivityCode =String.valueOf(list.get(i).getACTIVITY_CODE());
				if (!listAOV.containsKey(nActivityCode)){
					listAOV.put(String.valueOf(list.get(i).getACTIVITY_CODE()), node);
				}else{
				   if (list.get(i).getFINISH_FLAG() == 1){ //没有完成，新的工作{
					   listAOV.put(nActivityCode, node);
				   }
				}
			   //说明是最新的节点，采用最新的节点，使用最新的节点
			   if (node.workActivityID > listAOV.get(nActivityCode).workActivityID){
				   listAOV.put(nActivityCode, node);
			   }
			}
			}finally{
				objectManager.ShowLogError("链接数据库错误");
			}
			return true;
		}



		public final void BFS() throws SQLException{
			int i;
			Stack<ActivityNode> stackNodesZeroInEdges = new Stack<ActivityNode>();
			Stack<ActivityNode> stackNodesZeroInEdgesTmp = new Stack<ActivityNode>();
			ArrayList<ActivityNode> listOut = new ArrayList<ActivityNode>(); //输出队列
			StringBuilder strMsg = new StringBuilder();
			strMsg.append(String.format("流程ID[%1$s]工作ID[%2$s],拓扑序列[",this.nFlowId,this.nFlowId));
			try{
				//循环检测邻接表入度为0的活动，并将其压栈，同期入栈中的为并行活动
				for (Map.Entry<String, ActivityNode> item : listAOV.entrySet()){
					if (item.getValue().inEdges == 0)
					{
						stackNodesZeroInEdges.push(item.getValue());
					}
				}
				while (stackNodesZeroInEdges.size() > 0){
					while (stackNodesZeroInEdges.size() > 0){
						ActivityNode node = stackNodesZeroInEdges.pop(); //栈顶元素出栈
						node.ChangeActivityProperty(listAOV);
						listOut.add(node); //将栈顶元素放入拓扑序列数组中，同时也表示了已经进入拓扑序列中的元素个数
						if (node.strNextActivityCodes.length() == 0){
							continue;
						}
						String[] nextAllBraches = node.strNextActivityCodes.split("[,]", -1);
						for (String branch : nextAllBraches){
							ActivityNode childNode = listAOV.get(branch);
							/*
							 * 广度优先便利栈顶元素相邻的顶点，并将邻接顶点入度减1，
							 * 找出入度为0的顶点入临时栈stackNodesZeroInEdgesTmp
							*/
							if (--childNode.inEdges == 0){
								stackNodesZeroInEdgesTmp.push(childNode);
							}
						}
					}
					for (ActivityNode node : stackNodesZeroInEdgesTmp){
						stackNodesZeroInEdges.push(node);
					}
					stackNodesZeroInEdgesTmp.clear();
				}
				if (listOut.size() == listAOV.size()){ //当拓扑序列中的元素个数为总元素个数，则拓扑排序成功并输入序列
					for (i = 0; i < listOut.size(); i++){
						strMsg.append(listOut.get(i).nActivityCode.toString());
						if (i < listOut.size() - 1){
							strMsg.append("-->");
						}
					}
					strMsg.append("]");
				}else{
					strMsg.append("The network has cycle"); //当拓扑序列中元素个数少于总元素个数，则AOV网中存在环路，拓扑排序失败
				}
				//LOG_INFO bInfoLevel = LOG_INFO.INFO_COMMON;
				boolean bWorkFinished = true; //判断工作是否完成
				for (Map.Entry<String, ActivityNode> item : listAOV.entrySet()){
					if (item.getValue().bNeedActive){ //遍历需要激活的节点，进行激活
						WfDal.WF_WorkServiceNewActivity(nFlowId, item.getValue().nAcitivityID, item.getValue().strResponsible);
						strMsg.append(String.format("激活节点[%1$s]", item.getValue().nActivityCode.toString()));
						//bInfoLevel = LOG_INFO.INFO_CRITICAL;
					}
					if (item.getValue().byActivityNodeType == (byte)ActivityNodeTypeEnum.SLEEP.getValue() || item.getValue().byActivityNodeType == (byte)ActivityNodeTypeEnum.ACTIVE.getValue()){
						bWorkFinished = false;
					}
				}
				if (listAOV.size() > 0 && bWorkFinished){ //设置工作结束
					WfDal.WF_SetWorkFinish(nFlowId);
					strMsg.append("工作结束");
					//bInfoLevel = LOG_INFO.INFO_CRITICAL;
				}
				//objectManager.ShowLog(strMsg.toString(),bInfoLevel);
			}catch (RuntimeException ex){
				objectManager.ShowLogError("BFS执行异常", ex);
			}

}
	}


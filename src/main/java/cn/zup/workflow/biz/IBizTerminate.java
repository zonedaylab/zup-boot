package cn.zup.workflow.biz;

import cn.zup.workflow.structure.TerminateNode;

/// <summary>
/// 接口：强制终止方法
/// </summary>
public interface IBizTerminate{
	/**
	 * 强制终止时所需的业务操作
	 * @param strWorkID
	 * @param strMainBizKey
	 * @param terminateNode
	 */
    void updateBizTerminate(int strWorkID, String strMainBizKey, TerminateNode terminateNode);
}

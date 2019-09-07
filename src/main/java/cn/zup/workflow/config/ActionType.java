package cn.zup.workflow.config;

/// <summary>
/// 按钮操作命令
/// </summary>
public enum ActionType
{
	/// <summary>
    /// 保存
    /// </summary>
    Save,

    /// <summary>
    /// 提交
    /// </summary>
    Commit,

    /// <summary>
    /// 审核
    /// </summary>
    Check,

    /// <summary>
    /// 驳回
    /// </summary>
    Reject,

    /// <summary>
    /// 添加
    /// </summary>
    Add;

	public int getValue()
	{
		return this.ordinal();
	}

	public static ActionType forValue(int value)
	{
		return values()[value];
	}
}

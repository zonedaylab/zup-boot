package cn.zup.workflow.engine;

import java.util.Date;
import java.util.HashMap;

public class SWorkActivity {
	public Date dtMaxFinishedDateTime = new Date(); //当前完成活动最新时间
	public int nWorkActivityID; //最新完成活动对应WorkID
	public HashMap<Integer, Date> dicActivitys;
}

package cn.zup.workflow.dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import cn.zup.workflow.util.RefObject;
import cn.zup.workflow.util.StringHelper;

@Repository("activityDal")
public class WF_ACTIVITY extends WF_ActivityBase{
	
	@Autowired
	private JdbcTemplate jdbcTemplate_workflow;
	

	public WF_ACTIVITY(){}

	/** 
	 获取下一活动编号
	 
	 @param flowID 流程ID
	 @param activityCode 当前活动编号
	 @return 
	 * @throws SQLException 
	*/
	public String NextActivityCode(int flowID, int activityCode) throws SQLException{
		StringBuilder strSql = new StringBuilder();
		strSql.append("select NEXT_ACTIVITY_CODE FROM WF_ACTIVITY ");
		strSql.append(MessageFormat.format(" where  FLOW_ID={0} and ACTIVITY_CODE={1} ", flowID+"",activityCode+""));		
		String str = jdbcTemplate_workflow.query(strSql.toString(), new ResultSetExtractor<String>(){
			String value;
			@Override
			public String extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				 if(rs.next()) {  
					 value=rs.getString("NEXT_ACTIVITY_CODE");  
				 }
				return  value;   
			}
		});
			
		if(str != null)
			return str;	    				 
		else 
			return "";   
	}


	/** 
	 删除活动(事务)
	 
	 @param activityID 活动ID
	 * @throws SQLException 
	*/
	public  void ActivityDel(int activityID) throws SQLException{
		WF_LINE lineDal = new WF_LINE();
		cn.zup.workflow.model.WF_ACTIVITY activityModel =   GetModel(activityID);
		int flowID = activityModel.getFLOW_ID();
		int activityCode = activityModel.getACTIVITY_CODE();
		 Delete(activityID);
		NextActCodeReplace(activityCode, flowID);
		lineDal.Delete(flowID, activityCode); //删除连线关系        原DeleteTran
	}
	/** 
	 将下一节点活动序号字段中删除的活动去掉
	 
	 @param flowID 流程ID
	 @param activityCode 当前活动序号
	 @param dbTran 数据连接实例
	 @param transaction 事务
	 * @throws SQLException 
	*/
	private void NextActCodeReplace(int activityCode, int flowID) throws SQLException{
		//1-查询出当前流程的所有下一活动序号内容
		java.util.List<cn.zup.workflow.model.WF_ACTIVITY> activityList =  GetListArrayTran("FLOW_ID=" + String.valueOf(flowID));
		//2-筛选出下一活动中含有删除活动的节点
		java.util.List<cn.zup.workflow.model.WF_ACTIVITY> activityListDelNext=new ArrayList<cn.zup.workflow.model.WF_ACTIVITY>();
		for(cn.zup.workflow.model.WF_ACTIVITY item : activityList)
    	{
    		String nextActCode=item.getNEXT_ACTIVITY_CODE();                		
    		for(String codeItem :nextActCode.split(","))
    		{
    			if(codeItem.equals(activityCode)) 
    			{
    				activityListDelNext.add(item);
    				break;
    			}
    		}                		
    	}

		//3-将删除的活动字符从下一活动序号中排除掉
		String newNextActivityCode = "";
		for (cn.zup.workflow.model.WF_ACTIVITY model : activityListDelNext)
		{
			String codeArry[] = model.getNEXT_ACTIVITY_CODE().split(",");
			if(contains(codeArry,String.valueOf(activityCode)))//如果该活动中的下一活动序号包含删除的活动序号，进行排除            			
			{
				//生成新的下一活动序号
				for (String code : codeArry)
				{
					if(code.equals(activityCode)) //如果是删除的活动序号，则排除掉            					
					{            						
						continue;
					}
					newNextActivityCode += code + ",";
				}
				if (newNextActivityCode.length() > 0) //去掉"，"
				{
					newNextActivityCode = newNextActivityCode.substring(0, newNextActivityCode.length() - 1);
				}
				model.setNEXT_ACTIVITY_CODE(newNextActivityCode); //新的下一活动序号赋值
				 Update(model);
			}
		}
	
	}
	/*
	 * 判断数组是否包含某个元素
	 * */
	boolean contains(String array[],String str)
	{
		for(String codeItem :array)
		{
			if(codeItem.equals(str)) 
			{
				return true;
			}
		} 
		return false;            		
	}
	
	/** 
	 获取流程开始节点活动信息
	 
	 @param flowID 流程
	 @return 
	 * @throws SQLException 
	*/
	public  cn.zup.workflow.model.WF_ACTIVITY FirstActivityInfo(int flowID) throws SQLException
	{
		StringBuilder strSql = new StringBuilder();
		strSql.append(" FLOW_ID="+flowID+" and ACTIVITY_TYPE=" +  cn.zup.workflow.config.ActivityType.IntialStage.getValue());
		List<cn.zup.workflow.model.WF_ACTIVITY> list= GetListArray(strSql.toString());
		if(list.size()>0)
			return list.get(0);
		else 
			throw new SQLException("FirstActivityInfo执行时，流程"+flowID+"第一个活动为空，请检查流程");		
	}
	
	/** 
	 根据流程和编号得到一个对象实体
	 
	 @param flowID 流程ID
	 @param activityCode 活动编号
	 @return 
	 * @throws SQLException 
	*/
	public  cn.zup.workflow.model.WF_ACTIVITY GetModel(int flowID, int activityCode) throws SQLException
	{
		StringBuilder strSql = new StringBuilder();
		strSql.append(" FLOW_ID="+flowID+" and ACTIVITY_CODE=" + activityCode);		
		List<cn.zup.workflow.model.WF_ACTIVITY> list= GetListArray(strSql.toString());
		if(list.size()>0)
			return list.get(0);
		else return null;
	}


	public  java.util.List<cn.zup.workflow.model.WF_ACTIVITY> GetListArray(int flowID, String activityCodes) throws SQLException
	{
		StringBuilder strSql = new StringBuilder();
		strSql.append(" FLOW_ID = "+flowID);
		strSql.append(" and ACTIVITY_CODE in (" + activityCodes + ")");
		List<cn.zup.workflow.model.WF_ACTIVITY> list= GetListArray(strSql.toString());
		return list;
		
	}
	
	/** 
	 获取需要强制结束节点的信息
	 
	 @param workID 工作ID
	 @param activityID 需要获取的活动ID
	 @param activityType 需要获取的活动类型
	 @param workActivityID 需要获取的工作活动ID
	 * @throws SQLException 
	*/
	public void TerminateActivityInfo(int workID, RefObject<Integer> activityID, RefObject<Integer> activityType, RefObject<Integer> workActivityID) throws SQLException
	{

		StringBuilder strSql = new StringBuilder();
		strSql.append("SELECT  B.ACTIVITY_ID,C.ACTIVITY_TYPE,B.WORK_ACTIVITY_ID FROM ");
		strSql.append(" WF_WORK A,WF_WORK_ACTIVITY B,WF_ACTIVITY C WHERE  ");
		strSql.append(" A.WORK_ID=B.WORK_ID AND B.ACTIVITY_ID=C.ACTIVITY_ID AND B.WORK_ACTIVITY_STATE="+
				cn.zup.workflow.config.WorkActivityState.InProgress.getValue());
		strSql.append(" AND A.WORK_ID="+workID);
		
		List<Integer> list = jdbcTemplate_workflow.query(strSql.toString(), new ResultSetExtractor<List<Integer>>(){

			@Override
			public List<Integer> extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				List<Integer> list = new ArrayList<Integer>();
				if (rs.next()){
					list.add(Integer.parseInt(rs.getString("ACTIVITY_ID")));
					list.add(Integer.parseInt(rs.getString("ACTIVITY_TYPE")));
					list.add(Integer.parseInt(rs.getString("WORK_ACTIVITY_ID")));
				}
				return list;
			}
		});
		
		activityID.argvalue = list.get(0);
		activityType.argvalue = list.get(1);
		workActivityID.argvalue = list.get(2);
		
//		PreparedStatement ps = getConnection().prepareStatement(strSql.toString());
//		ps.clearParameters();
//		ps.setInt(1,cn.zup.workflow.config.WorkActivityState.InProgress.getValue() );
//		ps.setInt(2,workID);
//		ResultSet rs = ps.executeQuery();
//			if (rs.next())
//			{
//				activityID.argvalue = Integer.parseInt(rs.getString("ACTIVITY_ID"));
//				activityType.argvalue = Integer.parseInt(rs.getString("ACTIVITY_TYPE"));
//				workActivityID.argvalue = Integer.parseInt(rs.getString("WORK_ACTIVITY_ID"));
//			
//			}
		
	}

	/** 
	 获取需要驳回到的节点（需要激活的节点）
	 
	 @param activityID 活动ID
	 @param workID 工作ID
	 @return 
	 * @throws SQLException 
	*/
	public  java.util.List<cn.zup.workflow.model.WF_ACTIVITY> RejectTargetList(int activityID, int workID) throws SQLException
	{
		WF_WORK_ACTIVITY workActivityDal = new WF_WORK_ACTIVITY();
		//获取配置性需要驳回的节点
		java.util.ArrayList<cn.zup.workflow.model.WF_ACTIVITY> rejectList = new java.util.ArrayList<cn.zup.workflow.model.WF_ACTIVITY>();
		cn.zup.workflow.model.WF_ACTIVITY activityModel =  GetModel(activityID);
		//int rejectCode = activityModel.REJECT_ACTIVITY_CODE;
		int rejectCode = activityModel.getREJECT_ACTIVITY_CODE();
		if (rejectCode != 0) //如果设置了目标驳回节点,则获取驳回节点对应的活动实体并添加
		{
			//rejectList.add(GetModel(activityModel.FLOW_ID, rejectCode));
			rejectList.add(GetModel(activityModel.getFLOW_ID(),rejectCode));
		}
		else //如果没有设置就直接获取上一节点
		{
			java.util.List<cn.zup.workflow.model.WF_ACTIVITY> activityList = GetListArray("FLOW_ID=" + activityModel.getFLOW_ID()+" AND CONCAT(',',NEXT_ACTIVITY_CODE,',') like '%," + activityModel.getACTIVITY_CODE()+",%'");
			for (cn.zup.workflow.model.WF_ACTIVITY activity : activityList) {
				rejectList.add(activity);
			}
		}

		//获取实际工作中需要驳回到的节点
		java.util.List<cn.zup.workflow.model.WF_ACTIVITY> realRejectList = new ArrayList<cn.zup.workflow.model.WF_ACTIVITY>();
		cn.zup.workflow.model.WF_WORK_ACTIVITY workActivity;
//C# TO JAVA CONVERTER TODO TASK: There is no equivalent to implicit typing in Java:
		for (cn.zup.workflow.model.WF_ACTIVITY item : rejectList)
		{
			/**workActivity = workActivityDal.GetModel(workID, reject.ACTIVITY_ID);
			if (workActivity != null && workActivity.NEXT_ACTIVITY_CODES.split("[,]", -1).Contains(activityModel.ACTIVITY_CODE.toString()))
			{
				realRejectList.add(reject);
			}**/
			String nextActCode=item.getNEXT_ACTIVITY_CODE();                		
    		for(String codeItem :nextActCode.split(","))
    		{
    			if(codeItem.equals(String.valueOf(activityModel.getACTIVITY_CODE()))) 
    			{
    				realRejectList.add(item);
    				break;
    			}
    		}    
		}

		return realRejectList;
	}

	 /** 
	获取驳回目标节点的活动ID及后续活动ID
	
	@param flowID 流程ID
	@param activityCode 活动序号
	@return 
	 * @throws SQLException 
	 */
   public  String RejectActivityID(int flowID, java.util.List<cn.zup.workflow.model.WF_ACTIVITY> rejectTargetList) throws SQLException
   {
	   //1-获取所有驳回节点编号
	   java.util.ArrayList<String> nextActivityCodeList = new java.util.ArrayList<String>();
	   String nextActivityCodes = "";
//C# TO JAVA CONVERTER TODO TASK: There is no equivalent to implicit typing in Java:
	   for (cn.zup.workflow.model.WF_ACTIVITY model : rejectTargetList)
	   {
		   /**RejectList(flowID, (int)model.ACTIVITY_CODE, nextActivityCodeList);
		   for (String cur : nextActivityCodeList)
		   {
			   nextActivityCodes += "," + cur;
		   }**/
		   RejectList(flowID, model.getACTIVITY_CODE(), nextActivityCodeList);
 		   for (String cur : nextActivityCodeList)
 		   {
 			   nextActivityCodes += "," + cur;
 		   }
	   }
	   nextActivityCodes = nextActivityCodes.substring(1);
	   //2-获取所有需要驳回的活动ID
	  // java.util.ArrayList<cn.zoneday.wf.model.WF_ACTIVITY> nextActivityList = GetListArray("FlOW_ID=" + flowID + "AND ACTIVITY_CODE IN (" + nextActivityCodes + ")");
	   java.util.ArrayList<cn.zup.workflow.model.WF_ACTIVITY> nextActivityList = (ArrayList<cn.zup.workflow.model.WF_ACTIVITY>)  GetListArray("FlOW_ID=" + flowID + " AND ACTIVITY_CODE IN (" + nextActivityCodes + ")");
	   String nextActivities = "";
//C# TO JAVA CONVERTER TODO TASK: There is no equivalent to implicit typing in Java:
	   for (cn.zup.workflow.model.WF_ACTIVITY model : nextActivityList)
	   {
		   nextActivities += "," + model.getACTIVITY_ID();
	   }

	   return nextActivities.substring(1); //去掉开始的逗号
   }

   /** 
	获取某一活动编号后的所有活动编号
	
	@param flowID
	@param activityCode
	@param activityCodeList
 * @throws SQLException 
   */
   private void RejectList(int flowID, int activityCode, java.util.ArrayList<String> activityCodeList) throws SQLException
   {
	   activityCodeList.add((new Integer(activityCode)).toString());
	   String codes = NextActivityCode(flowID, activityCode); //获取下一活动编号
	   String[] codeArray = codes.split("[,]", -1);
	   for (String cur : codeArray)
	   {
		   if (StringHelper.isNullOrEmpty(cur))
		   {
			   break;
		   }
		   RejectList(flowID, Integer.parseInt(cur), activityCodeList);
	   }
   }

		///#endregion



}

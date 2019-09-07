package cn.zup.junit;

import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

import org.junit.Test;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import cn.zup.framework.aop.utils.ScanEntityField;
import cn.zup.rbac.entity.MenuRoleEx;
import net.sf.json.JSONObject;

public class Teast {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
//		java.sql.Timestamp t = new java.sql.Timestamp(System.currentTimeMillis());
//		String s =t.toString();
//		s = s.substring(0,s.indexOf('.'));
//		System.out.println(s);
//		java.sql.Date d =new java.sql.Date(System.currentTimeMillis());
//		
//		System.out.println(d);
		
		 String url = "jdbc:oracle:thin:@192.168.10.252:1521:orcl";
	        String user = "workflow";
	        String password = "workflow";
	         
	        Connection conn = null;
	        Statement st = null;
	         
	        try{
	            //注册驱动(数据库的类型)
	            Class.forName("oracle.jdbc.driver.OracleDriver");
	     
	            //获取连接
	            conn = DriverManager.getConnection(url, user, password);
	             
	            //得到运行环境
	            st = conn.createStatement();
	     
	            //执行SQL
	            java.sql.Timestamp t = new java.sql.Timestamp(System.currentTimeMillis());
	    		String datetime = t.toString();
	    		datetime = datetime.substring(0,datetime.indexOf('.'));
	    		
//	            String sql = "insert into demo(aa) values(to_date('"+datetime+"','YYYY-MM-DD HH24:MI:SS'))";
//	            System.out.println("sql="+sql);
//	            int result = st.executeUpdate(sql);
	    		
	    		StringBuffer strSql = new StringBuffer();
	    		strSql.append("insert into WF_WORK(");
	    		int incID=998;
	    		strSql.append("WORK_ID,FLOW_ID,WORK_NAME,WORK_STATE,SPONSOR_ID,SPONSOR_NAME,CREATE_DATETIME,MAIN_BIZ_KEY,PARENT_WORK_ID,PARENT_ACTIVITY_ID)");

	    		strSql.append(" values (");
	    		strSql.append("?,?,?,?,?,?,to_date('"+datetime+"','YYYY-MM-DD HH24:MI:SS'),?,?,?)");
	    		//strSql.append("?,?,?,?,?,?,?,?,?,?)");
	    		PreparedStatement ps =conn.prepareStatement(strSql.toString());
	    		ps.clearParameters();
	    		ps.setInt(1,incID);
	    		ps.setInt(2,1);
	    		ps.setString(3,"aa");
	    		ps.setInt(4,1);
	    		ps.setInt(5,1);
	    		ps.setString(6,"aa");
	    		//ps.setTimestamp(7, t);
	    		ps.setString(7,"aa");
	    		ps.setInt(8,1);
	    		ps.setInt(9,1);

	    		int result =ps.executeUpdate();
	     
	            //处理结果
	            if(result>0){
	                System.out.println("操作成功");
	            }else{
	                System.out.println("操作失败");
	            }
	        }catch(Exception ex){
	            ex.printStackTrace();
	        }finally{
	            //释放资源
	            if(st != null){
	                try {
	                    st.close();
	                } catch (SQLException e) {
	                    e.printStackTrace();
	                }finally{
	                    st = null;//--> 让他迅速成为java gc的对象
	                }
	            }
	            if(conn != null){
	                try {
	                    conn.close();
	                } catch (SQLException e) {
	                    e.printStackTrace();
	                }finally{
	                    conn = null;//--> 让他迅速成为java gc的对象
	                }
	            }
	        }

	}
	
	@Test
	public void getFK(){
		MenuRoleEx ui = new MenuRoleEx();
		ui.setFormAddress("你好");
		System.err.println(ScanEntityField.getFieldValue(ui));
	}

}

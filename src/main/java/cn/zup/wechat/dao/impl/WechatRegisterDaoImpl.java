package cn.zup.wechat.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import cn.zup.rbac.entity.Account;
import cn.zup.wechat.dao.WechatRegisterDao;
import cn.zup.wechat.entity.WechatRegister;

@Repository
public class WechatRegisterDaoImpl implements WechatRegisterDao {
	@Autowired
	private JdbcTemplate jdbcTemplate_wechat;
	
	private static Logger logger = Logger.getLogger(WechatRegisterDaoImpl.class);

	/*
	 * 添加数据
	 * @see cn.zup.wechat.dao.WechatRegisterDao#addRegister(cn.zup.wechat.entity.WechatRegister)
	 */
	@Override
	public void addRegister(WechatRegister wr) {
		StringBuffer sbSql = new StringBuffer();
		sbSql.append("INSERT INTO wechat_register (COMPANY_ID,REGISTER_NAME,REGISTER_PWD,WX_ACCOUNT,BIND_DATE)");
		sbSql.append(" VALUE(?,?,?,?,?)");
		Object[] args = {wr.getSystemId(),wr.getRegisterName(),wr.getRegisterPwd(),wr.getWxAccount(),wr.getBindDate()};
		jdbcTemplate_wechat.update(sbSql.toString(),args);
		
	}
	/*
	 * 删除一条数据
	 * @see cn.zup.wechat.dao.WechatRegisterDao#delRegister(cn.zup.wechat.entity.WechatRegister)
	 */
	@Override
	public Integer delRegister(WechatRegister wr) {
		int i ;
		StringBuffer sbSql = new StringBuffer();
		sbSql.append("DELETE FROM wechat_register WHERE REGISTER_ID=?");
		Object[] args = {wr.getRegisterId()};
		try {
			jdbcTemplate_wechat.update(sbSql.toString(),args);
			i=1;
		} catch (Exception e) {
			System.err.println(e.getMessage());
			i=0;
		}
		return i;
		
	}
	/*
	 * 更新数据
	 * @see cn.zup.wechat.dao.WechatRegisterDao#getUserInfoList(cn.zup.wechat.entity.WechatRegister)
	 */
	public Integer updateRegister(WechatRegister wr){
		int i;
		StringBuffer sbSql = new StringBuffer();
		List<Object> args = new ArrayList<Object>();
		sbSql.append("UPDATE wechat_register");
		if(wr.getSystemId() != null){
			sbSql.append(" SET COMPANY_ID= ?");
			args.add(wr.getSystemId());
		}
		if(wr.getRegisterName() != null){
			sbSql.append(",REGISTER_NAME=?");
			args.add(wr.getRegisterName());
		}
		if(wr.getRegisterPwd() != null){
			sbSql.append(",REGISTER_PWD=?");
			args.add(wr.getRegisterPwd());
		}
		if(wr.getWxAccount() != null){
			sbSql.append(",WX_ACCOUNT=?");
			args.add(wr.getWxAccount());
		}
		if(wr.getBindDate() != null){
			sbSql.append(",BIND_DATE=?");
			args.add(wr.getBindDate());
		}
		sbSql.append(" WHERE REGISTER_ID=?");
		args.add(wr.getRegisterId());
		try {
			jdbcTemplate_wechat.update(sbSql.toString(),args.toArray());
			i=1;
		} catch (Exception e) {
			System.err.println(e.getMessage());
			i=0;
		}
		return i;
	}


	@Override
	public List<WechatRegister> getUserInfoList(WechatRegister wechatRegister) {
		StringBuffer sbSql = new StringBuffer();
		sbSql.append("select  REGISTER_ID, wr.COMPANY_ID , REGISTER_NAME, REGISTER_PWD, ");
		sbSql.append("WX_ACCOUNT, BIND_DATE from  wechat_register wr ");
		sbSql.append(" join wechat_system s on wr.company_id = s.company_id where 1=1 ");
		if(wechatRegister.getRegisterId() != null)
			sbSql.append(" and register_id = " + wechatRegister.getRegisterId());
		if(wechatRegister.getSystemId() != null)
			sbSql.append(" and system_id = " + wechatRegister.getSystemId());
		if(wechatRegister.getRegisterName() != null)
			sbSql.append(" and register_name = '"+wechatRegister.getRegisterName()+"'");
		if(wechatRegister.getRegisterPwd() != null)
			sbSql.append(" and register_pwd = '"+ wechatRegister.getRegisterPwd() +"'");
		if(wechatRegister.getWxAccount() != null)
			sbSql.append(" and wx_account = '"+wechatRegister.getWxAccount()+"'");
		
		logger.info("getUserInfoList===>"+ sbSql.toString());
		List<WechatRegister> result = jdbcTemplate_wechat.query(sbSql.toString(), (rs) -> {
			List<WechatRegister> list = new ArrayList<WechatRegister>();
			while(rs.next()){
				list.add(bindData(rs));
			}
			return list;
		});
		return result;
	}

	@Override
	public WechatRegister getWechatRegister(WechatRegister wechatRegister) {
		StringBuffer sbSql = new StringBuffer();
		sbSql.append("select * from  wechat_register where 1=1 ");
		if(wechatRegister.getRegisterId() != null)
			sbSql.append(" and register_id = " + wechatRegister.getRegisterId());
		if(wechatRegister.getSystemId() != null)
			sbSql.append(" and company_id = " + wechatRegister.getSystemId());
		if(wechatRegister.getRegisterName() != null)
			sbSql.append(" and register_name = '"+wechatRegister.getRegisterName()+"'");
		if(wechatRegister.getRegisterPwd() != null)
			sbSql.append(" and register_pwd = '"+ wechatRegister.getRegisterPwd() +"'");
		if(wechatRegister.getWxAccount() != null)
			sbSql.append(" and wx_account = '"+wechatRegister.getWxAccount()+"'");
		
		logger.info("getWechatRegister===>"+ sbSql.toString());
		WechatRegister result = jdbcTemplate_wechat.query(sbSql.toString(), (rs) -> {
			WechatRegister wr = new WechatRegister();
			while(rs.next()){
				wr = bindData(rs);
			}
			return wr;
		});
		return result;
	}

	@Override
	public MiniDaoPage<WechatRegister> getWechatRegisterList(WechatRegister wr,
			int rows, int page) {
		StringBuffer sbSql = new StringBuffer();
		sbSql.append("select  w.register_id, w.register_name, w.bind_date, ws.COMPANY_NAME REGISTER_PWD,");
		sbSql.append("u.realname wx_account,ws.system_id as COMPANY_ID from  wechat_register w ");
		sbSql.append("join  WECHAT_SYSTEM ws on w.company_id = ws.company_id ");
		sbSql.append("join system s  on ws.system_id  = s.systemid ");
		sbSql.append("join account a on w.register_name = a.accountname ");
		sbSql.append("join userinfo u on a.userid = u.userid where 1=1 ");
 
		if( wr.getSystemId() != null)
			sbSql.append(" and ws.company_id = "+wr.getSystemId());
		if( wr.getRegisterName() != null)
			sbSql.append(" and register_name like '%"+wr.getRegisterName()+"%'");
		if( wr.getWxAccount() != null)
			sbSql.append(" and wx_account = '"+wr.getWxAccount()+"'");
		if( wr.getRegisterPwd() != null){
			sbSql.append(" and w.bind_date <= date_format('"+wr.getRegisterPwd()+" 23:59:59', '%Y-%c-%d %H:%i:%s')");
			sbSql.append(" and w.bind_date >= date_format('"+wr.getRegisterPwd()+" 00:00:00', '%Y-%c-%d %H:%i:%s')");
		}
		
		Integer total = jdbcTemplate_wechat.query(sbSql.toString(), (rs) -> {
			int totalAmount = 0;
			while(rs.next()){			
				totalAmount++;
			}	
			return totalAmount;
		});
		
		String sql = "SELECT *  FROM ( " +  sbSql +" ) table_alias LIMIT "+ ((page-1)*rows) +" , "+ rows;

		logger.info("getWechatRegisterList===>"+ sql);
		List<WechatRegister> result = jdbcTemplate_wechat.query(sql, (rs) -> {
			List<WechatRegister> list = new ArrayList<WechatRegister>();
			while(rs.next()){
				list.add(bindData(rs));
			}
			return list;
		});
		MiniDaoPage<WechatRegister> minipage = new MiniDaoPage<WechatRegister>();
		minipage.setPage(page);
		minipage.setResults(result);
		minipage.setRows(rows);
		minipage.setTotal(total);
		return minipage;
	}
	
	
	/**
	 * 数据绑定
	 * 
	 * */
	final private WechatRegister bindData(ResultSet rs) throws SQLException{
		WechatRegister wr = new WechatRegister();
		wr.setRegisterId(rs.getInt("REGISTER_ID"));
		wr.setSystemId(rs.getInt("COMPANY_ID"));
		wr.setRegisterName(rs.getString("REGISTER_NAME"));
		wr.setRegisterPwd(rs.getString("REGISTER_PWD"));
		wr.setWxAccount(rs.getString("WX_ACCOUNT"));
		wr.setBindDate(rs.getTimestamp("BIND_DATE"));
		return wr;
	}

	@Override
	public List<Account> getAccountInfoByUserId(Integer userId) {
		StringBuffer sbSql = new StringBuffer();
		sbSql.append("select accountid,userid,accountname,password from Account where 1=1 ");
		if(userId != null){
			sbSql.append("and userid = "+userId);
		}
		
		logger.info("getAccountInfoByUserId===>"+ sbSql.toString());
		List<Account> result = jdbcTemplate_wechat.query(sbSql.toString(), (rs) -> {
			List<Account> list = new ArrayList<Account>();
			while(rs.next()){
				Account ac = new Account();
				ac.setAccountId(rs.getInt("accountid"));
				ac.setUserId(rs.getInt("userid"));
				ac.setAccountName(rs.getString("accountname"));
				ac.setPassWord(rs.getString("password"));
				list.add(ac);
			}
			return list;
		});
		
		return result;
	}
	
	
}

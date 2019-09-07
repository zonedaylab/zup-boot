package cn.zup.wechat.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import cn.zup.wechat.dao.ReferrerDao;
import cn.zup.wechat.entity.ReferrerEntity;

@Repository
public class ReferrerDaoImpl implements ReferrerDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate_wechat;
	
	private static Logger logger = Logger.getLogger(ReferrerDaoImpl.class);

	@Override
	public boolean addRefrrer(ReferrerEntity entity) {
		StringBuffer sbSql = new StringBuffer();
		sbSql.append("INSERT INTO wechat_referrer (REFERRAL_OPENID,REFERRAL_QRCODE,REFERRER_OPENID,REFERRER_TIME)");
		sbSql.append(" VALUE(?,?,?,?)");
		Object[] args = {
				entity.getReferral_Openid(),
				entity.getReferral_QRCode(),
				entity.getReferrer_Openid(),
				entity.getReferrer_Time()
		};
		try {
			jdbcTemplate_wechat.update(sbSql.toString(), args);
			return true;
		} catch (Exception e) {
			logger.error("保存数据出现错误，具体原因："+e.getMessage());
			return false;
		}
	}

	@Override
	public boolean updateRefrrer(ReferrerEntity entity) {
		StringBuffer sbSql = new StringBuffer();
		List<Object> args = new ArrayList<Object>();
		sbSql.append("UPDATE wechat_referrer");
		sbSql.append(" SET REFERRAL_OPENID= ?");
		args.add(entity.getReferral_Openid());
		if(entity.getReferral_QRCode() != null){
			sbSql.append(" ,REFERRAL_QRCODE=?");
			args.add(entity.getReferral_QRCode());
		}
		if(entity.getReferrer_Openid() != null){
			sbSql.append(" ,REFERRER_OPENID=?");
			args.add(entity.getReferrer_Openid());
		}
		if(entity.getReferrer_Time() != null){
			sbSql.append(" ,REFERRER_TIME=?");
			args.add(entity.getReferrer_Time());
		}
		sbSql.append(" WHERE REFERRER_ID=?");
		args.add(entity.getReferrer_Id());
		try {
			jdbcTemplate_wechat.update(sbSql.toString(), args);
			return true;
		} catch (Exception e) {
			logger.error("更新数据出现错误，具体原因："+e.getMessage());
			return false;
		}
	}

	@Override
	public boolean deleteRefrrer(ReferrerEntity entity) {
		String str = "";
		if(entity.getReferrer_Id() != null) {
			str = " DELETE FROM wechat_referrer WHERE REFERRER_ID= "+entity.getReferrer_Id();
		}
		if(entity.getReferral_Openid() != null) {
			str = " DELETE FROM wechat_referrer WHERE REFERRAL_Openid= '"+entity.getReferral_Openid()+"'";
		}
		try {
			System.err.println(str);
			jdbcTemplate_wechat.update(str);
			return true;
		} catch (Exception e) {
			logger.error("删除数据出现错误，具体原因："+e.getMessage());
			return false;
		}
	}

	@Override
	public ReferrerEntity getRefrrer(ReferrerEntity entity) {
		StringBuffer sbSql = new StringBuffer();
		sbSql.append("SELECT " + 
				" wr.REFERRAL_OPENID, wr.REFERRAL_QRCODE, wr.REFERRER_ID, wr.REFERRER_OPENID, wr.REFERRER_TIME, wr.REFERRER_WELANG, wrg.REGISTER_NAME AS REFERRER_NAME  " + 
				" FROM wechat_referrer wr " + 
				" LEFT JOIN wechat_register wrg ON wrg.WX_ACCOUNT = wr.REFERRAL_OPENID " + 
				" WHERE 1=1 ");

		if(entity.getReferral_Openid() != null)
			sbSql.append("AND wr.REFERRAL_OPENID = '"+entity.getReferral_Openid()+"' "); 
		if(entity.getReferrer_Openid() != null)
			sbSql.append("AND wr.REFERRER_OPENID = '"+entity.getReferrer_Openid()+"' "); 
		if(entity.getReferrer_TimeStart() != null)
			sbSql.append("AND wr.REFERRER_TIME >= DATE_FORMAT('"+entity.getReferrer_TimeStart()+" 23:59:59', '%Y-%m-%d %H:%i:%s') "); 
		if(entity.getReferrer_TimeStart() != null)
			sbSql.append("AND wr.REFERRER_TIME <= DATE_FORMAT('"+entity.getReferrer_TimeEnd()+" 23:59:59', '%Y-%m-%d %H:%i:%s') ");

		ReferrerEntity result = jdbcTemplate_wechat.query(sbSql.toString(), (rs) -> {
			ReferrerEntity wr = new ReferrerEntity();
			while(rs.next()){
				wr = bindData(rs);
			}
			return wr;
		});
		return result;
	}

	@Override
	public List<ReferrerEntity> getRefrrerList(ReferrerEntity entity) {
		StringBuffer sbSql = new StringBuffer();
		sbSql.append("SELECT " + 
				" wr.REFERRAL_OPENID, wr.REFERRAL_QRCODE, wr.REFERRER_ID, wr.REFERRER_OPENID, wr.REFERRER_TIME, wr.REFERRER_WELANG, wrg.REGISTER_NAME AS REFERRER_NAME " + 
				" FROM wechat_referrer wr " + 
				" LEFT JOIN wechat_register wrg ON wrg.WX_ACCOUNT = wr.REFERRAL_OPENID " + 
				" WHERE 1=1 ");

		if(entity.getReferral_Openid() != null)
			sbSql.append("AND wr.REFERRAL_OPENID = '"+entity.getReferral_Openid()+"' "); 
		if(entity.getReferrer_Openid() != null)
			sbSql.append("AND wr.REFERRER_OPENID = '"+entity.getReferrer_Openid()+"' "); 
		if(entity.getReferrer_TimeStart() != null)
			sbSql.append("AND wr.REFERRER_TIME >= DATE_FORMAT('"+entity.getReferrer_TimeStart()+" 23:59:59', '%Y-%m-%d %H:%i:%s') "); 
		if(entity.getReferrer_TimeStart() != null)
			sbSql.append("AND wr.REFERRER_TIME <= DATE_FORMAT('"+entity.getReferrer_TimeEnd()+" 23:59:59', '%Y-%m-%d %H:%i:%s') ");

		List<ReferrerEntity> result = jdbcTemplate_wechat.query(sbSql.toString(), (rs) -> {
			List<ReferrerEntity> list = new ArrayList<ReferrerEntity>();
			while(rs.next()){
				ReferrerEntity wr = new ReferrerEntity();
				wr = bindData(rs);
				list.add(wr);
			}
			return list;
		});
		return result;
	}

	private ReferrerEntity bindData(ResultSet rs) throws SQLException{
		ReferrerEntity entity = new ReferrerEntity();
		entity.setReferrer_Welong(rs.getString("REFERRER_WELANG"));
		entity.setReferral_Openid(rs.getString("REFERRAL_OPENID"));
		entity.setReferral_QRCode(rs.getString("REFERRAL_QRCODE"));
		entity.setReferrer_Id(rs.getInt("REFERRER_ID"));
		entity.setReferrer_Openid(rs.getString("REFERRER_OPENID"));
		entity.setReferrer_Time(rs.getTimestamp("REFERRER_TIME"));
		entity.setReferralName(rs.getString("REFERRER_NAME"));
		return entity;
	}
}

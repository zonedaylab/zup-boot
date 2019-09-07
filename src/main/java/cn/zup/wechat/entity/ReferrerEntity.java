package cn.zup.wechat.entity;

import java.util.Date;

/**
 * 推荐人关系表实体类
 * 
 * */
public class ReferrerEntity {
	private Integer referrer_Id; //主键id
	private String referrer_Openid;  //推荐人openid
	private String referral_Openid;  //被推荐人openid
	private Date referrer_Time = new Date(); //创建时间
	private String referral_QRCode;  //被推荐人二维码地址
	private String referrer_Welong;  //推荐人欢迎语
	
	private String referrer_TimeStr; //创建时间字符串
	private String referrerName;  //推荐人姓名
	private String referralName;  //被推荐人姓名
	private Date referrer_TimeStart; //创建时间字符串
	private Date referrer_TimeEnd; //创建时间字符串
	public Integer getReferrer_Id() {
		return referrer_Id;
	}
	public void setReferrer_Id(Integer referrer_Id) {
		this.referrer_Id = referrer_Id;
	}
	public String getReferrer_Openid() {
		return referrer_Openid;
	}
	public void setReferrer_Openid(String referrer_Openid) {
		this.referrer_Openid = referrer_Openid;
	}
	public String getReferral_Openid() {
		return referral_Openid;
	}
	public void setReferral_Openid(String referral_Openid) {
		this.referral_Openid = referral_Openid;
	}
	public Date getReferrer_Time() {
		return referrer_Time;
	}
	public void setReferrer_Time(Date referrer_Time) {
		this.referrer_Time = referrer_Time;
	}
	public String getReferral_QRCode() {
		return referral_QRCode;
	}
	public void setReferral_QRCode(String referral_QRCode) {
		this.referral_QRCode = referral_QRCode;
	}
	public String getReferrer_TimeStr() {
		return referrer_TimeStr;
	}
	public void setReferrer_TimeStr(String referrer_TimeStr) {
		this.referrer_TimeStr = referrer_TimeStr;
	}
	public String getReferrerName() {
		return referrerName;
	}
	public void setReferrerName(String referrerName) {
		this.referrerName = referrerName;
	}
	public String getReferralName() {
		return referralName;
	}
	public void setReferralName(String referralName) {
		this.referralName = referralName;
	}
	public Date getReferrer_TimeStart() {
		return referrer_TimeStart;
	}
	public void setReferrer_TimeStart(Date referrer_TimeStart) {
		this.referrer_TimeStart = referrer_TimeStart;
	}
	public Date getReferrer_TimeEnd() {
		return referrer_TimeEnd;
	}
	public void setReferrer_TimeEnd(Date referrer_TimeEnd) {
		this.referrer_TimeEnd = referrer_TimeEnd;
	}
	public String getReferrer_Welong() {
		return referrer_Welong;
	}
	public void setReferrer_Welong(String referrer_Welong) {
		this.referrer_Welong = referrer_Welong;
	}
	
}

package cn.zup.rbac.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "ENERGY_MERCHANT_LINKMAN")
public class EnergyMerchantLinkman implements Serializable {
	private Integer    link_Man_Id; //联系人ID
	private Integer    organid;  //部门ID
	private String     linkman_Name; //联系人名称
	private String     mobile_Phone; //手机号码
	private String     phone; //联系电话
	private String     email; //邮箱
	private String     address; //地址
	private String     fax;//传真
	private String     post;  //职务
	private String     wechat_Num;  //微信号
	private String     memo;//备注
	//冗余字段
	private Integer    num;  //序号

	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getLink_Man_Id() {
		return link_Man_Id;
	}
	public void setLink_Man_Id(Integer linkManId) {
		link_Man_Id = linkManId;
	}
	public Integer getOrganid() {
		return organid;
	}
	public void setOrganid(Integer organid) {
		this.organid = organid;
	}
	public String getLinkman_Name() {
		return linkman_Name;
	}
	public void setLinkman_Name(String linkmanName) {
		linkman_Name = linkmanName;
	}
	public String getMobile_Phone() {
		return mobile_Phone;
	}
	public void setMobile_Phone(String mobilePhone) {
		mobile_Phone = mobilePhone;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getPost() {
		return post;
	}
	public void setPost(String post) {
		this.post = post;
	}
	public String getWechat_Num() {
		return wechat_Num;
	}
	public void setWechat_Num(String wechatNum) {
		wechat_Num = wechatNum;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	@Transient
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
}

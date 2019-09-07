package cn.zup.rbac.entity;

import java.io.Serializable;
import java.util.Date;
//即时通讯
public class Message implements Serializable {
	public Message() {
	}

	private Integer id;//主键
	private Integer accountid;///账户ID
	private String categorycode;//分类编号
	private String objectid;//唯一识别主键
	private String receiverid;//接收者主键
	private String contents;//内容
	private Integer isnew = 1;//是否新信息
	private String description;//描述
	private Integer enabled = 1;//有效
	private Date createon = new Date();//创建日期
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getAccountid() {
		return accountid;
	}
	public void setAccountid(Integer accountid) {
		this.accountid = accountid;
	}
	public String getCategorycode() {
		return categorycode;
	}
	public void setCategorycode(String categorycode) {
		this.categorycode = categorycode;
	}
	public String getObjectid() {
		return objectid;
	}
	public void setObjectid(String objectid) {
		this.objectid = objectid;
	}
	public String getReceiverid() {
		return receiverid;
	}
	public void setReceiverid(String receiverid) {
		this.receiverid = receiverid;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public Integer getIsnew() {
		return isnew;
	}
	public void setIsnew(Integer isnew) {
		this.isnew = isnew;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Integer getEnabled() {
		return enabled;
	}
	public void setEnabled(Integer enabled) {
		this.enabled = enabled;
	}
	public Date getCreateon() {
		return createon;
	}
	public void setCreateon(Date createon) {
		this.createon = createon;
	}


}
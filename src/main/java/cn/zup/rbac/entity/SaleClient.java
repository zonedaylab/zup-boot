package cn.zup.rbac.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="SALE_CLIENT")
public class SaleClient {
	
	private Integer client_Id;//客户ID
	private String client_Name;//客户名称
	private String client_Region_Code;//客户所在地
	private String client_Address;//详细地址
	private String client_Longitude;//客户经度 eg lng
	private String client_Latitude;//客户纬度eg lat
	private Integer client_Scale;//客户规模
	private Date client_Production_Date;//投产时间
	private Integer client_Energy_Property;//用电性质
	private String client_Linkman_Name;//联系人
	private String client_Linkphone;//联系电话
	private String client_Salesman;//销售人员
	private Integer client_Sign_State;//签约状态
	
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getClient_Id() {
		return client_Id;
	}
	public void setClient_Id(Integer clientId) {
		client_Id = clientId;
	}
	public String getClient_Name() {
		return client_Name;
	}
	public void setClient_Name(String clientName) {
		client_Name = clientName;
	}
	public String getClient_Region_Code() {
		return client_Region_Code;
	}
	public void setClient_Region_Code(String clientRegionCode) {
		client_Region_Code = clientRegionCode;
	}
	public String getClient_Address() {
		return client_Address;
	}
	public void setClient_Address(String clientAddress) {
		client_Address = clientAddress;
	}
	public String getClient_Longitude() {
		return client_Longitude;
	}
	public void setClient_Longitude(String clientLongitude) {
		client_Longitude = clientLongitude;
	}
	public String getClient_Latitude() {
		return client_Latitude;
	}
	public void setClient_Latitude(String clientLatitude) {
		client_Latitude = clientLatitude;
	}
	public Integer getClient_Scale() {
		return client_Scale;
	}
	public void setClient_Scale(Integer clientScale) {
		client_Scale = clientScale;
	}
	public Date getClient_Production_Date() {
		return client_Production_Date;
	}
	public void setClient_Production_Date(Date clientProductionDate) {
		client_Production_Date = clientProductionDate;
	}
	public Integer getClient_Energy_Property() {
		return client_Energy_Property;
	}
	public void setClient_Energy_Property(Integer clientEnergyProperty) {
		client_Energy_Property = clientEnergyProperty;
	}
	public String getClient_Linkman_Name() {
		return client_Linkman_Name;
	}
	public void setClient_Linkman_Name(String clientLinkmanName) {
		client_Linkman_Name = clientLinkmanName;
	}
	public String getClient_Linkphone() {
		return client_Linkphone;
	}
	public void setClient_Linkphone(String clientLinkphone) {
		client_Linkphone = clientLinkphone;
	}
	public String getClient_Salesman() {
		return client_Salesman;
	}
	public void setClient_Salesman(String clientSalesman) {
		client_Salesman = clientSalesman;
	}
	public Integer getClient_Sign_State() {
		return client_Sign_State;
	}
	public void setClient_Sign_State(Integer clientSignState) {
		client_Sign_State = clientSignState;
	}//签约状态 eg type
	
}

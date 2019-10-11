package cn.zup.workflowdemo.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * 说明： 保存样本信息实体类
 * @author 谢炎
 * @date 2016-8-17 16:11:49
 * 
 * */

public class DemoSampleReceiveRegister {
	private Integer sample_ID;       //样品id
	private String sample_Start_Time;  //采样时间
	private String sample_End_Time;    //结束时间
	private String sample_Peoper;    //采样人
	private String receive_Time;       //接收时间
	private String receive_Peoper;   //接收人
	private String container_Type;   //容器种类
	private String container_Specification;   //容器规格
	private Integer sample_Source;   //样品来源
	private String sample_Face;      //样品外观
	private String sample_Use;       //样品用途
	private String mainBizkey;
	
	public Integer getSample_ID() {
		return sample_ID;
	}
	public void setSample_ID(Integer sampleID) {
		sample_ID = sampleID;
	}
	public String getSample_Start_Time() {
		return sample_Start_Time;
	}
	public void setSample_Start_Time(String sampleStartTime) {
		sample_Start_Time = sampleStartTime;
	}
	public String getSample_End_Time() {
		return sample_End_Time;
	}
	public void setSample_End_Time(String sampleEndTime) {
		sample_End_Time = sampleEndTime;
	}
	public String getSample_Peoper() {
		return sample_Peoper;
	}
	public void setSample_Peoper(String samplePeoper) {
		sample_Peoper = samplePeoper;
	}
	public String getReceive_Time() {
		return receive_Time;
	}
	public void setReceive_Time(String receiveTime) {
		receive_Time = receiveTime;
	}
	public String getReceive_Peoper() {
		return receive_Peoper;
	}
	public void setReceive_Peoper(String receivePeoper) {
		receive_Peoper = receivePeoper;
	}
	public String getContainer_Type() {
		return container_Type;
	}
	public void setContainer_Type(String containerType) {
		container_Type = containerType;
	}
	public String getContainer_Specification() {
		return container_Specification;
	}
	public void setContainer_Specification(String containerSpecification) {
		container_Specification = containerSpecification;
	}
	public Integer getSample_Source() {
		return sample_Source;
	}
	public void setSample_Source(Integer sampleSource) {
		sample_Source = sampleSource;
	}
	public String getSample_Face() {
		return sample_Face;
	}
	public void setSample_Face(String sampleFace) {
		sample_Face = sampleFace;
	}
	public String getSample_Use() {
		return sample_Use;
	}
	public void setSample_Use(String sampleUse) {
		sample_Use = sampleUse;
	}
	public String getMainBizkey() {
		return mainBizkey;
	}
	public void setMainBizkey(String mainBizkey) {
		this.mainBizkey = mainBizkey;
	}
	
}

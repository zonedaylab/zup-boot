package cn.zup.bi.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

@Entity
@Table(name = "BI_TOPIC")
public class BI_TOPIC implements Serializable {
	
	private Integer topic_Id;
	private String topic_Name;
	private String topic_Caption;
	private Integer topic_Type;
	private String biz_Table_Name;
	private Integer ds_id;

	

	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getTopic_Id() {
		return topic_Id;
	}
	public void setTopic_Id(Integer topicId) {
		topic_Id = topicId;
	}
	public String getTopic_Name() {
		return topic_Name;
	}
	public void setTopic_Name(String topicName) {
		topic_Name = topicName;
	}
	public String getTopic_Caption() {
		return topic_Caption;
	}
	public void setTopic_Caption(String topicCaption) {
		topic_Caption = topicCaption;
	}
	public Integer getTopic_Type() {
		return topic_Type;
	}
	public void setTopic_Type(Integer topicType) {
		topic_Type = topicType;
	}
	public String getBiz_Table_Name() {
		return biz_Table_Name;
	}
	public void setBiz_Table_Name(String bizTableName) {
		biz_Table_Name = bizTableName;
	}

	public Integer getDs_id() {
		return ds_id;
	}

	public void setDs_id(Integer ds_id) {
		this.ds_id = ds_id;
	}
}

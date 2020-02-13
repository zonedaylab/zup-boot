package cn.zup.bi.entity;

import lombok.Data;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

@Data
public class BI_TOPIC implements Serializable {
	
	private Integer topic_Id;
	private String topic_Name;
	private String topic_Caption;
	private Integer topic_Type;
	private String biz_Table_Name;
	private Integer ds_id;
}

package cn.zup.bi.entity;

import lombok.Data;
import java.io.Serializable;

@Data
public class BI_DIM implements Serializable{
	private Integer dim_Id;   // 维表ID
	private String dim_Name;  // 维名称
	private String biz_Table_Name;  // 数据库表名
	private String text_Field;  // 文本字段
	private String id_Field;  // ID字段
	private String drill_Type;  // 钻取类型
	private String drill_Info;// 钻取信息
	private Integer ds_Id;// 数据源id
	private String ds_name;
}

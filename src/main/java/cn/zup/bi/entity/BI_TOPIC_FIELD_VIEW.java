package cn.zup.bi.entity;

import lombok.Data;

import java.io.Serializable;

@Data
public class BI_TOPIC_FIELD_VIEW implements Serializable {
		private BI_TOPIC_FIELD field;
		private String drill_Type;
}

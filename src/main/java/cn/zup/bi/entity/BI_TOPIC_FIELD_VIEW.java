package cn.zup.bi.entity;

import java.io.Serializable;

public class BI_TOPIC_FIELD_VIEW implements Serializable {
		public BI_TOPIC_FIELD_VIEW() {
		}
		
		private BI_TOPIC_FIELD field;
		private String drill_Type;
		
		public BI_TOPIC_FIELD getField() {
			return field;
		}
		public void setField(BI_TOPIC_FIELD field) {
			this.field = field;
		}
		public String getDrill_Type() {
			return drill_Type;
		}
		public void setDrill_Type(String drill_Type) {
			this.drill_Type = drill_Type;
		}
		
		
		
}

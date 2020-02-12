package cn.zup.bi.entity;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class DIM_VIEW {
	private String BIZ_TABLE_NAME;  
	private String DRILL_INFO;
	private Integer DIM_ID;
	private String ID_FIELD;
}

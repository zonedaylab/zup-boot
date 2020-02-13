package cn.zup.bi.entity;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Setter
@Getter
public class BI_REPORT_JSON {
	private List<BI_REPORT_FIELD> reportField;
	private List<BI_REPORT> params;
}

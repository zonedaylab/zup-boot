package cn.zup.bi.entity;

import java.util.List;

public class BI_REPORT_JSON {
	private List<BI_REPORT_FIELD> reportField;
	private List<BI_REPORT> params;
	public List<BI_REPORT_FIELD> getReportField() {
		return reportField;
	}
	public void setReportField(List<BI_REPORT_FIELD> reportField) {
		this.reportField = reportField;
	}
	public List<BI_REPORT> getParams() {
		return params;
	}
	public void setParams(List<BI_REPORT> params) {
		this.params = params;
	}
}

package cn.zup.workflow.structure;

public class FormAutoParameter {
	private Integer formID;
	private String formName;
	private String[] inputNames;
	private String[] inputValues;
	private Integer userID;
	private String mainBizKey;
	
	public Integer getFormID() {
		return formID;
	}
	public void setFormID(Integer formID) {
		this.formID = formID;
	}
	public String getFormName() {
		return formName;
	}
	public void setFormName(String formName) {
		this.formName = formName;
	}
	public String[] getInputNames() {
		return inputNames;
	}
	public void setInputNames(String[] inputNames) {
		this.inputNames = inputNames;
	}
	public String[] getInputValues() {
		return inputValues;
	}
	public void setInputValues(String[] inputValues) {
		this.inputValues = inputValues;
	}
	public Integer getUserID() {
		return userID;
	}
	public void setUserID(Integer userID) {
		this.userID = userID;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	private String realName;

	public String getMainBizKey() {
		return mainBizKey;
	}
	public void setMainBizKey(String mainBizKey) {
		this.mainBizKey = mainBizKey;
	}
	     
}

package cn.zup.workflow.model;


/**
 * 工作流表单
 * @author Administrator
 *
 */
public class WF_FORM implements java.io.Serializable {

	private Integer 		FORM_ID;//表单id
	private Integer 		PARENT_FORM_ID;//父级表单id
	private Integer 		SYSTEM_ID;//系统id
	private String 			FORM_NAME;//表单名称
	private String 			URL;//表单地址
	private String 			FORM_AUTO_CONTENT;//表单内容
	private String FORM_DELBIZ_CONTROLLER;//删除工作流时调用业务的controller，约定，在工作流中删除业务的方法需要增加del。
	public WF_FORM() {
	}
	
	public WF_FORM(int PARENT_FORM_ID, String FORM_NAME, String URL) {
		this.PARENT_FORM_ID 	= PARENT_FORM_ID;
		this.FORM_NAME 			= FORM_NAME;
		this.URL 				= URL;
	}
	public WF_FORM(int PARENT_FORM_ID, Integer SYSTEM_ID, String FORM_NAME,
			String URL) {
		this.PARENT_FORM_ID 	= PARENT_FORM_ID;
		this.SYSTEM_ID 			= SYSTEM_ID;
		this.FORM_NAME 			= FORM_NAME;
		this.URL 				= URL;
	}
	public WF_FORM(int PARENT_FORM_ID, Integer SYSTEM_ID, String FORM_NAME,
			String URL,String FORM_DELBIZ_CONTROLLER) {
		this.PARENT_FORM_ID 	= PARENT_FORM_ID;
		this.SYSTEM_ID 			= SYSTEM_ID;
		this.FORM_NAME 			= FORM_NAME;
		this.URL 				= URL;
		this.FORM_DELBIZ_CONTROLLER=FORM_DELBIZ_CONTROLLER;
	}
	public Integer getFORM_ID() {
		return FORM_ID;
	}

	public void setFORM_ID(Integer fORMID) {
		FORM_ID = fORMID;
	}

	public Integer getPARENT_FORM_ID() {
		return PARENT_FORM_ID;
	}

	public void setPARENT_FORM_ID(Integer pARENTFORMID) {
		PARENT_FORM_ID = pARENTFORMID;
	}

	public Integer getSYSTEM_ID() {
		return SYSTEM_ID;
	}

	public void setSYSTEM_ID(Integer sYSTEMID) {
		SYSTEM_ID = sYSTEMID;
	}

	public String getFORM_NAME() {
		return FORM_NAME;
	}

	public void setFORM_NAME(String fORMNAME) {
		FORM_NAME = fORMNAME;
	}

	public String getURL() {
		return URL;
	}

	public void setURL(String uRL) {
		URL = uRL;
	}

	public String getFORM_AUTO_CONTENT() {
		return FORM_AUTO_CONTENT;
	}

	public void setFORM_AUTO_CONTENT(String fORMAUTOCONTENT) {
		FORM_AUTO_CONTENT = fORMAUTOCONTENT;
	}

	public String getFORM_DELBIZ_CONTROLLER() {
		return FORM_DELBIZ_CONTROLLER;
	}

	public void setFORM_DELBIZ_CONTROLLER(String fORMDELBIZCONTROLLER) {
		FORM_DELBIZ_CONTROLLER = fORMDELBIZCONTROLLER;
	}
	
}

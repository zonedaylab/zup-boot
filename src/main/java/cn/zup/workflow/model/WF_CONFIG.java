package cn.zup.workflow.model;
public class WF_CONFIG implements java.io.Serializable {

	private int 	ID;
	private String 			NAME;
	private String 			SUB_NAME;
	private int SUB_ID;

	public WF_CONFIG() {
	}

	public WF_CONFIG(int ID) {
		this.ID 			= ID;
	}

	public WF_CONFIG(int ID, String NAME, String SUB_NAME) {
		this.ID 			= ID;
		this.NAME 			= NAME;
		this.SUB_NAME 		= SUB_NAME;
	}

	public int getID() {
		return ID;
	}

	public void setID(int ID) {
		this.ID 			= ID;
	}

	public String getNAME() {
		return NAME;
	}

	public void setNAME(String NAME) {
		this.NAME 			= NAME;
	}

	public String getSUB_NAME() {
		return SUB_NAME;
	}

	public void setSUB_NAME(String SUB_NAME) {
		this.SUB_NAME 		= SUB_NAME;
	}

	public void  setSUB_ID(int SUB_ID)
	{
		this.SUB_ID=SUB_ID;
	}
	public  int getSUB_ID()
	{
		 return SUB_ID;
	}

}

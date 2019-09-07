package cn.zup.workflow.engine;


public class SWork {
	public int nFlowID;
	public int nWorkID;
	public SWork clone(){
		SWork varCopy = new SWork();
		varCopy.nFlowID = this.nFlowID;
		varCopy.nWorkID = this.nWorkID;
		return varCopy;
	}
}

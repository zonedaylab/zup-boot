package cn.zup.workflow.model;

public class WF_ACTIVITY_POPEDOM implements java.io.Serializable {

	private WF_ACTIVITY_POPEDOM_ID 	ID;
	private byte 					STATE;
	
	private String 					GRID_COLUMN_DISPLAY;
    private int ACTIVITY_ID;
    private int CONTROL_ID;
	public WF_ACTIVITY_POPEDOM() {
	}

	public WF_ACTIVITY_POPEDOM(WF_ACTIVITY_POPEDOM_ID ID, byte STATE,int ACTIVITY_ID,int CONTROL_ID) {
		this.ID 					= ID;
		this.STATE 					= STATE;
		this.CONTROL_ID=CONTROL_ID;
		this.ACTIVITY_ID=ACTIVITY_ID;
	}

	public WF_ACTIVITY_POPEDOM(WF_ACTIVITY_POPEDOM_ID ID, byte STATE,
			String GRID_COLUMN_DISPLAY) {
		this.ID 					= ID;
		this.STATE 					= STATE;
		this.GRID_COLUMN_DISPLAY 	= GRID_COLUMN_DISPLAY;
	}

	public WF_ACTIVITY_POPEDOM_ID getID() {
		return ID;
	}

	public void setID(WF_ACTIVITY_POPEDOM_ID ID) {
		this.ID 					= ID;
	}

	public byte getSTATE() {
		return STATE;
	}

	public void setSTATE(byte STATE) {
		this.STATE 					= STATE;
	}
	
	
	public int getACTIVITY_ID() {
		
		return this.ACTIVITY_ID;
	}
	
	public void  setACTIVITY_ID(int ACTIVITY_ID) {
		
		this.ACTIVITY_ID=ACTIVITY_ID;
	}
   public int getCONTROL_ID() {		
		return CONTROL_ID;
	
	}
   public void setCONTROL_ID(int CONTROL_ID) {		
 		this.CONTROL_ID=CONTROL_ID;
 	
 	}
      
   

	public String getGRID_COLUMN_DISPLAY() {
		return GRID_COLUMN_DISPLAY;
	}

	public void setGRID_COLUMN_DISPLAY(String GRID_COLUMN_DISPLAY) {
		this.GRID_COLUMN_DISPLAY 	= GRID_COLUMN_DISPLAY;
	}


}

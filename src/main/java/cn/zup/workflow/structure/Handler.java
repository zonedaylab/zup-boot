package cn.zup.workflow.structure;
import java.io.Serializable;


/** 
 活动节点对应的操作者信息
 
*/
//C# TO JAVA CONVERTER WARNING: Java does not allow user-defined value types. The behavior of this class will differ from the original:
//ORIGINAL LINE: public struct Handler
   public final class Handler implements Serializable
{
   /** 
	ID
	
   */
   private int privateID;
   public int getID()
   {
	   return privateID;
   }
   public void setID(int value)
   {
	   privateID = value;
   }

   /** 
	名字
	
   */
   private String privateName;
   public String getName()
   {
	   return privateName;
   }
   public void setName(String value)
   {
	   privateName = value;
   }
}

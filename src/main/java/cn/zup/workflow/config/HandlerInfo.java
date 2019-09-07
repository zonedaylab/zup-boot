package cn.zup.workflow.config;

//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#endregion

//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#region 操作者信息

/** none
 操作者信息
 
*/
//C# TO JAVA CONVERTER WARNING: Java does not allow user-defined value types. The behavior of this class will differ from the original:
//ORIGINAL LINE: public struct HandlerInfo
public  class HandlerInfo
{
   public int User;
   public int Role;
   public int Position;
   public int Department;

	public HandlerInfo clone()
	{
		HandlerInfo varCopy = new HandlerInfo();

		varCopy.User = this.User;
		varCopy.Role = this.Role;
		varCopy.Position = this.Position;
		varCopy.Department = this.Department;

		return varCopy;
	}
}
//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
	///#endregion


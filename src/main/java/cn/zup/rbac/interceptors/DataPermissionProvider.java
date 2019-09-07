package cn.zup.rbac.interceptors;

public class DataPermissionProvider
{

	private DataPermissionProvider()
	{
	}

	private static DataPermissionProvider instance = new DataPermissionProvider();

	/** 
	 数据权限单一实例
	 
	*/
	public static DataPermissionProvider getInstance()
	{
		return instance;
	}

	/** 
	 获取当前账户的角色数据权限 
	 
	 @return sql语句 ,开头已添加and 
	*/
	/*
	public final String GetRoleDataPermissionSql()
	{
		Zone.Rbac.Contracts.IResourcePermission permissionService = Zone.Rbac.Client.InstanceManager.ServiceProxy.ResourcePermissionService();
		Zone.Rbac.Contracts.IAccountRole accountRoleService = Zone.Rbac.Client.InstanceManager.ServiceProxy.AccountRoleService();
		StringBuilder strSql = new StringBuilder();
		int accountID = UserContext.Current.UserSession.AccountID;
		int OrganID = UserContext.Current.UserSession.OrganID;

		String menuID = HttpContext.Current.Request.QueryString["form"];
		if(DotNetToJavaStringHelper.isNullOrEmpty(menuID))
		{
		   Uri url = new Uri(HttpContext.Current.Request.UrlReferrer.AbsoluteUri);
		   NameValueCollection col = GetQueryString(url.Query);
		   menuID = col["form"];
		}

		if (!DotNetToJavaStringHelper.isNullOrEmpty(menuID))
		{
//C# TO JAVA CONVERTER TODO TASK: There is no equivalent to implicit typing in Java:
			var permissionOrganizationList = permissionService.AccountDataPermissionList(accountID, Integer.parseInt(menuID), Zone.Rbac.Contracts.Setting.DataPermissionType.组织权限);
			if (permissionOrganizationList.size() > 0)
			{
//C# TO JAVA CONVERTER TODO TASK: There is no equivalent to implicit typing in Java:
				for (var permission : permissionOrganizationList)
				{
					strSql.append(" and " + permission.DataPermission);
				}
			}
//C# TO JAVA CONVERTER TODO TASK: There is no equivalent to implicit typing in Java:
			var permissionDataList = permissionService.AccountDataPermissionList(accountID, Integer.parseInt(menuID), Zone.Rbac.Contracts.Setting.DataPermissionType.业务范围权限);
			if (permissionDataList.size() > 0)
			{
//C# TO JAVA CONVERTER TODO TASK: There is no equivalent to implicit typing in Java:
				for (var permission : permissionDataList)
				{
					strSql.append(" and " + permission.DataPermission);
				}
			}
			if (strSql == null || strSql.length()<=0)
			{
				strSql.append(" and OrganID in (" + OrganID + ")");
			}
		}
		else
		{
		strSql.append(" and OrganID in (" + OrganID+")");
		}
		return strSql.toString();
	}
	*/

//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
		///#region URL参数获取

	/** 
	 将查询字符串解析转换为名值集合.
	 
	 @param queryString
	 @return 
	*/
	/*
	private static NameValueCollection GetQueryString(String queryString)
	{
		return GetQueryString(queryString, null, true);
	}
	*/
	/** 
	 将查询字符串解析转换为名值集合.
	 
	 @param queryString
	 @param encoding
	 @param isEncoded
	 @return 
	*/
	/*
	private static NameValueCollection GetQueryString(String queryString, Encoding encoding, boolean isEncoded)
	{
		queryString = queryString.replace("?", "");
		NameValueCollection result = new NameValueCollection(StringComparer.OrdinalIgnoreCase);
		if (!DotNetToJavaStringHelper.isNullOrEmpty(queryString))
		{
			int count = queryString.length();
			for (int i = 0; i < count; i++)
			{
				int startIndex = i;
				int index = -1;
				while (i < count)
				{
					char item = queryString.charAt(i);
					if (item == '=')
					{
						if (index < 0)
						{
							index = i;
						}
					}
					else if (item == '&')
					{
						break;
					}
					i++;
				}
				String key = null;
				String value = null;
				if (index >= 0)
				{
					key = queryString.substring(startIndex, index);
					value = queryString.substring(index + 1, index + 1 + (i - index) - 1);
				}
				else
				{
					key = queryString.substring(startIndex, i);
				}
				if (isEncoded)
				{
					result[MyUrlDeCode(key, encoding)] = MyUrlDeCode(value, encoding);
				}
				else
				{
					result[key] = value;
				}
				if ((i == (count - 1)) && (queryString.charAt(i) == '&'))
				{
					result[key] = "";
				}
			}
		}
		return result;
	}
	*/
	/** 
	 解码URL.
	 
	 @param encoding null为自动选择编码
	 @param str
	 @return 
	*/
	/*
	private static String MyUrlDeCode(String str, Encoding encoding)
	{
		if (encoding == null)
		{
			Encoding utf8 = Encoding.UTF8;
			//首先用utf-8进行解码                     
			String code = HttpUtility.UrlDecode(str.toUpperCase(), utf8);
			//将已经解码的字符再次进行编码.
			String encode = HttpUtility.UrlEncode(code, utf8).toUpperCase();
			if (str.equals(encode))
			{
				encoding = Encoding.UTF8;
			}
			else
			{
				encoding = Encoding.GetEncoding("gb2312");
			}
		}
		return HttpUtility.UrlDecode(str, encoding);
	}
	*/
//C# TO JAVA CONVERTER TODO TASK: There is no preprocessor in Java:
		///#endregion
}

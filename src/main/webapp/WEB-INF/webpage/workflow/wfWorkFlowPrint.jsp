<%@ page language="java" import="java.util.*, java.text.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta charset="utf-8" />
	<base href=" <%=basePath%>">
	<title>运维监控平台待办理工作流程配置管理打印</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<style type="text/css">
		td{
			text-align:center;
			height:20px;
		}
		th{
			height:20px;
		}
	</style>
  </head>
  
  <body>
  	<div>
  		<h1 style="margin-left:38%;"> 请 购 审 批 单</h1>
		<table border="1" width="96%" cellpadding="0" cellspacing="0" style="margin-left:20px; margin-top:10px;">
			<thead>
				<tr>
					<th>活动名称</th>
    				<th>签字人</th>
    				<th>签字时间</th>
    				<th>签字意见</th>
				</tr>
			</thead>
			<tbody id="SignData">
			</tbody>
		</table>
<!--		<div style="float:right; margin-right:20px; margin-top:10px;">-->
<!--			<span>打印日期：</span>-->
<!--			<% SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); String NowDate = sdf.format(new Date());%>-->
<!--			<span><%=NowDate %></span>-->
<!--		</div>-->
	</div>
	
	<!--  引入js存放的外部脚本库  -->
    <jsp:include page="../include/mainFooter.jsp"></jsp:include>
    
    <script type="text/javascript">
    	$(document).ready(function(){
    		$.ajax({
	           type: "POST",
	           url: "rest/workflow/workPersonal/workflowSignPrint", 
	           cache: false,  //禁用缓存
	           data: "WORK_ID="+GetQueryString("workID"),
	           dataType: "json",
	           success: function (result) {
	           		for(var i=0; i<result.data.length; i++){
	                   $("#SignData").append("<tr><td>"+result.data[i].ACTIVITY_NAME+"</td><td>"+result.data[i].SIGN_NAME+"</td><td>"+result.data[i].SIGN_DATE+"</td><td>"+result.data[i].SIGN_OPINION+"</td></tr>");
	           		}
	           		window.print();
	           },
	           error:function(){
	           		alert("数据读取失败：", function(){});
	           }
	       });
       });
       
       function GetQueryString(name) {
	        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
	        var r = window.location.search.substr(1).match(reg);
	        if (r != null) return unescape(r[2]); return null;
    	}
    
    </script>
  </body>
</html>

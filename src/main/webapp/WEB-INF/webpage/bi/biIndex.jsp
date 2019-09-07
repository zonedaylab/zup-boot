<%@ page language="java" import="java.util.*"  contentType="text/html; charset=UTF-8" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>BI 商务智能管理 - 积成能源</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--  import style	-->
	<jsp:include page="../include/mainHead.jsp"></jsp:include>

  </head>
  
  <body style="background:#ffffff; overflow-x: hidden;">
  	<!--  Theme Menu	-->
  	<div class="row">
  		<div style="height: 40px; width: 300px; margin: 10px auto;">
            <button id="dim" style="border: 1px solid #3080cc;"><span style="color: #3080cc; font-family:'黑体'">维表设置</span></button>
            <button id="theme" style="border: 1px solid #3080cc;"><span style="color: #3080cc; font-family:'黑体'">主题设置</span></button>
            <button id="table" style="border: 1px solid #3080cc;"><span style="color: #3080cc; font-family:'黑体'">报表设计</span></button>
        </div>
  	</div>
    <iframe id="iFrame" width="99%" style="border: none;"></iframe>
    
    <!--  import javascript	-->
    <jsp:include page="../include/mainFooter.jsp"></jsp:include>
    <script type="text/javascript">
    	$(document).ready(function(){
    		var h = $(window).height()-80;
    		$("#iFrame").attr("src", "rest/bi/BIDimController");
    		$("#theme").attr("class", "btn btn-white");
    		$("#dim>span").css("color", "#ffffff");
    		$("#theme>span").css("color", "#3080cc");
    		$("#table>span").css("color", "#3080cc");
    		$("#dim").attr("class", "btn btn-info");
    		$("#table").attr("class", "btn btn-white");
    		$("#iFrame").css("height", h+"px");
    	});
    	
    	$(document).resize(function(){
    		var h = $(window).height()-100;
    		$("#iFrame").css("height", h+"px");
    	});
    	
    	$("#theme").on("click", function(){
    		$("#iFrame").attr("src", "rest/bi/BITopicController");
    		$("#theme").attr("class", "btn btn-info");
    		$("#theme>span").css("color", "#ffffff");
    		$("#dim").attr("class", "btn btn-white");
    		$("#table").attr("class", "btn btn-white");
    		$("#dim>span").css("color", "#3080cc");
    		$("#table>span").css("color", "#3080cc");
    	});
    	
    	$("#dim").on("click", function(){
    		$("#iFrame").attr("src", "rest/bi/BIDimController");
    		$("#theme").attr("class", "btn btn-white");
    		$("#dim").attr("class", "btn btn-info");
    		$("#dim>span").css("color", "#ffffff");
    		$("#theme>span").css("color", "#3080cc");
    		$("#table").attr("class", "btn btn-white");
    		$("#table>span").css("color", "#3080cc");
    	});
    	
    	$("#table").on("click", function(){
    		$("#iFrame").attr("src", "rest/bi/biReportController");
    		$("#theme").attr("class", "btn btn-white");
    		$("#dim").attr("class", "btn btn-white");
    		$("#theme>span").css("color", "#3080cc");
    		$("#table").attr("class", "btn btn-info");
    		$("#table>span").css("color", "#ffffff");
    		$("#dim>span").css("color", "#3080cc");
    	});
    	
    </script>
  </body>
</html>

<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
  </head>
  <body>
    <!-- 基本 styles -->
    	<link type="text/css" rel="stylesheet" href="plug-in/ace/assets/css/dialogText.css" />
	    <link href="plug-in/ace/css/bootstrap.min.css" rel="stylesheet" />
	    <link rel="stylesheet" href="plug-in/ace/assets/css/font-awesome.min.css" />
	    <!--[if IE 7]>
	    <link rel="stylesheet" href="plug-in/ace/assets/css/font-awesome-ie7.min.css" />
	    <![endif]-->
	    <!-- page specific plugin styles -->
	    <!-- ace styles -->
	    <link rel="stylesheet" href="plug-in/ace/assets/css/jquery-ui-1.10.3.full.min.css" />
	    <link rel="stylesheet" href="plug-in/ace/assets/css/ace.min.css" />
	    <link rel="stylesheet" href="plug-in/ace/assets/css/ace-rtl.min.css" />
	    <link rel="stylesheet" href="plug-in/ace/assets/css/ace-skins.min.css" />
	    <!-- 引入数据互换下拉列表框-->
	    <link rel="stylesheet" href="plug-in/ace/css/pickList.css" />
	    <!--[if lte IE 8]>
	    <link rel="stylesheet" href="plug-in/ace/assets/css/ace-ie.min.css" />
	    <![endif]-->
	    <!-- inline styles related to this page -->
	    <!-- ace settings handler -->
	    <script src="plug-in/ace/assets/js/ace-extra.min.js"></script>
	    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	    <!--[if lt IE 9]>
	    <script src="plug-in/ace/assets/js/html5shiv.js"></script>
	    <script src="plug-in/ace/assets/js/respond.min.js"></script>
	    <![endif]-->
	    <style>
    		 .black_overlay{ 
		            display: none; 
		            position: absolute; 
		            top: 0%; 
		            left: 0%; 
		            width: 100%; 
		            height: 100%; 
		            background-color: black; 
		            z-index:1001; 
		            -moz-opacity: 0.8; 
		            opacity:.80; 
		            filter: alpha(opacity=88); 
		        } 
		        .white_content { 
		            display: none; 
		            position: absolute; 
		            top: 25%; 
		            left: 25%; 
		            width: 55%; 
		            height: 55%; 
		            padding: 20px; 
		            border: 10px solid orange; 
		            background-color: white; 
		            z-index:1002; 
		            overflow: auto; 
		        } 
    	</style>
  </body>
</html>

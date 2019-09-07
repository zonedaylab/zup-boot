<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  </head>
  <body>
    <!-- 基本 styles -->
	    <link href="../../plug-in/ace/assets/css/bootstrap.min.css" rel="stylesheet" />
	    <link rel="stylesheet" href="../../plug-in/ace/assets/css/font-awesome.min.css" />
	    <!--[if IE 7]>
	    <link rel="stylesheet" href="../../plug-in/ace/assets/css/font-awesome-ie7.min.css" />
	    <![endif]-->
	    <!-- page specific plugin styles -->
	    <!-- ace styles -->
	    <link rel="stylesheet" href="../../plug-in/ace/assets/css/jquery-ui-1.10.3.full.min.css" />
	    <link rel="stylesheet" href="../../plug-in/ace/assets/css/ace.min.css" />
	    <link rel="stylesheet" href="../../plug-in/ace/assets/css/ace-rtl.min.css" />
	    <link rel="stylesheet" href="../../plug-in/ace/assets/css/ace-skins.min.css" />
	    <!-- 引入数据互换下拉列表框-->
	    <link rel="stylesheet" href="../../plug-in/ace/css/pickList.css" />
	    <!--[if lte IE 8]>
	    <link rel="stylesheet" href="../../plug-in/ace/assets/css/ace-ie.min.css" />
	    <![endif]-->
	    <!-- inline styles related to this page -->
	    <!-- ace settings handler -->
	    <script src="../../plug-in/ace/assets/js/ace-extra.min.js"></script>
	    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	    <!--[if lt IE 9]>
	    <script src="../../plug-in/ace/assets/js/html5shiv.js"></script>
	    <script src="../../plug-in/ace/assets/js/respond.min.js"></script>
	    <![endif]-->
  </body>
</html>

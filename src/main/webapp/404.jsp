<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="eng" lang="eng">
  <head> 
	  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
	  <meta name="description" content="Site description" />
	  <meta name="keywords" content="keywords, keyword, seo, google" /> 
	  <meta name="apple-mobile-web-app-status-bar-style" content="black" /> 
	  <meta name="apple-mobile-web-app-capable" content="yes" /> 
	  <title>您访问的页面不存在了-积成</title>
	   <link rel="shortcut icon" type="image/x-icon" href="favicon.png" />
	   <link rel="icon" type="image/x-icon" href="favicon.png" />
	   <link rel="apple-touch-icon" href="favicon.png" />
	   <link rel="apple-touch-startup-image" href="favicon.png" />
		<link href="plug-in/ace/css/bootstrap.min.css" rel="stylesheet" />
   </head> 
   <body style="overflow-x : hidden ;overflow-y : hidden ; background:#000000 url(plug-in/ace/chromebrowse/images/404.png) no-repeat center center fixed;">
  	<div>
  		<div style="position:absolute; z-index:2; width:20%; height:5%; margin-left:64%; margin-top:28%;">
  			<h3 style="font-family:'黑体';">
  				<a href="javascript:history.go(-1);">返回</a> 
  			</h3>
  		</div>
  		
  	</div>
  </body>
</html>

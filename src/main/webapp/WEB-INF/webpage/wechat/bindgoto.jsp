<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
  <meta charset="utf-8">
  <title>跳转中，请稍等</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=0">
</head>
<script>
	if("${ param.url}" != "")
		location.href = "${ param.url}";
	else
		window.location.href= "${url}"
</script>
</html>

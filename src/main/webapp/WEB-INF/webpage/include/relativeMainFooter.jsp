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
    <!-- 引入 scripts -->
		<!--[if !IE]> -->
		<script type="text/javascript">
			window.jQuery || document.write("<script src='../../plug-in/ace/assets/js/jquery-2.0.3.min.js'>"+"<"+"/script>");
		</script>
		<!-- <![endif]-->
		<!--[if IE]>
		<script type="text/javascript">
		 window.jQuery || document.write("<script src='assets/js/jquery-1.10.2.min.js'>"+"<"+"/script>");
		</script>
		<![endif]-->
		<script type="text/javascript">
			if("ontouchend" in document) 
				document.write("<script src='../../plug-in/ace/assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
		</script>
        <!--引入异步加载的js库文件-->
		<script src="../../plug-in/ace/assets/js/bootstrap.min.js"></script>
        <!--引入上传界面js库文件-->
		<script src="../../plug-in/ace/assets/js/dropzone.min.js"></script>
		<script src="../../plug-in/ace/assets/js/typeahead-bs2.min.js"></script>
		<!-- page specific plugin scripts -->
		<script src="../../plug-in/datatables/jquery.dataTables.min.js"></script>
		<script src="../../plug-in/datatables//dataTables.bootstrap.min.js"></script>
		<!-- ace scripts -->
		<script src="../../plug-in/ace/assets/js/ace-elements.min.js"></script>
		<script src="../../plug-in/ace/assets/js/ace.min.js"></script>
		<!-- inline scripts related to this page -->
		<script src="../../plug-in/ace/assets/js/date-time/bootstrap-datepicker.js"></script>
		<script src="../../plug-in/ace/assets/js/date-time/locales/bootstrap-datepicker.zh-CN.js"></script>
    	<script src="../../plug-in/ace/assets/js/bootstrap.min.js"></script>
    	<script src="../../plug-in/ace/assets/js/typeahead-bs2.min.js"></script>
    	<!-- page specific plugin scripts -->
    	<script src="../../plug-in/ace/assets/js/fuelux/data/fuelux.tree-sampledata.js"></script>
    	<script src="../../plug-in/ace/assets/js/fuelux/fuelux.tree.min.js"></script>
    	<script src="../../plug-in/ace/assets/js/jquery-ui-1.10.3.full.min.js"></script>
		<script src="../../plug-in/ace/assets/js/jquery.ui.touch-punch.min.js"></script>
    	<!-- ace scripts -->
    	<script src="../../plug-in/ace/assets/js/ace-elements.min.js"></script>
    	<script src="../../plug-in/ace/assets/js/ace.min.js"></script>
    	<!-- 引入ace风格的alert消息框 -->
    	<script src="../../plug-in/ace/assets/js/bootbox.min.js"></script>
    	<!-- 引入数据互换下拉列表框-->
    	<script src="../../plug-in/ace/js/pickList.js"></script>
  </body>
</html>

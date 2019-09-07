<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!-- 引入 scripts -->
<!--[if !IE]> -->
<script type="text/javascript">
	window.jQuery || document.write("<script src='plug-in/ace/assets/js/jquery-2.0.3.min.js'>"+"<"+"/script>");
</script>
<!-- <![endif]-->
<!--[if IE]>
<script type="text/javascript">
 	window.jQuery || document.write("<script src='assets/js/jquery-1.10.2.min.js'>"+"<"+"/script>");
</script>
<![endif]-->
<script type="text/javascript">
	if("ontouchend" in document) 
		document.write("<script src='plug-in/ace/assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
</script>
<script src="plug-in/ace/assets/js/bootstrap.min.js"></script>
<script src="plug-in/ace/assets/js/typeahead-bs2.min.js"></script>
<!-- page specific plugin scripts -->
<script src="plug-in/datatables/jquery.dataTables.min.js"></script>
<script src="plug-in/datatables//dataTables.bootstrap.min.js"></script>
<!-- ace scripts -->
<script src="plug-in/ace/assets/js/ace-elements.min.js"></script>
<script src="plug-in/ace/assets/js/ace.min.js"></script>
<!-- inline scripts related to this page -->
<script src="plug-in/ace/assets/js/date-time/bootstrap-datepicker.js"></script>
<script src="plug-in/ace/assets/js/date-time/locales/bootstrap-datepicker.zh-CN.js"></script>
<script src="plug-in/ace/assets/js/bootstrap.min.js"></script>
<script src="plug-in/ace/assets/js/typeahead-bs2.min.js"></script>
<!-- page specific plugin scripts -->
<script src="plug-in/ace/assets/js/fuelux/data/fuelux.tree-sampledata.js"></script>
<script src="plug-in/ace/assets/js/fuelux/fuelux.tree.min.js"></script>
<script src="plug-in/ace/assets/js/jquery-ui-1.10.3.full.min.js"></script>
<script src="plug-in/ace/assets/js/jquery.ui.touch-punch.min.js"></script>
<!-- 引入ace风格的alert消息框 -->
<script src="plug-in/ace/assets/js/bootbox.min.js"></script>
<!-- 引入数据互换下拉列表框-->
<script src="plug-in/ace/js/pickList.js"></script>
<script>
	document.body.onclick = function (e) {
		var bodyParam = {};
	    if ((e.target||window.event.srcElement).tagName.toLowerCase() === 'button' 
	    		&& (e.target||window.event.srcElement).className.toLowerCase().indexOf("btn") > -1
	    		|| (e.target||window.event.srcElement).className.toLowerCase().indexOf("ui-button-text") > -1) {
	    	bodyParam.auditPage = $("li.active" , parent.document).text();
	    	bodyParam.auditEvent = (e.target||window.event.srcElement).innerText;
	    	if(bodyParam.auditEvent.indexOf("删除") || bodyParam.auditEvent.indexOf("添加") || bodyParam.auditEvent.indexOf("删除")){
	    		bodyParam.auditLevel = 3;
	    		if(bodyParam.auditEvent.indexOf("保存")){
	    			bodyParam.memo = "该用户可能保存了编辑或者添加的数据";
	    		}
	    	}else{
	    		bodyParam.auditLevel = 1;
	    	}
	        $.ajax({
		      async : true,
		      type : 'POST',
		      url : 'rest/rbac/auditLogController/addAuditLog',// 请求的路径
		      data : bodyParam,
		      dataType:"json"
	        });
	        return e;
	    }else{
	    	return e;
	    }
	    return e;
	}
	function showError(error){
		var close = "<a href = 'javascript:void(0)' onclick = 'closeError()'>点这里关闭本窗口</a><br><br><p>";
		$("#errorDiv").html(close+error);
		document.getElementById('errorDiv').style.display='block';
		document.getElementById('fade').style.display='block'
	}
	function closeError(){
		document.getElementById('errorDiv').style.display='none';
		document.getElementById('fade').style.display='none'
	}
</script>

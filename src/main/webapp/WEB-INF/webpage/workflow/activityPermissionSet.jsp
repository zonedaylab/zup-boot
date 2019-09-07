<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<base href=" <%=basePath%>">
		<meta name="description" content="运维监控平台" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<!--        引入外部样式库css        -->
        <jsp:include page="../include/mainHead.jsp"></jsp:include>
		
	</head>

	<body  style="background-color:#FFFFFF; height:1500px; overflow-x : hidden ;">
		<div class="page-content"> 
			<div class="row"> 
				<form class="bootbox-form">
		            <strong>活动序号：</strong><input id= "activityCode"  readonly="readonly"  type="text" style="height: 30px; width: 250px; margin-bottom:5px;"/></br>
		            <strong>活动名称：</strong><input id= "activityName"  readonly="readonly"  type="text" style="height: 30px; width: 250px; margin-bottom:5px;"/>  
		        </form>
				<div class="table-header">组件状态设置</div> 
				<div class="table-responsive">
					<table id="formControlTable" class="table table-striped table-bordered table-hover"  style="margin-bottom:20px;">
						<thead>
							<tr> 
								<th style="display:none;">
								</th>
								<th>
									组件名称
								</th>
								<th>
									组件文本名称
								</th>
								<th>
									组件状态
								</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${ listFormControl}" var ="control"> 
								 <tr>
					                <td style="display:none;">${control.CONTROL_ID}</td>
					                <td>${control.CONTROL_NAME}</td>
					                <td>${control.CONTROL_TEXT}</td>
					                <td>
					                	<select size="1" id="row-1-office" name="row-1-office">
					                	   <c:choose>
											   <c:when test="${control.STATE=='1'}">  
											        <option value="1" selected="selected">可用</option> 
											        <option value="2">只读</option> 
											        <option value="3">隐藏</option> 
											   </c:when> 
											   <c:when test="${control.STATE=='2'}">   
											        <option value="1">可用</option> 
											        <option value="2" selected="selected">只读</option> 
											        <option value="3">隐藏</option> 
											   </c:when> 
											   <c:when test="${control.STATE=='3'}">  
											        <option value="1">可用</option> 
											        <option value="2">只读</option> 
											        <option value="3" selected="selected">隐藏</option> 
											   </c:when> 
											   <c:otherwise>
											        <option value="1">可用</option> 
											        <option value="2">只读</option> 
											        <option value="3">隐藏</option> 
   												</c:otherwise> 
										  </c:choose>  
					                	</select>
					               </td>
					            </tr>
							</c:forEach>
						</tbody>
					</table>
				</div> 
				<div class="table-header">组件Grid</div> 
				<div class="table-responsive">
					<table id="formControlGridTable" class="table table-striped table-bordered table-hover"  style="margin-bottom:20px;">
						<thead>
							<tr> 
								<th style="display:none;">
								</th>
								<th>
									组件名称
								</th>
								<th>
									GridView中各列显隐性
								</th> 
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${listFormControlGrid}" var ="controlGrid"> 
								 <tr>
					                <td style="display:none;">${controlGrid.CONTROL_ID}</td>
					                <td>${controlGrid.CONTROL_NAME}</td> 
					                <td><input type="text" id="row-1-age" name="row-1-age" value="${controlGrid.GRID_COLUMN_DISPLAY}"></td> 
					            </tr>
							</c:forEach>
						</tbody>
					</table>
				</div> 
			</div>
			<div class="row">
				<div class="col-md-7"></div>
				<div class="col-md-4" style="margin-left:20px;height:30px; margin-bottom:10px; margin-top:5px;">
					<button class="btn btn-primary btn-sm" id="btnSave">保存</button>
				</div>
			</div>
		</div>

		<!--  引入js存放的外部脚本库  -->
        <jsp:include page="../include/mainFooter.jsp"></jsp:include> 
        <script type="text/javascript">
			var params = {};  
			function loadPage(){
	         	params.activityId=GetQueryString("activityId");
				$.ajax({
		            url: 'rest/workflow/design/getActivityInfo',
		            async: false,
		            data: 'activityId='+params.activityId,
		            type: 'POST',
		            dataType: 'json',
		            success: function (result) {  
		        		$("#activityCode").val(result.data[0].activityCode); 
		        		$("#activityName").val(result.data[0].activityName);  
		            },
		            error: function(){
		        		$("#activityCode").val(""); 
		        		$("#activityName").val("");  
		            }
			     });
			}
	     
	    	$("#btnSave").on('click' , function(){
		    	//非Grid控件  
	    		var rows = document.getElementById("formControlTable").rows.length;
	    		var colums = document.getElementById("formControlTable").rows[0].cells.length; 
	            var arrControls = []; 
	    		if(rows > 1){//
	                for (var i = 1; i < rows; i++) { //每行 从第二行开始因为第一行是表格的标题  
			            var item = {};
			            item["CONTROL_ID"] = document.getElementById("formControlTable").rows[i].cells[0].innerHTML;
			            item["STATE"] = document.getElementById("formControlTable").rows[i].cells[3].getElementsByTagName("select")[0].value;
			            arrControls.push(item);
	                }
	    		}
	    		arrControls = JSON.stringify(arrControls);
	    		params.arrControls=arrControls;

	            //Grid控件 
	    		var rowsGrid = document.getElementById("formControlGridTable").rows.length;
	    		var columsGrid = document.getElementById("formControlGridTable").rows[0].cells.length; 
	            var arrControlGrids = []; 
	    		if(rowsGrid > 1){//
	                for (var i = 1; i < rowsGrid; i++) { //每行 从第二行开始因为第一行是表格的标题  
			            var item = {};
			            item["CONTROL_ID"] = document.getElementById("formControlGridTable").rows[i].cells[0].innerHTML;
			            item["GRID_COLUMN_DISPLAY"] = document.getElementById("formControlGridTable").rows[i].cells[2].children[0].defaultValue;
			            arrControlGrids.push(item);
	                }
	    		}
	    		arrControlGrids = JSON.stringify(arrControlGrids);
	    		params.arrControlGrids=arrControlGrids;

	            $.ajax( {
	    			type : "post",
	    			async : false, //同步执行  
	                url: "rest/workflow/design/saveControlData", 
	                data: params,
	    			dataType : "json", //返回数据形式为json  
	    			success : function(result) { 
	        				alert(result.result);
	    			},
	    			error : function(errorMsg) {
	    				alert("图表请求数据失败!");
	    			}
	    		});
	    	});


	        function GetQueryString(name) {
	            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
	            var r = window.location.search.substr(1).match(reg);
	            if (r != null) return unescape(r[2]); return null;
	        }
	        loadPage();
        </script>
</body>
</html>

<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>报表设计管理 - BI商务智能 - 积成能源</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />

		<!--        引入外部样式库css        -->
		<jsp:include page="../include/mainHead.jsp"></jsp:include>

		<!-- CSS -->
		<style>
			.container {
				border: 1px dashed #ffffff;
				position: relative;
				min-width: 100%;
				max-width: 100%;
			}
			
			.container>div {
				background: #cccccc;
				position: absolute;
				height: 30px;
				width: 100%;
				color: #000;
				line-height: 30px;
				text-align: center;
				padding-left: 8px;
			}
			
			.thead {
				background: #a0a0a0;
				height: 30px;
				width: 100%;
				color: #000;
				line-height: 30px;
				text-align: center;
			}
			
			.thead>div {
				margin: 0 auto;
				background: #a0a0a0;
				height: 30px;
				width: 1262px;
				color: #000;
				line-height: 30px;
				text-align: center;
			}
			
			.thead>div>div {
				height: 30px;
				width: 100px;
				float: left;
			}
			
			.container>div:hover {
				background: #a0a0a0;
				height: 30px;
			}
			
			.container>div>div {
				height: 30px;
				width: 100px;
				float: left;
			}
			
			.container>.ss-placeholder-child {
				background: transparent;
			}
			
			#yuan>div {
				width: 100%;
			}
			
			.show>div {
				position: absolute;
				height: 50px;
				width: 130px;
				color: #000;
				background: #cccccc;
			}
			
			.show>div:hover {
				background: #cccccc;
				height: 50px;
			}
			
			.show>div>div {
				float: left;
				display: none;
			}
			
			.show>div>.lie {
				text-align: center;
			    height: 50px;
			    display: block;
			    float: left;
			    width: 110px;
			    line-height: 50px;
			    overflow: hidden;
			}
			
			.show>span {
				position: absolute;
				left: 0px;
				top: 0px;
				width: 130px;
				height: 100px;
				z-index: -10;
				color: #cccccc;
			}
			</style>
		<!--  引入js存放的外部脚本库  -->
		<jsp:include page="../include/mainFooter.jsp"></jsp:include>
		<script type="text/javascript"
			src="plug-in/ace/jqtool/js/vendor/jquery.touch-punch.min.js"></script>
		<script type="text/javascript"
			src="plug-in/ace/jqtool/js/jquery.shapeshift.js"></script>
	</head>
	<body style="background: #FFFFFF; overflow: hidden; overflow-y: auto;">
		<!-- 左查询条件开始 -->
		<div class="page-header">
			<div class="row">
				<small style="margin-left: 3%;"><i
					class="icon-double-angle-right"></i>查询条件</small>
			</div>
		</div>
		<div class="row center center-block"
			style="margin-top: 10px; margin-bottom: 10px;">
			<span
				style="float: left; margin-left: 5%; line-height: 32px; text-align: center;">选择主题：</span>
			<select id="seltheme" class="form-control inputs"
				style="float: left; width: 150px;">

			</select>
			<div id="reportSelect"
				style="float: left; margin-left: 5%; display: none;">
				<span style="float: left; line-height: 32px; text-align: center;">报表模板：</span>
				<select id="theme" class="form-control inputs"
					style="float: left; width: 150px;">

				</select>
			</div>
			<button id="btnPreview" class="btn btn-sm btn-primary"
				style="float: left; margin-left: 20px;">
				预览
			</button>
		</div>
		<!-- 报表设计面板 -->
		<div
			style="width: 100%; height: 30px; line-height: 30px; text-align: center; background: #307ecc; color: #fff; font-size: 16px; font-family: '黑体';">
			报表设计面板
		</div>
		<div class="row center center-block"
			style="margin-top: 10px; margin-bottom: 10px;">
			<span
				style="float: left; margin-left: 5%; line-height: 32px; text-align: center;">报表标题：</span>
			<input id="reportTitle" class="form-control inputs"
				style="float: left; width: 200px;" />
			<span
				style="float: left; margin-left: 5%; line-height: 32px; text-align: center;">报表名称：</span>
			<input id="reportName" class="form-control inputs"
				style="float: left; width: 200px;" />
			<span
				style="float: left; margin-left: 5%; line-height: 32px; text-align: center;">菜单名称：</span>
			<select id="menuName" class="form-control inputs"
				style="float: left; width: 200px;">

			</select>
		</div>
		<div class="container show" id="show"
			style="height: 122px; border: 1px dashed #3c3c3c; margin-bottom: 10px;">
			<span class="spanHidden">主题字段拖放到此处</span>
		</div>
		<!-- 主题字段 -->
		<div
			style="width: 100%; height: 30px; line-height: 30px; text-align: center; background: #307ecc; color: #fff; font-size: 16px; font-family: '黑体';">
			主题字段
		</div>
		<div class="thead">
			<div>
				<div style="margin-left: 15px;">
					标题
				</div>
				<div>
					名称
				</div>
				<div>
					数据类型
				</div>
				<div>
					别名
				</div>
				<div>
					对应维表
				</div>
				<div>
					长度
				</div>
				<div>
					小数
				</div>
				<div>
					允许为空
				</div>
				<div>
					是否唯一
				</div>
			</div>
		</div>
		<div class="container" id="yuan" style="padding: 0px;">

		</div>


		<!-- 保存按钮 -->
		<div class="row">
			<input id="btnSave" class="btn btn-sm btn-primary" onclick="save()"
				value="保存" style="float: right; margin-right: 10%;" />
		</div>

		<!--弹出框放置位置  添加 删除  查看详情-->
		<div id="fromEdit" class="hide">
			<form class="form-horizontal" role="form">
				<strong style="text-align: left; float: left;">报表模板：</strong>
				<select class="form-control" id="reportNameForm"
					style="width: 200px; float: left;">
				</select>
				<font style="float: left; font-size: 20px; margin-left: 5px;"
					color=red>*</font>
			</form>
		</div>

		<script type="text/javascript">
			var iframe = parent.document.getElementById("iFrame");
	     	$(document).ready(function() {
		        loadTheme();
		        loadMenu();
		    });
		    
	     	var reportId = null;
	     	var param = {};
	     	param.rows = 0;
            param.page = 0;
	     	$("#seltheme").on("change", function(e){
	     		param.topic_Id = $("#theme").val();
	     		if(param.topic_Id == 0){
	     			param.topic_Id="";
	     		}
	     		loadThemeField();
	     		$("#show").empty();
	     		$("#show").html("<span class='spanHidden'>主题字段拖放到此处</span>");
	     		getReportName(e);
	     		iframe.setAttribute("height", document.body.scrollHeight+"px");
	     	});
	    	//获取主题字段信息
	    	function loadThemeField(){
                //ajax请求数据
                $.ajax({
                    type: "POST",
                    url: "rest/bi/biReportDesignController/getFieldData",
                    cache: false,  //禁用缓存
                    data: param,  //传入组装的参数
                    dataType: "json",
                    success: function (result) {
                    	$("#yuan").html("");
						for(var i=0; i<result.data.length; i++){
							$("#yuan").append("<div style='white-space:nowrap;'><div style='display:none; margin-left:15px;'>"+result.data[i].field.title_Field_Id+"</div><div class='lie' title='"+result.data[i].field.title_Field_Name+":"+result.data[i].field.field_Caption+"'>"+result.data[i].field.title_Field_Name+"</div><div>"+result.data[i].field.field_Type+"</div><div style='display:none;'>"+result.data[i].drill_Type+"</div><div style='display:none;'></div><div style='display:none;'>"+result.data[i].field.field_Caption+"</div><div>"+result.data[i].field.field_Title+"</div><div>"+result.data[i].field.dim_Name+"</div><div>"+result.data[i].field.field_Length+"</div><div>"+result.data[i].field.field_Decimal+"</div><div>"+result.data[i].field.null_Permit+"</div><div>"+result.data[i].field.field_Identity+"</div></div>");
                    	}
						iframe.setAttribute("height", document.body.scrollHeight+"px");
						$("#yuan").css("width", "100%");
                    	$(".container").shapeshift();
                    }
                });
	    	}
	    	
	    	//加载主题下拉框
	    	function loadTheme(){
	    		$.ajax({
                   type: "POST",
                   url: "rest/bi/BITopicController/girdTopicList",
                   cache: false,  //禁用缓存
                   data: param,  //传入组装的参数
                   dataType: "json",
                   success: function (result) {
                   		$("#seltheme").html("");
                   		$("#seltheme").append("<option value='0'>请选择主题</option>");
                   		for(var i=0; i<result.data.length; i++){
                   			$("#seltheme").append("<option value="+result.data[i].topic_Id+">"+result.data[i].topic_Name+"</option>");
                    	}
                   }
               });
	    	}
	    	
	    	$("#menuName").click(function(){
	    		loadMenu();
	    	});
	    	
	    	//加载菜单下拉框
	    	function loadMenu(){
	    		$.ajax({
                   type: "POST",
                   url: "rest/bi/biReportDesignController/getMenu",
                   cache: false,  //禁用缓存
                   dataType: "json",
                   success: function (result) {
                   		$("#menuName").html("");
                   		$("#menuName").append("<option value='0'>请选择菜单</option>");
                   		for(var i=0; i<result.data.length; i++){
                   			$("#menuName").append("<option value="+result.data[i].menuId+">"+result.data[i].menuName+"</option>");
                    	}
                   }
               });
	    	}
	    	
	        //保存数据  通过标签属性找到方法
	        var reportField = new Array();
	        var params = new Array();
	        function save(){
		        $("#show").children().each(function(i,n){
	           		var obj = $(n);
	           		var field_Col = i+1;
	           		var a,b,c,d,e;
	           		//第二次循环，其中每次循环都是一个fileds对象
	           		obj.children().each(function(j,m){
						switch(j){
							case 0:
								a= $(m).html();
								break;
							case 1:
								b= $(m).html();
								break;
							case 2:
								c= $(m).html();
								break;
							case 3:
								d= $(m).html();
								break;
							case 4:
								e= $(m).html();
								break;
							default:
								break;
						}
	           		});
	           	   reportField.push({title_Field_Id:a,report_Field_Name:b,field_Type:c,drill_Type:d,report_Id:e,field_Row:1,field_Col:field_Col});
		         });
		        var topic_Id = $("#seltheme").val();
		        var report_Title = $("#reportTitle").val();
		        var report_Name = $("#reportName").val();
		        var menu_Id = $("#menuName").val();
		        params.push({topic_Id:topic_Id, report_Title:report_Title, report_Name:report_Name, menu_Id:menu_Id});
		        var par = new Array();
		        par.push({reportField:reportField, params:params});
	            $.ajax({
                   type: "POST",
                   url: "rest/bi/biReportDesignController/saveReportData",
                   cache: false,  //禁用缓存
                   data: JSON.stringify(par),
                   contentType : 'application/json;charset=utf-8', //设置请求头信息  
                   dataType: "json",
                   success: function (result) {
                   		if(result.info == "success")
               			parent.parent.bootbox.alert("保存成功");
                   		else
                   			parent.parent.bootbox.alert("保存失败");
                   },
                   error: function(){
                   		parent.parent.bootbox.alert("保存失败");
                   }
                }); 
	        }
	        
	        //获取保存后的模板加载（当模板有单个时）
	        function getDropAfter(){
	        	$.ajax({
                   type: "POST",
                   url: "rest/bi/biReportDesignController/getDropAfter",
                   cache: false,  //禁用缓存
                   data: "reportId="+reportId,
                   dataType: "json",
                   success: function (result) {
                   		$("#reportName").val(result.data[0].report_Name);
                   		$("#reportTitle").val(result.data[0].report_Title);
                   		$("#menuName").val(result.data[0].menu_Id);
                   		reportId = result.data[0].report_Id;
                   		$("#show").empty();
                   		for(var i=0; i< result.data.length; i++){
	                   		$("#show").append("<div style='white-space:nowrap;'><div style='display:none; margin-left:15px;'>"+result.data[i].title_Field_Id+"</div><div class='lie' title='"+result.data[i].report_Field_Name+"："+result.data[i].report_Field_Caption+"'>"+result.data[i].report_Field_Name+"</div><div>"+result.data[i].field_Type+"</div><div style='display:none;'>"+result.data[i].drill_Type+"</div><div>"+result.data[i].report_Id+"</div></div>");
                  		}
                  		iframe.setAttribute("height", document.body.scrollHeight+"px");
                  		$(".container").shapeshift();
                   },
                   error: function(){
                   		parent.parent.bootbox.alert("获取拖拽后的报表失败");
                   }
                });
	        }
	        //获取模板名称
	        function getReportName(e){
	        	topic_Id = $("#seltheme").val();
	        	$.ajax({
                   type: "POST",
                   url: "rest/bi/biReportDesignController/getReportName",
                   cache: false,  //禁用缓存
                   data: "topic_Id="+topic_Id,
                   dataType: "json",
                   success: function (result) {
                   		$("#reportNameForm").html("");
                   		$("#reportNameForm").append("<option value='0'>请选择报表模板</option>");
                   		if(result.count > 1){
                   			for(var i=0; i< result.data.length; i++){
                   				$("#reportNameForm").append("<option value="+result.data[i].report_Id+">"+result.data[i].report_Name+"</option>");
                			}
                			iframe.setAttribute("height", document.body.scrollHeight+"px");
                			flag = true;
                   			msgDialog(e);
                   		}else{
                   			reportId = result.data[0].report_Id;
                   			getDropAfter();
                   			iframe.setAttribute("height", document.body.scrollHeight+"px");
                   		}
                   },
                   error: function(){
                   		parent.parent.bootbox.alert("获取报表模板名称失败");
                   }
                });
	        }
	        
	        //获取报表id
	        $("#reportNameForm").on("change", function(){
	        	reportId = $("#reportNameForm").val();
	        });
	        
	        //预览按钮
	        var topic_Id = null;
	        $("#btnPreview").on("click", function(){
	        	if(reportId==0 || reportId==null){
	        		parent.parent.bootbox.alert("请选择报表模板");
	        		return;
	        	}
	        	window.open("rest/bi/biReportDesignController/previewPage?reportId="+reportId, '主题字段设置', 'height=650,width=1000,top=50,left=100,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
        	});
	        //加载保存的报表数据（当模板有多个时）
	       function loadSaveReporData(){
	        	report_Id = $("#reportNameForm").val();
	        	if(report_Id == 0){
	        		parent.parent.bootbox.alert("请选择报表模板");
	        		return;
	        	}
	        	$.ajax({
                   type: "POST",
                   url: "rest/bi/biReportDesignController/getReportData",
                   cache: false,  //禁用缓存
                   data: "report_Id="+report_Id,
                   dataType: "json",
                   success: function (result) {
                   		$("#reportName").val(result.data[0].report_Name);
                   		$("#reportTitle").val(result.data[0].report_Title);
                   		$("#menuName").val(result.data[0].menu_Id);
                   		$("#show").empty();
                   		for(var i=0; i< result.data.length; i++){
	                   		$("#show").append("<div style='white-space:nowrap;'><div style='display:none; margin-left:15px;'>"+result.data[i].title_Field_Id+"</div><div class='lie' title='"+result.data[i].report_Field_Name+"："+result.data[i].report_Field_Caption+"'>"+result.data[i].report_Field_Name+"</div><div>"+result.data[i].field_Type+"</div><div style='display:none;'>"+result.data[i].drill_Type+"</div><div>"+result.data[i].report_Id+"</div></div>");
                  		}
                  		$(".container").shapeshift();
                   },
                   error: function(){
                   		parent.parent.bootbox.alert("获取拖拽后的报表失败");
                   }
                });
	        }
	        
	        //弹出框样式
			$.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
				_title: function(title) {
					var $title = this.options.title || '&nbsp;'
					if( ("title_html" in this.options) && this.options.title_html == true )
						title.html($title);
					else title.text($title);
				}
			}));
			function msgDialog(e){
				e.preventDefault();
				var dialog = $( "#fromEdit" ).removeClass('hide').dialog({
					modal: true,
					width:325,
					title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>请选择报表模板</h4></div>",
					title_html: true,
					buttons: [ 
						{
							text: "取消",
							"class" : "btn btn-xs",
							click: function() {
								$( this ).dialog( "close" );
							} 
						},
						{
							text: "保存",
							"class" : "btn btn-primary btn-xs",
							click: function() {
								$( this ).dialog( "close" );
								getDropAfter();
							} 
						}
					]
				});
			}
			
			//当鼠标经过输入框时会删除此span
	        $("#show").on("mouseover", function (){
	        	$(".spanHidden").remove();
	        })
	        
	    </script>
	</body>

</html>

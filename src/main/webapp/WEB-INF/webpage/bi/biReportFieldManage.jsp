<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
  <head>
    <base href="<%=basePath%>">
    <title>BI 元素字段管理</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--  import style	-->
	<jsp:include page="../include/mainHead.jsp"></jsp:include>
  </head>
  <body style="width:97%; margin-left:20px; background:#ffffff; overflow-x: hidden;">
  	<!--  BI Content	-->
  	<div class="row">
  		<!-- datables开始 -->
		<div class="table-header">元素字段设置</div>
		<div class="row">
			<div class="col-md-6" style="margin-left:20px;height:30px; margin-bottom:10px; margin-top:5px;">
				<button class="btn btn-primary btn-sm" id="btnAdd">添加</button>
				<button class="btn btn-primary btn-sm" id="btnEdit">编辑</button>
				<button class="btn btn-primary btn-sm" id="btnDelete">删除</button>
			</div>
			<div class="col-md-7"></div>
		</div>
		<div class="table-responsive">
			<table id="postTable" class="table table-striped table-bordered table-hover"  style="margin-bottom:20px;">
				<thead>
					<tr>
						<th>
							<label>
								<input type="checkbox" class="ace" id="allCheck" />
								<span class="lbl"></span>
							</label>
						</th>
						<th>
							字段名称
						</th>
						<th>
							字段位置
						</th>
						<th>
							维度顺序
						</th>
						<th>
							可见性
						</th>
						<%--新加--%>
						<th>
							字段别名
						</th>
						<th>
							字段标题
						</th>
						<th>
							数据类型
						</th>
						<th>
							字段类型
						</th>
						<th>
							聚合类型
						</th>
						<th>
							单位
						</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
		<!-- datables结束 -->
  	</div>
  	
  	<!--弹出框放置位置  添加 删除  查看详情-->
    <div id="fromEdit" class="hide">
    	<div class="container">
			<div class="row clearfix">
				<div class="col-md-6 column">
					<form class="form-horizontal" role="form">
						<%--<div class="form-group row">
    						 <strong class="control-label" style="text-align: left; float:left; width:78px;" >字段选择：</strong>
							 <select class="form-control" id="field_Id" style="width:200px; float:left;"></select>
							 <font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div> --%>
						<div class="form-group row">
							<strong class="control-label" style="text-align: left; float:left; width:78px;" >字段名称：</strong>
							<select class="form-control" id="field_Name" type="text" style="width:200px; float:left;">
							</select>
							<font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>
						<div class="form-group row">
							<strong class="control-label" style="text-align: left; float:left; width:78px;" >字段别名：</strong>
							<input class="form-control" id="field_Caption" type="text" style="width:200px; float:left;"/>
							<font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>
						<div class="form-group row">
							<strong class="control-label" style="text-align: left; float:left; width:78px;" >字段标题：</strong>
							<input class="form-control" id="field_Title" type="text" style="width:200px; float:left;"/>
							<font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>

						<div class="form-group row">
							<strong class="control-label" style="text-align: left; float:left; width:78px;" >数据类型：</strong>
							<select class="form-control" id="data_Type" style="width:200px; float:left;">
							</select>
							<font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>

						<div class="form-group row">
							<strong class="control-label" style="text-align: left; float:left; width:78px;" >字段类型：</strong>
							<select class="form-control" id="field_Type" style="width:200px; float:left;">
							</select>
							<font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>



        			</form>
				</div>
				<div class="col-md-6 column">
					<form class="form-horizontal" role="form">
						<div class="form-group row">
							<strong class="control-label" style="text-align: left; float:left; width:78px;" >字段位置：</strong>
							<select class="form-control" id="field_Location" style="width:200px; float:left;">
								<option value="1">行维</option>
								<option value="2">列维</option>
								<option value="3">指标</option>
							</select>
							<font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>

						<div class="form-group row" id="dim">
							<strong class="control-label" style="text-align: left; float:left; width:78px;">维度顺序：</strong>
							<input class="form-control" id="dim_Order" style="width:200px; float:left;" type="number" />
							<font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>
						<div class="form-group row">
							<strong class="control-label" style="text-align: left; float:left; width:78px;" >可见性：</strong>
							<select class="form-control" id="display" style="width:200px; float:left;">
								<option value="1">显示</option>
								<option value="0">不显示</option>
							</select>
							<font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>

						<div class="form-group row unit">
							<strong class="control-label" style="text-align: left; float:left; width:78px;" >数据单位：</strong>
							<input class="form-control" id="unit" type="text" style="width:200px; float:left;" value=""/>
							<font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>

						<div class="form-group row dim_Id">
							<strong class="control-label" style="text-align: left; float:left; width:78px;" >对应维表：</strong>
							<select class="form-control" id="dimId" style="width:200px; float:left;">
							</select>
							<font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>

						<div class="form-group row aggregate_Type">
							<strong class="control-label" style="text-align: left; float:left; width:78px;" >聚合类型：</strong>
							<select class="form-control" id="aggregate_Type" style="width:200px; float:left;">
								<option value="0">请选择</option>
								<option value='AVG_'>AVG</option>
								<option value='COUNT_'>COUNT</option>
								<option value='MAX_'>MAX</option>
								<option value='MIN_'>MIN</option>
								<option value='SUM_'>SUM</option>
							</select>
							<font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>
					</form>
				</div>

			</div>
		</div> 
	</div>
  	
  	<!--  import javascript	-->
    <jsp:include page="../include/mainFooter.jsp"></jsp:include>
    
    <script type="text/javascript">
		var langData;
		$.ajax({
			url: "plug-in/ace/adIcon/lang/zh-cn.json",//json文件位置
			async: false,
			type: "GET",//请求方式为get
			dataType: "json", //返回数据格式为json
			success: function(data) {//请求成功完成后要执行的方法
				langData = data;
			}
		});

		$(document).ready(function(){
			loadGrid();
			// loadField();//字段选择
			getDBField(-1);
			getDataType();//数据类型
			getFieldType();//字段类型
			getBiDimName();//获取维表名称
		});

		function loadGrid(){
			var param = {};
			//提示信息
			var lang = {
				"sProcessing": "处理中...",
				"sLengthMenu": "每页 _MENU_ 项",
				"sZeroRecords": "没有匹配结果",
				"sInfo": "当前第 _START_ 至 _END_ 项，共 _TOTAL_ 项。",
				"sInfoEmpty": "当前显示第 0 至 0 项，共 0 项",
				"sInfoFiltered": "(由 _MAX_ 项结果过滤)",
				"sInfoPostFix": "",
				"sSearch": "搜索:",
				"sUrl": "",
				"sEmptyTable": "表中数据为空",
				"sLoadingRecords": "载入中...",
				"sInfoThousands": ",",
				"oPaginate": {
					"sFirst": "首页",
					"sPrevious": "上页",
					"sNext": "下页",
					"sLast": "末页",
					"sJump": "跳转"
				},
				"oAria": {
					"sSortAscending": ": 以升序排列此列",
					"sSortDescending": ": 以降序排列此列"
				}
			};
			//初始化表格
			var table = $("#postTable").dataTable({
				"dom": '<t><"col-md-4"i><"col-md-6"p><"col-md-2"l>',    //为表格元素书写css样式<t>为中间表格  在<t>右边就是在表格下边
				language:lang,  //提示信息
				stripeClasses: ["odd", "even"],  //为奇偶行加上样式，兼容不支持CSS伪类的场合
				serverSide: true,  //启用服务器端分页
				searching: false,  //禁用原生搜索
				bAutoWidth:true, //自适应宽度
				bDestroy:true,//重新加载使用
				renderer: "bootstrap",  //渲染样式：Bootstrap和jquery-ui
				pagingType: "full_numbers",  //分页样式：simple,simple_numbers,full,full_numbers
				ordering:false,
				ajax: function (data, callback, settings) {
					param.rows = data.length;//页面显示记录条数，在页面显示每页显示多少项的时候
					param.start = data.start;//开始的记录序号
					param.page = (data.start / data.length)+1;//当前页码
					param.report_Id = "${param.reportId}";
					//console.log(param);
					//ajax请求数据
					$.ajax({
						type: "POST",
						url: "rest/bi/biReportFieldController/getReportFieldList",
						cache: false,  //禁用缓存
						data: param,  //传入组装的参数
						dataType: "json",
						success: function (result) {
							setTimeout(function () {
								//封装返回数据
								var returnData = {};
								returnData.draw = data.draw;//这里直接自行返回了draw计数器,应该由后台返回
								returnData.recordsTotal = result.total;//返回数据全部记录
								returnData.recordsFiltered = result.total;//后台不实现过滤功能，每次查询均视作全部结果
								returnData.data = result.data;//返回的数据列表
								callback(returnData);
							}, 200);
						}
					});
				},
				columnDefs: [
					{
						"targets": [0], // 目标列位置，下标从0开始
						"data": "report_Field_Id", // 数据列名
						"orderable":false,
						"sWidth":"5%",
						"render": function(data, type, full) { // 返回自定义内容
							return "<label><input type='checkbox' class='ace' id='report_Field_Id' value = '" + data + "' /><span class='lbl' id='report_Field_Id' value = '" + data + "'></span></label>";
						 }
					},
					{
						"targets": [1], // 目标列位置，下标从0开始
						"sWidth":"10%",
						"data": "field_Name"
					},
					{
						"targets": [2], // 目标列位置，下标从0开始
						"sWidth":"10%",
						"data": "field_Location",
						"render": function(data, type, full) { // 返回自定义内容
							var dataname = "";
							switch (data) {
								case 1:
									dataname = "行维";
									break;
								case 2:
									dataname = "列维";
									break;
								case 3:
									dataname = "指标";
									break;
								default:
									dataname = "指标";
									break;
							}
							return dataname;
						 }
					},
					{
						"targets": [3], // 目标列位置，下标从0开始
						"sWidth":"10%",
						"data": "dim_Order" // 数据列名
					},
					{
						"targets": [4], // 目标列位置，下标从0开始
						"sWidth":"10%",
						"data": "display",
						"render": function(data, type, full) { // 返回自定义内容
							var dataname = "";
							switch (data) {
								case 1:
									dataname = "显示";
									break;
								case 0:
									dataname = "不显示";
									break;
							}
							return dataname;
						}
					},
					{
						"targets": [5], // 目标列位置，下标从0开始
						"sWidth":"10%",
						"data": "field_Caption" // 数据列名
					},
					{
						"targets": [6], // 目标列位置，下标从0开始
						"sWidth":"10%",
						"data": "field_Title" // 数据列名
					},
					{
						"targets": [7], // 目标列位置，下标从0开始
						"sWidth":"10%",
						"data": "data_Type_Str" // 数据列名
					},
					{
						"targets": [8], // 目标列位置，下标从0开始
						"sWidth":"10%",
						"data": "field_Type_Str" // 数据列名
					},
					{
						"targets": [9], // 目标列位置，下标从0开始
						"sWidth":"10%",
						"data": "aggregate_Type" // 数据列名
					},
					{
						"targets": [10], // 目标列位置，下标从0开始
						"sWidth":"10%",
						"data": "unit" // 数据列名
					}
				]
			}).api();
			//此处需调用api()方法,否则返回的是JQuery对象而不是DataTables的API对象
		}
		    //复选框全选
			$("#allCheck").on('click' , function(){
				var that = this;
				$(this).closest('table').find('tr > td:first-child input:checkbox')
				.each(function(){
					this.checked = that.checked;
					$(this).closest('tr').toggleClass('selected');
				});
			});
			var par = {};   //声明ajax传输参数的数组变量
			
			//增删改按钮命令
			$("#btnAdd").on("click", function(e){
				par.thisid = this.id;
				$("#field_Id").val(0);
				$("#field_Location").val(1);
				$("#dim_Order").val(1);
				$("#dim").css("display", "block");

				clearInputValue();//清空输入框的数据

				//获取维表名称
				getBiDimName();

				msgDialog(e);
				// getTopicFieldData(e);

				$(".dim_Id").css("display", "none");
				$(".aggregate_Type").css("display", "none");

			});

			//编辑按钮
			$("#btnEdit").on("click", function(e){
				clearInputValue();//清空输入框的数据

				par.thisid = this.id;
				if($("#report_Field_Id:checked").length != 1) {
					parent.parent.bootbox.alert("只能选择一个报表字段进行编辑", function(){});
		        	return;
				}else{
					par.report_Field_Id = $("#report_Field_Id:checked").val();
					getBiDimName();//获取维表名称
					getReportData(e); //点击编辑时根据主键获取到数据进行填充文本框
					// getTopicFieldData(e);
				}
			});

			//删除按钮
			$("#btnDelete").on("click", function(e){
				if($("#report_Field_Id:checked").length <= 0){
					parent.parent.bootbox.alert("请先选择要删除的报表字段", function(){});
					return;
				}else{
					par.report_Field_Ids = [];
					parent.parent.bootbox.confirm("你确定要删除报表字段吗？", function(result) {
						if(result){
							for(var i=0; i<$("#report_Field_Id:checked").length;i++){
								par.report_Field_Ids[i] = $("#report_Field_Id:checked")[i].defaultValue;
								if(par.report_Field_Ids.length < 1){
									parent.parent.bootbox.alert("请先选择要删除的报表字段", function(){});
									return;
								}
				   	        }
				   	        $.ajax({
			    	            url: 'rest/bi/biReportFieldController/deleteReportField',
			    	            async: false,
			    	            data: par,
			    	            type: 'POST',
			    	            dataType: 'json',
			    	            success: function (result) {
			    	                if(result.data == "success"){
			    	                	parent.parent.bootbox.alert("删除成功", function(){});
			    	                	loadGrid();
			   	                	}else{
			   	                		parent.parent.bootbox.alert("删除失败， 失败的报表字段id为："+result.data, function(){});
			   	                	}
			    	            },
			    	            error: function(){
			    	            	parent.parent.bootbox.alert("全部删除失败", function(){});
			    	            }
				   	        });
						}else{
							return;
						}
					});
				}
			});
			

	    	//选择页面下拉框
	    	function loadPage(){
	    		$.ajax({
                   type: "POST",
                   url: "rest/bi/biPageController/getPageList",
                   cache: false,  //禁用缓存
                   dataType: "json",
                   success: function (result) {
                   		$("#bi_Page").empty();
                   		$("#bi_Page").append("<option value='0'>请选择页面</option>");
                   		for(var i=0; i<result.data.length; i++){
                   			$("#bi_Page").append("<option value="+result.data[i].bi_Page_Id+">"+result.data[i].page_Name+"</option>");
                    	}
                   		$("#bi_Page").value(3);
                   }
               });
	    	}
			
			//点击编辑时根据主键获取到数据进行填充文本框
			function getReportData(e){
				par.report_Id = "${param.reportId}";
				//ajax请求数据
				$.ajax({
					type: "POST",
					url: "rest/bi/biReportFieldController/getReportField",
					async: false,
					cache: false,  //禁用缓存
					data: par,  //传入组装的参数
					dataType: "json",
					success: function (result) {
						$("#field_Location").val(result.data.field_Location);
						$("#dim_Order").val(result.data.dim_Order);
						$("#display").val(result.data.display);


						$("#field_Name").val(result.data.field_Name);//字段名称
						$("#field_Caption").val(result.data.field_Caption);//字段别名
						$("#field_Title").val(result.data.field_Title);//字段标题
						$("#data_Type").val(result.data.data_Type);//数据类型（数据库类型）
						$("#field_Type").val(result.data.field_Type);//字段类型（业务类型）
						$("#aggregate_Type").val(result.data.aggregate_Type==0?"":result.data.aggregate_Type);//聚合类型
						$("#unit").val(result.data.unit);//单位

						if(result.data.field_Type == 1){//1：关联唯独表
							$(".dim_Id").css("display", "block");
							$(".aggregate_Type").css("display", "none");
							getBiDimName(result.data.dim_Id);
						}else if(result.data.field_Type == 2){//2：普通字段
							$(".dim_Id").css("display", "none");
							$(".aggregate_Type").css("display", "none");
						}else if(result.data.field_Type == 3){//3：聚合字段
							$(".dim_Id").css("display", "none");
							$(".aggregate_Type").css("display", "block");
							$("#aggregate_Type").val(result.data.aggregate_Type);
						}

						if($("#field_Location").val() == 3){
							$("#dim").css("display", "none");
						}else{
							$("#dim").css("display", "block");
						}
						msgDialog(e);
					}, error: function(){
						parent.parent.bootbox.alert("编辑获取数据失败", function(){});
					}
				});

			}


			//数据类型
			function getDataType(){
				$.ajax({
					type: "POST",
					url: "rest/bi/BITopicFiledController/getDataType",
					cache: false,  //禁用缓存
					dataType: "json",
					success: function (result) {
						$("#data_Type").empty();
						$("#data_Type").append("<option value='0'>请选择</option>");
						for(var i=0; i<result.data.length; i++){
							$("#data_Type").append("<option value="+result.data[i].subid+">"+result.data[i].subname+"</option>");
						}
						// $("#data_Type").val(5);
					},
					error: function(){
						parent.bootbox.alert("字段获取数据失败", function(){});
					}
				});
			}

			//字段类型
			function getFieldType(){
				$.ajax({
					type: "POST",
					url: "rest/bi/BITopicFiledController/getFieldType",
					cache: false,  //禁用缓存
					dataType: "json",
					success: function (result) {
						$("#field_Type").empty();
						$("#field_Type").append("<option value='0'>请选择</option>");
						for(var i=0; i<result.data.length; i++){
							$("#field_Type").append("<option value="+result.data[i].subid+">"+result.data[i].subname+"</option>");
						}
						// $("#field_Type").val(2);
					},
					error: function(){
						parent.bootbox.alert("字段获取数据失败", function(){});
					}
				});
			}
			
			//点击添加
			function addReportData(){
				delete par.report_Field_Id;
				//ajax请求数据
                $.ajax({
                    type: "POST",
                    url: "rest/bi/biReportFieldController/saveReportField",
                    cache: false,  //禁用缓存
                    data: par,  //传入组装的参数
                    dataType: "json",
                    success: function (result) {
                    	if(result.data == "success"){
                    		parent.parent.bootbox.alert("添加成功", function(){});
                    		loadGrid();
                    		$( "#fromEdit" ).dialog( "close" );
                    	}else{
                    		parent.parent.bootbox.alert("添加失败", function(){});
                    	}
                    },
                    error: function(){
                    	parent.parent.bootbox.alert("添加失败", function(){});
                    }
                });
			}
			
			//点击编辑
			function editReportData(){
				//ajax请求数据
                $.ajax({
                    type: "POST",
                    url: "rest/bi/biReportFieldController/updateReportField",
                    cache: false,  //禁用缓存
                    data: par,  //传入组装的参数
                    dataType: "json",
                    success: function (result) {
                    	if(result.data == "success"){
                    		parent.parent.bootbox.alert("更新成功", function(){});
                    		loadGrid();
                    		$( "#fromEdit" ).dialog( "close" );
                    	}else{
                    		parent.parent.bootbox.alert("更新失败", function(){});
                    	}
                    },
                    error: function(){
                    	parent.parent.bootbox.alert("更新失败", function(){});
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
					width:680,
					title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>报表字段设置</h4></div>",
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
								// par.field_Id = $("#field_Id").val();
								par.field_Location = $("#field_Location").val();
								par.dim_Order = $("#dim_Order").val();
                                par.display = $("#display").val();
								par.report_Id = "${param.reportId}";

								//新加
								par.field_Name = $("#field_Name").val();//字段名称
								par.field_Caption = $("#field_Caption").val();//字段别名
								par.field_Title = $("#field_Title").val();//字段标题
								par.data_Type = $("#data_Type").val();//数据类型（数据库类型）
								par.field_Type = $("#field_Type").val();//字段类型（业务类型）
								par.aggregate_Type = $("#aggregate_Type").val()==0?"":$("#aggregate_Type").val();//聚合类型
								par.unit = $("#unit").val();//单位
								par.dim_Id = $("#dimId").val();//维表ID

								if(par.thisid == "btnAdd"){
									addReportData();	
								}else if(par.thisid == "btnEdit"){
									editReportData();
								}
							} 
						}
					]
				});
			}

			//字段位置
			$("#field_Location").change(function(){
				if($("#field_Location").val() == 1 || $("#field_Location").val() == 2){
					$("#dim").css("display", "block");
					$(".unit").css("display", "none");
					$("#dim_Order").val(1);
				}else if($("#field_Location").val() == 3){
					// $("#dim").css("display", "none");
					$("#dim_Order").val(1);
					$("#dim").css("display", "none");
					$(".unit").css("display", "block");
				}

			});



			//加载数据库的表名字
			var json = {};   //设置保存字段名称和字段描述的全局变量中
			function getDBField(value){
				//根据选中的数据表名称加载数据字段
				var fn = "${param.tabName}";
				$.ajax({
					type: "POST",
					url: "rest/bi/BIDimController/getTableData",
					cache: false, //禁用缓存
					data: "tableName="+fn,
					dataType: "json",
					success: function (result) {

						json = result;
						$("#field_Name").html("<option value='0'>请选择</option>");
						for(var i=0; i<result.data.length; i++){
							var txtt = langData.dimManage[fn];
							var txt = "";
							if(typeof(txtt) == "undefined" || txtt == "")
								txt = result.data[i].dim_Field_Name;
							else{
								txt = txtt[result.data[i].dim_Field_Name];
								if(typeof(txt) == "undefined" || txt == "")
									txt = result.data[i].dim_Field_Name;
							}
							if(value == result.data[i].dim_Field_Name){
								$("#field_Name").append("<option selected='selected' value="+result.data[i].dim_Field_Name+">"+txt+"</option>");
							}else{
								console.log()
								$("#field_Name").append("<option value="+result.data[i].dim_Field_Name+">"+txt+"</option>");
							}
						}
					},
					error: function(){
						parent.bootbox.alert("字段获取数据失败", function(){});
					}
				});
			}

		//清空输入框的数据
		function clearInputValue() {
			$("#field_Location").val(0);
			$("#dim_Order").val(1);
			$("#display").val(0);
			$("#field_Name").val(0);//字段名称
			$("#field_Caption").val("");//字段别名
			$("#field_Title").val("");//字段标题
			$("#data_Type").val(0);//数据类型（数据库类型）
			$("#field_Type").val(0);//字段类型（业务类型）
			$("#aggregate_Type").val(0);//聚合类型
			$("#unit").val("");//单位
			// $("#dim_Id").val(0);//维表ID
		}


		//字段类型选择
		$("#field_Type").on("change", function(){
			if($("#field_Type").val() == 1){
				$(".dim_Id").css("display", "block");
				$(".aggregate_Type").css("display", "none");
			}else if($("#field_Type").val() == 3){
				$(".dim_Id").css("display", "none");
				$(".aggregate_Type").css("display", "block");
			}else if($("#field_Type").val() == 2 || $("#field_Type").val() == 0){
				$(".dim_Id").css("display", "none");
				$(".aggregate_Type").css("display", "none");
			}
		});

		//获取维表名称
		function getBiDimName(value){
			//ajax请求数据
			$.ajax({
				type: "POST",
				url: "rest/bi/BITopicFiledController/getBiDimName",
				cache: false,  //禁用缓存
				dataType: "json",
				success: function (result) {
					$("#dimId").html()
					$("#dimId").html("<option value='0'>请选择</option>");
					for(var i=0; i<result.data.length; i++){
						$("#dimId").append("<option value='"+result.data[i].dim_Id+"'>"+result.data[i].dim_Name+"</option>");
					}

					value==null?"":$("#dimId").val(value);

				},
				error: function(){
					parent.bootbox.alert("获取失败", function(){});
				}
			});
		}
    </script>
  </body>
</html>

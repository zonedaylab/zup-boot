<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>BI 主题字段管理 </title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--  import style	-->
	<jsp:include page="../include/mainHead.jsp"></jsp:include>
	<style type="text/css">
		td{
			font-size:12px;
		}
	</style>
  </head>
  
  <body style="width:98%; margin-left:10px; background:#ffffff; overflow-x: hidden;">
    
  	<!--  BI Content	-->
  	<div class="row">
  		<!-- datables开始 -->
		<div class="table-header">主题设置</div>
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
							字段别名
						</th>
						<th>
							字段标题
						</th>
						<th>
							对应维表
						</th>
						<th>
							字段类型
						</th>
						<th>
							聚合类型
						</th>
						<th>
							数据类型
						</th>
						<th>
							单位
						</th>
<!-- 						<th> -->
<!-- 							长度 -->
<!-- 						</th> -->
<!-- 						<th> -->
<!-- 							小数 -->
<!-- 						</th> -->
<!-- 						<th> -->
<!-- 							允许为空 -->
<!-- 						</th> -->
<!-- 						<th> -->
<!-- 							是否唯一 -->
<!-- 						</th> -->
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
				<div class="col-md-12 column">
					<form class="form-horizontal" role="form">
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
    						 <strong class="control-label" style="text-align: left; float:left; width:78px;" >数据单位：</strong>
							 <input class="form-control" id="field_Unit" type="text" style="width:200px; float:left;" value="数量"/>
							 <font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>
<!-- 						<div class="form-group row"> -->
<!--     						 <strong class="control-label" style="text-align: left; float:left; width:78px;" >字段长度：</strong> -->
<!-- 							 <input class="form-control" id="field_Length" type="number" style="width:200px; float:left;" value="10"/> -->
<!-- 							 <font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font> -->
<!-- 						</div> -->
<!-- 						<div class="form-group row"> -->
<!--     						 <strong class="control-label" style="text-align: left; float:left; width:78px;" >字段小数：</strong> -->
<!-- 							 <input class="form-control" id=field_Decimal type="number" style="width:200px; float:left;" value="0"/> -->
<!-- 							 <font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font> -->
<!-- 						</div> -->
<!-- 						<div class="form-group row"> -->
<!--     						 <strong class="control-label" style="text-align: left; float:left; width:78px;" >是否唯一：</strong> -->
<!-- 							 <select class="form-control" id="field_Identity" style="width:200px; float:left;"> -->
<!-- 							 </select> -->
<!-- 							 <font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font> -->
<!-- 						</div>  -->
<!-- 						<div class="form-group row"> -->
<!--     						 <strong class="control-label" style="text-align: left; float:left; width:78px;" >是否为空：</strong> -->
<!-- 							 <select class="form-control" id="field_Null" style="width:200px; float:left;"> -->
<!-- 							 </select> -->
<!-- 							 <font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font> -->
<!-- 						</div>  -->
						<div class="form-group row">
    						 <strong class="control-label" style="text-align: left; float:left; width:78px;" >字段类型：</strong>
							 <select class="form-control" id="field_Type" style="width:200px; float:left;">
							 </select>
							 <font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div> 
						<div class="form-group row dim_Id">
    						 <strong class="control-label" style="text-align: left; float:left; width:78px;" >对应维表：</strong>
							 <select class="form-control" id="dim_Id" style="width:200px; float:left;">
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
   			loadGrid(); //加载数据
   			getDataType(); //加载数据类型
			getFieldType(); //加载字段类型
		    getSF();
		    getBiDimName();
   		});
   		
   		$(window).resize(function(){
   			loadGrid();
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
	                //console.log(param);
	                //ajax请求数据
	                param.topicId = "${ topicId}";
	                $.ajax({
	                    type: "POST",
	                    url: "rest/bi/BITopicFiledController/girdTopicFieldList",
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
				        "data": "field_Id", // 数据列名
				        "orderable":false,
				        "sWidth":"15px",
				        "render": function(data, type, full) { // 返回自定义内容
				       		return "<label><input type='checkbox' class='ace' id='title_Field_Id' value = '" + data + "' /><span class='lbl' id='title_Field_Id' value = '" + data + "'></span></label>";
				         }
                    },
                    {
					  	"targets": [1], // 目标列位置，下标从0开始
					  	"sWidth":"15%",
					   	"data": "field_Name"
                    },
                    {
					  	"targets": [2], // 目标列位置，下标从0开始
					  	"sWidth":"15%",
					   	"data": "field_Caption"
                    },
                    {
					   	"targets": [3], // 目标列位置，下标从0开始
					   	"sWidth":"15%",
					   	"data": "field_Title" // 数据列名
                    },
                    {
					  	"targets": [4], // 目标列位置，下标从0开始
					  	"sWidth":"15%",
					   	"data": "dim_Name"
                    },
                    {
					   	"targets": [5], // 目标列位置，下标从0开始
					   	"sWidth":"10%",
					   	"data": "field_Type_Str" // 数据列名
                    },
                    {
					  	"targets": [6], // 目标列位置，下标从0开始
					  	"sWidth":"10%",
					   	"data": "aggregate_Type", // 数据列名
					   	"render": function(data, type, full) { // 返回自定义内容
	                    	if(data !=null && data!=""){
                                return data;
                            }else{
                                return "";
                            }
				         }
                    },
                    {
					   	"targets": [7], // 目标列位置，下标从0开始
					   	"sWidth":"10%",
					   	"data": "data_Type_Str" // 数据列名
                    },
                    {
					  	"targets": [8], // 目标列位置，下标从0开始
					  	"sWidth":"10%",
					   	"data": "field_Unit"
                    },
                   /* {
					  	"targets": [9], // 目标列位置，下标从0开始
					  	"sWidth":"8%",
					   	"data": "field_Length"
                    },
                    {
					  	"targets": [10], // 目标列位置，下标从0开始
					  	"sWidth":"8%",
					   	"data": "field_Decimal"
                    },
                    {
					   	"targets": [11], // 目标列位置，下标从0开始
					   	"sWidth":"8%",
					   	"data": "field_Null_Str" // 数据列名
                    },
                    {
					   	"targets": [12], // 目标列位置，下标从0开始
					   	"sWidth":"8%",
					   	"data": "field_Identity" // 数据列名
                    }*/
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
	</script>
	<script type="text/javascript">
		var par = {};   //声明ajax传输参数的数组变量
		
		//增删改按钮命令
		$("#btnAdd").on("click", function(e){
			getDBField(0);
			par.thisid = this.id;  //区别是添加还是编辑
			msgDialog(e);
			$(".dim_Id").css("display", "none");
			$(".aggregate_Type").css("display", "none");
		});
		
		
		$("#btnEdit").on("click", function(e){
			par.thisid = this.id;
			if($("#title_Field_Id:checked").length != 1){
				parent.bootbox.alert("只能选择一个字段进行编辑", function(){});
	        	return;
			}else{
				par.field_Id = $("#title_Field_Id:checked").val();
				getTopicFieldData(e);
			}
		});
		$("#btnDelete").on("click", function(e){
			if($("#title_Field_Id:checked").length <= 0){
				parent.bootbox.alert("请先选择要删除的字段", function(){});
				return;
			}else{
				par.titleIds = [];
				parent.bootbox.confirm("你确定要删除字段吗？", function(result) {
					if(result){
						for(var i=0; i<$("#title_Field_Id:checked").length;i++){
							par.titleIds[i] = $("#title_Field_Id:checked")[i].defaultValue;
							if(par.titleIds.length < 1){
								parent.bootbox.alert("请先选择要删除的字段", function(){});
								return;
							}
			   	        }
			   	        $.ajax({
		    	            url: 'rest/bi/BITopicFiledController/deleteTopicFieldData',
		    	            async: false,
		    	            data: par,
		    	            type: 'POST',
		    	            dataType: 'json',
		    	            success: function (result) {
		    	                if(result.data == "success"){
		    	                	parent.bootbox.alert("删除成功", function(){});
		    	                	loadGrid();
		   	                	}else{
		   	                		parent.bootbox.alert("删除失败， 失败的主题id为："+result.data, function(){});
		   	                	}
		    	            },
		    	            error: function(){
		    	            	parent.bootbox.alert("全部删除失败", function(){});
		    	            }
			   	        });
					}else{
						return;
					}
				});
			}
		});
		
		//填充聚合类型下拉框
		function getADBField(value){
			//ajax请求数据
               $.ajax({
                   type: "POST",
                   url: "rest/bi/BITopicFiledController/getAggregateField",
                   cache: false,  //禁用缓存
                   data: "topic_Id=${ topicId}",  //传入组装的参数
                   dataType: "json",
                   success: function (result) {
                   	$("#aggregateField").html("<option value='0'>请选择</option>");
                   	for(var i=0; i<result.data.length; i++){
						if(value == result.data[i].dim_Field_Name){
							$("#aggregateField").append("<option selected='selected' value="+result.data[i].dim_Field_Name+">"+result.data[i].dim_Field_Name+"</option>");
							disType(false);
						}else{
							$("#aggregateField").append("<option value="+result.data[i].dim_Field_Name+">"+result.data[i].dim_Field_Name+"</option>");
						}
					}
                   },
                   error: function(){
                   	parent.bootbox.alert("字段获取数据失败", function(){});
                   }
               });
		}
		
		
		//点击编辑时根据topicId获取数据填充到编辑框
		function getTopicFieldData(e){
			par.topic_Id = "${param.topicId}";
			//ajax请求数据
               $.ajax({
                   type: "POST",
                   url: "rest/bi/BITopicFiledController/getTopicFieldData",
                   cache: false,  //禁用缓存
                   data: par,  //传入组装的参数
                   dataType: "json",
                   success: function (result) {
                   	$("#data_Type").val(result.data[0].data_Type);
                   	$("#field_Type").val(result.data[0].field_Type);
					$("#field_Length").val(result.data[0].field_Length);
					$("#field_Decimal").val(result.data[0].field_Decimal); 
					$("#field_Null").val(result.data[0].field_Null);
					$("#field_Identity").val(result.data[0].field_Identity);
					$("#field_Title").val(result.data[0].field_Title);
					$("#field_Unit").val(result.data[0].field_Unit);
					getDBField(result.data[0].field_Name);
					$("#field_Caption").val(result.data[0].field_Caption);
					if($("#field_Type").val() == 1){
						$(".dim_Id").css("display", "block");
						$(".aggregate_Type").css("display", "none");
						$("#dim_Id").val(result.data[0].dim_Id);
					}else if($("#field_Type").val() == 2){
						$(".dim_Id").css("display", "none");
						$(".aggregate_Type").css("display", "none");
					}else if($("#field_Type").val() == 3){
						$(".dim_Id").css("display", "none");
						$(".aggregate_Type").css("display", "block");
						$("#aggregate_Type").val(result.data[0].aggregate_Type);
					}
                   	msgDialog(e);
                   },
                   error: function(){
                   	parent.bootbox.alert("编辑获取数据失败", function(){});
                   }
               });
		}
		
		//点击添加
		function addTopicFieldData(){
			//ajax请求数据
               $.ajax({
                   type: "POST",
                   url: "rest/bi/BITopicFiledController/addTopicFieldData",
                   cache: false,  //禁用缓存
                   data: par,  //传入组装的参数
                   dataType: "json",
                   success: function (result) {
                   	if(result.data == "success"){
                   		parent.bootbox.alert("添加成功", function(){});
                   		loadGrid();
                   		$( "#fromEdit" ).dialog( "close" );
                   	}else{
                   		parent.bootbox.alert("添加失败", function(){});
                   	}
                   },
                   error: function(){
                   	parent.bootbox.alert("添加失败", function(){});
                   }
               });
		}
		
		//点击编辑
		function editTopicFieldData(){
			//ajax请求数据
               $.ajax({
                   type: "POST",
                   url: "rest/bi/BITopicFiledController/editTopicFieldData",
                   cache: false,  //禁用缓存
                   data: par,  //传入组装的参数
                   dataType: "json",
                   success: function (result) {
                   	if(result.data == "success"){
                   		parent.bootbox.alert("更新成功", function(){});
                   		loadGrid();
                   		$( "#fromEdit" ).dialog( "close" );
                   	}else{
                   		parent.bootbox.alert("更新失败", function(){});
                   	}
                   },
                   error: function(){
                   	parent.bootbox.alert("更新失败", function(){});
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
				title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>主题设置</h4></div>",
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
							par.topic_Id = "${ topicId}";
							par.field_Type = $("#field_Type").val();
							par.data_Type = $("#data_Type").val();
							par.field_Length = 10;
							par.field_Decimal = 4; 
							par.field_Null = 1;
							par.field_Identity = 1;
							par.field_Name = $("#field_Name").val();
							par.field_Caption = $("#field_Caption").val();
							par.field_Title = $("#field_Title").val();
							par.field_Unit = $("#field_Unit").val();
							if(par.field_Type == 1){
								par.dim_Id = $("#dim_Id").val();
							}else{
								delete par.dim_Id;
							}
							if(par.field_Type == 3){
								par.aggregate_Type = $("#aggregate_Type").val();
							}else{
								delete par.aggregate_Type;
							}
							console.log(par); 
							if(par.thisid == "btnAdd"){
								addTopicFieldData();	
							}else if(par.thisid == "btnEdit"){
								editTopicFieldData();
							}
						} 
					}
				]
			});
		}
		
		//获取维表名称
		function getBiDimName(){
			//ajax请求数据
		   $.ajax({
			   type: "POST",
			   url: "rest/bi/BITopicFiledController/getBiDimName",
			   cache: false,  //禁用缓存
			   dataType: "json",
			   success: function (result) {
				$("#dim_Id").html("<option value='0'>请选择</option>");
				for(var i=0; i<result.data.length; i++){
					$("#dim_Id").append("<option value="+result.data[i].dim_Id+">"+result.data[i].dim_Name+"</option>");
				}
			   },error: function(){
				parent.bootbox.alert("获取失败", function(){});
			   }
		   });
		}
		
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
							$("#field_Name").append("<option value="+result.data[i].dim_Field_Name+">"+txt+"</option>");
						}
					}
                   },
                   error: function(){
                   	parent.bootbox.alert("字段获取数据失败", function(){});
                   }
               });
		}
		
		$("#field_Name").on("change",  function(){
			$("#field_Title").val($("#field_Name option:selected").text());
			$("#field_Caption").val($("#field_Name").val());
		});
		
		$("#field_Type").on("change", function(){
			if($("#field_Type").val() == 1){
				$(".dim_Id").css("display", "block");
				$(".aggregate_Type").css("display", "none");
			}else if($("#field_Type").val() == 3){
				$(".dim_Id").css("display", "none");
				$(".aggregate_Type").css("display", "block");
			}else if($("#field_Type").val() == 2){
				$(".dim_Id").css("display", "none");
				$(".aggregate_Type").css("display", "none");
			}
		});
		
		function getDataType(){
			$.ajax({
                   type: "POST",
                   url: "rest/bi/BITopicFiledController/getDataType",
                   cache: false,  //禁用缓存
                   dataType: "json",
                   success: function (result) {
                   	$("#data_Type").empty();
                   	for(var i=0; i<result.data.length; i++){
                   		$("#data_Type").append("<option value="+result.data[i].subid+">"+result.data[i].subname+"</option>");
					}
                   	$("#data_Type").val(5);
                   },
                   error: function(){
                   	parent.bootbox.alert("字段获取数据失败", function(){});
                   }
               });
		}
		
		function getSF(){
			$.ajax({
                   type: "POST",
                   url: "rest/bi/BITopicFiledController/getShiFou",
                   cache: false,  //禁用缓存
                   dataType: "json",
                   success: function (result) {
                   	$("#field_Identity").empty();
                   	$("#field_Null").empty();
                   	for(var i=0; i<result.data.length; i++){
                   		$("#field_Identity").append("<option value="+result.data[i].subid+">"+result.data[i].subname+"</option>");
                   		$("#field_Null").append("<option value="+result.data[i].subid+">"+result.data[i].subname+"</option>");
					}
                   },
                   error: function(){
                   	parent.bootbox.alert("字段获取数据失败", function(){});
                   }
               });
		}
		
		function getFieldType(){
			$.ajax({
                   type: "POST",
                   url: "rest/bi/BITopicFiledController/getFieldType",
                   cache: false,  //禁用缓存
                   dataType: "json",
                   success: function (result) {
                   	$("#field_Type").empty();
                   	for(var i=0; i<result.data.length; i++){
                   		$("#field_Type").append("<option value="+result.data[i].subid+">"+result.data[i].subname+"</option>");
					}
                   	$("#field_Type").val(2);
                   },
                   error: function(){
                   	parent.bootbox.alert("字段获取数据失败", function(){});
                   }
               });
		}
    </script>
  </body>
</html>

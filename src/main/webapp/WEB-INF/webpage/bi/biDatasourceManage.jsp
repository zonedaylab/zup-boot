<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
  <head>
    <base href="<%=basePath%>">
    <title>BI 数据源管理</title>
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
		<div class="table-header">数据源设置</div>
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
							数据源名称
						</th>
						<th>
							IP地址
						</th>
						<th>
							用户名
						</th>
						<th>
							密码
						</th>
						<th>
							创建时间
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
				<div class="col-md-12 column">
					<form class="form-horizontal" role="form">
						<div class="form-group row">
							<strong class="control-label" style="text-align: left; float:left; width:98px;" >IP地址：</strong>
							<input class="form-control" id="ds_ip" type="text" style="width:180px; float:left;"/><font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>
						<div class="form-group row">
							<strong class="control-label" style="text-align: left; float:left; width:98px;" >端口号：</strong>
							<input class="form-control" id="ds_port" type="text" style="width:180px; float:left;"/><font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>
						<div class="form-group row">
							<strong class="control-label" style="text-align: left; float:left; width:98px;" >用户名：</strong>
							<input class="form-control" id="ds_username" type="text" style="width:180px; float:left;"/><font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>

						<div class="form-group row">
							<strong class="control-label" style="text-align: left; float:left; width:98px;" >密码：</strong>
							<input class="form-control" id="ds_password" type="text" style="width:180px; float:left;"/><font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>

						<div class="form-group row">
							<strong class="control-label" style="text-align: left; float:left; width:98px;" >连接配置：</strong>
							<input class="form-control" id="ds_attr" type="text" style="width:180px; float:left;"/><font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>

						<div class="form-group row">
    						 <strong class="control-label" style="text-align: left; float:left; width:98px;" >数据源名称：</strong>
							 <input class="form-control" id="ds_name" type="text" style="width:180px; float:left;"/><font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>

						<div class="form-group row">
							<strong class="control-label" style="text-align: left; float:left; width:98px;" >数据源地址：</strong>
							<input class="form-control" id="ds_dir" type="text" style="width:180px; float:left;"/><font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>



        			</form>
				</div> 
			</div>
		</div> 
	</div>
  	
  	<!--  import javascript	-->
    <jsp:include page="../include/mainFooter.jsp"></jsp:include>
    
    <script type="text/javascript">
    		$(document).ready(function(){
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
		                $.ajax({
		                    type: "POST",
		                    url: "rest/bi/BIDatasourceController/getDatasourceList",
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
					        "data": "id", // 数据列名
					        "orderable":false,
					        "sWidth":"15px",
					        "render": function(data, type, full) { // 返回自定义内容
					       		return "<label><input type='checkbox' class='ace' id='id' value = '" + data + "' /><span class='lbl' id='id' value = '" + data + "'></span></label>";
					         }
	                    },
	                    {
						  	"targets": [1], // 目标列位置，下标从0开始
						  	"sWidth":"20%",
						   	"data": "ds_name"
	                    },
	                    {
						  	"targets": [2], // 目标列位置，下标从0开始
						  	"sWidth":"20%",
						   	"data": "ds_ip"
	                    },
	                    {
						   	"targets": [3], // 目标列位置，下标从0开始
						   	"sWidth":"20%",
						   	"data": "ds_username" // 数据列名
	                    },
	                    {
						   	"targets": [4], // 目标列位置，下标从0开始
						   	"sWidth":"20%",
						   	"data": "ds_password" // 数据列名
	                    },
	                    {
						   	"targets": [5], // 目标列位置，下标从0开始
						   	"sWidth":"20%",
						   	"data": "ds_create_time" // 数据列名
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
				msgDialog(e);
			});
			
			$("#btnEdit").on("click", function(e){
				par.thisid = this.id;
				if($("#id:checked").length != 1) {
					parent.parent.bootbox.alert("只能选择一个报表进行编辑", function(){});
		        	return;
				}else{
					par.id = $("#id:checked").val();
					getReportData(e);
				}
			});
			
			$("#btnDelete").on("click", function(e){
				if($("#id:checked").length <= 0){
					parent.parent.bootbox.alert("请先选择要删除的报表", function(){});
					return;
				}else{
					par.ids = [];
					parent.parent.bootbox.confirm("你确定要删除报表吗？", function(result) {
						if(result){
							for(var i=0; i<$("#id:checked").length;i++){
								par.ids[i] = $("#id:checked")[i].defaultValue;
								if(par.ids.length < 1){
									parent.parent.bootbox.alert("请先选择要删除的报表", function(){});
									return;
								}
				   	        }
				   	        $.ajax({
			    	            url: 'rest/bi/BIDatasourceController/deleteDatasource',
			    	            async: false,
			    	            data: par,
			    	            type: 'POST',
			    	            dataType: 'json',
			    	            success: function (result) {
			    	                if(result.data == "success"){
			    	                	parent.parent.bootbox.alert("删除成功", function(){});
			    	                	loadGrid();
			   	                	}else{
			   	                		parent.parent.bootbox.alert("删除失败， 失败的报表id为："+result.data, function(){});
			   	                	}
			    	            },
			    	            error: function(){
			    	            	parent.parent.bootbox.alert("删除失败", function(){});
			    	            }
				   	        });
						}else{
							return;
						}
					});
				}
			});
			

			

			
			//点击编辑时根据主键获取到数据进行填充文本框
			function getReportData(e){
				//ajax请求数据
                $.ajax({
                    type: "POST",
                    url: "rest/bi/BIDatasourceController/getDatasourceInfo",
                    cache: false,  //禁用缓存
                    data: par,  //传入组装的参数
                    dataType: "json",
                    success: function (result) {
                    	$("#ds_ip").val(result.data.ds_ip);
						$("#ds_port").val(result.data.ds_port);
						$("#ds_username").val(result.data.ds_username);
						$("#ds_password").val(result.data.ds_password);
						$("#ds_attr").val(result.data.ds_attr);
						$("#ds_name").val(result.data.ds_name);
						$("#ds_dir").val(result.data.ds_dir);
                    	msgDialog(e);
                    },
                    error: function(){
                    	parent.parent.bootbox.alert("编辑获取数据失败", function(){});
                    }
                });
			}
			
			//点击添加
			function addReportData(){
				//ajax请求数据
                $.ajax({
                    type: "POST",
					url: "rest/bi/BIDatasourceController/saveDatasource",
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
                    url: "rest/bi/BIDatasourceController/updateDatasource",
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
					width:325,
					title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>报表设置</h4></div>",
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
								par.ds_name = $("#ds_name").val();
								par.ds_ip = $("#ds_ip").val();
								par.ds_port = $("#ds_port").val();
								par.ds_attr = $("#ds_attr").val();
								par.ds_username = $("#ds_username").val();
								par.ds_password = $("#ds_password").val();
								par.ds_dir = $("#ds_dir").val();

								if(par.thisid == "btnAdd"){
									addReportData();	
								}else if(par.thisid == "btnEdit"){
									par.bi_Page_Id = $("#bi_Page_Id").val();
									editReportData();
								}
							} 
						}
					]
				});
			}
			
			//报表字段管理按钮
			$("#btnValSetting").on("click", function(){
				var id = 0;
				if($("#id:checked").length != 1) {
					parent.parent.bootbox.alert("只能选择一个报表进行编辑", function(){});
		        	return;
				}else{
					id = $("#id:checked").val();
					window.open("rest/bi/biReportFieldController?reportId="+id, '报表字段设置', 'height=650,width=1200,top=200,left=50,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
				}
			});
			
    </script>
  </body>
</html>

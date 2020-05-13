<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
  <head>
    <base href="<%=basePath%>">
    <title>BI维度管理</title>
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
		<div class="table-header">维度管理</div>
		<div class="row">
			<div class="col-md-6" style="margin-left:20px;height:30px; margin-bottom:10px; margin-top:5px;">
				<button class="btn btn-primary btn-sm" id="btnAdd">添加</button>
				<button class="btn btn-primary btn-sm" id="btnEdit">编辑</button>
				<button class="btn btn-primary btn-sm" id="btnDelete">删除</button>
				<%--数据源：<select id="ds" style="width: 100px;"></select>--%>
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
							维度名称
						</th>
						<th>
							数据库表
						</th>
 						<th>
							ID字段 
						</th>
						<th>
							文字字段
						</th>
						<th>
							钻取类型
						</th>
						<th>
							钻取信息
						</th>
						<th>
							数据源
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
						<%--<div class="form-group row">
							<strong class="control-label" style="text-align: left; float:left; width:98px;">数据源：</strong>
							<select class="form-control" id="ds_Id" style="width:180px; float:left;"></select>
						</div>--%>
						<div class="form-group row">
							<strong class="control-label" style="text-align: left; float:left; width:98px;" >维表名称：</strong>
							<input class="form-control" id="dim_Name" type="text" style="width:180px; float:left;"/><font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>
						<div class="form-group row">
							<strong class="control-label" style="text-align: left; float:left; width:98px;">数据表：</strong>
							<select class="form-control" id="biz_Table_Name" style="width:180px; float:left;"></select>
							<font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>
						<div class="form-group row">
							<strong class="control-label" style="text-align: left; float:left; width:98px;">ID字段：</strong>
							<select class="form-control" id="id_Field" style="width:180px; float:left;"></select>
							<font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>
						<div class="form-group row">
							<strong class="control-label" style="text-align: left; float:left; width:98px;">文字字段：</strong>
							<select class="form-control" id="text_Field" style="width:180px; float:left;"></select>
							<font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>
						<div class="form-group row">
							<strong class="control-label" style="text-align: left; float:left; width:98px;">钻取类型：</strong>
							<select class="form-control" id="drill_Type" style="width:180px; float:left;">
								<option value="1">无层次结构</option>
								<option value="2">分段信息</option>
								<option value="3">钻取路径</option>
								<option value="4">钻取不同主题</option>

							</select>
							<font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>
						<div class="form-group row" id="drill" >
							<strong class="control-label" style="text-align: left; float:left; width:98px;">钻取信息：</strong>
							<input class="form-control" id="drill_Info" type="text" style="width:180px; float:left;"/>
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

   			//添加-->维表设置-->钻取信息：默认不显示
			$("#drill").css("display", "none");


			//加载主页数据源
			// loadMainDsList();
			//加载表格数据
   			loadGrid();
			// loadDsList();
			// loadTableName();
   		});

   		//加载主页数据源
		function loadMainDsList(){
			$.ajax({
				url: "rest/bi/BIDatasourceController/getDsList",
				async: true,
				type: "GET",//请求方式为get
				dataType: "json", //返回数据格式为json
				success: function(data) {//请求成功完成后要执行的方法
					$("#ds").empty();
					$("#ds").append("<option value='0'>全部</option>");
					for (var i = 0; i < data.data.length; i++) {
						$("#ds").append("<option value='"+data.data[i].id+"'>"+data.data[i].ds_name+"</option>");
					}
				}
			});
		}

		//加载编辑或添加时的数据源
   		function loadDsList(dsId){
			$.ajax({
				url: "rest/bi/BIDatasourceController/getDsList",
				async: true,
				type: "GET",//请求方式为get
				dataType: "json", //返回数据格式为json
				success: function(data) {//请求成功完成后要执行的方法
					$("#ds_Id").empty();
					$("#ds_Id").append("<option value='0'>全部</option>");
					for (var i = 0; i < data.data.length; i++) {
						$("#ds_Id").append("<option value='"+data.data[i].id+"'>"+data.data[i].ds_name+"</option>");
					}

					$("#ds_Id").val(dsId);//回显数据
				}
			});
		}

		$("#ds").change(function () {
			loadGrid();
		});

		//加载表格数据
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
					if($("#ds option:selected").val() != 0){
						param.ds_Id = $("#ds option:selected").val();
					}
	                console.log(param);
	                //ajax请求数据
	                $.ajax({
	                    type: "POST",
	                    url: "rest/bi/BIDimController/girdDimList",
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
				        "data": "dim_Id", // 数据列名
				        "orderable":false,
				        "sWidth":"10px",
				        "render": function(data, type, full) { // 返回自定义内容
				       		return "<label><input type='checkbox' class='ace' id='dim_Id' value = '" + data + "' /><span class='lbl' id='dim_Id' value = '" + data + "'></span></label>";
				         }
                    },
                    {
					  	"targets": [1], // 目标列位置，下标从0开始
					  	"sWidth":"20%",
					   	"data": "dim_Name"
                    },
                    {
					  	"targets": [2], // 目标列位置，下标从0开始
					  	"sWidth":"15%",
					   	"data": "biz_Table_Name"
                    },
                    {
					  	"targets": [3], // 目标列位置，下标从0开始
					  	"sWidth":"10%",
					   	"data": "id_Field"
                    },       {
					  	"targets": [4], // 目标列位置，下标从0开始
					  	"sWidth":"15%",
					   	"data": "text_Field"
                    },       {
					  	"targets": [5], // 目标列位置，下标从0开始
					  	"sWidth":"10%",
					   	"data": "drill_Type",
						"render": function(data, type, full) { // 返回自定义内容
					  		switch (data) {
								case 1:
									return "";
							}
							return "";
						}
                    },
                    {
					   	"targets": [6], // 目标列位置，下标从0开始
					   	"sWidth":"15%",
					   	"data": "drill_Info" // 数据列名
                    },
                    {
					   	"targets": [7], // 目标列位置，下标从0开始
					   	"sWidth":"10%",
					   	"data": "ds_name" // 数据列名
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
			//加载编辑或添加时的数据源
			// loadDsList();

			//加载表名
			loadTableName();

			msgDialog(e, 1);
		});

		//编辑维度
		$("#btnEdit").on("click", function(e){
			//加载编辑或添加时的数据源
			// loadDsList();

			//加载表名
			loadTableName();

			//加setTimeout只是为了先让加载加载表名然后加载数据的时候，直接填充就好了
			setTimeout(function(){
				$.ajax({
					type: "GET",
					url: "rest/bi/BIDimController/getDim",
					cache: false,  //禁用缓存
					data: "dimId="+$("#dim_Id:checked").val(),  //传入组装的参数
					dataType: "json",
					success: function (result) {
						$("#dim_Name").val(result.data.dim_Name);
						$("#biz_Table_Name").val(result.data.biz_Table_Name);
						$("#drill_Type").val(result.data.drill_Type);
						$("#drill_Info").val(result.data.drill_Info);
						$("#ds_Id").val(result.data.ds_Id);
						//加载编辑或添加时的数据源
						loadDsList(result.data.ds_Id);

						//加载 维度设置的ID字段和文字字段
						loadFaild(result.data.id_Field,result.data.text_Field);


						if(result.data.drill_Type == 1){
							$("#drill").css("display", "none");
						}else{
							$("#drill").css("display", "block");
						}
						msgDialog(e, 2);



					},
					error: function(){
						parent.parent.bootbox.alert("获取失败", function(){});
					}
				});

			},100)


		});

		$("#btnDetail").on("click", function(){
			window.open("rest/bi/BIDimController/biDimSet?dimId="+ $("#dim_Id:checked").val(), '维度设置', 'height=650,width=1200,top=200,left=200,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
		});
			
		$("#btnDelete").on("click", function(e){
			if($("#dim_Id:checked").length <= 0){
				parent.parent.bootbox.alert("请先选择要删除的维度", function(){});
				return;
			}else{
				par.dim_Ids = [];
				parent.parent.bootbox.confirm("你确定要删除维度吗？", function(result) {
					if(result){
						for(var i=0; i<$("#dim_Id:checked").length;i++){
							par.dim_Ids[i] = $("#dim_Id:checked")[i].defaultValue;
							if(par.dim_Ids.length < 1){
								parent.parent.bootbox.alert("请先选择要删除的维度", function(){});
								return;
							}
			   	        }
			   	        $.ajax({
		    	            url: 'rest/bi/BIDimController/deleteDimData',
		    	            async: false,
		    	            data: par,
		    	            type: 'POST',
		    	            dataType: 'json',
		    	            success: function (result) {
		    	                if(result.data == "success"){
		    	                	if(result.mes=="")

		    	                	parent.parent.bootbox.alert("删除成功", function(){});

		    	                	else
									parent.parent.bootbox.alert("删除成功,但其中有已经进行了主题关联，删除主题后再进行维度删除，关联的维度ID为："+result.mes, function(){});

		    	                		loadGrid();
		   	                	}else{
									if(result.mes=="")
										parent.parent.bootbox.alert("删除失败， 失败的维度id为："+result.data, function(){});

									else

									parent.parent.bootbox.alert("该维度已经关联主题，请先删除主题后再进行删除！", function(){});

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

		//弹出框样式
		$.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
			_title: function(title) {
				var $title = this.options.title || '&nbsp;'
				if( ("title_html" in this.options) && this.options.title_html == true )
					title.html($title);
				else title.text($title);
			}
		}));

		function msgDialog(e, type){
			e.preventDefault();
			var dialog = $( "#fromEdit" ).removeClass('hide').dialog({
				modal: true,
				width:325,
				title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>维表设置</h4></div>",
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
							var pd = {};
							pd.dim_Name = $("#dim_Name").val();
							pd.biz_Table_Name = $("#biz_Table_Name").val();
							pd.text_Field = $("#text_Field").val();
							pd.id_Field = $("#id_Field").val();
							pd.drill_Type = $("#drill_Type").val();
							pd.drill_Info = $("#drill_Info").val();
							pd.ds_Id = $("#ds_Id").val();
							if(type == 1){
								$.ajax({
									type: "POST",
									url: "rest/bi/BIDimController/saveDim",
									cache: false,  //禁用缓存
									data: pd,  //传入组装的参数
									dataType: "json",
									success: function (result) {
										if(result.info == "success"){
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
							}else{
								pd.dim_Id = $("#dim_Id:checked").val();
								$.ajax({
									type: "POST",
									url: "rest/bi/BIDimController/updateDim",
									cache: false,  //禁用缓存
									data: pd,  //传入组装的参数
									dataType: "json",
									success: function (result) {
										if(result.info == "success"){
											parent.parent.bootbox.alert("编译成功", function(){});
											loadGrid();
											$( "#fromEdit" ).dialog( "close" );
										}else{
											parent.parent.bootbox.alert("编译失败", function(){});
										}
									},
									error: function(){
										parent.parent.bootbox.alert("编译失败", function(){});
									}
								});
							}
						}
					}
				]
			});
		}

		//加载数据库表名
		function loadTableName(){
			$.ajax({
				type: "POST",
				url: "rest/bi/BIDimController/getDatabaseTableName",
				cache: false, //禁用缓存
				data: "",
				dataType: "json",
				success: function(result){
					if(result.data != "error"){
						$("#biz_Table_Name").empty("");
						$("#biz_Table_Name").append("<option value='0'>请选择</option>");
						for(var i=0; i< result.data.length; i++){
							var txt = langData.dimManage.tableName[result.data[i]];
							if(typeof(txt) == "undefined" || txt == "")
								txt = result.data[i];
							$("#biz_Table_Name").append("<option value="+result.data[i]+">"+txt+"</option>");
						}

						$("#id_Field").append("<option value=''>请选择数据表</option>");
						$("#text_Field").append("<option value=''>请选择数据表</option>");

						// loadDataFaild();
					}else{
						parent.bootbox.alert("数据表名称加载失败");
					}
				},
				error: function(){
					parent.bootbox.alert("数据表名称加载失败");
				}
			});
		}

		//选择数据表
		$("#biz_Table_Name").change(function(){
			loadDataFaild();
		});

		//根据选中的数据表名称加载数据字段
		function loadDataFaild(){
			$.ajax({
				type: "POST",
				url: "rest/bi/BIDimController/getTableData",
				cache: false, //禁用缓存
				data: "tableName="+$("#biz_Table_Name option:selected").val(),
				dataType: "json",
				success: function(result){
					$('#id_Field').empty();
					$('#text_Field').empty();
					if(result.data != "error"){
						for(var i=0; i< result.data.length; i++){
							var txt = "";
							if(typeof(langData.dimManage[$("#biz_Table_Name option:selected").val()]) == "undefined")
								txt = result.data[i].dim_Field_Name;
							else
								txt = langData.dimManage[$("#biz_Table_Name option:selected").val()][result.data[i].dim_Field_Name]
							$('#id_Field').append("<option value="+result.data[i].dim_Field_Name+">"+txt+"</option>");
							$('#text_Field').append("<option value="+result.data[i].dim_Field_Name+">"+txt+"</option>");
						}
					}else{
						parent.bootbox.alert("表数据加载失败");
					}
				},
				error: function(){
					parent.bootbox.alert("表数据加载失败");
				}
			});
		}

		function loadFaild(i_f,t_f){
			$.ajax({
				type: "POST",
				url: "rest/bi/BIDimController/getTableData",
				cache: false, //禁用缓存
				data: "tableName="+$("#biz_Table_Name option:selected").val(),
				dataType: "json",
				success: function(result){
					$('#id_Field').empty();
					$('#text_Field').empty();
					if(result.data != "error"){
						for(var i=0; i< result.data.length; i++){
							var txt = "";
							if(typeof(langData.dimManage[$("#biz_Table_Name option:selected").val()]) == "undefined")
								txt = result.data[i].dim_Field_Name;
							else
								txt = langData.dimManage[$("#biz_Table_Name option:selected").val()][result.data[i].dim_Field_Name]
							$('#id_Field').append("<option value="+result.data[i].dim_Field_Name+">"+txt+"</option>");
							$('#text_Field').append("<option value="+result.data[i].dim_Field_Name+">"+txt+"</option>");
						}

						$('#id_Field').val(i_f);
						$('#text_Field').val(t_f);

					}else{
						parent.bootbox.alert("表数据加载失败");
					}
				},
				error: function(){
					parent.bootbox.alert("表数据加载失败");
				}
			});
		}


		$("#drill_Type").change(function(){
			var type = $("#drill_Type option:selected").val();
			if(type == 1){
				$("#drill").css("display", "none");
			}else{
				$("#drill").css("display", "block");
			}
		});
    </script>
  </body>
</html>

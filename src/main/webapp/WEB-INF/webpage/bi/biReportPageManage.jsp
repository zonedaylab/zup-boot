<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
  <head>
    <base href="<%=basePath%>">
    <title>BI 表单管理</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="BI Show Page">
	<!--  import style	-->
	<jsp:include page="../include/mainHead.jsp"></jsp:include>
  </head>
  <body style="width:97%; margin-left:20px; background:#ffffff; overflow-x: hidden;">
  	<!--  BI Content	-->
  	<div class="row">
  		<!-- datables开始 -->
		<div class="table-header">表单配置</div>
		<div class="row">
			<div class="col-md-6" style="margin-left:20px;height:30px; margin-bottom:10px; margin-top:5px;">
				<button class="btn btn-primary btn-sm" id="btnAdd">添加</button>
				<button class="btn btn-primary btn-sm" id="btnEdit">编辑</button>
				<button class="btn btn-primary btn-sm" id="btnDelete">删除</button>
				<button class="btn btn-primary btn-sm" id="btnScreenSetting">布局设置</button>
				<button class="btn btn-primary btn-sm" id="btnReportSetting">元素设置</button>
				<button class="btn btn-primary btn-sm" id="btnPreview">报表预览</button>
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
							表单名称
						</th>
						<th>
							表单类型
						</th>
						<th>
							表单标题
						</th>
						<th>
							表单模板
						</th>
						<th>
							菜单&地址
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
    						 <strong class="control-label" style="text-align: left; float:left; width:98px;">表单名称：</strong>
							 <input class="form-control" id="page_Name" style="width:180px; float:left;" type="text" />
							 <font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>
						<div class="form-group row">
    						 <strong class="control-label" style="text-align: left; float:left; width:98px;" >表单类型：</strong>
							 <select class="form-control" id="page_Type" style="width:180px; float:left;"></select>
							 <font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div> 
						<div class="form-group row" id="title">
    						 <strong class="control-label" style="text-align: left; float:left; width:98px;">表单标题：</strong>
							 <input class="form-control" id="page_Title" style="width:180px; float:left;" type="text" />
							 <font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>
						<div class="form-group row">
    						 <strong class="control-label" style="text-align: left; float:left; width:98px;">表单地址：</strong>
							 <select class="form-control" id="page_Url" style="width:180px; float:left;"></select>
							 <font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>
						<div class="form-group row" id="menu">
    						 <strong class="control-label" style="text-align: left; float:left; width:98px;">关联菜单：</strong>
							 <select class="form-control" id="menu_Id" style="width:180px; float:left;"></select>
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
    		$(document).ready(function(){
    			loadGrid();
    			loadMenu();
    			loadPageType();
    			loadTemplateUrl();
    		});
    		
    		function getHost(){
    			var murl = window.location.href;
    			console.log(murl);
    			var index = murl.indexOf("rest/bi/biPageController")
    			murl = murl.substring(0, index-1);
    			console.log(murl);
    			return murl;
    		}
    		
    		function isAllNaN(str) {
    		    for (var i = 0; i < str.length; i++) {
    		        if(isNaN(str.charAt(i))) {
    		            return false;
    		        }
    		    }
    		    return true;
    		}
    
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
		                    url: "rest/bi/biPageController/getPageListByPage",
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
					        "data": "bi_Page_Id", // 数据列名
					        "orderable":false,
					        "sWidth":"15px",
					        "render": function(data, type, full) { // 返回自定义内容
					       		return "<label><input type='checkbox' class='ace' id='bi_Page_Id' value = '" + data + "' /><span class='lbl'></span></label>";
					         }
	                    },
	                    {
						  	"targets": [1], // 目标列位置，下标从0开始
						  	"sWidth":"20%",
						   	"data": "page_Name"
	                    },
	                    {
						   	"targets": [2], // 目标列位置，下标从0开始
						   	"sWidth":"20%",
						   	"data": "pageTypeStr"
	                    },
	                    {
						   	"targets": [3], // 目标列位置，下标从0开始
						   	"sWidth":"20%",
						   	"data": "page_Title" // 数据列名
	                    },
	                    {
						   	"targets": [4], // 目标列位置，下标从0开始
						   	"sWidth":"20%",
						   	"data": "page_Url" // 数据列名
	                    },
	                    {
						   	"targets": [5], // 目标列位置，下标从0开始
						   	"sWidth":"20%",
						   	"data": "menu_Name",
						   	"render": function(data, type, full) { // 返回自定义内容
						   		var d = data.replace("/Bi/", "");
						   		if(isAllNaN(d)){
						   			var mnurl = getHost()+data;
						   			return "<a  target='_Blank' href=" + mnurl + ">" + mnurl + "</a>";
						   		}else{
						   			return data;
						   		}
					         }
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
				$("#page_Name").val("");
				$("#page_Title").val("");
				$("#page_Type").val(0);
				$("#page_Url").val("");
				$("#menu_Id").val("");
				$("#title").css("display", "none");
				$("#menu").css("display", "none");
				msgDialog(e);
			});
			
			$("#btnEdit").on("click", function(e){
				par.thisid = this.id;
				if($("#bi_Page_Id:checked").length != 1) {
					parent.parent.bootbox.alert("只能选择一个表单进行编辑", function(){});
		        	return;
				}else{
					getReportData(e);
				}
			});
			
			
			//布局设置按钮
			$("#btnScreenSetting").on("click", function(){
				var Page_Id = 0;
				if($("#bi_Page_Id:checked").length != 1) {
					parent.parent.bootbox.alert("只能选择一个表单设置布局", function(){});
		        	return;
				}else{
					Page_Id = $("#bi_Page_Id:checked").val();
					window.open("/rest/bi/biScreenController?pageId="+Page_Id+"&tabName="+$("#bi_Page_Id:checked").parent().parent().next().next().next().text(), '表单布局设置', 'height=650,width=1200,top=200,left=50,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
				}
			});
			
			//元素设置按钮
			$("#btnReportSetting").on("click", function(){
				var Page_Id = 0;
				if($("#bi_Page_Id:checked").length != 1) {
					parent.parent.bootbox.alert("只能选择一个表单设置元素", function(){});
		        	return;
				}else{
					Page_Id = $("#bi_Page_Id:checked").val();
					window.open("/rest/bi/biReportController?pageId="+Page_Id+"&tabName="+$("#bi_Page_Id:checked").parent().parent().next().next().next().text(), '表单元素设置', 'height=650,width=1200,top=200,left=50,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
				}
			});
			
			$("#btnDelete").on("click", function(e){
				if($("#bi_Page_Id:checked").length <= 0){
					parent.parent.bootbox.alert("请先选择要删除的报表页面", function(){});
					return;
				}else{
					par.bi_Page_Ids = [];
					parent.parent.bootbox.confirm("你确定要删除报表页面吗？", function(result) {
						if(result){
							for(var i=0; i<$("#bi_Page_Id:checked").length;i++){
								par.bi_Page_Ids[i] = $("#bi_Page_Id:checked")[i].defaultValue;
								if(par.bi_Page_Ids.length < 1){
									parent.parent.bootbox.alert("请先选择要删除的报表页面", function(){});
									return;
								}
				   	        }
				   	        $.ajax({
			    	            url: 'rest/bi/biPageController/deletePage',
			    	            async: false,
			    	            data: par,
			    	            type: 'POST',
			    	            dataType: 'json',
			    	            success: function (result) {
			    	                if(result.data == "success"){
			    	                	parent.parent.bootbox.alert("删除成功", function(){});
			    	                	loadGrid();
			   	                	}else{
			   	                		parent.parent.bootbox.alert("删除失败， 失败的报表页面id为："+result.data, function(){});
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

			//布局设置按钮
			$("#btnPreview").on("click", function(){
				var Page_Id = 0;
				if($("#bi_Page_Id:checked").length != 1) {
					parent.parent.bootbox.alert("只能选择一个表单设置布局", function(){});
					return;
				}else{
					Page_Id = $("#bi_Page_Id:checked").val();
					window.open("/Bi/BIPageShow?pageId="+Page_Id);
				}
			});
			//选择页面类型
	    	function loadPageType(){
	    		$.ajax({
                   type: "POST",
                   url: "rest/bi/biPageController/getPageType",
                   cache: false,  //禁用缓存
                   dataType: "json",
                   success: function (result) {
                   		$("#page_Type").empty();
                   		$("#page_Type").append("<option value='0'>请选择类型</option>");
                   		for(var i=0; i<result.data.length; i++){
                   			$("#page_Type").append("<option value="+result.data[i].subid+">"+result.data[i].subname+"</option>");
                    	}
                   }
               });
	    	}
			
	    	//选择页面模板
	    	function loadTemplateUrl(){
	    		$.ajax({
                   type: "POST",
                   url: "rest/bi/biPageController/getTemplateUrl",
                   cache: false,  //禁用缓存
                   dataType: "json",
                   success: function (result) {
                   		$("#page_Url").empty();
                   		$("#page_Url").append("<option value='0'>请页面模板</option>");
                   		for(var i=0; i<result.data.length; i++){
                   			$("#page_Url").append("<option value="+result.data[i].subname+">"+result.data[i].name+"</option>");
                    	}
                   		$("#page_Url").val(0);
                   }
               });
	    	}
			
	    	//加载菜单下拉框
	    	function loadMenu(){
	    		$.ajax({
                   type: "POST",
                   url: "rest/bi/biPageController/getMenu",
                   data: {accountId: "${ usersession.accountId}"},
                   cache: false,  //禁用缓存
                   dataType: "json",
                   success: function (result) {
                   		$("#menu_Id").empty();
                   		$("#menu_Id").append("<option value='0'>请选择菜单</option>");
                   		for(var i=0; i<result.data.length; i++){
                   			$("#menu_Id").append("<option value="+result.data[i].menuId+">"+result.data[i].menuName+"</option>");
                    	}
                   		$("#menu_Id").val(0);
                   }
               });
	    	}
			
			//点击编辑时根据主键获取到数据进行填充文本框
			function getReportData(e){
				par.bi_Page_Id = $("#bi_Page_Id:checked").val();
				//ajax请求数据
                $.ajax({
                    type: "POST",
                    url: "rest/bi/biPageController/getPageInfo",
                    async: false,
                    cache: false,  //禁用缓存
                    data: par,  //传入组装的参数
                    dataType: "json",
                    success: function (result) {
                    	$("#page_Name").val(result.data.page_Name);
        				$("#page_Type").val(result.data.page_Type);
        				$("#page_Url").val(result.data.page_Url);
        				$("#menu_Id").val(result.data.menu_Id);
						if($("#page_Type").val() != 2){
							$("#title").css("display", "block");
							$("#page_Title").val(result.data.page_Title);
						}else
							$("#title").css("display", "none");
                    	msgDialog(e);
                    },
                    error: function(){
                    	parent.parent.bootbox.alert("编辑获取数据失败", function(){});
                    }
                });
			}
			
			//点击添加
			function addReportData(){
				delete par.report_Field_Id;
				//ajax请求数据
                $.ajax({
                    type: "POST",
                    url: "rest/bi/biPageController/savePage",
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
                    url: "rest/bi/biPageController/updatePage",
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
					title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>报表页面设置</h4></div>",
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
								var date=new Date();
							    var h=date.getHours(); //获取小时
							    var m=date.getMinutes(); //获取分钟
							    var s=date.getSeconds(); //获取秒
							    var random = parseInt(h+""+m+""+s);
								par.page_Name = $("#page_Name").val();
								if($("#page_Type").val() == 1){
									var mid = parseInt(Math.random()*random);
									console.log(mid);
									par.menu_Id = mid;
									par.menu_Name = "/Bi/" + mid;
								}else{
									par.menu_Id = $("#menu_Id").val();
									par.menu_Name = $("#menu_Id option:selected").text()
								}
								if($("#page_Type").val() != 2)
									par.page_Title = $("#page_Title").val()
								else{
									delete par.page_Title;
								}
								par.page_Type = $("#page_Type").val();
								par.page_Url = $("#page_Url").val();
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
			
			$("#page_Type").change(function(){
				if($("#page_Type").val() != 2){
					$("#title").css("display", "block");
				}else{
					$("#title").css("display", "none");
				}
				if($("#page_Type").val() != 1){
					$("#menu").css("display", "block");
				}else{
					$("#menu").css("display", "none");
				}
			});
			
    </script>
  </body>
</html>

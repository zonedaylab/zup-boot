<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
  <head>
    <base href="<%=basePath%>">
    <title>BI 主题表管理 - 积成能源</title>
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
		<div class="table-header">主题设置</div>
		<div class="row">
			<div class="col-md-6" style="margin-left:20px;height:30px; margin-bottom:10px; margin-top:5px;">
				<button class="btn btn-primary btn-sm" id="btnAdd">添加</button>
				<button class="btn btn-primary btn-sm" id="btnEdit">编辑</button>
				<button class="btn btn-primary btn-sm" id="btnDelete">删除</button>
				<button class="btn btn-primary btn-sm" id="btnValSetting">字段设置</button>
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
							主题名称
						</th>
						<th>
							标题
						</th>
<!-- 						<th> -->
<!-- 							主题类型 -->
<!-- 						</th> -->
						<th>
							数据表
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
    						 <strong class="control-label" style="text-align: left; float:left; width:98px;" >主题名称：</strong>
							 <input class="form-control" id="topic_Name" type="text" style="width:180px; float:left;"/><font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div> 
						<div class="form-group row">
    						 <strong class="control-label" style="text-align: left; float:left; width:98px;" >标题：</strong>
							 <input class="form-control" id="topic_Caption" type="text" style="width:180px; float:left;"/><font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font>
						</div>
<!-- 						<div class="form-group row"> -->
<!--     						 <strong class="control-label" style="text-align: left; float:left; width:98px;">主题类型：</strong> -->
<!-- 							 <select class="form-control" id="topic_Type" style="width:180px; float:left;"></select> -->
<!-- 							 <font style="float:left; font-size:20px; margin-left:5px;" color=red>*</font> -->
<!-- 						</div> -->
						<div class="form-group row">
    						 <strong class="control-label" style="text-align: left; float:left; width:98px;">数据表：</strong>
							 <select class="form-control" id="biz_Table_Name" style="width:180px; float:left;"></select>
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
	                    url: "rest/bi/BITopicController/girdTopicList",
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
				        "data": "topic_Id", // 数据列名
				        "orderable":false,
				        "sWidth":"15px",
				        "render": function(data, type, full) { // 返回自定义内容
				       		return "<label><input type='checkbox' class='ace' id='topic_Id' value = '" + data + "' /><span class='lbl' id='topic_Id' value = '" + data + "'></span></label>";
				         }
                    },
                    {
					  	"targets": [1], // 目标列位置，下标从0开始
					  	"sWidth":"35%",
					   	"data": "topic_Name"
                    },
                    {
					  	"targets": [2], // 目标列位置，下标从0开始
					  	"sWidth":"35%",
					   	"data": "topic_Caption"
                    },
                   /* {
					   	"targets": [3], // 目标列位置，下标从0开始
					   	"sWidth":"25%",
					   	"data": "topic_Type" // 数据列名
                    },*/
                    {
					   	"targets": [3], // 目标列位置，下标从0开始
					   	"sWidth":"30%",
					   	"data": "biz_Table_Name" // 数据列名
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
			loadTableName(-1);
			$("#biz_Table_Name").val("");
              	$("#topic_Caption").val("");
              	$("#topic_Name").val("");
			par.thisid = this.id;
			msgDialog(e);
		});
		
		$("#btnEdit").on("click", function(e){
			$("#biz_Table_Name").val("");
              	$("#topic_Caption").val("");
              	$("#topic_Name").val("");
			par.thisid = this.id;
			if($("#topic_Id:checked").length != 1)
			{
				parent.parent.bootbox.alert("只能选择一个主题进行编辑", function(){});
	        	return;
			}else{
				par.topic_Id = $("#topic_Id:checked").val();
				getTopicData(e);
			}
		});
		
		$("#btnDelete").on("click", function(e){
			if($("#topic_Id:checked").length <= 0){
				parent.parent.bootbox.alert("请先选择要删除的主题", function(){});
				return;
			}else{
				par.topic_Ids = [];
				parent.parent.bootbox.confirm("你确定要删除主题吗？", function(result) {
					if(result){
						for(var i=0; i<$("#topic_Id:checked").length;i++){
							par.topic_Ids[i] = $("#topic_Id:checked")[i].defaultValue;
							if(par.topic_Ids.length < 1){
								parent.parent.bootbox.alert("请先选择要删除的主题", function(){});
								return;
							}
			   	        }
			   	        $.ajax({
		    	            url: 'rest/bi/BITopicController/deleteTopicData',
		    	            async: false,
		    	            data: par,
		    	            type: 'POST',
		    	            dataType: 'json',
		    	            success: function (result) {
		    	                if(result.data == "success"){
		    	                	parent.parent.bootbox.alert("删除成功", function(){});
		    	                	loadGrid();
		   	                	}else{
		   	                		parent.parent.bootbox.alert("删除失败， 失败的主题id为："+result.data, function(){});
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
		
		//点击编辑时根据topic_Id获取数据填充到编辑框
		function getTopicData(e){
			//ajax请求数据
               $.ajax({
                   type: "POST",
                   url: "rest/bi/BITopicController/getTopicData",
                   cache: false,  //禁用缓存
                   data: par,  //传入组装的参数
                   dataType: "json",
                   success: function (result) {
                   	loadTableName(result.data[0].biz_Table_Name);
                   	$("#topic_Caption").val(result.data[0].topic_Caption);
                   	$("#topic_Name").val(result.data[0].topic_Name);
                   	msgDialog(e);
                   },
                   error: function(){
                   	parent.parent.bootbox.alert("编辑获取数据失败", function(){});
                   }
               });
		}
		
		//点击添加
		function addTopicData(){
			//ajax请求数据
               $.ajax({
                   type: "POST",
                   url: "rest/bi/BITopicController/addTopicData",
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
		function editTopicData(){
			//ajax请求数据
               $.ajax({
                   type: "POST",
                   url: "rest/bi/BITopicController/editTopicData",
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
							par.topic_Name = $("#topic_Name").val();
							par.topic_Caption = $("#topic_Caption").val();
							par.biz_Table_Name = $("#biz_Table_Name").val();
							if(par.topic_Name != "" && par.topic_Caption != "" && par.biz_Table_Name != ""){
								if(par.thisid == "btnAdd"){
									addTopicData();	
								}else if(par.thisid == "btnEdit"){
									editTopicData();
								}
							}else{
								parent.parent.bootbox.alert("请填写必填项", function(){});
								return;
							}
						} 
					}
				]
			});
		}
		
		//主题字段管理按钮
		$("#btnValSetting").on("click", function(){
			var topic_Id = 0;
			if($("#topic_Id:checked").length != 1) {
				parent.parent.bootbox.alert("只能选择一个主题进行编辑", function(){});
	        	return;
			}else{
				topic_Id = $("#topic_Id:checked").val();
				window.open("rest/bi/BITopicFiledController?topicId="+topic_Id+"&tabName="+$("#topic_Id:checked").parent().parent().next().next().next().text(), '主题字段设置', 'height=650,width=1200,top=200,left=50,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
			}
		});
		
		//加载数据库表名 
    	function loadTableName(value){
    		$.ajax({ 
    			type: "POST",
    			url: "rest/bi/BIDimController/getDatabaseTableName",
    			cache: false, //禁用缓存
    			data: "",
    			dataType: "json",
    			success: function(result){
    				if(result.data != "error"){
    					$("#biz_Table_Name").html("");
    					$("#biz_Table_Name").append("<option value='0'>请选择</option>");
    					for(var i=0; i< result.data.length; i++){
    						var txt = langData.dimManage.tableName[result.data[i]];
    						if(typeof(txt) == "undefined" || txt == "")
    							txt = result.data[i];
    						if(value == result.data[i]){
    							$("#biz_Table_Name").append("<option selected='selected' value="+result.data[i]+">"+txt+"</option>");
    						}else{
    							$("#biz_Table_Name").append("<option value="+result.data[i]+">"+txt+"</option>");
    						}
    					}
    				}else{
    					parent.parent.bootbox.alert("数据表名称加载失败");
    				}
    			},
    			error: function(){
    				parent.parent.bootbox.alert("数据表名称加载失败");
    			}
    		});
    	}
    </script>
  </body>
</html>

<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<base href=" <%=basePath%>">
		<title>积成能源 运维监控平台菜单操作项</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	    <!--        引入外部样式库css        -->
        <jsp:include page="../include/mainHead.jsp"></jsp:include>
       
</head>
<body style="background-color:#FFFFFF; height:1500px; overflow-x : hidden ;" >
    <div class="row">
    	<!-- 左侧树形图开始 -->
		<div class="col-sm-3 col-xs-12 col-lg-3" style="margin-top:-3px; paading:0px;">
			<div class="widget-box">
				<div class="widget-header header-color-blue2">
					<h4 class="lighter smaller">菜单管理</h4>
				</div>
				<div style="margin-left:25px; margin-bottom:10px; margin-top:10px;">
					<strong>系统名称：</strong>
					<select class="ipt" id="systemList" style="height: 30px; width: 160px; ">
					</select>
				</div>
				<div class="widget-body">
					<div class="widget-main padding-8" id="parenTree">
					
					</div>
				</div>
			</div>
		</div>
		<!-- 左侧树形图结束 -->
		
		<div class="col-sm-9 col-xs-12 col-lg-9 widget-body">
			<!-- 菜单操作项datables开始 -->
			<div class="table-header">菜单详情</div>
			<div class="row">
				<div class="col-md-4" style="margin-left:20px;height:30px; margin-bottom:10px; margin-top:5px;">
					<button class="btn btn-primary btn-sm" id="btnAdd">添加</button>
					<button class="btn btn-primary btn-sm" id="btnEdit">编辑</button>
					<button class="btn btn-primary btn-sm" id="btnDelete">删除</button>
				</div>
				<div class="col-md-7"></div>
			</div>
			<div class="table-responsive">
				<table id="gridAction" class="table table-striped table-bordered table-hover"  style="margin-bottom:20px;">
					<thead>
						<tr>
							<th>
								<label>
									<input type="checkbox" class="ace" id="allCheck" />
									<span class="lbl"></span>
								</label>
							</th>
							<th>操作项显示名</th>
							<th>操作项名称</th>
							<th>操作标志码</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		<!-- 菜单操作项信息datables结束 -->
	</div>
	
	<!--弹出框放置位置  添加 删除  查看详情 布局-->
    <div id="formEdit" class="hide">
		<div class="container">
			<div class="row clearfix">
				<div class="col-md-12 column">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							 <strong for="opShowName" class="col-xs-12 col-md-3 control-label" style="text-align: left" >操作项显示名：</strong>
							<div class="col-xs-12 col-md-8">
								<input class="form-control" id="opShowName" type="text" />
							</div>
							<div class="col-xs-12 col-md-1">
								<font color="red">*</font>
							</div>
						</div> 
						<div class="form-group">
							 <strong for="opName" class="col-xs-12 col-md-3 control-label" style="text-align: left" >操 作 项名称：</strong>
							<div class="col-xs-12 col-md-8">
								<input class="form-control" id="opName" type="text" />
							</div>
							<div class="col-xs-12 col-md-1">
								<font color="red">*</font>
							</div>
						</div> 
						<div class="form-group">
							 <strong for="opCode" class="col-xs-12 col-md-3 control-label" style="text-align: left" >操作项标志码：</strong>
							<div class="col-xs-12 col-md-8">
								<input class="form-control" id="opCode" type="text" />
							</div>
							<div class="col-xs-12 col-md-1">
								<font color="red">*</font>
							</div>
						</div> 
        		</form>
        		</div>
			</div> 
		</div>
	</div> 
	
	
    <!--  引入js存放的外部脚本库  -->
    <jsp:include page="../include/mainFooter.jsp"></jsp:include>
    
   	<!-- 添加脚本开始 -->
   	<script type="text/javascript">
        //封装请求参数
        var param = {};
        var pars = {};
   		//添加系统名称下拉框
   		$(document).ready(function(){
   			$.ajax({
               type: "POST",
               url: "rest/rbac/menuController/getSystemList",
               cache: false,  //禁用缓存
               dataType: "json",
               success: function (result) {
               		$("#systemList").empty();
               		for(var i=0; i<result.systemList.length; i++){
               			$("#systemList").append("<option value='"+result.systemList[i].systemId+"'>"+result.systemList[i].systemName+"</option>");
               		}
					pars.rootOnly = true;
	    			pars.parentMenuId = -1;
					pars.systemId =  $("#systemList").val();
	    			$("#parenTree").append("<div id='treeMenu"+pars.systemId+"' class='tree'></div>");  //重新追加一个div来承载tree
	    			tree(pars);
	    			if(pars.parentMenuId == -1){
       					pars.parentMenuId = 0;
       				}
 					$("#systemList").change(function(){
		    			$(".tree").remove();
		    			pars.rootOnly = true;
		    			pars.parentMenuId = -1;
 						pars.systemId =  $("#systemList").val();
		    			$("#parenTree").append("<div id='treeMenu"+pars.systemId+"' class='tree'></div>");
		    			tree(pars);
		    			if(pars.parentMenuId == -1){
	       					pars.parentMenuId = 0;
	       				}
	       				param.systemId = $("#systemList").val();
	       				loadTableData();
	    		     });
               },
               error:function(){
               	alert("系统平台名称加载失败");
               }
           });
   		});
   		//初始化菜单管理树形图
   		function tree(pars){
   			var DataSourceTree = function (options) {
   	        	this.url = options.url;
    	    }
	       	 DataSourceTree.prototype.data = function (options, callback) {
	       	    var self = this;
	       	    var $data = null;
	       	    if (!("name" in options) && !("type" in options) && pars.parentMenuId != -1) {
	       	        pars.parentMenuId = 0; //当父节点不为-1时赋值为0，可以到根节点 
	       	    } else if ("type" in options && options.type == "folder") {
	       	       		 if (options.id!="0") {
		       	            pars.parentMenuId = options.id;
	       	        }
	       	        else{
	       	        	par.organId=options.id;
	       	        }
	       	    }
       	        $.ajax({
                  type: "POST",
                  url: this.url,
                  cache: false,  //禁用缓存
                  data:pars,
                  dataType: "json",
                  success: function (result) {
                 		callback(result);
                 		//默认打开二级
               			var cobj = $('#treeMenu'+pars.systemId+"  .tree-folder:eq(1)")[0].childNodes[1];
			            if(result.data[0].id == 0){
			           	    cobj.click();
			            }
                  },
                  error:function(){
                  	alert("系统树加载失败");
                  }
              	});
	       	};
	       	$('#treeMenu'+pars.systemId).ace_tree({
	       		dataSource: new DataSourceTree({
	       	    	url: 'rest/rbac/menuController/getChildNode'
	       	    })
	       	});
	       	//加载grid数据（叶子节点）
	       	$('#treeMenu'+pars.systemId).on('selected', function(evt, data) {
	         	//取出ID
	         	param.menuId=data.info[0].id;
	       	    loadTableData();
	       	});
	      	//加载grid数据（父节点）
	        $('#treeMenu'+pars.systemId).on('closed', function(evt, data) {
	        	param.menuId=null;//data.id;
	   	     	loadTableData();
	    	});
	    	$('#treeMenu'+pars.systemId).on('opened', function(evt, data) {
	    		param.menuId=data.id;
	   	     	loadTableData();
	    	});
	       	
   		}
   		
   		//datables表复选框全选
		$("#allCheck").on('click' , function(){
			var that = this;
			$(this).closest('table').find('tr > td:first-child input:checkbox')
			.each(function(){
				this.checked = that.checked;
				$(this).closest('tr').toggleClass('selected');
			});
		});
        //加载datables表数据js
   		$(function () {
   			loadTableData();
   		});
	    function loadTableData(){
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
	            "sAria": {
	                "sSortAscending": ": 以升序排列此列",
	                "sSortDescending": ": 以降序排列此列"
	            }
	        };   
    		//初始化表格
        	var table = $("#gridAction").dataTable({
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
	                //ajax请求数据
	                $.ajax({
	                    type: "POST",
	                    url: "rest/rbac/menuActionController/getActionList",
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
				        "data": "actionId", // 数据列名
				        "orderable":false,
				        "sWidth":"15px",
				        "render": function(data, type, full) { // 返回自定义内容
				       		return "<label><input type='checkbox' class='ace' id='actionId' value = '" + data + "' /><span class='lbl' id='sorganid' value = '" + data + "'></span></label>";
				         }
                    },
                    {
					  	"targets": [1], // 目标列位置，下标从0开始
					  	"sWidth":"40%",
					   	"data": "caption"
                    },
                    {
					   	"targets": [2], // 目标列位置，下标从0开始
					   	"sWidth":"30%",
					   	"data": "actionName" // 数据列名
                    },
                    {
					   	"targets": [3], // 目标列位置，下标从0开始
					   	"sWidth":"30%",
					   	"data": "actionCode" // 数据列名
                    }
            ]
        }).api();
        //此处需调用api()方法,否则返回的是JQuery对象而不是DataTables的API对象
	    }
	</script>
	
	<!--弹出框放置位置  添加 删除  查看详情 js脚本实现-->
    <script type="text/javascript">
    	$.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
			_title: function(title) {
				var $title = this.options.title || '&nbsp;'
				if( ("title_html" in this.options) && this.options.title_html == true )
					title.html($title);
				else title.text($title);
			}
		}));
		var thisid = null;
		$( "#btnAdd" ).on('click', function(e) {
			thisid = this.id;  //获取当前点击按钮的id
			$("#opShowName").val('');
			$("#opShowName").removeAttr("readonly");
			$("#opName").val('');
			$("#opName").removeAttr("readonly");
			$("#opCode").val('');
			$("#opCode").removeAttr("readonly");
			if(param.menuId == null || param.menuId == ""){
				parent.bootbox.confirm("请先选择左侧的菜单", function(){});
				return;
			}else{
				msgDialog(e);
			}
		});
		$( "#btnEdit" ).on('click', function(e) {
			if(param.menuId == null || param.menuId == ""){
				parent.bootbox.confirm("请先选择左侧的菜单", function(){});
				return;
			}			
			else{	
				thisid = this.id;  //获取当前点击按钮的id
				lookActionInfo(e);
				//editActionInfo(e)
			}
			
		});
		var par = {};   //声明ajax传输参数的数组变量
		$( "#btnDelete" ).on('click', function(e) {	
			par.menuId = param.menuId;		
			if($("#actionId:checked").length <= 0){
				parent.bootbox.alert("请先选择要删除的操作项", function(){});
				return;
			}else{
				delActionInfo(par);
			}
		});
		
		function msgDialog(e){
			e.preventDefault();
				var dialog = $( "#formEdit" ).removeClass('hide').dialog({
					modal: true,
					title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>操作项设置</h4></div>",
					title_html: true,
					width:540,
					height:270,
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
								if(thisid == "btnAdd"){
									par.menuId = param.menuId;
									par.actionName = $("#opName").val();
									par.caption = $("#opShowName").val();
									par.actionCode = $("#opCode").val();
									addActionInfo(par);
									//loadTableData();
								}
								if(thisid == "btnEdit"){
									par.actionName = $("#opName").val();
									par.caption = $("#opShowName").val();
									par.actionCode = $("#opCode").val();
									editActionInfo(par);
									//loadTableData();
								}
								//$( this ).dialog( "close" );
							} 
						}
					]
				});
		}
		
		//添加菜单操作项信息
		function addActionInfo(par){
			if(par.caption==""||par.caption==null){
				parent.bootbox.alert("操作项显示名称不能为空" , function(){});
					return;
				}
			else if(par.actionName == ""||par.actionName==null){
					parent.bootbox.alert("操作项名称不能为空" , function(){});
					return;
			}
			else if( par.actionCode == ""||par.actionCode==null){
			 			parent.bootbox.alert("操作项标志码不能为空" , function(){});
					return;
					}
				else{	
					$.ajax({
	       	            url: 'rest/rbac/menuActionController/addAction',
	       	            data: par,
	       	            type: 'POST',
	       	            dataType: 'json',
	       	            success: function (result) {
	       	            	if(result){
	    	                	parent.bootbox.alert("添加成功", function(){
	    	                		$( "#formEdit" ).dialog( "close" ); 
	    	                		 loadTableData();
	    	                	});
	   	                	}else{
	   	                		parent.bootbox.alert("操作项显示名称已经存在，请更换", function(){});
	   	                	}
	       	            },
	       	            error: function(){
	       	                parent.bootbox.alert("添加失败", function(){});
	       	            }
	       	        });
	       	       }       	       
			}		
		
		//删除操作项信息
		function delActionInfo(par){ 
				par.actionIds = [];
				parent.bootbox.confirm("你确定要删除吗？", function(result) {
				if(result){
					for(var i=0; i<$("#actionId:checked").length;i++){
						par.actionIds[i] = $("#actionId:checked")[i].defaultValue;
						if(par.actionIds == null){
							parent.bootbox.alert("请先选择操作信息", function(){});
							return;
						}
		   	        }		   	       
		   	        $.ajax({
	    	            url: 'rest/rbac/menuActionController/deleteAction',
	    	            async: false,
	    	            data: par,
	    	            type: 'POST',
	    	            dataType: 'json',
	    	            success: function (result) {
	    	                if(result.result == "success"){
	    	                	parent.bootbox.alert("删除成功", function(){
	    	                	loadTableData();
	    	                	});
	   	                	}else{
	   	                		parent.bootbox.alert("该操作项已被其他角色引用，不允许删除："+result.info, function(){});
	   	                	}
	    	            },
	    	            error: function(){
	    	            	parent.bootbox.alert("删除失败", function(){});
	    	            }
		   	        });
		   	       loadTableData();
				}else{
					return;
				}
			});
		}
		
		//查看操作信息
		function lookActionInfo(e){
			par.actionId = $("#actionId:checked").val();
			if(par.actionId == null || par.actionId == "" || par.actionId=="undefined"){
				parent.bootbox.alert("请先选择要编辑的操作项", function(){});
				return;
			}
			if($("#actionId:checked").length>1)
			{
				parent.bootbox.alert("只能选择一个操作项进行编辑", function(){});
	        	return;
			}else{
				$.ajax({
    	            url: 'rest/rbac/menuActionController/getAction',
    	            data: 'actionId='+par.actionId,
    	            type: 'POST',
    	            dataType: 'json',
    	            success: function (result) {
    	                $("#opName").val(result.actioninfo[0].actionName);
						$("#opShowName").val(result.actioninfo[0].caption);
						$("#opCode").val(result.actioninfo[0].actionCode);
						msgDialog(e);
    	            },
    	            error: function(){
    	            	parent.bootbox.alert("查看数据失败", function(){});
    	            	return;
    	            }
   	        	});
  	        }
		}
		//编辑操作信息
		function editActionInfo(par){
			par.actionId = $("#actionId:checked").val();
			par.menuId = param.menuId;						
			if(par.caption==""||par.caption==null){
				parent.bootbox.alert("操作项显示名称不能为空" , function(){});
					return;
				}
			else if(par.actionName == ""||par.actionName==null){
					parent.bootbox.alert("操作项名称不能为空" , function(){});
					return;
			}
			else if( par.actionCode == ""||par.actionCode==null){
			 			parent.bootbox.alert("操作项标志码不能为空" , function(){});
					return;
					}
				else{						
					$.ajax({
	    	            url: 'rest/rbac/menuActionController/editAction',
	    	            data: par,
	    	            type: 'POST',
	    	            dataType: 'json',
	    	            success: function (result) {
	   	            		if(result){
	    	                	parent.bootbox.alert("更新成功", function(){});
	    	                	$("#formEdit").dialog("close");
	    	                	loadTableData();
	   	                	}else{
	   	                		parent.bootbox.alert("操作项显示名称已经存在，请更换", function(){});
	   	                	}
		   	            },
		   	            error: function(){
		   	            	parent.bootbox.alert("更新数据失败", function(){});
		   	            	return;
		   	            }
	   	        	});
   	        	}
		}
		
	</script>
    
	</body>
</html>


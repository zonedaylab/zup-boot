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
        <!--        定义适应屏幕的css样式 -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <style type="text/css">
        	.bootbox-body{
        		color:#F00;
        	}
        </style>
        <link rel="stylesheet" type="text/css" href="plug-in\ace\main\esale\new_css\esale-new-style.css"/>
</head>
<body style="background-color:#FFFFFF;  overflow-x : hidden ;" >
    <div class="row">
		<div class="col-md-12 col-xs-12 col-lg-12 widget-body">
			<div class="row center center-block" style="margin-top:20px;">
				<div class="container">
					<div class="row clearfix">
						<div class="col-md-12 col-xs-12 column">
							<form class="form-horizontal" role="form">
								<div class="form-group">
									<label for="FlOWNAMEQUERY" class="col-xs-5 col-md-2 control-label" style="text-align: right" >流程名称：</label>
									<div class="col-xs-4 col-md-3">
										<input type="text" class="form-control" id="FlOWNAMEQUERY" />
									</div>
									<label for="FlOWSTATEQUERY" class="col-xs-5 col-md-2 control-label" id="POSITIONDEPRESS" style="text-align: right" >流程状态：</label>
									<div class="col-xs-4 col-md-3">
										<select class="form-control" id="FlOWSTATEQUERY">
										<option value='0'>全部</option>
										</select>
									</div>
									<div class="col-md-2 col-xs-3" style=" position:absolute; right:15px; top:0px">
										<button class="btn btn-sm btn-primary" type="button" id="btnSearch"><i class="icon-ok"></i>查询</button>
									</div>
								</div>
								<div class="form-group">
									<label for="SHIPSYSTEMQUERY" class="col-xs-5 col-md-2 control-label" style="text-align: right" >所属系统：</label>
									<div class="col-xs-4  col-md-3">
										<select class="form-control" id="SHIPSYSTEMQUERY">
										<option value='0'>全部</option>
										</select>
									</div>
								</div> 
				          </form>
			         </div>
			    </div>
			</div>
	     </div>
			<!-- 查询条件结束 -->
			<!-- 菜单操作项datables开始 -->
			<div class="table-header">流程配置管理</div>
			<div class="row">
				<div class="col-md-8" style="margin-left:6px;height:30px; margin-bottom:10px; margin-top:5px;">
					<button class="btn btn-primary btn-sm" id="btnAdd">添加</button>
					<button class="btn btn-primary btn-sm" id="btnEdit">编辑</button>
					<button class="btn btn-primary btn-sm" id="btnDelete">删除</button>
					<button class="btn btn-primary btn-sm" id="btnDesign">设计</button>
				</div>
				<div class="col-md-7"></div>
			</div>
			<div class="table-responsive">
				<table id="gridFlow" class="table table-striped table-bordered table-hover"  style="margin-bottom:20px;">
					<thead>
						<tr>
							<th>
								<label>
									<input type="checkbox" class="ace" id="allCheck" />
									<span class="lbl"></span>
								</label>
							</th>
							<th>所属系统</th>
							<th>流程名称</th>
							<th>流程状态</th>
							<th>流程类型</th>
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
		<form class="bootbox-form" id="addOrEditForm">
            <strong>流程名称： </strong><input type="text" id="FlOWNAME" style="height: 30px; width: 160px; margin-bottom:5px;" /><br/>
			<strong>流程状态：</strong>
			<select id="FlOWSTATE" style="height: 30px; width: 160px; margin-bottom:5px;">
				<option value='0'>全部</option>
			</select><br/>
			<strong>流程类型： </strong><input name="FLOW_TYPE" id="FLOWTYPE" type="text" style="height: 30px; width: 160px; margin-bottom:5px;"/><br/>
			<strong>所属系统：</strong>
			<select id="SHIPSYSTEM" style="height: 30px; width: 160px; margin-bottom:5px;">
				<option value='0'>全部</option>
			</select><br/>
			<strong>用户选择：</strong>
			<input  id="receiversDialog" type="text" style="height: 30px; width: 160px; margin-bottom:5px;" />
        </form>
       <!-- <div class="row" id="btnTree" style="mrgin-left:10px;">
       	<div class="col-md-4"></div>
			<button class="btn btn-primary btn-sm col-md-12" id="btnUser" style="border: 1px solid #FFFFFF;">用户选择</button>
       	<div class="col-md-4"></div>
        </div> -->
        <!--树形图开始 -->
		<!-- <div class="widget-box">
			<div class="widget-body">
				<div class="widget-main padding-8" id="parentTree">
				
				</div>
			</div>
		</div> -->
	</div>
	<div id="receiverTreeDialog" class="hide"> 
		<div class="widget-box">
				<div class="widget-header header-color-blue2">
					<h4 class="lighter smaller">接收者</h4>
				</div>
				<div class="widget-body">
					<div class="widget-main padding-8" id = "parentTreess">
						
					</div>
				</div>
			</div>
		</div>
	 <div id="messageStrategyPerson" class="hide">
		<form class="bootbox-form">
            <strong>组织机构：</strong><input class="diaorgan" id="receiverDialog" type="text" style="height: 30px; width: 195px; margin-bottom:5px;"/><br/>
          	<button class="btn btn-sm btn-primary " type="button" style="float:right; height:30px; margin-top:-34px;" id="searchMsg"><i class="icon-ok"></i>查询</button>
		</form>
		<div class="panel panel-default" style="margin-top:10px; height:360px;">
	        <div class="panel-body">
	           <div id="pickList" style="height:260px;"></div>
         		<span class="col-md-7 col-lg-7 panel-title" style="">待分配用户</span>
         		<span class="col-md-5 col-lg-5 panel-title" >已分配用户</span>
	           <div class="panel-heading" style="margin-top:10px;">	           
	        </div>
	           <br><br>
	        </div>
     	</div>
	</div>
    <!--  引入js存放的外部脚本库  -->
    <jsp:include page="../include/mainFooter.jsp"></jsp:include>
    
   	<!-- 添加脚本开始 -->
   	<script type="text/javascript">
   		//datables表复选框全选
   		var param = {};
   		var pars = {};
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
   			//绑定下拉框 流程装填  所属系统
			$.ajax({
	            type: "POST",
	            url: "rest/workflow/wfConfigManage/flowState", 
	            cache: false,  //禁用缓存
	            dataType: "json",
	            success: function (result) {
	       			$("#FlOWSTATEQUERY").empty();
	       			$("#FlOWSTATEQUERY").append("<option value=0>全部</option>");
	       			$("#FlOWSTATE").empty();
	       			$("#FlOWSTATE").append("<option value=0>全部</option>");
	            	for(var i=0;i<result.flowstate.length;i++){
	             		$("#FlOWSTATEQUERY").append("<option value='"+result.flowstate[i].SUB_ID+"'>"+result.flowstate[i].SUB_NAME+"</option>");
	             		$("#FlOWSTATE").append("<option value='"+result.flowstate[i].SUB_ID+"'>"+result.flowstate[i].SUB_NAME+"</option>");
	            	}
	            }
	        });
        	$.ajax({
	            type: "POST",
	            url: "rest/workflow/wfConfigManage/SystemName", 
	            cache: false,  //禁用缓存
	            dataType: "json",
	            success: function (result) {
	       			$("#SHIPSYSTEMQUERY").empty();
	       			$("#SHIPSYSTEMQUERY").append("<option value=0>全部</option>");
	       			$("#SHIPSYSTEM").empty();
	       			$("#SHIPSYSTEM").append("<option value=0>全部</option>");
	            	for(var i=0;i<result.system.length;i++){
	             		$("#SHIPSYSTEMQUERY").append("<option value='"+result.system[i].systemId+"'>"+result.system[i].systemName+"</option>");
	             		$("#SHIPSYSTEM").append("<option value='"+result.system[i].systemId+"'>"+result.system[i].systemName+"</option>");
	            	}
	            	//网页加载时 装载树形图
   					$(".tree").remove();
	    			pars.parentMenuId = -1;
					pars.systemId =  $("#SHIPSYSTEM").val();
					pars.postMark = 0;
					pars.FLOW_ID = -1;
	    			$("#parentTree").append("<div id='treeMenu"+pars.systemId+"' class='tree'></div>");
	    			tree(pars);
	    			if(pars.parentMenuId == -1){
       					pars.parentMenuId = 0;
       				}
   					$("#SHIPSYSTEM").change(function(){
   						$(".tree").remove();
		    			pars.parentMenuId = -1;
		    			pars.postMark = 0;
		    			pars.FLOW_ID = -1;
 						pars.systemId =  $("#SHIPSYSTEM").val();
		    			$("#parentTree").append("<div id='treeMenu"+pars.systemId+"' class='tree'></div>");
		    			tree(pars);
		    			if(pars.parentMenuId == -1){
	       					pars.parentMenuId = 0;
	       				}
		    		});
	            }
	        });
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
	            "oAria": {
	                "sSortAscending": ": 以升序排列此列",
	                "sSortDescending": ": 以降序排列此列"
	            }
	        };   
    		//初始化表格
        	var table = $("#gridFlow").dataTable({
        	    "dom": '<t><"row"<"col-md-2"l><"col-md-4"i><"col-md-6"p>>',    //为表格元素书写css样式<t>为中间表格  在<t>右边就是在表格下边
           		language:lang,  //提示信息
            	stripeClasses: ["odd", "even"],  //为奇偶行加上样式，兼容不支持CSS伪类的场合
	            serverSide: true,  //启用服务器端分页
	            searching: false,  //禁用原生搜索
	            bAutoWidth:false, //自适应宽度 
	            bDestroy:true,//重新加载使用
	            renderer: "bootstrap",  //渲染样式：Bootstrap和jquery-ui
	            pagingType: "full_numbers",  //分页样式：simple,simple_numbers,full,full_numbers
	            ordering:false,
	            ajax: function (data, callback, settings) {
					if($("#FlOWNAMEQUERY").val()!=""){
						 param.FLOW_NAME = $("#FlOWNAMEQUERY").val();
					}else if($("#FlOWNAMEQUERY").val() == ""){
						 param.FLOW_NAME = "";
					}
					if($("#FlOWSTATEQUERY").val()!="" || $("#FlOWSTATEQUERY").val()!=0){
						 param.FLOW_STATE = $("#FlOWSTATEQUERY").val();
					}
					if($("#SHIPSYSTEMQUERY").val()!="" || $("#SHIPSYSTEMQUERY").val()!=0){
						 param.SYSTEM_ID = $("#SHIPSYSTEMQUERY").val();
					}
	                param.rows = data.length;//页面显示记录条数，在页面显示每页显示多少项的时候
	                param.start = data.start;//开始的记录序号
	                param.page = (data.start / data.length)+1;//当前页码
	                //console.log(param);
	                //ajax请求数据
	                $.ajax({
	                    type: "POST",
	                    url: "rest/workflow/wfConfigManage/getFlowConfig",
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
				        "data": "FLOW_ID", // 数据列名
				        "orderable":false,
				        "sWidth":"40px",
				        "render": function(data, type, full) { // 返回自定义内容
				       		return "<label><input type='checkbox' class='ace' id='flowId' value = '" + data + "' /><span class='lbl' id='postId' value = '" + data + "'></span></label>";
				         }
                    },
                    {
					  	"targets": [1], // 目标列位置，下标从0开始
					  	"sWidth":"30%",
					   	"data": "SYSTEM_NAME",
					   	"render": function(data, type, full) { // 返回自定义内容
	                    	if(data !=null && data!=""){
                                return data;
                            }else{
                                return "";
                            }
				         }
                    },
                    {
					   	"targets": [2], // 目标列位置，下标从0开始
					   	"sWidth":"30%",
					   	"data": "FLOW_NAME",
					   	"render": function(data, type, full) { // 返回自定义内容
	                    	if(data !=null && data!=""){
                                return data;
                            }else{
                                return "";
                            }
				         }
                    },
                    {
					   	"targets": [3], // 目标列位置，下标从0开始
					   	"sWidth":"20%",
					   	"data": "FLOW_STATE_NAME",
					   	"render": function(data, type, full) { // 返回自定义内容
	                    	if(data !=null && data!=""){
                                return data;
                            }else{
                                return "";
                            }
				         }
                    },
                    {
					   	"targets": [4], // 目标列位置，下标从0开始
					   	"sWidth":"20%",
					   	"data": "FLOW_TYPE",
					   	"render": function(data, type, full) { // 返回自定义内容
	                    	if(data !=null && data!=""){
                                return data;
                            }else{
                                return "";
                            }
				         }
                    }
	            ]
	        }).api();
	        //此处需调用api()方法,否则返回的是JQuery对象而不是DataTables的API对象
		    }
	    //点击查询
	    $( "#btnSearch" ).on('click', function(e) {
			loadTableData();
		});
	    
	</script>
	
    <!--	用户树形图    -->
	<script type="text/javascript">
		function tree(pars){
   			var DataSourceTree = function (options) {
   	        	this.url = options.url;
    	    }
	       	 DataSourceTree.prototype.data = function (options, callback) {
	       	    var self = this;
	       	    var $data = null;
	       	    if (!("name" in options) && !("type" in options) && pars.parentMenuId != -1) {
	       	        pars.parentMenuId = 0; //load the first level 
	       	        pars.FLOW_ID = param.FLOW_ID;
	       	    } else if ("type" in options && options.type == "folder") {
	       	        //if ("additionalParameters" in options && "children" in options.additionalParameters) {
	       	        if (options.id!=0) {
	       	            pars.parentMenuId = options.id;
	       	            pars.postMark = options.postMark;
	       	            pars.FLOW_ID = param.FLOW_ID;
	       	        }
	       	    }
       	        $.ajax({
                  type: "POST",
                  url: this.url,
                  cache: false,  //禁用缓存
                  data:pars,
                  dataType: "json",
                  success: function (result) {
                			console.log(result);
                			callback(result);
                  },
                  error:function(){
                  	alert("系统树加载失败");
                  }
              	});
	       	};
	       	$('#treeMenu'+pars.systemId).ace_tree({
	       		dataSource: new DataSourceTree({
	       	    	url: 'rest/workflow/wfConfigManage/getUserTree'
	       	    }),
	       	    multiSelect: true,
	       	    cacheItems: true,
                folderSelect: false
	       	});
	       	param.MONITORs = [];
	       	//加载grid数据（叶子节点）
	       	/* $('#treeMenu'+pars.systemId).on('selected', function(evt, data) {
	         	//遍历被选中的id并且存放到数组中
	         	for(var i=0; i<data.info.length; i++){
	         		param.MONITORs[i] = data.info[i].id;
	         	}
	       	}); */
	      	//加载grid数据（父节点）
	        $('#treeMenu'+pars.systemId).on('closed', function(evt, data) {
	        	
	    	});
	    	$('#treeMenu'+pars.systemId).on('opened', function(evt, data) {
	    		//param.userId=data.id;    //把菜单id放入param中
	    		pars.postMark=data.postMark; 
	    	});
	    	 $('#treeMenu'+pars.systemId).on('loaded', function(evt, data) {
	        	if("item-selected" == this.additionalParameters){
	        		console.log(data);
	        	}
	    	});
   		}
	</script>
	
	<!--弹出框放置位置  添加 删除  查看详情 js脚本实现-->
    <script type="text/javascript">
    	//弹出框顶部样式
    	$.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
			_title: function(title) {
				var $title = this.options.title || '&nbsp;'
				if( ("title_html" in this.options) && this.options.title_html == true )
					title.html($title);
				else title.text($title);
			}
		}));
		
		var thisid = null;   //声明存储当前点击按钮的id的变量
		//添加按钮
		$( "#btnAdd" ).on('click', function(e) {
			$("#parentTree").hide();
			$("#btnTree").hide();
			thisid = this.id;  //获取当前点击按钮的id
			$("#FlOWNAME").val("");
			$("#FlOWSTATE").val("0");
			$("#FLOWTYPE").val("");
			$("#SHIPSYSTEM").val("0");
			$("#receiversDialog").val("");
			msgDialog(e);
		});
		//编辑按钮
		$( "#btnEdit" ).on('click', function(e) {
			$("#parentTree").show();
			$("#btnTree").show();
			thisid = this.id;  //获取当前点击按钮的id
			var Id = $("#flowId:checked").val();
			if(Id == null && Id != 0){
				parent.bootbox.alert("请先选择操作信息", function(){});
				return;
			}else if($("#flowId:checked").length != 1){
				parent.bootbox.alert("只能选择一项", function(){});
				return;
			}else{
				$.ajax({
    	            url: 'rest/workflow/wfConfigManage/getFlow',
    	            data: 'flowId='+Id,
    	            type: 'POST',
    	            dataType: 'json',
    	            success: function (data) {
						//绑定数据
						$("#FlOWNAME").val(data.result[0].FLOW_NAME);
						$("#FlOWSTATE").val(data.result[0].FLOW_STATE);
						$("#FLOWTYPE").val(data.result[0].FLOW_TYPE);
						$("#SHIPSYSTEM").val(data.result[0].SYSTEM_ID);	
						$("#receiversDialog").val(data.monitor);
						param.FLOW_ID = data.result[0].FLOW_ID;
						msgDialog(e);
    				},
                    error: function (jqXHR, textStatus, errorThrown) {
                  	  showError(jqXHR.responseText);
                    }
   	        	});
			}
		});
		
		//点击删除按钮触发的事件
		$( "#btnDelete" ).on('click', function(e) {
			if($("#flowId:checked").length<1){
				bootbox.alert("请选择要删除的流程");
	        	return;
			}
			delInfo();
		});
 
		$( "#btnDesign" ).on('click', function(e) { 
			if($("#flowId:checked").length>1)
			{
				bootbox.alert("只能选择一个操作信息", function(){});
	        	return;
			}
			flowId = $("#flowId:checked").val();
			if(flowId == null || flowId == ""){
				bootbox.alert("请先选择操作信息", function(){});
				return;
			}else{
		        var url="rest/workflow/design";
		        var paramater = "?flowId="+flowId+"&title="+$("#flowId:checked").parent().parent().next().next().text();
		        window.open(encodeURI(encodeURI(url+paramater)), 'flowIdDesign', 'height=618,width=1000,top=50,left=100,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no')
			}
		});
		
		
		//弹出框js函数
		function msgDialog(e){
			e.preventDefault();
				var dialog = $( "#formEdit" ).removeClass('hide').dialog({
					modal: true,
					title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>流程配置</h4></div>",
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
								if(thisid == "btnAdd"){
									if($("#FlOWNAME").val()!=""&&$("#FlOWNAME").val()!=null){
										param.FLOW_NAME = $("#FlOWNAME").val();
									}else{
										parent.bootbox.alert("流程名称不能为空！");
										return;
										}
									param.FLOW_STATE = $("#FlOWSTATE").val();
									if($("#FLOWTYPE").val()!=""&&$("#FLOWTYPE").val()!=null){
										param.FLOW_TYPE = $("#FLOWTYPE").val();
									}else{
										parent.bootbox.alert("流程类型不能为空！");
										return;
										}
									param.SYSTEM_ID = $("#SHIPSYSTEM").val();
									addFlow();
								}
								else if(thisid == "btnEdit"){
									if($("#FlOWNAME").val()!=""&&$("#FlOWNAME").val()!=null){
										param.FLOW_NAME = $("#FlOWNAME").val();
									}else{
										parent.bootbox.alert("流程名称不能为空！");
										return;
										}
									param.FLOW_STATE = $("#FlOWSTATE").val();
									if($("#FLOWTYPE").val()!=""&&$("#FLOWTYPE").val()!=null){
										param.FLOW_TYPE = $("#FLOWTYPE").val();
									}else{
										parent.bootbox.alert("流程类型不能为空！");
										return;
										}
									param.SYSTEM_ID = $("#SHIPSYSTEM").val();
									editFlow();
									if(param.MONITORs.length == 0){
										return;
									}else{
										editMonitor();
									} 
								}
							} 
						}
					]
				});
		}
		
		//添加流程信息
		function addFlow(){
		param.FLOW_ID = 0;
			$.ajax({
				cache: true,
				type: "POST",
				url: "rest/workflow/wfConfigManage/addFlow",
				data: param,
				dataType:"json",
				success: function(data) {
					if(data.result == "success"){
						parent.bootbox.alert("添加成功", function(){});
						loadTableData();
						$( "#formEdit" ).dialog( "close" );
					}else
						showError(data.result);
				},
                error: function (jqXHR, textStatus, errorThrown) {
              	  showError(jqXHR.responseText);
                }
			});
		}
		
		//编辑流程信息
		function editFlow(){
			$.ajax({
				cache: true,
				type: "POST",
				url: "rest/workflow/wfConfigManage/editFlow",
				data: param,
				dataType:"json",
				success: function(data) {
					if(data.result == "success"){
						if(param.MONITORs.length == 0)
						parent.bootbox.alert("更新成功", function(){});
						loadTableData();
						$( "#formEdit" ).dialog( "close" );
					}else{
						showError(data.result);
					}
				},
                error: function (jqXHR, textStatus, errorThrown) {
              	  showError(jqXHR.responseText);
                }
			});
		}
		
		//编辑中的树形菜单信息
		function editMonitor(){
			param.FLOW_ID = $("#flowId:checked").val();
			$.ajax({
				cache: true,
				type: "POST",
				url: "rest/workflow/wfConfigManage/addUser",
				data: param,
				dataType:"json",
				success: function(data) {
					if(data.info == "success"){
						parent.bootbox.alert("更新成功", function(){});
						loadTableData();
						$( "#formEdit" ).dialog( "close" );
	         			param.MONITORs = [];
					}else{
						parent.bootbox.alert("添加失败的flowId为："+data.info, function(){});
					}
				},
                error: function (jqXHR, textStatus, errorThrown) {
              	  showError(jqXHR.responseText);
                }
			});
		}
		
		//删除流程信息
		function delInfo(){
			var delparam = {};
			delparam.flowIds = [];
			for(var i=0; i<$("#flowId:checked").length;i++){
				delparam.flowIds[i] = $("#flowId:checked")[i].defaultValue;
   	        }
   	        if(delparam.flowIds.length <= 0){
						parent.bootbox.alert("请选择流程配置详情", function(){});
						return;
					}
			parent.bootbox.confirm("删除流程会对您已经办理过的工作产生严重影响，您确定要删除吗？", function(result) {
				if(result){
					$.ajax({
						cache: true,
						type: "POST",
						url:"rest/workflow/wfConfigManage/delFlow",
						data:delparam,// 你的flowIds
						async: false,
						dataType:"json",
						success: function(data) {
							if(data.info == "success"){
								parent.bootbox.alert("操作成功");
								loadTableData();
							}else
								parent.bootbox.alert("抱歉，该流程已经被引用，无法删除");
						},
		                error: function (jqXHR, textStatus, errorThrown) {
		              	  //showError(jqXHR.responseText);
		                }
					});
				}else{
					return;
				}
			});
			$(".bootbox-body", parent.document).css("color","#F00");
			$(".bootbox-body", parent.document).css("font-size","16px");
		}

	</script>
    
   <script type="text/javascript">
	//点击添加接收人，弹出树结构
	 var parsOperatorAdd = {}; //加载增加接收者的树的参数
	  var datapar = {};
	  var flags = 0;
		$("#receiverDialog").on('click', function(e) {
				parsOperatorAdd.parentMenuId = -1;
				parsOperatorAdd.systemId = 1;
				parsOperatorAdd.postMark = 0;
				parsOperatorAdd.modelMark=0;
				$("#treeReceiverAdd").remove();
	    		$("#parentTreess").append("<div id='treeReceiverAdd' class='tree'></div>");//追加一个div承载tree
				treeReceiverAdd(parsOperatorAdd);
				if(parsOperatorAdd.parentMenuId == -1){
   					parsOperatorAdd.parentMenuId = 0;
	   			}
				receiverTreeInput();
			});
			function receiverTreeInput(){
				var dialog = $( "#receiverTreeDialog" ).removeClass('hide').dialog({
					modal: true,
					title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i> 接收者</h4></div>",
					title_html: true,
					width:530,
					height:400,
					buttons: [ 
						{
							text: "取消",
							"class" : "btn btn-xs",
							click: function() {
								$( this ).dialog( "close" );
							} 
						},
						{
							text: "确定",
							"class" : "btn btn-primary btn-xs",
							click: function() {
								$("#receiverDialog").val(param.name);
								$( this ).dialog( "close" );
							} 
						}
					]
				});
			}
			 //加载树形结构方法
        	function treeReceiverAdd(parsOperatorAdd){         	
     	    	var params = {};  //声明保存树信息的数组
	   			params.parentOrganId = -1;
	   			tree(params);
	   			if(params.parentOrganId == -1){
	   				params.parentOrganId = 0;
	   			}
	   			function tree(params){
		   			var DataSourceTree = function (options) {
		   	        	this.url = options.url;
		    	    }
			       	 DataSourceTree.prototype.data = function (options, callback) {
			       	    var self = this;
			       	    var $data = null;
			       	    if (!("name" in options) && !("type" in options) && params.parentOrganId != -1) {
			       	        params.parentOrganId = 0; //load the first level  
			       	    } else if ("type" in options && options.type == "folder") {
			       	        if (options.id!=0) {
			       	            params.parentOrganId = options.id;
			       	        }
			       	    }
		       	        $.ajax({
		                  type: "POST",
		                  url: this.url,
		                  cache: false,  //禁用缓存
		                  data: params,
		                  dataType: "json",
		                  success: function (result) {
	                			callback(result);
	                			var cobj = $('#treeReceiverAdd .tree-folder:eq(1)')[0].childNodes[1];
					            if(result.data[0].id == 0){
					           	    cobj.click();
					            }
		                  },
		                  error:function(){
		                  	alert("系统树加载失败");
		                  }
		              	});
			       	};
		       	$('#treeReceiverAdd').ace_tree({
		       		dataSource: new DataSourceTree({
		       	    	url: "rest/workflow/design/getChildNode"
		       	    })
		       	});
		      	//加载grid数据（叶子节点）
		       	$('#treeReceiverAdd').on('selected', function(evt, data) {
		         	//取出ID
		         	param.organId=data.info[0].id;
		         	param.name = data.info[0].name;
		       	});
		      	//加载grid数据（父节点）
		        $('#treeReceiverAdd').on('closed', function(evt, data) {
		        	param.organId=null;//data.id;
		        	param.name = null;//data.name;
		    	});
		    	$('#treeReceiverAdd').on('opened', function(evt, data) {
		    		param.organId=data.id;
		    		param.name = data.name;
		    	});	
		      }
	     }
	       //点击角色账户设置中的查询按钮
		$("#searchMsg").click(function(){
			getDaiFen();
		});
		  //待分配账户
		function getDaiFen(){
			datapar.organId = param.organId;
			if(datapar.organId == null){
				parent.bootbox.alert("请选择非根节点的组织机构", function(){});
			}
			datapar.operateFlag=1;
			datapar.strategy_id = $("#strategy_id:selected").val();
			$.ajax({
	            url: "rest/workflow/design/getUserInfoByOrganId",
	            data: datapar,
	            type: 'POST',
	            dataType: 'json',
	            success: function (result) {
	            	if(flags == 0){
	            		pick = $("#pickList").pickList({data: result.data});
	            		flags++;
	            	}
            		$("#pickData").empty();
            		//pick = $("#pickList").pickList({data: result.data});            		
	            	for(var i=0;i<result.data.length;i++){
	             		$("#pickData").append("<option value='"+result.data[i].userId+"'>"+result.data[i].realName+"</option>");
	            	}
	            },
	            error: function(){
	                parent.bootbox.alert("加载失败", function(){});
	            }
	        });
	    }
	    
			//消息策略添加人员弹出框
			function messageStrategyPerson(e){
				e.preventDefault();
				var dialog = $( "#messageStrategyPerson" ).removeClass('hide').dialog({
					modal: true,
					width:660,
					height:550,
					title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>操作者配置信息</h4></div>",
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
							"class" : "btn btn-xs btn-primary",
							 click: function() {
								 var userIds = "";
							 	 var pickListResultLength=pick.getValues().length;
								/* if(pickListResultLength <= 0){
						    		parent.bootbox.alert("请选择用户。", function(){});
						    	 }else{ */	    	
						    	 	$("#receiversDialog").val(""); 		
						       	    for(var i=0; i<pick.getValues().length; i++){ 
						       	   		userIds += $("#pickListResult option")[i].value+",";
						       	   		param.MONITORs[i] = $("#pickListResult option")[i].value;
						       	   	}	   
						       	   	userIds = userIds.substring(0,userIds.length-1);
									$("#receiversDialog").val(userIds); 		
								 	$( this ).dialog( "close" );
								 	flags = 0;
								 	$("#pickList").empty();
							 	//}
							 } 
						}
					]
				});
			}
			//点击添加接收人，弹出树结构
			$("#receiversDialog").on('click', function(e) {
				//******************************************************
				messageStrategyPerson(e);
				datapar.organId = 0;
				datapar.userIds = $("#receiversDialog").val();
				datapar.operateFlag=1;
				$.ajax({
		            //url: 'design/getUserInfoByOrganId',
		            url: "rest/workflow/design/getUserInfoByOrganId",
		            data: datapar,
		            type: 'POST',
		            dataType: 'json',
		            success: function (result) {
		            	if(flags == 0){
		            		pick = $("#pickList").pickList({data: result.data});
		            		flags++;
		            	}
	            		$("#pickListResult").empty();
		            	for(var i=0;i<result.dataSe.length;i++){
		             		$("#pickListResult").append("<option value='"+result.dataSe[i].userId+"'>"+result.dataSe[i].realName+"</option>");
		            	}
		            },
		            error: function(){
		                parent.bootbox.alert("加载失败", function(){});
		            }
		        });
			});
			</script>
	</body>
</html>


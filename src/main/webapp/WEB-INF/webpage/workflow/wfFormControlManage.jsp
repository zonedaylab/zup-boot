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
		<title>运维监控平台菜单操作项</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	    <!--        引入外部样式库css        -->
        <jsp:include page="../include/mainHead.jsp"></jsp:include>
       <style type="text/css">
       		.bootbox-form strong{
       			display:-moz-inline-box;
	            display:inline-block;
	            width:100px;
       		}
       		li{
       			list-style:none;
       		}
       		.dataTables_wrapper input[type=text], .dataTables_wrapper select{margin: 0;}
       	</style>
       	<link rel="stylesheet" type="text/css" href="plug-in\ace\main\esale\new_css\esale-new-style.css"/>
</head>
<body style="background-color:#FFFFFF;  overflow-x : hidden ;" >
    <div class="row">
    	<!-- 左侧树形图开始 -->
		<div class="col-sm-3 col-xs-12 col-lg-3 fixedLeft" style="margin-top:-3px; paading:0px;">
			<div class="widget-box" style="border-bottom: none;">
				<div class="widget-header header-color-blue2">
					<h4 class="lighter smaller">表单列表</h4>
				</div>
				<div style="margin-left:25px; padding-bottom:10px; padding-top:10px; border-right: 1px solid #ccc;">
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
		
		<div class="col-sm-9 col-xs-12 col-lg-9 widget-body fixedRight">
			<div class="row">
				
			
			<!-- 菜单操作项datables开始 -->
			<div class="table-header">表单组件</div>
			<div class="row">
				<div class="col-md-4" style="margin-left:12px;height:30px; margin-bottom:10px; margin-top:5px;">
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
							<th>组件名称</th>
							<th>组件显示文本</th>
							<th>组件类型</th>
							<th>为空标识</th>
							<th>默认长度</th>
							<th>组件含义</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		<!-- 菜单操作项信息datables结束 -->
		</div>
	</div>
	
	<!--弹出框放置位置  添加 删除  查看详情 布局-->
    <div id="formEdit" class="hide">
		<form class="bootbox-form" id="addOrEditForm" style="margin-left:5px;">
			<input name="CONTROL_ID" id="CONTROL_ID" type="hidden" />
			<input name="FORM_ID" id="FORM_ID" type="hidden" />
            <strong>组件名称：</strong><input name="CONTROL_NAME" id="CONTROL_NAME" type="text" style="height: 30px; width: 160px; margin-bottom:5px; margin-left:4px;"/><br/>
            <strong>组件文本：</strong><input name="CONTROL_TEXT" id="CONTROL_TEXT" type="text" style="height: 30px; width: 160px; margin-bottom:5px; margin-left:4px;"/><br/>
            <strong>组件类型：</strong>
            	<select name="CONTROL_TYPE" id="CONTROL_TYPE"  style="height: 30px; width: 160px; margin-bottom:5px;">
            		
            	</select>
            <br/>
            <strong>为空标识：</strong>
            	<select name="NULL_PERMIT" id="NULL_PERMIT"   style="height: 30px; width: 160px; margin-bottom:5px;">
            		
            	</select>
            <br/>
            <strong>默认长度：</strong><input name="DEFAULT_LENGTH" id="DEFAULT_LENGTH" type="text" style="height: 30px; width: 160px; margin-bottom:5px; margin-left:4px;"/><br/>
            <strong>组件含义：</strong>
           	<select name="CONTROL_MEANING" id="CONTROL_MEANING" style="height: 30px; width: 160px; margin-bottom:5px;">
           		
           	</select><br>
           	<strong>组件状态：</strong>
           	<select name="STATE" id="STATE" style="height: 30px; width: 160px; margin-bottom:5px;">
           		
           	</select><br>
           	<strong>组件显隐性：</strong>
           	<div id="activeList" style="width: 280px; height:300px; margin-bottom:5px; margin-top:5px; border:1px solid #cccccc; padding:10px;">
				
           	</div>
            	
        </form>
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
	       	    }
       	        $.ajax({
                  type: "POST",
                  url: this.url,
                  cache: false,  //禁用缓存
                  data:pars,
                  dataType: "json",
                  success: function (result) {
                 		callback(result);
	                 	var cobj = $("#treeMenu"+pars.systemId+"  .tree-folder:eq(1)")[0].childNodes[1];
			            if(result.data[0].id == 0){
			           	    cobj.click();
			            }
                  },
                  error: function () {
                  	alert("树形图加载失败");
                  }
              	});
	       	};
	       	$('#treeMenu'+pars.systemId).ace_tree({
	       		dataSource: new DataSourceTree({
	       	    	url: 'rest/workflow/workForm/getChildNode'
	       	    })
	       	});
	       	//加载grid数据（叶子节点）
	       	$('#treeMenu'+pars.systemId).on('selected', function(evt, data) {
	         	//取出ID
	         	param.FormID=data.info[0].id;
	       	    loadTableData();
	       	});
	      	//加载grid数据（父节点）
	        $('#treeMenu'+pars.systemId).on('closed', function(evt, data) {
	        	param.FormID=null;//data.id;
	   	     	loadTableData();
	    	});
	    	$('#treeMenu'+pars.systemId).on('opened', function(evt, data) {
	    		if(data.id == 0){
	    			param.FormID=null;
	    		}else{
	    			param.FormID=data.id;
	    		}
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
	                param.rows = data.length;//页面显示记录条数，在页面显示每页显示多少项的时候
	                param.start = data.start;//开始的记录序号
	                param.page = (data.start / data.length)+1;//当前页码
	                //ajax请求数据
	                $.ajax({
	                    type: "POST",
	                    url: "rest/workflow/workForm/controlListQuery",
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
				        "data": "CONTROL_ID", // 数据列名
				        "orderable":false,
				        "sWidth":"40px",
				        "render": function(data, type, full) { // 返回自定义内容
				       		return "<label><input type='checkbox' class='ace' id='actionId' value = '" + data + "' /><span class='lbl' id='sorganid' value = '" + data + "'></span></label>";
				         }
                    },
                    {
					  	"targets": [1], // 目标列位置，下标从0开始
					  	"sWidth":"15%",
					   	"data": "CONTROL_NAME",
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
					   	"sWidth":"15%",
					   	"data": "CONTROL_TEXT",
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
					   	"sWidth":"15%",
					   	"data": "CONTROL_TYPE_NAME",
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
					   	"sWidth":"15%",
					   	"data": "NULL_PERMIT_NAME",
					   	"render": function(data, type, full) { // 返回自定义内容
	                    	if(data !=null && data!=""){
                                return data;
                            }else{
                                return "";
                            }
				         }
                    },
                    {
					   	"targets": [5], // 目标列位置，下标从0开始
					   	"sWidth":"15%",
					   	"data": "DEFAULT_LENGTH",
					   	"render": function(data, type, full) { // 返回自定义内容
	                    	if(data !=null && data!=""){
                                return data;
                            }else{
                                return "";
                            }
				         }
                    },
                    {
					   	"targets": [6], // 目标列位置，下标从0开始
					   	"sWidth":"15%",
					   	"data": "CONTROL_MEANING_NAME",
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
			if(param.FormID == null || param.FormID == "" || param.FormID == "null"){
				parent.bootbox.confirm("请先选择左侧中的表单", function(){});
				return;
			}
			$("#CONTROL_ID").val("0");
			$("#FORM_ID").val(param.FormID);
			$("#CONTROL_NAME").val("");
			$("#CONTROL_TEXT").val("");
			$("#DEFAULT_LENGTH").val("");
			bind(-1,-1,-1);	
			getActiveInfo(param.FormID);
			getActiveState();
			msgDialog(e);
		});
		$( "#btnEdit" ).on('click', function(e) {
			thisid = this.id;  //获取当前点击按钮的id
			if(param.FormID == null || param.FormID == ""){
				parent.bootbox.confirm("请先选择左侧中的表单", function(){});
				return;
			}
			var Id = $("#actionId:checked").val();
			if(Id == null ||Id == ""){
				parent.bootbox.alert("请先选择操作信息", function(){});
				return;
			}else{
				$.ajax({
    	            url: 'rest/workflow/workForm/formControlSee',
    	            data: 'formControlID='+Id,
    	            type: 'POST',
    	            dataType: 'json',
    	            success: function (data) {
						if(data.result == "success"){
							//绑定数据
							$("#CONTROL_ID").val(data.data[0].CONTROL_ID);
							$("#FORM_ID").val(param.FormID);
							$("#CONTROL_NAME").val(data.data[0].CONTROL_NAME);
							$("#CONTROL_TEXT").val(data.data[0].CONTROL_TEXT);
							$("#DEFAULT_LENGTH").val(data.data[0].DEFAULT_LENGTH);
							bind(data.data[0].CONTROL_TYPE,data.data[0].NULL_PERMIT,data.data[0].CONTROL_MEANING);
							getActiveInfo(param.FormID);	
							getActiveState();
							
							
							$("input[name='acId']").each(function(){
								for(var i=0; i<data.activityPopedom.length; i++){
									$("#STATE").val(data.activityPopedom[0].STATE);
									if($(this).val() == data.activityPopedom[i].ACTIVITY_ID)
										$(this).attr("checked", "checked");
								}
								//alert($(this).val());
							});
						}
    				},
                    error: function () {
                  	  
                    }
   	        	});
   	        	msgDialog(e);
			}
			
		});
		
		$( "#btnDelete" ).on('click', function(e) {
			delInfo();
		});

		//绑定各种下拉框
		function bind(controlType,nullPermit,controlPermit){
			//1:绑定组件类型
			$.ajax({
				url:"rest/workflow/workForm/controlTypeBind",
				dataType:"json",
				success: function(data) {
					if(data.result == "success"){
						$("#CONTROL_TYPE").empty();
						$("#CONTROL_TYPE").append("<option value='-1'>请选择</option>");
						for(var i=0; i<data.data.length; i++){
							if(data.data[i].SUB_ID ==  controlType){
								$("#CONTROL_TYPE").append("<option selected='selected' value='"+data.data[i].SUB_ID+"'>"+data.data[i].SUB_NAME+"</option>");
							}
							else{
								$("#CONTROL_TYPE").append("<option value='"+data.data[i].SUB_ID+"'>"+data.data[i].SUB_NAME+"</option>");
							}
	               		}
					}
					else
						showError(data);
				},
                error: function () {
              	  alert("系统错误，绑定组件类型失败。");
                }
			});
			//2:绑定为空标识
			$.ajax({
				url:"rest/workflow/workForm/nullPermitBind",
				dataType:"json",
				success: function(data) {
					if(data.result == "success"){
						$("#NULL_PERMIT").empty();
						$("#NULL_PERMIT").append("<option value='-1'>请选择</option>");
						for(var i=0; i<data.data.length; i++){
							if(data.data[i].SUB_ID ==  nullPermit){
	               				$("#NULL_PERMIT").append("<option selected='selected' value='"+data.data[i].SUB_ID+"'>"+data.data[i].SUB_NAME+"</option>");
							}
							else{
								$("#NULL_PERMIT").append("<option value='"+data.data[i].SUB_ID+"'>"+data.data[i].SUB_NAME+"</option>");
							}
	               		}
					}
					else
						showError(data);
				},
                error: function () {
              	  
                }
			});
			//3:绑定控件含义
			$.ajax({
				url:"rest/workflow/workForm/controlMeaningBind",
				dataType:"json",
				success: function(data) {
					if(data.result == "success"){
						$("#CONTROL_MEANING").empty();
						$("#CONTROL_MEANING").append("<option value='-1'>请选择</option>");
						for(var i=0; i<data.data.length; i++){
							if(data.data[i].SUB_ID ==  controlPermit){
	               				$("#CONTROL_MEANING").append("<option selected='selected' value='"+data.data[i].SUB_ID+"'>"+data.data[i].SUB_NAME+"</option>");
							}
							else{
								$("#CONTROL_MEANING").append("<option value='"+data.data[i].SUB_ID+"'>"+data.data[i].SUB_NAME+"</option>");
							}
	               		}
					}
					else
						showError(data);
				},
                error: function () {
                	alert("系统错误，绑定控件含义失败。");
                }
			});
			
		}
		
		function msgDialog(e){
			e.preventDefault();
			var dialog = $( "#formEdit" ).removeClass('hide').dialog({
				modal: true,
				title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>表单组件设置</h4></div>",
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
								addOrEdit("rest/workflow/workForm/formControlSave");
							}
							else if(thisid == "btnEdit"){
								addOrEdit("rest/workflow/workForm/formControlEdit");
							}
							loadTableData();
							$( this ).dialog( "close" );
						} 
					}
				]
			});
		}
		
		//添加菜单操作项信息
		function addOrEdit(url){
			$.ajax({
				cache: true,
				type: "POST",
				url:url,
				data:$('#addOrEditForm').serialize(),// 你的formid
				async: false,
				dataType:"json",
				success: function(data) {
					if(data.result == "success")
						parent.bootbox.alert("操作成功", function(){});
					else
						showError(data);
				},
                error: function () {
					alert("系统错误，添加菜单操作项信息失败。");
                }
			});
		}
		
		//删除操作项信息
		function delInfo(){
			var delparam = {};
			delparam.Ids = [];
			for(var i=0; i<$(".aceCheckBox:checked").length;i++){
				delparam.Ids[i] = $(".aceCheckBox:checked")[i].defaultValue;
   	        }
			parent.bootbox.confirm("你确定要删除吗？", function(result) {
				if(result){
					if(delparam.Ids.length <= 0){
						parent.bootbox.alert("请选择操作项", function(){});
						return;
					}
					$.ajax({
						cache: true,
						type: "POST",
						url:"rest/workflow/workForm/formControlDelete",
						data:delparam,// 你的formid
						async: false,
						dataType:"json",
						success: function(data) {
							if(data.result == "success"){
								parent.bootbox.alert("操作成功", function(){});
								loadTableData();
							}
							else
								showError(data);
						},
		                error: function () {
		              	  alert("系统错误，删除操作项信息失败。");
		                }
					});
				}else{
					return;
				}
			});
		}

		//根据表单id获取活动id
		function getActiveInfo(formid){
			$.ajax({
				cache: true,
				type: "POST",
				url:"rest/workflow/workForm/getActiveInfo",
				data: "formId="+formid,// 你的formid
				async: false,
				dataType:"json",
				success: function(data) {
					$("#activeList").html("");
					for(var i=0; i<data.data.length; i++){
						$("#activeList").append('<div style="width:100%; height:30px;"><input class="ace" type="checkbox" name="acId" value='+data.data[i].ACTIVITY_ID+'><span class="lbl" style="white-space:nowrap;">'+data.data[i].ACTIVITY_NAME+'</span></div>');
					}
				},
	            error: function () {
	          	  alert("系统错误，获取活动id失败。");
	            }
			});
		}
		
		//根据表单id获取活动id
		function getActiveState(){
			$.ajax({
				cache: true,
				type: "POST",
				url:"rest/workflow/workForm/getActiveState",
				async: false,
				dataType:"json",
				success: function(data) {
					$("#STATE").html("");
					$("#STATE").append("<option value='0'>请选择</option>");
					for(var i=0; i<data.data.length; i++){
						$("#STATE").append('<option value='+data.data[i].SUB_ID+'>'+data.data[i].SUB_NAME+'</option>');
					}
				},
	            error: function () {
	          	  alert("系统错误，获取活动id失败。");
	            }
			});
		}
		
	</script>
    
	</body>
</html>


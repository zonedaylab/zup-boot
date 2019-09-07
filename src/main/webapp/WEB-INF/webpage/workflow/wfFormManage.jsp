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
				<div style="margin-left:25px;padding-bottom:10px; padding-top:10px; border-right: 1px solid #ccc;">
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
			<!-- 表单详情开始 -->
			<div class="table-header" style="margin-left:-12px ;">表单字段</div>
			<div class="row">
				<div class="col-md-12" style="height:30px; margin-bottom:10px; margin-top:5px;">
					<button class="btn btn-primary btn-sm" id="btnAdd">添加</button>
					<button class="btn btn-primary btn-sm" id="btnEdit">编辑</button>
					<button class="btn btn-primary btn-sm" id="btnDelete">删除</button>
					<button class="btn btn-primary btn-sm" id="btnFormAuto">自定义表单</button>
				</div>
				<div class="col-md-7"></div>
			</div>
			<div class="row">
				<strong style="margin-left:10px;">表单ID&nbsp;：&nbsp;&nbsp;</strong><input name="from_FROMID" id="from_FROMID" type="text" style="height: 30px; width: 500px; margin-bottom:5px;"/><br/>
				<strong style="margin-left:10px;">表单名称：</strong><input name="from_FROMNAME" id="from_FROMNAME" type="text" style="height: 30px; width: 500px; margin-bottom:5px;"/><br/>
            	<strong style="margin-left:10px;">表单地址：</strong><input name="from_FROMADDRESS" id="from_FROMADDRESS" type="text" style="height: 30px; width: 500px; margin-bottom:5px;"/><br/>
				<strong style="margin-left:10px;">父级表单：</strong><input name="from_PARENT_FROM" id="from_PARENT_FROM" type="text" style="height: 30px; width: 500px; margin-bottom:5px;"/><br/>
				<strong style="margin-left:10px;">删除业务层：</strong><input name="from_Del_Controller" id="from_Del_Controller" type="text" style="height: 30px; width: 500px; margin-bottom:5px;"/><br/>
			</div>
		</div>	
		<!-- 表单详情结束 -->
	</div>
	
	<!--弹出框放置位置  添加 删除  查看详情 布局-->
    <div id="formEdit" class="hide">
		<form class="bootbox-form" id="addOrEditForm">
            <strong>表单名称：</strong><input name="FROM_NAME" id="FROM_NAME" type="text" style="height: 30px; width: 160px; margin-bottom:5px;"/><br/>
            <strong>表单地址：</strong><input name="FROM_ADDRESS" id="FROM_ADDRESS" type="text" style="height: 30px; width: 160px; margin-bottom:5px;"/><br/>
       		<strong>删除业务的控制层：&nbsp;&nbsp;&nbsp;</strong>
			<input  id="delBizController" type="text" style="height: 30px; width: 160px; margin-bottom:5px;" />
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
                 		var cobj = $("#treeMenu"+pars.systemId+" .tree-folder:eq(1)")[0].childNodes[1];
			            if(result.data[0].id == 0){
			           	    cobj.click();
			            }
                  },
                  error: function (jqXHR, textStatus, errorThrown) {
                	  showError(jqXHR.responseText);
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
	        	getFromInfo();
	       	});
	      	//加载grid数据（父节点）
	        $('#treeMenu'+pars.systemId).on('closed', function(evt, data) {
	        	param.FormID=null;//data.id;
	    	});
	    	$('#treeMenu'+pars.systemId).on('opened', function(evt, data) {
	    		if(data.id == 0){
	    			param.FormID=0;
	    		}else{
	    			param.FormID=data.id;
	    			getFromInfo();
	    		}
	    	});
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
			if(param.FormID == null){
				parent.bootbox.confirm("请先选择左侧中的表单", function(){});
				return;
			}
			param.SYSTEM_ID = $("#systemList").val();
			param.PARENT_FORM_ID = param.FormID;
			$("#FROM_NAME").val("");
			$("#FROM_ADDRESS").val("");
			msgDialog(e);
		});
		$( "#btnEdit" ).on('click', function(e) {
			thisid = this.id;  //获取当前点击按钮的id
			if(param.FormID == null || param.FormID == ""){
				parent.bootbox.confirm("请先选择左侧中的表单", function(){});
				return;
			}else{
				$("#FROM_NAME").val($("#from_FROMNAME").val());
				$("#FROM_ADDRESS").val($("#from_FROMADDRESS").val());
				$("#delBizController").val($("#from_Del_Controller").val());
				param.SYSTEM_ID = $("#systemList").val();
				param.FORM_ID = param.FormID;
				param.PARENT_FORM_ID = $("#from_PARENT_FROM").val();
				msgDialog(e);
			}
		});
		//自定义表单
		$( "#btnFormAuto" ).on('click', function(e) {
			thisid = this.id;  //获取当前点击按钮的id
			if(param.FormID == 0){
				parent.bootbox.confirm("请先选择左侧中的表单", function(){});
				return;
			}
			if(param.FormID != $("#from_FROMID").val() || param.FormID =="0"){
				parent.bootbox.confirm("请选择叶子表单", function(){});
				return;
			}
			if($("#from_FROMADDRESS").val() != ""){
				parent.bootbox.confirm("含有表单地址无法自定义", function(){});
				return;
			}
			console.log(param);
			window.open('rest/workflow/workFormAutoController/getFormAutoInfo?formID='+param.FormID, 'workflow', 'height=818,width=1050,top=50,left=100,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
		});
		
		var par = {};   //声明ajax传输参数的数组变量
		$( "#btnDelete" ).on('click', function(e) {
			par.FormId = param.FormID;
			delFromMenu(par);
			window.reload();
		});
		//弹出框js方法
		function msgDialog(e){
			e.preventDefault();
				var dialog = $( "#formEdit" ).removeClass('hide').dialog({
					modal: true,
					title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>表单字段设置</h4></div>",
					title_html: true,
					height:300,
					width:500,
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
									param.FORM_NAME = $("#FROM_NAME").val();
									param.URL = $("#FROM_ADDRESS").val();
									param.FORM_DELBIZ_CONTROLLER=$("#delBizController").val();
									addFrom();
								}
								else if(thisid == "btnEdit"){
									param.FORM_NAME = $("#FROM_NAME").val();
									param.URL = $("#FROM_ADDRESS").val();
									param.FORM_DELBIZ_CONTROLLER=$("#delBizController").val();
									editFromMenu();
								}
								$(this).dialog( "close" );
							} 
						}
					]
				});
		}
		
		//获取表单详细信息
		function getFromInfo(){
			if(param.FormID == null){
				parent.bootbox.confirm("请先选择左侧中的表单", function(){});
				return;
			}else{
				$.ajax({
    	            url: 'rest/workflow/workForm/FormInfo',
    	            data: 'formid='+param.FormID,
    	            type: 'POST',
    	            dataType: 'json',
    	            success: function (result) {
						$("#from_FROMID").val(result.wfform[0].FORM_ID);
						$("#from_FROMNAME").val(result.wfform[0].FORM_NAME);
            			$("#from_FROMADDRESS").val(result.wfform[0].URL);
						$("#from_PARENT_FROM").val(result.wfform[0].PARENT_FORM_ID);
						$("#from_Del_Controller").val(result.wfform[0].FORM_DELBIZ_CONTROLLER);
    	            },
    	            error: function(){
    	            	parent.bootbox.alert("查看数据失败", function(){});
    	            	return;
    	            }
   	        	});
			}
		}
		
		//添加菜单操作项信息
		function addFrom(){
			$.ajax({
				cache: true,
				type: "POST",
				url: "rest/workflow/workForm/addWorkForm",
				data: param,// 实体
				async: false,
				success: function(data) {
					if(data != null){
   	                	parent.bootbox.alert("添加成功", function(){});
   	                	window.location.reload();
	                }else{
	                	parent.bootbox.alert("添加失败 ");
	                }
				},
                error: function (jqXHR, textStatus, errorThrown) {
              	  showError(jqXHR.responseText);
                }
			});
		}
		
		//编辑表单信息
		function editFromMenu(){
			$.ajax({
   	            url: 'rest/workflow/workForm/WorkFormEdit',
   	            data: param,
   	            type: 'POST',
   	            dataType: 'json',
   	            success: function (data) {
					if(data.result == "success"){
   	                	parent.bootbox.alert("更新成功", function(){});
   	                	window.location.reload();
	                }else{
	                	parent.bootbox.alert("更新失败 ，FromID为：" + data.error, function(){});
	                }
   	            },
   	            error: function(){
   	            	parent.bootbox.alert("更新数据失败", function(){});
   	            	return;
   	            }
 	        });
		}
		
		//删除操作项信息
		function delFromMenu(par){ 
				parent.bootbox.confirm("你确定要删除吗？", function(result) {
					if(result){
			   	        $.ajax({
		    	            url: 'rest/workflow/workForm/WorkFormDelete',
		    	            async: false,
		    	            data: 'formId='+param.FormID,
		    	            type: 'POST',
		    	            dataType: 'json',
		    	            success: function (data) {
		    	                if(data.result == "success"){
		    	                	parent.bootbox.alert("删除成功", function(){});
		    	                	window.location.reload();
		   	                	}else{
		   	                		parent.bootbox.alert("删除 "+data.error, function(){});
		   	                	}
		    	            },
		    	            error: function(){
		    	            	parent.bootbox.alert("删除失败", function(){});
		    	            }
			   	        });
					}else{
						return;
					}
			});
		}
	</script>
    
	</body>
</html>


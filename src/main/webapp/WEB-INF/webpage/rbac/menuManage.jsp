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
		<title>菜单管理-积成能源 运维监控平台</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<!--   引入外部样式库css  -->
        <jsp:include page="../include/mainHead.jsp"></jsp:include>
	</head>
<body style="background-color:#FFFFFF; height:1500px; overflow-x : hidden ;">
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
				<div class="widget-body" style=" height:auto; overflow-y :yes;">
					<div class="widget-main padding-8" id="parenTree" >
						
					</div>
				</div>
			</div>
		</div>
		<!-- 左侧树形图结束 -->
	
        <!-- 菜单详情表单布局 -->
		<div class="col-sm-9 col-xs-12 col-lg-9 widget-body">
			<!-- 菜单详情datables开始 -->
			<div class="table-header">菜单详情</div>
			<div class="row" style="margin-left:-3.66%">
				<div class="col-md-8" style="margin-left:20px;height:30px; margin-bottom:10px; margin-top:5px;">
					<button class="btn btn-primary btn-sm" id="btnAdd">添加</button>
					<button class="btn btn-primary btn-sm" id="btnEdit">编辑</button>
					<button class="btn btn-primary btn-sm" id="btnDelete">删除</button>
				</div>
				<div class="col-md-7"></div>
			</div>
			<div class="form-group">			
			<form class="form-horizontal" role="form">
				<div class="form-group">
					<label class="col-md-6 control-label no-padding-right" for=""> </label>
							<div class="col-sm-6">								
							</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 col-xs-3 control-label no-padding-right" for="organIdForm" style=" position:static; left:10px; letter-spacing: 3px;">所属系统：</label>
					<div class="col-sm-6 col-xs-6">
						<input type="text" id="systemName"  class="col-xs-6 col-sm-5" readonly="readonly"/>
						<input id="systemNameId" type="hidden">
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 col-xs-3 control-label no-padding-right" for="organIdForm" style=" position:static; left:10px; letter-spacing: 3px;">菜单名称：</label>
					<div class="col-sm-6 col-xs-6">
						<input type="text" id="menuName"  class="col-xs-6 col-sm-5" readonly="readonly"/>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 col-xs-3 control-label no-padding-right" for="organCodeForm">父菜单名称：</label>
					<div class="col-sm-6 col-xs-6">
						<input type="text" id="parentMenuName"  class="col-xs-6 col-sm-5" readonly="readonly"/>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 col-xs-3 control-label no-padding-right" for="organIdForm" style=" position:static; left:10px; letter-spacing: 3px;">菜单地址：</label>
					<div class="col-sm-6 col-xs-6">
						<input type="text" id="urlAddress"  class="col-xs-6 col-sm-5" readonly="readonly"/>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 col-xs-3 control-label no-padding-right" for="organCodeForm" style=" position:static; left:10px; letter-spacing: 3px;">命名空间：</label>
					<div class="col-sm-6 col-xs-6">
						<input type="text" id="nameSpace"  class="col-xs-6 col-sm-5" readonly="readonly"/>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 col-xs-3 control-label no-padding-right" for="organIdForm" style=" position:static; left:10px; letter-spacing: 3px;">菜单序号：</label>
					<div class="col-sm-6 col-xs-6">
						<input type="text" id="orderCode"  class="col-xs-6 col-sm-5" readonly="readonly"/>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 col-xs-3 control-label no-padding-right" for="organCodeForm" style=" position:static; left:10px; letter-spacing: 3px;">表单地址：</label>
					<div class="col-sm-6 col-xs-6">
						<input type="text" id="formAddress"  class="col-xs-6 col-sm-5" readonly="readonly" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 col-xs-3 control-label no-padding-right" for="organIdForm" style=" position:static; left:10px; letter-spacing: 3px;">菜单图标：</label>
					<div class="col-sm-6 col-xs-6">
						<input type="text" id="iconStyle"  class="col-xs-6 col-sm-5" readonly="readonly"/>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 col-xs-3 control-label no-padding-right" for="organCodeForm" style=" position:static; left:10px; letter-spacing: 3px;">流程名称：</label>
					<div class="col-sm-6 col-xs-6">
						<select type="text" id="flowId"  class="col-xs-6 col-sm-5" disabled="disabled" >
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 col-xs-3 control-label no-padding-right" for="organCodeForm" style=" position:static; left:10px; letter-spacing: 3px;">菜单类型：</label>
					<div class="col-sm-6 col-xs-6">
						<select type="text" id="mobileFlag"  class="col-xs-6 col-sm-5" disabled="disabled">
						</select>
					</div>
				</div>
			</form>
			</div>
		</div>
		<!-- 菜单详情表单布局结束 -->
		
		<!--弹出框放置位置  添加 删除  查看详情 布局-->
	    <div id="formEdit" class="hide">
			<div class="container">
				<div class="row clearfix">
					<div class="col-md-12 column">
						<form class="form-horizontal" role="form">
							<div class="form-group">
							 	<strong for="projectNameForm" class="col-xs-3 col-md-3 control-label" style="text-align: left" >菜单名称：</strong>
								<div class="col-xs-8 col-md-8">
									<input class="form-control" id="menuNameForm" type="text" />
								</div>
								<div class="col-xs-1 col-md-1" style="margin-top:5px ; margin-left:-14px">
									<font color=red>*</font><br/>
								</div>
							</div> 
							<div class="form-group">
							 	<strong for="belongSystem" class="col-xs-3 col-md-3 control-label" style="text-align: left" >所属系统：</strong>
								<div class="col-xs-8 col-md-8">
									<select class="form-control" id="belongSystem" >
										
									</select>
								</div>
								<div class="col-xs-1 col-md-1" style="margin-top:5px ; margin-left:-14px">
									<font color=red>*</font><br/>
								</div>
							</div>   
							<div class="form-group">
							 	<strong class="col-xs-3 col-md-3 control-label" style="text-align: left;">父菜单名称：</strong>
								<div class="col-xs-8 col-md-8">
									<input class="form-control" id="parentMenuNameForm" type="text" readonly="readonly" />
								</div>
								<div class="col-xs-1 col-md-1">
									
								</div>
							</div>
							<div class="form-group">
							 	<strong for="urlAddressForm" class="col-xs-3 col-md-3 control-label" style="text-align: left" >菜单地址：</strong>
								<div class="col-xs-8 col-md-8">
									<input class="form-control" id="urlAddressForm" type="text" />
								</div>
								<div class="col-xs-1 col-md-1" style="margin-top:5px; margin-left:-14px">
									<font color=red>*</font><br/>
								</div>
							</div>
							<div class="form-group">
							 	<strong for="nameSpaceForm" class="col-xs-3 col-md-3 control-label" style="text-align: left" >命名空间：</strong>
								<div class="col-xs-8 col-md-8">
									<input class="form-control" id="nameSpaceForm" type="text" />
								</div>
								<div class="col-xs-1 col-md-1">
									
								</div>
							</div>
							<div class="form-group">
							 	<strong for="orderCodeForm" class="col-xs-3 col-md-3 control-label" style="text-align: left" >菜单序号：</strong>
								<div class="col-xs-8 col-md-8">
									<input class="form-control" id="orderCodeForm" type="text" />
								</div>
								<div class="col-xs-1 col-md-1">
									
								</div>
							</div>
							<div class="form-group">
							 	<strong for="formAddressForm" class="col-xs-3 col-md-3 control-label" style="text-align: left" >表单地址：</strong>
								<div class="col-xs-8 col-md-8">
									<input class="form-control" id="formAddressForm" type="text" />
								</div>
								<div class="col-xs-1 col-md-1">
									
								</div>
							</div>
							<div class="form-group">
							 	<strong for="iconStyleForm" class="col-xs-3 col-md-3 control-label" style="text-align: left" >菜单图标：</strong>
								<div class="col-xs-8 col-md-8">
									<input class="form-control" id="iconStyleForm" type="text" />
								</div>
								<div class="col-xs-1 col-md-1">
									
								</div>
							</div>
	            			<div class="form-group">
							 	<strong for="iconStyleForm" class="col-xs-3 col-md-3 control-label" style="text-align: left" >流程名称：</strong>
								<div class="col-xs-8 col-md-8">
									<select id="flowIdForm" class="form-control" >
						              	<option value="">请选择</option>
                    					
					            	</select>
								</div>
								<div class="col-xs-1 col-md-1">
									
								</div>
							</div>  
							<div class="form-group">
							 	<strong class="col-xs-3 col-md-3 control-label" style="text-align: left" >菜单类型：</strong>
								<div class="col-xs-8 col-md-8">
									<select id="mobileFlagForm" class="form-control" >
						              	<option value="">请选择</option>
                    					
					            	</select>
								</div>
								<div class="col-xs-1 col-md-1">
									
								</div>
							</div>              
			        </form>
				</div>
			</div>
		</div>
	</div>
	
    <!--  引入js存放的外部脚本库  -->
    <jsp:include page="../include/mainFooter.jsp"></jsp:include>
       
   	<!-- 添加系统下拉框加载和树形图初始化脚本开始 -->
   	<script type="text/javascript">
        //封装请求参数
        var param = {};
        var pars = {};
        var par = {};
        var parentMenu={};//为每个子节点保存其父节点
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
               			$("#belongSystem").append("<option value='"+result.systemList[i].systemId+"'>"+result.systemList[i].systemName+"</option>");
               		}
               		 $("#systemName").val($("#systemList option:checked").text());
               		 $("#systemNameId").val($("#systemList option:checked").val());
               		//网页加载时 装载树形图
					pars.rootOnly = true;
	    			pars.parentMenuId = -1;
					pars.systemId =  $("#systemList").val();
	    			$("#parenTree").append("<div id='treeMenu"+pars.systemId+"' class='tree'></div>");
	    			tree(pars);
	    			if(pars.parentMenuId == -1){
       					pars.parentMenuId = 0;
       				}
       				//当系统下拉框改变时 装载树形图
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
	       				$("#systemName").val($("#systemList option:checked").text());
	    		     });
                 },
                 error:function(){
                 	alert("系统平台名称加载失败");
                 }
             });
   		});
   		//加载菜单树
   		function tree(pars){
   			var DataSourceTree = function (options) {
   	        	this.url = options.url;
    	    }
	       	 DataSourceTree.prototype.data = function (options, callback) {
	       	    var self = this;
	       	    var $data = null;
	       	    if (!("name" in options) && !("type" in options) && pars.parentMenuId != -1) {
	       	        pars.parentMenuId = 0; 
	       	    } else if ("type" in options && options.type == "folder") {
	       	        if (options.id!=0) {
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
                  error:function(){
                  	alert("系统树加载失败");
                  }
              	});
	       	};
	       	
	       	$('#treeMenu'+pars.systemId).ace_tree({
	       		dataSource: new DataSourceTree({
	       	    	url: 'rest/rbac/menuController/getChildNode'
	       	    }),
	       	});
	       	//加载grid数据（叶子节点）
	       	$('#treeMenu'+pars.systemId).on('selected', function(evt, data) {
	         	//取出ID
	         	param.menuId=data.info[0].id;
	         	param.name=data.info[0].name;
	         	getMenu();
	       	});
	      	//加载grid数据（父节点）
	        $('#treeMenu'+pars.systemId).on('closed', function(evt, data) {
	        	param.menuId=data.info[0].id;
	         	param.name=data.info[0].name;
	         	getMenu();
	    	});
	    	$('#treeMenu'+pars.systemId).on('opened', function(evt, data) {
	    		if(data.id == 0){
	    			param.menuId=0;
	    		}else{
	    			param.menuId=data.id;
	    		}
	    		param.menuName=data.name;
    			param.parentMenuId=data.id;
    			param.parentMenuName=data.name;
	    		$("#menuName").val(param.menuName);
	    		$("#parentMenuName").val(param.parentMenuName);
	    		getMenu();
	    	});
	    	 $('#treeMenu'+pars.systemId).on('loaded', function(evt, data) {
	        	if("item-selected" == this.additionalParameters){
	        		//console.log(data);
	        	}
	    	});
	    	//根据系统id获取所有的流程
	  	param.systemId=pars.systemId;
         $.ajax({
	  		type:"POST",
	  		url:"rest/rbac/menuController/getWorkflow",
	  		dataType:"json",
	  		data:param,
	  		success:function(result){
	  			$("#flowIdForm").html("");
	  			$("#flowId").html("");
	  			$("#flowIdForm").append("<option value='0'></option>");
	  			$("#flowId").append("<option value='0'></option>");
	  			
	  			for(var i=0;i<result.data.length;i++){
	  				$("#flowIdForm").append("<option value='"+result.data[i].FLOW_ID+"'>"+result.data[i].FLOW_NAME+"</option>");
	  				$("#flowId").append("<option value='"+result.data[i].FLOW_ID+"'>"+result.data[i].FLOW_NAME+"</option>");
	  			}
	  		}
	  	});
	  	//获取手机端标识
	  	  $.ajax({
	            type: "POST",
	            url: "rest/rbac/menuController/getMobileFlag", 
	            cache: false,  //禁用缓存
	            dataType: "json",
	            success: function (result) {
	       			$("#mobileFlag").html(""); 
	       			$("#mobileFlagForm").html(""); 	
	            	for(var i=0;i<result.data.length;i++){
	             		$("#mobileFlag").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
	             		$("#mobileFlagForm").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
	            	}
	            },
	            error:function(){	            	
	            }
	        });
	    	
   		}
	</script>
	
	<!--增删改查按钮的实现js	-->
    <script type="text/javascript">
    	var par = {};   //声明ajax传输参数的数组变量
    	//增删改查弹出框头部样式
    	$.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
			_title: function(title) {
				var $title = this.options.title || '&nbsp;'
				if( ("title_html" in this.options) && this.options.title_html == true )
					title.html($title);
				else title.text($title);
			}
		}));
		
    	//添加按钮点击事件
		$( "#btnAdd" ).on('click', function(e) {			
			if(param.menuId == null){
			 	parent.bootbox.alert("请选择左侧菜单", function(){});
			 	return;
			 }else{
			 	$("#parentMenuNameForm").val($("#menuName").val());
			 	if($("#parentMenuNameForm").val()==null || $("#parentMenuNameForm").val()==""){
			 		$("#parentMenuNameForm").val("菜单管理")
			 	}
			 	$("#menuNameForm").val("");
			 	$("#belongSystem").attr("disabled","disabled");
			 	$("#belongSystem").val($("#systemList option:checked").val());
				$("#urlAddressForm").val("");
			    $("#nameSpaceForm").val("");
			    $("#orderCodeForm").val("");
			    $("#iconStyleForm").val("");
			    $("#formAddressForm").val("");	
			    //$("#mobileFlagForm").val("");		    
				msgDialog(e, this.id);
			}
		});
		
		//编辑按钮点击事件
		$("#btnEdit").on('click', function(e) {
			if(param.menuId == null){
			 	parent.bootbox.alert("请选择左侧菜单", function(){});
			 	return;
			 }else{
			 	$("#parentMenuNameForm").val($("#parentMenuName").val());
			 	$("#belongSystem").removeAttr("disabled");
			 	$("#belongSystem").val($("#systemList option:checked").val());
			 	$("#menuNameForm").val($("#menuName").val());
				$("#urlAddressForm").val($("#urlAddress").val());
			    $("#nameSpaceForm").val($("#nameSpace").val());
			    $("#orderCodeForm").val($("#orderCode").val());
			    $("#iconStyleForm").val($("#iconStyle").val());
			    $("#formAddressForm").val($("#formAddress").val());
			    $("#flowIdForm").val($("#flowId").val());
			    $("#mobileFlagForm").find("option[value='"+$("#mobileFlag").val()+"']").attr("selected",true);
			 	msgDialog(e, this.id);
			 }
		});
		
		//删除按钮点击事件
		$("#btnDelete").on('click', function(e) {			
			delMenu();
		});
		
		//弹出框主窗体
		function msgDialog(e, thisid){
			e.preventDefault();
				var dialog = $( "#formEdit" ).removeClass('hide').dialog({
					modal: true,
					title: "<div class='widget-header widget-header-small' style='width:335px;'><h4 class='smaller'><i class='icon-ok'></i>菜单设置</h4></div>",
					title_html: true,
					width:480,
					height:530,
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
									par.menuName = $("#menuNameForm").val();
									par.urlAddress = $("#urlAddressForm").val();
								    par.nameSpace= $("#nameSpaceForm").val();
								    par.orderCode= $("#orderCodeForm").val();
								    par.iconStyle= $("#iconStyleForm").val();
								    par.formAddress= $("#formAddressForm").val();
								    par.flowId= $("#flowIdForm").val();
								    par.mobileFlag= $("#mobileFlagForm").val();
									addMenu(par);
								}
								if(thisid == "btnEdit"){
									
								 	par.menuName = $("#menuNameForm").val();
									par.urlAddress = $("#urlAddressForm").val();
								    par.nameSpace= $("#nameSpaceForm").val();
								    par.orderCode= $("#orderCodeForm").val();
								    par.iconStyle= $("#iconStyleForm").val();
								    par.formAddress= $("#formAddressForm").val();
								    par.flowId= $("#flowIdForm").val();
								    par.mobileFlag= $("#mobileFlagForm").val();
								    editMenu(par);
								}
								//$( this ).dialog( "close" );
							} 
						}
					]
				});
		}
		
		//添加菜单信息
		function addMenu(par){			
			 par.parentMenuId=param.menuId;
			 par.systemId = $("#systemList").val();
			 par.urlAddress = $("#urlAddressForm").val();
			 par.menuName=$("#menuNameForm").val();
			 //if(par.parentMenuName == null && par.parentMenuName == ""){
			 	//parent.bootbox.alert("父菜单名字为空，请选择左侧菜单", function(){});
			 	//return;
			 //}
			 if(par.menuName == null || par.menuName == ""){
			 	parent.bootbox.confirm("菜单名字不能为空", function(){});
			 	//return;
			 }else if( par.urlAddress==""|| par.urlAddress==null){
			 	parent.bootbox.alert("菜单地址不能为空", function(){});
			 		}else{
						 $.ajax({
			               type: "POST",
			               url: 'rest/rbac/menuController/addMenu',
			               cache: false,  //禁用缓存
			               data: par,
			               dataType: "json",
			               success: function (result) {
			              		if(result){
			            		    parent.bootbox.alert("添加菜单成功", function(){});
			            		    $( "#formEdit" ).dialog( "close" ); 
			            		    reloadTree();//重新加载树
					           	}else{
					           		parent.bootbox.alert("该菜单名称已存在，请更换菜单名", function(){});
					           	}
			               },
			               error:function(){
			               	   parent.bootbox.alert("保存菜单失败", function(){});
			               }
	          			});
         				}
	  	}
	  	
		//获取菜单信息
		function getMenu(){
			if(param.menuId == null){
			 	parent.bootbox.alert("请选择左侧菜单", function(){});
			 	return;
			 }else{
	  	        $.ajax({
	                 type: "POST",
	                 url: 'rest/rbac/menuController/getMenu',
	                 cache: false,  //禁用缓存
	                 // data: "menuId="+menuId,
	                 data:param,
	                 dataType: "json",
	                 success: function (result) {
	                 		parentMenu=result.data[0].parentMenuId;
	                		$("#menuName").val(result.data[0].menuName);
							$("#urlAddress").val(result.data[0].urlAddress);
						    $("#nameSpace").val(result.data[0].nameSpace);
						    $("#orderCode").val(result.data[0].orderCode);
						    $("#iconStyle").val(result.data[0].iconStyle);
						    $("#formAddress").val(result.data[0].formAddress);
						    $("#flowId").val(result.data[0].flowId);
						    $("#mobileFlag").val(result.data[0].mobileFlag);
	                 },
	                 error:function(){
	                 	parent.bootbox.alert("获取菜单失败", function(){});
	                 }
	           	});
          	}
	  	}
	  	
	  	//编辑菜单信息
		function editMenu(par){
			par.urlAddress = $("#urlAddressForm").val();
			par.menuName=$("#menuNameForm").val();
			par.parentMenuId = parentMenu;
			par.menuId=param.menuId;
			par.systemId = $("#belongSystem option:checked").val();		
		 	if(par.menuName == null || par.menuName == ""){
			 	parent.bootbox.confirm("菜单名字不能为空", function(){});
			 	//return;
			 }else if( par.urlAddress==""|| par.urlAddress==null){
			 			parent.bootbox.alert("菜单地址不能为空", function(){});
			 		}
			 		else{			
			 	        $.ajax({
			                type: "POST",
			                url: 'rest/rbac/menuController/editMenu',
			                cache: false,  //禁用缓存
			                data: par,
			                dataType: "json",
			                success: function (result) {
			             			if(result){
			             				parent.bootbox.alert("更新菜单成功", function(){});
			             				$( "#formEdit" ).dialog( "close" ); 
			             				reloadTree();//重新加载树
			             			}
			             			else{
			             				parent.bootbox.alert("该菜单名称已经存在，请更换菜单名称", function(){});			             				
			             			}
			                },
			                error:function(){
			                	parent.bootbox.alert("更新菜单失败", function(){});
			                }
			          	});
	  				}
	  		}
	  	
	  	//删除菜单信息
		function delMenu(){
			par.menuId = param.menuId;
			if(par.menuId == null || par.menuId == ""){
			 	parent.bootbox.alert("请选择要删除的菜单", function(){});
			 	return;
			 }
			else{
				 bootbox.confirm("你确定要删除吗？", function(result) {
					if(result){			
			  	        $.ajax({
			                 type: "POST",
			                 url: 'rest/rbac/menuController/delMenu',
			                 cache: false,  //禁用缓存
			                 data: par,
			                 dataType: "json",
			                 success: function (result) {
			               			if(result){
			               				parent.bootbox.alert("删除菜单成功", function(){});
			           					reloadTree();//重新加载树
			               			}else{
			               				parent.bootbox.alert("删除菜单失败", function(){});
			               			}
			                 },
			                 error:function(){
			                 	parent.bootbox.alert("删除菜单失败", function(){});
			                 }
			           	});
          			}
	  			});
	  		}
	  	}
	  	//重新加载树
	  	function reloadTree(){
	  		$(".tree").remove();
			pars.rootOnly = true;
   			pars.parentMenuId = -1;
			pars.systemId =  $("#systemList").val();
   			$("#parenTree").append("<div id='treeMenu"+pars.systemId+"' class='tree'></div>");
   			tree(pars);
   			if(pars.parentMenuId == -1){
				pars.parentMenuId = 0;
			}
	  	}
	  	
	</script>
	
    
	</body>
</html>


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
		<title>运维监控平台树形图</title>
		<!--	引入外部样式库css	-->
	    <jsp:include page="../include/mainHead.jsp"></jsp:include>
	    <!--        定义适应屏幕的css样式 -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <style type="text/css">
	        @media (max-width:992px){
				#roleTypeQuery{
					margin-top:15px;
				}
				#POSITIONDEPRESS{
					margin-top:15px;
				}			
			}
        </style>
        <link rel="stylesheet" type="text/css" href="plug-in\ace\main\esale\new_css\esale-new-style.css"/>
</head>
<body style="background-color:#FFFFFF;overflow-x : hidden ;">
    <div class="row1">
		<!-- 左查询条件开始 -->
<div class="row center center-block" style="margin-top:20px;">
<div class="container">
<div class="row clearfix">
<div class="col-md-12 col-xs-12 column">
<form class="form-horizontal" role="form">
<div class="form-group">
<label for="roleNameQuery" class="col-xs-5 col-md-2 control-label" style="text-align: right; height:25px" >角色名称：</label>
<div class="col-xs-4 col-md-3"> 
<input type="text" class="form-control" id="roleNameQuery" />
</div>
<label for="roleTypeQuery" class="col-xs-5 col-md-2 control-label" id="POSITIONDEPRESS" style="text-align: right" >角色类型：</label>
<div class="col-xs-4 col-md-3">
<select id="roleTypeQuery" class="form-control" >
<option value="">&nbsp;</option>
</select>
</div>
<div class="col-md-2 col-xs-3" style=" position:absolute; right:30px; top:0px">
<button class="btn btn-sm btn-primary" type="button" id="search"><i class="icon-ok"></i>查询</button>
</div>
</div>

<div class="form-group">
<label for="acountNameQuery" class="col-xs-5 col-md-2 control-label" style="text-align: right" >账户名称：</label>
<div class="col-xs-4 col-md-3">
<input type="text" class="form-control" id="acountNameQuery" />
</div>
</div>

</form>
</div>
</div>
</div>
</div>

			<!-- 查询条件结束 -->
			<!-- 角色信息datables开始 -->
			<div class="table-header">角色信息</div>
			<div class="row1">
				<div class="col-md-12" style="margin-left:-6px;height:30px; margin-bottom:10px; margin-top:5px;">
					<button class="btn btn-primary btn-sm" id="btnRoleSetting">角色账户设置</button>
					<button class="btn btn-primary btn-sm" id="btnDataActionManageSetting">菜单操作项设置</button>
					<button class="btn btn-primary btn-sm" id="btnDataSetting">数据权限设置</button>
					<button class="btn btn-primary btn-sm" id="btnAdd">添加</button>					
					<button class="btn btn-primary btn-sm" id="btnEdit">编辑</button>
					<button class="btn btn-primary btn-sm" id="btnDelete">删除</button>
				</div>
				<div class="col-md-7"></div>
			</div>
			<div class="table-responsive">
				<table id="roletable" class="table table-striped table-bordered table-hover"  style="margin-bottom:20px;">
					<thead>
						<tr>
							<th>
								<label>
									<input type="checkbox" class="ace" id="allCheck" />
									<span class="lbl"></span>
								</label>
							</th>
							<th>
								角色名称
							</th>
							<th>
								角色类型
							</th>
							<th>
								角色限额
							</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		<!-- 岗位信息datables结束 -->
	</div>
     <!--角色账户设置-->
    <div id="rolaSetting" class="hide">
		<form class="bootbox-form">
            <strong>角色名称：</strong><input class="diarolaname" id="roleAccount" type="text" style="height: 30px; width: 195px; margin-bottom:5px;"/><br/>
            <strong>组织机构：</strong><input class="diaorgan" id="diaOrgan" type="text" style="height: 30px; width: 195px; margin-bottom:5px;"/><br/>
            <strong>账户名称：</strong><input class="dianameserach" id="diaNameSerach" type="text" style="height: 30px; width: 195px; margin-bottom:5px;"/><br/>
          	<button class="btn btn-sm btn-primary " type="button" style="float:right; margin-top:-34px;" id="searchMsg"><i class="icon-ok"></i>查询</button>
		</form>
		<div class="panel panel-default" style="margin-top:10px;">
	        <div class="panel-body">
	           <div id="pickList"></div>
         		<span class="col-md-7 col-lg-7 panel-title" style="">待分配账户</span>
         		<span class="col-md-5 col-lg-5 panel-title" >已分配账户</span>
	           <div class="panel-heading" style="margin-top:10px;">	           
	        </div>
	           <br><br>
	           <div class="row">
		           <div class="col-md-4"></div>
		           <button class="btn btn-primary col-md-4 col-md-offset-4" id="getSelected">保存已分配账户</button>
		           <div class="col-md-4"></div>
	           </div>
	        </div>
     	</div>
	</div>
	<!-- 组织机构树显示 -->
	<div id="treeDialog" class="hide">
    	<!-- 左侧树形图开始 -->
		<div class="col-sm-12 col-xs-12 col-lg-12" style="margin-top:-3px; padding:0px;" id="tree">
			<div class="widget-box">
				<div class="widget-header header-color-blue2">
					<h4 class="lighter smaller">组织机构</h4>
				</div>
				<div class="widget-body">
					<div class="widget-main padding-8" id="orginTree">
						
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!--菜单操作项弹出框-->
    <div id="menuAction" class="hide">
    	<div class="container">
			<div class="row clearfix">
				<div class="col-md-12 column">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							 <strong for="projectNameForm" class="col-xs-12 col-md-4 control-label" style="text-align: left" id="txtRoleName">角色名称</strong>
							<div class="col-xs-12 col-md-7">
								<input class="form-control" id="diaMenuRoleName" type="text" />
							</div>
						</div> 
						<div class="form-group">
							 <strong for="systemList" class="col-xs-12 col-md-4 control-label" style="text-align: left" >系统选择 </strong>
							<div class="col-xs-12 col-md-7"> 
					            <select id="systemList" class="form-control" >
						              <option value="">&nbsp;</option> 
					            </select>
							</div>
						</div>    	
				        <!-- 左侧树形图开始 -->
						<div class="col-sm-12 col-xs-12 col-lg-12" style="margin-top:-3px; margin-left:-5px; padding:0px;" id="tree">
							<div class="widget-box">
								<div class="widget-header header-color-blue2">
									<h4 class="lighter smaller">菜单</h4>
								</div>
								<div class="widget-body">
									<div class="widget-main padding-8" id = "parentTree">
										
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- 左侧树形图结束 -->
	<!--数据设置弹出框-->
    <div id="dataSettings" class="hide">
    	
    		<div class="container">
			<div class="row clearfix">
				<div class="col-md-12 column">
					<form class="bootbox-form">
						<div class="form-group">
							 <strong for="diaRoleName" class="col-xs-12 col-md-3 control-label" style="text-align: left;" >角色名称：</strong>
							<div class="col-xs-12 col-md-3">
								<input class="form-control" id="diaRoleName" type="text" style="margin-bottom:2px;height:30px"/>
							</div>
							 <strong for="accentname" class="col-xs-12 col-md-3 control-label" style="text-align: left;" >账户名称：</strong>
							<div class="col-xs-12 col-md-3">
								<input class="form-control" id="accentname" type="text" style="margin-bottom:2px;height:30px"/>
							</div>
						</div>
						<div class="form-group">
							 <strong for="menuSelect" class="col-xs-12 col-md-3 control-label" style="text-align: left;" >菜单选项：</strong>
							<div class="col-xs-12 col-md-3">
								<input class="form-control" id="menuSelect" type="text" style="margin-bottom:2px;height:30px" />
							</div>
							 <strong for="dataType" class="col-xs-12 col-md-3 control-label" style="text-align: left;" >数据权限类型 ：</strong>
							<div class="col-xs-12 col-md-3"> 
					            <select id="dataType" class="form-control" style="margin-bottom:2px;height:30px">
						              <option value="">&nbsp;</option> 
					            </select>
							</div>
						</div>  
						
						<div class="form-group">
							 <strong for="dataContent" class="col-xs-12 col-md-3 control-label" style="text-align: left;" >数据权限内容：</strong>
							<div class="col-xs-12 col-md-9">
								<input class="form-control" id="dataContent" type="text" style="margin-bottom:2px;" />
							</div>							 
						</div>
    					
    					<div class="form-group">
							<div class="col-xs-12 col-md-12" style="margin-right:5px;height:30px; margin-bottom:10px; margin-top:5px;">
								<button class="btn btn-sm btn-primary col-sd-2" type="button" style="float:right; " id="btnDeleteRoleData"><i class="icon-ok"></i>删除</button>			
							</div>							
						</div>
					</form>
					</div>							
				</div>
			</div>							
		
        <div class="table-responsive">
			<table id="dataTable" class="table table-striped table-bordered table-hover"  style="margin-bottom:20px;">
				<thead>
					<tr>
						<th>
							<label>
								<input type="checkbox" class="ace" id="allCheck" />
								<span class="lbl"></span>
							</label>
						</th>
						<th>
							菜单名称
						</th>
						<th>
							数据权限类型
						</th>
						<th>
							数据权限内容详情
						</th>						
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
	
	</div>
	<!--弹出框放置位置  添加 删除  查看详情-->
    <div id="dialog-message" class="hide">
		<div class="container">
			<div class="row clearfix">
				<div class="col-md-12 column">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							 <strong for="roleName" class="col-xs-3 col-md-3 control-label" style="text-align: left" >角色名称：</strong>
							<div class="col-xs-8 col-md-8">
								<input class="form-control" id="roleName" type="text"/>
							</div>
							<div class="col-xs-1 col-md-1" style="margin-top:8px; margin-left:-14px">
								<font color=red>*</font>
							</div>
						</div>
						<div class="form-group">
							 <strong for="roleLimit" class="col-xs-3 col-md-3 control-label" >角色限额：</strong>
							<div class="col-xs-8 col-md-8">
								<input class="form-control" id="roleLimit" type="number" style="padding-left:5px;"/>
							</div>
						</div>  
						<div class="form-group">
							 <strong for="roleType" class="col-xs-3 col-md-3 control-label">角色类型：</strong>
							<div class="col-xs-8 col-md-8"> 
					            <select id="roleType" class="form-control" >
						              <option value="">&nbsp;</option> 
					            </select>
							</div>
						</div>
       				</form>
				</div> 
			</div>
		</div> 
	</div>
	
	
	
	
	
	<!--数据权限弹出框放置位置 -->
    <div id="dataActionSetting" class="hide">
		<div class="row">
    	<!-- 左侧树形图开始 -->
		<div class="col-sm-3 col-xs-12 col-lg-3" style="margin-top:-3px; paading:0px;">
			<div class="widget-box">
				<div class="widget-header header-color-blue2">
					<h4 class="lighter smaller">菜单管理</h4>
				</div>
				<div style="margin-left:25px; margin-bottom:10px; margin-top:10px;">
					<strong>系统名称：</strong>
					<select class="ipt" id="systemListData" style="height: 30px; width: 160px; ">
					</select>
				</div>
				<div class="widget-body">
					<div class="widget-main padding-8" id="parenTreeData">
					
					</div>
				</div>
			</div>
		</div>
		<!-- 左侧树形图结束 -->
		
		<div class="col-sm-9 col-xs-12 col-lg-9 widget-body">
			 <div style="margin-left:25px; margin-bottom:10px; margin-top:10px;">
					<strong>有无菜单操作项权限：</strong>
    				<input type="radio" value="yes"  name="showAction" id="showActiona" onchange='changeMenuAction()'/>
    				<label>有</label>
    				<input type="radio" value="no"  name="showAction" id="showActionb" onchange='changeMenuAction()' />
     				<label>无</label>
			 </div>
			<!-- 文本框等开始 -->
		    <div class="row center center-block" style="margin-top:0px;">
				<div class="container">
					<div class="row clearfix">
						<div class="col-md-12 column">
						   	<form class="form-horizontal" role="form">
							     <div class="form-group">
									  <strong class="col-xs-5 col-md-2 control-label" style="text-align: right" for="roleName">角色名称：</strong>
									     <div class="col-xs-4 col-md-3">
										     <input type="text" id="roleNameDataManage" class="form-control" readonly="readonly" /><!-- form-field-1 -->
									     </div>				

									  <strong class="col-xs-5 col-md-2 control-label"  style="text-align: right" for="operationSignQuery">操作标志码：</strong>
									      <div class="col-xs-4 col-md-3">
										     <input type="text" id="operationSignQuery" class="form-control" />
									      </div>
									  <div class="col-md-2 col-xs-12" style="position:absolute; top:3px; right:30px">
										  <button class="btn btn-sm btn-primary" type="button" style="float:right; " id="opreationSignsearch"><i class="icon-ok"></i>查询</button>
								      </div> 
					              </div>
						    </form>
						</div> 
					</div>
				</div>
				</div>
			<!-- 菜单操作项datables开始 -->
			<div class="table-header">菜单详情</div> 
			<div class="table-responsive">
				 <button class="btn btn-primary btn-sm" id="btnAlreadyAssigned">已添加操作项</button> 
				<button class="btn btn-primary btn-sm" id="btnUnalreadyAssigned">未添加操作项</button>
			    <button class="btn btn-primary btn-sm" id="btnAddUnAssignedAction">添加</button> 
			    <button class="btn btn-primary btn-sm" id="btnDeleteAssignedAction">删除</button>
				<table id="gridActionData" class="table table-striped table-bordered table-hover"  style="margin-bottom:20px;">
					<thead>
						<tr>
							<th>
								<label>
									<input type="checkbox" class="ace" id="allCheckData" />
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
	</div>
	
	<!--  引入js存放的外部脚本库  -->
	<jsp:include page="../include/mainFooter.jsp"></jsp:include>
	
   	<!-- 加载datables表数据js -->
   	<script type="text/javascript">
        //封装请求参数
        var param = {};   //声明grid查询条件的数据
   		$(function () {
   			loadTableData();
   			findSelectData();
   		});
   		var paramSign = {};
   		function loadOpreationSignSearch(){
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
	        	var table = $("#gridActionData").dataTable({
	        	    "dom": '<t><"col-md-4"i><"col-md-6"p><"col-md-2"l>',    //为表格元素书写css样式<t>为中间表格  在<t>右边就是在表格下边
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
		                paramSign.rows = data.length;//页面显示记录条数，在页面显示每页显示多少项的时候
		                paramSign.start = data.start;//开始的记录序号
		                paramSign.page = (data.start / data.length)+1;//当前页码
		                paramSign.menuId = paramdata.menuId;
		                paramSign.actionCode =$("#operationSignQuery").val();
		                //ajax请求数据
		                $.ajax({
		                    type: "POST",
		                    url: "rest/rbac/roleController/getOperationSignList",
		                    cache: false,  //禁用缓存
		                    data: paramSign,  //传入组装的参数
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
						   	"data": "actionName"
	                    },
	                    {
						   	"targets": [2], // 目标列位置，下标从0开始
						   	"sWidth":"30%",
						   	"data": "caption" // 数据列名
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
        	var table = $("#roletable").dataTable({
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
					if($("#roleNameQuery").val()==""){
						 param.roleName =null;						 						
					}
					else{
						param.roleName = $("#roleNameQuery").val();
					}
					if($("#roleTypeQuery").val()==""){
							param.roleType =null;
					}
					else{						
							param.roleType = $("#roleTypeQuery").val();
					}		
					if($("#acountNameQuery").val()==""){
						 delete param.accountName;						 						
					}
					else{
						param.accountName = $("#acountNameQuery").val();
					}							
	                param.rows = data.length;//页面显示记录条数，在页面显示每页显示多少项的时候
	                param.start = data.start;//开始的记录序号
	                param.page = (data.start / data.length)+1;//当前页码
	                //ajax请求数据
	                $.ajax({
	                    type: "POST",
	                    url: "rest/rbac/roleController/getRoleInfo",
	                    cache: false,  //禁用缓存
	                    data: param,  //传入组装的参数
	                    dataType: "json",
	                    success: function (result) {
	                        //setTimeout仅为测试延迟效果
	                        setTimeout(function () {
	                            //封装返回数据
	                            var returnData = {};
	                            returnData.draw = data.draw;//这里直接自行返回了draw计数器,应该由后台返回
	                            returnData.recordsTotal = result.total;//返回数据全部记录
	                            returnData.recordsFiltered = result.total;//后台不实现过滤功能，每次查询均视作全部结果
	                            returnData.data = result.data;//返回的数据列表
	                            //调用DataTables提供的callback方法，代表数据已封装完成并传回DataTables进行渲染
	                            //此时的数据需确保正确无误，异常判断应在执行此回调前自行处理完毕
	                            callback(returnData);
	                        }, 200);
	                    }
	                });
            	},
            	columnDefs: [
                	{
				    	"targets": [0], // 目标列位置，下标从0开始
				        "data": "roleId", // 数据列名
				        "orderable":false,
				        "sWidth":"15px",
				        "render": function(data, type, full) { // 返回自定义内容
				       		return "<label><input type='checkbox' class='ace' id='roleId' value = '" + data + "' /><span class='lbl' id='sorganid' value = '" + data + "'></span></label>";
				         }
                    },
                    {
					  	"targets": [1], // 目标列位置，下标从0开始
					  	"sWidth":"40%",
					   	"data": "roleName"
                    },
                    {
					   	"targets": [2], // 目标列位置，下标从0开始
					   	"sWidth":"30%",
					   	"data": "roleTypeString" // 数据列名
                    },
                    {
					   	"targets": [3], // 目标列位置，下标从0开始
					   	"sWidth":"30%",
					   	"data": "roleLimit" // 数据列名
                    }
            ]
        }).api();
        //此处需调用api()方法,否则返回的是JQuery对象而不是DataTables的API对象
	    }
	    //获取下拉菜单的内容
	    function findSelectData(){	   
			$.ajax({
	            type: "POST",
	            url: "rest/rbac/roleController/getRoleType", 
	            cache: false,  //禁用缓存
	            dataType: "json",	            
	            success: function (result) {	             		             	
	       			$("#roleTypeQuery").empty(); 	
	       			$("#roleTypeQuery").append("<option value=''>全部</option>");       			
	            	$("#roleType").empty(); 
	            	for(var i=0;i<result.data.length;i++){
	             		$("#roleTypeQuery").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
	             		$("#roleType").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
	            	}
	            },
	            error:function(){	            	
	            }	            
	        });	       
	        $.ajax({
	            type: "POST",
	            url: "rest/rbac/roleController/getDataType", 
	            cache: false,  //禁用缓存
	            dataType: "json",	            
	             success: function (result) {	             	
	       			$("#dataType").html(""); 	
	            	for(var i=0;i<result.data.length;i++){
	             		$("#dataType").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
	            	}
	            },
	            error:function(){	            	
	            }	            
	        });
	        
   		}
    	$("#search").click(function(){
    		loadTableData();
    	});
    	$("#opreationSignsearch").click(function(){
    	    loadOpreationSignSearch();
    	});
    	$("#btnUnalreadyAssigned").click(function(){
    	   $("#btnUnalreadyAssigned").text("* 未添加操作项");
    	   $("#btnAlreadyAssigned").text("已添加操作项");
    	   $("#btnDeleteAssignedAction").hide();
    	   $("#btnAddUnAssignedAction").show();
    	     loadUnSignedActionData();
    	     
    	});
    	$("#btnAlreadyAssigned").click(function(){
    		$("#btnAlreadyAssigned").text("*已添加操作项");
    		$("#btnUnalreadyAssigned").text("未添加操作项");
    		$("#btnDeleteAssignedAction").show();
    	    $("#btnAddUnAssignedAction").hide();
    	     loadSignedActionData();
    	});
    	
	</script>
   	<!-- 左侧树形图加载数据js -->
   	<script type="text/javascript">
        //装载树形tree
        function orginTree(){
            var params = {};  //声明保存树信息的数组
   			$(".tree").remove();
   			params.parentOrganId = -1;
   			$("#orginTree").append("<div id='treeview' class='tree'></div>");
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
                			var cobj = $('#treeview .tree-folder:eq(1)')[0].childNodes[1];
				            if(result.data[0].id == 0){
				           	    cobj.click();
				            }
	                  },
	                  error:function(){
	                  	alert("系统树加载失败");
	                  }
	              	});
		       	};
	       	$('#treeview').ace_tree({
	       		dataSource: new DataSourceTree({
	       	    	url: 'rest/rbac/organController/getChildNode'
	       	    })
	       	});
	      	//加载grid数据（叶子节点）
	       	$('#treeview').on('selected', function(evt, data) {
	         	//取出ID
	         	param.organId=data.info[0].id;
	         	param.name = data.info[0].name;
	       	});
	      	//加载grid数据（父节点）
	        $('#treeview').on('closed', function(evt, data) {
	        	param.organId=null;//data.id;
	        	param.name = null;//data.name;
	    	});
	    	$('#treeview').on('opened', function(evt, data) {
	    		param.organId=data.id;
	    		param.name = data.name;
	    	});	
	      }
        }
    </script>
	
	<!-- 点击组织机构输入框加载树 -->
	<script type="text/javascript">
		$("#diaOrgan").click(function(e){
			orginTree();
			treeDialog(e);
		});
	</script>
	
    <script type="text/javascript">
		var thisid = null;
		$( "#btnRoleSetting" ).on('click', function(e) {
			thisid = this.id;  //获取当前点击按钮的id
			if($("#roleId:checked").length != 1){
				parent.bootbox.alert("只能选择一个角色进行配置", function(){});
				return;
			}
			lookEditPost(e, thisid);
		});
		$( "#btnMenuActionSetting" ).on('click', function(e) {
			thisid = this.id;  //获取当前点击按钮的id
			if($("#roleId:checked").length != 1){
				parent.bootbox.alert("只能选择一个角色进行配置", function(){});
				return;
			}
			lookEditPost(e, thisid);
			
		});
		$( "#btnDeleteRoleData" ).on('click', function(e) {
			thisid = this.id;  //获取当前点击按钮的id
			if($("#dataId:checked").length <1){
				parent.bootbox.alert("请选择要删除的角色数据", function(){});
				return;
			}
			else{			
				deleteRoleData();
			}			
		});
		$( "#btnDataSetting" ).on('click', function(e) {
			thisid = this.id;  //获取当前点击按钮的id	
			if($("#roleId:checked").length != 1){
				parent.bootbox.alert("只能选择一个角色进行配置", function(){});
				return;
			}
			else{
				par.roleId=$("#roleId:checked").val();
				//alert("角色id"+par.roleId);
				getAccountSource(par.roleId);	
				lookEditPost(e, thisid);
			}
			
		});
		$( "#btnAdd" ).on('click', function(e) {
			thisid = this.id;  //获取当前点击按钮的id
			msginput(e);
		});
		$( "#btnEdit" ).on('click', function(e) {
			thisid = this.id;  //获取当前点击按钮的id
			if($("#roleId:checked").length>1)
			{
				parent.bootbox.alert("只能选择一个角色进行编辑", function(){});
	        	return;			
			}else{				
				par.postId = $("#postId:checked").val();
				if(par.roleId == "undefined"){
					parent.bootbox.alert("请先选择要编辑的角色", function(){});
					return;
				}else{					
					lookEditPost(e, this.id);
				}
			}			
		});
		$( "#btnDelete" ).on('click', function(e) {
			if($("#roleId:checked").length <= 0){
				parent.bootbox.alert("请先选择要删除的角色", function(){});
				return;
			}
			else{
				del();
			}
		});

		//弹出数据操作项
		$( "#btnDataActionManageSetting" ).on('click', function(e) {
			thisid = this.id;  //获取当前点击按钮的id
			lookEditPost(e, thisid);
		});

		//弹出添加操作数据操作项
		$( "#btnAddDataManage").on('click', function(e) {			
			thisid = this.id;  //获取当前点击按钮的id
			lookEditPost(e, thisid);
		});
		//弹出删除操作项
		$( "#btnDeleteAssignedAction").on('click', function(e) {
		    thisid=this.id;
		    delActionData();
		});
		$("#btnAddUnAssignedAction").on('click',function(e) {
		    thisid=this.id;
		    saveSignedActionDatas();
		});
		//弹出框  头部样式
		$.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
				_title: function(title) {
					var $title = this.options.title || '&nbsp;'
					if( ("title_html" in this.options) && this.options.title_html == true )
						title.html($title);
					else title.text($title);
				}
			}));
		var par = {};   //声明ajax传输参数的数组变量
		//增删改查弹出框
		function msginput(e){
			e.preventDefault();
			var dialog = $( "#dialog-message" ).removeClass('hide').dialog({
				modal: true,
				title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i> 角色管理操作</h4></div>",
				title_html: true,
				width:450,
				height:300,
				position: { my: "center", at: "center top+30%"},
				
				buttons: [ 
					{
						text: "取消",
						"class" : "btn btn-xs",
						click: function() {
							$( this ).dialog( "close" );
							$("#roleName").val('');
							$("#roleName").removeAttr("readonly");
							$("#roleLimit").val('');
							$("#roleLimit").removeAttr("readonly");
							$("#roleType").val("");
							$("#roleType").removeAttr("readonly"); 
						} 
					},
					
					{
						text: "确定",
						"class" : "btn btn-primary btn-xs",
						click: function() {
							if(thisid == "btnAdd"){
								par.roleName = $("#roleName").val();
								par.roleLimit = $("#roleLimit").val();
								par.roleType = $("#roleType").val();
								btnAdd(par);
							}
							if(thisid == "btnEdit"){
								par.roleName = $("#roleName").val();
								par.roleLimit = $("#roleLimit").val();
								par.roleType = $("#roleType").val();
								btnEdit(e);
							}
						} 
					}
				]
			});
		}
		//树显示
		function treeDialog(e){
			e.preventDefault();
			var dialog = $( "#treeDialog" ).removeClass('hide').dialog({
				modal: true,
				title: "<div class='widget-header widget-header-small' style='width:348px;'><h4 class='smaller'><i class='icon-ok'></i>设置</h4></div>",
				title_html: true,
				width:360,
				height:450,
				
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
							$("#diaOrgan").val(param.name);
							$( this ).dialog( "close" );
						} 
					}
				]
			});
			
		}
		//角色设置     弹出框
		function btnRoleSetting(e){
			e.preventDefault();
			var dialog = $("#rolaSetting").removeClass('hide').dialog({
				modal: true,
				title: "<div class='widget-header widget-header-small' style='width:600px;'><h4 class='smaller'><i class='icon-ok'></i>角色账户设置</h4></div>",
				title_html: true,
				width:615,
				height:610,
				position: { my: "center", at: "center top"},
				buttons: [ 
					{
						text: "关闭",
						"class" : "btn btn-primary btn-xs",
						click: function() {
							loadTableData();
							$( this ).dialog( "close" );
						} 
					}
				]
			});
		}
       	var s = [];
		//菜单操作项设置   弹出框
		function btnMenuActionSetting(e, thisid){
			e.preventDefault();
			var dialog = $("#menuAction").removeClass('hide').dialog({
				modal: true,
				title: "<div class='widget-header widget-header-small' style='width:320px;'><h4 class='smaller'><i class='icon-ok'></i>菜单操作项设置</h4></div>",
				title_html: true,
				width:330,
				height:630,
				position: { my: "center", at: "center top"},
				buttons: [ 
					{
						text: "确定",
						"class" : "btn btn-xs",
						click: function() {
							$("#diaRoleName").show();
    						$("#txtRoleName").show();
							$( this ).dialog( "close" );
						} 
					}/*,
					{
						text: "确定",
						"class" : "btn btn-primary btn-xs",
						click: function() {
				    		if(thisid == "btnMenuActionSetting"){ 
								par.menuId = param.menuId;
								par.roleId = $("#roleId:checked").val();
								loadTableData();
							}else if(thisid == "menuSelect")(
								$("#menuSelect").val(param.menuName)
							)
							$( this ).dialog( "close" );
							$("#diaRoleName").show();
    						$("#txtRoleName").show();
						} 
					}*/
				]
			});
			
		}
		//角色操作项树和系统加载
		//封装请求参数
        var param = {};
        var pars = {};
        var par = {};
   		//添加系统名称下拉框
   		function actionTree(){
   			$.ajax({
                 type: "POST",
                 url: "rest/rbac/menuController/getSystemList",
                 cache: false,  //禁用缓存
                 dataType: "json",
                 success: function (result) {
                 	$("#systemList").find("option").remove();
               		for(var i=0; i<result.systemList.length; i++){
               			$("#systemList").append("<option value='"+result.systemList[i].systemId+"'>"+result.systemList[i].systemName+"</option>");
               		}
               		//网页加载时 装载树形图
   					$(".tree").remove();
					pars.rootOnly = true;
	    			pars.parentMenuId = -1;
	    			pars.roleId = par.roleId;
					pars.systemId =  $("#systemList").val();
	    			$("#parentTree").append("<div id='treeMenu"+pars.systemId+"' class='tree'></div>");
	    			tree(pars);
	    			if(pars.parentMenuId == -1){
       					pars.parentMenuId = 0;
       				}
   					$("#systemList").change(function(){
   						$(".tree").remove();
		    			pars.rootOnly = true;
		    			pars.parentMenuId = -1;
 						pars.systemId =  $("#systemList").val();
		    			$("#parentTree").append("<div id='treeMenu"+pars.systemId+"' class='tree'></div>");
		    			tree(pars);
		    			if(pars.parentMenuId == -1){
	       					pars.parentMenuId = 0;
	       				}
		    		});
                 },
                 error:function(){
                 	alert("系统平台名称加载失败");
                 }
             });
   		}
   		var datapar = {};
   		function tree(pars){
   			var DataSourceTree = function (options) {
   	        	this.url = options.url;
    	    }
	       	 DataSourceTree.prototype.data = function (options, callback) {
	       	    var self = this;
	       	    var $data = null;
	       	    if (!("name" in options) && !("type" in options) && pars.parentMenuId != -1) {
	       	        pars.parentMenuId = 0; //load the first level  
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
	       	    	url: 'rest/rbac/menuController/getMenuAndActionNode'
	       	    }),
	       	    multiSelect: true,
	       	    cacheItems: true,
                folderSelect: false
	       	});
	    	$('#treeMenu'+pars.systemId).on('opened', function(evt, data) {
	    		param.menuId=data.id;    //把菜单id放入param中
	         	//取出ID  
	    		param.menuName=data.name; //把菜单名称放入param中
    			param.parentmenuId=data.id;
    			param.parentMenuName=data.name;
    			param.roleId=pars.roleId;
	    		$("#menuName").val(param.menuName);
	    		$("#parentMenuName").val(param.parentMenuName);
	    	});
	    	 $('#treeMenu'+pars.systemId).on('loaded', function(evt, data) {
	        	if("item-selected" == this.additionalParameters){
	        	}
	        	//叶子节点的click事件，必须要放在loaded事件中，需要loaded之后加载完毕dom之后
	        	$('#treeMenu'+pars.systemId+" .tree-item").off("click");
	        	$('#treeMenu'+pars.systemId+" .tree-item").on("click",function(f) {
					//删除所有cur样式
	        		$(".cur").removeClass("cur");
		        	//为当前追加cur样式
		        	var obj = f.target;
		        	//判断所选元素是否为子节点元素
		        	if(obj.className.indexOf('tree-item-name')>=0){
						obj = obj.parentElement;
			        }
			        //为点击的标签添加类
		        	obj.className+=' cur';
					//获取到点击返回的数据
	        		var data = $('#treeMenu'+pars.systemId).tree("click");
	    	    	parmenus.menuIds = data[0].id;
	    	    	menurole();
		        });	
	    	});
	    	
   		} 	
		$("#menuSelect").click(function(e){ 
    		$("#txtRoleName").hide();
    		$("#diaMenuRoleName").hide();
			btnMenuActionSetting(e, this.id);
			actionTreeselect();
		});

   		function actionTreeselect(){
   			$.ajax({
                 type: "POST",
                 url: "rest/rbac/menuController/getSystemList",
                 cache: false,  //禁用缓存
                 dataType: "json",
                 success: function (result) {
                 	$("#systemList").find("option").remove();
               		for(var i=0; i<result.systemList.length; i++){
               			$("#systemList").append("<option value='"+result.systemList[i].systemId+"'>"+result.systemList[i].systemName+"</option>");
               		}
               		//网页加载时 装载树形图
   					$(".tree").remove();
					pars.rootOnly = true;
	    			pars.parentMenuId = -1;
	    			pars.roleId = par.roleId;
					pars.systemId =  $("#systemList").val();
	    			$("#parentTree").append("<div id='treeMenu"+pars.systemId+"' class='tree'></div>");
	    			treeSelect(pars);
	    			if(pars.parentMenuId == -1){
       					pars.parentMenuId = 0;
       				}
   					$("#systemList").change(function(){
   						$(".tree").remove();
		    			pars.rootOnly = true;
		    			pars.parentMenuId = -1;
 						pars.systemId =  $("#systemList").val();
		    			$("#parentTree").append("<div id='treeMenu"+pars.systemId+"' class='tree'></div>");
		    			treeSelect(pars);
		    			if(pars.parentMenuId == -1){
	       					pars.parentMenuId = 0;
	       				}
		    		});
                 },
                 error:function(){
                 	alert("系统平台名称加载失败");
                 }
             });
   		}
		function treeSelect(pars){
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
	       	    }),
	       	});
	       	//加载grid数据（叶子节点）
	       	$('#treeMenu'+pars.systemId).on('selected', function(evt, data) {
	         	//取出ID
	         	param.menuId=data.info[0].id;
	         	param.menuName=data.info[0].name;
	         	$("#menuName").val(param.menuName);
	         	if($("#parentMenuName").val() == null||$("#parentmenuname").val() == ""){
	         		$("#parentMenuName").val("菜单管理");
	         		param.parentMenuId=0;
	         	} 
	    		$("#menuSelect").val(param.menuName);
	       	});
	      	//加载grid数据（父节点）
	        $('#treeMenu'+pars.systemId).on('closed', function(evt, data) {
	    	});
	    	$('#treeMenu'+pars.systemId).on('opened', function(evt, data) {
	    		param.menuId=data.id;
	    		param.menuName=data.name;
    			param.parentMenuId=data.id;
    			param.parentMenuName=data.name;
	    		$("#menuName").val(param.menuName);
	    		$("#parentMenuName").val(param.parentMenuName); 
	    	});
	    	 $('#treeMenu'+pars.systemId).on('loaded', function(evt, data) {
	        	if("item-selected" == this.additionalParameters){
	        	}
	    	});
	    	
   		}
   		//删除roleData
   		function deleteRoleData(){
   			par.dataIds=[];
   			parent.bootbox.confirm("你确定要删除角色数据权限吗？", function(result) {
				if(result){
					for(var i=0; i<$("#dataId:checked").length;i++){
						par.dataIds[i] = $("#dataId:checked")[i].defaultValue;
						if(par.dataIds.length < 1){
							parent.bootbox.alert("请先选择要删除的角色数据", function(){});
							return;
						}
		   	        }
		   	        $.ajax({
	    	            url: 'rest/rbac/roleController/delRoleData',
	    	            async: false,
	    	            data: par,
	    	            type: 'POST',
	    	            dataType: 'json',
	    	            success: function (result) {
	    	                if(result.result == "success"){
	    	                	parent.bootbox.alert("删除角色数据成功", function(){	
	    	                		loadDataMenu(par);    	                		
	    	                	});
	    	                		    	                	
	   	                	}	   	                	
	    	            },
	    	            error: function(){
	    	            	parent.bootbox.alert("删除角色数据失败", function(){});
	    	            }
		   	        });
		   	       loadTableData();
				}else{
					return;
				}
			});
   			
   		}
   		
   		//获取角色账户数据源
	 	function getAccountSource(roleId){	
	 		var accountNames="";	 		
	 		var accountNames=[];	
	 		$.ajax({
   	            url: 'rest/rbac/roleController/getAccountSource',
   	            async: false,
   	           	data: 'roleId='+roleId,
   	            type: 'POST',
   	            dataType: 'json',
   	            success: function (result) {
   	            	for(var i=0;i<result.data.length;i++){
   	            		accountNames +=result.data[i].accountName+";";
   	            	}  
   	            	$("#accentname").val(accountNames);	            	 	  	            	
   	            },
   	            error: function(){
   	            	parent.bootbox.alert("获取角色账户失败", function(){});
   	            }
  	        	});
	 	}   		
 		//数据权限弹出框 btnDataSetting
   		function btnDataSetting(e){ 
			e.preventDefault();
			var dialog = $("#dataSettings").removeClass('hide').dialog({
				modal: true,
				title: "<div class='widget-header widget-header-small' style='width:600px;'><h4 class='smaller'><i class='icon-ok'></i>数据权限设置</h4></div>",
				title_html: true,
				width:974,
				height:550,
				position: { my: "center", at: "center top"},
				buttons: [ 
					{
						text: "关闭",
						"class" : "btn btn-xs",
						click: function() {
							$("#dataSettings").dialog("close");
						} 
					},
					{
						text: "确定",
						"class" : "btn btn-primary btn-xs",
						click: function() {
							//保存菜单数据权限到数据库中
							datapar.menuId = param.menuId;
							datapar.roleId = $("#roleId:checked").val();
							datapar.dataPermissionType = $("#dataType").val();
							datapar.dataPermission = $("#dataContent").val();
							//判断roledata的属性不为空
							if(datapar.roleId==null||datapar.roleId==""){
								 parent.bootbox.alert("请选择要添加数据的角色");
							}
							if(datapar.menuId==null||datapar.menuId==""){
								 parent.bootbox.alert("请选择要添加数据的菜单");
							}
							else{
								$.ajax({
				    	            url: 'rest/rbac/roleController/addDataMenuRole',
				    	            async: false,
				    	            data: datapar,
				    	            type: 'POST',
				    	            dataType: 'json',
				    	            success: function (result) {
				    	                parent.bootbox.alert("添加菜单数据权限成功", function(){
				    	               		loadDataMenu(par);				    	               	
				    	                });
				    	            },
				    	            error: function(){
				    	            	parent.bootbox.alert("添加失败", function(){});
				    	            }
				   	        	});
							} 
						}
					}
				]
			});
			
		}
		//封装请求参数   数据权限内部表
        var param = {};   //声明grid查询条件的数据
   		$(function () {
   			loadDataTableData();
   		});
	    function loadDataTableData(){
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
    		
        //此处需调用api()方法,否则返回的是JQuery对象而不是DataTables的API对象
	    }
		//添加角色信息
		function btnAdd(par){
			if(par.roleName == ""||par.roleName ==null){
					parent.bootbox.confirm("角色名称不能为空" , function(){});
					//return;
			}else{
				$.ajax({
       	            url: 'rest/rbac/roleController/addRole',
       	            data: par,
       	            type: 'POST',
       	            dataType: 'json',
       	            success: function (result) {
       	            	if(result){
    	                	parent.bootbox.alert("添加成功", function(){
    	                		$( "#dialog-message" ).dialog( "close" );
    	                		loadTableData();
    	                	});
    	                	
   	                	}else{
   	                		parent.bootbox.alert("添加失败", function(){});
   	                	}
       	            },
       	            error: function(){
       	                parent.bootbox.alert("添加失败", function(){});
       	            }
       	        });
       	        loadTableData();
    	    }
		}
		//删除角色信息
		function del(){
			par.roleIds = [];
			//par.roleId = $("#roleId:checked").val();			
				parent.bootbox.confirm("你确定要删除吗？", function(result) {
				if(result){
					for(var i=0; i<$("#roleId:checked").length;i++){
						par.roleIds[i]=$("#roleId:checked")[i].defaultValue;
						//par.roleId = $("#roleId:checked")[i].defaultValue;   //是一个数组所以加上i遍历
					}
				$.ajax({
    	            url: 'rest/rbac/roleController/delRole',
    	            async: false,
    	            data: par,
    	            type: 'POST',
    	            dataType: 'json',
    	            success: function (result) {
    	            if(result.result == "success"){
	    	             parent.bootbox.alert("删除角色成功", function(){});
	    	             loadTableData();
	   	             }
	   	             else if(result.result=="error"){
	   	                 parent.bootbox.alert("角色已被引用，不允许删除："+result.info, function(){});
	   	             }
    	            },
    	            error: function(){
    	            	parent.bootbox.alert("删除失败", function(){});
    	            }
   	        	});
  	            }
				else{
				      return;
				  }			 
		});
		}
		
		var diaRoleName = null;
		//获取到角色用户名，然后放到弹出框的角色名称输入框里
		function lookEditPost(e, thisid){
			par.roleId = $("#roleId:checked").val();
			if(par.roleId == null || par.roleId == ""){
				parent.bootbox.alert("请先选择角色信息", function(){});
				return;
			}else{
				$.ajax({
    	            url: 'rest/rbac/roleController/lookRoleInfo',
    	            data: 'roleId='+par.roleId,
    	            type: 'POST',
    	            dataType: 'json',
    	            success: function (result) {
						diaRoleName = result.roleInfo[0].roleName;
						if(thisid == "btnRoleSetting"){
							$("#roleAccount").val(diaRoleName);
							//$("#diaRoleName").attr("readonly","readonly");
							$("#roleAccount").attr("readonly","readonly");
							$("#diaNameSerach").val("");
							//getAssignedAccount(par.roleId);
							initDaiFen();
							btnRoleSetting(e);
						}else if(thisid == "btnMenuActionSetting"){
							$("#diaMenuRoleName").val(diaRoleName);
							$("#diaMenuRoleName").attr("readonly","readonly");
							actionTree();
							btnMenuActionSetting(e, thisid);
						}else if(thisid == "btnEdit"){
							$("#roleName").val(result.roleInfo[0].roleName);
							$("#roleLimit").val(result.roleInfo[0].roleLimit);
							$("#roleType").find("option[value='"+result.roleInfo[0].roleType+"']").attr("selected",true);
							msginput(e);
						}else if(thisid == "btnDataActionManageSetting"){ 
							par.roleId=result.roleInfo[0].roleId;
							$("#roleNameDataManage").val(result.roleInfo[0].roleName);
							//initActionDataManage();
							initActionData();
							//btnDataActionManageSetting(e,thisid) 
							btnDataActionSetting(e,thisid,par) 
						}else if(thisid == "btnAddDataManage"){ 
							//$("#roleNameDataManage").val(result.roleInfo[0].roleName);
							par.roleId=result.roleInfo[0].roleId;
							initActionData();
							btnDataActionSetting(e,thisid,par) 
						}
						else{
							$("#diaRoleName").val(diaRoleName);
							$("#diaRoleName").attr("readonly","readonly");
							$("#txtRoleName").val(diaRoleName);
    						$("#txtRoleName").attr("readonly","readonly");							
							
							//账户名也是自动获取
							$("#accentname").attr("readonly","readonly");
							loadDataMenu(par);
							btnDataSetting(e);
						}
    	            },
    	            error: function(){
    	            	parent.bootbox.alert("获取数据失败", function(){});
    	            	return;
    	            }
   	        	});
			}
			
		}
		//编辑数据
		function btnEdit(e){
			par.roleId = $("#roleId:checked").val();
			par.roleName = $("#roleName").val();
			par.roleLimit = $("#roleLimit").val();
			par.roleType = $("#roleType").val();
			if(par.roleName == ""||par.roleName ==null){
					parent.bootbox.confirm("角色名称不能为空" , function(){});
					//return;
			}
			else{
				$.ajax({
    	            url: 'rest/rbac/roleController/editRole',
    	            data: par,
    	            type: 'POST',
    	            dataType: 'json',
    	            success: function (result) {    	            	
						parent.bootbox.alert("更新成功", function(){
							$( "#dialog-message" ).dialog( "close" ); 
							loadTableData();
						});
    	            },
    	            error: function(){
    	            	parent.bootbox.alert("更新数据失败", function(){});
    	            	return;
    	            }
   	        	});
			}
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
		//复选框全选
		$("#allCheckDataManage").on('click' , function(){
			var that = this;
			$(this).closest('table').find('tr > td:first-child input:checkbox')
			.each(function(){
				this.checked = that.checked;
				$(this).closest('tr').toggleClass('selected');
			});
		});
		//复选框全选
		$("#allCheckData").on('click' , function(){
			var that = this;
			$(this).closest('table').find('tr > td:first-child input:checkbox')
			.each(function(){
				this.checked = that.checked;
				$(this).closest('tr').toggleClass('selected');
			});
		});
		//添加菜单角色
		var parmenus = {};
		function menurole(){ 
			parmenus.roleId = $("#roleId:checked").val();
			if(parmenus.menuIds == "" && parmenus.menuIds != 0 ){
					parent.bootbox.confirm("菜单为空,请重新点击" , function(){});
					return;
			}else{
				$.ajax({
       	            url: 'rest/rbac/roleController/addMenuRole',
       	            data: parmenus,
       	            type: 'POST',
       	            dataType: 'json',
       	            success: function (result) {
       	            	if(result){
   	                	}else{
   	                		parent.bootbox.alert("删除或者添加失败，请重试", function(){});
   	                	}
       	            },
       	            error: function(){
       	                parent.bootbox.alert("删除或者添加失败，请重试", function(){});
       	            }
       	        });
    	    }
		}
		//点击角色账户设置中的查询按钮
		$("#searchMsg").click(function(){
			if((param.organId == ""||param.organId==null)&&$("#diaNameSerach").val()==""){
				parent.bootbox.alert("请在'组织机构'或'账户名称'输入查询条件。");
				return;
			}
			datapar.accountName = $("#diaNameSerach").val();
			datapar.organId = param.organId;
			if(param.organId == 0){
				delete datapar.organId;
			}
			getDaiFen();
		});
		//创建data传输参数数组
		var datapar = {};
		//声明列表互选控件变量
		var pick = null;
		
		function initDaiFen(){
	    	$.ajax({
	            url: 'rest/rbac/roleController/getAssignedAccountInit',
	            data:"roleId="+par.roleId,	           
	            type: 'POST',		
	            dataType: 'json',
	            success: function (result) {
            		$("#pickList").empty();
            		pick = $("#pickList").pickList({data: result.data});            		
            		$("#pickData").empty();
            		getAssignedAccount(par.roleId);
	            },
	            error: function(){
	                //parent.bootbox.alert("保存失败", function(){});
	            }
	          });
	    }
		//待分配账户
		function getDaiFen(){
			$.ajax({
	            url: 'rest/rbac/roleController/getNoAccount',
	            data: datapar,
	            type: 'POST',
	            dataType: 'json',
	            success: function (result) {
	            	if(result.none=="yes"){
	            		 parent.bootbox.alert("没有待分配的账户。");
	            	}
            		$("#pickData").empty();
            		//pick = $("#pickList").pickList({data: result.data});            		
	            	for(var i=0;i<result.data.length;i++){
	             		$("#pickData").append("<option value='"+result.data[i].accountId+"'>"+result.data[i].accountName+"</option>");
	            	}
	            },
	            error: function(){
	                parent.bootbox.alert("请选择组织机构", function(){});
	            }
	        });
	    }
	    var accountIds=[];
	    var pickListResultLength;
	    //显示已分配账户列表
	    function getAssignedAccount(roleId){	    	
	    	//datapar.organId = param.organId;
	    	//datapar.accountName = $("#diaNameSerach").val();
	    	//datapar.roleId=par.roleId;
	    	$.ajax({
	            url: 'rest/rbac/roleController/getAssignedAccount',
	            data:"roleId="+roleId,	           
	            type: 'POST',		
	            dataType: 'json',
	            success: function (result) {
	           		//$("#pickList").empty();
            		//pick = $("#pickList").pickList({data: result.data});
            	   	//$("#pickListResult").pickListRight({data: result.data});
            		$("#pickData").empty();
	            	for(var i=0;i<result.data.length;i++){
	             		$("#pickListResult").append("<option value='"+result.data[i].accountId+"'>"+result.data[i].accountName+"</option>");
	            		accountIds[i]=result.data[i].accountId;	            		
	            	}
	            	pickListResultLength=pick.getValues().length;            			          		
	            },
	            error: function(){
	                //parent.bootbox.alert("保存失败", function(){});
	            }
	          });
	    }
	    //保存角色账户add
    	$("#getSelected").click(function () {
    		var arpar = {}; 
    		arpar.accountIds=[];//以数组形式添加accountrole
    		arpar.accountIds[0] = -1;
	    	if(pickListResultLength==pick.getValues().length){
	    		parent.bootbox.alert("请选择要操作的账户信息。", function(){});
	    	}
	    	else{ 	    	 		
	       	   for(var i=0; i<pick.getValues().length; i++){ 
	       	   		arpar.accountIds[i]= $("#pickListResult option")[i].value; 	       	   		
	       	   	}	       	   	
      	   		arpar.roleId = par.roleId;
      	   		$.ajax({
		            url: 'rest/rbac/roleController/addAccountRole',
		            data: arpar,
		            type: 'POST',		
		            dataType: 'json',
		            success: function (result) {
		           		if(result){
		           			parent.bootbox.alert("保存成功", function(){
		           				$("#pickListResult").empty();
		           				getAssignedAccount(par.roleId);
		           			});
		           		}
		            },
		            error: function(){
		                parent.bootbox.alert("系统错误，保存失败。请刷新重试。", function(){});
		            }
         		});	
         		}  
        });
	    //添加菜单菜单数据权限
	    
	    function loadDataMenu(par)
	    {
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
        	var table = $("#dataTable").dataTable({
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
	                param.roleId = par.roleId;
	                //ajax请求数据
	                $.ajax({
	                    type: "POST",
	                    url: "rest/rbac/roleController/getRoleDataInfo",
	                    cache: false,  //禁用缓存
	                    data: param,  //传入组装的参数
	                    dataType: "json",
	                    success: function (result) {
	                        //setTimeout仅为测试延迟效果
	                        setTimeout(function () {
	                            //封装返回数据
	                            var returnData = {};
	                            returnData.draw = data.draw;//这里直接自行返回了draw计数器,应该由后台返回
	                            returnData.recordsTotal = result.total;//返回数据全部记录
	                            returnData.recordsFiltered = result.total;//后台不实现过滤功能，每次查询均视作全部结果
	                            returnData.data = result.data;//返回的数据列表 
	                            //调用DataTables提供的callback方法，代表数据已封装完成并传回DataTables进行渲染
	                            //此时的数据需确保正确无误，异常判断应在执行此回调前自行处理完毕
	                            callback(returnData);
	                        }, 200);
	                    }
	                });
            	},
            	columnDefs: [
                	{
				    	"targets": [0], // 目标列位置，下标从0开始
				        "data": "dataId", // 数据列名
				        "orderable":false,
				        "sWidth":"15px",
				        "render": function(data, type, full) { // 返回自定义内容
				       		return "<label><input type='checkbox' class='ace' id='dataId' value = '" + data + "' /><span class='lbl' id='sorganid' value = '" + data + "'></span></label>";
				         }
                    },
                    {
					  	"targets": [1], // 目标列位置，下标从0开始
					  	"sWidth":"33%",
					   	"data": "menuName"
                    },
                    {
					   	"targets": [2], // 目标列位置，下标从0开始
					   	"sWidth":"34%",
					   	"data": "dataPermissionString" // 数据列名
                    },
                    {
					   	"targets": [3], // 目标列位置，下标从0开始
					   	"sWidth":"33%",
					   	"data": "dataPermission" // 数据列名
                    }                    
	           ]
	       }).api();
		}

		//角色操作项弹出框 
		function btnDataActionSetting(e, thisid){
			e.preventDefault();
			var dialog = $("#dataActionSetting").removeClass('hide').dialog({
				modal: true,
				title: "<div class='widget-header widget-header-small' style='width:600px;'><h4 class='smaller'><i class='icon-ok'></i>角色操作项添加</h4></div>",
				title_html: true,
				width:1000,
				height:550,
				position: { my: "center", at: "center top"},
				buttons: [ 
					{
						text: "关闭",
						"class" : "btn btn-primary btn-xs",
						click: function() {							
							$( this ).dialog( "close" );
						} 
					}
				]
			});
		}
		//封装请求参数
        var paramdata = {};
        var parsdata = {};
		function initActionData()
		{
	   		//添加系统名称下拉框
	   		$(document).ready(function(){
	   			$.ajax({
	               type: "POST",
	               url: "rest/rbac/menuController/getSystemList",
	               cache: false,  //禁用缓存
	               dataType: "json",
	               success: function (result) {
	               		$("#systemListData").empty();
	               		for(var i=0; i<result.systemList.length; i++){
	               			$("#systemListData").append("<option value='"+result.systemList[i].systemId+"'>"+result.systemList[i].systemName+"</option>");
	               		}
		    			$(".tree").remove();
						parsdata.rootOnly = true;
		    			parsdata.parentMenuId = -1;
						parsdata.systemId =  $("#systemListData").val();
						parsdata.roleId = $("#roleId:checked").val();
		    			$("#parenTreeData").append("<div id='treeMenuData"+parsdata.systemId+"' class='tree'></div>");  //重新追加一个div来承载tree
		    			treeData(parsdata);
		    			if(parsdata.parentMenuId == -1){
	       					parsdata.parentMenuId = 0;
	       				}
	 					$("#systemListData").change(function(){
			    			$(".tree").remove();
			    			parsdata.rootOnly = true;
			    			parsdata.parentMenuId = -1;
	 						parsdata.systemId =  $("#systemListData").val();
	 						parsdata.roleId = $("#roleId:checked").val();
			    			$("#parenTreeData").append("<div id='treeMenuData"+parsdata.systemId+"' class='tree'></div>");
			    			treeData(parsdata);
			    			if(parsdata.parentMenuId == -1){
		       					parsdata.parentMenuId = 0;
		       				}
		       				paramdata.systemId = $("#systemListData").val();
		       				loadTableActionData();
		    		     });
	               },
	               error:function(){
	               	alert("系统平台名称加载失败");
	               }
	           });
	   		});
		}


	   		//初始化菜单管理树形图
	   		function treeData(parsdata){
	   			var DataSourceTree = function (options) {
	   	        	this.url = options.url;
	    	    }
		       	 DataSourceTree.prototype.data = function (options, callback) {
		       	    var self = this;
		       	    var $data = null;
		       	    if (!("name" in options) && !("type" in options) && parsdata.parentMenuId != -1) {
		       	        parsdata.parentMenuId = 0; //当父节点不为-1时赋值为0，可以到根节点 
		       	    } else if ("type" in options && options.type == "folder") {
		       	       		 if (options.id!="0") {
			       	            parsdata.parentMenuId = options.id;
		       	        }
		       	        else{
		       	        	par.organId=options.id;
		       	        }
		       	    }
	       	        $.ajax({
	                  type: "POST",
	                  url: this.url,
	                  cache: false,  //禁用缓存
	                  data:parsdata,
	                  dataType: "json",
	                  success: function (result) {
	                 		callback(result);
	                 		//默认打开二级
	               			var cobj = $('#treeMenuData'+parsdata.systemId+"  .tree-folder:eq(1)")[0].childNodes[1];
				            if(result.data[0].id == 0){
				           	    cobj.click();
				            }
	                  },
	                  error:function(){
	                  	alert("系统树加载失败");
	                  }
	              	});
		       	};
		       	$('#treeMenuData'+parsdata.systemId).ace_tree({
		       		dataSource: new DataSourceTree({
		       	    	url: 'rest/rbac/menuController/getChildNode'
		       	    })
		       	});
		       	//加载grid数据（叶子节点）
		       	$('#treeMenuData'+parsdata.systemId).on('selected', function(evt, data) {
		         	//取出ID
		         	paramdata.menuId=data.info[0].id;
		         	getMenuPermission();
		         	$("#btnUnalreadyAssigned").text("* 未添加操作项");
		     	    $("#btnAlreadyAssigned").text("已添加操作项");
		     	    $("#btnDeleteAssignedAction").hide();
		     	    $("#btnAddUnAssignedAction").show();
		         	loadUnSignedActionData();
		       	});
		      	//加载grid数据（父节点）
		        $('#treeMenuData'+parsdata.systemId).on('closed', function(evt, data) {
		        	paramdata.menuId=null;//data.id;
		        	getMenuPermission();
		        	$("#btnUnalreadyAssigned").text("* 未添加操作项");
		     	    $("#btnAlreadyAssigned").text("已添加操作项");
		     	    $("#btnDeleteAssignedAction").hide();
		     	    $("#btnAddUnAssignedAction").show();
		         	loadUnSignedActionData();
		    	});
		    	$('#treeMenuData'+parsdata.systemId).on('opened', function(evt, data) {
		    		paramdata.menuId=data.id;
		    		getMenuPermission();
		    		$("#btnUnalreadyAssigned").text("* 未添加操作项");
		     	    $("#btnAlreadyAssigned").text("已添加操作项");
		     	    $("#btnDeleteAssignedAction").hide();
		     	    $("#btnAddUnAssignedAction").show();
		         	loadUnSignedActionData();
		    	}); 
	   		}

		    function loadTableActionData(){
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
	        	var table = $("#gridActionData").dataTable({
	        	    "dom": '<t><"col-md-4"i><"col-md-6"p><"col-md-2"l>',    //为表格元素书写css样式<t>为中间表格  在<t>右边就是在表格下边
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
		                param.roleId =par.roleId;
		                param.menuId = paramdata.menuId;
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
						   	"data": "actionName"
	                    },
	                    {
						   	"targets": [2], // 目标列位置，下标从0开始
						   	"sWidth":"30%",
						   	"data": "caption" // 数据列名
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
 //加载已添加操作项操作项数据
            function loadUnSignedActionData(){
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
	        	var table = $("#gridActionData").dataTable({
	        	    "dom": '<t><"col-md-4"i><"col-md-6"p><"col-md-2"l>',    //为表格元素书写css样式<t>为中间表格  在<t>右边就是在表格下边
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
		                param.roleId =par.roleId;
		                param.menuId = paramdata.menuId;
		                //ajax请求数据
		                $.ajax({
		                    type: "POST",
		                    url: "rest/rbac/roleController/getUnSignedActionList",
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
						   	"data": "actionName"
	                    },
	                    {
						   	"targets": [2], // 目标列位置，下标从0开始
						   	"sWidth":"30%",
						   	"data": "caption" // 数据列名
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
//加载已添加操作项操作项数据
            function loadSignedActionData(){
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
	        	var table = $("#gridActionData").dataTable({
	        	    "dom": '<t><"col-md-4"i><"col-md-6"p><"col-md-2"l>',    //为表格元素书写css样式<t>为中间表格  在<t>右边就是在表格下边
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
		                param.roleId =par.roleId;
		                param.menuId = paramdata.menuId;
		                //ajax请求数据
		                $.ajax({
		                    type: "POST",
		                    url: "rest/rbac/roleController/getSignedActionList",
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
						   	"data": "actionName"
	                    },
	                    {
						   	"targets": [2], // 目标列位置，下标从0开始
						   	"sWidth":"30%",
						   	"data": "caption" // 数据列名
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
		    function initActionDataManage(){
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
	        	var table = $("#gridActionDataManage").dataTable({
	        	   // "dom": '<t><"col-md-4"i><"col-md-6"p><"col-md-2"l>',    //为表格元素书写css样式<t>为中间表格  在<t>右边就是在表格下边
	           		language:lang,  //提示信息
	            	stripeClasses: ["odd", "even"],  //为奇偶行加上样式，兼容不支持CSS伪类的场合
		            serverSide: true,  //启用服务器端分页
		            searching: false,  //禁用原生搜索
		            //bAutoWidth:false, //自适应宽度 
		            bDestroy:true,//重新加载使用
		            renderer: "bootstrap",  //渲染样式：Bootstrap和jquery-ui
		            pagingType: "full_numbers",  //分页样式：simple,simple_numbers,full,full_numbers
		            ordering:false,
		            ajax: function (data, callback, settings) {
		                param.rows = data.length;//页面显示记录条数，在页面显示每页显示多少项的时候
		                param.start = data.start;//开始的记录序号
		                param.page = (data.start / data.length)+1;//当前页码
		                param.roleId = par.roleId;
		                //ajax请求数据
		                $.ajax({
		                    type: "POST",
		                    url: "rest/rbac/roleController/getRoleActionList",
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
					       		return "<label><input type='checkbox' class='ace' id='roleActionId' value = '" + data + "' /><span class='lbl' id='sorganid' value = '" + data + "'></span></label>";
					         }
	                    },
	                    {
						  	"sWidth":"25%",
						  	"targets": [1], // 目标列位置，下标从0开始
						  	"data": "actionName"
	                    },
	                    {
						   	"sWidth":"25%",
						   	"targets": [2], // 目标列位置，下标从0开始						   	
						   	"data": "caption" // 数据列名
	                    },
	                    {
	                    	"sWidth":"25%",
						   	"targets": [3], // 目标列位置，下标从0开始
						   
						   	"data": "actionCode" // 数据列名
	                    },
	                    {
						   "sWidth":"25%",
						   	"targets": [4], // 目标列位置，下标从0开始						   	
						   	"data": "menuName" // 数据列名
	                    }
	            ]
	        }).api();
	        //此处需调用api()方法,否则返回的是JQuery对象而不是DataTables的API对象
		    }
 
			//删除角色操作项信息
			function delActionData(){ 
				par.actionIds = [];
				if($("#actionId:checked").length==0)
				{
					parent.bootbox.alert("请先选择操作信息", function(){});
					return;
				}
				for(var i=0; i<$("#actionId:checked").length;i++){
					par.actionIds[i] = $("#actionId:checked")[i].defaultValue;
					if(par.actionIds == null || par.actionIds.length==0){
						parent.bootbox.alert("请先选择操作信息", function(){});
						return;
					}
	   	        }
				par.roleId = $("#roleId:checked").val();
				if(par.roleId == null || par.roleId == ""){
					parent.bootbox.alert("请选择角色详情？", function(result) {});
				}else{
					parent.bootbox.confirm("你确定要删除吗？", function(result) {
					if(result){ 
						$.ajax({
		    	            url: 'rest/rbac/roleController/delRoleActionDatas',
		    	            async: false,
		    	            data: par,
		    	            type: 'POST',
		    	            dataType: 'json',
		    	            success: function (result) {
		    	                parent.bootbox.alert("删除成功", function(){
		    	                	//initActionDataManage();
		    	                	loadSignedActionData();
		    	                });
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
			}
	//var parsave = {};
			//添加角色操作项信息
			function saveSignedActionDatas(){ 
				par.actionIds = [];
				if($("#actionId:checked").length==0)
				{
					parent.bootbox.alert("请先选择操作信息", function(){});
					return;
				}
				for(var i=0; i<$("#actionId:checked").length;i++){
					par.actionIds[i] = $("#actionId:checked")[i].defaultValue;
					if(par.actionIds == null || par.actionIds.length==0){
						parent.bootbox.alert("请先选择操作信息", function(){});
						return;
					}
	   	        }
				par.roleId = $("#roleId:checked").val();
				if(par.roleId == null || par.roleId == ""){
					parent.bootbox.alert("请选择角色详情？", function(result) {});
				}else{
					parent.bootbox.confirm("你确定要添加吗？", function(result) {
					if(result){ 
						$.ajax({
		    	            url: 'rest/rbac/roleController/saveActionDatas',
		    	            async: false,
		    	            data: par,
		    	            type: 'POST',
		    	            dataType: 'json',
		    	            success: function (result) {
		    	                parent.bootbox.alert("添加成功", function(){
		    	                	loadUnSignedActionData();
		    	                });
		    	            },
		    	            error: function(){
		    	            	parent.bootbox.alert("添加失败", function(){});
		    	            }
		   	        	});
				   	    
					  }else{
					      return;
					  }
				   });
				}
			}
			var parget = {};
			//菜单操作项单选按钮显示
			function getMenuPermission(){
  				parget.menuId = paramdata.menuId;
  				parget.roleId = par.roleId;
		 		$.ajax({
			      type: "POST",
			      url: 'rest/rbac/roleController/getMenuPermission',
			      cache: false,  //禁用缓存
			      data: parget,
			      dataType: "json",
			      async:false,
			      success: function (result) {
			          if(result.data=="true"){
			              $("#showActiona").prop("checked", true);
			              $("#btnAlreadyAssigned").show();
 						  $("#btnUnalreadyAssigned").show();
 						  $("#btnAddUnAssignedAction").show();
 						  $("#btnDeleteAssignedAction").show();
				      }else{
					      $("#showActionb").prop("checked", true);
					      $("#btnAlreadyAssigned").hide();
      					  $("#btnUnalreadyAssigned").hide();
	                      $("#btnAddUnAssignedAction").hide();
		                  $("#btnDeleteAssignedAction").hide();
						  }
			      }
	     		});
			}
			var parChange={};
			//菜单操作项添加删除
			function changeMenuAction(){
			parChange.menuIds=parget.menuId;
			parChange.roleId=parget.roleId;
	 	      $.ajax({
       	            url: 'rest/rbac/roleController/addMenuRole',
       	            data: parChange,
       	            type: 'POST',
       	            dataType: 'json',
       	            async:false,
       	            success: function (result) {
			 	    	 if(result.data=="delete"){
							    parent.bootbox.alert("删除权限成功");
							    $("#btnAlreadyAssigned").hide();
							    $("#btnUnalreadyAssigned").hide();
		                     	$("#btnAddUnAssignedAction").hide();
			                    $("#btnDeleteAssignedAction").hide();
			                    loadTableActionData();
		                 }else{
		                		parent.bootbox.alert("添加权限成功");
		                		 $("#btnAlreadyAssigned").show();
								 $("#btnUnalreadyAssigned").show();
								 $("#btnAddUnAssignedAction").show();
								 $("#btnDeleteAssignedAction").hide();
								 loadUnSignedActionData();
		                 }
       	            },
       	            error: function(){
       	                parent.bootbox.alert("删除或者添加权限失败，请重试", function(){});
       	            }
       	        });	  
	 	     }
	</script>
	
	</body>
</html>


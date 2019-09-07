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
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="plug-in/ace/main/css/index/searchpage.css" rel="stylesheet" type="text/css" />
	    <!-- 引入外部样式库css-->
        <jsp:include page="../include/mainHead.jsp"></jsp:include>
        <!-- 定义适应屏幕的css样式 -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <style type="text/css">
	        @media (max-width:992px){
				#validityQuery{
					margin-top:15px;
				}
				#POSITIONDEPRESS{
					margin-top:15px;
				}			
			}
        </style>
   </head>
   <body style="background-color:#FFFFFF; height:1500px;overflow-x : hidden ;">
     <div class="row">
    	<!-- 左侧树形图开始 -->
		<div class="col-sm-3 col-xs-12 col-lg-3" style="margin-top:-3px; paading:0px;">
			<div class="widget-box">
				<div class="widget-header header-color-blue2">
					<h4 class="lighter smaller">组织机构</h4>
				</div>
				<div class="widget-body">
					<div class="widget-main padding-8" id = "parentTree">
						<div id="treeMenu" class="tree"></div>
					</div>
				</div>
			</div>
		</div>
		<!-- 左侧树形图结束 -->
		
		<!-- 左查询条件开始 -->
		<div class="col-sm-9 col-xs-12 col-lg-9 widget-body">
			<div class="page-header">
				<div class="col-md-6 col-xs-6 col-lg-6">
					<small><i class="icon-double-angle-right"></i>查询条件</small>
				</div>				
			</div>
			<div class="row center center-block" style="margin-top:20px;">
				<div class="container">
					<div class="row clearfix">
						<div class="col-md-12 column">
							<form class="form-horizontal" role="form">
								<div class="form-group ">
									<label class="col-xs-5 col-md-2 control-label" style="text-align: right" for="workname">岗位名称：</label>
									<div class="col-xs-4 col-md-3">								
										<input type="text" id="postNameQuery" class="form-control inputs"/><!-- form-field-1 -->
									</div>							
									<label class="col-xs-5 col-md-2 control-label" id="POSITIONDEPRESS" style="text-align: right" for="validityQuery">有效性：</label>
									<div class="col-xs-4 col-md-3"> 
							            <select id="validityQuery" class="form-control inputs" >
								              <option value="">&nbsp;</option> 
							            </select>
									</div>
									<div class="col-md-2 col-xs-2" style=" position:absolute; right:30px; top:0px">
										<button class="btn btn-sm btn-primary" type="button" style="float:right; height:30px;" id="btnSearch"><i class="icon-ok"></i>查询</button>
									</div>									
								</div>					
							</form>
						</div> 
					</div>
				</div>
			</div>
			<!-- 查询条件结束 -->
			<!-- 岗位信息datables开始 -->
			<div class="table-header">岗位信息</div>
			<div class="row">
				<div class="col-md-6" style="margin-left:20px;height:30px; margin-bottom:10px; margin-top:5px;">
					<!-- <button class="btn btn-primary btn-sm" id="btnLookData">查看详情</button> -->
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
								岗位名称
							</th>
							<th>
								部门名称
							</th>
							<th>
								岗位职责
							</th>
							<th>
								标准人数
							</th>
							<th>
								有效性
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
	
	<!--弹出框放置位置  添加 删除  查看详情-->
    <div id="fromEdit" class="hide">
    	<div class="container">
			<div class="row clearfix">
				<div class="col-md-12 column">
					<form class="form-horizontal" role="form">
						<div class="form-group">
    						 <strong for="postName" class="col-xs-4 col-md-3 control-label" style="text-align: left" >岗位名称：</strong>
							<div class="col-xs-7 col-md-8">
								<input class="form-control" id="postName" type="text" />
							</div>
							<div class="col-xs-1 col-md-1" style="position:absolute; top:7px; right:17px">
								<font color=red>*</font>
							</div>
						</div> 
    					<div class="form-group">
    						 <strong for="bmName" class="col-xs-4 col-md-3 control-label" style="text-align: left" >部门名称：</strong>
							<div class="col-xs-7 col-md-8">
								<input class="form-control" id="bmName" type="text" />
							</div>
						</div> 
  						<div class="form-group">
    						 <strong for="postDuty" class="col-xs-4 col-md-3 control-label" style="text-align: left" >岗位职责：</strong>
							<div class="col-xs-7 col-md-8">
								<input class="form-control" id="postDuty" type="text" />
							</div>
							<div class="col-xs-1 col-md-1" style="position:absolute; top:105px; right:17px">
								<font color=red>*</font>
							</div>
						</div> 
						<div class="form-group">
    						 <strong for="plNum" class="col-xs-4 col-md-3 control-label" style="text-align: left" >标准人数：</strong>
							<div class="col-xs-7 col-md-8">
								<input class="form-control" id="plNum" type="text" />
							</div>
						</div> 
           				<div class="form-group">
							 <strong for="validitysFrom" class="col-xs-4 col-md-3 control-label" style="text-align: left" >有效性 ：</strong>
							<div class="col-xs-7 col-md-8"> 
					            <select id="validitysFrom" class="form-control" >
						              <option value="">&nbsp;</option> 
					            </select>
							</div>
						</div>
        			</form>
				</div> 
			</div>
		</div> 
	</div>
    
    <!--  引入js存放的外部脚本库  -->
    <jsp:include page="../include/mainFooter.jsp"></jsp:include>
	
   	<!-- 加载datables表数据js -->
   	<script type="text/javascript">
        //封装请求参数
        var param = {};
        var flags = false;
   		$(function () {
   			loadTableData();
   			loadList(-1);
   			$("#bmName").val("组织机构");
   			param.organId = 0;
   			flags = true;
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
        	var table = $("#postTable").dataTable({
        	    "dom": '<t><"row"<"col-md-2"l><"col-md-4"i><"col-md-6"p>>',    //为表格元素书写css样式<t>为中间表格  在<t>右边就是在表格下边
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
					if($("#postNameQuery").val()!=""){
						 param.postName = $("#postNameQuery").val();
					}else if($("#postNameQuery").val() == ""){
						param.postName = "";
					}
					if($("#validityQuery").val()!=""){
						param.validFlag = $("#validityQuery").val();
					}else{
						param.validFlag = "";
					}
					if(param.organId == 0){
						delete param.organId;
					}
	                param.rows = data.length;//页面显示记录条数，在页面显示每页显示多少项的时候
	                param.start = data.start;//开始的记录序号
	                param.page = (data.start / data.length)+1;//当前页码
	                //console.log(param);
	                //ajax请求数据
	                $.ajax({
	                    type: "POST",
	                    url: "rest/rbac/postController/girdPostList",
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
				        "data": "postId", // 数据列名
				        "orderable":false,
				        "sWidth":"15px",
				        "render": function(data, type, full) { // 返回自定义内容
				       		return "<label><input type='checkbox' class='ace' id='postId' value = '" + data + "' /><span class='lbl' id='postId' value = '" + data + "'></span></label>";
				         }
                    },
                    {
					  	"targets": [1], // 目标列位置，下标从0开始
					  	"sWidth":"20%",
					   	"data": "postName"
                    },
                      {
					  	"targets": [2], // 目标列位置，下标从0开始
					  	"sWidth":"20%",
					   	"data": "organName"
                    },
                    {
					   	"targets": [3], // 目标列位置，下标从0开始
					   	"sWidth":"20%",
					   	"data": "postDuty" // 数据列名
                    },
                    {
					   	"targets": [4], // 目标列位置，下标从0开始
					   	"sWidth":"20%",
					   	"data": "standardNumber" // 数据列名
                    },
                    {
					   	"targets": [5], // 目标列位置，下标从0开始
					   	"sWidth":"20%",
					   	"data": "validFlagString" // 数据列名
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
			//搜索按钮
	    	$("#btnSearch").click(function(){
	    		loadTableData();
	    	});
		</script>
		
    	<!-- 左侧树形图加载数据js -->
   		<script type="text/javascript">
        //装载树形tree
        jQuery(document).ready(function(){
            var params = {};
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
		       	        params.parentOrganId = 0;
		       	   }else if ("type" in options && options.type == "folder") {
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
	                	var cobj = $("#treeMenu  .tree-folder:eq(1)")[0].childNodes[1];
			            if(result.data[0].id == 0){
			           	    cobj.click();
			           	    if(params.parentOrganId == -1){
								params.parentOrganId = 0;
							}
			            }
	                 },
	                 error:function(){
	                  	alert("系统树加载失败，请刷新重新加载");
	                 }
	              });
			 };
	       	$('#treeMenu').ace_tree({
	       		dataSource: new DataSourceTree({
	       	    	url: 'rest/rbac/organController/getChildNode'
	       	    })
	       	});
	      	//加载grid数据（叶子节点）
	       	$('#treeMenu').on('selected', function(evt, data) {
	         	//取出ID
	         	flags = false;
	         	param.organId=data.info[0].id;
	         	param.name = data.info[0].name;
	       	    loadTableData();
	       	});
	      	//加载grid数据（父节点）
	        $('#treeMenu').on('closed', function(evt, data) {
	        	flags = false;
	        	param.organId=null;//data.id;
	        	param.name = null;//data.name;
	   	     	loadTableData();
	    	});
	    	$('#treeMenu').on('opened', function(evt, data) {
	    		if(data.id == 0){
	    			param.organId=0;
	    		}else{
	    			flags = false;
	    			param.organId=data.id;
		    		param.name = data.name;
		   	     	loadTableData();
	    		}
	    	});	
	      }
        });
        
       	    
    </script>
	
	<!--增删改查弹出框 样式及其数据操作	-->
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
		$("#btnAdd").on('click', function(e) {
			$("#postName").val('');
			$("#postName").removeAttr("readonly");
			if(flags){
				$("#bmName").val("组织机构");
   				param.organId = 0;
			}else{
				$("#bmName").val(param.name);
			}
			
			$("#bmName").attr("readonly","readonly");
			$("#postDuty").val('');
			$("#postDuty").removeAttr("readonly");
			$("#plNum").val("");
			$("#plNum").removeAttr("readonly");
			$("#validitysFrom").removeAttr("disabled");
			if(param.organId == null && param.organId != 0){
				parent.bootbox.alert("请先选择左侧的组织机构", function(){});
				return;
			}else{
				msgDialog(e, this.id);
			}
		});
		$( "#btnLookData" ).on('click', function(e) {
			if(param.organId == null && param.organId != 0){
				parent.bootbox.alert("请先选择左侧的组织机构", function(){});
				return;
			}else{
				$("#postName").attr("readonly","readonly");
				$("#bmName").attr("readonly","readonly");
				$("#postDuty").attr("readonly","readonly");
				$("#plNum").attr("readonly","readonly");
				$("#validitysFrom").attr("disabled", "disabled");
				par.postId = $("#postId:checked").val();
				if(par.postId == null && par.postId != "" || par.postId == "undefined"){
					parent.bootbox.alert("请先选择要查看的岗位", function(){});
					return;
				}else{
					lookPost(e);
					lookDialog(e);
				}
			}
		});
		
		$( "#btnEdit" ).on('click', function(e) {
			if($("#postId:checked").length>1)
			{
				parent.bootbox.alert("只能选择一个岗位进行编辑", function(){});
	        	return;
			}
			if(param.organId == null && param.organId != 0){
				parent.bootbox.alert("请先选择左侧的组织机构", function(){});
				return;
			}else{
				$("#postName").removeAttr("readonly");
				$("#bmName").attr("readonly","readonly");
				$("#postDuty").removeAttr("readonly");
				$("#plNum").removeAttr("readonly"); 
				$("#validitysFrom").removeAttr("disabled");
				par.postId = $("#postId:checked").val();
				if(par.postId == null || par.postId == ""){
					parent.bootbox.alert("请先选择要编辑的岗位", function(){});
					return;
				}else{
					lookPost(e);
					msgDialog(e, this.id);
				}
			}
			
		});
		
		$( "#btnDelete" ).on('click', function(e) {
			if($("#postId:checked").length <= 0){
				parent.bootbox.alert("请先选择要删除的岗位", function(){});
				return;
			}else{
				delPost();
			}
		});
		
		var par = {};   //声明ajax传输参数的数组变量
		function msgDialog(e, thisid){
			e.preventDefault();
				var dialog = $( "#fromEdit" ).removeClass('hide').dialog({
					modal: true,
					width:450,
					title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>岗位管理操作</h4></div>",
					title_html: true,
					buttons: [ 
						{
							text: "取消",
							"class" : "btn btn-xs",
							click: function() {
								$( this ).dialog( "close" );
								$("#postName").val('');
								$("#postName").removeAttr("readonly");
								$("#postDuty").val('');
								$("#postDuty").removeAttr("readonly");
								$("#plNum").val("");
								$("#plNum").removeAttr("readonly"); 
							} 
						},
						{
							text: "保存",
							"class" : "btn btn-primary btn-xs",
							click: function() {
								if(thisid == "btnAdd"){
									par.postName = $("#postName").val();									
									par.organId = param.organId;
									par.postDuty = $("#postDuty").val();
									par.standardNumber = $("#plNum").val();
									par.validFlag = $("#validitysFrom").val();
									addPost(par);
								}
								if(thisid == "btnEdit"){
									par.postId = $("#postId:checked").val();
									par.organId = param.organId;
									par.postName = $("#postName").val();
									par.postDuty = $("#postDuty").val();
									par.standardNumber = $("#plNum").val();
									par.validFlag = $("#validitysFrom").val();	
									editPost(par);
								}
								//$("#postName").val('');
								//$("#postName").removeAttr("readonly");
								//$("#postDuty").val('');
								//$("#postDuty").removeAttr("readonly");
								//$("#plNum").val("");
								//$("#plNum").removeAttr("readonly");
								//$("#validitysm").val("");
								//$("#validitys").removeAttr("disabled");
								//$( this ).dialog( "close" );
							} 
						}
					]
				});
		}
		
		function lookDialog(e){
			e.preventDefault();
				var dialog = $( "#fromEdit" ).removeClass('hide').dialog({
					modal: true,
					title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>岗位管理操作</h4></div>",
					title_html: true,
					buttons: [ 
						{
							text: "关闭",
							"class" : "btn btn-primary btn-xs",
							click: function() {
								$("#postName").val('');
								$("#postName").removeAttr("readonly");
								$("#postDuty").val('');
								$("#postDuty").removeAttr("readonly");
								$("#plNum").val("");
								$("#plNum").removeAttr("readonly");
								$("#validitysm").val("");
								$("#validitysFrom").removeAttr("disabled");
								$( this ).dialog( "close" );
							} 
						}
					]
				});
		}
		
		//添加岗位信息
		function addPost(par){		
			if(par.postName ==null || par.postName==""){
				parent.bootbox.alert("岗位名字不能为空" , function(){});
			}
			else if(par.postDuty == null|| par.postDuty==""){
					parent.bootbox.alert("岗位职责不能为空" , function(){});
					//return;
					}else{
						$.ajax({
		       	            url: 'rest/rbac/postController/addPost',
		       	            data: par,
		       	            type: 'POST',
		       	            dataType: 'json',
		       	            success: function (result) {
		       	            //console.log(result.result);
		       	            	if(result.result=="yes"){
		    	                	parent.bootbox.alert("添加岗位成功", function(){
		    	                	$( "#fromEdit" ).dialog( "close" ); 
    	                			loadTableData();
    	                		});
   	                			}
   	                			else{	
   	                				parent.bootbox.alert("岗位名称已经存在，请更换岗位名称", function(){});
   	                			}
       	            		},
       	            		error: function(){
       	               		 	parent.bootbox.alert("系统错误！添加岗位失败，请刷新重新添加", function(){});
       	            		}
       	       			 });
       	        		//loadTableData();
       	             }
		}
		
		//删除岗位信息
		function delPost(){
			par.actionIds = [];
				parent.bootbox.confirm("你确定要删除岗位吗？", function(result) {
				if(result){
					for(var i=0; i<$("#postId:checked").length;i++){
						par.actionIds[i] = $("#postId:checked")[i].defaultValue;
						if(par.actionIds.length < 1){
							parent.bootbox.alert("请先选择要删除的岗位", function(){});
							return;
						}
		   	        }
		   	        $.ajax({
	    	            url: 'rest/rbac/postController/delPost',
	    	            async: false,
	    	            data: par,
	    	            type: 'POST',
	    	            dataType: 'json',
	    	            success: function (result) {
	    	                if(result.result == "success"){
	    	                	parent.bootbox.alert("删除岗位成功", function(){});
	    	                	loadTableData();
	   	                	}
	   	                	else if(result.result=="error"){
	   	                		parent.bootbox.alert("该岗位已被引用，不允许删除："+result.info, function(){});
	   	                	}
	    	            },
	    	            error: function(){
	    	            	parent.bootbox.alert("该岗位已被引用，不允许删除", function(){});
	    	            }
		   	        });
		   	       loadTableData();
				}else{
					return;
				}
			});
		}
		//填充下拉框数据
		function loadList(validFlag){
			//通过枚举获取有效性
	         $.ajax({
	            type: "POST",
	            url: "rest/rbac/userController/getValidFlag", 
	            cache: false,  //禁用缓存
	            dataType: "json",
	            success: function (result) {
	       			$("#validityQuery").empty();
	       			$("#validityQuery").append("<option value=''>全部</option>");
	       			$("#validitysFrom").empty();
	       			$("#validitysFrom").append("<option value=''></option>");
	            	for(var i=0;i<result.data.length;i++){
	            		$("#validityQuery").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
	            		if(validFlag == -1)
	             			$("#validitysFrom").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
	             		else {
	             			if(result.data[i].subid == validFlag)
	             				$("#validitysFrom").append("<option selected='selected' value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
             				else
             					$("#validitysFrom").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
         				}
	            	}
	            }
	        });
		}
		
		//查看岗位信息
		function lookPost(e){
			$.ajax({
   	            url: 'rest/rbac/postController/getPost',
   	            data: 'postId='+par.postId,
   	            type: 'POST',
   	            dataType: 'json',
   	            success: function (result) {
   	                $("#postName").val(result.postinfo[0].postName);
					$("#bmName").val(result.organinfo.organName);
					param.organId = result.postinfo[0].organId;
					$("#postDuty").val(result.postinfo[0].postDuty);
					$("#plNum").val(result.postinfo[0].standardNumber);
					loadList(result.postinfo[0].validFlag);
					//$("#validitysFrom").find("option [value='"+result.postinfo[0].validFlag+"']").attr("selected",true);
   	            },
   	            error: function(){
   	            	parent.bootbox.alert("系统错误，获取数据失败！请刷新重新操作", function(){});
   	            	return;
   	            }
  	        });
		}
		//编辑数据
		function editPost(e){
			if(par.postName ==null || par.postName==""){
				parent.bootbox.confirm("岗位名字不能为空" , function(){});
			}else if(par.postDuty == null|| par.postDuty==""){
				parent.bootbox.confirm("岗位职责不能为空" , function(){});
				return;
			}else{				
			   $.ajax({
    	            url: 'rest/rbac/postController/editPost',
    	            data: par,
    	            type: 'POST',
    	            dataType: 'json',
    	            success: function (result) {
    	            	if(result.result=="success"){
	  	            		parent.bootbox.alert("更新成功", function(){
	  	            			$( "#fromEdit" ).dialog( "close" ); 
								loadTableData();
	  	           			});
  	            		}
	  	            	else{
	  	            		parent.bootbox.alert("岗位名称已经存在，请更换岗位名称", function(){});
	  	            	}						
	  	            },
	  	            error: function(){
	  	            	parent.bootbox.alert("系统错误！更新数据失败", function(){});
	  	            	return;
	  	            }
 	           });
		    }
		}
	</script>
    
	</body>
</html>


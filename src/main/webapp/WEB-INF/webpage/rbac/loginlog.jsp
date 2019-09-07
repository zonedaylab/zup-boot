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
		<title>登录日志管理</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	    
	    <!--	引入外部样式库css	-->
	    <jsp:include page="../include/mainHead.jsp"></jsp:include>
	    <!--        定义适应屏幕的css样式 -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <style type="text/css">
	        
        </style>
	    
</head>
<body style="background-color:#FFFFFF; overflow-x : hidden ;">
	<!-- 左侧数型图和查询条件 -->
    <div class="row">		
		<div class="col-sm-12 col-xs-12 col-lg-12 widget-body">
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
							<div class="form-group">
								<label class="col-xs-4 col-md-2 control-label" style="text-align: right" for="postNameQuery">真实姓名：</label>
								<div class="col-xs-5 col-md-3">
									<input type="text" id="username"  class="form-control"/><!-- form-field-1 -->
								</div>
								<label class="col-xs-4 col-md-2 control-label" id="POSITIONDEPRESS" style="text-align: right" for="realname">登录类型：</label>
								<div class="col-xs-5 col-md-3"> 
									<select class="form-control" id="postNameQuery">
										<option value="">&nbsp;</option>									
									</select>
								</div>							
									
							</div>
							<div class="form-group">
								<label class="control-label no-padding-right col-md-2 col-sm-6" for="startLogDateTime">登录时间：&nbsp;&nbsp;&nbsp;</label>
								<div class="input-group col-md-3 col-sm-6">
									<input class="form-control date-picker " id="startLogDateTime" type="text" data-date-format="yyyy-mm-dd" />
									<span class="input-group-addon"><i class="icon-calendar bigger-110"></i></span>
								</div>
								<label class="control-label no-padding-right col-md-2 col-sm-6 for="endLogDateTime">至：&nbsp;&nbsp;&nbsp;</label>
								<div class="input-group col-md-3 col-sm-6">
									<input class="form-control date-picker " id="endLogDateTime" type="text" data-date-format="yyyy-mm-dd" />
									<span class="input-group-addon"><i class="icon-calendar bigger-110"></i></span>
								</div>			
							</div>
							<div class="form-group">																
								<label class="col-xs-4 col-md-2 control-label" for="startLogDateTime">所属系统：</label>
								<div class="col-xs-5 col-md-3"> 
									<select class="form-control" id="systemname">
										<option value="">&nbsp;</option>									
									</select>
								</div>
								<div class="col-xs-5 col-md-3">	
									<div class="col-xs-4 col-md-1 control-label" style="position:absolute; right:30px; top:0px">
										<button class="btn btn-sm btn-primary" type="button" id="search"><i class="icon-ok"></i>查询</button>
									</div>	
								</div>	
							</div>
						</form>
					</div> 
				</div>
			</div>
			</div>
			
	<!-- 岗位信息datables开始 -->
	<div class="table-header">登录日志信息</div>
			<div class="table-responsive">
				<table id="loginlogtable" class="table table-striped table-bordered table-hover"  style="margin-bottom:20px;">
					<thead>
						<tr>
							<th>
								<label>
									<input type="checkbox" class="ace" id="allCheck" />
									<span class="lbl"></span>
								</label>
							</th>
							<th>
								用户名
							</th>
							<th>
								系统名
							</th>							
							<th>
								所属部门单位
							</th>
							<th>
								登录时间
							</th>
							<th>
								登录类型
							</th>
							<th>
								用户ip
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
	
	
	<!-- 以下为js放置位置 --> 
	  
    <!--  引入js存放的外部脚本库  -->
	<jsp:include page="../include/mainFooter.jsp"></jsp:include>   
   	<script type="text/javascript" src="plug-in/ace/login/js/jquery.md5.js"></script>
   	<!-- 左侧树形图加载 以及查询数据源数据js -->
   	<script type="text/javascript">
       //装载树形tree
      	jQuery(document).ready(function (e) {
      	    //日期框
		$('.date-picker').datepicker({
            language: 'cn',
            autoclose: true,
            dateFormat: 'yy-mm-dd',
           // altFormat: "yyyy-mm-dd",
            todayHighlight: true,
            showHms:false,//是否显示时分秒
            changeYear: true,
            changeMonth: true,
            yearRange:"2000:2017"
        }) 
      });
	</script>
		
    	<!-- 加载datables表数据js -->
    <script type="text/javascript">
            //封装请求参数
            var param = {};
    		$(function () {
    			findSelectData();
    			loadTableData();    			
    		});
		   function loadTableData(){
	         var lang = {
	            "sProcessing": "处理中...",
	            "sLengthMenu": "每页 _MENU_ 项",
	            "sZeroRecords": "没有匹配结果",
	            "sInfo": "当前显示第 _START_ 至 _END_ 项，共 _TOTAL_ 项。",
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
        	var table = $("#loginlogtable").dataTable({
        	    "dom": '<t><"col-md-6"i><"col-md-4"p><"col-md-2"l>',    //为表格元素书写css样式<t>为中间表格  在<t>右边就是在表格下边
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
	                //封装请求参数
	                var param = {};
	              if($("#username").val()!=""){
						param.username = $("#username").val();
				  }else{
				  		delete param.username;
				  }
				  if($("#systemname").val() != 0){	
				  		if("${usersession.systemId}" != "")
				  				param.systemId = "${usersession.systemId}";
				  		else					
								param.systemId = $("#systemname").val();
				  }else{
				  		delete param.systemId;
				  }
				  if($("#startLogDateTime").val()!=""){							
								param.startLogDateTime = $("#startLogDateTime").val();
				  }else{
				  		delete param.startLogDateTime;
				  }
				  if($("#endLogDateTime").val()!=""){				
								param.endLogDateTime =$("#endLogDateTime").val();
				  }else{
				  		delete param.endLogDateTime;
				  }
				  if($("#postNameQuery").val()!=""){				
						param.logtype =$("#postNameQuery").val();
				  }else{
				  		delete param.logtype;
				  }	
	                param.rows = data.length;//页面显示记录条数，在页面显示每页显示多少项的时候
	                param.start = data.start;//开始的记录序号
	                param.page = (data.start / data.length)+1;//当前页码
	                //console.log(param);
	                //ajax请求数据
	                $.ajax({
	                    type: "POST",
	                    url: "rest/rbac/loginlogController/gird",
	                    cache: false,  //禁用缓存
	                    data: param,  //传入组装的参数
	                    dataType: "json",
	                    success: function (result) {
	                        //console.log(result);
	                        //setTimeout仅为测试延迟效果
	                        setTimeout(function () {
	                            //封装返回数据
	                            var returnData = {};
	                            returnData.draw = data.draw;//这里直接自行返回了draw计数器,应该由后台返回
	                            returnData.recordsTotal = result.total;//返回数据全部记录
	                            returnData.recordsFiltered = result.total;//后台不实现过滤功能，每次查询均视作全部结果
	                            returnData.data = result.data;//返回的数据列表
	                            //console.log(returnData);
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
				        "data": "loginlogid", // 数据列名
				        "orderable":false,
				        "sWidth":"15px",
				        "render": function(data, type, full) { // 返回自定义内容
				       		return "<label><input type='checkbox' class='ace' /><span class='lbl' value = '" + data + "'></span></label>";
				         }
                    },
                    {
					  	"targets": [1], // 目标列位置，下标从0开始
					   	"data": "username"
                    },
                    {
					   	"targets": [2], // 目标列位置，下标从0开始
					   	"data": "systemname" // 数据列名
                    },
                    {
					   	"targets": [3], // 目标列位置，下标从0开始
					   	"data": "accountname" // 数据列名
                    },
                    {
				       	"targets": [4], // 目标列位置，下标从0开始
				       	"data": "logdatetime" // 数据列名
                    },
                    {
				       	"targets": [5], // 目标列位置，下标从0开始
				       	"data": "logtypestring" // 数据列名
                    },
                    {
			         	"targets": [6], // 目标列位置，下标从0开始
			         	"data": "logip" // 数据列名
                  	}
            ]
        }).api();
        //此处需调用api()方法,否则返回的是JQuery对象而不是DataTables的API对象
    }
		    $("#search").click(function(){
				loadTableData();
			});	    	
	</script>   
	
	
    <!-- 主页面的 数据操作处理js 增删该查 -->
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
	var par = {};   //声明ajax传输参数的数组变量
	//格式化编辑时加载的 时间格式
	function FormatDate (strTime) {
	    var date = new Date(strTime);
	    return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
	}
    </script> 
    <!-- 子页面的 数据操作处理js 增删该查 -->
    <script type="text/javascript">
		function findSelectData(){
			//ajax请求数据
	        $.ajax({
	            type: "POST",
	            url: "rest/rbac/loginlogController/loadSystem",
	            cache: false,  //禁用缓存
	            dataType: "json",
	            success: function (result) {
	            	for(var i=0;i<result.data.length;i++){
	             		$("#systemname").append("<option value='"+result.data[i].systemId+"'>"+result.data[i].systemName+"</option>");
	            	}
	            	$("#systemname").val(${usersession.systemId});
	            	$("#systemname").attr("disabled", "disabled");
	            },
	            error:function(){
	            	parent.bootbox.alert("数据请求失败");
	            }
	        });

			//获取登录类型
	        $.ajax({
	            type: "POST",
	            url: "rest/rbac/loginlogController/loadLoginResult",
	            cache: false,  //禁用缓存
	            dataType: "json",
	            success: function (result) {
	            	for(var i=0;i<result.data.length;i++){
	             		$("#postNameQuery").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
	            	}
	            },
	            error:function(){
	            	parent.bootbox.alert("数据请求失败");
	            }
	        });
		}
    </script>
    
	</body>
</html>

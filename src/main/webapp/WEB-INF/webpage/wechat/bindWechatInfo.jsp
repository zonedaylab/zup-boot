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
		<title>微信用户绑定查看</title>
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
			td > a{
				color:#009688!important;
			}
			thead > tr > td{
				text-align:center!important;
			}
        </style>
   </head>
   <body style="background-color:#FFFFFF; overflow-x : hidden ;">
     <div class="row">
		
		<!-- 左查询条件开始 -->
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
								<div class="form-group ">
									<label class="col-xs-5 col-md-2 control-label" style="text-align: right" >账户名称：</label>
									<div class="col-xs-4 col-md-3">								
										<input id="accountName" class="form-control inputs" />
									</div>							
									<label class="col-xs-5 col-md-2 control-label" style="text-align: right">所属系统：</label>
									<div class="col-xs-4 col-md-3"> 
							            <select id="system" class="form-control inputs">
							            </select>
									</div>
									<div class="col-md-2 col-xs-2" style=" position:absolute; right:30px; top:0px">
										<button class="btn btn-sm btn-primary" type="button" style="float:right; height:30px;" id="btnSearch"><i class="icon-ok"></i>查询</button>
									</div>									
								</div>	
								<div class="form-group ">					
									<label class="col-xs-5 col-md-2 control-label" style="text-align: right">绑定时间：</label>
									<div class="col-xs-4 col-md-3 input-group" >
										<input class="form-control date-picker" id="bindDate" data-date-format="dd-mm-yyyy" type="text">
										<span class="input-group-addon">
											<i class="icon-calendar bigger-110"></i>
										</span>
									</div>
									<div class="col-md-2 col-xs-2" style=" position:absolute; right:30px; top:0px">
									</div>									
								</div>					
							</form>
						</div> 
					</div>
				</div>
			</div>
			<!-- 查询条件结束 -->
			<!-- 岗位信息datables开始 -->
			<div class="table-header">详细信息</div>
			<div class="table-responsive">
				<table id="postTable" class="table table-striped table-bordered table-hover"  style="margin-bottom:20px;">
					<thead>
						<tr>
							<th>
								用户名称
							</th>
							<th>
								账户名称
							</th>
							<th>
								所属系统
							</th>
							<th>
								绑定日期
							</th>
							<th>
								操作
							</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		<!-- datables结束 -->
	</div>
    
    <!--  引入js存放的外部脚本库  -->
    <jsp:include page="../include/mainFooter.jsp"></jsp:include>
	
   	<!-- 加载datables表数据js -->
   	<script type="text/javascript">
        //封装请求参数
        var param = {};
   		$(document).ready(function () {
   			//日期控件js
   			dateDom();
   			loadTableData();
   			loadSystemName();
   		});
   		
   		function loadSystemName(){
   			$.ajax({
	            type: "POST",
	            url: "rest/workflow/workPersonal/SystemName", 
	            cache: false,  //禁用缓存
	            dataType: "json",
	            success: function (result) {
	       			$("#system").empty();
	       			$("#system").append("<option value='0'>全部</option>");
	            	for(var i=0;i<result.system.length;i++){
	             		$("#system").append("<option value='"+result.system[i].systemId+"'>"+result.system[i].systemName+"</option>");
	            	}
	            }
	        });
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
	        var state = 0;
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
					if($("#accountName").val() != ""){
						 param.registerName = $("#accountName").val();
					}else{
						 param.registerName = null;
					}
					if($("#system").val() != 0){
						param.systemId = $("#system").val();
					}else{
						param.systemId = null;
					}
					if($("#bindDate").val() != 0){
						param.registerPwd = $("#bindDate").val();
					}else{
						param.registerPwd = null;
					}
					
	                param.rows = data.length;//页面显示记录条数，在页面显示每页显示多少项的时候
	                param.start = data.start;//开始的记录序号
	                param.page = (data.start / data.length)+1;//当前页码
	                //console.log(param);
	                //ajax请求数据
	                $.ajax({
	                    type: "POST",
	                    url: "rest/wechat/wechatBindUserController/wechatBindList",
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
					  	"sWidth":"15%",
					   	"data": "wxAccount"
                    },
                      {
					  	"targets": [1], // 目标列位置，下标从0开始
					  	"sWidth":"25%",
					   	"data": "registerName"
                    },
                    {
					   	"targets": [2], // 目标列位置，下标从0开始
					   	"sWidth":"25%",
					   	"data": "registerPwd" // 数据列名
                    },
                    {
					   	"targets": [3], // 目标列位置，下标从0开始
					   	"sWidth":"25%",
					   	"data": "bindDate", // 数据列名
					   	"render": function(data, type, full) { // 返回自定义内容
				       		if(data == "")
				       			return "2017-01-01";
				       		else
				       			return data;
				         }
                    },
                    {
                    	"targets": [4], // 目标列位置，下标从0开始
					   	"sWidth":"10%",
					   	"data": "registerId", // 数据列名
					   	"render": function(data, type, full) { // 返回自定义内容
			       			return '<button class="btn btn-primary btn-sm" onclick="unlock('+data+')">解绑</button>';
				         }
                    }
	            ]
	        }).api();
	        //此处需调用api()方法,否则返回的是JQuery对象而不是DataTables的API对象
		    }
			//搜索按钮
	    	$("#btnSearch").click(function(){
	    		loadTableData();
	    	});

		var thisid = null;
		
		//日期控件js
   		function dateDom(){
   			$.datepicker.regional['zh-CN'] = { 
			  clearText: '清除', 
			  clearStatus: '清除已选日期', 
			  closeText: '关闭', 
			  closeStatus: '不改变当前选择', 
			  prevText: '<上月', 
			  prevStatus: '显示上月', 
			  prevBigText: '<<', 
			  prevBigStatus: '显示上一年', 
			  nextText: '下月>', 
			  nextStatus: '显示下月', 
			  nextBigText: '>>', 
			  nextBigStatus: '显示下一年', 
			  currentText: '今天', 
			  currentStatus: '显示本月', 
			  monthNames: ['一月','二月','三月','四月','五月','六月', '七月','八月','九月','十月','十一月','十二月'], 
			  monthNamesShort: ['一','二','三','四','五','六', '七','八','九','十','十一','十二'], 
			  monthStatus: '选择月份', 
			  yearStatus: '选择年份', 
			  weekHeader: '周', 
			  weekStatus: '年内周次', 
			  dayNames: ['星期日','星期一','星期二','星期三','星期四','星期五','星期六'], 
			  dayNamesShort: ['周日','周一','周二','周三','周四','周五','周六'], 
			  dayNamesMin: ['日','一','二','三','四','五','六'], 
			  dayStatus: '设置 DD 为一周起始', 
			  dateStatus: '选择 m月 d日, DD', 
			  dateFormat: 'yy-mm-dd', 
			  firstDay: 1, 
			  initStatus: '请选择日期', 
			  isRTL: false};
			$.datepicker.setDefaults($.datepicker.regional['zh-CN']);
   			//日期框
			$('.date-picker').datepicker({
                language: 'zh-CN',
                autoclose: true,
                todayHighlight: true
            })
   		}
   		
   		function unlock(id){
   			var par = {};
   			parent.bootbox.alert("您解绑微信后就会失去一个订阅用户，您确定要解绑吗？", function(){
				par.registerId = id;
	   			$.ajax({
	                type: "POST",
	                url: "rest/wechat/wechatBindUserController/closeBind",
	                data: par,
	                cache: false,  //禁用缓存
	                dataType: "json",
	                success: function (result) {
	                    if(result.data == "error"){
	                    	parent.bootbox.alert("请重试，出现错误", function(){});
	                    }else{
	                    	parent.bootbox.alert("微信解绑成功", function(){});
	                    	loadTableData();
	                    }
	                }
	            });
   			});
   		}
	</script>
    
	</body>
</html>


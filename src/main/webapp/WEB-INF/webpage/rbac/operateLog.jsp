<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<base href=" <%=basePath%>">
		<meta name="description" content="积成能源 运维监控平台" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<!--        引入外部样式库css        -->
        <jsp:include page="../include/mainHead.jsp"></jsp:include>
        <!--        定义适应屏幕的css样式 -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        
        <style type="text/css">
        
        @media (max-width:992px){
						#logLevelQuery{
						margin-top:15px;
						}
						#POSITIONDEPRESS{
						margin-top:15px;
						}			
					}
        </style>
		
	</head>

	<body  style="background-color:#FFFFFF; height:1500px; overflow-x : hidden ;">
		<div class="page-content">
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
									<label class="col-xs-5 col-md-2 control-label" style="text-align: right"  for="userName">真实姓名：</label>
									<div class="col-xs-4 col-md-3">
										<input type="text" id="userNameQuery" class="form-control"/>
									</div>
																
									<label class="col-xs-5 col-md-2 control-label" id="POSITIONDEPRESS" style="text-align: right"  for="logDate">操作时间：</label>
									<div class="input-group col-xs-4 col-md-3" id="POSITIONDEPRESS">
										<input class="date-picker form-control" id="logDateQuery" type="text" data-date-format="dd-mm-yyyy" value="${ demo.receive_Time}"/>
									    <span class="input-group-addon" >
											<i class="icon-calendar bigger-110 "></i>
										</span>
									</div>
									<div class="col-md-2 col-xs-2" style=" position:absolute; right:30px; top:0px">
										<button class="btn btn-sm btn-primary" type="button" style="float:right; height:30px; margin-top:5px" id="btnSearch"><i class="icon-ok"></i>查询</button>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-xs-5 col-md-2 control-label" style="text-align: right"  for="userName">系&nbsp;&nbsp;统：</label>
									<div class="col-xs-4 col-md-3">
										<input type="text" id="systemListQuery" class="form-control"/>
									</div>							
									<label class="col-xs-5 col-md-2 control-label" id="POSITIONDEPRESS" style="text-align: right"  for="logDate">等&nbsp;&nbsp;级：</label>
									<div class="col-xs-4 col-md-3">
										<select class="form-control" id="logLevelQuery">
											<option value="">全部</option>
										</select>
									</div>
								</div>													
						</form>
						</div> 
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12">
					<!-- <h3 class="header smaller lighter blue">操作日志</h3> -->
					<div class="table-header">
						操作日志
					</div>
					<div class="table-responsive">
						<table id="operateTable" class="table table-striped table-bordered table-hover"  style="margin-bottom:20px;">
							<thead>
								<tr>
									<th>
										操作人
									</th>
									<th>
										所属系统
									</th>
									<th>
										日志信息
									</th>
									<th>
										告警等级
									</th>
									<th>
										操作sql
									</th>
									<th>
										操作时间
									</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>

		<!--  引入js存放的外部脚本库  -->
        <jsp:include page="../include/mainFooter.jsp"></jsp:include>

		

		<script type="text/javascript">
			jQuery(function($) {
			    //table 表格复选框全选
				$('table th input:checkbox').on('click' , function(){
					var that = this;
					$(this).closest('table').find('tr > td:first-child input:checkbox')
					.each(function(){
						this.checked = that.checked;
						$(this).closest('tr').toggleClass('selected');
					});
				});
				//日期弹出选择框
				$('[data-rel="tooltip"]').tooltip({placement: tooltip_placement});
				function tooltip_placement(context, source) {
					var $source = $(source);
					var $parent = $source.closest('table');
					var off1 = $parent.offset();
					var w1 = $parent.width();
					var off2 = $source.offset();
					var w2 = $source.width();
					if( parseInt(off2.left) < parseInt(off1.left) + parseInt(w1 / 2) ) return 'right';
					return 'left';
				}
				//日期框
				$('.date-picker').datepicker({
	                language: 'zh-CN',
	                autoclose: true,
	                format: 'yyyy-mm-dd',
	                todayHighlight: true,
	                showHms:false
	            })
	            //ajax请求数据填充下拉框 
	            findSystemList();
	            function findSystemList(){
				//ajax请求数据
		        $.ajax({
		            type: "POST",
		            url: "rest/rbac/operateLogControaller/loadSystem",
		            cache: false,  //禁用缓存
		            dataType: "json",
		            success: function (result) {
		            	$("#systemListQuery").empty();
		            	$("#systemListQuery").append("<option value=''>全部</option>");
		            	for(var i=0;i<result.data.length;i++){
		             		$("#systemListQuery").append("<option value='"+result.data[i].systemId+"'>"+result.data[i].systemName+"</option>");
		            	}
		            },
		            error:function(){
		            	parent.bootbox.alert("数据请求失败");
		            }
		        });
			}
			findLogLevel();
			//填充日志等级下了列表
			function findLogLevel(){
				//ajax请求数据
		        $.ajax({
		            type: "POST",
		            url: "rest/rbac/operateLogControaller/getLogLevel",
		            cache: false,  //禁用缓存
		            dataType: "json",
		            success: function (result) {
		            	$("#logLevelQuery").empty();
		            	$("#logLevelQuery").append("<option value=''>全部</option>");
		            	for(var i=0;i<result.data.length;i++){
		             		$("#logLevelQuery").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
		            	}
		            },
		            error:function(){
		            	parent.bootbox.alert("数据请求失败");
		            }
		        });
			}
	            
			})
		</script>

        <!-- 操作日志datable grid表格	-->
		<script type="text/javascript">
    		$(function () {
    			loadTableData();
    			dateDom();
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
		        	var table = $("#operateTable").dataTable({
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
							if($("#userNameQuery").val() != ""){
								param.userName = $("#userNameQuery").val();
							}else{
								delete param.userName;
							}
							if($("#logDateQuery").val()!=""){
								param.logLevelString = $("#logDateQuery").val(); //借用字段传值
							}
							if($("#systemListQuery").val()!=""){
								console.log($("#systemListQuery").val());
								if($("#systemListQuery").val()==0){
									delete param.systemName;
								}
								if($("#systemListQuery").val()!=0){
									param.systemName = $("#systemListQuery").val();
								}								
							}
							if($("#logLevelQuery").val()!==""){
								param.logLevel = $("#logLevelQuery").val();
							}
			                param.rows = data.length;//页面显示记录条数，在页面显示每页显示多少项的时候
			                param.start = data.start;//开始的记录序号
			                param.page = (data.start / data.length)+1;//当前页码
			                $.ajax({
			                    type: "POST",
			                    url: "rest/rbac/operateLogControaller/getGird",
			                    cache: false,  //禁用缓存
			                    data: param,  //传入组装的参数
			                    dataType: "json",
			                    success: function (result) {
			                    	console.log(result);
			                        setTimeout(function () {
			                            //封装返回数据
			                            var returnData = {};
			                            returnData.draw = data.draw;//这里直接自行返回了draw计数器,应该由后台返回
			                            returnData.recordsTotal = result.total;//返回数据全部记录
			                            returnData.recordsFiltered = result.total;//后台不实现过滤功能，每次查询均视作全部结果
			                            returnData.data = result.data;//返回的数据列表
			                            callback(returnData);
			                        }, 200);
			                    },
			                    error:function(){
			                    	alert("系统错误！数据请求失败，请刷新重试！");
			                    }
			                });
		            	},
		            	columnDefs: [
		                    {
		                    	"sWidth":"10%",
							  	"targets": [0], // 目标列位置，下标从0开始
							   	"data": "userName"
		                    },
		                    {
							   "sWidth":"15%",
							   	"targets": [1], // 目标列位置，下标从0开始
							   	"data": "systemName" // 数据列名
		                    },
		                    {
		                    	"sWidth":"40%",
							   	"targets": [2], // 目标列位置，下标从0开始
							   	"data": "logInfo"
							   	
		                    },
		                    {
						       	"sWidth":"10%",
						       	"targets": [3], // 目标列位置，下标从0开始
						       	"data": "logLevelString" // 数据列名
		                    },
		                    {
						       "sWidth":"10%",
						       	"targets": [4], // 目标列位置，下标从0开始
						       	"data": "logSql" // 数据列名
		                    },
		                  	{
					         	"sWidth":"15%",
					         	"targets": [5], // 目标列位置，下标从0开始
					         	"data": "logDate" // 数据列名
		              		}
		            ]
		        }).api();
		        //此处需调用api()方法,否则返回的是JQuery对象而不是DataTables的API对象
		    }
		    //搜索
		    $("#btnSearch").click(function(){
				loadTableData();
			});
			
			
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
	 
			function info(data){
				parent.bootbox.alert(""+data);
			}
		</script>
</body>
</html>

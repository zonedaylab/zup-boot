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
		<link rel="stylesheet" href="plug-in/jquery/jquery.contextmenu.css" />
		<!-- basic styles -->

		<link href="plug-in/ace/assets/css/bootstrap.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="plug-in/ace/assets/css/font-awesome.min.css" />

		<!--[if IE 7]>
		  <link rel="stylesheet" href="assets/css/font-awesome-ie7.min.css" />
		<![endif]-->

		<!-- page specific plugin styles -->

		<!-- fonts -->


		<!-- ace styles -->

		<link rel="stylesheet" href="plug-in/ace/assets/css/ace.min.css" />
		<link rel="stylesheet" href="plug-in/ace/assets/css/ace-rtl.min.css" />
		<link rel="stylesheet" href="plug-in/ace/assets/css/ace-skins.min.css" />

		<!--[if lte IE 8]>
		  <link rel="stylesheet" href="assets/css/ace-ie.min.css" />
		<![endif]-->

		<!-- inline styles related to this page -->

		<!-- ace settings handler -->

		<script src="plug-in/ace/assets/js/ace-extra.min.js"></script>

		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

		<!--[if lt IE 9]>
		<script src="assets/js/html5shiv.js"></script>
		<script src="assets/js/respond.min.js"></script>
		<![endif]-->
		<link rel="stylesheet" href="plug-in/ace/assets/css/datepicker.css" />
	</head>
  
  <body  style="background-color:#FFFFFF; height:1500px;">
  	<div class="page-content">
  	  		<div class="page-header">
				<div class="col-md-6 col-xs-6 col-lg-6">
					<small><i class="icon-double-angle-right"></i>查询条件</small>
				</div>
				<div class="col-md-6 col-xs-6 col-lg-6">
					<button class="btn btn-sm btn-success" type="button" style="float:right; height:30px;" id="search"><i class="icon-ok"></i>查询</button>
				</div>
			</div>
			
			<div class="row center center-block" style="margin-top:20px;">
				<form class="form-horizontal" role="form">
					<div class="form-group ">
						<div class="row">
							<div class="col-md-6 col-xs-12">
								<label class="control-label no-padding-right" for="configcode">编码规则：</label>
								<input type="text" id="configcode" placeholder="编码规则" class="trueName" /><!-- form-field-1 -->
							</div>
							<div class="col-md-6 col-xs-12">
								<label class="control-label no-padding-right" for="memo">备注：</label>
								<input type="text" id="memo" placeholder="备注" class="trueName" />
							</div>
						
						
						</div>
					</div>
				</form>
			</div>
			
			<div class="row">
				<div class="col-xs-12">
					<!-- <h3 class="header smaller lighter blue">编码规则</h3> -->

					<div class="table-header">
						规则配置
					</div>
					
					<div class="row">
						<div class="col-md-6" style="margin-left:10px;height:30px; margin-bottom:10px; margin-top:5px;">
							<button class="btn btn-primary btn-sm" id="add">添加</button>
							<button class="btn btn-primary btn-sm" id="delete">删除</button>
							<button class="btn btn-primary btn-sm" id="edit">编辑</button>
							<button class="btn btn-primary btn-sm" id="test">生成编码</button>
						</div>
						<div class="col-md-7"></div>
			   		 </div>
					
					<div class="table-responsive">
						<table id="codetable" class="table table-striped table-bordered table-hover"  style="margin-bottom:20px;">
							<thead>
								<tr>
									<th>
										<label>
											<input type="checkbox" class="ace" />
											<span class="lbl"></span>
										</label>
									</th>
									<th>
										ID
									</th>
									<th>
										编码规则
									</th>
									<th>
										备注
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
  	
  	
  		<!-- basic scripts -->

		<!--[if !IE]> -->
		<script type="text/javascript">
			window.jQuery || document.write("<script src='plug-in/ace/assets/js/jquery-2.0.3.min.js'>"+"<"+"/script>");
		</script>

		<!-- <![endif]-->
		
		<!--[if IE]>
		<script type="text/javascript">
		 window.jQuery || document.write("<script src='assets/js/jquery-1.10.2.min.js'>"+"<"+"/script>");
		</script>
		<![endif]-->
		
		
		<script type="text/javascript">
			if("ontouchend" in document) 
				document.write("<script src='plug-in/ace/assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
		</script>
		<script src="plug-in/ace/assets/js/bootstrap.min.js"></script>
		<script src="plug-in/ace/assets/js/typeahead-bs2.min.js"></script>

		<!-- page specific plugin scripts -->

		<script src="plug-in/datatables/jquery.dataTables.min.js"></script>
		<script src="plug-in/datatables//dataTables.bootstrap.min.js"></script>


		<!-- ace scripts -->

		<script src="plug-in/ace/assets/js/ace-elements.min.js"></script>
		<script src="plug-in/ace/assets/js/ace.min.js"></script>
		<!-- inline scripts related to this page -->
		
		<script src="plug-in/ace/assets/js/date-time/bootstrap-datepicker.js"></script>
		<script src="plug-in/ace/assets/js/date-time/locales/bootstrap-datepicker.zh-CN.js"></script>
		
		
		
		<script type="text/javascript">
			jQuery(function($) {
				$('table th input:checkbox').on('click' , function(){
					var that = this;
					$(this).closest('table').find('tr > td:first-child input:checkbox')
					.each(function(){
						this.checked = that.checked;
						$(this).closest('tr').toggleClass('selected');
					});
				});
			
			
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
		
			})
		</script>


		<script type="text/javascript">
    		$(function () {
    			loadTableData();
    		});
    
		    function loadTableData(){
		    		//提示信息
			        var lang = {
			            "sProcessing": "处理中...",
			            "sLengthMenu": "每页 _MENU_ 项",
			            "sZeroRecords": "没有匹配结果",
			            "sInfo": "当前显示第 _START_ 至 _END_ 项，共 _TOTAL_ 项。",
			            
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
		        	var table = $("#codetable").dataTable({
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
							if($("#configcode").val()!=""){
								param.configCode = $("#configcode").val();
							}if($("#memo").val()!=""){
								param.memo = $("#memo").val();
							}
							
			                param.rows = data.length;//页面显示记录条数，在页面显示每页显示多少项的时候
			                param.start = data.start;//开始的记录序号
			                param.page = (data.start / data.length)+1;//当前页码
			                //console.log(param);
			                //ajax请求数据
			                $.ajax({
			                    type: "POST",
			                    url: "rest/rbac/codeconfig/gird",
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
			                    },
			                    error:function(){
			                    	alert("数据请求失败");
			                    }
			                });
		            	},
		            	columnDefs: [
		                	{
						    	"targets": [0], // 目标列位置，下标从0开始
						        "data": "operateid", // 数据列名
						        "orderable":false,
						        "sWidth":"15px",
						        "render": function(data, type, full) { // 返回自定义内容
						       		return "<label><input type='checkbox' class='ace' /><span class='lbl' value = '" + data + "'></span></label>";
						         }
		                    },
		                    {
							  	"targets": [1], // 目标列位置，下标从0开始
							   	"data": "configID"
		                    },
		                    {
							   	"targets": [2], // 目标列位置，下标从0开始
							   	"data": "configCode" // 数据列名
		                    },
		                    {
							   	"targets": [3], // 目标列位置，下标从0开始
							   	"data": "memo" // 数据列名
		                    }
		            ]
		        }).api();
		        //此处需调用api()方法,否则返回的是JQuery对象而不是DataTables的API对象
		    }
	</script>
	
	
	<script type="text/javascript">
			$("#search").click(function(){
				loadTableData();
			});
			$("#test").click(function(){
				getCodeInfo();
			});
			function getCodeInfo(){
				 $.ajax({
	                 type: "POST",
	                 url: "rest/rbac/codeconfig/getCodeConfig",
	                 cache: false,  //禁用缓存
	                 dataType: "json",
	                 success: function (result) {
	                	 alert("成功");
	                 },
	                 error:function(){
	                 	alert("数据请求失败");
	                 }
	             });
			}
			
			
			
	</script>
	
	<!--弹出框放置位置  添加 删除  查看详情-->
    <div id="dialog-message" class="hide">
    	
		<form class="bootbox-form">
            <strong>岗位名称：</strong><input class="postname" type="text" style="height: 30px; width: 195px; margin-bottom:5px;"/>
            <strong>部门名称：</strong><input class="bmname" type="text" style="height: 30px; width: 195px; margin-bottom:5px;"/>
              

        </form>
	</div>

		
 
  </body>
</html>

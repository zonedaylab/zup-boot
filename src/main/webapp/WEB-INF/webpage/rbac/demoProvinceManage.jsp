<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
						#codeQuery{
						margin-top:15px;
						}
						#POSITIONDEPRESS{
						margin-top:15px;
						}			
					}
        </style>
		
	</head>

	<body  style="background-color:#FFFFFF; overflow-x : hidden ;">
		<div class="page-content">
			<div class="page-header">
				<div class="col-md-6 col-xs-6 col-lg-6">
					<small><i class="icon-double-angle-right"></i>查询条件</small>
				</div>

			</div>
			
			<div class="row center center-block" style="margin-top:20px;">
				<form class="form-horizontal" role="form">
					<div class="form-group ">
								
								<label class="col-md-2 col-xs-5 control-label " style="text-align: right" for="nameQuery">省份名称：</label>
								<div class="col-xs-4 col-md-3">
								<input type="text" id="nameQuery" placeholder="省份名称" class="form-control" "/>
							    </div>
								<label class="col-md-2 col-xs-5 control-label" id="POSITIONDEPRESS" style="text-align: right"  for="codeQuery">省份编号：</label>
								<div class="col-xs-4 col-md-3">
								<input type="text" id="codeQuery" placeholder="省份编号" class="form-control" />
							    </div>
							     <div class="col-md-2 col-xs-3" style="position:absolute;top:50px;right:30px">
								<button class="btn btn-sm btn-primary" type="button" id="btnSearch"><i class="icon-ok"></i>查询</button>
				                </div>
					</div>
				</form>
			</div>
		
			<div class="row">
				<div class="col-xs-12">
					<!-- <h3 class="header smaller lighter blue">操作日志</h3> -->
					<div class="table-header">
						省份demo
					</div>
					<div class="row">
					<div class="col-md-12" style="height:30px; margin-bottom:10px; margin-top:5px;">
						<c:if test="${fn:contains(actionNames,'btnAddDemo')}">
							<button class="btn btn-primary btn-sm" id="btnAddDemo" style="position:relative;">添加</button>
						</c:if>
					</div>
					<div class="col-md-7"></div>
					</div>
					<div class="table-responsive">
						<table id="operateTable" class="table table-striped table-bordered table-hover"  style="margin-bottom:20px;">
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
										省份名称
									</th>
									<th>
										Code
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
		
		<div id="formEdit" class="hide">
			<form class="bootbox-form">
		        <span>名称：</span><input id="nameFrom" type="text" class="ants" /><br/>
		        <span>Code：</span><input id="codeFrom" type="text" class="ants" /><br/>
			 </form>
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
	                todayHighlight: true
	            })
	            
			})
		</script>

        <!-- 操作日志datable grid表格	-->
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
							if($("#nameQuery").val()!=""){
								param.name = $("#nameQuery").val();
							}
							if($("#codeQuery").val()!=""){
								param.code = $("#codeQuery").val();
							}
			                param.rows = data.length;//页面显示记录条数，在页面显示每页显示多少项的时候
			                param.start = data.start;//开始的记录序号
			                param.page = (data.start / data.length)+1;//当前页码

							//数据权限需要带上menuid
							param.menuId = ${ param.menuid};
			                
			                $.ajax({
			                    type: "POST",
			                    url: "rest/rbac/demo/getGird",
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
			                    },
			                    error:function(){
			                    	alert("数据请求失败");
			                    }
			                });
		            	},
		            	columnDefs: [
		                	{
						    	"targets": [0], // 目标列位置，下标从0开始
						        "data": "id", // 数据列名
						        "orderable":false,
						        "sWidth":"15px",
						        "render": function(data, type, full) { // 返回自定义内容
						       		return "<label><input type='checkbox' class='ace' id='operateId' value = '" + data + "' /><span class='lbl' value = '" + data + "'></span></label>";
						         }
		                    },
		                    {
							  	"targets": [1], // 目标列位置，下标从0开始
							   	"data": "id"
		                    },
		                    {
							   	"targets": [2], // 目标列位置，下标从0开始
							   	"data": "name" // 数据列名
		                    },
		                    {
							   	"targets": [3], // 目标列位置，下标从0开始
							   	"data": "code" // 数据列名
		                    }
		            ]
		        }).api();
		        //此处需调用api()方法,否则返回的是JQuery对象而不是DataTables的API对象
		    }
		    //搜索
		    $("#btnSearch").click(function(){
				loadTableData();
			});
		</script>
	<script type="text/javascript">
		$.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
			_title: function(title) {
				var $title = this.options.title || '&nbsp;'
				if( ("title_html" in this.options) && this.options.title_html == true )
					title.html($title);
				else title.text($title);
			}
		}));
		//添加按钮点击事件
		$( "#btnAddDemo" ).on('click', function(e) {
			$("#idFrom").val("");
			$("#nameFrom").val("");
		    $("#codeFrom").val("");
			msgDialog(e, this.id);
		});
	
		//弹出框主窗体
		var par = {};   //声明ajax传输参数的数组变量
		function msgDialog(e, thisid){
			e.preventDefault();
			var dialog = $( "#formEdit" ).removeClass('hide').dialog({
				modal: true,
				title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>省份增加</h4></div>",
				title_html: true,
				width:350,
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
							if(thisid == "btnAddDemo"){
								par.name = $("#nameFrom").val();
							    par.code = $("#codeFrom").val();
							    if(par.name == ""){
							    	 parent.bootbox.alert("请填省份名称", function(){});
							    	 return;
								}
							    if(par.code == ""){
							    	 parent.bootbox.alert("请填省份Code", function(){});
							    	 return;
								}
							    $.ajax({
						               type: "POST",
						               url: 'rest/rbac/demo/addDemo',
						               cache: false,  //禁用缓存
						               data: par,
						               dataType: "json",
						               success: function (result) {
						              		if(result.result=="success"){
						            		    parent.bootbox.alert("添加成功", function(){});
						            		    loadTableData();
								           	}else{
								           		parent.bootbox.alert("保存失败", function(){});
								           	}
						               },
						               error:function(){
						               	   parent.bootbox.alert("保存失败", function(){});
						               }
						          	});
							}
							$( this ).dialog( "close" );
						} 
					}
				]
			});
		}

	</script>
</body>
</html>

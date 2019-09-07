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
	    <!-- t.CONFIGID,t.SUBID,t.NAME,t.SUBNAME -->
        <jsp:include page="../include/mainHead.jsp"></jsp:include>       
    </head>
	<body style="background-color:#FFFFFF;  overflow-x : hidden ;" >
	
	<div class="row center center-block" style="margin-top:20px;">
		<div class="container">
			<div class="row clearfix">
				<div class="col-md-12 col-xs-12 column">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label for="roleNameQuery" class="col-xs-5 col-md-2 control-label" style="text-align: right; height:25px" >配置类别：</label>
							<div class="col-xs-4 col-md-3"> 
								<input type="text" class="form-control" id="nameQuery" />
							</div>
							
							<label for="roleTypeQuery" class="col-xs-5 col-md-2 control-label" id="POSITIONDEPRESS" style="text-align: right" >配置名字：</label>
							<div class="col-xs-4 col-md-3">
								<input type="text" class="form-control" id="subnameQuery" />
							</div>
							
							<div class="col-md-2 col-xs-3" style=" position:absolute; right:30px; top:0px">
								<button class="btn btn-sm btn-primary" type="button" id="btnSearch"><i class="icon-ok"></i>查询</button>
							</div>
						</div>
						
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="col-md-4 col-xs-12 col-lg-4"  style="magin-top:5px; margin-bottom:5px;" class="row">	
		<button class="btn btn-primary btn-sm" id="btnAdd">添加</button>
		<button class="btn btn-primary btn-sm " id="btnDelete" >删除</button>
		<button class="btn btn-primary btn-sm" id="btnRefresh">刷新</button>	
	</div>	
 	<div class="table-responsive">
	</div>
	 	<div class="table-responsive">
		<table id="configTable" class="table table-striped table-bordered table-hover" align="center" width="98%"  style="margin-bottom:20px;">
			<thead>
				<tr>
					<th>
						<label>
							<input type="checkbox" class="ace" id="allCheck" />
							<span class="lbl"></span>
						</label>
					</th>
					<th>
						配置ID
					</th>
					<th>
						配置子ID
					</th>
					<th>
						配置类别
					</th>
					<th>
						配置名字
					</th>			
				</tr>
			</thead>
		</table>
	</div>
</div>
<!--弹出框放置位置  添加  布局-->
    <div id="configEdit"  class="hide">
		<form class="bootbox-form" id="addOrEditForm"  style="padding:10px;">
            <table>
			<tr >
				<td><strong style="margin-left:10px;">配置ID：</strong></td>
				<td><input name="configidAdd" id="configidAdd" type="number" class="form-control" style="width:100%;"/></td>
				<td><font  color="red" >*</font></td>
			</tr>
			<tr >
				<td><strong style="margin-left:10px;">配置子ID：</strong></td>
				<td><input name="subidAdd" id="subidAdd" type="number" class="form-control" style="width:100%;"/></td>
				<td><font  color="red" >*</font></td>
			</tr>
			<tr >
				<td><strong style="margin-left:10px;">配置类别：</strong></td>
				<td><input name="nameAdd" id="nameAdd" type="text" class="form-control" style="width:100%;"/></td>
				<td><font  color="red" >*</font></td>
			</tr>
			<tr>
				<td><strong style="margin-left:10px;">配置名字：</strong></td>
				<td><input name="subnameAdd" id="subnameAdd" type="text" class="form-control" style="width:100%;"/></td>
				<td><font  color="red" >*</font></td>
			</tr>			
			</table>
        </form>
	</div>		
	
    <!--  引入js存放的外部脚本库  -->
    <jsp:include page="../include/mainFooter.jsp"></jsp:include>  
   	<!-- 添加脚本开始 -->
   	<script type="text/javascript">
   	    var pars={};
   	    var param={};
   		//添加系统名称下拉框
   		$(document).ready(function(){
   			param.configid=null;
   			loadConfigTableData();
   		
   		});
   		$('.date-picker').datepicker({autoclose:true}).next().on(ace.click_event, function(){
			$(this).prev().focus();
		});
		dateDom();
  		var mydate = new Date();
        var year = mydate.getFullYear()+"-";
        var month = (mydate.getMonth()+1)+"-";
        var day = mydate.getDate()+" ";
        var hours = mydate.getHours()+":";  
		var minutes = mydate.getMinutes()+":";  
		var seconds=mydate.getSeconds();
		pars.time = " " + hours+minutes+seconds;//自动填充填写时间
		
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
            });
   		} 
   		</script>

<!--按钮功能定义-->
    <script type="text/javascript">    
  //复选框全选
	$("#allCheck").on('click' , function(){
		var that = this;
		$(this).closest('table').find('tr > td:first-child input:checkbox')
		.each(function(){
			this.checked = that.checked;
			$(this).closest('tr').toggleClass('selected');
		});
	});  
    $.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
			_title: function(title) {
				var $title = this.options.title;
				if( ("title_html" in this.options) && this.options.title_html == true )
					title.html($title);
				else title.text($title);
			}
		}));    
    $( "#btnAdd" ).on('click', function(e) {	
    	thisid = this.id;
		$("#configidAdd").val("");			
		$("#subidAdd").val("");
		$("#nameAdd").val("");
		$("#subnameAdd").val("");
		msgDialog();
	});	
	//删除
	$( "#btnDelete" ).on('click', function(e) {	
		if($("#configid:checked").length<=0 || $("#configid:checked").length>1){
			parent.bootbox.alert("请先选择要删除的一项", function(){});
			return;
		}else if($("#configid:checked").val()<=63){
			parent.bootbox.alert("无权限对此进行操作", function(){});
			return;
		}		
		delTask();
	});	
	//查询
	$( "#btnSearch" ).on('click', function(e) {	
		if($("#nameQuery").val()!=""&&$("#nameQuery").val()!=null||$("#subnameQuery").val()!=""&&$("#subnameQuery").val()!=null){
			if($("#nameQuery").val()==""&&$("#nameQuery").val()==null){
				param.subname=$("#subnameQuery").val();
				param.name=null;
				loadConfigTableData();
				}else if($("#subnameQuery").val()==""&&$("#subnameQuery").val()==null){
					param.name=$("#nameQuery").val();
					param.subname=null;
					loadConfigTableData();
					}else{
						param.name=$("#nameQuery").val();
						param.subname=$("#subnameQuery").val();
						loadConfigTableData();
						} 
			}else{
				param.subname=null;
				param.name=null;
				loadConfigTableData();
			}
			
	});	
	//编辑
	$( "#btnRefresh" ).on('click', function(e) {
		if($("#nameQuery").val()!=""&&$("#nameQuery").val()!=null||$("#subnameQuery").val()!=""&&$("#subnameQuery").val()!=null){
			if($("#nameQuery").val()==""&&$("#nameQuery").val()==null){
				param.subname=$("#subnameQuery").val();
				param.name=null;
				loadConfigTableData();
				}else if($("#subnameQuery").val()==""&&$("#subnameQuery").val()==null){
					param.name=$("#nameQuery").val();
					param.subname=null;
					loadConfigTableData();
					}else{
						param.name=$("#nameQuery").val();
						param.subname=$("#subnameQuery").val();
						loadConfigTableData();
						} 
			}else{
				param.subname=null;
				param.name=null;
				loadConfigTableData();
			}
	});
	</script>

 	 <script type="text/javascript">
 	//弹出框js方法
		function msgDialog(){			
				var dialog = $( "#configEdit" ).removeClass('hide').dialog({
					modal: true,
					title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>枚举配置</h4></div>",
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
								if(thisid == "btnAdd"){
										param.configid = $("#configidAdd").val();
										param.subid = $("#subidAdd").val();
										param.name = $("#nameAdd").val();
										param.subname = $("#subnameAdd").val();
										addTask();
								}
								
							}
						} 
					]
				});
		}
		//添加菜单操作项信息
		function addTask(){
			if(param.configid ==null || param.configid==""){
				parent.bootbox.alert("配置ID不能为空" , function(){});
			}else if(param.subid ==null || param.subid==""){
				parent.bootbox.alert("配置子ID不能为空" , function(){});
			}else if(param.name ==null || param.name==""){
				parent.bootbox.alert("配置类别不能为空" , function(){});
			}else if(param.subname ==null || param.subname==""){
				parent.bootbox.alert("配置名字不能为空" , function(){});
			}else{
				$.ajax({
	   	        	type: "POST",
    	            url: "rest/rbac/configController/addConfig",
    	            async: false,
    	            data: param,
    	            dataType: "json",
    	            success: function (data) {
    	            	if(data.result == "success"){
    						parent.bootbox.alert("添加成功");
    						$( "#configEdit" ).dialog( "close" );
    						param.subname=null;
    						param.name=null;
    						loadConfigTableData();
    	                }else if(data.result == "info"){
    	                	parent.bootbox.alert("配置ID和配置子ID已经存在，请重新设置配置ID或配置子ID.");
    	                }else if(data.result == "subName"){
    	                	parent.bootbox.alert("配置名字已经存在，请更改配置名字");
    	                }else{
    	                	parent.bootbox.alert("添加失败 ");
    	                }
			        },
			        error: function(){
			           parent.bootbox.alert("系统错误！删除信息失败。请刷新重新操作。");
			        }
	   	        });
			}
		}
		
		function delTask(){ 
			param.configid = $("#configid:checked").val();
			parent.bootbox.confirm("你确定要删除吗？", function(result) {
				if(result){
		   	        $.ajax({
		   	        	type: "POST",
	    	            url: "rest/rbac/configController/deleteConfig",
	    	            async: false,
	    	            data: param,
	    	            dataType: "json",
	    	            success: function (result) {
				            if(result.result){
				              	parent.bootbox.alert("删除成功", function(){ });
				              	loadConfigTableData();
			              	}else {
			              		parent.bootbox.alert("删除失败", function(){ });
			              	}
				        },
				        error: function(){
				           parent.bootbox.alert("系统错误！删除信息失败。请刷新重新操作。", function(){});
				        }
		   	        });
				}else{
					return;
				}
			});
		}
		
   		function loadConfigTableData(){
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
        	var table = $("#configTable").dataTable({
        	    "dom": '<t><"row"<"col-md-2"l><"col-md-4"i><"col-md-6"p>>',    //为表格元素书写css样式<t>为中间表格  在<t>右边就是在表格下边
           		language:lang,  //提示信息
            	stripeClasses: ["odd", "even"],  //为奇偶行加上样式，兼容不支持CSS伪类的场合
	            serverSide: true,  //启用服务器端分页
	            searching: false,  //禁用原生搜索
	            bAutoWidth:true, //自适应宽度 
	            bDestroy:true,//重新加载使用
	            async:false,
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
	                    url: "rest/rbac/configController/getConfigList",
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
        				        "data": "configid", // 数据列名
        				        "orderable":false,
        				        "sWidth":"15px",
        				        "render": function(data, type, full) { // 返回自定义内容
        				       		return "<label><input type='checkbox' class='ace' id='configid' value = '" + data + "' /><span class='lbl' id='postId' value = '" + data + "'></span></label>";
        				         }                       	
                            },    
                            {
        					   	"targets": [1], // 目标列位置，下标从0开始
        					   	"sWidth":"25%",
        					   	"data": "configid", // 数据列名,所属任务
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
        					   	"sWidth":"25%",
        					   	"data": "subid", // 数据列名,所属任务
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
        					   	"sWidth":"25%",
        					   	"data": "name", // 数据列名,所属任务
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
        					   	"sWidth":"25%",
        					   	"data": "subname", // 数据列名,所属任务
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
	    }
 	</script>
	</body>
</html>
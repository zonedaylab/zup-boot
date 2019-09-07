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
		<title>交易市场管理配置</title>
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
					<div class="row clearfix" style="margin-bottom:5px;">
						<div class="form-group ">
							<label class="col-xs-2 col-md-2 control-label" style="text-align: right" for="workname">市场名称：</label>
							<div class="col-xs-3 col-md-3">								
								<select id="marketNameQuery" class="form-control inputs" >
					            </select>
							</div>							
							<label class="col-xs-2 col-md-2 control-label" style="text-align: right;letter-spacing:3px;" for="workname">所属区域：</label>
							<div class="col-xs-3 col-md-3">								
								<select id="energyRegionQuery" class="form-control inputs" >
					            </select>
							</div>
							<input id="hiddenMdmc" type="hidden" />
							<div class="col-md-2 col-xs-2" style="position:absolute; top:0px; right:30px">
									<button class="btn btn-sm btn-primary" type="button" style="float:right; height:30px;top: 45px;" id="btnSearch"><i class="icon-ok"></i>查询</button>
								</div>	
															
						</div>					
					</div>
				</div>
			</div>
			<!-- 查询条件结束 -->
			<!-- datables开始 -->
			<div class="table-header" style=" margin-top:15px;">交易市场</div>
			<div class="row" style="margin-left:20px;height:30px; margin-bottom:10px; margin-top:25px;">
				<button class="btn btn-primary btn-sm" id="btnAdd">添加</button>
				<button class="btn btn-primary btn-sm" id="btnEdit">编辑</button>
				<button class="btn btn-primary btn-sm" id="btnDelete">删除</button>
			</div>
			<div class="table-responsive">
				<table id="tradeMarketConfigTable" class="table table-striped table-bordered table-hover"  style="margin-bottom:20px;">
					<thead>
						<tr>
							<th>
								<label>
									<input type="checkbox" class="ace" id="allCheck" />
									<span class="lbl"></span>
								</label>
							</th>
							<th>
								交易市场
							</th>
							<th>
								市场编号
							</th>
							<th>
								对应区域
							</th>
							<th>
								创建时间
							</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
	<!--告警记录信息弹出框放置位置  添加  查看详情-->
    <div id="energyMarketDialog" class="hide"> 
		<div class="container">
			<div class="row clearfix">
				<div class="col-md-12 column">
					<div class="form-horizontal" role="form" style="margin-left:-5%">
						<div class="form-group">
							<label class="col-xs-4 col-md-4 control-label" id="POSITIONDEPRESS" style="text-align: right" for="validityQuery">市场名称：</label>
							<div class="col-xs-7 col-md-7"> 
					            <input id="tradeMarketEdit" class="form-control inputs" />
							</div>
							<div class="col-xs-1 col-md-1"> 
					           <font color="red">*</font>
							</div>
						</div>
						<div class="form-group ">
							<label class="col-xs-4 col-md-4 control-label" id="POSITIONDEPRESS" style="text-align: right" for="validityQuery">创建时间：</label>
							<div class="col-xs-7 col-md-7"> 
					            <input id="createTimeEdit" class="form-control " readonly="readonly" />
							</div>
							<div class="col-xs-1 col-md-1"> 
					           <font color="red">*</font>
							</div>
						</div> 
						<div class="form-group " style="display:none;">
							<label class="col-xs-4 col-md-4 control-label" id="POSITIONDEPRESS" style="text-align: right;display:none;" for="validityQuery">对应区域：</label>
							<div class="col-xs-7 col-md-7"> 
					            <input id="energyRegionEdit" class="form-control" />
							</div>
						</div> 
						
						<div id="messageStrategyPerson">
							<div class="panel panel-default" style="margin-top:10px; height:260px;">
						        <div class="panel-body">
						           <div id="pickList" style="height:220px;"></div>
					         		<span class="col-md-7 col-lg-7 panel-title" style="">未对应区域</span>
					         		<span class="col-md-5 col-lg-5 panel-title" >已对应区域</span>
						           <div class="panel-heading" style="margin-top:10px;">	           
						        </div>
						           <br><br>
						        </div>
					     	</div>
						</div>
        			</div>
				</div> 
			</div>
		</div> 
	</div>  
	
    <!--  引入js存放的外部脚本库  -->
    <jsp:include page="../include/mainFooter.jsp"></jsp:include>
	<!-- 左侧树形图加载数据js -->
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
			//弹出框  头部样式
			$.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
					_title: function(title) {
						var $title = this.options.title;
						if( ("title_html" in this.options) && this.options.title_html == true )
							title.html($title);
						else title.text($title);
					}
				}));
			
		</script>
   		<script type="text/javascript">
   		var paradd = {};
   		var param = {};
   		var pardel = {};
   		var parup = {};
   		var parsign = {};
   	 	$(document).ready(function(){
	   		loadTableData();
	   		getSelectInfo();
	    });
		</script>
		<script type="text/javascript">
			var thisid = "";
			$("#btnEdit").on('click',function(e){
				thisid=this.id;
				if($("#market_Id:checked").length > 1){
					parent.bootbox.alert("只能选择一个交易市场进行编辑", function(){});
					return;
				}
				if($("#market_Id:checked").length <1){
					parent.bootbox.alert("请选择一个交易市场进行编辑", function(){});
					return;
				}
				parsign.market_Id = $("#market_Id:checked").val();
				parup.market_Id = $("#market_Id:checked").val();
				energyMarketDialog(e,thisid);
				getUnSignedRegion();
				getEnergyMarketInfo();
			});
			
			$("#btnSearch").on('click',function(e){
				param.market_Id = $("#marketNameQuery").val();
				param.regionCodes = $("#energyRegionQuery").val();
				loadTableData();
			});
			$("#btnAdd").on('click',function(e){
				var nowDate = new Date();
				var nowDateTime = nowDate.getFullYear() + "-" + (nowDate.getMonth() + 1) + "-" + nowDate.getDate()+" "+nowDate.getHours()+":00:00";
				$("#createTimeEdit").val(nowDateTime);
				$("#tradeMarketEdit").val('');
	          	//$("#createTimeEdit").val('');
				thisid=this.id;
				energyMarketDialog(e,thisid);
				getUnSignedRegion();
				$("#pickListResult").empty();
			});
			var flags=0;
			function getEnergyMarketInfo(){
				$.ajax({
			 	       url: 'rest/rbac/energyMarketConfigController/getMarketInfo',
			           data: parup,
			           type: 'POST',
			           dataType: 'json',
				       success: function (result) {
				    	   
				    		if(flags == 0){
			            		pick = $("#pickList").pickList({data: result.data});
			            		flags++;
			            	}
			            	$("#pickListResult").empty();
			            	for(var i=0;i<result.data.length;i++){
			            		if(result.data[i].regionCodes != null && result.data[i].regionCodes != ""){
				             		$("#pickListResult").append("<option value='"+result.data[i].regionCodes+"'>"+result.data[i].regionName+"</option>");
			            		}
			            	}
				    	   
					       	if(thisid=="btnEdit"){//点击编辑按钮
					       		  if(result.result == "success"){
					       			$("#tradeMarketEdit").val(result.data[0].market_Name);
					              	$("#createTimeEdit").val(result.data[0].createTimeString);
					              	
									//diaryEditInput(e,thisid);
			              		}else if(result.result == "error"){
			              			parent.bootbox.alert("获取信息失败", function(){});		              		
			              		}	       	
					       	}
						},
				        error: function(){
				           parent.bootbox.alert("系统错误！获取信息失败。请刷新重新操作。", function(){});
				        }
			  	   });
			}
			
			//获取未配置的区域
			 
			 function getUnSignedRegion(){
				 $.ajax({
			            url: 'rest/rbac/energyMarketConfigController/listEnergyRegion',
			            data: parsign,
			            type: 'POST',
			            dataType: 'json',
			            success: function (result) {
			            	if(flags == 0){
			            		pick = $("#pickList").pickList({data: result.data});
			            		flags++;
			            	}
		            		$("#pickData").empty();
			            	for(var i=0;i<result.data.length;i++){
			             		$("#pickData").append("<option value='"+result.data[i].region_Code+"'>"+result.data[i].region_Name+"</option>");
			            	}
			            	delete parsign.region_Market_Id;
			            },
			            error: function(){
			                parent.bootbox.alert("加载失败", function(){});
			            }
			        });
			        
			 }
			function energyMarketDialog(e,thisid){
				e.preventDefault();
					var dialog = $( "#energyMarketDialog" ).removeClass('hide').dialog({
						modal: true,
						width:600,
						title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>交易市场编辑</h4></div>",
						title_html: true,
						buttons: [ 
							{
								text: "取消",
								"class" : "btn btn-xs",
								click: function() {
									$( this ).dialog( "close" );
						          	$("#tradeMarketEdit").val('');
						          	$("#createTimeEdit").val('');															
								} 
							},
							{
								text: "保存",
								"class" : "btn btn-primary btn-xs",
								click: function() {
									if(thisid == "btnAdd"){
										$( this ).dialog( "close" );
										
										$("#energyRegionEdit").val(""); 
						            	var userIds = "";
							       	    for(var i=0; i<pick.getValues().length; i++){ 
							       	   		userIds += $("#pickListResult option")[i].value+",";
							       	   	}	   
							       	   	userIds = userIds.substring(0,userIds.length);
										$("#energyRegionEdit").val(userIds); 
									 	flags = 0;
									 	$("#pickList").empty();
									 	
										paradd.market_Name = $("#tradeMarketEdit").val();
										paradd.create_Time = new Date($("#createTimeEdit").val());
										paradd.regionCodes = $("#energyRegionEdit").val();
										addCommon(paradd);
									}
									if(thisid == "btnEdit"){
										$( this ).dialog( "close" );
										
										$("#energyRegionEdit").val(""); 
						            	var userIds = "";
							       	    for(var i=0; i<pick.getValues().length; i++){ 
							       	   		userIds += $("#pickListResult option")[i].value+",";
							       	   	}	   
							       	   	userIds = userIds.substring(0,userIds.length);
										$("#energyRegionEdit").val(userIds); 
									 	flags = 0;
									 	$("#pickList").empty();
										parup.market_Name = $("#tradeMarketEdit").val();
										parup.create_Time = new Date($("#createTimeEdit").val());
										parup.regionCodes = $("#energyRegionEdit").val();									
										editCommon(parup);
									}
								} 
							}
						]
					});
				}
			
			
			function editCommon(parup){	
				if(parup.market_Name == null || parup.market_Name == ""){
					parent.bootbox.alert("请添加交易市场名称",function(){});
					return ;
				}
				if(parup.create_Time == null || parup.create_Time == ""){
					parent.bootbox.alert("请选择该交易市场创建日期",function(){});
					return ;
				}
				$.ajax({
	        		 type: "POST",
	                 url: 'rest/rbac/energyMarketConfigController/updateMarketInfo', //用于文件上传的服务器端请求地址
	                 data: parup,
	                 secureuri: false, //是否需要安全协议，一般设置为false
	                 dataType: 'json', //返回值类型 一般设置为json
	                 success: function (result){  //服务器成功响应处理函数
						if(result.result == "success"){
	                    	 parent.bootbox.alert("修改成功", function(){});
	                    	 $("#tradeMarketEdit").val('');
	                       	 $("#createTimeEdit").val('');	
	                       	 $("#energyRegionEdit").val('')
							 loadTableData();
	                         getSelectInfo();
	                     }else{
	                    	 parent.bootbox.alert("已经存在相同名称的交易市场，请重新填写");
	                     }
	                 },
	                 error: function (){//服务器响应失败处理函数
	                	 parent.bootbox.alert("修改失败，请刷新重试", function(){});
	                 }
	           	});
			}
			 function addCommon(paradd){
					if(paradd.market_Name == null || paradd.market_Name == ""){
						parent.bootbox.alert("请添加交易市场名称",function(){});
						return ;
					}
					if(paradd.create_Time == null || paradd.create_Time == ""){
						parent.bootbox.alert("请选择该交易市场创建日期",function(){});
						return ;
					}
					$.ajax({
		        		 type: "POST",
		                 url: 'rest/rbac/energyMarketConfigController/addMarketInfo', //用于文件上传的服务器端请求地址
		                 data: paradd,
		                 secureuri: false, //是否需要安全协议，一般设置为false
		                 dataType: 'json', //返回值类型 一般设置为json
		                 success: function (result){  //服务器成功响应处理函数
							if(result.result == "success"){
		                    	 //parent.bootbox.alert("添加成功", function(){});
		                    	 $("#tradeMarketEdit").val('');
		                       	 $("#createTimeEdit").val('');											
								 loadTableData();
								 getSelectInfo();
		                     }else{
		                    	 parent.bootbox.alert("已存在相同名称的交易市场，请重新填写");
		                     }
		                 },
		                 error: function (){//服务器响应失败处理函数
		                	 parent.bootbox.alert("添加失败，请刷新重试", function(){});
		                 }
		           	});
				}
			 
			 $("#btnDelete").on('click',function(e){
			    	if($("#market_Id:checked").length<=0){
						parent.bootbox.alert("请先选择要删除的交易市场", function(){});
						return;
					}else{
						thisid=this.id;
						deleteTradeMarket();
					}
			    });
			    function deleteTradeMarket(){
			    	pardel.energyMarketIds=[];
				 	parent.bootbox.confirm("你确定要删除这<font color=red>" + $("#market_Id:checked").length + "</font>个交易市场吗？",function(result){
			     		if(result){
							//取出要删除消息策略的startegyid
							for(var i=0;i<$("#market_Id:checked").length;i++){
								pardel.energyMarketIds[i]=$("#market_Id:checked")[i].defaultValue;							
							}
							$.ajax({
					 	       url: 'rest/rbac/energyMarketConfigController/deleteEnergyMarket',
					           data: pardel,
					           type: 'POST',
					           dataType: 'json',
						       success: function (result) {
						            if(result.result){
						              	parent.bootbox.alert("删除成功", function(){ });
					              		loadTableData();
					              		getSelectInfo();
					              		
					              	}else {
					              		parent.bootbox.alert("删除失败", function(){ });
					              	}
						        },
						        error: function(){
						           parent.bootbox.alert("系统错误！删除配置信息失败。请刷新重新操作。", function(){});
						        }
					  	   });
					  	}
					  	else{
					  		return;
					  	}   
			     	});
			    }
		</script>
		<script type="text/javascript">
		function getSelectInfo(){	
	    	   $.ajax({
	               type: "POST",
	               url: "rest/rbac/energyMarketConfigController/getAllMarket", 
	               cache: false,  //禁用缓存
	               dataType: "json",
	               async:false,
	               success: function (result) {
	          	       $("#marketNameQuery").html(""); 
	          	       $("#marketNameQuery").append("<option value='0'>选择查询</option>");
	               	for(var i=0;i<result.data.length;i++){
	                		$("#marketNameQuery").append("<option value='"+result.data[i].market_Id+"'>"+result.data[i].market_Name+"</option>");
	               	}
	              },
	               error:function(){	            	
	              	}
	          	});
	    	   $.ajax({
	               type: "POST",
	               url: "rest/rbac/energyMarketConfigController/getAllRegion", 
	               cache: false,  //禁用缓存
	               dataType: "json",
	               async:false,
	               success: function (result) {
	          	       $("#energyRegionQuery").html(""); 
	          	       $("#energyRegionQuery").append("<option value='0'>选择查询</option>");
	               	for(var i=0;i<result.data.length;i++){
	                		$("#energyRegionQuery").append("<option value='"+result.data[i].region_Code+"'>"+result.data[i].region_Name+"</option>");
	               	}
	              },
	               error:function(){	            	
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
    		//初始化表格
        	var table = $("#tradeMarketConfigTable").dataTable({
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
	            	if(param.market_Id == null || param.market_Id == ""|| param.market_Id == 0 ){
	            		delete param.market_Id;
	            	}
	            	if(param.regionCodes == null || param.regionCodes == ""|| param.regionCodes == 0){
	            		delete param.regionCodes;
	            	}
	                param.rows = data.length;//页面显示记录条数，在页面显示每页显示多少项的时候
	                param.start = data.start;//开始的记录序号
	                param.page = (data.start / data.length)+1;//当前页码
	                $.ajax({
	                    type: "POST",
	                    url: "rest/rbac/energyMarketConfigController/getRegionMarketPage",
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
					        "data": "market_Id", // 数据列名
					        "orderable":false,
					        "sWidth":"5px",
					        "render": function(data, type, full) { // 返回自定义内容
					       		return "<label><input type='checkbox' class='ace' id='market_Id' value = '" + data + "' /><span class='lbl' id='market_Id' value = '" + data + "'></span></label>";
					         }
		                },
		                {
						   	"targets": [1], // 目标列位置，下标从0开始
						   	"sWidth":"25%",
						   	"data": "market_Name", // 数据列名,所属任务
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
						   	"data": "market_Code", // 数据列名,所属任务
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
						   	"data": "regionName", // 数据列名,所属任务
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
						   	"data": "createTimeString", // 当日工作计划
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
	        //此处需调用api()方法,否则返回的是JQuery对象而不是DataTables的API对象
		    } 
		</script>
	</body>
</html>


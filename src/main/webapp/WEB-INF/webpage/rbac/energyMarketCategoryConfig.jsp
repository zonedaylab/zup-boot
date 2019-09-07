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
		<title>交易品种配置</title>
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
			.closePic{
				margin-left:3px; 
				margin-top:2px;
				float:right;
			}
			.closePic:hover{
				color:#f00;
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
							<label class="col-xs-2 col-md-2 control-label" style="text-align: right;letter-spacing:3px;" for="workname">交易品种：</label>
							<div class="col-xs-3 col-md-3">								
								<select id="tadeCategoryQuery" class="form-control inputs" >
					            </select>
							</div>
							<div class="col-md-2 col-xs-2" style="position:absolute; top:0px; right:30px">
									<button class="btn btn-sm btn-primary" type="button" style="float:right; height:30px;top: 45px;" id="btnSearch"><i class="icon-ok"></i>查询</button>
								</div>	
															
						</div>					
					</div>
				</div>
			</div>
			</div>
			<!-- 查询条件结束 -->
		<div class="col-sm-12 col-xs-12 col-lg-12 widget-body">			
			<!-- 消息策略datables开始 -->
			<div class="table-header">交易品种配置列表</div>
			<div class="row" style="margin-left:20px;height:30px; margin-bottom:10px; margin-top:5px;">
				<button class="btn btn-primary btn-sm" id="btnAdd">添加</button>
				<button class="btn btn-primary btn-sm" id="btnEdit">编辑</button>
				<button class="btn btn-primary btn-sm" id="btnDelete">删除</button>				
			</div>
			<div class="table-responsive">
				<table id="tradeCategoryConfigTable" class="table table-striped table-bordered table-hover"  style="margin-bottom:20px;">
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
								交易品种
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
	</div>
	<!--弹出框-->
    <div id="tradeCategoryConfigEdit" class="hide"> 
		<div class="container">
			<div class="row clearfix">
				<div class="col-md-12 column">
					<div class="form-group">
						<div class="form-group">
							<label  class="col-xs-4 col-md-4 col-sd-4  control-label" style="text-align:right;letter-spacing:3px;margin-top:5px" >交易市场：</label>
							<div class="col-xs-7 col-md-7 col-sd-3" style="margin-top:5px"> 
					             <select class="form-control" id="marketNameEdit" rows="4" ></select>
							</div>
							<div class="col-xs-1 col-md-1"> 
					           <font color="red">*</font>
							</div>
						</div>
						<div class="form-group">
							<label  class="col-xs-4 col-md-4 col-sd-4  control-label" style="text-align:right;letter-spacing:3px;margin-top:5px" >交易品种：</label>
							<div class="col-xs-7 col-md-7 col-sd-3" style="margin-top:5px"> 
					             <select class="form-control" id="tradeCategoryEdit" rows="4"></select>
							</div>
							<div class="col-xs-1 col-md-1"> 
					           <font color="red">*</font>
							</div>
						</div>
						<div class="form-group">
							<label  class="col-xs-4 col-md-4 col-sd-4  control-label" style="text-align:right;letter-spacing:3px;margin-top:5px" >有效性：</label>
							<div class="col-xs-7 col-md-7 col-sd-3" style="margin-top:5px"> 
					             <select class="form-control" id="validflagEdit" rows="4">
					             	<option value="0">请选择</option>
					             	<option value="1">有效</option>
					             	<option value="2">无效</option>
					             </select>
							</div>
							<div class="col-xs-1 col-md-1"> 
					           <font color="red">*</font>
							</div>
						</div>
        			</div>
				</div> 
			</div>
		</div> 
	</div>  
    <!--  引入js存放的外部脚本库  -->
    <jsp:include page="../include/mainFooter.jsp"></jsp:include>
    <script type="text/javascript" src="plug-in/ace/js/uploadFileAjax/ajaxfileupload.js"></script>
    <script type="text/javascript">
    	var param = {};
    	var pardel = {};
    	var paradd = {};
    	var parup = {};
	    $(document).ready(function(){
	   		loadTableData();
	   		getTradeInfo();
	    });
	 
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
		
		$("#btnSearch").on('click',function(e){
			param.market_Id = $("#marketNameQuery").val();
			param.tade_Category = $("#tadeCategoryQuery").val();
			loadTableData();
		});
		
		 //点击添加按钮
		$("#btnAdd").on('click', function(e) {
			$("#marketNameEdit").val('');
          	$("#tradeCategoryEdit").val('');
          	$("#validflagEdit").val('');
			diaryEditInput(e,this.id);			
		});
		$("#btnEdit").on('click', function(e) {
			if($("#category_Config_Id:checked").length > 1){
				parent.bootbox.alert("只能选择一个交易品种进行编辑", function(){});
				return;
			}
			if($("#category_Config_Id:checked").length <1){
				parent.bootbox.alert("请选择一个交易品种进行编辑", function(){});
				return;
			}
			$("#marketNameEdit").val('');
          	$("#tradeCategoryEdit").val('');
          	$("#validflagEdit").val('');
          	parup = {};
			parup.category_Config_Id = $("#category_Config_Id:checked").val();
			getTradeCategoryInfo(e,this.id);
						
		});
	    $("#btnDelete").on('click',function(e){
	    	if($("#category_Config_Id:checked").length<=0){
				parent.bootbox.alert("请先选择要删除的交易品种", function(){});
				return;
			}else{
				thisid=this.id;
				deleteTradeCategory();
			}
	    });
	    
		//获取交易品种
	    function  getTradeCategoryInfo(e,thisid){
			$.ajax({
	 	       url: 'rest/rbac/energyMarketConfigController/getTradeCategoryInfo',
	           data: parup,
	           type: 'POST',
	           dataType: 'json',
		       success: function (result) {
			       	if(thisid=="btnEdit"){//点击编辑按钮
			       		  if(result.result == "success"){
			       			$("#marketNameEdit").val(result.data[0].market_Id);
			              	$("#tradeCategoryEdit").val(result.data[0].trade_Category_Id);
			              	$("#validflagEdit").val(result.data[0].validflag);
							diaryEditInput(e,thisid);
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
		function diaryEditInput(e, thisid){
			e.preventDefault();
				var dialog = $( "#tradeCategoryConfigEdit" ).removeClass('hide').dialog({
					modal: true,
					width:600,
					title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>交易品种编辑</h4></div>",
					title_html: true,
					buttons: [ 
						{
							text: "取消",
							"class" : "btn btn-xs",
							click: function() {
								$( this ).dialog( "close" );
								$("#marketNameEdit").val('');
					          	$("#tradeCategoryEdit").val('');
					          	$("#validflagEdit").val('');															
							} 
						},
						{
							text: "保存",
							"class" : "btn btn-primary btn-xs",
							click: function() {
								var thisId = this;
								if(thisid == "btnEdit"){
									parup.market_Id = $("#marketNameEdit").val();
									parup.market_Name = $("#marketNameEdit").find("option:selected").text();
									parup.trade_Category_Id= $("#tradeCategoryEdit").val();
									parup.trade_Category= $("#tradeCategoryEdit").find("option:selected").text();
									parup.validflag = $("#validflagEdit").val();
									editCategory(thisId,parup);
								}
								if(thisid == "btnAdd"){
									paradd.market_Id = $("#marketNameEdit").val();
									paradd.market_Name = $("#marketNameEdit").find("option:selected").text();
									paradd.trade_Category_Id= $("#tradeCategoryEdit").val();
									paradd.trade_Category= $("#tradeCategoryEdit").find("option:selected").text();
									paradd.validflag = $("#validflagEdit").val();	
									addCommon(thisId,paradd);
								}
							} 
						}
					]
				});
		 }
		 function addCommon(thisId,paradd){	
    	 	if(paradd.market_Id ==null || paradd.market_Id==""|| paradd.market_Id==0){
				parent.bootbox.alert("请选择交易市场" , function(){});
				return;
			}else if(paradd.trade_Category == null || paradd.trade_Category == ""){
				parent.bootbox.alert("交易品种不能为空" , function(){});
				return;
			}else if(paradd.validflag == null || paradd.validflag == "" || paradd.validflag == 0){
				parent.bootbox.alert("请选择有效性" , function(){});	
				return;
			}
			$.ajax({
        		 type: "POST",
                 url: 'rest/rbac/energyMarketConfigController/addTradeCategory', //用于文件上传的服务器端请求地址
                 data: paradd,
                 secureuri: false, //是否需要安全协议，一般设置为false
                 dataType: 'json', //返回值类型 一般设置为json
                 success: function (result){  //服务器成功响应处理函数
					if(result.result == "success"){
						 $( thisId ).dialog( "close" );
                    	 $("#marketNameEdit").val('');
			          	 $("#tradeCategoryEdit").val('');
				         $("#validflagEdit").val('');											
						 loadTableData();										
                     }else{
                    	 parent.bootbox.alert("该交易市场已经存在此有效的交易品种", function(){});
                     }
                 },
                 error: function (){//服务器响应失败处理函数
                	 parent.bootbox.alert("添加失败，请刷新重试", function(){});
                 }
           	});
		}
		function editCategory(thisId,parup){	
			if(parup.market_Id ==null || parup.market_Id==""|| parup.market_Id==0){
				parent.bootbox.alert("请选择交易市场" , function(){});
				return;
			}else if(parup.trade_Category == null || parup.trade_Category == ""){
				parent.bootbox.alert("交易品种不能为空" , function(){});
				return;
			}else if(parup.validflag == null || parup.validflag == "" || parup.validflag == 0){
				parent.bootbox.alert("请选择有效性" , function(){});	
				return;
			}
			parup.category_Config_Id = $("#category_Config_Id:checked").val();
			$.ajax({
        		 type: "POST",
                 url: 'rest/rbac/energyMarketConfigController/updateTradeCategory', //用于文件上传的服务器端请求地址
                 data: parup,
                 secureuri: false, //是否需要安全协议，一般设置为false
                 dataType: 'json', //返回值类型 一般设置为json
                 success: function (result){  //服务器成功响应处理函数
					if(result.result == "success"){
						 $( thisId ).dialog( "close" );
                    	 parent.bootbox.alert("修改成功", function(){});
                    	 $("#marketNameEdit").val('');
			          	 $("#tradeCategoryEdit").val('');
				         $("#validflagEdit").val('');											
						 loadTableData();										
                     }else{
                    	 parent.bootbox.alert("该交易市场已经存在此有效的交易品种", function(){});
                     }
                 },
                 error: function (){//服务器响应失败处理函数
                	 parent.bootbox.alert("修改失败，请刷新重试", function(){});
                 }
           	});
		}
		function deleteTradeCategory(){
	    	pardel.tradeCategoryIds=[];
		 	parent.bootbox.confirm("你确定要删除这<font color=red>" + $("#category_Config_Id:checked").length + "</font>个交易品种吗？",function(result){
	     		if(result){
					//取出要删除消息策略的startegyid
					for(var i=0;i<$("#category_Config_Id:checked").length;i++){
						pardel.tradeCategoryIds[i]=$("#category_Config_Id:checked")[i].defaultValue;							
					}
					$.ajax({
			 	       url: 'rest/rbac/energyMarketConfigController/deleteTradeCategory',
			           data: pardel,
			           type: 'POST',
			           dataType: 'json',
				       success: function (result) {
				            if(result.result){
				              	parent.bootbox.alert("删除成功", function(){ });
			              		loadTableData();
			              		
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
        	var table = $("#tradeCategoryConfigTable").dataTable({      		      		
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
	    			if($("#marketNameQuery").val() !=null && $("#marketNameQuery").val() != "" && $("#marketNameQuery").val() != 0){
	    				param.market_Id = $("#marketNameQuery").val();
	    			}else{
	    				delete param.market_Id;
	    			}
	    			if($("#tadeCategoryQuery").val() !=null && $("#tadeCategoryQuery").val() != "" && $("#tadeCategoryQuery").val() != 0){
	    				param.category_Config_Id = $("#tadeCategoryQuery").val();
	    			}else{
	    				delete param.category_Config_Id;
	    			}
	                param.rows = data.length;//页面显示记录条数，在页面显示每页显示多少项的时候
	                param.start = data.start;//开始的记录序号
	                param.page = (data.start / data.length)+1;//当前页码
	                //ajax请求数据
	                $.ajax({
	                    type: "POST",
	                    url: "rest/rbac/energyMarketConfigController/getTradeCategoryPage",
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
				        "data": "category_Config_Id", // 数据列名
				        "orderable":false,
				        "sWidth":"5px",
				        "render": function(data, type, full) { // 返回自定义内容
				       		return "<label><input type='checkbox' class='ace' id='category_Config_Id' value = '" + data + "' /><span class='lbl' id='category_config_id' value = '" + data + "'></span></label>";
				         }
                    },
                    {
					   	"targets": [1], // 目标列位置，下标从0开始
					   	"sWidth":"35%",
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
					   	"sWidth":"35%",
					   	"data": "trade_Category", // 当日工作计划
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
					   	"sWidth":"30%",
					   	"data": "validflagString", // 数据列名，当日工作完成情况
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
	<script type="text/javascript">
     //加载交易市场
       function getTradeInfo(){	
    	  
    	   $.ajax({
               type: "POST",
               url: "rest/rbac/energyMarketConfigController/getAllMarket", 
               cache: false,  //禁用缓存
               dataType: "json",
               async:false,
               success: function (result) {
          	    $("#marketNameQuery").html("");
          	    $("#marketNameQuery").append("<option value='0'selected='selected'>"+"选择查询"+"</option>");
          	    $("#marketNameEdit").html("");
               	for(var i=0;i<result.data.length;i++){
                	$("#marketNameQuery").append("<option value='"+result.data[i].market_Id+"'>"+result.data[i].market_Name+"</option>");
                	$("#marketNameEdit").append("<option value='"+result.data[i].market_Id+"'>"+result.data[i].market_Name+"</option>");
               	}
              },
               error:function(){	            	
              	}
          	});
          	$.ajax({
                type: "POST",
                url: "rest/rbac/energyMarketConfigController/getTradeCategory", 
                cache: false,  //禁用缓存
                dataType: "json",
                async:false,
                success: function (result) {
                   $("#tradeCategoryEdit").html(""); 
            	   $("#tradeCategoryEdit").append("<option value='0'>"+"选择添加"+"</option>");
           	       $("#tadeCategoryQuery").html(""); 
           	   	   $("#tadeCategoryQuery").append("<option value='0'>"+"选择查询"+"</option>");
                   for(var i=0;i<result.data.length;i++){
                   	  $("#tradeCategoryEdit").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
                   	  $("#tadeCategoryQuery").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
                   }
               },
                error:function(){	            	
               	}
           	});
		}	
	</script>
  </body>
</html>







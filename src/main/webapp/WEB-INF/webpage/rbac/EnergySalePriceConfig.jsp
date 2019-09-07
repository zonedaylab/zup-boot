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
		<title>上网电价配置</title>
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
   	    <div class="container-fluid" style="margin-top: 15px;">
		<!-- 查询条件-->
		<div class="container">
			<div class="row" style="position:relative;">
				<div class="col-md-5">
					<div class="form-group clearfix">
						<div class="col-xs-4 text-right">
							<label>交易市场：</label>
						</div>
						<div class="col-xs-6 col-md-8">
							<select class="form-control" id="marketNameQuery" name="">
							</select>
						</div>
					</div>
				</div>
				<div class="col-md-5">
					<div class="form-group clearfix">
						<div class="col-xs-4  text-right">
							<label>年份：</label>
						</div>
						<div class="input-group col-xs-6 col-md-8">
							<select id="configYearQuery" class="form-control"></select>
						</div>
					</div>
				</div>
				<div style="position: absolute; right: 60px; top: 0px;">
					<div class="form-group clearfix">
						<button type="button" id="btnSearch" class="btn btn-primary btn-sm">查询</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 查询条件结束 -->
		
		<hr />
		
		<div class="row buttonGroup">
			<div class="col-xs-10">
				<button type="button" id="btnAdd" class="btn btn-primary btn-sm">添加</button>
				<button type="button" id="btnEdit" class="btn btn-primary btn-sm">编辑</button>
				<button type="button" id="btnDelete" class="btn btn-primary btn-sm">删除</button>
			</div>
			<div class="col-xs-2">
				<label style="color: #999;">价格单位：元/兆瓦时</label>
			</div>
		</div>
		<div class="table-responsive">
			<table id="priceConfigTable" class="table table-striped table-bordered table-hover" style="margin-bottom: 20px;">
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
							年份
						</th>
						<th>
							上网电价
						</th>
						<th>
							创建人
						</th>
						<th>
							创建时间
						</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
   
	<!--弹出框放置位置  添加  查看详情-->
    <div id="priceConfigDialog" class="hide"> 
		<div class="container">
			<div class="row clearfix">
				<div class="col-md-12 column">
					<div class="form-horizontal" role="form" style="margin-left:-5%">
						<div class="form-group">
							<label class="col-xs-4 col-md-4 control-label"  style="text-align: right" for="validityQuery">交易市场：</label>
							<div class="col-xs-7 col-md-7"> 
					            <select id="marketNameEdit" class="form-control inputs" ></select>
							</div>
							<div class="col-xs-1 col-md-1"> 
					           <font color="red">*</font>
							</div>
						</div>
						<div class="form-group ">
							<label class="col-xs-4 col-md-4 control-label"  style="text-align: right" for="validityQuery">年份：</label>
							<div class="col-xs-7 col-md-7"> 
								<select id="configYearEdit" class="form-control inputs" >
								</select>
							</div>
							<div class="col-xs-1 col-md-1"> 
					           <font color="red">*</font>
							</div>
						</div> 
						
					</div>
					<div class="form-horizontal" role="form" style="margin-left:-5%">
						<div class="form-group ">
							<label class="col-xs-4 col-md-4 control-label"   style="text-align: right" for="validityQuery">上网电价：</label>
							<div class="col-xs-7 col-md-7"> 
								<input id="salePriceEdit" class="form-control inputs" type="number"  />
							</div>
							<div class="col-xs-1 col-md-1"> 
					           <font color="red">*</font>
							</div>
						</div>
						<div class="form-group ">
							<label class="col-xs-4 col-md-4 control-label"   style="text-align: right" for="validityQuery">创建人：</label>
							<div class="col-xs-7 col-md-7"> 
								<input id="userNameEdit" class="form-control inputs" readonly="readonly"/>
							</div>
						</div>
					</div>
					<div class="form-horizontal" role="form" style="margin-left:-5%">
						<div class="form-group ">
							<label class="col-xs-4 col-md-4 control-label"   style="text-align: right" for="validityQuery">创建时间：</label>
							<div class="col-xs-7 col-md-7"> 
								<input id="createDateEdit" class="form-control inputs" readonly="readonly"/>
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
	   		getLoginPerson();
	   		getNowTime();
	   		getSchemeYear();
	    });
   	 	
   	 	function getNowTime(){
	   	 	var nowDate = new Date();
			var nowDateTime = nowDate.getFullYear() + "-" + (nowDate.getMonth() + 1) + "-" + nowDate.getDate()+" "+nowDate.getHours()+":"+nowDate.getMinutes()+":"+nowDate.getSeconds();
			$("#createDateEdit").val(nowDateTime);
			$("#createDateEdit").val(nowDateTime);
   	 	}
        function getSchemeYear(){	
 		  	var myDate = new Date();
 		  	var startYear = myDate.getFullYear();
 		  	var endYear = myDate.getFullYear()+1;
 		  	$("#configYearEdit").html("");
 		  	$("#configYearEdit").append("<option value='0'></option>")
 		  	$("#configYearQuery").html("");
 		  	$("#configYearQuery").append("<option value='0'selected='selected'>"+"选择查询"+"</option>");
 		  	for(var i=startYear;i<=endYear;i++){
 		  		$("#configYearEdit").append("<option value='"+i+"'>"+i+"</option>")
 		  		$("#configYearQuery").append("<option value='"+i+"'>"+i+"</option>")
 		  	}
 		}
        function getLoginPerson(){
        	 $("#userNameEdit").val("${usersession.realName}");
        }
        
    	$("#btnSearch").on('click',function(e){
			param.market_Id = $("#marketNameQuery").val();
			param.config_Year = $("#configYearQuery").val();
			loadTableData();
		});
    	
    	$("#btnAdd").on('click', function(e) {
    		$("#marketNameEdit").val('');
          	$("#configYearEdit").val('');
          	$("#salePriceEdit").val('');
          	$("#userNameEdit").val('');
          	$("#createDateEdit").val('');
          	getLoginPerson();
          	getNowTime();
			diaryEditInput(e,this.id);			
		});
    	$("#btnEdit").on('click', function(e) {
			if($("#generator_Config_Id:checked").length > 1){
				parent.bootbox.alert("只能选择一个上网电价进行编辑");
				return;
			}
			if($("#generator_Config_Id:checked").length <1){
				parent.bootbox.alert("请选择一个上网电价进行编辑");
				return;
			}
			$("#marketNameEdit").val('');
          	$("#configYearEdit").val('');
          	$("#salePriceEdit").val('');
          	$("#userNameEdit").val('');
          	$("#createDateEdit").val('');
          	parup = {};
			parup.generator_Config_Id = $("#generator_Config_Id:checked").val();
			getPriceConfig(e,this.id);
						
		});
    	$("#btnDelete").on('click',function(e){
	    	if($("#generator_Config_Id:checked").length<=0){
				parent.bootbox.alert("请先选择要删除的上网电价");
				return;
			}else{
				thisid=this.id;
				deletePriceConfig();
			}
	    });
	    function deletePriceConfig(){
	    	pardel.generatorConfigIds=[];
		 	parent.bootbox.confirm("你确定要删除这<font color=red>" + $("#generator_Config_Id:checked").length + "</font>个上网标杆电价吗？",function(result){
	     		if(result){
					//取出要删除消息策略的startegyid
					for(var i=0;i<$("#generator_Config_Id:checked").length;i++){
						pardel.generatorConfigIds[i]=$("#generator_Config_Id:checked")[i].defaultValue;							
					}
					$.ajax({
			 	       url: 'rest/rbac/energySalePriceConfigController/deletePriceConfig',
			           data: pardel,
			           type: 'POST',
			           dataType: 'json',
				       success: function (result) {
				            if(result.result == "success"){
				              	parent.bootbox.alert("删除成功");
			              		loadTableData();
			              		
			              	}else {
			              		parent.bootbox.alert("删除失败");
			              	}
				        },
				        error: function(){
				           parent.bootbox.alert("系统错误！删除配置信息失败。请刷新重新操作。");
				        }
			  	   });
			  	}
			  	else{
			  		return;
			  	}   
	     	});
	    }
    	
    	function diaryEditInput(e, thisid){
			e.preventDefault();
				var dialog = $( "#priceConfigDialog" ).removeClass('hide').dialog({
				modal: true,
				width:600,
				title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>上网电价编辑</h4></div>",
				title_html: true,
				buttons: [ 
					{
						text: "取消",
						"class" : "btn btn-xs",
						click: function() {
							$( this ).dialog( "close" );
							$("#marketNameEdit").val('');
				          	$("#configYearEdit").val('');
				          	$("#salePriceEdit").val('');
				          	$("#userNameEdit").val('');
				          	$("#createDateEdit").val('');															
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
								parup.config_Year = $("#configYearEdit").val();
								parup.sale_Price = $("#salePriceEdit").val();
								parup.user_Name = $("#userNameEdit").val();
								parup.create_Date =new Date($("#createDateEdit").val());
								editCommon(thisId,parup);
							}
							if(thisid == "btnAdd"){
								paradd.market_Id = $("#marketNameEdit").val();
								paradd.market_Name = $("#marketNameEdit").find("option:selected").text();
								paradd.config_Year = $("#configYearEdit").val();
								paradd.sale_Price = $("#salePriceEdit").val();
								paradd.user_Name = $("#userNameEdit").val();
								paradd.create_Date =new Date($("#createDateEdit").val())	
								addCommon(thisId,paradd);
							}
						} 
					}
				]
			});
		}
    	function getPriceConfig(e,thisid){
			$.ajax({
	 	       url: 'rest/rbac/energySalePriceConfigController/getPriceConfig',
	           data: parup,
	           type: 'POST',
	           dataType: 'json',
		       success: function (result) {
			       	if(thisid=="btnEdit"){//点击编辑按钮
			       		if(result.result == "success"){
			       			$("#marketNameEdit").val(result.data[0].market_Id);
				          	$("#configYearEdit").val(result.data[0].config_Year);
				          	$("#salePriceEdit").val(result.data[0].sale_Price);
				          	$("#userNameEdit").val(result.data[0].user_Name);
				          	$("#createDateEdit").val(result.data[0].create_Date);
							diaryEditInput(e,thisid);
	              		}else{
	              			parent.bootbox.alert("获取信息失败");		              		
	              		}	       	
			       	}
				},
		        error: function(){
		           parent.bootbox.alert("系统错误！获取信息失败。请刷新重新操作。");
		        }
	  	   });
	     }
    	
    	function editCommon(thisId,parup){	
			if(parup.market_Id ==null || parup.market_Id==""|| parup.market_Id==0){
				parent.bootbox.alert("请选择交易市场");
				return;
			}else if(parup.config_Year == null || parup.config_Year == "" || parup.config_Year == 0){
				parent.bootbox.alert("请选择年份");
				return;
			}else if(parup.sale_Price == null || parup.sale_Price == "" ){
				parent.bootbox.alert("上网电价不能为空");	
				return;
			}
			parup.generator_Config_Id = $("#generator_Config_Id:checked").val();;
			$.ajax({
        		 type: "POST",
                 url: 'rest/rbac/energySalePriceConfigController/updatePriceConfig', //用于文件上传的服务器端请求地址
                 data: parup,
                 secureuri: false, //是否需要安全协议，一般设置为false
                 dataType: 'json', //返回值类型 一般设置为json
                 success: function (result){  //服务器成功响应处理函数
					if(result.result == "success"){
						 $( thisId ).dialog( "close" );
                    	 parent.bootbox.alert("修改成功");
                    	 $("#marketNameEdit").val('');
			          	 $("#configYearEdit").val('');
			          	 $("#salePriceEdit").val('');
			          	 $("#userNameEdit").val('');
			          	 $("#createDateEdit").val('');												
						 loadTableData();										
                     }else{
                    	 parent.bootbox.alert("在该年份的交易市场下，此上网标杆电价已经存在");
                     }
                 },
                 error: function (){//服务器响应失败处理函数
                	 parent.bootbox.alert("修改失败，请刷新重试");
                 }
           	});
		}
		function addCommon(thisId,paradd){	
			if(paradd.market_Id ==null || paradd.market_Id==""|| paradd.market_Id==0){
				parent.bootbox.alert("请选择交易市场");
				return;
			}else if(paradd.config_Year == null || paradd.config_Year == "" || paradd.config_Year == 0){
				parent.bootbox.alert("请选择年份");
				return;
			}else if(paradd.sale_Price == null || paradd.sale_Price == "" ){
				parent.bootbox.alert("上网电价不能为空");	
				return;
			}
			$.ajax({
        		 type: "POST",
                 url: 'rest/rbac/energySalePriceConfigController/addPriceConfig', //用于文件上传的服务器端请求地址
                 data: paradd,
                 secureuri: false, //是否需要安全协议，一般设置为false
                 dataType: 'json', //返回值类型 一般设置为json
                 success: function (result){  //服务器成功响应处理函数
					if(result.result == "success"){
					   $( thisId ).dialog( "close" );
					   $("#marketNameEdit").val('');
		          	   $("#energyPropertyEdit").val('');
		          	   $("#maxDemandPriceEdit").val('');
		          	   $("#capacityPriceEdit").val('');
		          	   $("#voltageLevelEdit").val('');
		          	   $("#catalogPriceEdit").val('');												
					   loadTableData();										
                    }else{
                   	   parent.bootbox.alert("在该年份的交易市场下，此上网标杆电价已经存在");
                    }
                 },
                 error: function (){//服务器响应失败处理函数
                	 parent.bootbox.alert("添加失败，请刷新重试");
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
       	var table = $("#priceConfigTable").dataTable({
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
            	if(param.config_Year == null || param.config_Year == ""|| param.config_Year == 0){
            		delete param.config_Year;
            	}
                param.rows = data.length;//页面显示记录条数，在页面显示每页显示多少项的时候
                param.start = data.start;//开始的记录序号
                param.page = (data.start / data.length)+1;//当前页码
                $.ajax({
                    type: "POST",
                    url: "rest/rbac/energySalePriceConfigController/getPriceConfigPage",
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
				        "data": "generator_Config_Id", // 数据列名
				        "orderable":false,
				        "sWidth":"5px",
				        "render": function(data, type, full) { // 返回自定义内容
				       		return "<label><input type='checkbox' class='ace' id='generator_Config_Id' value = '" + data + "' /><span class='lbl' id='generator_Config_Id' value = '" + data + "'></span></label>";
				         }
	                },
	                {
					   	"targets": [1], // 目标列位置，下标从0开始
					   	"sWidth":"20%",
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
					   	"sWidth":"20%",
					   	"data": "config_Year", // 数据列名,所属任务
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
					   	"sWidth":"20%",
					   	"data": "sale_Price", // 数据列名,所属任务
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
					   	"sWidth":"20%",
					   	"data": "user_Name", // 当日工作计划
					   	"render": function(data, type, full) { // 返回自定义内容
	                    	if(data !=null && data!=""){
	                            return data;
	                        }else{
	                            return "";
	                        }
	                    }
	                },
	                {
					   	"targets": [5], // 目标列位置，下标从0开始
					   	"sWidth":"20%",
					   	"data": "create_Date", // 当日工作计划
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
	
	function getSelectInfo(){
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
	}
	</script>
  </body>
</html>
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
		<title>用户管理</title>
	    <!--	引入外部样式库css	-->
	    <jsp:include page="../include/mainHead.jsp"></jsp:include>
	    <!--        定义适应屏幕的css样式 -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <style type="text/css">
	        @media (max-width:992px){
				#realNameQuery{
					margin-top:15px;
				}
				#POSITIONDEPRESS{
					margin-top:15px;
				}
				#firststar{
					position:absolute!important;
					right:65px!important;
					top:68px!important;
				}
				#secondstar{
					position:absolute!important;
					right:65px!important;
					top:128px!important;
				}			
			}
        </style>
        <link rel="stylesheet" type="text/css" href="plug-in/shanghe/css/blue.css">
</head>
<body style="background-color:#FFFFFF; overflow-x : hidden ;">
	<!-- 左侧数型图和查询条件 -->
    <div class="row">
    	<!-- 左侧树形图开始 -->
		<div class="col-sm-3 col-xs-12 col-lg-3 fixedLeft" style="margin-top:-3px; paading:0px;">
			<div class="widget-box">
				<div class="widget-header header-color-blue2">
					<h4 class="lighter smaller">组织机构</h4>
				</div>
				<div class="widget-body">
					<div class="widget-main padding-8">
						<div id="treeView" class="tree"></div>
					</div>
				</div>
			</div>
		</div>
		<!-- 左侧树形图结束 -->
		<!-- 左查询条件开始 -->
		<div class="col-sm-9 col-xs-12 col-lg-9 widget-body fixedRight">
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
									<label class="col-xs-5 col-md-2 control-label hide" style="text-align: right" for="postNameQuery">岗位名称：</label>
									<div class="col-xs-4 col-md-3 hide"> 
										<select class="form-control" id="postNameQuery">
											<option value="">&nbsp;</option>									
										</select>
									</div>							
									<label class="col-xs-5 col-md-2 control-label" id="POSITIONDEPRESS" style="text-align: right" for="realname">姓名：</label>
									<div class="col-xs-4 col-md-3">
										<input type="text" id="realNameQuery"  class="form-control"/><!-- form-field-1 -->
									</div>
									<div class="col-md-2 col-xs-2" style=" position:absolute; right:400px; top:0px">
										<button class="btn btn-sm btn-primary" type="button" id="search"><i class="icon-ok"></i>查询</button>
									</div>		
							</div>
							
							<div class="form-group hide">																
									<label class="col-xs-5 col-md-2 control-label" style="text-align: right; letter-spacing:3.5px;"  for="userValidFlag" >有效性：</label>
									<div class="col-xs-4 col-md-3"> 
										<select class="form-control" id="userValidFlagQuery" >
											<option value=""></option>	
										</select>
									</div>					
							</div>
						</form>
					</div> 
				</div>
			</div>
			</div>
			<!-- 查询条件结束 -->
			<!-- 岗位信息datables开始 -->
			<div class="table-header">用户信息</div>
			<div class="row">
				<div class="col-md-12" style="margin-left:20px;height:30px; margin-bottom:10px; margin-top:5px;">
					<button class="btn btn-primary btn-sm" id="btnAdd">添加</button>
					<button class="btn btn-info btn-sm" id="btnEdit">编辑</button>					
					<button class="btn btn-danger btn-sm" id="btnDelete">删除</button>
					<button class="btn btn-success btn-sm hide" id="btnManage">账户管理</button>
				</div>
				<div class="col-md-7"></div>
			</div>
			<div class="table-responsive">
				<table id="usertable" class="table table-striped table-bordered table-hover"  style="margin-bottom:20px;">
					<thead>
						<tr>
							<th>
								<label>
									<input type="checkbox" class="ace" id="allCheck" />
									<span class="lbl"></span>
								</label>
							</th>
							<th>
								姓名
							</th>
							<th>
								所属区域
							</th>	
							<th>
								性别
							</th>
							<th>
								身份证
							</th>
							<th>
								联系电话
							</th>
							<th>
								电表号
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
    <div id="dialog-message" class="hide"> 
		<div class="container">
			<div class="row clearfix">
				<div class="col-md-12 column">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							 <strong  class="col-xs-2 col-md-2 col-sd-2 control-label" style="text-align:right;letter-spacing:5px;"  >所属区域：</strong>
							<div class="col-xs-3 col-md-3 col-sd-3">
								<input class="form-control" id="organName"  readonly="readonly" type="text" />
							</div>
							<div class="col-xs-1 col-md-1">
							</div>
							<strong  class="col-xs-2 col-md-2 col-sd-2 control-label" style="text-align:right;letter-spacing:5px;" >姓名：</strong>
							<div class="col-xs-3 col-md-3 col-sd-3">
								<input class="form-control" id="realNameAdd" type="text" />
							</div>
							<div class="col-xs-1 col-md-1">
								<font color=red>*</font>
							</div>
						</div>  
						
						<div class="form-group">
							<strong  class="col-xs-2 col-md-2 col-sd-2 control-label" style="text-align:right;letter-spacing:5px;" >身份证号：</strong>
							<div class="col-xs-3 col-md-3 col-sd-3">
								<input class="form-control" id="identitycard" type="text" />
							</div>
							<div class="col-xs-1 col-md-1">
								<font color=red>*</font>
							</div>
							<strong class="col-xs-2 col-md-2 col-sd-2 control-label" style="text-align:right;letter-spacing:5px;" >性&nbsp;&nbsp;别：</strong>
							<div class="col-xs-3 col-md-3 col-sd-3"> 
					            <select id="sex" class="form-control" >
						              <option value="">&nbsp;</option> 
					            </select>
							</div>
							<div class="col-xs-1 col-md-1">
								
							</div>
						</div>
            		
						<div class="form-group">
							<strong  class="col-xs-2 col-md-2 col-sd-2 control-label" style="text-align:right;letter-spacing:5px;" >联系电话：</strong>
							<div class="col-xs-3 col-md-3 col-sd-3">
								<input class="form-control" id="cellphone" type="text" />
							</div>
							<div class="col-xs-1 col-md-1">
								<font color=red>*</font>
							</div>
							<strong class="col-xs-2 col-md-2 col-sd-2 control-label" style="text-align:right;letter-spacing:10px;" >电表号：</strong>
							<div class="col-xs-3 col-md-3 col-sd-3">
								<input class="form-control" id="phone" type="text" />
							</div>
							<div class="col-xs-1 col-md-1">
							</div>
						</div>   
						<div class="form-group hide">
							<strong class="col-xs-2 col-md-2 col-sd-2 control-label" style="text-align:right;letter-spacing:10px;" >岗位：</strong>
							<div class="col-xs-3 col-md-3 col-sd-3">
								<select id="userAddPostName" class="form-control" >
						              <option value="">&nbsp;</option> 
					            </select>
							</div>
							
						</div>                          
        			</form>
				</div> 
			</div>
		</div> 
	</div>  
    <!--弹出框放置位置  账号信息-->
    <div id="dialogmanage-message" class="hide" >
		<form class="bootbox-form">
            <span>真实姓名：</span><input class="userRealName" id= "userRealName"  readonly="readonly"  type="text" style="height: 30px; width: 250px; margin-bottom:5px;"/>  
        </form>
		<div class="table-header">账号信息</div>
		<div class="row">
			<div style="margin-left:20px;height:30px; margin-bottom:10px; margin-top:5px;">					
				<button class="btn btn-primary btn-sm" id="btnSubAdd">添加</button>
				<button class="btn btn-primary btn-sm" id="btnSubEdit">编辑</button>
				<button class="btn btn-primary btn-sm" id="btnSubPasswordReset">重置密码</button>
				<button class="btn btn-primary btn-sm" id="btnSubDelete">删除</button>
			</div> 
		</div>
		<div class="table-responsive">
			<table id="accountTable" class="table table-striped table-bordered table-hover"  style="margin-bottom:20px;">
				<thead>
					<tr>
						<th>
							<label>
								<input type="checkbox" class="ace" id="allCheck" />
								<span class="lbl"></span>
							</label>
						</th>
						<th>
							账号名称
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
	 
    <!--账号弹出框放置位置  添加 删除  查看详情-->
    <div id="dialogaccount-message" class="hide"> 
		<form class="bootbox-form">
		  <div>   
            <span>账号名称：</span><input id="accountName" type="text" class="ants"/><font color=red style="margin-left:10px">*</font><br/>
          </div>
          <div style="margin-top:15px">
            <span>密&nbsp;&nbsp;码：</span><input id="accountPsw" type="password" class="ants"/><br/> 
          </div> 
          <div style="margin-top:15px">
            <span>有效性&nbsp;：</span>
			<select id="accountValidFlag"  class="ants" style="margin-left:-6px">
	              <option value="">&nbsp;</option>	            
            </select> 
          </div> 
        </form>
	</div>
	
	<!-- 以下为js放置位置 --> 
	  
    <!--  引入js存放的外部脚本库  -->
	<jsp:include page="../include/mainFooter.jsp"></jsp:include>   
   	<script src="plug-in/ace/main/js/jquery.md5.js" type="text/javascript"></script>
   	<!-- 左侧树形图加载 以及查询数据源数据js -->
   	<script type="text/javascript">
   		var flags = false;   //是否是页面加载的标志
  		 //封装请求参数
        var param = {};
       //装载树形tree
      	jQuery(document).ready(function (e) {
      		dateDom();
      		var params = {};
      		params.parentOrganId = -1;
      		tree(params);
      		if(params.parentOrganId == -1){
      			params.parentOrganId = ${usersession.organId};
      		}
      		param.organId = 0;
      		$("#organName").val("组织机构");
      		findSelectData();      //查询条件数据源 	
      		flags = true;
      	    //日期框
			$('.date-picker').datepicker({
	            language: 'cn',
	            autoclose: true,
	            dateFormat: 'yy-mm-dd',
	           // altFormat: "yyyy-mm-dd",
	            todayHighlight: true,
	            showHms:false,/*是否显示时分秒*/
	            changeYear: true,
	            changeMonth: true,
	            yearRange:"1900:2016"
	        })
	        loadTableData();    		
		}); 
	
      //日期控件
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
		//查询条件数据源
		function findSelectData(){
		    //获取有效标志符
	        $.ajax({
	            type: "POST",
	            url: "rest/pms/villagerManageController/getValidFlag", 
	            cache: false,  //禁用缓存
	            dataType: "json",
	            success: function (result) {
	       			$("#userValidFlagQuery").html(""); 
	       			$("#userValidFlagQuery").append("<option value='0'>全部</option>");
	            	$("#accountValidFlag").html(""); 
	            	//$("#accountValidFlag").html("<option selected='selected' value='1'>是</option>");
	            	$("#validFlag").html("");
	            	for(var i=0;i<result.data.length;i++){
	             		$("#userValidFlagQuery").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
	             		$("#accountValidFlag").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
	             		$("#validFlag").append("<option id='Form"+result.data[i].subid+"' value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
	            	}
	            	var s = result.data[0].subid;
	            	//alert(s);
	            	$("#Form"+s).attr("selected", "selected");
	            },
	            error:function(){	            	
	            }
	        });
	        //获取性别
	        $.ajax({
	            type: "POST",
	            url: "rest/pms/villagerManageController/getSex", 
	            cache: false,  //禁用缓存
	            dataType: "json",
	            success: function (result) {
	       			$("#sex").html(""); 	       			
	            	for(var i=0;i<result.data.length;i++){
	             		$("#sex").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
	            	}
	            },
	            error:function(){	            	
	            }
	        });
	         //获取岗位
	         $.ajax({
	            type: "POST",
	            url: "rest/pms/postController/loadPost",
	            data: 'organId='+param.organId,
	            cache: false,  //禁用缓存
	            dataType: "json",
	            success: function (result) {
	       			$("#postNameQuery").html(""); 
	       			$("#postNameQuery").append("<option value='0'>全部</option>");
	            	for(var i=0;i<result.data.length;i++){
	             		$("#postNameQuery").append("<option value='"+result.data[i].postId+"'>"+result.data[i].postName+"</option>");
	            	}
	            	
	            },
	            error:function(){	            	
	            }
	        });	
	        //获取政治面貌
             $.ajax({
	            type: "POST",
	            url: "rest/pms/villagerManageController/getPoliticsStatus", 
	            cache: false,  //禁用缓存
	            dataType: "json",
	            success: function (result) {
	                     
	       			$("#politicsStatus").html(""); 	       			
	            	for(var i=0;i<result.data.length;i++){
	             		$("#politicsStatus").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
	            	}
	            },
	            error:function(){	            	
            	}
        	}); 
        	//获取合同类型 
        	 $.ajax({
	            type: "POST",
	            url: "rest/pms/villagerManageController/getContractType", 
	            cache: false,  //禁用缓存
	            dataType: "json",
	            success: function (result) {
	            	           
	       			$("#contractType").html(""); 	       			
	            	for(var i=0;i<result.data.length;i++){
	             		$("#contractType").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
	            	}
	            },
	            error:function(){	            	
            	}
        	});
        	//获取学历的下拉列表
        	 $.ajax({
	            type: "POST",
	            url: "rest/pms/villagerManageController/getEducation", 
	            cache: false,  //禁用缓存
	            dataType: "json",
	            success: function (result) {
	            	          
	       			$("#education").html(""); 	       			
	            	for(var i=0;i<result.data.length;i++){
	             		$("#education").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
	            	}
	            },
	            error:function(){	            	
            	}
        	});
		}
	
		//树形图
		function tree(params){
      	    	var DataSourceTree = function (options) {
      	        	this.url = options.url;
      	   		 }
	       	 DataSourceTree.prototype.data = function (options, callback) {
	       	    var self = this;
	       	    var $data = null;
	       	    if (!("name" in options) && !("type" in options) && params.parentOrganId != -1) {
	       	        params.parentOrganId = ${usersession.organId}; //load the first level  
	       	    } else if ("type" in options && options.type == "folder") {
	       	        //if ("additionalParameters" in options && "children" in options.additionalParameters) {
	       	        if (options.id!="0") {
	       	            params.parentOrganId = options.id;
	       	        }
	       	    }
	       	    if (params != null) {
	       	        $.ajax({
	       	            url: this.url,
	       	            data: params,
	       	            type: 'POST',
	       	            dataType: 'json',
	       	            success: function (response) {
	       	            	if(response.data.length > 0){
		       	            	if(response.data[0].id == 0){  //确保是第一次加载根节点
		       	            		response.data[0].id = ${usersession.organId}
		       	            		response.data[0].name = "${usersession.organName}"
		       	            	}
		       	                callback(response);
	       	            	}else{
	       	            		callback(response);
	       	            	}
	       	            },
	       	            error: function (response) {
	       	                console.log(response);
	       	            }
	       	        })
	       	    }
	       	};
	
	       	$('#treeView').ace_tree({
	       		dataSource: new DataSourceTree({
	       	    	url: 'rest/rbac/organController/getChildNode'
	       	    })
	       	});
	       	
	      	//加载grid数据（叶子节点）
	       	$('#treeView').on('selected', function(evt, data) {
	         	//取出ID
	         	param.organId=data.info[0].id;
	         	param.name = data.info[0].name;
	         	findSelectData();
	       	    loadTableData();
	       	    flags = false;
	       	});
	       	
	      	//加载grid数据（父节点）
	        $('#treeView').on('closed', function(evt, data) {
	        	param.organId=data.id;
	        	flags = false;
	        	param.name = data.name;
	        	findSelectData();
	   	     	loadTableData();
	    	});
	    	
	    	$('#treeView').on('opened', function(evt, data) {
	    		if(data.id == 0){
	    			param.organId = 0;
	    		}else{
	    			flags = false;
	    			param.organId=data.id;
		    		param.name = data.name;
		    		findSelectData();
		   	     	loadTableData();
	    		}
	    	});
    	 }

	
	</script>
		
    	<!-- 加载datables表数据js -->
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
        	var table = $("#usertable").dataTable({
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
					param.postId = $("#postNameQuery").val();
					param.realName = $("#realNameQuery").val();
					param.validFlag = $("#userValidFlagQuery").val();
	                param.rows = data.length;//页面显示记录条数，在页面显示每页显示多少项的时候
	                param.start = data.start;//开始的记录序号
	                param.page = (data.start / data.length)+1;//当前页码
	                if(flags){
	                	param.postId = 0;
	                	param.organId=${usersession.organId};
	                	param.name = "${usersession.organName}";
	                }
	                //ajax请求数据
	                $.ajax({
	                    type: "POST",
	                    url: "rest/pms/villagerManageController/girdUser",
	                    cache: false,  //禁用缓存
	                    data: param,  //传入组装的参数
	                    dataType: "json",
	                    success: function (result) {
	                     
	                        //setTimeout仅为测试延迟效果
	                        setTimeout(function () {
	                            //封装返回数据
	                            var returnData = {};
	                            returnData.draw = data.draw;//这里直接自行返回了draw计数器,应该由后台返回
	                            returnData.recordsTotal = result.total;//返回数据全部记录
	                            returnData.recordsFiltered = result.total;//后台不实现过滤功能，每次查询均视作全部结果
	                            returnData.data = result.data;//返回的数据列表
	                           
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
				        "data": "userId", // 数据列名
				        "orderable":false,
				        "sWidth":"5px",
				        "render": function(data, type, full) { // 返回自定义内容
				       		return "<label><input type='checkbox' class='ace' id='userId' value = '" + data + "' /><span class='lbl' id='sorganid' value = '" + data + "'></span></label>";
				         }
                    },
                    {
                    	"sWidth":"10%",
					  	"targets": [1], // 目标列位置，下标从0开始
					   	"data": "realName"// 姓名
					   	 
                    },
                    {						   
					   "sWidth":"20%",
					   	"targets": [2], // 目标列位置，下标从0开始
					   	"data": "organName" // 所属
					   	 
                    },
                    {
                    	"sWidth":"10%",
					   	"targets": [3], // 目标列位置，下标从0开始
					   	"data": "sexString" // 性别
                    },
                    {
					    "sWidth":"20%",
					   	"targets": [4], // 目标列位置，下标从0开始
					   	"data": "identitycard" // 身份证
                    },
                    {
					    "sWidth":"20%",
					   	"targets": [5], // 目标列位置，下标从0开始
					   	"data": "cellphone" // 联系方式
                    },
                    {
					    "sWidth":"20%",
					   	"targets": [6], // 目标列位置，下标从0开始
					   	"data": "phone" // 电表号
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
    
	function findselectorganData(postId){
		//ajax请求数据		
        $.ajax({
            type: "POST",
            url: "rest/pms/villagerManageController/loadPost",
            data: 'organId='+param.organId,          
            cache: false,  //禁用缓存
            dataType: "json",
            success: function (result) {        
        		$("#userAddPostName").empty();
            	for(var i=0;i<result.data.length;i++){
             		if(postId == -1){
             			$("#userAddPostName").append("<option value='"+result.data[i].postId+"'>"+result.data[i].postName+"</option>");
             		}else{
	             		if(result.data[i].postId == postId)
	           				$("#userAddPostName").append("<option selected='selected' value='"+result.data[i].postId+"'>"+result.data[i].postName+"</option>");
	        			else
	           				$("#userAddPostName").append("<option value='"+result.data[i].postId+"'>"+result.data[i].postName+"</option>");
       				}
            	}
            	
            },
            error:function(){	            	
            }
        });
	}
	
	$.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
		_title: function(title) {
			var $title = this.options.title || '&nbsp;'
			if( ("title_html" in this.options) && this.options.title_html == true )
				title.html($title);
			else title.text($title);
		}
	}));
	
	var thisid = null;
	$( "#lookdata" ).on('click', function(e) {
		if(param.organId == null || param.organId == ""){
			parent.bootbox.alert("请先选择左侧中的组织机构", function(){});
			return;
		}else{
			lookPost(e);
			thisid = this.id;  //获取当前点击按钮的id
		}
	});

	var par = {};   //声明ajax传输参数的数组变量
	
	function msginput(e, postIds){
		findselectorganData(postIds);
		e.preventDefault();
			var dialog = $( "#dialog-message" ).removeClass('hide').dialog({
				modal: true,
				title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i> 村民管理</h4></div>",
				title_html: true,
				width:800,
				height:300,
				buttons: [ 
					{
						text: "取消",
						"class" : "btn btn-xs",
						click: function() {
							$( this ).dialog( "close" );
							$("#realName").val('');
							$("#realName").removeAttr("readonly"); 
						} 
					},
					{
						text: "保存",
						"class" : "btn btn-primary btn-xs",
						click: function() {
							if(thisid == "btnAdd"){ 
								    par.organId = param.organId;
    								par.postId = $("#userAddPostName").val(); 
    								par.realName = $("#realNameAdd").val();   
    								par.sex = $("#sex").val();    
    								par.phone = $("#phone").val();   
    								par.cellphone = $("#cellphone").val();   
 		  							par.validFlag = 1;
 		  							par.identitycard = $("#identitycard").val();
 		  							add(par);															
							}
							if(thisid == "btnEdit"){
								par.organId = param.organId;
								par.postId = $("#userAddPostName").val();   
								par.realName = $("#realNameAdd").val();   
								par.sex = $("#sex").val();      
								par.identitycard = $("#identitycard").val();   
								par.phone = $("#phone").val();   
								par.cellphone = $("#cellphone").val();   
		  						par.validFlag = 1; 		  					
								edit(par);
							}
						} 
					}
				]
			});
	}

	//添加
	$( "#btnAdd" ).on('click', function(e) {
		thisid = this.id;  //获取当前点击按钮的id 
		if(param.organId == null || param.organId == 0 || flags == true){
			parent.bootbox.alert("请在左侧选择节点组织,组织机构下不可以添加用户", function(){});
		    return;		
		}else{
		    $("#organName").val(param.name);
			$("#userAddPostName").removeAttr("readonly"); 
			$("#realNameAdd").val('');
			$("#realName").removeAttr("readonly"); 
			$("#sex").val('');
			$("#sex").removeAttr("readonly"); 
			$("#sex").val('');
			$("#sex").removeAttr("readonly"); 
			$("#birthday").val('');
			$("#birthday").removeAttr("readonly"); 
			$("#identitycard").val('');
			$("#identitycard").removeAttr("readonly"); 
			$("#address").val('');
			$("#address").removeAttr("readonly"); 
			$("#phone").val('');
			$("#phone").removeAttr("readonly"); 
			$("#cellphone").val('');
			$("#cellphone").removeAttr("readonly"); 
			$("#education").val('');
			$("#education").removeAttr("readonly"); 
			$("#graduationDate").val('');
			$("#graduationDate").removeAttr("readonly"); 
			$("#politicsStatus").val('');
			$("#politicsStatus").removeAttr("readonly"); 
			$("#contractType").val('');
			$("#contractType").removeAttr("readonly"); 
			$("#contractStartDate").val('');
			$("#contractStartDate").removeAttr("readonly"); 
			$("#contractTerminationDate").val('');
			$("#contractTerminationDate").removeAttr("readonly"); 
			$("#professionalInfo").val('');
			$("#professionalInfo").removeAttr("readonly"); 
			$("#createDate").val('');
			$("#createDate").removeAttr("readonly"); 
			$("#validFlag").val('');
			$("#validFlag").removeAttr("readonly"); 
			findSelectData();
			msginput(e, -1);
		}
	});
	
	//添加用户信息
	function add(par){			
		if(par.organId == null || par.organId == ""){
			parent.bootbox.alert("组织机构不能为空,请在左侧菜单中选择", function(){});
			return;
		}else if(par.postId == null || par.postId == ""){
			parent.bootbox.alert("添加失败，请联系管理员" , function(){});
			//return;
			
		}else if(par.realName==null||par.realName==""){
				parent.bootbox.alert("真实姓名不能为空", function(){});
		}else if(par.identitycard==null||par.identitycard==""){
				parent.bootbox.alert("身份证不能为空", function(){});
		}else if(par.cellphone==null||par.cellphone==""){
				parent.bootbox.alert("联系方式不能为空", function(){});
		}
		else{  // if(IdentityCodeValid(par.identitycard))
				
			$.ajax({
   	            url: 'rest/pms/villagerManageController/addUser',
   	            data: par,
   	            type: 'POST',
   	            dataType: 'json',
   	            success: function (result) {
   	            	if(result.result == "success"){
	                	parent.bootbox.alert("添加成功", function(){ 
	                	$( "#dialog-message" ).dialog( "close" );
	                	});
	                	loadTableData();
	                	}else if(result.result == "error"){
	                		parent.bootbox.alert("用户名已经存在，请更换用户名", function(){});
	                	}
   	            },
   	            error: function(){
   	                parent.bootbox.alert("系统错误！添加用户失败。请刷新重新操作。", function(){});
   	            }
   	        });			 
		}
		
	}
	
	//编辑
	$( "#btnEdit" ).on('click', function(e) {
		if($("#userId:checked").length>1){
			parent.bootbox.alert("只能选择一个用户进行编辑", function(){});
        	return;
		}
		thisid = this.id;  //获取当前点击按钮的id		
		editAction(e);
	});
	
	//编辑用户的赋值方法
	function editAction(e){		
		par.userId = $("#userId:checked").val();
		if(par.userId == null || par.userId == ""){
			parent.bootbox.alert("请先选择要编辑的用户", function(){});
			return;
		}else{
			$.ajax({
	            url: 'rest/pms/villagerManageController/getUserInfo',
	            data: 'userId='+par.userId,
	            type: 'POST',
	            dataType: 'json',
	            success: function (result) {
	            	console.log(result.data);
	            	$("#organName").val(param.name);
	            	if(flags){
	            		$("#organName").val(result.organInfo.organName);
	            	}
					param.organId = result.data[0].organId;
                	$("#validitysFrom").empty();
	       			$("#validitysFrom").append("<option value=''></option>");
	                $("#realNameAdd").val(result.data[0].realName); 
	                $("#sex").val(result.data[0].sex);  
	                $("#identitycard").val(result.data[0].identitycard); 
	                $("#address").val(result.data[0].address); 
	                $("#phone").val(result.data[0].phone); 
	                $("#cellphone").val(result.data[0].cellphone); 
	                $("#education").val(result.data[0].education);  
	                $("#politicsStatus").val(result.data[0].politicsStatus); 
	                $("#contractType").val(result.data[0].contractType);  
	                $("#professionalInfo").val(result.data[0].professionalInfo);  
	                $("#validFlag").val(result.data[0].validFlag); 
	                if(result.data[0].birthday !=null && result.data[0].birthday!="")
	                {
		                $("#birthday").val(FormatDate(result.data[0].birthday.time)); 
	                } 
	                if(result.data[0].graduationDate !=null && result.data[0].graduationDate!="")
	                {
		                $("#graduationDate").val(FormatDate(result.data[0].graduationDate.time)); 
	                }
	                if(result.data[0].contractStartDate !=null && result.data[0].contractStartDate!="")
	                {
		                $("#contractStartDate").val(FormatDate(result.data[0].contractStartDate.time)); 
	                } 
		            if(result.data[0].contractTerminationDate !=null && result.data[0].contractTerminationDate!="")
	                {
		                $("#contractTerminationDate").val(FormatDate(result.data[0].contractTerminationDate.time)); 
	                } 
		            if(result.data[0].createDate !=null && result.data[0].createDate!="")
	                {
		                $("#createDate").val(FormatDate(result.data[0].createDate.time)); 
	                }
					msginput(e, result.data[0].postId);
	            },
	            error: function(){
	            	parent.bootbox.alert("系统错误，查看数据失败。请刷新重新操作", function(){});
	            	return;
	            }
	        	});
		}
	}

	//格式化编辑时加载的 时间格式
	function FormatDate (strTime) {
	    var date = new Date(strTime);
	    return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
	}
	
	//编辑用户的保存方法
	function edit(par){
		if(par.organId == null || par.organId == ""){
			parent.bootbox.alert("请在左侧菜单中选择组织机构", function(){});
			return;
		}else if(par.postId == null || par.postId == ""){
				parent.bootbox.alert("更新失败，请联系管理员" , function(){});
				return;
		}else if(par.realName==null||par.realName==""){
			parent.bootbox.alert("真实姓名不能为空", function(){});
		}else if(par.identitycard==null||par.identitycard==""){
				parent.bootbox.alert("身份证不能为空", function(){});
		}else if(par.cellphone==null||par.cellphone==""){
				parent.bootbox.alert("联系方式不能为空", function(){});
			}
			else{
				par.userId = $("#userId:checked").val();
				par.organId = param.organId;
				
				$.ajax({
		            url: 'rest/pms/villagerManageController/editUserInfo',
		            data: par,
		            type: 'POST',
		            dataType: 'json',
		            success: function (result) {
		            	if(result.result == "success"){
		                	parent.bootbox.alert("更新用户成功", function(){
		                	$("#dialog-message").dialog("close");
		                	loadTableData();
		                	});
		                	}else{
		                		parent.bootbox.alert("用户名已经存在，请更换用户名", function(){});
		                	}
	   	            },
	   	            error: function(){
	   	            	parent.bootbox.alert("系统错误，更新数据失败请刷新重新操作。", function(){});
	   	            	return;
	   	            }
			   });
		}
 }
	//删除用户信息
	$( "#btnDelete" ).on('click', function(e) {
		if($("#userId:checked").length <= 0){
			parent.bootbox.alert("请先选择要删除的用户", function(){});
			return;
		}else{
				par.organId = param.organId;
				del(par); 
			}		
	});
	
	function del(par){
		 par.userIds=[];	     
			parent.bootbox.confirm("你确定要删除该用户吗？", function(result) {
			if(result){				
				for(var i=0; i<$("#userId:checked").length;i++){
					par.userIds[i] = $("#userId:checked")[i].defaultValue;
				}
					$.ajax({
	    	            url: 'rest/pms/villagerManageController/delUserInfo',
	    	            async: false,
	    	            data: par,
	    	            type: 'POST',
	    	            dataType: 'json',
	    	            success: function (result) { 
	    	            	if(result.result == "success"){
		    	            	parent.bootbox.alert("删除用户成功", function(){});
		    	                loadTableData();
		    	             }
		    	            else if(result.result=="error"){
	   	                		parent.bootbox.alert("该用户已被引用，不允许删除："+result.info, function(){});
	   	                	}
	    	            },
	    	            error: function(){
	    	            	parent.bootbox.alert("该用户已被引用，不允许删除", function(){});
	    	            }
		   	        });	   	       
			}else{
				return;
			}
		});
	  }
	  
	var accountpar = {};   //声明ajax传输参数的数组变量
	//账号管理
	$( "#btnManage" ).on('click', function(e) {
		thisid = this.id;  //获取当前点击按钮的id 
		accountpar.userId = $("#userId:checked").val();
		if(accountpar.userId == null || accountpar.userId == ""){
			parent.bootbox.alert("请先选择要操作的用户", function(){});
			return;
		} 
		$.ajax({
            url: 'rest/pms/villagerManageController/getUserInfo',
            async: false,
            data: 'userId='+accountpar.userId,
            type: 'POST',
            dataType: 'json',
            success: function (result) {  
        		$("#userRealName").val(result.data[0].realName); 
            },
            error: function(){
        		$("#userRealName").val(""); 
            }
	     });
		msgManageInput(e);
		loadAccountTableData();
	});

	function msgManageInput(e){
		e.preventDefault();
			var dialog = $( "#dialogmanage-message" ).removeClass('hide').dialog({
				modal: true,
				title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i> 账号管理</h4></div>",
				title_html: true,
				width:610,
				height:500,
				buttons: [ 
					{
						text: "关闭",
						"class" : "btn btn-xs",
						click: function() {
							$( this ).dialog( "close" ); 
						} 
					}
				]
			});
	}

    </script> 
    
    <!-- 子页面的 数据操作处理js 增删该查 -->
    <script type="text/javascript">
    
    function loadAccountTableData(){
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
    	var table = $("#accountTable").dataTable({
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
				param.userId = accountpar.userId;
                param.rows = data.length;//页面显示记录条数，在页面显示每页显示多少项的时候
                param.start = data.start;//开始的记录序号
                param.page = (data.start / data.length)+1;//当前页码
               
                //ajax请求数据
                $.ajax({
                    type: "POST",
                    url: "rest/pms/villagerManageController/gridAccount",
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
			        "data": "accountId", // 数据列名
			        "orderable":false,
			        "sWidth":"15px",
			        "render": function(data, type, full) { // 返回自定义内容
			       		return "<label><input type='checkbox' class='ace' id='accountId' value = '" + data + "' /><span class='lbl' id='sorganid' value = '" + data + "'></span></label>";
			         }
                },
                {
				  	"targets": [1], // 目标列位置，下标从0开始
				   	"data": "accountName",
				   	 "sWidth":"50%"
                },
                {
				   	"targets": [2], // 目标列位置，下标从0开始
				   	"data": "validFlagString", // 数据列名
				   	 "sWidth":"40%"
                }
        ]
    }).api();
    //此处需调用api()方法,否则返回的是JQuery对象而不是DataTables的API对象
    }

  //账号管理
	$( "#btnSubAdd" ).on('click', function(e) {
		thisid = this.id;  //获取当前点击按钮的id 
		$("#accountName").val('');
		$("#accountName").removeAttr("readonly");
		$("#accountPsw").val('');
		$("#accountPsw").removeAttr("readonly");
		$("#accountValidFlag").val("");
		$("#accountValidFlag").removeAttr("readonly"); 
		accountInput(e); 
	});

	function accountInput(e){
		e.preventDefault();
			var dialog = $( "#dialogaccount-message" ).removeClass('hide').dialog({
				modal: true,
				title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i> 账号设置</h4></div>",
				title_html: true, 
				width:350,
				buttons: [ 
					{
						text: "取消",
						"class" : "btn btn-xs",
						click: function() {
							$( this ).dialog( "close" );
							$("#accountName").val('');
							$("#accountName").removeAttr("readonly");
							$("#accountPsw").val('');
							$("#accountPsw").removeAttr("readonly");
							$("#accountValidFlag").val("");
							$("#accountValidFlag").removeAttr("readonly"); 
						}
					},
					{
						text: "保存",
						"class" : "btn btn-primary btn-xs",
						click: function() {
							if(thisid == "btnSubAdd"){
								accountpar.accountName = $("#accountName").val(); 
								var md5pwd = $.md5($("#accountPsw").val());
								$("#accountPsw").val(md5pwd); 
								accountpar.passWord = $("#accountPsw").val();
								accountpar.validFlag = $("#accountValidFlag").val();
								accountAdd(accountpar); 
							}
							if(thisid == "btnSubEdit"){
								accountpar.accountName = $("#accountName").val(); 
								var md5pwd = $.md5($("#accountPsw").val());
								$("#accountPsw").val(md5pwd); 
								accountpar.passWord = $("#accountPsw").val(); 
								accountpar.validFlag = $("#accountValidFlag").val();
								accountEdit(accountpar);
							}
						}
					}
				]
			});
	}

	//添加账号信息
	function accountAdd(accountpar){
		 
		if(accountpar.accountName==null||accountpar.accountName==""){
			parent.bootbox.alert("账户名称不能为空", function(){});
		}else{
			$.ajax({
  	            url: 'rest/pms/villagerManageController/addAccount',
  	            data: accountpar,
  	            type: 'POST',
  	            dataType: 'json',
  	            success: function (result) {
  	            	if(result.result == "success"){
                		parent.bootbox.alert("添加账户成功", function(){
			                $( "#dialogaccount-message" ).dialog("close");
		                	loadAccountTableData(); 
		                });
                	}else{
                		parent.bootbox.alert("账户名称已经存在，请更换账户名", function(){});
                	}  	      			 
  	            },
  	            error: function(){
  	                parent.bootbox.alert("添加失败", function(){});
  	            }
  	        });
	}
	}
 
	//账户编辑
	$( "#btnSubEdit" ).on('click', function(e) {
		if($("#accountId:checked").length>1)
		{
			parent.bootbox.alert("只能选择一个账户进行编辑", function(){});
        	return;
		}
		thisid = this.id;  //获取当前点击按钮的id  
		 editAccountAction(e);   
	});
	//重置密码
	$("#btnSubPasswordReset").on('click',function(e){
	   if($("#accountId:checked").length>1)
	   {
	        parent.bootbox.alert("只能选择一个账户进行重置",function(){});
	        return;
	   }
	   thisid = this.id;
	   resetAccountAction(e);
	});
	//编辑账户的赋值方法
	function editAccountAction(e){
		accountpar.accountId = $("#accountId:checked").val();
	     if(accountpar.accountId == null || accountpar.accountId == ""){
			parent.bootbox.alert("请先选择要编辑的账户", function(){});
			return;
		}else{
			$.ajax({
	            url: 'rest/pms/villagerManageController/getAccountInfo',
	            data: 'accountId='+accountpar.accountId,
	            type: 'POST',
	            dataType: 'json',
	            success: function (result) { 
                	$("#accountName").val(result.accountInfo[0].accountName); 
	                $("#accountPsw").val(result.accountInfo[0].passWord);  
	                $("#accountValidFlag").val(result.accountInfo[0].validFlag); 
	                accountInput(e);
	            },
	            error: function(){
	            	parent.bootbox.alert("查看数据失败", function(){});
	            	return;
	            }
	        	});
		} 
	} 
	
	//编辑账户的保存方法
	function accountEdit(accountpar){
		accountpar.accountId = $("#accountId:checked").val(); 
		if(accountpar.accountName==null||accountpar.accountName==""){
			parent.bootbox.alert("账户名称不能为空", function(){});
			}
		else{
			$.ajax({
	            url: 'rest/pms/villagerManageController/editAccountInfo',
	            data: accountpar,
	            type: 'POST',
	            dataType: 'json',
	            success: function (result) {
	            	if(result.result == "success"){
		                	parent.bootbox.alert("更新账户成功", function(){
		                		 $( "#dialogaccount-message" ).dialog("close");
		                		 loadAccountTableData(); 
		                	});
	                	}else{
	                		parent.bootbox.alert("账户名称已经存在，请更换账户名", function(){});
	                }            			
   	            },
   	            error: function(){
   	            	parent.bootbox.alert("系统错误！更新数据失败。请刷新重试！", function(){});
   	            	return;
   	            }
	        	});
	}
	}
 //重置密码前获取账户信息
	function resetAccountAction(e){
		parent.bootbox.confirm("确定要重置密码吗？", function (result){
         	if(result){
         		accountpar.accountId = $("#accountId:checked").val(); 
         		accountpar.passWord = "f379eaf3c831b04de153469d1bec345e"; 
         		accountpar.flag = 1;
				if(accountpar.accountId==null||accountpar.accountId==""){
					parent.bootbox.alert("请选择账户", function(){});
				}else{
					$.ajax({
			            url: 'rest/pms/villagerManageController/editAccountInfo',
			            data: accountpar,
			            type: 'POST',
			            dataType: 'json',
			            success: function (result) {
			            	if(result.result == "success"){
				                	parent.bootbox.alert("重置密码成功，默认密码为：666666", function(){});
				                		 loadAccountTableData(); 
				                	
			                	}else{
			                		parent.bootbox.alert("重置密码失败", function(){});
			                }            			
		   	            },
		   	            error: function(){
		   	            	parent.bootbox.alert("系统错误！更新数据失败。请刷新重试！", function(){});
		   	            	return;
		   	            }
		        	});
				}
         	}
         	else
         		return;
         });
	} 
	//删除账户信息
	$( "#btnSubDelete" ).on('click', function(e) { 
		accountdel(accountpar); 
	});
	
	function accountdel(accountpar){
		accountpar.accountId = $("#accountId:checked").val();
	     if(accountpar.accountId == null || accountpar.accountId == ""){
			parent.bootbox.alert("请先选择要删除的账户信息", function(){});
			return;
		 }else{
		 	par.accountIds=[];
			parent.bootbox.confirm("你确定要删除账户吗？", function(result) {
			if(result){
				//var eventmgr = "";
				for(var i=0; i<$("#accountId:checked").length;i++){
					par.accountIds[i]=$("#accountId:checked")[i].defaultValue;
					//accountpar.accountId = $("#accountId:checked")[i].defaultValue;
				}
				$.ajax({
    	            url: 'rest/pms/villagerManageController/delAccountInfo',
    	            async: false,
    	            //data: 'accountId='+accountpar.accountId,
    	            data:par,
    	            type: 'POST',
    	            dataType: 'json',
    	            success: function (result) { 	    	            	
    	            	 if(result.result == "success"){
    	                	parent.bootbox.alert("删除账户成功", function(){});
    	                	loadAccountTableData();
   	                	}
   	                	else if(result.result=="error"){
   	                		parent.bootbox.alert("账户已被引用，不允许删除："+result.info, function(){});
   	                	}
    	            },
    	            error: function(){ 
    	            	//eventmgr= accountpar.accountId+"删除失败";
    	            	return;
    	            }
	   	        });	   	       
			}else{
				return;
			}
		});
	  }
	  } 
		//身份证号合法性验证 
		//支持15位和18位身份证号
		//支持地址编码、出生日期、校验位验证
        function IdentityCodeValid(code) { 
            var city={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江 ",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北 ",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏 ",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外 "};
            var tip = "";
            var pass= true;  
            if(!code || !/^[1-9][0-9]{5}(19[0-9]{2}|200[0-9]|2010)(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|3[01])[0-9]{3}[0-9xX]$/i.test(code)){
                tip = "身份证号格式错误";
                pass = false;
            }else if(!city[code.substr(0,2)]){
                tip = "地址编码错误";
                pass = false;
            }
            else{
                //18位身份证需要验证最后一位校验位
                if(code.length == 18){
                    code = code.split('');
                    //∑(ai×Wi)(mod 11)
                    //加权因子
                    var factor = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ];
                    //校验位
                    var parity = [ 1, 0, 'X', 9, 8, 7, 6, 5, 4, 3, 2 ];
                    var sum = 0;
                    var ai = 0;
                    var wi = 0;
                    for (var i = 0; i < 17; i++)
                    {
                        ai = code[i];
                        wi = factor[i];
                        sum += ai * wi;
                    }
                    var last = parity[sum % 11];
                    if(parity[sum % 11] != code[17]){
                        tip = "校验位错误";
                        pass =false;
                    }
                }
            }
            if(!pass) parent.bootbox.alert(tip);
            return pass;
        }    
	
    </script>
    
	</body>
</html>

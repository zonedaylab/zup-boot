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
		<title>积成能源 运维监控平台树形图</title>
	    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	    
	    <!--	引入外部样式库css	-->
	    <jsp:include page="../include/mainHead.jsp"></jsp:include>
    </head>
    <body style="background-color:#FFFFFF;">
    <div class="row">
		<div class="col-sm-3 col-xs-12 col-lg-3" style="margin-top:-3px; paading:0px;">
			<div class="widget-box">
				<div class="widget-header header-color-blue2">
					<h4 class="lighter smaller">系统管理</h4>
				</div>
				<div class="widget-body" style="height:900px;">
					<div class="widget-main padding-8">
						<div id="treeview" class="tree"></div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-9 col-xs-12 col-lg-9 widget-body">	
			<div class="table-header">系统详情</div>
			<div class="row1">
				<div class="col-md-4" style="margin-left:20px;height:30px; margin-bottom:10px; margin-top:5px;">					
					<button class="btn btn-primary btn-sm" id="btnAdd">添加</button>
					<button class="btn btn-primary btn-sm" id="btnEdit">编辑</button>
					<button class="btn btn-primary btn-sm" id="btnDelete">删除</button>
				</div>
				<div class="col-md-9"></div>
			</div>	
			<div class="form-group">			
			<form class="form-horizontal" role="form">			
					<div class="form-group">
						<label class="col-md-2 control-label no-padding-right" for=""> </label>
							<div class="col-sm-6">								
							</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 col-xs-4 control-label no-padding-right" for="systemNameForm"> 系统名称：</label>
							<div class="col-sm-6 col-xs-8">
								<input type="text" id="systemNameForm" class="col-xs-10 col-sm-5" />
							</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 col-xs-4 control-label no-padding-right" for="systemUrlForm"> 路&nbsp;&nbsp;径：</label>
							<div class="col-sm-6 col-xs-8">
								<input type="text" id="systemUrlForm" class="col-xs-10 col-sm-5" />
							</div>
					</div>				
					<div class="form-group">
						<label class="col-md-2 col-xs-4 control-label no-padding-right" for="validFlagForm" style="letter-spacing:3px;"> 有效性：</label>
							<div class="col-sm-6 col-xs-8">
								<input type="text" id="validFlagForm"  class="col-xs-10 col-sm-5" />
							</div>
					</div>									
			</form>
			</div>
		</div>
	</div>
	<!--弹出框放置位置  添加 删除  查看详情-->
    <div id="dialog-message" class="hide"> 
		<div class="container">
			<div class="row clearfix">
				<div class="col-md-12 column">
					<div class="form-group">
						 <strong for="systemName" class="col-xs-12 col-md-3 control-label" style="text-align: left" >系统名称:</strong>
						<div class="col-xs-12 col-md-8">
							<input class="form-control" id="systemName" type="text" />
						</div>
						<div class="col-xs-12 col-md-1">
							<font color=red>*</font>
						</div>
					</div> 
					<div class="form-group">
						 <strong for="systemUrl" class="col-xs-12 col-md-3 control-label" style="text-align: left" >路&nbsp;&nbsp;径：</strong>
						<div class="col-xs-12 col-md-8">
							<input class="form-control" id="systemUrl" type="text" />
						</div>
						<div class="col-xs-12 col-md-1">
							
						</div>
					</div> 
					<div class="form-group">
						 <strong for="validFlag" class="col-xs-12 col-md-3 control-label" style="text-align: left" style="letter-spacing:3px;">有 效 性：</strong>
						<div class="col-xs-12 col-md-8">
							<select id="validFlag" class="form-control" >
					              <option value="">&nbsp;</option> 
				            </select>
						</div>
						<div class="col-xs-12 col-md-1">
							
						</div>
					</div>						         
				</div>
			</div>
		</div>
	</div> 
	
    <!--  引入js存放的外部脚本库  -->
	<jsp:include page="../include/mainFooter.jsp"></jsp:include>   
    	
   <script type="text/javascript">
        //装载树形tree
       	jQuery(document).ready(function (e) {
       		var params = {};       		
       		tree(params);       		     	
       	    function tree(params){
       	    	var DataSourceTree = function (options) {
       	        	this.url = options.url;
       	   		 }
		       	 DataSourceTree.prototype.data = function (options, callback) {
		       	    var self = this;
		       	    var $data = null;		       	   
		       	    if (params != null) {
		       	        $.ajax({
		       	            url: this.url,
		       	            data: params,
		       	            type: 'POST',
		       	            dataType: 'json',
		       	            success: function (response) {
		       	                callback(response);
		       	                //默认打开二级
		               			var cobj = $('#treeview .tree-folder:eq(1)')[0].childNodes[1];
					            if(response.data[0].id == 0){
					           	    cobj.click();
					            }
		       	            },
		       	            error: function (response) {
		       	                console.log(response);
		       	            }
		       	        })
		       	    }
		       	};		
		$('#treeview').ace_tree({
       		dataSource: new DataSourceTree({
       	    	url: 'rest/rbac/systemController/getSystemTree'
       	    })
		     });
		//加载grid数据（叶子节点）
		$('#treeview').on('selected', function(evt, data) {
         	//取出ID
         	param.systemId=data.info[0].id;
         	param.systemName = data.info[0].name;
       	    loadMainFormData();
       		});		      
       	    }
       	//日期框
		$('.date-picker').datepicker({
            language: 'zh-CN',
            autoclose: true,
            format: 'yyyy-mm-dd',
            todayHighlight: true
	        })       	    
		});	
    </script>
    <script type="text/javascript">	
		var param = {};
		//显示系统详情信息
		function loadMainFormData() {
			$.ajax( {
				type : "POST",
				url : "rest/rbac/systemController/getSystem",
				cache : false, //禁用缓存
				data : param, //传入组装的参数
				dataType : "json",
				success : function(result) {							
					$("#systemNameForm").val(result.data[0].systemName);
					$("#systemNameForm").attr("readonly",true);
					$("#systemUrlForm").val(result.data[0].systemUrl);	
					$("#systemUrlForm").attr("readonly",true);				
					$("#validFlagForm").val(result.data[0].validFlagString);
					$("#validFlagForm").attr("readonly",true);
				}
			});
		}
		
		//加载编辑表单
		function loadAddFormData() {
			$.ajax( {
				type : "POST",
				url : "rest/rbac/systemController/getSystem",
				cache : false, //禁用缓存
				data : param, //传入组装的参数
				dataType : "json",
				success : function(result) {				
					$("#systemName").val(result.data[0].systemName);
					$("#systemUrl").val(result.data[0].systemUrl);
					$("#validFlag").val(result.data[0].validFlag);
				}
			});
		}
	</script> 
	<script type="text/javascript">	
		var thisid = null;
		//添加按钮
		$( "#btnAdd" ).click(function(e) {
			thisid = this.id;  //获取当前点击按钮的id
			$("#systemName").val('');
			$("#systemName").removeAttr("readonly");
			$("#systemUrl").val('');
			$("#systemUrl").removeAttr("readonly");
			$("#validFlag").val('');
			$("#validFlag").removeAttr("readonly");	
			msginput(e);
			})
			
		//删除按钮
		$('#btnDelete').click(function(){
		if(param.systemId == null || param.systemId == ""){
				parent.bootbox.alert("请在左侧选择要删除的系统", function(){});
				return;		
			}
			else{			
				deleteSystem();
			}			
		})	
		//编辑按钮
		$("#btnEdit").click(function(e){
			thisid = this.id;
			if(param.systemId == null || param.systemId == ""){
				parent.bootbox.alert("请在左侧选择要编辑的系统", function(){});
				return;
			}else{		
				loadAddFormData();
				msginput(e);
			}	
		})
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
		
		//弹出框信息
		var par = {};
		function msginput(e){
			e.preventDefault();
			var dialog = $( "#dialog-message" ).removeClass('hide').dialog({
				modal: true,
				title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>系统管理操作</h4></div>",
				title_html: true,
				width:415,
				buttons: [ 
					{
						text: "取消",
						"class" : "btn btn-xs",
						click: function() {
							$( this ).dialog( "close" ); 
								$("#systemName").val('');
								$("#systemName").removeAttr("readonly");
								$("#systemUrl").val('');
								$("#systemUrl").removeAttr("readonly");
								$("#validFlag").val('');
								$("#validFlag").removeAttr("readonly");	
						} 
					},
					{
						text: "保存",
						"class" : "btn btn-primary btn-xs",
						click: function() {										 
							if(thisid=="btnAdd"){	//添加							
								par.systemName = $("#systemName").val();								
								par.systemUrl = $("#systemUrl").val();								
								par.validFlag = $("#validFlag").val();								
								addSystem(par);
							}
							if(thisid=="btnEdit"){//更新操作								
								editSystem(e);								
							}
						}
					}						
				]
			});
			}
		//增加系统
		function addSystem(par){					
			 if(par.systemName == "" ||par.systemName==null){
					parent.bootbox.alert("系统名称不能为空" , function(){});
					return;
			}else{
				$.ajax({
       	            url: 'rest/rbac/systemController/addSystem',
       	            data: par,
       	            type: 'POST',
       	            dataType: 'json',
       	            success: function (result) {       	           
       	            	if(result.result == "success"){
    	                	parent.bootbox.alert("添加成功", function(){
    	                		$( "#dialog-message" ).dialog( "close" );
    	                		window.location.reload();
    	                	});    	                	
   	                	}else{
   	                		parent.bootbox.alert("系统名称重复，请更换系统名称", function(){});
   	                	}
       	            },
       	            error: function(){
       	                parent.bootbox.alert("系统添加失败", function(){});
       	            }
       	        })
       	    }
       	}
       	
       	//编辑（调用更新操作）
        function editSystem(){			
			par.systemId = param.systemId;
			par.systemName = $("#systemName").val();	
			par.systemUrl = $("#systemUrl").val();		
			par.validFlag = $("#validFlag option:selected").val();	
			if(par.systemName == "" ||par.systemName==null){
					parent.bootbox.alert("系统名称不能为空" , function(){});					
			}
			else{		
				$.ajax({
    	            url: 'rest/rbac/systemController/editSystem',
    	            data: par,
    	            type: 'POST',
    	            dataType: 'json',
    	            success: function (result) { 
    	             if(result.result == "success"){
   	                	parent.bootbox.alert("更新成功", function(){
   	                	if(result){
   	                		window.location.reload();
   	                	}
   	                	});    	                	
   	                	}else{
   	                		parent.bootbox.alert("系统名称重复，请更换系统名称", function(){
   	                		
   	                		});
   	                	}
    	            },
    	            error: function(){
    	            	parent.bootbox.alert("更新数据失败", function(){});
    	            	return;
    	            }
   	        	});
   	        }	
		}
		
      //删除系统
	  function deleteSystem(){				
			bootbox.confirm("你确定要删除吗？", function(result) {
				if(result){					
					systemId =param.systemId; 				
					$.ajax({
		  	            url: 'rest/rbac/systemController/deleteSystem',
		  	            async: false,
		  	            data: 'systemId='+systemId,
		  	            type: 'POST',
		  	            dataType: 'json',
		  	           	success: function (result) {		  	           		  	           
		  	           		if(result.result=="success"){
		  	           			parent.bootbox.alert("删除成功", function(){
		  	           				window.location.reload();
		  	           				});
		  	           		}
		  	           		if(result.result=="error"){
		  	           			parent.bootbox.alert("该系统已被引用，不允许删除", function(){});
		  	           		}		    	                
		   	            },
		   	        	error: function(){
		   	            	parent.bootbox.alert("该系统已被引用，不允许删除", function(){});
		   	            }
		   	        });   	       
				loadMainFormData();
			}
			else{
					return;
				}				
			});			
		}			
	</script>
	<script type="text/javascript">
	
	//获取系统的有效标志
	 $.ajax({
            type: "POST",
            url: "rest/rbac/userController/getValidFlag", 
            cache: false,  //禁用缓存
            dataType: "json",
            success: function (result) {
       			$("#validFlag").html("");        			
            	for(var i=0;i<result.data.length;i++){
             		$("#validFlag").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
            	}
            },
            error:function(){	            	
            }
        });
 	</script>
	</body>
</html>

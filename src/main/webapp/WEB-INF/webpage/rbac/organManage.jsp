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
		<title>积成 运维监控平台树形图</title>
	    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	    
	    <!--	引入外部样式库css	-->
	    <jsp:include page="../include/mainHead.jsp"></jsp:include>
	    
	</head>
    <body style="background-color:#FFFFFF;">
    <div class="row">
		<div class="col-sm-3 col-xs-12 col-lg-3" style="margin-top:-3px; padding:0px;">
			<div class="widget-box">
				<div class="widget-header header-color-blue2" style="margin-left: 2%;">
					<h4 class="lighter smaller">组织机构</h4>
				</div>
				<div class="widget-body" >
					<div class="widget-main padding-8">
						<div id="treeview" class="tree"></div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-8 col-xs-12 col-lg-8 widget-body">
			<div class="table-header">组织机构详情</div>
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
					<label class="col-md-6 control-label no-padding-right" for=""> </label>
							<div class="col-sm-6">								
							</div>
				</div>
				<div class="form-group" style="display:none">
					<label class="col-md-3 col-xs-3 control-label no-padding-right" for="organIdForm" style=" position:static; left:10px; letter-spacing: 5px;">部门ID</label>
							<div class="col-sm-6 col-xs-6">
								<input type="text" id="organIdForm"  class="col-xs-6 col-sm-5"/>
							</div>
				</div> 
				
				<div class="form-group">
					<label class="col-md-3 col-xs-3 control-label no-padding-right" for="organNameForm"> 名&nbsp;&nbsp;称</label>
							<div class="col-sm-6 col-xs-6">
								<input type="text" id="organNameForm" class="col-xs-6 col-sm-5" />
							</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 col-xs-3 control-label no-padding-right" for="shortNameForm"> 简&nbsp;&nbsp;称</label>
							<div class="col-sm-6 col-xs-6">
								<input type="text" id="shortNameForm"  class="col-xs-6 col-sm-5" />
							</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 col-xs-3 control-label no-padding-right" for="organCodeForm">编&nbsp;&nbsp;号</label>
							<div class="col-sm-6 col-xs-6">
								<input type="text" id="organCodeForm"  class="col-xs-6 col-sm-5" />
							</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 col-xs-3 control-label no-padding-right" for="orderCodeForm" style="letter-spacing: 3.5px;">排序号</label>
							<div class="col-sm-6 col-xs-6">
								<input type="text" id="orderCodeForm"  class="col-xs-6 col-sm-5" />
							</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 col-xs-3 control-label no-padding-right" for="organTypeForm"> 组织类型</label>
							<div class="col-sm-6 col-xs-6">
								<input type="text" id="organTypeForm"  class="col-xs-6 col-sm-5" />
							</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 col-xs-3 control-label no-padding-right" for="governorForm"> 主管人员</label>
							<div class="col-sm-6 col-xs-6">
								<input type="text" id="governorForm"  class="col-xs-6 col-sm-5" />
							</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 col-xs-3 control-label no-padding-right" for="validFlagForm" style="letter-spacing: 3.5px;">有效性</label>
							<div class="col-sm-6 col-xs-6">
								<input type="text" id="validFlagForm"  class="col-xs-6 col-sm-5" />
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
					<form class="form-horizontal" role="form">
				        <div class="form-group">
							 <strong for="organName" class="col-xs-3 col-md-3 control-label" style="text-align: left" >名&nbsp;&nbsp;称：</strong>		
				           	<div class="col-xs-8 col-md-8">
								<input class="form-control" id="organName" type="text" />
							</div>
							<div class="col-xs-1 col-md-1" style="position:absolute; top:56px; right:17px">
								<font color=red>*</font>
							</div>
						</div>
						 <div class="form-group">
							 <strong for="shortName" class="col-xs-3 col-md-3 control-label" style="text-align: left" >简&nbsp;&nbsp;称：</strong>		
				           	<div class="col-xs-8 col-md-8">
								<input class="form-control" id="shortName" type="text" />
							</div>
							<div class="col-xs-1 col-md-1">
								
							</div>
						</div>
						<div class="form-group">
							 <strong for="organCode" class="col-sm-3  col-xs-3 col-md-3 control-label" style="text-align: left" >编&nbsp;&nbsp;号：</strong>		
				           	<div class="col-sm-8 col-xs-8 col-md-8">
								<input class="form-control" id="organCode" type="text" />
							</div>
							<div class="col-sm-1 col-xs-1 col-md-1">
								
							</div>
						</div>
						 <div class="form-group">
							 <strong for="orderCode" class="col-xs-3 col-md-3 control-label" style="text-align: left;letter-spacing:5px;" >排序号：</strong>		
				           	<div class="col-xs-8 col-md-8">
								<input class="form-control" id="orderCode" type="text" />
							</div>
							<div class="col-xs-1 col-md-1" style="position:absolute; top:153px; right:17px">
								<font color=red>*</font>
							</div>
						</div>
				        <div class="form-group">
							 <strong for="organType" class="col-xs-3 col-md-3 control-label" style="text-align: left" >组织类型：</strong>
							<div class="col-xs-8 col-md-8"> 
					            <select id="organType" class="form-control" >
						              <option value="">&nbsp;</option> 
					            </select>
							</div>
							<div class="col-xs-1 col-md-1">
								
							</div>
						</div>      
				         <div class="form-group">
							 <strong for="governor" class="col-xs-3 col-md-3 control-label" style="text-align: left" >主管人员：</strong>		
				           	<div class="col-xs-8 col-md-8">
								<input class="form-control" id="governor" type="text" />
							</div>
							<div class="col-xs-1 col-md-1">
								
							</div>
						</div>
				        <div class="form-group">
							 <strong for="validFlag" class="col-xs-3 col-md-3 control-label" style="text-align: left;letter-spacing:5px;" >有效性：</strong>
							<div class="col-xs-8 col-md-8"> 
					            <select id="validFlag" class="form-control" >
						              <option value="">&nbsp;</option> 
					            </select>
							</div>
							<div class="col-xs-1 col-md-1">
								
							</div>
						</div>
				       </form>
					</div> 
				</div>
			</div> 
		</div>

    <!--  引入js存放的外部脚本库  -->
	<jsp:include page="../include/mainFooter.jsp"></jsp:include>   
    	
    <script type="text/javascript">
        //装载树形tree
       	jQuery(document).ready(function (e) { 
       		var pars = {};
       		var parentOrgan={};//为每个子节点保存其父节点
       		pars.parentOrganId = -1;
	       	tree(pars);
	       	if(pars.parentOrganId == -1){
	       		pars.parentOrganId = 0;
	       	}
	       	function tree(pars){         	
	       	     var DataSourceTree = function (options) {
	       	        this.url = options.url;
	       	     }
		       	 DataSourceTree.prototype.data = function (options, callback) {
		       	    var self = this;
		       	    var $data = null;
		       	    if (!("name" in options) && !("type" in options) && pars.parentOrganId != -1) {
		       	        pars.parentOrganId = 0; //load the first level  
		       	    } else if ("type" in options && options.type == "folder") {
		       	       		 if (options.id!="0") {
			       	            pars.parentOrganId = options.id;
			       	            parentOrgan=pars.parentOrganId;
		       	        }
		       	        else{
		       	        	par.organId=options.id;		       	        
		       	        }
		       	    }
	       	        $.ajax({
	       	            url: this.url,
	       	            data: pars,
	       	            type: 'POST',
	       	            dataType: 'json',
	       	            success: function (response) {
	       	                callback(response);
	       	                var cobj = $("#treeview  .tree-folder:eq(1)")[0].childNodes[1];
				            if(response.data[0].id == 0){
				           	    cobj.click();
				           	    if(params.parentMenuId == -1){
									params.parentMenuId = 0;
								}
				            }
	       	            },
	       	            error: function (response) {
	       	                console.log(response);
	       	            }
	       	        })
		       	};
		
		       	$('#treeview').ace_tree({
		       		dataSource: new DataSourceTree({
		       	    	url: 'rest/rbac/organController/getChildNode'
		       	    })
		       	});
		      	//加载grid数据（叶子节点）
		       	$('#treeview').on('selected', function(evt, data) {
		         	//取出ID
		         	param.type=data.info[0].type;
		         	param.organId=data.info[0].id;
		         	param.name = data.info[0].name;
		       	    loadMainFormData();
		       	});
		      	//加载grid数据（父节点）
		        $('#treeview').on('closed', function(evt, data) {
		       		param.type=data.type;
		        	param.organId=data.id;
		        	param.name = data.name;
		   	     	loadMainFormData();
		    	});
		    	$('#treeview').on('opened', function(evt, data) {
		    		if(data.id == 0){
		    			param.organId=0;
		    		}else{
		    			param.type=data.type;		    		
			    		param.organId=data.id;
			    		param.name = data.name;
			   	     	loadMainFormData();
		    		}
		    	});
	   	   }  
		});        
    </script>
    <script type="text/javascript">	
    	$('.tree-item-name').on('click', function(){
    		alert("111");
    	});	
    	//通过枚举类型获取组织的类型
	   		  $.ajax({
		            type: "POST",
		            url: "rest/rbac/organController/getOrganType", 
		            cache: false,  //禁用缓存
		            dataType: "json",
		            success: function (result) {
		       			//$("#organType").html(""); 
		       			$("#organType").empty();
	       				$("#organType").append("<option value=''></option>");	       			
		            		for(var i=0;i<result.data.length;i++){
		             		$("#organType").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
		            	}
		            },
		            error:function(){	            	
		            }
	        });
	        $(document).ready(function(){
	        	getValidFlag();
	       	});
		//通过枚举获取有效性
		function getValidFlag(){
	         $.ajax({
	            type: "POST",
	            url: "rest/rbac/userController/getValidFlag", 
	            cache: false,  //禁用缓存
	            dataType: "json",
	            success: function (result) {
	       			//$("#validFlag").html(""); 	
	       			$("#validFlag").empty(); 			
	            	for(var i=0;i<result.data.length;i++){
	             			$("#validFlag").append("<option id='Form"+result.data[i].subid+"' value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
	             	}
	            	var s = result.data[0].subid;
	            	$("#Form"+s).attr("selected", "selected");
	            },
	            error:function(){	            	
	            }
	        });
	   }
 	</script>
    <script type="text/javascript">		 
		var param = {};
		var parentOrgan={};
		//显示组织机构的详细信息
		function loadMainFormData() {
			$.ajax( {
				type : "POST",
				url : "rest/rbac/organController/getOrgan",
				cache : false, //禁用缓存
				data : param, //传入组装的参数
				dataType : "json",
				success : function(result) {
					parentOrgan=result.data[0].parentOrganId;//为该父节点的各个子节点保存parentorganid		
					$("#organIdForm").val(param.organId);
					$("#organIdForm").attr("readonly",true);
					$("#organNameForm").val(result.data[0].organName);
					$("#organNameForm").attr("readonly",true);
					$("#organCodeForm").val(result.data[0].organCode);
					$("#organCodeForm").attr("readonly",true);
					$("#shortNameForm").val(result.data[0].shortName);
					$("#shortNameForm").attr("readonly",true);
					$("#orderCodeForm").val(result.data[0].orderCode);
					$("#orderCodeForm").attr("readonly",true);
					$("#organTypeForm").val(result.data[0].organTypeString);
					$("#organTypeForm").attr("readonly",true);
					$("#governorForm").val(result.data[0].governor);
					$("#governorForm").attr("readonly",true);
					$("#validFlagForm").val(result.data[0].validFlagString);
					$("#validFlagForm").attr("readonly",true);
				}
			});
		}
		//显示编辑组织的信息
		function loadAddPanelData() {		
			$.ajax( {
				type : "POST",
				url : "rest/rbac/organController/getOrgan",
				cache : false, //禁用缓存
				data : param, //传入组装的参数
				dataType : "json",
				success : function(result) {
					parentOrgan=result.data[0].parentOrganId;//为该父节点的各个子节点保存parentorganid
					$("#organId").val(param.organId);					
					$("#organName").val(result.data[0].organName);					
					$("#organCode").val(result.data[0].organCode);				
					$("#shortName").val(result.data[0].shortName);				
					$("#orderCode").val(result.data[0].orderCode);					
					//$("#organType").val(result.data[0].organTypeString);
					$("#organType").find("option[value='"+result.data[0].organType+"']").attr("selected",true);	
					$("#governor").val(result.data[0].governor);					
					$("#validFlag").find("option[value='"+result.data[0].validFlag+"']").attr("selected",true);	
					//getValidFlag(result.data[0].validFlag);
					//console.log("有效值"+result.data[0].validFlag);
										
				}
			});
		}
		
		//添加一个组织
		function addOrgan(par){							
			if(par.organName == "" || par.organName==null){
				parent.bootbox.alert("组织名字不能为空" , function(){});
				//return;
			}
			else if(par.orderCode == "" || par.organName==null){
				parent.bootbox.alert("排序号不能为空" , function(){});
				//return;
			}
			else{		
				$.ajax({
       	            url: 'rest/rbac/organController/addOrgan',
       	            data: par,
       	            type: 'POST',
       	            dataType: 'json',
       	            success: function (result) {   
       	            	if(result.msg=="success"){ 
       	            		parent.bootbox.alert("添加成功", function(){ 
       	            			$( "#dialog-message" ).dialog( "close" );        	
	    	                	window.location.reload();    	                	
	    	                	});     	                	   	                	
	   	                }
	   	                if(result.msg=="organName"){
	   	                	parent.bootbox.alert("组织名称已经存在，请更换组织名称", function(){});
	   	                
	   	                }
						if(result.msg=="orderCode"){
	   	                		parent.bootbox.alert("该排序号已经存在，请更换排序号", function(){});
	   	                	}
   	                 },       	           
       	            error: function(){
       	                parent.bootbox.alert("添加失败", function(){});
       	            }
       	        })
       	    }
       	}
       	
       	//编辑一个组织
       	function editOrgan(par){
       		if(par.organName == "" || par.organName==null){
				parent.bootbox.alert("组织名字不能为空" , function(){});
				//return;
			}else{	       					
				$.ajax({
    	            url: 'rest/rbac/organController/editOrgan',
    	            data: par,
    	            type: 'POST',
    	            dataType: 'json',
    	            success: function (result) {				   	                        
       	            	if(result.msg=="success"){     	            	
	    	                parent.bootbox.alert("更新成功", function(){
	    	                   $( "#dialog-message" ).dialog( "close" );        	
	    	                	window.location.reload();  
	    	                	});     	                	   	                	
	   	                	}
	   	                if(result.msg=="organName"){
	   	                	parent.bootbox.alert("组织名称已经存在，请更换组织名称", function(){});
	   	                
	   	                }
						if(result.msg=="orderCode"){
	   	                		parent.bootbox.alert("该排序号已经存在，请更换排序号", function(){});
	   	                	}
    	            },
    	            error: function(){
    	            	parent.bootbox.alert("更新数据失败", function(){});
    	            	return;
    	            }
   	        	});
		}
		}
		
		//删除组织机构
		function deleteOrgan() {			
			param.organId = $("#organIdForm").val();					
				if (param.type == "folder") {
					 parent.bootbox.alert("该组织存在其他子组织，不允许删除", function(){});					
						}
				else if (param.type == "item") {
				 	bootbox.confirm("你确定要删除吗？", function(result) {
					if(result){
						organId =param.organId;
						$.ajax({
							type : "POST",
							url : "rest/rbac/organController/deleteOrgan",
							async : false,							
							data: 'organId='+organId,
							dataType : "json",
							success : function(result) {												
								if(result.result=="success"){								
									parent.bootbox.alert("删除成功", function() {																					
									window.location.reload();
									});
								}
								else{
									parent.bootbox.alert("该组织已被引用，不允许删除", function() {																					
									return;
										});
								}
							},							
							error : function() {
								parent.bootbox.alert("该组织已被引用，不允许删除", function() {																				
								return;									
								});
							}
						});
						loadMainFormData();
							}							
					})
				}
		}		
	 </script>

    <script type="text/javascript">	
		var thisId = null;
		//增加按钮控制
		$("#btnAdd").click(function(e){
		  thisId = this.id;
		  if(param.organId == null && param.organId != 0){
				parent.bootbox.alert("请在左侧选择要增加的组织节点", function(){});
			    return;		
			}
		 else{			
			$("#organName").val('');
            $("#organCode").val('');
            $("#shortName").val('');
            $("#orderCode").val('');
            $("#organType").val('');
            $("#governor").val('');
            $("#validFlag").val('');
			msgInput(e);
			}			
		})
		
		//编辑按钮控制
		$("#btnEdit").click(function(e){
			thisId = this.id;
			if(param.organId == null || param.organId == ""){
				parent.bootbox.alert("请在左侧选择要编辑的组织", function(){});
				return;		
			}
			else{
				loadAddPanelData();		
				msgInput(e);
			}			
		})
		
		//删除按钮控制
		$('#btnDelete').click(function(){		
			if(param.organId == null || param.organId == ""){
				parent.bootbox.alert("请在左侧选择要删除的组织", function(){});
				return;		
			}
			else{			
				deleteOrgan();
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
		var par = {};
		
		//弹出框信息
		function msgInput(e){
			e.preventDefault();
			var dialog = $( "#dialog-message" ).removeClass('hide').dialog({
				modal: true,
				title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>组织管理操作</h4></div>",
				title_html: true,
				width:450,
				buttons: [ 
				 {
					text: "取消",
					"class" : "btn btn-xs",
					click: function() {
					  $( this ).dialog( "close" ); 
							$("#organName").val('');
							$("#organName").removeAttr("readonly");
				            $("#organCode").val('');
				            $("#organCode").removeAttr("readonly");
				            $("#shortName").val('');
				            $("#shortName").removeAttr("readonly");
				            $("#orderCode").val('');
	           				$("#orderCode").removeAttr("readonly");
				            $("#organType").val('');
				            $("#organType").removeAttr("readonly");
				            $("#governor").val('');
				            $("#governor").removeAttr("readonly");
				            $("#validFlag").val('');
				            $("#validFlag").removeAttr("readonly");
						} 
				},
				{
					text: "保存",
					"class" : "btn btn-primary btn-xs",
					click: function() {	
					  	if(thisId=="btnAdd"){ //添加子组织						 					
							par.parentOrganId=param.organId;								
							par.organName = $("#organName").val();								
							par.organCode = $("#organCode").val();
							par.shortName = $("#shortName").val();
							par.orderCode = $("#orderCode").val();
							par.organType = $("#organType").val();
							par.governor = $("#governor").val();
							par.validFlag = $("#validFlag").val();
							addOrgan(par);
							//loadMainFormData();							
					  	}
					  	if(thisId=="btnEdit"){//编辑子组织																					
							par.organId=param.organId;
				       		par.parentOrganId=parentOrgan; 
							par.organName = $("#organName").val();								
							par.organCode = $("#organCode").val();
							par.shortName = $("#shortName").val();
							par.orderCode =	$("#orderCode").val();
							par.organType = $("#organType").val();
							par.governor = $("#governor").val();
							par.validFlag = $("#validFlag").val();	
								
							editOrgan(par);	
							//loadMainFormData();								
					  	}
							//$( this ).dialog( "close" ); 
							//$("#organName").val('');
							//$("#organName").removeAttr("readonly");
				           // $("#organCode").val('');
				           // $("#organCode").removeAttr("readonly");
				            //$("#shortName").val('');
				            //$("#shortName").removeAttr("readonly");
				            //$("#orderCode").val('');
	           				//$("#orderCode").removeAttr("readonly");
				           // $("#organType").val('');
				            //$("#organType").removeAttr("readonly");
				           // $("#governor").val('');
				           // $("#governor").removeAttr("readonly");
				            //$("#validFlag").val('');
				           // $("#validFlag").removeAttr("readonly");
						}
						}				
				]
			});
			}			
	</script>
	</body>
</html>

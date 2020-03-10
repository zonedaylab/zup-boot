<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>维表设置</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		
    <!--        引入外部样式库css        -->
    <jsp:include page="../include/mainHead.jsp"></jsp:include>
	<link rel="stylesheet" type="text/css" href="plug-in/ace/bi/css/dim.css?v=1.0">

  </head>
  
  <body style="background:#fafafa; overflow: hidden; overflow-y: auto;">
  	<div>
	  	<form id="iform">
		    <!--维表设置-->
		    <div class="row row-5">
		        <div class="col-lg-12 col-md-12 col-xs-12">
		            <span class="glyphicon glyphicon-chevron-down"></span>
		            <span class="title">维表设置</span>
		        </div>
		        <div class="col-lg-12 col-md-12 col-xs-12 lineSpacing">
		            <div class="row">
		                <div class="col-lg-4 col-md-5 col-xs-5">
		                    <span class="star text-indent-4 float-left">*</span>
		                    <span class="text float-left">数据库表名称</span>
		                    <select class="form-control inputWidth float-left" id="dbName" name="dbName">

		                    </select>
		                </div>
		                <div class="col-lg-4 col-md-5 col-xs-5">
		                    <span class="star text-indent-4 float-left">*</span>
		                    <span class="text float-left">维名称</span>
		                    <input type="text" class="form-control inputWidth" id="dimName" name="dimName" />
		                    <input type="text" class="form-control inputWidth" id="dimId" name="dimId" style="display:none;"/>
		                </div>
		            </div>
		        </div>
		    </div>
		    <!--字段设置-->
		    <div class="row row-5">
		        <div class="col-lg-12 col-md-12 col-xs-12">
		            <span class="glyphicon glyphicon-chevron-down"></span>
		            <span class="title">字段显示</span>
		        </div>
		        <div class="col-lg-12 col-md-12 col-xs-12 lineSpacing">
		            <div class="row">
		                <table cellpadding="0" cellspacing="0" border="0" class="text-indent-4" width="95%">
		                    <thead>
		                        <td>字段</td>
		                        <td>字段名称</td>
		                        <td>字段描述</td>
		                        <td>字段字段长度</td>
		                        <td>字段小数位数</td>
		                        <td>字段字段类型</td>
		                    </thead>
		                    <tbody id="fieldTbody">
		                    </tbody>
		                </table>
		            </div>
		        </div>
		    </div>

		    <!--字段ID设置-->
		    <div class="row row-5" id="radio">
		        <div class="col-lg-12 col-md-12 col-xs-12">
		            <span class="glyphicon glyphicon-chevron-down"></span>
		            <span class="title">维表ID、文字字段设置</span>
		        </div>
		        <div class="col-lg-12 col-md-12 col-xs-12 lineSpacing text-indent-4">
		            <div class="row">
			      	    <div class="col-lg-6 col-md-6 col-xs-6">
			            	<span class="radioText">ID字段</span>
			                <select class="form-control tableInput tableValueInput" name="idField"> </select>
			      	    </div>
			      	    <div class="col-lg-6 col-md-6 col-xs-6">
			            	<span class="radioText">文字字段</span>
			                <select class="form-control tableInput tableValueInput" name="nameField"> </select>
			      	    </div>
		      	    </div>
		        </div>
		    </div>


		    <!--树形设置-->
		    <div class="row row-5" id="radio">
		        <div class="col-lg-12 col-md-12 col-xs-12">
		            <span class="glyphicon glyphicon-chevron-down"></span>
		            <span class="title">树形设置</span>
		        </div>
		        <div class="col-lg-12 col-md-12 col-xs-12 lineSpacing text-indent-4">
		            <div class="row row-5">
		                <input type="radio" name="tree" class="form-control" style="width: 15px; height: 15px; float: left;" value="1"/>
		                <span class="radioText">无层次结构</span>
		            </div>
<!-- 		            <div class="row row-5"> -->
<!-- 		                <input type="radio" name="tree" class="form-control" style="width: 15px; height: 15px; float: left; margin-top: 5px;" value="2"/> -->
<!-- 		                <span class="radioText">分段信息</span> -->
<!-- 		                <input type="text" class="form-control tableValueInput float-left" id="piecewiseInfo" name="piecewiseInfo" /> -->
<!-- 		                <span class="text float-left" style="margin-top: -5px;">（如：1-2-3 未做）</span> -->
<!-- 		            </div> -->
		            <div class="row row-5">
		                <input type="radio" name="tree" class="form-control" style="width: 15px; height: 15px; float: left;" id="openRadioPath" value="3" />
		                <span class="radioText">钻取路径</span>
		                <input type="text" class="form-control tableValueInput float-left" id="openPath" name="openPath" />
		            </div>
		        </div>
		    </div>

			<!--属性设置-->
			<div class="row row-5">
				<div title="属性设置专为钻取方式所用!" class="col-lg-12 col-md-12 col-xs-12">
					<span class="glyphicon glyphicon-chevron-down"></span>
					<span class="title" >钻取属性设置</span>
				</div>
				<div class="col-lg-12 col-md-12 col-xs-12 lineSpacing">
					<div class="row">
						<table cellpadding="0" cellspacing="0" border="0" class="text-indent-4" width="95%">
							<thead>
							<td>属性</td>
							<td>属性名称</td>
							<td>属性列名</td>
							<td>文字列名</td>
							<!-- 		                    <td>是否需要分割</td> -->
							<td><span class="glyphicon glyphicon-plus add" id="addValue"></span></td>
							</thead>
							<tbody id="valTbody">
							<tr>
								<td colspan='5' id='tip'>请点击加号进行添加属性</td>
								<!--<td><span class="text" id="value">属性1</span></td>
                                <td><input type="text" class="form-control tableValueInput" id="valueName" name="valueName" /></td>
                                <td><select class="form-control tableInput tableValueInput" name="valueColName"></select></td>
                                <td><select class="form-control tableInput tableValueInput" name="textColName"></select></td>
                                 <td><input class="form-control tableInput tableValueInput" name="split" value="0"/></td>
                                <td class="glyphicon glyphicon-minus add" onclick="delValue(this)" style="height: 35px; line-height: 35px;"></td>-->
							</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>

		    <!-- 保存按钮 -->
		    <div class="row row-5">
		    	<input type="button" id="save" class="btn btn-sm btn-primary" value="保存" style="float:right; margin-right:10%;" />
		    </div>

 		    <div style="margin-left: 20px;">
 		    	<p>注意：使用须知：</p>
 		    	<ol>
 		    		<li>属性名称填写规则：必须填写数据表中的列名称！</li>
 		    		<li>属性列名填写规则：不允许书写中文和数字！</li>
 		    		<li>文字列名填写规则：不允许书写中文和数字</li>
 		    		<li>ID字段填写规则： 必须是你设置的是维度选择的物理表中和主题表中选择具有关联的一个字段，因为这里要作为 join 表连接时的  on 条件！</li>
 		    	</ol>
 		    </div>
	    </form>
	</div>
	<select id="linshi" style="display:none;">
	
	</select>
    
    <!--  引入js存放的外部脚本库  -->
    <jsp:include page="../include/mainFooter.jsp"></jsp:include>
    
    <script type="text/javascript">
		var dimId=null;
		$(function (){
			$("[data-toggle='popover']").popover();
		});
    	var langData;
	    $.ajax({
    	   url: "plug-in/ace/adIcon/lang/zh-cn.json",//json文件位置
    	   async: false,
    	   type: "GET",//请求方式为get
    	   dataType: "json", //返回数据格式为json
    	   success: function(data) {//请求成功完成后要执行的方法 
    		   langData = data;
    	   }
    	});

		dimId="${dimId}";
		//alert("提示信息！"+dimId);
		loadTableName();
    	var param = "";
    	//加载数据库表名 
    	function loadTableName(){
    		$.ajax({ 
    			type: "POST",
    			url: "rest/bi/BIDimController/getDatabaseTableName",
    			cache: false, //禁用缓存
    			data: "",
    			dataType: "json",
    			success: function(result){
    				if(result.data != "error"){
    					$("#dbName").html("");
    					$("#dbName").append("<option value='0'>请选择</option>");
    					for(var i=0; i< result.data.length; i++){
    						var txt = langData.dimManage.tableName[result.data[i]];
    						if(typeof(txt) == "undefined" || txt == "")
    							txt = result.data[i];
    						$("#dbName").append("<option value="+result.data[i]+">"+txt+"</option>");
    					}
    				}else{
    					parent.bootbox.alert("数据表名称加载失败");
    				}
    			},
    			error: function(){
    				parent.bootbox.alert("数据表名称加载失败");
    			}
    		});
    	}
    	
    	$("#addConn").click(function(){
    		$.ajax({ 
    			type: "POST",
    			url: "rest/bi/BIDimController/addConnection",
    			cache: false, //禁用缓存
    			data: {
    				className: "com.mysql.jdbc.Driver",
    				url: "jdbc:mysql://192.168.10.216:3306/mgeids?useUnicode=true&characterEncoding=UTF-8",
					user: "root",
					pwd: "andot"
    			},
    			dataType: "json",
    			success: function(result){
    				loadTableName();
    			},
    			error: function(){
    				parent.bootbox.alert("失败");
    			}
    		});
    	});
    	
    	//数据表名称发生改变时
    	$("#dbName").on("change", function(){
    		param = $("#dbName").val();
    		loadDbDim(1);
    		loadDataFaild();
    	});
    	
    	//添加属性
    	var i = 0;
    	$("#addValue").on("click", function(){
    		$("#tip").remove();
    		i++;
    		$("#valTbody").append("<tr><td><span class='text' name='value'>属性"+i+"<sup style='color: red;'>新</sup></span><input style='display:none;' id='valueId' name='valueId' value='0'/></td><td><input type='text float-left' class='form-control tableValueInput' name='valueName' /></td><td><select class='form-control tableInput tableValueInput' name='valueColName'>"+$("#linshi").html()+"</select></td><td><select class='form-control tableInput tableValueInput' name='textColName'>"+$("#linshi").html()+"</select></td><td class='glyphicon glyphicon-minus add'  onclick='delValue(this)'></td></tr>");
    		$('[name="valueColName"]').change(function(){
    			$($(this).parent().prev().children()[0]).val($(this).val())
    		});
    	});
    	//删除属性
    	function delValue(obj){
    		$(obj).parent().remove();
    	}
    	
    	//根据选中的数据表名称加载数据字段
    	function loadDataFaild(){
    		$.ajax({
    			type: "POST",
    			url: "rest/bi/BIDimController/getTableData",
    			cache: false, //禁用缓存
    			data: "tableName="+param,
    			dataType: "json",
    			success: function(result){
    				$("#fieldTbody").empty();
    				$('[name="idField"]').empty();
    				$('[name="nameField"]').empty();
    				$('[name="valueColName"]').append("");
					$('[name="textColName"]').append("");
    				if(result.data != "error"){
    					for(var i=0; i< result.data.length; i++){
    						var txt = "";
    						if(typeof(langData.dimManage[param]) == "undefined")
    							txt = result.data[i].dim_Field_Name;
    						else
    							txt = langData.dimManage[param][result.data[i].dim_Field_Name]
    						$("#fieldTbody").append("<tr><td>字段"+(i+1)+"</td><td>"+result.data[i].dim_Field_Name+"</td><td>"+txt+"</td><td>"+result.data[i].field_Length+"</td><td>"+result.data[i].field_Decimal+"</td><td>"+result.data[i].field_Type+"</td></tr>");
    						$('[name="idField"]').append("<option value="+result.data[i].dim_Field_Name+">"+txt+"</option>");
    						$('[name="nameField"]').append("<option value="+result.data[i].dim_Field_Name+">"+txt+"</option>");
    						$('[name="valueColName"]').append("<option value="+result.data[i].dim_Field_Name+">"+txt+"</option>");
 							$('[name="textColName"]').append("<option value="+result.data[i].dim_Field_Name+">"+txt+"</option>");
    						$("#linshi").append("<option value="+result.data[i].dim_Field_Name+">"+txt+"</option>");
    					}
    					loadDbDim(0);
    				}else{
    					parent.bootbox.alert("表数据加载失败");
    				}
    			},
    			error: function(){
    				parent.bootbox.alert("表数据加载失败");
    			}
    		});
    	}
    	
    	//保存事件
    	$("#save").on("click", function(){
    		var dimName = $("#dimName").val();
    		var dbName = $("#dbName").val();
    		if(dbName == 0){
    			parent.bootbox.alert("请选择数据库表名称");
    			return;
    		}else if(dimName == ""){
    		 	parent.bootbox.alert("请输入维名称");
    		 	return;
    		}else{
    			saveDimData();
    		}
    	});
    	
    	//保存维表数据
    	function saveDimData(){
		    $.ajax({
    			type: "POST",
    			url: "rest/bi/BIDimController/saveDimData",
    			cache: false, //禁用缓存
    			data: $('#iform').serialize(),
    			dataType: "json",
    			success: function(result){
    				if(result.info != "error"){
    					parent.bootbox.alert(result.info);
						window.close();
						window.opener.document.location.reload();  //调用子窗体的父窗体进行刷新
    				}else{
    					parent.bootbox.alert("表数据加载失败");
    				}
    			},
    			error: function(){
    				parent.bootbox.alert("表数据加载失败");
    			}
    		});
    	}
    	
    	//通过数据库表名查看是否已经有维表
		function loadDbDim(type){
		    var dbName = $("#dbName").val();
			$.ajax({
                   type: "POST",
                   url: "rest/bi/BIDimController/loadDbDim",
                   cache: false,  //禁用缓存
                   data: "dnName="+dbName,  //传入组装的参数
                   dataType: "json",
                   success: function (result) {
                   		if(result.info == "success"){

                   			$("#tip").remove();
                   			$("#dimId").val(result.dim.dim_Id);
                   			if(type==1){
                   				$("#dimName").val(result.dim.dim_Name);
    	                   		$("#openPath").val(result.dim.drill_Info);
    	                   		$("#idField").val(result.dim.id_Field);
    			            	var obj = $(":input[name='tree']");
    			            	if(obj.attr("type") == "radio"){
    			            		obj.each(function(){
    			            		    if($(this).attr("value") == result.dim.drill_Type){
    			            		    	$(this).attr("checked","checked"); 
    				            		}
    			            		});
    			            	}
    	                   		$("#valTbody").html("");
    	                   		for(var i=0; i<result.dimInfo.length ;i++){
    	 							$("#valTbody").append("<tr><td><span class='text' name='value'>属性"+(i+1)+"</span><input id='valueId' style='display:none;' name='valueId' value="+result.dimInfo[i].attribute_Id+" /></td><td><input type='text float-left' class='form-control tableValueInput' name='valueName' value="+result.dimInfo[i].attribute_Caption_Field+" /></td><td><select class='form-control tableInput tableValueInput' name='valueColName'>"+$("#linshi").html()+"</select></td><td><select class='form-control tableInput tableValueInput' name='textColName'>"+$("#linshi").html()+"</select></td><td class='glyphicon glyphicon-minus add' onclick='delValue(this)' style='height: 35px; line-height: 35px;'></td></tr>");
    	 							$('[name="valueColName"]').val(result.dimInfo[i].attribute_Value_Field);
    	 							$('[name="textColName"]').val(result.dimInfo[i].attribute_Name);
    	                   		}
                   			}else{
                   				for(var z=0; z<result.dimInfo.length ;z++){
    	                   			$($('[name="valueColName"]')[z]).val(result.dimInfo[z].attribute_Value_Field)
    	                   			$($('[name="textColName"]')[z]).val(result.dimInfo[z].attribute_Name)
    	                   		}
                   			}
	                   	}else{
	                   		$("#dimName").val("");
	                   		$("#openPath").val("");
			            	var obj = $(":input[name='tree']");
	                   		if(obj.attr("type") == "radio"){
			            		obj.each(function(){
			            		   $(this).attr("checked","check"); 
			            		});
			            	}
	                   		$("#valTbody").html("<td colspan='5' id='tip'>请点击加号进行添加属性</td>");
	                   		//$("#valTbody").append("<tr><td><span class='text' name='value'>属性1</span></td><td><input type='text float-left' class='form-control tableValueInput' name='valueName'/></td><td><select class='form-control tableInput tableValueInput' name='valueColName' ></select></td><td><select class='form-control tableInput tableValueInput' name='textColName'></select></td><td class='glyphicon glyphicon-minus add'  onclick='delValue(this)' style='height: 35px; line-height: 35px;'></td></tr>");
	                   	}
                   },
                   error: function(){
                   		parent.bootbox.alert("数据库表名编辑获取失败", function(){});
                   }
               });
		}
    	
    </script>
    
  </body>
</html>

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
		<title>客户线索</title>
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
     <div class="row" align="left" id="energyCustomerClueEdit" style="margin-top:15px;">
			<div class="col-sm-12 col-xs-12 col-lg-12 widget-body"align="left">
			<div class="row center center-block">
				<div class="container"align="left">
					<div class="row clearfix"align="left">
						<div class="col-md-20 column" align="left">
							<form class="form-horizontal" role="form">
								<div class="form-group program-b">
									<div class=" program-b-b">
									</div>
									<div class="col-xs-10 col-md-10"  style="margin-left: 1%;">
										<label class="col-xs-5 col-md-4 control-label" style="text-align: right; letter-spacing:2.5px;  " >公司名称：</label>
										<div class="input-group col-xs-5 col-md-7">
											<input class="form-control" id="customerNameEdit" type="text" />
										</div>
										<div class="input-group col-xs-1 col-md-1" style="margin-top: 6px;">
											<font color="red">*</font>
										</div>
									</div>
								</div>
								<div class="form-group program-b" >
									<div class=" program-b-b"></div>
									<div>
										<div class="col-md-2 col-xs-2"></div>
										<div class="col-md-5 col-xs-5">
											<label class="col-xs-4 col-md-3 control-label">所在地区：</label>
											<div class="input-group col-xs-5 col-md-7">
												<input class="form-control" id="provinceEdit" type="text">
											</div>
											<label class="col-xs-1 col-md-1 control-label">省</label>
										</div>
										<div class="col-md-4 col-xs-4 col-lg-4">
											<div class="col-xs-5 col-md-7">
												<input type="text" id="cityEdit" class="form-control" style=" height:34px">
											</div>
											<label class="col-xs-1 col-md-1 control-label">市</label>
										</div>
									</div>
								</div>
								<div class="form-group program-b">
									<div class=" program-b-b">
									</div>
									<div class="col-xs-10 col-md-10"  style="margin-left: 1%;">
										<label class="col-xs-5 col-md-4 control-label" style="text-align: right; letter-spacing:2.5px;  " >公司地址：</label>
										<div class="input-group col-xs-5 col-md-7">
											<input class="form-control" id="customerAddressEdit" type="text" />
										</div>
										<div class="input-group col-xs-1 col-md-1" style="margin-top: 6px;">
											<font color="red">*</font>
										</div>
									</div>
								</div>
								<div class="form-group program-b">
									<div class=" program-b-b">
									</div>
									<div class="col-xs-10 col-md-10"  style="margin-left: 1%;">
										<label class="col-xs-5 col-md-4 control-label" style="text-align: right; letter-spacing:2.5px;  " >联系人：</label>
										<div class="input-group col-xs-5 col-md-7">
											<input class="form-control" id="linkmanNameEdit" type="text" />
										</div>
										<div class="input-group col-xs-1 col-md-1" style="margin-top: 6px;">
											<font color="red">*</font>
										</div>
									</div>
								</div>
								<div class="form-group program-b">
									<div class=" program-b-b">
									</div>
									<div class="col-xs-10 col-md-10"  style="margin-left: 1%;">
										<label class="col-xs-5 col-md-4 control-label" style="text-align: right; letter-spacing:2.5px;  " >联系电话：</label>
										<div class="input-group col-xs-5 col-md-7">
											<input class="form-control" id="linkmanPhoneEdit" type="text" />
										</div>
										<div class="input-group col-xs-1 col-md-1" style="margin-top: 6px;">
											<font color="red">*</font>
										</div>
									</div>
								</div>
								<div class="form-group program-b">
									<div class=" program-b-b">
									</div>
									<div class="col-xs-10 col-md-10"  style="margin-left: 1%;">
										<label class="col-xs-5 col-md-4 control-label" style="text-align: right; letter-spacing:2.5px;  " >电压等级：</label>
										<div class="input-group col-xs-5 col-md-7">
											<input class="form-control" id="voltageClassEdit" type="text" />
										</div>
										<div class="input-group col-xs-1 col-md-1" style="margin-top: 6px;">
											<font color="red">*</font>
										</div>
									</div>
								</div>
								<div class="form-group program-b">
									<div class=" program-b-b">
									</div>
									<div class="col-xs-10 col-md-10"  style="margin-left: 1%;">
										<label class="col-xs-5 col-md-4 control-label" style="text-align: right; letter-spacing:2.5px;  " >年用电量(兆瓦时)：</label>
										<div class="input-group col-xs-5 col-md-7">
											<input class="form-control" id="yearQuantityEdit" type="text" />
										</div>
										<div class="input-group col-xs-1 col-md-1" style="margin-top: 6px;">
											<font color="red">*</font>
										</div>
									</div>
								</div>
								<div class="form-group program-b">
									<div class=" program-b-b">
									</div>
									<div class="col-xs-10 col-md-10"  style="margin-left: 1%;">
										<label class="col-xs-5 col-md-4 control-label" style="text-align: right; letter-spacing:2.5px;  " >项目概况：</label>
										<div class="input-group col-xs-5 col-md-7">
											<textarea class="form-control" id="projectSituationEdit" type="text" ></textarea>
										</div>
										<div class="input-group col-xs-1 col-md-1" style="margin-top: 6px;">
											<font color="red">*</font>
										</div>
									</div>
								</div>
								<div class="form-group program-b">
									<div class=" program-b-b">
									</div>
									<div class="col-xs-10 col-md-10"  style="margin-left: 1%;">
										<label class="col-xs-5 col-md-4 control-label" style="text-align: right; letter-spacing:2.5px;  " >登记人：</label>
										<div class="input-group col-xs-5 col-md-7">
											<input class="form-control" id="regUserNameEdit"/>
										</div>
									</div>
								</div>
								<div class="form-group program-b">
									<div class=" program-b-b">
									</div>
									<div class="col-xs-10 col-md-10"  style="margin-left: 1%;">
										<label class="col-xs-5 col-md-4 control-label" style="text-align: right; letter-spacing:2.5px;  " >登记时间：</label>
										<div class="input-group col-xs-5 col-md-7">
											<input class="form-control" id="regDateEdit" type="text" readonly="readonly" />
										</div>
									</div>
								</div>
								
							</form>
							<div class="col-md-11 col-xs-11" align="right" style="margin-top: 10px;margin-right: 10px;margin-bottom: 5px" id="buttonDiv">
								<button class="btn btn-primary btn-sm" id="btnSave">保存</button>
								<button class="btn btn-primary btn-sm" id="btnCommit">提交</button>
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
    	$(document).ready(function(){
    		$("#regUserNameEdit").val("${usersession.realName}");
    		$("#regDateEdit").val(FormatDate(new Date));
    	});
    	function FormatDate(strDate){
    		var date = new Date(strDate);
    		return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
    	}
    	
	</script>
  </body>
</html>
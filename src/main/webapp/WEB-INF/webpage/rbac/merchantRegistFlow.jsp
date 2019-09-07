<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<base href=" <%=basePath%>">
<title>商户注册</title>
<!--	引入外部样式库css	-->
<jsp:include page="../include/mainHead.jsp"></jsp:include>
<!--        定义适应屏幕的css样式 -->
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="stylesheet" type="text/css"
	href="plug-in\ace\main\esale\new_css\esale-new-style.css" />
</head>
<body style="background-color: #FFFFFF; overflow-x: hidden;">
	<div class="row" align="left">
		<div class="col-sm-12 col-xs-12 col-lg-12 widget-body" align="left">
			<!-- 商户注册页面-->
			<div style="margin-top: 20px;" id="registDialog">
				<div class="page-header">
					<div class="table-header">商户注册</div>
				</div>
				<div class="container" align="left">
					<form class="form-horizontal">
						<div class="form-group" align="left" style="display: none"
							id="merchantCodeDiv">
							<div class="col-xs-12 col-md-4">
								<label for="" class="col-xs-5 col-md-5 control-label"
									style="text-align: right; height: 25px; color: red; letter-spacing: 2px;">商户编号:</label>
								<div class="col-xs-6 col-md-6" align="left">
									<input type="text" id="merchantCode" class="form-control"
										readonly="readonly" />
								</div>
							</div>
							<div class="col-xs-12 col-md-4">
								<label for="" class="col-xs-5 col-md-5 control-label"
									style="text-align: right; height: 25px; color: red">账户名称:</label>
								<div class="col-xs-6 col-md-6" align="left">
									<input type="text" id="accountId" class="form-control"
										placeholder="保存时自动生成" readonly="readonly" />
								</div>
							</div>
							<div class="col-xs-12 col-md-4">
								<label for="" class="col-xs-5 col-md-5 control-label"
									style="text-align: right; height: 25px; color: red">账户密码:</label>
								<div class="col-xs-6 col-md-6" align="left">
									<input type="text" id="password" class="form-control"
										placeholder="保存时自动生成" readonly="readonly" />
								</div>
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-xs-12 col-md-4" id="organNameDiv">
								<label for="" class="col-xs-5 col-md-5 control-label"
									style="text-align: right; height: 25px; letter-spacing: 2px;">售电公司:</label>
								<div class="col-xs-6 col-md-6" align="left">
									<input type="text" id="organName" class="form-control"
										placeholder="售电公司名称" readonly="readonly" value="${organName}" />
									<input type="text" id="organId" class="form-control"
										placeholder="售电公司id" readonly="readonly" style="display: none"
										value="${organId}" />
								</div>
								<div class="col-xs-1 col-md-1"
									style="margin-top: 2%; margin-left: -1%;">
									<font color=red>*</font>
								</div>
							</div>
							<div class="col-xs-12 col-md-4 xsmt15">
								<label for="" class="col-xs-5 col-md-5 control-label"
									style="text-align: right; height: 25px;">商户类别:</label>
								<div class="col-xs-6 col-md-6" align="left">
									<select id="merchantType" class="form-control"
										style="height: 35px;"></select>
								</div>
								<div class="col-xs-1 col-md-1"
									style="margin-top: 2%; margin-left: -1%;">
									<font color=red>*</font>
								</div>
							</div>
							<div class="col-xs-12 col-md-4 xsmt15">
								<label for="marketPlace" class="col-xs-5 col-md-5 control-label"
									style="text-align: right; height: 25px;">交易市场:</label>
								<div class="col-xs-6 col-md-6" align="left">
									<select id="marketPlace" class="form-control"
										style="height: 35px;">
										<option value='0'>请选择</option>
									</select>
								</div>
								<div class="col-xs-1 col-md-1"
									style="margin-top: 2%; margin-left: -1%;">
									<font color=red>*</font>
								</div>
							</div>
							<div class="col-xs-12 col-md-4 xsmt15 hide">
								<label for="" class="col-xs-5 col-md-5 control-label"
									style="text-align: right; height: 25px;">商户Id:</label>
								<div class="col-xs-6 col-md-6" align="left">
									<input type="text" id="merchantId" class="form-control"
										placeholder="保存时自动生成" readonly="readonly" />
								</div>
							</div>
							<div class="col-xs-12 col-md-4 xsmt15 hide">
								<label for="" class="col-xs-5 col-md-5 control-label"
									style="text-align: right; height: 25px; letter-spacing: 3.2px;">园区Id:</label>
								<div class="col-xs-6 col-md-6" align="left">
									<input type="text" id="energyParkId" class="form-control"
										placeholder="保存时自动生成" readonly="readonly" />
								</div>
							</div>

						</div>
						<div class="form-group" align="left">
							<div class="col-xs-12 col-md-4">
								<label for="" class="col-xs-5 col-md-5 control-label"
									style="text-align: right; height: 25px; letter-spacing: 2px;">商户名称:</label>
								<div class="col-xs-6 col-md-6" align="left">
									<input type="text" id="merchantName" class="form-control" />
								</div>
								<div class="col-xs-1 col-md-1"
									style="margin-top: 2%; margin-left: -1%;">
									<font color=red>*</font>
								</div>
							</div>
							<div class="col-xs-12 col-md-4 xsmt15">
								<label for="" class="col-xs-5 col-md-5 control-label"
									style="text-align: right; height: 25px;">行业类别:</label>
								<div class="col-xs-6 col-md-6" align="left">
									<select id="industryCategory" class="form-control"
										style="height: 35px;">
									</select>
								</div>
							</div>
							<div class="col-xs-12 col-md-4 xsmt15">
								<label for="" class="col-xs-5 col-md-5 control-label"
									style="text-align: right; height: 25px;">商户规模:</label>
								<div class="col-xs-6 col-md-6" align="left">
									<select id="merchantScale" class="form-control"
										style="height: 35px;"></select>
								</div>
							</div>
							<div class="col-xs-12 col-md-4 xsmt15 hide">
								<label for="" class="col-xs-5 col-md-5 control-label"
									style="text-align: right; height: 25px;">用电性质:</label>
								<div class="col-xs-6 col-md-6" align="left">
									<select id="energyProperty" class="form-control"
										style="height: 35px;"></select>
								</div>
								<div class="col-xs-1 col-md-1"
									style="margin-top: 2%; margin-left: -1%;">
									<font color=red>*</font>
								</div>
							</div>

						</div>
						<div class="form-group" align="left">
							<div class="col-xs-12 col-md-4">
								<label for="" class="col-xs-5 col-md-5 control-label"
									style="text-align: right; height: 25px; letter-spacing: 2px;">企业法人:</label>
								<div class="col-xs-6 col-md-6" align="left">
									<input type="text" id="legalPerson" class="form-control" />
								</div>
							</div>
							<div class="col-xs-12 col-md-4 xsmt15">
								<label for="" class="col-xs-5 col-md-5 control-label"
									style="text-align: right; height: 25px;">注册资本:</label>
								<div class="col-xs-6 col-md-6" align="left">
									<input type="text" id="regCapital" class="form-control"
										placeholder="万元" />
								</div>
							</div>
							<div class="col-xs-12 col-md-4 xsmt15">
								<label for="" class="col-xs-5 col-md-5 control-label"
									style="text-align: right; height: 25px;">信用等级:</label>
								<div class="col-xs-6 col-md-6" align="left">
									<select id="credit" class="form-control" style="height: 35px;"></select>
								</div>
							</div>
						</div>
						<div class="form-group hide" align="left">

							<div class="col-xs-12 col-md-4">
								<label for="" class="col-xs-5 col-md-5 control-label"
									style="text-align: right; height: 25px; letter-spacing: 6px;">传&nbsp;&nbsp;真:</label>
								<div class="col-xs-6 col-md-6" align="left">
									<input type="text" id="fax" class="form-control" />
								</div>
							</div>
							<div class="col-xs-12 col-md-4 xsmt15">
								<label for="" class="col-xs-5 col-md-5 control-label"
									style="text-align: right; height: 25px;">邮政编码:</label>
								<div class="col-xs-6 col-md-6" align="left">
									<input type="text" id="postcode" class="form-control" />
								</div>
							</div>
							
						</div>
						<div class="form-group" align="left">
							<div class="col-xs-12 col-md-4">
								<label for="" class="col-xs-5 col-md-5 control-label"
									style="text-align: right; height: 25px; letter-spacing: 2px;">开户银行:</label>
								<div class="col-xs-6 col-md-6" align="left">
									<input type="text" id="depositBank" class="form-control" />
								</div>
								<!--  <div class="col-xs-1 col-md-1" style="margin-top: 2%;  margin-left: -1%;">
								<font color=red>*</font>
						  	 </div> -->
							</div>
							<div class="col-xs-12 col-md-4 xsmt15">
								<label for="" class="col-xs-5 col-md-5 control-label"
									style="text-align: right; height: 25px;">银行账户:</label>
								<div class="col-xs-6 col-md-6" align="left">
									<input type="text" id="bankAccount" class="form-control"
										placeholder="16、18-21位" />
								</div>
								<!-- <div class="col-xs-1 col-md-1" style="margin-top: 2%;  margin-left: -1%;">
								<font color=red>*</font>
						  	 </div> -->
							</div>
							<div class="col-xs-12 col-md-4 xsmt15">
								<label for="" class="col-xs-5 col-md-5 control-label"
									style="text-align: right; height: 25px;">开户名称:</label>
								<div class="col-xs-6 col-md-6" align="left">
									<input type="text" id="accountName" class="form-control" />
								</div>
								<!--  <div class="col-xs-1 col-md-1" style="margin-top: 2%;  margin-left: -1%;">
								<font color=red>*</font>
						  	 </div> -->
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-xs-12 col-md-4">
								<label for="" class="col-xs-5 col-md-5 control-label"
									style="text-align: right; height: 25px;">三证合一号:</label>
								<div class="col-xs-6 col-md-6" align="left">
									<input type="text" id="regNumber" class="form-control" />
								</div>
							</div>
							<div class="col-xs-12 col-md-4 xsmt15">
								<label for="" class="col-xs-5 col-md-5 control-label"
									style="text-align: right; height: 25px;">公司邮箱:</label>
								<div class="col-xs-6 col-md-6" align="left">
									<input type="text" id="email" class="form-control" />
								</div>
							</div>
							<div class="col-xs-12 col-md-4 xsmt15">
								<label for="" class="col-xs-5 col-md-5 control-label"
									style="text-align: right; height: 25px;">企业公众号:</label>
								<div class="col-xs-6 col-md-6" align="left">
									<input type="text" id="publicNumber" class="form-control" />
								</div>
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-xs-12 col-md-4">
								<label for="" class="col-xs-5 col-md-5 control-label"
									style="text-align: right; height: 25px;">地址:（省）</label>
								<div class="col-xs-6 col-md-6" align="left">
									<select id="province" class="form-control"
										style="height: 35px;"></select>
								</div>
								<div class="col-xs-1 col-md-1"
									style="margin-top: 2%; margin-left: -1%;">
									<font color=red>*</font>
								</div>
							</div>
							<div class="col-xs-12 col-md-4 xsmt15">
								<label for="" class="col-xs-5 col-md-5 control-label"
									style="text-align: right; height: 25px;">（市区）:</label>
								<div class="col-xs-6 col-md-6" align="left">
									<select id="city" class="form-control" style="height: 35px;"></select>
								</div>
								<div class="col-xs-1 col-md-1"
									style="margin-top: 2%; margin-left: -1%;">
									<font color=red>*</font>
								</div>
							</div>
							<div class="col-xs-12 col-md-4 xsmt15">
								<label for="" class="col-xs-5 col-md-5 control-label"
									style="text-align: right; height: 25px;">（区县）:</label>
								<div class="col-xs-6 col-md-6" align="left">
									<select id="county" class="form-control" style="height: 35px;"></select>
								</div>
								<div class="col-xs-1 col-md-1"
									style="margin-top: 2%; margin-left: -1%;">
									<font color=red>*</font>
								</div>
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-xs-12 col-md-4">
								<label class="col-xs-5 col-md-5 control-label"
									style="text-align: right; height: 25px; letter-spacing: 2px;">详细地址:</label>
								<div class="col-xs-6 col-md-6" align="left">
									<input type="text" id="address" class="form-control escel-xxdz" />
								</div>
							</div>
							</div>
						<div class="form-group" align="left">
							<div class="col-xs-12 col-md-4">
								<label for="" class="col-xs-5 col-md-5 control-label"
									style="text-align: right; height: 25px; letter-spacing: 6px;">登记人:</label>
								<div class="col-xs-6 col-md-6" align="left">
									<input type="text" id="regName" class="form-control"
										readonly="readonly" />
								</div>
							</div>
							<div class="col-xs-12 col-md-4 xsmt15 hide">
								<label for="" class="col-xs-5 col-md-5 control-label"
									style="text-align: right; height: 25px;">交易资格:</label>
								<div class="col-xs-6 col-md-6" align="left">
									<input id="tradeFlag" class="form-control"
										style="width: 125px;" readonly="readonly" />
								</div>
							</div>

							<div class="col-xs-12 col-md-4 xsmt15">
								<label for="" class="col-xs-5 col-md-5 control-label"
									style="text-align: right; height: 25px;">登记日期:</label>
								<div class="col-xs-6 col-md-6" align="left">
									<input type="text" id="regTime" class="form-control"
										readonly="readonly" />
								</div>
							</div>
						</div>
					</form>
					<div class="row">
						<div class="col-md-12"
							style="margin-left: 85%; height: 30px; margin-bottom: 10px; margin-top: 5px;">
							<!--<button class="btn btn-primary btn-sm"  id="btnCancle">取&nbsp;消</button>  -->
							<button class="btn btn-primary btn-sm" id="btnFirstNext">下一步</button>
						</div>
					</div>
				</div>
			</div>
			<!-- 商户用电信息配置-->
			<div style="margin-top: 20px; display: none;" id="consumeDialog">
				<div class="container" align="left">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<div class="col-xs-12 col-md-6">
								<label class="col-sm-5  col-xs-5 col-md-5 control-label"
									style="text-align: right">商户名称：</label>
								<div class="col-sm-6 col-xs-6 col-md-6">
									<input class="form-control" id="merchantNameConsume"
										type="text" readonly="readonly" />
								</div>
							</div>
							<div class="col-xs-12 col-md-6">
								<label class="col-sm-5  col-xs-5 col-md-5 control-label">电价方式：</label>
								<div class="col-sm-6 col-xs-6 col-md-6">
									<select class="form-control" id="priceModeConsume">
									</select>
								</div>
								<div class="col-xs-1 col-md-1"
									style="margin-top: 2%; margin-left: -1%;">
									<font color=red>*</font>
								</div>

							</div>
						</div>
						<div class="form-group">
							<div class="col-xs-12 col-md-6">
								<label class="col-sm-5  col-xs-5 col-md-5 control-label"
									style="text-align: right">电压等级：</label>
								<div class="col-sm-6 col-xs-6 col-md-6">
									<select class="form-control" id="voltageClassConsume"></select>
								</div>
								<div class="col-xs-1 col-md-1"
									style="margin-top: 2%; margin-left: -1%;">
									<font color=red>*</font>
								</div>
							</div>

							<div class="col-xs-12 col-md-6">
								<label class="col-sm-5  col-xs-5 col-md-5 control-label"
									style="text-align: right">用电性质：</label>
								<div class="col-sm-6 col-xs-6 col-md-6">
									<select class="form-control" id="energyPropertyConsume"></select>
								</div>
								<div class="col-xs-1 col-md-1"
									style="margin-top: 2%; margin-left: -1%;">
									<font color=red>*</font>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="col-xs-12 col-md-6">
								<label class="col-sm-5  col-xs-5 col-md-5 control-label"
									style="text-align: right;">容量(kVA)：</label>
								<div class="col-sm-6 col-xs-6 col-md-6">
									<input class="form-control" id="volumeConsume" type="text" />
								</div>
							</div>
							<div class="col-xs-12 col-md-6">
								<label class="col-sm-5  col-xs-5 col-md-5 control-label"
									style="text-align: right">容量电价：</label>
								<div class="col-sm-6 col-xs-6 col-md-6">
									<input class="form-control" id="capacityPriceConsume"
										type="text" />
								</div>
							</div>

						</div>
						<div class="form-group">
							<div class="col-xs-12 col-md-6">
								<label class="col-sm-5  col-xs-5 col-md-5 control-label"
									style="text-align: right">目录电价：</label>
								<div class="col-sm-6 col-xs-6 col-md-6">
									<input class="form-control" id="catalogPriceConsume"
										type="text" />
								</div>
								<div class="col-xs-1 col-md-1"
									style="margin-top: 2%; margin-left: -1%;">
									<font color=red>*</font>
								</div>
							</div>
							<div class="col-xs-12 col-md-6">
								<label class="col-sm-5  col-xs-5 col-md-5 control-label"
									style="text-align: right; letter-spacing: 3px;">谷电价：</label>
								<div class="col-sm-6 col-xs-6 col-md-6">
									<input class="form-control" id="valleyPriceConsume" type="text" />
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="col-xs-12 col-md-6">
								<label class="col-sm-5  col-xs-5 col-md-5 control-label"
									style="text-align: right; letter-spacing: 3px;">峰电价：</label>
								<div class="col-sm-6 col-xs-6 col-md-6">
									<input class="form-control" id="peakPriceConsume" type="text" />
								</div>
							</div>

							<div class="col-xs-12 col-md-6">
								<label class="col-sm-5  col-xs-5 col-md-5 control-label"
									style="text-align: right; letter-spacing: 3px;">平电价：</label>
								<div class="col-sm-6 col-xs-6 col-md-6">
									<input class="form-control" id="flatPriceConsume" type="text" />
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="col-xs-12 col-md-6">
								<label class="col-sm-11  col-xs-11 col-md-11 control-label"
									style="text-align: right; margin-left: -22%; letter-spacing: 3px; color: red; font-size: 6px;">电价单位：元/兆瓦时</label>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		<!-- 联系人管理页面-->
		<div class="row" id="fromEdit" style="display: none; margin-right: 0;">
			<div class="page-header">
				<div class="table-header" style="margin-left: 2%;">联系人管理</div>
			</div>
			<div class="col-sm-12 col-xs-12 col-lg-12 widget-body">
				<div class="row center center-block" style="margin-top: 20px;">
					<div class="container">
						<div class="row clearfix">
							<div class="col-md-12 col-xs-12 column">
								<form class="form-horizontal" role="form">
									<div class="form-group">
										<label class="col-xs-4 col-md-2 control-label"
											style="text-align: right" for="postNameQuery">联系人姓名：</label>
										<div class="col-xs-5 col-md-3">
											<input class="form-control" id="linkManNameQuery" />
										</div>
										<label class="col-xs-4 col-md-2 control-label xsmt15"
											id="POSITIONDEPRESS" style="text-align: right" for="realname">联系电话：</label>
										<div class="col-xs-5 col-md-3">
											<input type="text" id="phoneQuery"
												class="form-control xsmt15" />
										</div>
										<div class="col-md-2 col-xs-2"
											style="position: absolute; right: 30px; top: 0px">
											<button class="btn btn-sm btn-primary" type="button"
												id="searchLinkMan">
												<i class="icon-ok"></i>查询
											</button>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				<!-- 查询条件结束 -->
				<!-- 岗位信息datables开始 -->
				<div class="table-header" style="margin-left: 1%;">联系人信息</div>
				<div class="row">
					<div class="col-md-12"
						style="margin-left: 18px; height: 30px; margin-bottom: 10px; margin-top: 5px;">
						<button class="btn btn-primary btn-sm" id="btnAddLinkMan">添加</button>
						<button class="btn btn-primary btn-sm" id="btnEditLinkMan">编辑</button>
						<button class="btn btn-primary btn-sm" id="btnDeleteLinkMan">删除</button>
					</div>
					<div class="col-md-7"></div>
				</div>
				<div class="row">
					<div class="table-responsive" style="margin-left: 2%;">
						<table id="linkManTable"
							class="table table-striped table-bordered table-hover"
							style="margin-bottom: 20px;">
							<thead>
								<tr>
									<th><label> <input type="checkbox" class="ace"
											id="allCheck" /> <span class="lbl"></span>
									</label></th>
									<th>联系人姓名</th>
									<th>联系电话</th>
									<th>手机号码</th>
									<th>传真</th>
									<th>邮件</th>
									<th>职务</th>
									<th>地址</th>
									<th>微信号</th>
									<th>备注</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="row" id="noProductEdit" style="display: none">
				<div class="col-md-12"
					style="margin-left: 85%; height: 30px; margin-bottom: 10px; margin-top: 5px;">

					<button class="btn btn-primary btn-sm" id="btnSecondLast">上一步</button>
					<button class="btn btn-primary btn-sm" id="btnSecondNext">下一步</button>

				</div>
			</div>
			<div class="row" id="productEdit" style="display: none">
				<div class="col-md-12"
					style="margin-left: 85%; height: 30px; margin-bottom: 10px; margin-top: 5px;">
					<button class="btn btn-primary btn-sm" id="btnSecondLastSale">上一步</button>
					<button class="btn btn-primary btn-sm" id="btnPowerFinish">完成</button>
				</div>
			</div>
		</div>
		<!-- 园区信息配置-->
		<div class="row" id="energyInfoEdit" style="display: none">
			<div class="page-header">
				<div class="table-header" style="margin-left: 2%;">商户园区信息配置</div>
			</div>
			<div class="col-sm-12 col-xs-12 col-lg-12 widget-body">
				<div class="row center center-block" style="margin-top: 20px;">
					<div class="container">
						<div class="row clearfix">
							<div class="col-md-12 col-xs-12 column">
								<form class="form-horizontal">
									<div class="form-group">
										<label class="col-xs-4 col-md-2 control-label"
											style="text-align: right">园区名称：</label>
										<div class="col-xs-5 col-md-3">
											<input type="text" id="parkNameQuery" class="form-control" />
										</div>
										<label class="col-xs-4 col-md-2 control-label"
											id="POSITIONDEPRESS" style="text-align: right">园区类型：</label>
										<div class="col-xs-5 col-md-3 xsmt15">
											<select class="form-control" id="parkTypeQuery"
												style="height: 35px;"></select>
										</div>
										<div class="col-md-2 col-xs-2"
											style="position: absolute; right: 30px; top: 0px">
											<button class="btn btn-sm btn-primary" type="button"
												id="searchEnergy">
												<i class="icon-ok"></i>查询
											</button>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				<!-- 查询条件结束 -->
				<!-- 岗位信息datables开始 -->
				<div class="table-header" style="margin-left: 1%;">商户园区信息</div>
				<div class="row">
					<div class="col-md-12"
						style="margin-left: 1%; height: 30px; margin-bottom: 10px; margin-top: 5px;">
						<button class="btn btn-primary btn-sm" id="btnAddEnergyPark">添加</button>
						<button class="btn btn-primary btn-sm" id="btnEditEnergyPark">编辑</button>
						<button class="btn btn-primary btn-sm" id="btnDeleteEnergyPark">删除</button>
						<button class="btn btn-primary btn-sm" id="btnEnergyConsume">用电信息配置</button>
					</div>
					<div class="col-md-7"></div>
				</div>
				<div class="table-responsive" style="margin-left: 1%;">
					<table id="energyInfoTable"
						class="table table-striped table-bordered table-hover"
						style="margin-bottom: 20px;">
						<thead>
							<tr>
								<th><label> <input type="checkbox" class="ace"
										id="allCheckEnergy" /> <span class="lbl"></span>
								</label></th>
								<th>园区名称</th>
								<th>园区类型</th>
								<th>园区地址</th>
								<th>对应电网企业</th>
								<th>园区经度</th>
								<th>园区维度</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12"
					style="margin-left: 85%; height: 30px; margin-bottom: 10px; margin-top: 5px;">
					<button class="btn btn-primary btn-sm" id="btnThirdLast">上一步</button>
					<button class="btn btn-primary btn-sm" id="btnFinish">完成</button>
				</div>
			</div>
		</div>
		<!-- 用电信息配置管理页面-->
		<div class="row hide" id="powerInfoEdit">
			<div class="col-sm-11 col-xs-11 col-lg-11 widget-body">

				<!-- 查询条件结束 -->
				<!-- 岗位信息datables开始 -->
				<div class="table-header" style="margin-left: 1%;">用电信息</div>
				<div class="row">
					<div class="col-md-12"
						style="margin-left: 1%; height: 30px; margin-bottom: 10px; margin-top: 5px;">
						<button class="btn btn-primary btn-sm" id="btnAddConsume">添加</button>
						<button class="btn btn-primary btn-sm" id="btnEditConsume">编辑</button>
						<!-- <button class="btn btn-primary btn-sm" id="btnDeleteConsume">删除</button> -->
					</div>
					<div class="col-md-7"></div>
				</div>
				<div class="row">
					<div class="table-responsive" style="margin-left: 1%;">
						<table id="consumeTable"
							class="table table-striped table-bordered table-hover"
							style="margin-bottom: 20px;">
							<thead>
								<tr>
									<th><label> <span class="lbl"></span>
									</label></th>
									<th style="text-align: center">供电地点</th>
									<th style="text-align: center">电压等级</th>
									<th style="text-align: center">用电性质</th>
									<th style="text-align: center">容量（kVA）</th>
									<th style="text-align: center">电价方式</th>
									<th style="text-align: center">容量电价(元)</th>
									<th style="text-align: center">目录电价(元)</th>
									<th style="text-align: center">峰电价(元)</th>
									<th style="text-align: center">平电价(元)</th>
									<th style="text-align: center">谷电价(元)</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<!-- 商户园区信息增加编辑弹出框 -->
		<div class="hide " style="margin-top: 20px;" id="energyParkDialog">
			<div class="container" align="left">
				<form class="form-horizontal" role="form">
					<div class="form-group">
						<div class="col-xs-12 col-md-12">
							<label for="projectNameForm"
								class="col-sm-4  col-xs-4 col-md-4 control-label"
								style="text-align: right; letter-spacing: 5px;">商户名称：</label>
							<div class="col-sm-5 col-xs-5 col-md-5">
								<input class="form-control" id="merchantNameEnergyParkDialog"
									type="text" readonly="readonly" />
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-12 col-md-12">
							<label for="linkMan"
								class="col-sm-4  col-xs-4 col-md-4 control-label"
								style="text-align: right; letter-spacing: 5px;">园区类型：</label>
							<div class="col-sm-5 col-xs-5 col-md-5">
								<select class="form-control" style="width: 100%; height: 35px;"
									id="parkType">
								</select>
							</div>
							<div class="col-xs-12 col-md-1"
								style="margin-top: 2%; margin-left: -5%;">
								<font color=red>*</font>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-12 col-md-12">
							<label for="linkPhone"
								class="col-sm-4  col-xs-4 col-md-4 control-label"
								style="text-align: right; letter-spacing: 5px;">园区名称：</label>
							<div class="col-sm-5 col-xs-5 col-md-5">
								<input class="form-control" id="parkName" type="text" />
							</div>
							<div class="col-xs-12 col-md-1"
								style="margin-top: 2%; margin-left: -5%;">
								<font color=red>*</font>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-12 col-md-12">
							<label for="projectPlace"
								class="col-sm-4  col-xs-4 col-md-4 control-label"
								style="text-align: right; letter-spacing: 5px;">园区地址：</label>
							<div class="col-sm-5 col-xs-5 col-md-5">
								<textarea class="form-control" id="parkAddress"
									style="height: 60px;"></textarea>
							</div>
							<div class="col-xs-12 col-md-1"
								style="margin-top: 3%; margin-left: -5%;">
								<font color=red>*</font>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-12 col-md-12">
							<label for="projectPlace" class="col-xs-4 col-md-4 control-label"
								style="text-align: right; letter-spacing: 5px;">坐标信息:</label>
							<div class="col-xs-5 col-md-5" align="left">
								<input type="text" id="latitude" class="form-control"
									style="width: 100%;" />
							</div>
							<div class="col-xs-12 col-md-1"
								style="margin-top: 3%; margin-left: -5%;">
								<font color=red>*</font>
							</div>
							<div class="col-xs-2 col-md-2">
								<input type="button" class="form-control"
									style="width: 100%; color: #797bc5; margin-left: -5%;"
									onclick='openWin()' value="获取" />
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-12 col-md-12">
							<label for="contractorUnit"
								class="col-sm-4  col-xs-4 col-md-4 control-label"
								style="text-align: right">对应电网企业：</label>
							<div class="col-sm-5 col-xs-5 col-md-5">
								<input class="form-control" id="powerCompany" type="text" />
							</div>
							<div class="col-xs-12 col-md-1"
								style="margin-top: 2%; margin-left: -5%;">
								<font color=red>*</font>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
		<!-- 联系人添加编辑弹出框-->
		<div class="hide" align="left" id="linkManDialog">
			<form class="form-horizontal" role="form">
				<div class="form-group">
					<div class="col-xs-12 col-md-12">
						<label for="projectNameForm"
							class="col-sm-5  col-xs-5 col-md-5 control-label"
							style="text-align: right">联系人姓名：</label>
						<div class="col-sm-6 col-xs-6 col-md-6">
							<input class="form-control" id="linkmanName" type="text" />
						</div>
						<div class="col-xs-12 col-md-1"
							style="margin-top: 2%; margin-left: -5%;">
							<font color=red>*</font>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-12 col-md-12">
						<label for="linkMan"
							class="col-sm-5  col-xs-5 col-md-5 control-label"
							style="text-align: right; letter-spacing: 3.1px;">手机号码：</label>
						<div class="col-sm-6 col-xs-6 col-md-6">
							<input class="form-control" id="mobilePhone" type="text" />
						</div>
						<div class="col-xs-12 col-md-1"
							style="margin-top: 2%; margin-left: -5%;">
							<font color=red>*</font>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-12 col-md-12">
						<label for="linkPhone"
							class="col-sm-5  col-xs-5 col-md-5 control-label"
							style="text-align: right; letter-spacing: 5px;">邮&nbsp;&nbsp;&nbsp;箱：</label>
						<div class="col-sm-6 col-xs-6 col-md-6">
							<input class="form-control" id="emails" type="text" />
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-12 col-md-12">
						<label for="projectPlace"
							class="col-sm-5  col-xs-5 col-md-5 control-label"
							style="text-align: right; letter-spacing: 5px;">地&nbsp;&nbsp;&nbsp;址：</label>
						<div class="col-sm-6 col-xs-6 col-md-6">
							<input class="form-control" id="addresss" type="text" />
						</div>
						<div class="col-xs-12 col-md-1"
							style="margin-top: 2%; margin-left: -5%;">
							<font color=red>*</font>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-12 col-md-12">
						<label for="contractorUnit"
							class="col-sm-5  col-xs-5 col-md-5 control-label"
							style="text-align: right; letter-spacing: 3.1px;">联系电话：</label>
						<div class="col-sm-6 col-xs-6 col-md-6">
							<input class="form-control" id="phones" type="text" />
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-12 col-md-12">
						<label for="register"
							class="col-sm-5  col-xs-5 col-md-5 control-label"
							style="text-align: right; letter-spacing: 5px;">传&nbsp;&nbsp;&nbsp;真：</label>
						<div class="col-sm-6 col-xs-6 col-md-6">
							<input class="form-control" id="faxs" type="text" />
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-12 col-md-12">
						<label for="registerName"
							class="col-sm-5  col-xs-5 col-md-5 control-label"
							style="text-align: right; letter-spacing: 5px;">职&nbsp;&nbsp;&nbsp;务：</label>
						<div class="col-sm-6 col-xs-6 col-md-6">
							<input class="form-control" id="post" type="text" />
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-12 col-md-12">
						<label for="registDate"
							class="col-sm-5  col-xs-5 col-md-5 control-label"
							style="text-align: right; letter-spacing: 7px;">微信号：</label>
						<div class="col-sm-6 col-xs-6 col-md-6">
							<input class="form-control" id="wechatNum" type="text" />
						</div>
						<div class="col-xs-12 col-md-1"
							style="margin-top: 2%; margin-left: -5%;">
							<font color=red>*</font>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-12 col-md-12">
						<label for="registerName"
							class="col-sm-5  col-xs-5 col-md-5 control-label"
							style="text-align: right; letter-spacing: 5px;">备&nbsp;&nbsp;&nbsp;注：</label>
						<div class="col-sm-6 col-xs-6 col-md-6">
							<textarea class="form-control" id="memo"
								style="width: 138px; height: 60px;"></textarea>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<!-- 以下为js放置位置 -->
	<jsp:include page="../include/mainFooter.jsp"></jsp:include>

	<script type="text/javascript">
     //加载datables表数据js
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
   		//格式化加载的 时间格式
		function FormatDate (strTime) {
		    var date = new Date(strTime);
		    return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
		}
      var thisid=null;
      var par={};
      var energyParkParam={};//园区信息的变量
      var energyConsumeParam={};//用户用电信息的变量
      var  energyConsumeParamTable={};
      var resultid;
      var merchant={};
      $(document).ready(function(){
       	$("#regName").val("${usersession.realName}");
        $("#regTime").val(FormatDate(new Date()));
        getProvince();//加载省
      	findSelectData();
      	findMerchantData();//加载商户规模和用电性质
      	$("#tradeFlag").val("无效状态");//默认为取消状态
	    $("#tradeFlag").attr("disabled","disabled");
       });
    $.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
        _title: function(title) {
            var $title = this.options.title || '&nbsp;'
            if( ("title_html" in this.options) && this.options.title_html == true )
                title.html($title);
            else title.text($title);
        }
    }));
    	$("#allCheck").on('click' , function(){
				var that = this;
				$(this).closest('table').find('tr > td:first-child input:checkbox')
				.each(function(){
					this.checked = that.checked;
					$(this).closest('tr').toggleClass('selected');
			});
		});
		$("#allCheckEnergy").on('click' , function(){
				var that = this;
				$(this).closest('table').find('tr > td:first-child input:checkbox')
				.each(function(){
					this.checked = that.checked;
					$(this).closest('tr').toggleClass('selected');
			});
		});
    //商户注册点击下一步
     $( "#btnFirstNext" ).on('click', function(e) {
        	thisid = this.id;  //获取当前点击按钮的id 
        	$("#merchantNameEnergyParkDialog").val($("#merchantName").val());
        	$("#merchantNameConsume").val($("#merchantName").val());
        	if($("#merchantId").val()==""||$("#merchantId").val()==null){//新增商户
        		merchant.flag="addF";
        	}
        	else{//更新商户
        		merchant.flag="updateF";
        		merchant.organid=$("#merchantId").val();
        	}
        	addMerchantFunction();
     });
     //联系人管理点击添加联系人
     $( "#btnAddLinkMan" ).on('click', function(e) {
        	thisid = this.id;  //获取当前点击按钮的id 
        	$("#linkmanName").val("");$("#mobilePhone").val("");$("#emails").val("");$("#addresss").val("");
        	$("#phones").val("");$("#faxs").val("");$("#post").val("");$("#wechatNum").val("");
        	$("#memo").val("");
        	linkManDialog();
     });
     //联系人管理点击编辑
     $( "#btnEditLinkMan" ).on('click', function(e) {
        	thisid = this.id;  //获取当前点击按钮的id 
        	if($("#link_Man_Id:checked").length>1){
        		parent.bootbox.alert("只能选择一个联系人进行编辑。");
        		return;
        	}
        	if($("#link_Man_Id:checked").length<1){
        		parent.bootbox.alert("请选择一个联系人进行编辑。");
        		return;
        	}
        	linkManParam.link_Man_Id=$("#link_Man_Id:checked").val();
        	getLinkManInfo(linkManParam);
     });
     //删除联系人
     $( "#btnDeleteLinkMan" ).on('click', function(e) {
        	thisid = this.id;  //获取当前点击按钮的id 
        	if($("#link_Man_Id:checked").length<1){
        		parent.bootbox.alert("请选择要删除的联系人。");
        		return;
        	}
        	deleteLinkMan(linkManParam);
     });
     //查询联系人
     $("#searchLinkMan").on('click',function(){
     	linkManParam.organid=$("#merchantId").val();
     	loadLinkManTable();
     });
     //联系人注册点击下一步
     $( "#btnSecondNext" ).on('click', function(e) {
        	thisid = this.id;  //获取当前点击按钮的id 
        	//获取该商户下是否已经有联系人，有则下一步，无则提示添加联系人
        	linkManParam.organid=$("#merchantId").val();
        	getLinkManList();
     });
     //发电商户点击完成
      $( "#btnPowerFinish" ).on('click', function(e) {
        	thisid = this.id;  //获取当前点击按钮的id 
        	//获取该商户下是否已经有联系人，有则下一步，无则提示添加联系人
        	linkManParam.organid=$("#merchantId").val();
        	getLinkManListFinish();
     });
     //商户园区信息点击添加
     $( "#btnAddEnergyPark" ).on('click', function(e) {
        	thisid = this.id;  //获取当前点击按钮的id 
        	$("#parkType").val("");
        	$("#parkName").val("");
        	$("#parkAddress").val("");
        	$("#powerCompany").val("");
        	$("#latitude").val("");
        	energyParkDialog();
     });
     //编辑商户园区信息
     $( "#btnEditEnergyPark" ).on('click', function(e) {
        	thisid = this.id;  //获取当前点击按钮的id 
        	if($("#park_Id:checked").length>1){
        		parent.bootbox.alert("只能选择一个园区信息进行编辑。");
        		return;
        	}
        	if($("#park_Id:checked").length<1){
        		parent.bootbox.alert("请选择一个园区信息进行编辑。");
        		return;
        	}
        	energyParkParam.park_Id=$("#park_Id:checked").val();
        	getEnergyParkInfo(energyParkParam);
     });
      //删除园区信息
     $( "#btnDeleteEnergyPark" ).on('click', function(e) {
        	thisid = this.id;  //获取当前点击按钮的id 
        	if($("#park_Id:checked").length<1){
        		parent.bootbox.alert("请选择要删除的园区信息。");
        		return;
        	}
        	deleteEnergyPark(energyParkParam);
     });
     //用电信息配置
     $( "#btnEnergyConsume" ).on('click', function(e) {
        	thisid = this.id;  //获取当前点击按钮的id 
        	if($("#park_Id:checked").length<1){
        		parent.bootbox.alert("请选择要配置用电信息的园区。");
        		return;
        	}
        	if($("#park_Id:checked").length>1){
        		parent.bootbox.alert("只能选择一个园区信息进行用电配置。");
        		return;
        	}
        	energyConsumeDialog();
        	energyConsumeParamTable.park_Id=$("#park_Id:checked").val();
			energyConsumeParamTable.organId=$("#merchantId").val();
			loadEnergyConsumeTable();
     });
     
    //查询园区信息
    $( "#searchEnergy" ).on('click', function(e) {
        	energyParkParam.department_Id=$("#merchantId").val();
     		loadEnergyParkTable();
     }); 
      //商户用电信息点击添加
     $( "#btnAddConsume" ).on('click', function(e) {
     		energyConsumeParamTable.organId=$("#merchantId").val();
	        if(getEnergyConsumeList()!=0){//园区用电信息已经配置完毕
     			parent.bootbox.alert("该园区已经配置过用电信息，不允许重复配置。");
	       		return;
     		}
        	thisid = this.id;  //获取当前点击按钮的id 
        	$("#supplyLocationConsume").val(0);
        	$("#voltageClassConsume").val(0);
        	$("#energyPropertyConsume").val(0);
        	$("#volumeConsume").val("");
        	$("#priceModeConsume").val("");
        	$("#capacityPriceConsume").val("");
        	$("#catalogPriceConsume").val("");
        	$("#peakPriceConsume").val("");
        	$("#flatPriceConsume").val("");
        	$("#valleyPriceConsume").val("");
        	consumeDialog();
        	energyConsumeParam.department_Id=$("#merchantId").val();
        	getSupplyLocation();
        	getSupplyLocationAll();
     });
     //点击编辑用户用电信息
      $( "#btnEditConsume" ).on('click', function(e) {
        	thisid = this.id;  //获取当前点击按钮的id 
        	energyConsumeParam.department_Id=$("#merchantId").val();
        	getSupplyLocation();
        	getSupplyLocationAll();
        	energyConsumeParam.park_Id=$("#park_Id_Consume:checked").val();
        	getEnergyConsumeInfo();
     });
     //点击删除用户用电信息
      $( "#btnDeleteConsume" ).on('click', function(e) {
      	if($("#park_Id_Consume:checked").length<1){
      		parent.bootbox.alert("请选择要删除的用户用电信息。");
        		return;
      	}
        energyConsumeParam.park_Id=$("#park_Id_Consume").val();
        deleteConsume();
     });
      //联系人注册点击上一步
     $( "#btnSecondLast" ).on('click', function(e) {
        	thisid = this.id;  //获取当前点击按钮的id 
        	$("#merchantType").removeAttr("readonly");
        	$("#merchantType").removeAttr("disabled");
        	$("#registDialog").css("display","block");
        	$("#organId").attr("readonly","readonly");
        	$("#organId").attr("disabled","disabled");
        	$("#fromEdit").css("display","none");
     });
     //注册售电商户上一步
        $( "#btnSecondLastSale" ).on('click', function(e) {
        	thisid = this.id;  //获取当前点击按钮的id 
        	$("#merchantType").attr("readonly","readonly");
        	$("#merchantType").attr("disabled","disabled");
        	$("#registDialog").css("display","block");
        	$("#organId").attr("readonly","readonly");
        	$("#organId").attr("disabled","disabled");
        	$("#fromEdit").css("display","none");
     });
      //联系人注册点击上一步
     $( "#btnThirdLast" ).on('click', function(e) {
        	thisid = this.id;  //获取当前点击按钮的id 
        	//$("#registDialog").css("display","block");
        	$("#fromEdit").css("display","block");
        	$("#energyInfoEdit").css("display","none");
     });
     //配置用电信息点击上一步
     $( "#btnFourthLast" ).on('click', function(e) {
        	thisid = this.id;  //获取当前点击按钮的id 
        	$("#powerInfoEdit").css("display","none");
        	$("#energyInfoEdit").css("display","block");
     });
     //完成
      $( "#btnFinish" ).on('click', function(e) {
      		//获取该商户下是否已经有园区信息，有则下一步，无则提示添加园区信息
        	energyParkParam.department_Id=$("#merchantId").val();
        	if(getEnergyParkList()==0){
        		parent.bootbox.alert("抱歉，请先添加商户园区信息。");
        		return;
        	}
      		//获取该商户下所有园区是否用电配置完毕，有则下一步，无则提示添加园区信息
        	energyConsumeParam.department_Id=$("#merchantId").val();
        	getSupplyLocation();//没有配置过的园区
        	if(getSupplyLocation()!=0){
        		parent.bootbox.alert("抱歉，目前还有园区没有对用电信息进行配置，请继续配置用电信息。");
        		return;
        	}
        	else{
        		parent.bootbox.alert("恭喜您，商户信息已经完善。请牢记您的账户信息！！！账户名"+$("#accountId").val()+"登录密码"+$("#password").val());
        		//隐藏用电配置信息，显示商户注册的信息，为只读模式？？
        		$("#energyInfoEdit").css("display","none");
        		$("#registDialog").css("display","block");
        	}       	
     });
        	
         //加载省
         function getProvince(){	
        	  $.ajax({
	            type: "POST",
	            url: "rest/rbac/MerchantRegistFlowController/getProvince", 
	            cache: false,  //禁用缓存
	            dataType: "json",
	            success: function (result) {
	       	   $("#province").html(""); 
	       	   $("#province").append("<option value='0'>请选择</option>");		   	       			
	            	for(var i=0;i<result.data.length;i++){
	             		$("#province").append("<option value='"+result.data[i].region_Code+"'>"+result.data[i].region_Name+"</option>");
	            	}
	           },
	            error:function(){	            	
            	}
        	});
        	}
        	 //根据选择的省加载市
        	$("#province").change(function(e){
		      getCity($("#province option:selected").val());
		    });
        	 //根据选择的商户类别来选择商户规模和用电性质是否可选
        	$("#merchantType").change(function(e){
		      if($("#merchantType").val() ==2||$("#merchantType").val() ==3) {
		    	  $("#merchantScale").html(""); 
		       	  $("#merchantScale").append("<option value='0'>不选该项</option>");
		       	  //$("#energyProperty").html(""); 
		       	  //$("#energyProperty").append("<option value='0'>不选该项</option>");
		       	  //$("#marketPlace").html(""); 
		       	  //$("#marketPlace").append("<option value='0'>不选该项</option>");
		      }else {
		    	  findMerchantData();
		      }
		    if($("#merchantType").val()==2){//注册售电商户
       			$("#organNameDiv").css("display","none");
       		}
       		else{
       			$("#organNameDiv").css("display","block");
       		}
		    });
         function getCity(id){	
        	  $.ajax({
	            type: "POST",
	            url: "rest/rbac/MerchantRegistFlowController/getCity", 
	            data: 'id='+id,
	            cache: false,  //禁用缓存
	            dataType: "json",
	            success: function (result) {
	       	   $("#city").html(""); 
	       	   $("#city").append("<option value='0'>请选择</option>");		   	       			
	            	for(var i=0;i<result.data.length;i++){
	             		$("#city").append("<option value='"+result.data[i].region_Code+"'>"+result.data[i].region_Name+"</option>");
	            	}
	           },
	            error:function(){	            	
            	}
        	});
        }  
        //根据市加载区县
        	$("#city").change(function(e){
		      getCounty($("#city option:selected").val());
		    });
         function getCounty(id){	
        	  $.ajax({
	            type: "POST",
	            url: "rest/rbac/MerchantRegistFlowController/getCounty", 
	            data: 'id='+id,
	            cache: false,  //禁用缓存
	            dataType: "json",
	            success: function (result) {
	       	   $("#county").html(""); 
	       	   $("#county").append("<option value='0'>请选择</option>");		   	       			
	            	for(var i=0;i<result.data.length;i++){
	             		$("#county").append("<option value='"+result.data[i].region_Code+"'>"+result.data[i].region_Name+"</option>");
	            	}
	           },
	            error:function(){	            	
            	}
        	});
        }  
	</script>
	<script type="text/javascript">
	 	//获取下拉框的内容
	 	function findSelectData(){
	 		//获取所属经营公司
	 		/*$.ajax({
   	            url:'rest/rbac/MerchantRegistFlowController/getOperateOrganList',
   	            type: 'POST',
   	            dataType: 'json',
   	            async: false,
   	            success: function (result) {
   	            if(result.result == "success"){
	             	$("#organId").html(""); 
	       	   		$("#organId").append("<option value='0'>请选择</option>");		   	       			
	            	for(var i=0;i<result.data.length;i++){
	             		$("#organId").append("<option value='"+result.data[i].organId+"'>"+result.data[i].organName+"</option>");
	            	}
	             }
   	            },
   	            error: function(){
   	                parent.bootbox.alert("系统错误！获取所属经营公司失败。请刷新重新操作。", function(){});
   	            }
   	        });*/
   	        //获取商户类别
   	         $.ajax({
	            type: "POST",
	            url: "rest/rbac/MerchantRegistFlowController/getMerchantType", 
	            cache: false,  //禁用缓存
	            dataType: "json",
	            success: function (result) {
	       	   $("#merchantType").html(""); 
	       	   $("#merchantType").append("<option value='0'>请选择</option>");		   	       			
	            	for(var i=0;i<result.data.length;i++){
	             		$("#merchantType").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
	            	}
	           },
	            error:function(){	            	
            	}
        	});
        	//获取行业类别
        	$.ajax({
	            type: "POST",
	            url: "rest/rbac/MerchantRegistFlowController/getIndustryCategory", 
	            cache: false,  //禁用缓存
	            dataType: "json",
	            success: function (result) {
	       	   $("#industryCategory").html(""); 
	       	   $("#industryCategory").append("<option value='0'>请选择</option>");		   	       			
	            	for(var i=0;i<result.data.length;i++){
	             		$("#industryCategory").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
	            	}
	           },
	            error:function(){	            	
            	}
        	});
        	//加载信用等级
        	  $.ajax({
	            type: "POST",
	            url: "rest/rbac/MerchantRegistFlowController/getCredit", 
	            cache: false,  //禁用缓存
	            dataType: "json",
	            success: function (result) {
	       	   $("#credit").html(""); 
	       	   $("#credit").append("<option value='0'>请选择</option>");		   	       			
	            	for(var i=0;i<result.data.length;i++){
	             		$("#credit").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
	            	}
	           },
	            error:function(){	            	
            	}
        	});
        	 //加载园区类型	
        	  $.ajax({
	            type: "POST",
	            url: "rest/rbac/MerchantRegistFlowController/getParkType", 
	            cache: false,  //禁用缓存
	            dataType: "json",
	            success: function (result) {
		       	   $("#parkType").html("");
		       	   $("#parkTypeQuery").html("");
		       	   $("#parkType").append("<option value='0'>请选择</option>");	
		       	   $("#parkTypeQuery").append("<option value='0'>请选择</option>");	   	       			
		            	for(var i=0;i<result.data.length;i++){
		             		$("#parkType").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
		             		$("#parkTypeQuery").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
		            	}
		        },
	            error:function(){	            	
            	}
        	});
        	
        	 //加载电压等级
        	  $.ajax({
	            type: "POST",
	            url: "rest/rbac/MerchantRegistFlowController/getVoltageClass", 
	            cache: false,  //禁用缓存
	            dataType: "json",
	            success: function (result) {
	       	   $("#voltageClassConsume").html(""); 
	       	   $("#voltageClassConsume").append("<option value='0'>请选择</option>");		   	       			
	            	for(var i=0;i<result.data.length;i++){
	             		$("#voltageClassConsume").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
	            	}
	           },
	            error:function(){	            	
            	}
        	});
        	//加载电价方式
        	  $.ajax({
	            type: "POST",
	            url: "rest/rbac/MerchantRegistFlowController/getPriceMode", 
	            cache: false,  //禁用缓存
	            dataType: "json",
	            success: function (result) {
	       	   $("#priceModeConsume").html(""); 
	       	   $("#priceModeConsume").append("<option value='0'>请选择</option>");		   	       			
	            	for(var i=0;i<result.data.length;i++){
	             		$("#priceModeConsume").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
	            	}
	           },
	            error:function(){	            	
            	}
        	});
	 	}
	 	
	 	function findMerchantData(){
		 		//加载商户规模
	      	  $.ajax({
		            type: "POST",
		            url: "rest/rbac/MerchantRegistFlowController/getMerchantScale", 
		            cache: false,  //禁用缓存
		            dataType: "json",
		            success: function (result) {
		       	   $("#merchantScale").html(""); 
		       	   $("#merchantScale").append("<option value='0'>请选择</option>");		   	       			
		            	for(var i=0;i<result.data.length;i++){
		             		$("#merchantScale").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
		            	}
		           },
		            error:function(){	            	
	          	}
	      	});
	        //加载用电性质
	      	  $.ajax({
		            type: "POST",
		            url: "rest/rbac/MerchantRegistFlowController/getEnergyProperty", 
		            cache: false,  //禁用缓存
		            dataType: "json",
		            success: function (result) {
		            
		       	   $("#energyProperty").html(""); 
		       	   $("#energyPropertyConsume").html(""); 
		       	   $("#energyPropertyQuery").html("");
		       	   $("#energyProperty").append("<option value='0'>请选择</option>");	
		       	    $("#energyPropertyConsume").append("<option value='0'>请选择</option>");	
		       	      $("#energyPropertyQuery").append("<option value='0'>请选择</option>");		   	       			
		            	for(var i=0;i<result.data.length;i++){
		             		$("#energyProperty").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
		             		$("#energyPropertyConsume").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
		             		$("#energyPropertyQuery").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
		            	}
		           },
		            error:function(){	            	
	          	}
	      	});
	        //加载所属交易市场
	        $.ajax({
	        	type:"POST",
	        	url:"rest/rbac/MerchantRegistFlowController/listEnergyMarket",
	        	dataType:"json",
	        	cache: false,
	        	success:function (result){
	        		$('#marketPlace').html('');
	        		$('#marketPlace').append("<option value='0'>请选择</option>");	
	        		for(var i=0;i<result.data.length;i++){
	        			$('#marketPlace').append("<option value='"+result.data[i].market_Id+"'>"+result.data[i].market_Name+"</option>");
	            	}
	        	},
	        	error:function(){}
	        })
	 	}
	 </script>

	<script type="text/javascript">
	 	//加载园区表格
	 	function loadEnergyParkTable(){
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
	        	var table = $("#energyInfoTable").dataTable({
	        	    "dom": '<t><"row"<"col-md-2"l><"col-md-4"i><"col-md-6"p>>',    //为表格元素书写css样式<t>为中间表格  在<t>右边就是在表格下边
	           		language:lang,  //提示信息
	            	stripeClasses: ["odd", "even"],  //为奇偶行加上样式，兼容不支持CSS伪类的场合
		            serverSide: true,  //启用服务器端分页
		            searching: false,  //禁用原生搜索
		            bAutoWidth:false, //自适应宽度 
		            bDestroy:true,//重新加载使用
		            renderer: "bootstrap",  //渲染样式：Bootstrap和jquery-ui
		            pagingType: "full_numbers",  //分页样式：simple,simple_numbers,full,full_numbers
		            ordering:false,
		            ajax: function (data, callback, settings) {	
		                energyParkParam.rows = data.length;//页面显示记录条数，在页面显示每页显示多少项的时候
		                energyParkParam.start = data.start;//开始的记录序号
		                energyParkParam.page = (data.start / data.length)+1;//当前页码
		                if($("#parkNameQuery").val()!=""){
		               		energyParkParam.park_Name=$("#parkNameQuery").val();
		                }
		                else{
		                	delete energyParkParam.park_Name;
		                }
		                if($("#parkTypeQuery").val()!=""&&$("#parkTypeQuery").val()!=0){
		               		energyParkParam.park_Type=$("#parkTypeQuery").val();
		                }
		                else{
		                	delete energyParkParam.park_Type;
		                }
		                //ajax请求数据
		                $.ajax({
		                    type: "POST",
		                    url: "rest/rbac/MerchantRegistFlowController/girdEnergyParkList",
		                    cache: false,  //禁用缓存
		                    data: energyParkParam,  //传入组装的参数
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
					        "data": "park_Id", // 数据列名
					        "orderable":false,
					        "sWidth":"5px",
					        "render": function(data, type, full) { // 返回自定义内容
					       		return "<label><input type='checkbox' class='ace' id='park_Id' name='acecheck' value = '" + data + "' /><span class='lbl' id='id' value = '" + data + "'></span></label>";
					         }
	                    },
	                     {
	                    	"sWidth":"17%",
						  	"targets": [1], // 目标列位置，下标从0开始
						   	"data": "park_Name",// 数据列名
						   	function(data, type, full) { // 返回自定义内容
			                    	if(data !=null && data!=""){
		                                return data;
		                            }else{
		                                return "";
		                            } 
							}
	                    },
	                    {
	                    	"sWidth":"17%",
						  	"targets": [2], // 目标列位置，下标从0开始
						   	"data": "parkTypeString",// 数据列名
						   	function(data, type, full) { // 返回自定义内容
			                    	if(data !=null && data!=""){
		                                return data;
		                            }else{
		                                return "";
		                            } 
							}
	                    },
	                    {						   
						   "sWidth":"18%",
						   	"targets": [3], // 目标列位置，下标从0开始
						   	"data": "park_Address",	// 数据列名
						   		function(data, type, full) { // 返回自定义内容
			                    	if(data !=null && data!=""){
		                                return data;
		                            }else{
		                                return "";
		                            } 
							}	 
	                    },	 
	                     {						   
						   "sWidth":"18%",
						   	"targets": [4], // 目标列位置，下标从0开始
						   	"data": "power_Company",// 数据列名
						   	function(data, type, full) { // 返回自定义内容
			                    	if(data !=null && data!=""){
		                                return data;
		                            }else{
		                                return "";
		                            } 
							}
						   	 
	                    } ,
	                     {						   
						   "sWidth":"18%",
						   	"targets": [5], // 目标列位置，下标从0开始
						   	"data": "park_Longitude",// 数据列名
						   	function(data, type, full) { // 返回自定义内容
			                    	if(data !=null && data!=""){
		                                return data;
		                            }else{
		                                return "";
		                            } 
							}
						   	 
	                    }, {						   
						   "sWidth":"18%",
						   	"targets": [6], // 目标列位置，下标从0开始
						   	"data": "park_Latitude",// 数据列名
						   	function(data, type, full) { // 返回自定义内容
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
		   
		    //点击下一步时，提示用户先添加园区信息
		 function getEnergyParkList(){
		 	var energyParkNum=0;
		      	$.ajax({
		           type: "POST",
		           url: "rest/rbac/MerchantRegistFlowController/girdEnergyParkList", 
		           data:energyParkParam,
		           cache: false,  //禁用缓存
		           dataType: "json",
		           async:false,
		           success: function (result) {
			      	  energyParkNum=result.total;
			      	   if(result.total==0){//标识还没添加联系人
			      	   		//parent.bootbox.alert("请先添加园区信息。");
		     	 			return energyParkNum;	
			      	   }
			      	   else{
			      	   		//$("#energyInfoEdit").css("display","none");
				       		//$("#powerInfoEdit").css("display","block");
				       		
			      	   }
			          },
		           error:function(){	            	
		          	}
		      	});
		      	return energyParkNum;
		    }                
	 </script>
	<script type="text/javascript">
	 	var linkManParam={};
	 	//加载联系人table
	 	function loadLinkManTable(){
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
	        	var table = $("#linkManTable").dataTable({
	        	    "dom": '<t><"row"<"col-md-2"l><"col-md-4"i><"col-md-6"p>>',    //为表格元素书写css样式<t>为中间表格  在<t>右边就是在表格下边
	           		language:lang,  //提示信息
	            	stripeClasses: ["odd", "even"],  //为奇偶行加上样式，兼容不支持CSS伪类的场合
		            serverSide: true,  //启用服务器端分页
		            searching: false,  //禁用原生搜索
		            bAutoWidth:false, //自适应宽度 
		            bDestroy:true,//重新加载使用
		            renderer: "bootstrap",  //渲染样式：Bootstrap和jquery-ui
		            pagingType: "full_numbers",  //分页样式：simple,simple_numbers,full,full_numbers
		            ordering:false,
		            ajax: function (data, callback, settings) {	
		                linkManParam.rows = data.length;//页面显示记录条数，在页面显示每页显示多少项的时候
		                linkManParam.start = data.start;//开始的记录序号
		                linkManParam.page = (data.start / data.length)+1;//当前页码
		                if($("#linkManNameQuery").val()!=""){
		               		linkManParam.linkman_Name=$("#linkManNameQuery").val();
		                }
		                else{
		               		delete linkManParam.linkman_Name;
		                }
		                if($("#phoneQuery").val()!=""){
		               		linkManParam.phone=$("#phoneQuery").val();
		                }
		                else{
		               		delete linkManParam.phone;
		                }
		                //ajax请求数据
		                $.ajax({
		                    type: "POST",
		                    url: "rest/rbac/MerchantRegistFlowController/girdLinkMan",
		                    cache: false,  //禁用缓存
		                    data: linkManParam,  //传入组装的参数
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
					        "data": "link_Man_Id", // 数据列名
					        "orderable":false,
					        "sWidth":"5px",
					        "render": function(data, type, full) { // 返回自定义内容
					       		return "<label><input type='checkbox'  class='ace' id='link_Man_Id' name='acecheck' value = '" + data + "' /><span class='lbl' id='id' value = '" + data + "'></span></label>";
					         }
	                    },
	                     {
	                    	"sWidth":"11%",
						  	"targets": [1], // 目标列位置，下标从0开始
						   	"data": "linkman_Name",// 数据列名
						   	function(data, type, full) { // 返回自定义内容
			                    	if(data !=null && data!=""){
		                                return data;
		                            }else{
		                                return "";
		                            } 
							}
	                    },
	                    {
	                    	"sWidth":"11%",
						  	"targets": [2], // 目标列位置，下标从0开始
						   	"data": "phone",// 数据列名
						   	function(data, type, full) { // 返回自定义内容
			                    	if(data !=null && data!=""){
		                                return data;
		                            }else{
		                                return "";
		                            } 
							}
	                    },
	                    {						   
						   "sWidth":"11%",
						   	"targets": [3], // 目标列位置，下标从0开始
						   	"data": "mobile_Phone",	// 数据列名
						   		function(data, type, full) { // 返回自定义内容
			                    	if(data !=null && data!=""){
		                                return data;
		                            }else{
		                                return "";
		                            } 
							}	 
	                    },	 
	                     {						   
						   "sWidth":"11%",
						   	"targets": [4], // 目标列位置，下标从0开始
						   	"data": "fax",// 数据列名
						   	function(data, type, full) { // 返回自定义内容
			                    	if(data !=null && data!=""){
		                                return data;
		                            }else{
		                                return "";
		                            } 
							}
						   	 
	                    } ,{
	                    	"sWidth":"11%",
						  	"targets": [5], // 目标列位置，下标从0开始
						   	"data": "email",// 数据列名
						   	function(data, type, full) { // 返回自定义内容
			                    	if(data !=null && data!=""){
		                                return data;
		                            }else{
		                                return "";
		                            } 
							}
	                    },
	                    {
	                    	"sWidth":"11%",
						  	"targets": [6], // 目标列位置，下标从0开始
						   	"data": "post",// 数据列名
						   	function(data, type, full) { // 返回自定义内容
			                    	if(data !=null && data!=""){
		                                return data;
		                            }else{
		                                return "";
		                            } 
							}
	                    },
	                    {						   
						   "sWidth":"11%",
						   	"targets": [7], // 目标列位置，下标从0开始
						   	"data": "address",	// 数据列名
						   		function(data, type, full) { // 返回自定义内容
			                    	if(data !=null && data!=""){
		                                return data;
		                            }else{
		                                return "";
		                            } 
							}	 
	                    },	 
	                     {						   
						   "sWidth":"11%",
						   	"targets": [8], // 目标列位置，下标从0开始
						   	"data": "wechat_Num",// 数据列名
						   	function(data, type, full) { // 返回自定义内容
			                    	if(data !=null && data!=""){
		                                return data;
		                            }else{
		                                return "";
		                            } 
							}
						   	 
	                    } 
	                    ,	 
	                     {						   
						   "sWidth":"12%",
						   	"targets": [9], // 目标列位置，下标从0开始
						   	"data": "memo",// 数据列名
						   	function(data, type, full) { // 返回自定义内容
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
		   //点击下一步时，提示用户先添加联系人
		 function getLinkManList(){
		      	$.ajax({
		           type: "POST",
		           url: "rest/rbac/MerchantRegistFlowController/girdLinkMan", 
		           data:linkManParam,
		           cache: false,  //禁用缓存
		           dataType: "json",
		           async:false,
		           success: function (result) {
			      	   if(result.total==0){//标识还没添加联系人
			      	   		parent.bootbox.alert("请先添加联系人信息。");
		     	 			return;	
			      	   }
			      	   else{
			      		   $("#fromEdit").css("display","none");
				        	energyParkParam.department_Id=$("#merchantId").val();
				       		loadEnergyParkTable();
				       		$("#energyInfoEdit").css("display","block");
			      	   }
			          },
		           error:function(){	            	
		          	}
		      	});
		    }
		     
		  //点击完成时，提示用户先添加联系人
		 function getLinkManListFinish(){
		      	$.ajax({
		           type: "POST",
		           url: "rest/rbac/MerchantRegistFlowController/girdLinkMan", 
		           data:linkManParam,
		           cache: false,  //禁用缓存
		           dataType: "json",
		           async:false,
		           success: function (result) {
			      	   if(result.total==0){//标识还没添加联系人
			      	   		parent.bootbox.alert("请先添加联系人信息。");
		     	 			return;	
			      	   }
			      	   else{
			      	   		$("#fromEdit").css("display","none");
			      	   		$("#registDialog").css("display","block");
			      	   		parent.bootbox.alert("恭喜您，商户信息已经完善。请牢记您的账户信息！！！账户名"+$("#accountId").val()+"登录密码"+$("#password").val());
			      	   }
			          },
		           error:function(){	            	
		          	}
		      	});
		    }
		   
	  </script>
	<script type="text/javascript">
	   		//保存商户信息
		   function addMerchantFunction(){ 
		     thisid = this.id;  //获取当前点击按钮的id
		     /*if($("#organId").val()!=null &&$("#organId").val()!=""&&$("#organId").val()!=0){
		     	  merchant.belongOrganId=$("#organId").val();
		     }else{
		     	 parent.bootbox.alert("请选择所属公司");
		     	 return;
		     }*/
		     merchant.belongOrganId=$("#organId").val();
		     if($("#merchantType").val()!=null &&$("#merchantType").val()!=""&&$("#merchantType").val()!=0){
		     	 merchant.merchant_Type=$("#merchantType  option:selected").val();
		     }else{
		     	 parent.bootbox.alert("请选择商户类别");
		     	 return;
		     } 
		     if($("#marketPlace").val()!=null &&$("#marketPlace").val()!=""&&$("#marketPlace").val()!=0){
		     	 merchant.marketId=$("#marketPlace  option:selected").val();
		     	 merchant.marketName=$("#marketPlace  option:selected").text();
		     }else{
		     	 parent.bootbox.alert("请选择所属交易市场");
		     	 return;
		     }  
		     if($("#merchantName").val()!=null &&$("#merchantName").val()!=""&&$("#merchantName").val()!=0){
		     	 merchant.merchant_Name=$("#merchantName").val();
		     }else{
		     	 parent.bootbox.alert("请填写商户名称");
		     	 return;
		     }
// 		     if($("#energyProperty").val()!=null &&$("#energyProperty").val()!=""&&$("#energyProperty").val()!=0 ){
// 		     	   merchant.energy_Property=$("#energyProperty").val();
// 		     }else if($("#merchantType").val() !=2&&$("#merchantType").val() !=3 ){
// 		     	 parent.bootbox.alert("请选择用电性质");
// 		     	 return;
// 		     }
		     if($("#credit").val()!=null &&$("#credit").val()!=""&&$("#credit").val()!=0){
		     	   merchant.credit=$("#credit").val();
		     }
		     if($("#legalPerson").val()!=null &&$("#legalPerson").val()!=""&&$("#legalPerson").val()!=0){
		     	 merchant.legal_Person=$("#legalPerson").val();
		     }	    
		    if($("#bankAccount").val()!=null &&$("#bankAccount").val()!=""&&$("#bankAccount").val()!=0){
		     	  merchant.bank_Accout=$("#bankAccount").val();
		     }/* else{
		     	  parent.bootbox.alert("请填写银行账户");
		     	  return; 
		     } */
		    if($("#accountName").val()!=null &&$("#accountName").val()!=""&&$("#accountName").val()!=0){
		     	  merchant.account_Name=$("#accountName").val();
		     }/* else{
		     	 parent.bootbox.alert("请填写开户名称");
		     	 return;
		     } */
		     if($("#regNumber").val()!=null &&$("#regNumber").val()!=""&&$("#regNumber").val()!=0){
		     	   // var regNumberCheck=/^\d{17}[a-zA-Z]{1}$/;
				      // if(!regNumberCheck.exec($("#regNumber").val())) {
					    // parent.bootbox.alert("三证合一号应该为17位数字加1位字母。");
					   //  return;
					   //}else{
					   	merchant.reg_Number= $("#regNumber").val();
					   //}
		     }
		     if($("#province").val()==null ||$("#province").val()==""||$("#province").val()==0){
		     	 parent.bootbox.alert("请选择商户地址所在的省份");
		     	 return;
		     }
		     else  if($("#city").val()==null ||$("#city").val()==""||$("#city").val()==0){
		     	 parent.bootbox.alert("请选择商户地址所在的市区");
		     	 return;
		     }else if($("#county").val()==null ||$("#county").val()==""||$("#county").val()==0){
		     	 parent.bootbox.alert("请选择商户地址所在的区县");
		     	 return;
		     }else {
		    	 //区域编号
		     	 merchant.region_Code=$("#county option:selected").val();
		     }if($("#address").val()!=null &&$("#address").val()!=""&&$("#address").val()!=0){
		     	 merchant.address=$("#province option:selected").text()+$("#city option:selected").text()+$("#county option:selected").text()+"*"+ $("#address").val();
		     	
		     }	   
		     if($("#regCapital").val()==""){
		        merchant.reg_Capital=0;
		     }else{
	         	merchant.reg_Capital=$("#regCapital").val();
	         	//var nums = /^\d*$/; //全数字
	         	//验证有1-3位小数的正实数：
	         var nums=/^[0-9]+(.[0-9]{1,3})?$/;
			   if(!nums.exec(merchant.reg_Capital)) {
			     parent.bootbox.alert("注册资本应该为数字。");
			     return;
			   }
	         }
		     merchant.fax= $("#fax").val();
		     if($("#postcode").val()!=""){
		       var postCodeCheck=/^\d{6}$/;
		       if(!postCodeCheck.exec($("#postcode").val())) {
			     parent.bootbox.alert("邮编应该为6位数字。");
			     return;
			   }else{
			   	merchant.postcode=$("#postcode").val();
			   }
		     }
		     merchant.public_Number=$("#publicNumber").val();
		    
		     if($("#email").val()!=""){
		     	var emailCheck=/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
		     	if(!emailCheck.test($("#email").val())){
		     		 parent.bootbox.alert("请填写正确的邮箱。");
			     	return;
		     	}
		     	else{
		     		 merchant.email=$("#email").val();
		     	}
		     }
		     merchant.industry_Category= $("#industryCategory").val();
		     merchant.merchant_Scale=$("#merchantScale").val();
		     merchant.reg_User_Name=$("#regName").val();
		     merchant.reg_Date=new Date($("#regTime").val());;
		     merchant.check_State=2;//未审核状态
		     if($("#depositBank").val()!=null &&$("#depositBank").val()!=""&&$("#depositBank").val()!=0){
		     	var depositBankCheck=/^[\u4e00-\u9fa5]{0,}$/;
		     	if(!depositBankCheck.exec($("#depositBank").val())){
		     		 parent.bootbox.alert("请填写开户银行的汉字。");
			     	return;
		     	}else{
		     		merchant.deposit_Bank= $("#depositBank").val();
		     	}
		     }/* else{
		     	 parent.bootbox.alert("请填写开户银行");
		     	 return;
		     } */
		     if(CheckBankNo()!=false){
		     	//判断是新增还是更新
		     	if(merchant.flag=="addF"){
		     		addMerchant(merchant);
		     	}
		     	else if(merchant.flag=="updateF"){
		     		merchant.organid=$("#merchantId").val();
		     		updateMerchant(merchant);
		     	}
		     }
		     else{
		     	return;
		     }
		     
       };
       //添加商户
        function addMerchant(merchant){	
			$.ajax({
   	            url:'rest/rbac/MerchantRegistFlowController/addMerchant',
   	            data:merchant,
   	            type: 'POST',
   	            dataType: 'json',
   	            async: false,
   	            success: function (result) {
	   	            if(result.result =="merchantName"){
		            	parent.bootbox.alert("该商户名称已经存在请更换商户名称。");
		            	return;
		            }
		            else if(result.result =="regNumber"){
		            	parent.bootbox.alert("该三证合一号已经存在！请更换三证合一号。");
		            	return;
		            } 
		             else{
			            parent.bootbox.alert("注册商户成功！请继续完善商户信息", function(){});
			            	$("#merchantCode").val(result.result.data);
			             	$("#merchantCodeDiv").css("display","block");
			             	$("#merchantId").val(result.result.organId);
			              	$("#accountId").val(result.result.accountName);
			                $("#password").val(result.result.password);
			             	$("#registDialog").css("display","none");
			             	$("#fromEdit").css("display","block");
			             	if( $("#merchantType").val() != 2&&$("#merchantType").val() !=3) {
	       						$("#noProductEdit").css("display","block");
			             	}else if($("#merchantType").val() == 2||$("#merchantType").val() ==3){
			             		$("#productEdit").css("display","block");
			             	}
			             linkManParam.organid=result.result.organId;
       					 loadLinkManTable();
			           
		            }
   	            },
   	            error: function(){
   	                parent.bootbox.alert("系统错误！添加注册失败。请刷新重新操作。");
   	            }
   	        }); 
	    }
	    //更新商户
        function updateMerchant(merchant){	
			$.ajax({
   	            url:'rest/rbac/MerchantRegistFlowController/updateEnergyMerchantInfo',
   	            data:merchant,
   	            type: 'POST',
   	            dataType: 'json',
   	            async: false,
   	            success: function (result) {
	   	            if(result.result == "success"){
	   	            	parent.bootbox.alert("更新商户信息成功！");
			            $("#registDialog").css("display","none");
	       				$("#fromEdit").css("display","block");
			            linkManParam.organid=$("#merchantId").val();
       					loadLinkManTable();
		            }
		            else if(result.result == "merchantName"){
		            	parent.bootbox.alert("该商户名称已经存在，请更换商户名称。");
		            	return;
		            } 
		            else if(result.result =="regNumber"){
		            	parent.bootbox.alert("该三证合一号已经存在！请更换三证合一号。");
		            	return;
		            } 
   	            },
   	            error: function(){
   	                parent.bootbox.alert("系统错误！更新商户信息失败。请刷新重新操作。", function(){});
   	            }
   	        }); 
	    }
	    </script>
	<!-- 联系人相关功能 -->
	<script type="text/javascript">
	    //添加或编辑联系人弹出框
	    function linkManDialog(e) {
        	var dialog = $("#linkManDialog").removeClass('hide').dialog({
	            modal: true,
	            width: 350,
	            title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>联系人管理</h4></div>",
	            title_html: true,
	            buttons: [
	                {
	                    text: "取消",
	                    "class": "btn btn-xs",
	                    click: function () {
	                        $(this).dialog("close");
	                    }
	                },
	                {
	                    text: "保存",
	                    "class": "btn btn-primary btn-xs",
	                    click: function () {
	                        if (thisid == "btnAddLinkMan") {
		                        par.organid=$("#merchantId").val();
								par.linkman_Name = $("#linkmanName").val();
								par.mobile_Phone = $("#mobilePhone").val();
							    par.email=$("#emails").val();
								par.address=$("#addresss").val();
								par.phone=$("#phones").val();
								par.fax=$("#faxs").val();
								par.post=$("#post").val();
								par.wechat_Num=$("#wechatNum").val();
								par.memo=$("#memo").val();
		 						addLinkMan(par);
	                        }
	                        if (thisid == "btnEditLinkMan") {
		                        par.link_Man_Id=$("#link_Man_Id:checked").val();
		                        par.organid=$("#merchantId").val();
								par.linkman_Name = $("#linkmanName").val();
								par.mobile_Phone = $("#mobilePhone").val();
							    par.email=$("#emails").val();
								par.address=$("#addresss").val();
								par.phone=$("#phones").val();
								par.fax=$("#faxs").val();
								par.post=$("#post").val();
								par.wechat_Num=$("#wechatNum").val();
								par.memo=$("#memo").val();
		 						updateLinkMan(par);
	                        }
	                    }
	                }
	            ]
        });
    }
    //添加联系人信息
	function addLinkMan(par){	
		if(par.linkman_Name==""){
			  parent.bootbox.alert("联系人姓名不能为空！")
			  return;
		}	
		if(par.mobile_Phone==""){
			  parent.bootbox.alert("手机号码不能为空！")
			  return;
		}
		if(par.address==""){
			  parent.bootbox.alert("地址不能为空！")
			  return;
		}
		if(par.wechat_Num==""){
			  parent.bootbox.alert("微信号不能为空！")
			  return;
		}	
		$.ajax({
  	            url:'rest/rbac/MerchantRegistFlowController/addLinkMan',
  	            data: par,
  	            type: 'POST',
  	            dataType: 'json',
  	            async: false,
  	            success: function (result) {
  	            	if(result.result== "success"){
	                	parent.bootbox.alert("联系人添加成功！");
	                	$( "#linkManDialog" ).dialog( "close" );
	                	linkManParam.organid=$("#merchantId").val();
	                	loadLinkManTable();
                	}
  	            },
  	            error: function(){
  	                parent.bootbox.alert("系统错误！添加联系人信息失败。请刷新重新操作。", function(){});
  	            }
  	        });	
	}
	//根据联系人获取联系人信息
   	function getLinkManInfo(e){
		$.ajax({
            url: 'rest/rbac/MerchantRegistFlowController/getLinkManInfo',
            data: linkManParam,
            async: false,
            type: 'POST',
            dataType: 'json',
            success: function (result) {
 	            $("#linkmanName").val(result.data.linkman_Name);
				$("#mobilePhone").val(result.data.mobile_Phone);
				$("#emails").val(result.data.email);
				$("#addresss").val(result.data.address);
				$("#phones").val(result.data.phone);
				$("#faxs").val(result.data.fax);
				$("#post").val(result.data.post);
				$("#wechatNum").val(result.data.wechat_Num);
				$("#memo").val(result.data.memo);
				linkManDialog(e);
   	        },
   	        error: function(){
   	            parent.bootbox.alert("系统错误！获取偏差系数信息失败。请刷新重新操作。", function(){});
   	        }
   	    });
	}
	//更新联系人
	function updateLinkMan(par){	
		if(par.linkman_Name==""){
			  parent.bootbox.alert("联系人姓名不能为空！")
			  return;
		}	
		if(par.mobile_Phone==""){
			  parent.bootbox.alert("手机号码不能为空！")
			  return;
		}
		if(par.address==""){
			  parent.bootbox.alert("地址不能为空！")
			  return;
		}
		if(par.wechat_Num==""){
			  parent.bootbox.alert("微信号不能为空！")
			  return;
		}	
		$.ajax({
  	            url:'rest/rbac/MerchantRegistFlowController/updateLinkMan',
  	            data: par,
  	            type: 'POST',
  	            dataType: 'json',
  	            async: false,
  	            success: function (result) {
  	            	if(result.result== "success"){
	                	parent.bootbox.alert("联系人信息更新成功！");
                		$( "#linkManDialog" ).dialog( "close" );
                		linkManParam.organid=$("#merchantId").val();
                		loadLinkManTable();
                	}
  	            },
  	            error: function(){
  	                parent.bootbox.alert("系统错误！联系人信息更新失败。请刷新重新操作。", function(){});
  	            }
  	        });	
	     }
	     //删除联系人信息
	 	function deleteLinkMan(){
	 		 linkManParam.linkManIds=[];    
				parent.bootbox.confirm("你确定要删除联系人信息吗？", function(result) {
				if(result){				
					for(var i=0;i<$("#link_Man_Id:checked").length;i++){
		        		linkManParam.linkManIds[i]=$("#link_Man_Id:checked")[i].defaultValue;
		        	}
						$.ajax({
		    	            url: 'rest/rbac/MerchantRegistFlowController/delLinkMan',
		    	            async: false,
		    	            data:  linkManParam,
		    	            type: 'POST',
		    	            dataType: 'json',
		    	            success: function (result) { 
		    	            	if(result.result == "success"){
			    	            	parent.bootbox.alert("该联系人信息删除成功！");
			    	            	linkManParam.organid=$("#merchantId").val();
			    	            	loadLinkManTable();
			    	             }
		    	            },
		    	            error: function(){
		    	            	parent.bootbox.alert("联系人信息删除失败！", function(){});
		    	            }
			   	        });	   	       
				    }
			  });
		}
    </script>
	<!-- 园区相关功能 -->
	<script type="text/javascript">
    	//添加或编辑园区信息弹出框
	    function energyParkDialog(e) {
        	var dialog = $("#energyParkDialog").removeClass('hide').dialog({
	            modal: true,
	            width: 500,
	            title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>园区信息管理</h4></div>",
	            title_html: true,
	            buttons: [
	                {
	                    text: "取消",
	                    "class": "btn btn-xs",
	                    click: function () {
	                        $(this).dialog("close");
	                    }
	                },
	                {
	                    text: "保存",
	                    "class": "btn btn-primary btn-xs",
	                    click: function () {
	                    	if($("#latitude").val()==""){
	                    		parent.bootbox.alert("请点击按钮获取坐标位置信息");
	                    		return;
	                    	}
	                    	else{
	                    		  var  latitudes=$("#latitude").val().split(",");
	                    		if(latitudes.length<=1){
							     	parent.bootbox.alert("请输入正确的经度和维度，并用“,”隔开");
								     	return;
							     }else{
							     	energyParkParam.park_Latitude=latitudes[1];
							     	energyParkParam.park_Longitude=latitudes[0];
							     }
	                    	}
	                        if (thisid == "btnAddEnergyPark") {
		                        energyParkParam.department_Id=$("#merchantId").val();
								energyParkParam.park_Name = $("#parkName").val();
								energyParkParam.park_Type = $("#parkType").val();
							    energyParkParam.power_Company=$("#powerCompany").val();
								energyParkParam.park_Address=$("#parkAddress").val();
		 						addEnergyPark(energyParkParam);
	                        }
	                        if (thisid == "btnEditEnergyPark") {
	                        	energyParkParam.department_Id=$("#merchantId").val();
								energyParkParam.park_Name = $("#parkName").val();
								energyParkParam.park_Type = $("#parkType").val();
							    energyParkParam.power_Company=$("#powerCompany").val();
								energyParkParam.park_Address=$("#parkAddress").val();
		 						updateEnergyPark(energyParkParam);
	                        }
	                    }
	                }
	            ]
        });
    }
    //添加联系人信息
	function addEnergyPark(energyParkParam){	
		if(energyParkParam.park_Name==""){
			  parent.bootbox.alert("请填写园区名称！")
			  return;
		}	
		if(energyParkParam.park_Type==""||energyParkParam.park_Type==0){
			  parent.bootbox.alert("请选择园区类型！")
			  return;
		}
		if(energyParkParam.power_Company==""){
			  parent.bootbox.alert("请填写对应电网企业！")
			  return;
		}
		if(energyParkParam.park_Address==""){
			  parent.bootbox.alert("请填写园区地址！")
			  return;
		}	
		energyParkParam.scada_Park_Id=0;//必加项，与monitor关联
		$.ajax({
  	            url:'rest/rbac/MerchantRegistFlowController/addEnergyPark',
  	            data: energyParkParam,
  	            type: 'POST',
  	            dataType: 'json',
  	            async: false,
  	            success: function (result) {
  	            	if(result.result== "success"){
	                	parent.bootbox.alert("园区信息配置成功！");
	                	$( "#energyParkDialog" ).dialog( "close" );
	                	energyParkParam.department_Id=$("#merchantId").val();
	                	$("#energyParkId").val(result.data);
	                	loadEnergyParkTable();
                	}
  	            },
  	            error: function(){
  	                parent.bootbox.alert("系统错误！园区信息配置失败。请刷新重新操作。", function(){});
  	            }
  	        });	
	}
	//获取园区信息
		function getEnergyParkInfo(e){
		$.ajax({
            url: 'rest/rbac/MerchantRegistFlowController/getEnergyParkInfo',
            data: energyParkParam,
            async: false,
            type: 'POST',
            dataType: 'json',
            success: function (result) {
 	            $("#parkName").val(result.data.park_Name);
				$("#parkType").val(result.data.park_Type);
				$("#parkAddress").val(result.data.park_Address);
				$("#powerCompany").val(result.data.power_Company);
				$("#latitude").val(result.data.park_Longitude+","+result.data.park_Latitude);
				energyParkParam.park_Id=result.data.park_Id;
				energyParkDialog(e);
   	        },
   	        error: function(){
   	            parent.bootbox.alert("系统错误！获取园区信息失败。请刷新重新操作。", function(){});
   	        }
   	    });
	}
	//更新园区信息
	function updateEnergyPark(energyParkParam){	
		if(energyParkParam.park_Name==""){
			  parent.bootbox.alert("请填写园区名称！")
			  return;
		}	
		if(energyParkParam.park_Type==""||energyParkParam.park_Type==0){
			  parent.bootbox.alert("请选择园区类型！")
			  return;
		}
		if(energyParkParam.power_Company==""){
			  parent.bootbox.alert("请填写对应电网企业！")
			  return;
		}
		if(energyParkParam.park_Address==""){
			  parent.bootbox.alert("请填写园区地址！")
			  return;
		}	
		energyParkParam.scada_Park_Id=0;//必加项，与monitor关联
		$.ajax({
  	            url:'rest/rbac/MerchantRegistFlowController/updateEnergyPark',
  	            data: energyParkParam,
  	            type: 'POST',
  	            dataType: 'json',
  	            async: false,
  	            success: function (result) {
  	            	if(result.result== "success"){
	                	parent.bootbox.alert("园区信息更新成功！");
                		$( "#energyParkDialog" ).dialog( "close" );
                		energyParkParam.department_Id=result.departmentId;
                		loadEnergyParkTable();
                	}
  	            },
  	            error: function(){
  	                parent.bootbox.alert("系统错误！园区信息更新失败。请刷新重新操作。", function(){});
  	            }
  	        });	
	     }
	      //删除园区信息
	 	function deleteEnergyPark(){
	 		 energyParkParam.parkIds=[];    
				parent.bootbox.confirm("你确定要删除园区信息吗？", function(result) {
				if(result){				
					for(var i=0;i<$("#park_Id:checked").length;i++){
		        		energyParkParam.parkIds[i]=$("#park_Id:checked")[i].defaultValue;
		        	}
						$.ajax({
		    	            url: 'rest/rbac/MerchantRegistFlowController/delEnergyPark',
		    	            async: false,
		    	            data:  energyParkParam,
		    	            type: 'POST',
		    	            dataType: 'json',
		    	            success: function (result) { 
		    	            	if(result.result == "success"){
			    	            	parent.bootbox.alert("园区信息删除成功！");
			    	            	energyParkParam.department_Id=$("#merchantId").val();
			    	            	loadEnergyParkTable();
			    	             }
		    	            },
		    	            error: function(){
		    	            	parent.bootbox.alert("园区信息删除失败！", function(){});
		    	            }
			   	        });	   	       
				    }
			  });
		}
    </script>
	<!-- 用户用电信息配置 -->
	<script type="text/javascript">
	 	function loadEnergyConsumeTable(){
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
	        	var table = $("#consumeTable").dataTable({
	        	    "dom": '<t><"row"<"col-md-2"l><"col-md-4"i><"col-md-6"p>>',    //为表格元素书写css样式<t>为中间表格  在<t>右边就是在表格下边
	           		language:lang,  //提示信息
	            	stripeClasses: ["odd", "even"],  //为奇偶行加上样式，兼容不支持CSS伪类的场合
		            serverSide: true,  //启用服务器端分页
		            searching: false,  //禁用原生搜索
		            bAutoWidth:false, //自适应宽度 
		            bDestroy:true,//重新加载使用
		            renderer: "bootstrap",  //渲染样式：Bootstrap和jquery-ui
		            pagingType: "full_numbers",  //分页样式：simple,simple_numbers,full,full_numbers
		            ordering:false,
		            ajax: function (data, callback, settings) {	
		                energyConsumeParamTable.rows = data.length;//页面显示记录条数，在页面显示每页显示多少项的时候
		                energyConsumeParamTable.start = data.start;//开始的记录序号
		                energyConsumeParamTable.page = (data.start / data.length)+1;//当前页码
		                energyConsumeParamTable.organId=$("#merchantId").val();
		                if($("#supplyLocationQuery").val()!=0&&$("#supplyLocationQuery").val()!=""){
		                	energyConsumeParamTable.supply_Location=$("#supplyLocationQuery option:selected").text();
		                }
		                else{
		                	delete energyConsumeParamTable.supply_Location;
		                }
		                if($("#energyPropertyQuery").val()!=0&&$("#energyPropertyQuery").val()!=""){
		                	energyConsumeParamTable.energy_Property=$("#energyPropertyQuery option:selected").text();
		                }
		                else{
		                	delete energyConsumeParamTable.energy_Property;
		                }
		                //ajax请求数据
		                $.ajax({
		                    type: "POST",
		                    url: "rest/rbac/MerchantRegistFlowController/gridEnergyConsumeList",
		                    cache: false,  //禁用缓存
		                    data: energyConsumeParamTable,  //传入组装的参数
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
					        "data": "park_Id", // 数据列名
					        "orderable":false,
					        "sWidth":"5px",
					        "render": function(data, type, full) { // 返回自定义内容
					       		return "<label><input type='radio' name='radio' class='ace' id='park_Id_Consume' value = '" + data + "' /><span class='lbl' id='id' value = '" + data + "'></span></label>";
					         }
	                    },
	                     {
	                    	"sWidth":"10%",
						  	"targets": [1], // 目标列位置，下标从0开始
						   	"data": "supply_Location",// 数据列名
						   	function(data, type, full) { // 返回自定义内容
			                    	if(data !=null && data!=""){
		                                return data;
		                            }else{
		                                return "";
		                            } 
							}
	                    },
	                    {
	                    	"sWidth":"10%",
						  	"targets": [2], // 目标列位置，下标从0开始
						   	"data": "voltageClassString",// 数据列名
						   	function(data, type, full) { // 返回自定义内容
			                    	if(data !=null && data!=""){
		                                return data;
		                            }else{
		                                return "";
		                            } 
							}
	                    },
	                    {						   
						   "sWidth":"10%",
						   	"targets": [3], // 目标列位置，下标从0开始
						   	"data": "energyPropertyString",	// 数据列名
						   		function(data, type, full) { // 返回自定义内容
			                    	if(data !=null && data!=""){
		                                return data;
		                            }else{
		                                return "";
		                            } 
							}	 
	                    },	 
	                     {						   
						   "sWidth":"10%",
						   	"targets": [4], // 目标列位置，下标从0开始
						   	"data": "volume",// 数据列名
						   	function(data, type, full) { // 返回自定义内容
			                    	if(data !=null && data!=""){
		                                return data;
		                            }else{
		                                return "";
		                            } 
							}
						   	 
	                    } ,{
	                    	"sWidth":"10%",
						  	"targets": [5], // 目标列位置，下标从0开始
						   	"data": "priceModeString",// 数据列名
						   	function(data, type, full) { // 返回自定义内容
			                    	if(data !=null && data!=""){
		                                return data;
		                            }else{
		                                return "";
		                            } 
							}
	                    },
	                    {
	                    	"sWidth":"10%",
						  	"targets": [6], // 目标列位置，下标从0开始
						   	"data": "capacity_Price",// 数据列名
						   	function(data, type, full) { // 返回自定义内容
			                    	if(data !=null && data!=""){
		                                return data;
		                            }else{
		                                return "";
		                            } 
							}
	                    },
	                    {						   
						   "sWidth":"10%",
						   	"targets": [7], // 目标列位置，下标从0开始
						   	"data": "catalog_Price",	// 数据列名
						   		function(data, type, full) { // 返回自定义内容
			                    	if(data !=null && data!=""){
		                                return data;
		                            }else{
		                                return "";
		                            } 
							}	 
	                    },	 
	                     {						   
						   "sWidth":"10%",
						   	"targets": [8], // 目标列位置，下标从0开始
						   	"data": "peak_Price",// 数据列名
						   	function(data, type, full) { // 返回自定义内容
			                    	if(data !=null && data!=""){
		                                return data;
		                            }else{
		                                return "";
		                            } 
							}
						   	 
	                    } 
	                    ,	 
	                     {						   
						   "sWidth":"10%",
						   	"targets": [9], // 目标列位置，下标从0开始
						   	"data": "flat_Price",// 数据列名
						   	function(data, type, full) { // 返回自定义内容
			                    	if(data !=null && data!=""){
		                                return data;
		                            }else{
		                                return "";
		                            } 
							}
						   	 
	                    },	 
	                     {						   
						   "sWidth":"10%",
						   	"targets": [10], // 目标列位置，下标从0开始
						   	"data": "valley_Price",// 数据列名
						   	function(data, type, full) { // 返回自定义内容
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
		   //获取用户的用电配置信息
	    function getEnergyConsumeList(){
			var consumeNum=0;
			$.ajax({
               type: "POST",
               url: "rest/rbac/MerchantRegistFlowController/gridEnergyConsumeList",
               cache: false,  //禁用缓存
               data: energyConsumeParamTable,  //传入组装的参数
               dataType: "json",
               async:false,
               success: function (result) {
                  consumeNum=result.total;
                }
           });
	    	return consumeNum;
	    }      
	  </script>
	<script type="text/javascript">
    	//加载供电地点：实际加载该商户下所有的园区
    	function getSupplyLocationAll(){
    		var b=0;
	      	$.ajax({
	           type: "POST",
	           url: "rest/rbac/MerchantRegistFlowController/getSupplyLocationAll", 
	           data:energyConsumeParam,
	           cache: false,  //禁用缓存
	           dataType: "json",
	           async:false,
	           success: function (result) {
	      	   $("#supplyLocationQuery").html(""); 	
	      	    $("#supplyLocationQuery").append("<option value='0'>请选择</option>");	   	       			
	           	for(var i=0;i<result.data.length;i++){
	            		$("#supplyLocationQuery").append("<option value='"+result.data[i].park_Id+"'>"+result.data[i].park_Name+"</option>");
	           	}
	           	b=result.data.length;
	          },
	           error:function(){	            	
	          	}
	      	});
	      	return b;
    }
    //加载供电地点：过滤掉已经配置过的园区
    	function getSupplyLocation(){
    		var  a=0;
      	$.ajax({
           type: "POST",
           url: "rest/rbac/MerchantRegistFlowController/getSupplyLocation", 
           data:energyConsumeParam,
           cache: false,  //禁用缓存
           dataType: "json",
           async:false,
           success: function (result) {
      	   $("#supplyLocationConsume").html(""); 
      	   $("#supplyLocationConsume").append("<option value='0'>请选择</option>");		
           	for(var i=0;i<result.data.length;i++){
            		$("#supplyLocationConsume").append("<option value='"+result.data[i].park_Id+"'>"+result.data[i].park_Name+"</option>");
           	}
           	a=result.data.length;
          },
           error:function(){	            	
          	}
      	});
      	return a;
    }
    function energyConsumeDialog(e) {
        	var dialog = $("#powerInfoEdit").removeClass('hide').dialog({
	            modal: true,
	            width: 900,
	            title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>用电信息配置</h4></div>",
	            title_html: true,
	            buttons: [
	                {
	                    text: "关闭",
	                    "class": "btn btn-xs",
	                    click: function () {
	                        $(this).dialog("close");
	                    }
	                }
	            ]
        });
    }
    	//添加或编辑用户信息弹出框
	    function consumeDialog(e) {
        	var dialog = $("#consumeDialog").removeClass('hide').dialog({
	            modal: true,
	            width: 600,
	            title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>商户用电信息</h4></div>",
	            title_html: true,
	            buttons: [
	                {
	                    text: "取消",
	                    "class": "btn btn-xs",
	                    click: function () {
	                        $(this).dialog("close");
	                    }
	                },
	                {
	                    text: "保存",
	                    "class": "btn btn-primary btn-xs",
	                    click: function () {								
								/*if($("#supplyLocationConsume").val()==""||$("#supplyLocationConsume").val()==null||$("#supplyLocationConsume").val()==0){
									  parent.bootbox.alert("请选择供电地点！")
									  return;
								}else{
									energyConsumeParam.supply_Location = $("#supplyLocationConsume").val();//parkId，根据parkId后台获取该园区的地址
									energyConsumeParam.park_Id=$("#supplyLocationConsume").val();
								}	*/
								energyConsumeParam.park_Id=$("#park_Id:checked").val();
								if($("#voltageClassConsume").val()==""||$("#voltageClassConsume").val()==0){
									  parent.bootbox.alert("请选择电压等级！")
									  return;
								}else{
									energyConsumeParam.voltage_Class = $("#voltageClassConsume").val();
								}
								if($("#energyPropertyConsume").val()==""||$("#energyPropertyConsume").val()==0){
									  parent.bootbox.alert("请选择用电性质！")
									  return;
								}else{
									 energyConsumeParam.energy_Property=$("#energyPropertyConsume").val();
								}
								if($("#priceModeConsume").val()==""||$("#priceModeConsume").val()==0||$("#priceModeConsume").val()==null){
									  parent.bootbox.alert("请选择电价方式！")
									  return;
								}else{
									energyConsumeParam.price_Mode=$("#priceModeConsume").val();
								}
								var nums=/^[0-9]+(.[0-9]{1,3})?$/;
						    	if($("#volumeConsume").val()==""){
								    merchant.volume=0;
							    }else if(!nums.exec($("#volumeConsume").val())) {
								    parent.bootbox.alert("容量应该为数字。");
								    return;
								}else{
								   	energyConsumeParam.volume=$("#volumeConsume").val();
								}
								
								if($("#catalogPriceConsume").val()==""){
								     parent.bootbox.alert("请填写目录电价");
								     return;
							    }else if(!nums.exec($("#catalogPriceConsume").val())) {
								     parent.bootbox.alert("目录电价应该为数字。");
								     return;
								}else{
								   	energyConsumeParam.catalog_Price = $("#catalogPriceConsume").val();
								}
								
								if($("#capacityPriceConsume").val()==""){
								      merchant.capacity_Price=0;
							    }else if(!nums.exec($("#capacityPriceConsume").val())) {
								     parent.bootbox.alert("容量电价应该为数字。");
								     return;
								}else{
								   	energyConsumeParam.capacity_Price = $("#capacityPriceConsume").val();
								}
								
								if($("#peakPriceConsume").val()==""){
								      merchant.peak_Price=0;
							    }else if(!nums.exec($("#peakPriceConsume").val())) {
								     parent.bootbox.alert("峰电价应该为数字。");
								     return;
								}else{
								   	energyConsumeParam.peak_Price=$("#peakPriceConsume").val();
								}
								
								if($("#valleyPriceConsume").val()==""){
								     merchant.valley_Price=0;
							    }else if(!nums.exec($("#valleyPriceConsume").val())) {
								     parent.bootbox.alert("谷电价应该为数字。");
								     return;
								}else{
								   	energyConsumeParam.valley_Price=$("#valleyPriceConsume").val();
								}
						         
						        if($("#flatPriceConsume").val()==""){
								     merchant.flat_Price=0;
							    }else if(!nums.exec($("#flatPriceConsume").val())) {
								     parent.bootbox.alert("平电价应该为数字。");
								     return;
								}else{
								   	energyConsumeParam.flat_Price=$("#flatPriceConsume").val();
								}
	                        if (thisid == "btnAddConsume") {
		 						addEnergyConsume(energyConsumeParam);		 						
	                        }
	                        if (thisid == "btnEditConsume") {
								updateEnergyConsume(energyConsumeParam);
	                        }
	                    }
	                }
	            ]
        });
    }
  
    //添加商户用电信息
    function addEnergyConsume(){
		$.ajax({
  	            url:'rest/rbac/MerchantRegistFlowController/addEnergyConsume',
  	            data: energyConsumeParam,
  	            type: 'POST',
  	            dataType: 'json',
  	            async: false,
  	            success: function (result) {
  	            	if(result.result== "success"){
	                	parent.bootbox.alert("用电信息配置成功！");
	                	$( "#consumeDialog" ).dialog( "close" );
	                	//energyConsumeParam.park_Id=result.data;
	                	energyConsumeParamTable.organId=$("#merchantId").val();
	                	loadEnergyConsumeTable();
                	}
  	            },
  	            error: function(){
  	                parent.bootbox.alert("系统错误！园区信息配置失败。请刷新重新操作。", function(){});
  	            }
  	        });	
    }
    //获取用户信息
		function getEnergyConsumeInfo(e){
		$.ajax({
            url: 'rest/rbac/MerchantRegistFlowController/getEnergyConsumeInfo',
            data: energyConsumeParam,
            async: false,
            type: 'POST',
            dataType: 'json',
            success: function (result) {
            	consumeDialog(e);
 	            $("#supplyLocationConsume").val(result.data.park_Id);
				$("#voltageClassConsume").val(result.data.voltage_Class);
			    $("#energyPropertyConsume").val(result.data.energy_Property);
				$("#volumeConsume").val(result.data.volume);
				$("#priceModeConsume").val(result.data.price_Mode);
				$("#capacityPriceConsume").val(result.data.capacity_Price);
				$("#catalogPriceConsume").val(result.data.catalog_Price);
			    $("#peakPriceConsume").val(result.data.peak_Price);
				$("#flatPriceConsume").val(result.data.flat_Price);
				$("#valleyPriceConsume").val(result.data.valley_Price);
   	        },
   	        error: function(){
   	            parent.bootbox.alert("系统错误！获取用户用电信息失败。请刷新重新操作。", function(){});
   	        }
   	    });
	}
	//更新园区信息
	function updateEnergyConsume(energyConsumeParam){
		$.ajax({
  	            url:'rest/rbac/MerchantRegistFlowController/updateEnergyConsume',
  	            data: energyConsumeParam,
  	            type: 'POST',
  	            dataType: 'json',
  	            async: false,
  	            success: function (result) {
  	            	if(result.result== "success"){
	                	parent.bootbox.alert("用电信息更新成功！");
                		$( "#consumeDialog" ).dialog( "close" );
                		//energyConsumeParam.park_Id=result.data;
                		energyConsumeParamTable.organId=$("#merchantId").val();
                		loadEnergyConsumeTable();
                	}
  	            },
  	            error: function(){
  	                parent.bootbox.alert("系统错误！用电信息更新失败。请刷新重新操作。", function(){});
  	            }
  	        });	
	     }
	      //删除用户用电信息
	 	function deleteConsume(){
	 		 energyConsumeParam.parkIds=[];    
				parent.bootbox.confirm("你确定要删除用户用电信息吗？", function(result) {
				if(result){				
					for(var i=0;i<$("#park_Id_Consume:checked").length;i++){
		        		energyConsumeParam.parkIds[i]=$("#park_Id_Consume:checked")[i].defaultValue;
		        	}
						$.ajax({
		    	            url: 'rest/rbac/MerchantRegistFlowController/delEnergyConsume',
		    	            async: false,
		    	            data:  energyConsumeParam,
		    	            type: 'POST',
		    	            dataType: 'json',
		    	            success: function (result) { 
		    	            	if(result.result == "success"){
			    	            	parent.bootbox.alert("用户用电信息删除成功！");
			    	            	delete energyConsumeParam.parkIds;
			    	            	energyConsumeParamTable.organId=$("#merchantId").val();
			    	            	loadEnergyConsumeTable();
			    	             }
		    	            },
		    	            error: function(){
		    	            	parent.bootbox.alert("用户用电信息删除失败！", function(){});
		    	            }
			   	        });	   	       
				    }
			  });
		}
    </script>
	<script type="text/javascript">
	　　function CheckBankNo() {
	  　　var bankno =$("#bankAccount").val();
	  　/* 　if(bankno == "") {
	    　　parent.bootbox.alert("请填写银行卡号！");
	     return false;
	   } */
	   if(bankno != "") {
		   if(bankno.length < 16 || bankno.length > 23) {
		     parent.bootbox.alert("请填写正确的银行账户！");
		     return false;
		   }
		   var num = /^\d*$/; //全数字
		   if(!num.exec(bankno)) {
		     parent.bootbox.alert("银行卡号必须全为数字");
		     return false;
		   }
		   //开头6位
		   var strBin = "10,18,30,35,37,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,58,60,62,65,68,69,84,87,88,94,95,98,99";
		   if(strBin.indexOf(bankno.substring(0, 2)) == -1) {
		      parent.bootbox.alert("银行卡号开头6位不符合规范");
		     return false;
		   }
	   }
	   //Luhm校验（新）
	   /*if(!luhmCheck(bankno))
	     return false;
	     $("#banknoInfo").html("验证通过!");
	     return true;*/
	   }
</script>
	<script type="text/javascript">
	function openWin(){
		window.open ("http://api.map.baidu.com/lbsapi/getpoint/index.html", "newwindow", "height=650, width=1200, top=200, left=300,toolbar=no, menubar=no, scrollbars=no, resizable=yes, location=n o, status=no");  
	}
</script>
</body>
</html>
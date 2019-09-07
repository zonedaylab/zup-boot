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
		<title>商户管理</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	    
	    <!--	引入外部样式库css	-->
	    <jsp:include page="../include/mainHead.jsp"></jsp:include>
	    <!--        定义适应屏幕的css样式 -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <style type="text/css">
	        @media (max-width:992px){
				#merchantTypeQuery{
					margin-top:15px;
				}
				#POSITIONDEPRESS{
					margin-top:15px;
				}			
			}
		    @media (min-width:970px){
				.col-md-1_3{
					width:13%
				}
				.col-md-8_45{
					width:84.5%
				}
			}
        </style>
	<link rel="stylesheet" type="text/css" href="plug-in\ace\main\esale\new_css\esale-new-style.css"/>
</head>
<body style="background-color:#FFFFFF; overflow-x : hidden ;">
	<!-- 左侧数型图和查询条件 -->
    <div class="row">
		<div class="col-sm-12 col-xs-12 col-lg-12 widget-body">

<div class="row center center-block" style="margin-top:20px;">
<div class="container">
<div class="row clearfix">
<div class="col-md-12 col-xs-12 column">
<form class="form-horizontal" role="form">
<div class="form-group">
<label for="merchantNameQuery" class="col-xs-5 col-md-2 control-label" style="text-align: right; height:25px" >商户姓名：</label>
<div class="col-xs-4 col-md-3"> 
<input type="text" class="form-control" id="merchantNameQuery" />
</div>
<label for="merchantTypeQuery" class="col-xs-5 col-md-2 control-label" id="POSITIONDEPRESS" style="text-align: right" >商户类别：</label>
<div class="col-xs-4 col-md-3">
<select id="merchantTypeQuery" class="form-control" >
<option value="">&nbsp;</option>
</select>
</div>
<div class="col-md-2 col-xs-3" style=" position:absolute; right:30px; top:0px">
<button class="btn btn-sm btn-primary" type="button" id="search"><i class="icon-ok"></i>查询</button>
</div>
</div>

<div class="form-group">
<label for="tradeFlagQuery" class="col-xs-5 col-md-2 control-label" style="text-align: right" >交易资格：</label>
<div class="col-xs-4 col-md-3">
<input type="text" class="form-control" id="tradeFlagQuery" />
</div>
</div>

</form>
</div>
</div>
</div>
</div>
			<!-- 查询条件结束 -->
			<div class="table-header">商户信息</div>
			<div class="row">
				<div class="col-md-12" style="height:30px; margin-bottom:11px; margin-top:6px; margin-left: 6px;">
					
					<button class="btn btn-primary btn-sm" id="btnDetail">查看详情</button>
					<button class="btn btn-primary btn-sm" id="btnEdit">编辑</button>
					<button class="btn btn-primary btn-sm hide" id="btnCheck">审核 </button>
					
					 
					<button class="btn btn-primary btn-sm" id="btnLinkMan">联系人管理</button>					
					<button class="btn btn-primary btn-sm" id="btnEnergyPark">园区信息管理</button>
					
					<button class="btn btn-primary btn-sm" id="btnDelete">删除</button>
				</div>
				<div class="col-md-7"></div>
			</div>
			<div class="table-responsive">
				<table id="merchantTable" class="table table-striped table-bordered table-hover"  style="margin-bottom:20px;">
					<thead>
						<tr>
							<th>
								<label>
									<input type="checkbox" class="ace" id="allCheckMerchant" />
									<span class="lbl"></span>
								</label>
							</th>
							<th>
								商户名称
							</th>
							<th>
								商户类别
							</th>							
							<th>
								注册资本（万元）
							</th>
							<th>
								用电性质
							</th>
							<th>
								交易资格
							</th>
							<th>
								开户银行
							</th>
							<th>
								银行账户
							</th>
							<th>
								商户地址
							</th>
							<th>
								三证合一号
							</th>
							<th>
								审核标志
							</th>
							<th>
								注册日期
							</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
    <!--商户信息弹出框放置位置  添加 删除  查看详情-->
		 <div  style="margin-top:20px;" id="merchantDialog" class="hide">
            <div class="container" align="left">
                 <form class="form-horizontal" >
                     <div class="form-group" align="left">
	                     <div class="col-xs-12 col-md-4 hide">
	                          <label for="" class="col-xs-5 col-md-5 control-label"style="text-align: right;height: 25px;">所属公司:</label>
	                          <div class="col-xs-6 col-md-6" align="left">
	                              <select id="organId"  class="form-control" style="height: 35px" ></select>
	                          </div>
	                         <div class="col-xs-1 col-md-1" style="margin-top: 2%;  margin-left: -1%;">
								<font color=red>*</font>
						  	 </div>
	                      </div>                      
	                      <div class="col-xs-12 col-md-4">
	                      	 <label for="" class="col-xs-5 col-md-5 control-label"style="text-align: right;height: 25px;letter-spacing:2px;">商户类别:</label>
	                         <div class="col-xs-6 col-md-6" align="left">
	                              <select id="merchantType"class="form-control"style="height: 35px"></select>
	                         </div>
	                         <div class="col-xs-1 col-md-1" style="margin-top: 2%;  margin-left: -1%;">
								<font color=red>*</font>
						  	 </div>
	                      </div>
	                      <div class="col-xs-12 col-md-4  xsmt15">
	                      	 <label for="" class="col-xs-5 col-md-5 control-label"style="text-align: right;height: 25px;">商户规模:</label>
	                         <div class="col-xs-6 col-md-6" align="left">
	                             <select id="merchantScale"class="form-control"style="height: 35px"></select>
	                         </div>
                      	 </div>
	                      <div class="col-xs-12 col-md-4 hide">
	                      	<label for="" class="col-xs-5 col-md-5 control-label"style="text-align: right;height: 25px;">商户Id:</label>
	                        <div class="col-xs-6 col-md-6" align="left">
	                              <input type="text" id="merchantId"  class="form-control" placeholder="保存时自动生成" readonly="readonly"/>
	                        </div>
	                      </div>
	                      <div class="col-xs-12 col-md-4 hide">
	                      	<label for="" class="col-xs-5 col-md-5 control-label"style="text-align: right;height: 25px;letter-spacing: 3.2px;">园区Id:</label>
	                        <div class="col-xs-6 col-md-6" align="left">
	                              <input type="text" id="energyParkId"  class="form-control" placeholder="保存时自动生成" readonly="readonly"/>
	                        </div>
	                      </div>
                     </div>
                     <div class="form-group" align="left">
                      	<div class="col-xs-12 col-md-4">
                      		 <label for="" class="col-xs-5 col-md-5 control-label"style="text-align: right;height: 25px;letter-spacing:2px;">商户名称:</label>
	                         <div class="col-xs-6 col-md-6" align="left">
	                             <input type="text" id="merchantName"  class="form-control" />
	                         </div>
	                         <div class="col-xs-1 col-md-1" style="margin-top: 2%;  margin-left: -1%;">
								<font color=red>*</font>
						  	 </div>
                      	</div>
                      	<div class="col-xs-12 col-md-4 xsmt15">
	                      	 <label for="" class="col-xs-5 col-md-5 control-label"style="text-align: right;height: 25px;">行业类别:</label>
	                         <div class="col-xs-6 col-md-6" align="left" >
	                             <select id="industryCategory"class="form-control"style="height: 35px">
	                                 <option value="0"></option>
	                             </select>
	                         </div>
                      	</div>
                      	
                      	<div class="col-xs-12 col-md-4 xsmt15">
	                      	 <label for="" class="col-xs-5 col-md-5 control-label"style="text-align: right;height: 25px;">用电性质:</label>
	                         <div class="col-xs-6 col-md-6" align="left">
	                             <select id="energyProperty"class="form-control" style="height: 35px"></select>
	                         </div>
	                         <div class="col-xs-1 col-md-1" style="margin-top: 2%;  margin-left: -1%;">
								<font color=red>*</font>
						  	 </div>
                      	  </div>
                      	
                     </div>
                     <div class="form-group"align="left">
                      	<div class="col-xs-12 col-md-4">
                      		 <label for="" class="col-xs-5 col-md-5 control-label"style="text-align: right;height: 25px;letter-spacing:2px;">企业法人:</label>
	                         <div class="col-xs-6 col-md-6" align="left">
	                             <input type="text" id="legalPerson"  class="form-control" />
	                         </div>
                      	</div>
                      	<div class="col-xs-12 col-md-4 xsmt15">
	                      	 <label for="" class="col-xs-5 col-md-5 control-label"style="text-align: right;height: 25px;">注册资本:</label>
	                         <div class="col-xs-6 col-md-6" align="left">
	                             <input type="text" id="regCapital"  class="form-control" />
	                         </div>
                      	</div>
                      	
                      	<div class="col-xs-12 col-md-4 xsmt15">
                      		 <label for="" class="col-xs-5 col-md-5 control-label"style="text-align: right;height: 25px;">信用等级:</label>
	                         <div class="col-xs-6 col-md-6" align="left">
	                             <select id="credit"class="form-control"style="height: 35px"></select>
	                         </div>
	            
                      	</div>
                     </div>
                     <div class="form-group"align="left">
                      	
                      	<div class="col-xs-12 col-md-4">
                      		<label for="" class="col-xs-5 col-md-5 control-label"style="text-align: right;height: 25px;letter-spacing:6px;">传&nbsp;&nbsp;真:</label>
	                         <div class="col-xs-6 col-md-6" align="left">
	                             <input type="text" id="fax"  class="form-control" />
	                         </div>
                      	</div>
                      	<div class="col-xs-12 col-md-4 xsmt15">
                      		<label for="" class="col-xs-5 col-md-5 control-label"style="text-align: right;height: 25px;">邮政编码:</label>
	                         <div class="col-xs-6 col-md-6" align="left">
	                             <input type="text" id="postcode"  class="form-control" />
	                         </div>
                      	</div>
                      	<div class="col-xs-12 col-md-4 xsmt15">
                      		 <label for="" class="col-xs-5 col-md-5 control-label"style="text-align: right;height: 25px;">企业公众号:</label>
	                         <div class="col-xs-6 col-md-6" align="left">
	                             <input type="text" id="publicNumber"  class="form-control" />
	                         </div>
                      	</div>
                     </div>
                     <div class="form-group"align="left">
                      	<div class="col-xs-12 col-md-4">
                      		<label for="" class="col-xs-5 col-md-5 control-label"style="text-align: right;height: 25px;letter-spacing:2px;">开户银行:</label>
	                         <div class="col-xs-6 col-md-6" align="left">
	                             <input type="text" id="depositBank"  class="form-control" />
	                         </div>
	                  
                      	</div>
                      	<div class="col-xs-12 col-md-4 xsmt15">
                      		 <label for="" class="col-xs-5 col-md-5 control-label"style="text-align: right;height: 25px;">银行账户:</label>
	                         <div class="col-xs-6 col-md-6" align="left" >
	                             <input type="text" id="bankAccount"  class="form-control" placeholder="16、18-21位"/>
	                         </div>
	                        
                      	</div>
                      	<div class="col-xs-12 col-md-4 xsmt15">
	                      	<label for="" class="col-xs-5 col-md-5 control-label"style="text-align: right;height: 25px;">开户名称:</label>
	                        <div class="col-xs-6 col-md-6" align="left">
	                             <input type="text" id="accountName"  class="form-control" />
	                        </div>
	                       
                      	</div>
                     </div>
                     <div class="form-group"align="left">
                     	<div class="col-xs-12 col-md-4">
                      		 <label for="" class="col-xs-5 col-md-5 control-label" style="text-align: right;height: 25px;">三证合一号:</label>
	                         <div class="col-xs-6 col-md-6" align="left">
	                             <input type="text" id="regNumber"  class="form-control" placeholder="18位"/>
	                         </div>
	                         <div class="col-xs-1 col-md-1" style="margin-top: 2%;  margin-left: -1%;">
								<font color=red>*</font>
						  	 </div>
                      	</div>
                      	<div class="col-xs-12 col-md-4 xsmt15">
	                      	 <label for="" class="col-xs-5 col-md-5 control-label"style="text-align: right;height: 25px;">公司邮箱:</label>
	                         <div class="col-xs-6 col-md-6" align="left">
	                             <input type="text" id="email"  class="form-control" />
	                         </div>
                      	</div>
                      	<div class="col-xs-12 col-md-4 xsmt15">
                      		 <label for="" class="col-xs-5 col-md-5 control-label"style="text-align: right;height: 25px;">联系电话:</label>
	                         <div class="col-xs-6 col-md-6" align="left">
	                             <input type="text" id="phone"  class="form-control" />
	                         </div>
	                         <div class="col-xs-1 col-md-1" style="margin-top: 2%;  margin-left: -1%;">
								<font color=red>*</font>
						  	 </div>
                      	</div>                      	 
                     </div>
                     <div class="form-group"align="left">
                     	<div class="col-xs-12 col-md-4">
                      		<label for="" class="col-xs-5 col-md-5 control-label"style="text-align: right;height: 25px;">地址:（省）</label>
                      		<div class="col-xs-6 col-md-6" align="left">
                              <select id="province"class="form-control"style="height: 35px"></select>
                         	</div>
                         	<div class="col-xs-1 col-md-1" style="margin-top: 2%;  margin-left: -1%;">
								<font color=red>*</font>
						  	 </div>
                      	</div>
                      	<div class="col-xs-12 col-md-4 xsmt15">                             	 
                         	<label for="" class="col-xs-5 col-md-5 control-label"style="text-align: right;height: 25px;">（市）:</label>
                         	<div class="col-xs-6 col-md-6" align="left">
                              <select id="city"class="form-control"style="height: 35px"></select>
                         	</div>
                         	<div class="col-xs-1 col-md-1" style="margin-top: 2%;  margin-left: -1%;">
								<font color=red>*</font>
						  	 </div>
                      	</div>
                      	<div class="col-xs-12 col-md-4 xsmt15">
                      	 	<label for="" class="col-xs-5 col-md-5 control-label"style="text-align: right;height: 25px;">（县）:</label>
                      	 	<div class="col-xs-6 col-md-6" align="left">
                              <select id="county"class="form-control"style="height: 35px"></select>
                         	</div>
                         	<div class="col-xs-1 col-md-1" style="margin-top: 2%;  margin-left: -1%;">
								<font color=red>*</font>
						  	 </div>
                      	 </div>
                     </div>
                     <div class="form-group" align="left">
                      	<div class="col-xs-12">
                        	<label  class="col-xs-5 col-md-1_3 control-label"style="text-align: right;height: 25px;letter-spacing:2px;">详细地址:</label>
                        	<div class="col-xs-6 col-md-8_45" align="left">
	                             <input type="text" id="address"  class="form-control escel-xxdz"/>
	                         </div>
	                      
                        </div>
                     </div>
                     <div class="form-group"align="left">
                      	 <div class="col-xs-12 col-md-4 hide">
	                      	 <label for="" class="col-xs-5 col-md-5 control-label"style="text-align: right;height: 25px;">交易资格:</label>
	                         <div class="col-xs-6 col-md-6" align="left">
	                             <input id="tradeFlag"class="form-control"style="width: 125px;" readonly="readonly"/>
	                         </div>
                      	 </div>
                      	  <div class="col-xs-12 col-md-4">
	                      	 <label for="" class="col-xs-5 col-md-5 control-label" style="text-align: right;height: 25px;letter-spacing:6px;">登记人:</label>
	                         <div class="col-xs-6 col-md-6" align="left">
	                             <input type="text" id="regName"  class="form-control" readonly="readonly"/>
	                         </div>
                      	  </div>
                      	  <div class="col-xs-12 col-md-4 xsmt15">
	                      	  <label for="" class="col-xs-5 col-md-5 control-label" style="text-align: right;height: 25px;">登记日期:</label>
	                         <div class="col-xs-6 col-md-6" align="left">
	                             <input type="text" id="regTime"  class="form-control" readonly="readonly"/>
	                         </div>
                      	  </div>
                     </div>
                     </form>
                      <div  class="row">
                       	<div class="col-md-12" style="height:30px; margin-bottom:10px; margin-top:5px;">
                        	
                        	<div class="col-md-4"  style="float:right;display:none" id="btnUpdateDiv"><button class="btn btn-primary btn-sm"  id="btnUpdate" >保存</button></div>
                        	<div class="col-md-4"  style="float:right;display:none;" id="btnCheckPassDiv"><button class="btn btn-primary btn-sm"  id="btnCheckPass">审核通过</button></div>
                        	<div class="col-md-4" style="float:right" ><button class="btn btn-primary btn-sm"  id="btnCancle">取消</button></div>
				        </div>
				     </div>
            	</div>
        </div>
    <!--联系人弹出框放置位置  -->
   <div class="hide" id="fromEdit">
		<div class="">
            <div class="table-header">联系人信息</div>
        </div>
		<div class="col-sm-12 col-xs-12 col-lg-12 widget-body">
			<div class="row">
				<div class="col-md-12" style="height:30px; margin-bottom:10px; margin-top:5px;">
					<button class="btn btn-primary btn-sm" id="btnAddLinkMan">添加</button>
					<button class="btn btn-primary btn-sm" id="btnEditLinkMan">编辑</button>					
					<button class="btn btn-primary btn-sm" id="btnDeleteLinkMan">删除</button>
				</div>
				<div class="col-md-7"></div>
			</div>
			<div class="row">
			<div class="table-responsive"><!-- style="margin-left: 2%;"-->
				<table id="linkManTable" class="table table-striped table-bordered table-hover"  style="margin-bottom:20px; ">
					<thead>
						<tr>
							<th>
								<label>
									<input type="checkbox" class="ace" id="allCheckLinkMan" />
									<span class="lbl"></span>
								</label>
							</th>
		                    <th>
		                        	联系人姓名
		                    </th>
		                    <th>
		                       	 	联系电话
		                    </th>
		                    <th>
		                        	手机号码
		                    </th>
		                    <th>
		                       		 传真
		                    </th>
		                    <th>
		                        	邮件
		                    </th>
		                    <th>
		                        	职务
		                    </th>
		                    <th>
		                        	地址
		                    </th>
		                    <th>
		                        	微信号
		                    </th>
		                    <th>
		                       		 备注
		                    </th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
			</div>
		</div>
		
	</div>
	 <!--联系人弹出框放置位置  增删查改-->
	<div class="hide" align="left" id="linkManDialog">
        <form class="form-horizontal" role="form">
            <div class="form-group">
            	<div class="col-xs-12 col-md-12">
	                <label for="projectNameForm" class="col-sm-5  col-xs-5 col-md-5 control-label" style="text-align: right" >联系人姓名：</label>
	                <div class="col-sm-6 col-xs-6 col-md-6">
	                    <input class="form-control" id="linkmanName" type="text" />
	                </div>
	                <div class="col-xs-12 col-md-1" style="margin-top: 2%; margin-left: -5%;">
						<font color=red>*</font>
					</div>
              	</div>
            </div>
            <div class="form-group">
                <div class="col-xs-12 col-md-12">
		            <label for="linkMan" class="col-sm-5  col-xs-5 col-md-5 control-label" style="text-align: right; letter-spacing: 3.1px;" >手机号码：</label>
	                <div class="col-sm-6 col-xs-6 col-md-6">
	                    <input class="form-control" id="mobilePhone" type="text" />
	                </div>
	                 <div class="col-xs-12 col-md-1" style="margin-top: 2%; margin-left: -5%;">
						<font color=red>*</font>
					</div>
               </div>
            </div>
            <div class="form-group">
            	<div class="col-xs-12 col-md-12">
	               	<label for="linkPhone" class="col-sm-5  col-xs-5 col-md-5 control-label" style="text-align: right" >邮&nbsp;&nbsp;&nbsp;箱：</label>
	                <div class="col-sm-6 col-xs-6 col-md-6">
	                     <input class="form-control" id="emails" type="text" />
	                </div>
               </div>
            </div>
            <div class="form-group">
                <div class="col-xs-12 col-md-12">
                     <label for="projectPlace" class="col-sm-5  col-xs-5 col-md-5 control-label" style="text-align: right" >地&nbsp;&nbsp;&nbsp;址：</label>
                     <div class="col-sm-6 col-xs-6 col-md-6">
                         <input class="form-control" id="addresss" type="text" />
                     </div>
                      <div class="col-xs-12 col-md-1" style="margin-top: 2%; margin-left: -5%;">
						<font color=red>*</font>
					</div>
                </div>
            </div>
            <div class="form-group">
                <div class="col-xs-12 col-md-12">
                	  <label for="contractorUnit" class="col-sm-5  col-xs-5 col-md-5 control-label" style="text-align: right;letter-spacing: 3.1px;" >联系电话：</label>
	                  <div class="col-sm-6 col-xs-6 col-md-6">
	                      <input class="form-control" id="phones" type="text" />
	                  </div>
                </div>
            </div>
            <div class="form-group">
                <div class="col-xs-12 col-md-12">
                    <label for="register" class="col-sm-5  col-xs-5 col-md-5 control-label" style="text-align: right" >传&nbsp;&nbsp;&nbsp;真：</label>
	                	<div class="col-sm-6 col-xs-6 col-md-6">
	                         <input class="form-control" id="faxs" type="text" />
	                    </div>
                </div>
            </div>
            <div class="form-group">
               	<div class="col-xs-12 col-md-12">
               		<label for="registerName" class="col-sm-5  col-xs-5 col-md-5 control-label" style="text-align: right" >职&nbsp;&nbsp;&nbsp;务：</label>
                    <div class="col-sm-6 col-xs-6 col-md-6">
                        <input class="form-control" id="post" type="text" />
                    </div>
                 </div>
            </div>
            <div class="form-group">
                 <div class="col-xs-12 col-md-12">
                 	<label for="registDate" class="col-sm-5  col-xs-5 col-md-5 control-label" style="text-align: right;letter-spacing: 7px;" >微信号：</label>
                    <div class="col-sm-6 col-xs-6 col-md-6">
                         <input class="form-control" id="wechatNum" type="text" />
                    </div>
                     <div class="col-xs-12 col-md-1" style="margin-top: 2%; margin-left: -5%;">
						<font color=red>*</font>
					</div>
                 </div>
           </div>
           <div class="form-group">
	           	<div class="col-xs-12 col-md-12">
	            	<label for="registerName" class="col-sm-5  col-xs-5 col-md-5 control-label" style="text-align: right;" >备&nbsp;&nbsp;&nbsp;注：</label>
	               <div class="col-sm-6 col-xs-6 col-md-6">
	                   <textarea class="form-control" id="memo" style="width:138px;height:60px;" ></textarea>
	               </div>
	            </div>
           </div>
        </form>
     </div>
	 <!-- 园区 弹出框放置位置  -->
	<div class="hide" id="energyPark">
		<div class="">
            <div class="table-header" >商户园区信息</div>
        </div>
		<div class="col-sm-12 col-xs-12 col-lg-12 widget-body">
			<div class="row">
				<div class="col-md-12" style="height:30px; margin-bottom:10px; margin-top:5px;">
					<button class="btn btn-primary btn-sm" id="btnAddEnergyPark">添加</button>
					<button class="btn btn-primary btn-sm" id="btnEditEnergyPark">编辑</button>					
					<button class="btn btn-primary btn-sm" id="btnDeleteEnergyPark">删除</button>
					<button class="btn btn-primary btn-sm" id="btnConsumeManage">用能信息管理</button>
				</div>
				<div class="col-md-7"></div>
			</div>
			<div class="table-responsive" style="margin-left: 1%;">
				<table id="energyInfoTable" class="table table-striped table-bordered table-hover"  style="margin-bottom:20px;">
					<thead>
						<tr>
							<th>
								<label>
									<input type="checkbox" class="ace" id="allCheckEnergyInfo" />
									<span class="lbl"></span>
								</label>
							</th>
							<th>
								园区名称
							</th>
							<th>
								园区类型
							</th>							
							<th>
								园区地址
							</th>
							<th>
								对应电网企业
							</th>
							<th>
								园区经度
							</th>
							<th>
								园区维度
							</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<!--园区弹出框放置位置  增删查改-->
	<div class="hide " style="margin-top:20px;" id="energyParkDialog">
            <div class="container" align="left">
            	<form class="form-horizontal" role="form">
                  <div class="form-group">
                  	<div class="col-xs-12 col-md-12 hide">
                      <label for="projectNameForm" class="col-sm-4  col-xs-4 col-md-4 control-label" style="text-align: right;letter-spacing:5px;" >商户名称：</label>
                      <div class="col-sm-5 col-xs-5 col-md-5">
                          <input class="form-control" id="merchantNameEnergyParkDialog" type="text" readonly="readonly"/>
                      </div>
                    </div>
                    </div>
                      <div class="form-group">
                    <div class="col-xs-12 col-md-12">
                    	<label for="linkMan" class="col-sm-4  col-xs-4 col-md-4 control-label" style="text-align: right;letter-spacing:5px;" >园区类型：</label>
	                      <div class="col-sm-5 col-xs-5 col-md-5">
	                          <select class="form-control" style="width:100%;height: 35px;" id="parkType">
		                      </select>
                      	   </div>
	                       <div class="col-xs-12 col-md-1" style="margin-top: 2%;  margin-left: -1%;">
						<font color=red>*</font>
					</div>
                     </div>
                  </div>
                  <div class="form-group">
                  	<div class="col-xs-12 col-md-12">
                     	 <label for="linkPhone" class="col-sm-4  col-xs-4 col-md-4 control-label" style="text-align: right;letter-spacing:5px;" >园区名称：</label>
	                      <div class="col-sm-5 col-xs-5 col-md-5">
	                          <input class="form-control" id="parkName" type="text"  />
	                      </div>
	                       <div class="col-xs-12 col-md-1" style="margin-top: 2%; margin-left: -5%;">
						<font color=red>*</font>
					</div>
                     </div>
                     </div>
                      <div class="form-group">
                  	 <div class="col-xs-12 col-md-12">
	                      <label for="projectPlace" class="col-sm-4  col-xs-4 col-md-4 control-label" style="text-align: right;letter-spacing:5px;" >园区地址：</label>
	                      <div class="col-sm-5 col-xs-5 col-md-5">
	                          <textarea class="form-control" id="parkAddress" style="height:60px; " ></textarea>
	                      </div>
	                       <div class="col-xs-12 col-md-1" style="margin-top: 3%; margin-left: -5%;">
						<font color=red>*</font>
					</div>
                     </div>
                   </div>
                   <div class="form-group">
                     <div class="col-xs-12 col-md-12">
                     	<label for="projectPlace" class="col-sm-4  col-xs-4 col-md-4 control-label" style="text-align: right;letter-spacing:5px;">坐标信息:</label>
                        	<div class="col-sm-5 col-xs-5 col-md-5" align="left">
	                             <input type="text" id="latitude" class="form-control"  style="width: 100%;"/>
	                         </div>
	                          <div class="col-xs-12 col-md-1" style="margin-top: 3%; margin-left: -5%;">
									<font color=red>*</font>
								</div>
	                          <div class="col-xs-2 col-md-2">
								<input type="button"  class="form-control"  style="width: 100%;color:#797bc5;margin-left: -5%;" onclick='openWin()' value="获取"/>
							</div>
                     </div>
                  </div>
                   <div class="form-group">
                     <div class="col-xs-12 col-md-12">
                     	<label for="contractorUnit" class="col-sm-4  col-xs-4 col-md-4 control-label" style="text-align: right" >对应电网企业：</label>
	                      <div class="col-sm-5 col-xs-5 col-md-5">
	                          <input class="form-control" id="powerCompany" type="text" />
	                      </div>
	                       <div class="col-xs-12 col-md-1" style="margin-top: 2%; margin-left: -5%;">
						<font color=red>*</font>
						</div>
                     </div>
                  </div>
                </form>
            </div>
        </div>
	<!--用能信息弹出框放置位置-->
	<div class="hide" id="energyConsume">
		<div class="">
            <div class="table-header">商户用电信息管理</div>
        </div>
		<div class="col-sm-12 col-xs-12 col-lg-12 widget-body">
			
			<div class="row">
				<div class="col-md-12" style="height:30px; margin-bottom:10px; margin-top:5px;">
					<button class="btn btn-primary btn-sm" id="btnAddConsume">添加</button>
					<button class="btn btn-primary btn-sm" id="btnEditConsume">编辑</button>					
					<!-- <button class="btn btn-primary btn-sm" id="btnDeleteConsume">删除</button> -->
				</div>
				<div class="col-md-7"></div>
			</div>
			<div class="row">
			<div class="table-responsive" style="margin-left: 1%;">
				<table id="consumeTable" class="table table-striped table-bordered table-hover"  style="margin-bottom:20px; ">
					<thead>
						<tr>
							<th>
								<label>
									<span class="lbl"></span>
								</label>
							</th>
		                    <th style="text-align:center">
		                        	供电地点
		                    </th>
		                    <th style="text-align:center">
		                       	 	电压等级
		                    </th>
		                    <th style="text-align:center">
		                        	用电性质
		                    </th>
		                    <th style="text-align:center">
		                       		 容量（kVA）
		                    </th>
		                    <th style="text-align:center">
		                        	电价方式
		                    </th>
		                    <th style="text-align:center">
		                        	容量电价(元)
		                    </th>
		                    <th style="text-align:center">
		                        	目录电价(元)
		                    </th>
		                    <th style="text-align:center">
		                        	峰电价(元)
		                    </th>
		                    <th style="text-align:center">
		                       		 平电价(元)
		                    </th>
		                    <th style="text-align:center">
		                       		 谷电价(元)
		                    </th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
			</div>
		</div>
		
	</div>
	<!--用能信息弹出框放置位置  增删查改-->
	<div style="margin-top:20px; display:none;" id="consumeDialog">
            <div class="container" align="left">
            	<form class="form-horizontal" role="form">
                  <div class="form-group">
                  	<div class="col-xs-12 col-md-6 hide">
	                      <label class="col-sm-5  col-xs-5 col-md-5 control-label" style="text-align: right" >商户名称：</label>
	                      <div class="col-sm-6 col-xs-6 col-md-6">
	                          <input class="form-control" id="merchantNameConsume" type="text" readonly="readonly" />
	                      </div>
                    </div>
                    <div class="col-xs-12 col-md-6 hide">
                    	<label class="col-sm-5  col-xs-5 col-md-5 control-label" style="text-align: right;" >供电地点：</label>
	                     <div class="col-sm-6 col-xs-6 col-md-6">
	                           <input class="form-control" id="supplyLocationConsume"/>
	                      </div>
	                      <div class="col-xs-1 col-md-1" style="margin-top: 2%;  margin-left: -1%;">
							<font color=red>*</font>
						  </div>
                     </div>
                      <div class="col-xs-12 col-md-6">
	                     	 <label  class="col-sm-5  col-xs-5 col-md-5 control-label" style="text-align: right" >电压等级：</label>
		                      <div class="col-sm-6 col-xs-6 col-md-6">
		                          <select  class="form-control"  id="voltageClassConsume" style="height: 35px;"></select>
		                      </div>
		                      <div class="col-xs-1 col-md-1" style="margin-top: 2%;  margin-left: -1%;">
							<font color=red>*</font>
						  </div>
	                  </div>
	                  <div class="col-xs-12 col-md-6">
                    	<label  class="col-sm-5  col-xs-5 col-md-5 control-label" >电价方式：</label>
	                      <div class="col-sm-6 col-xs-6 col-md-6">
		                      <select class="form-control"  id="priceModeConsume" style="height: 35px">
		                      </select>
	                      </div>
	                      <div class="col-xs-1 col-md-1" style="margin-top: 2%;  margin-left: -1%;">
							<font color=red>*</font>
						  </div>
	                      
                     </div>
                  </div>
                  <div class="form-group">
                  	 <div class="col-xs-12 col-md-6">
	                      <label class="col-sm-5  col-xs-5 col-md-5 control-label" style="text-align: right" >用电性质：</label>
	                      <div class="col-sm-6 col-xs-6 col-md-6">
	                          <select class="form-control"   id="energyPropertyConsume" style="height: 35px"></select>
	                      </div>
	                      <div class="col-xs-1 col-md-1" style="margin-top: 2%;  margin-left: -1%;">
							<font color=red>*</font>
						  </div>
                     </div>
                     <div class="col-xs-12 col-md-6">
                     	<label  class="col-sm-5  col-xs-5 col-md-5 control-label" style="text-align: right;    letter-spacing: 1.5px;" >容量kVA：</label>
	                      <div class="col-sm-6 col-xs-6 col-md-6">
	                          <input class="form-control" id="volumeConsume" type="text" />
	                      </div>
                     </div>
                   </div>
                   <div class="form-group">
                    <div class="col-xs-12 col-md-6">
                     	<label  class="col-sm-5  col-xs-5 col-md-5 control-label" style="text-align: right" >目录电价：</label>
	                      <div class="col-sm-6 col-xs-6 col-md-6">
	                          <input class="NumText" id="catalogPriceConsume" type="text" style="height:34px;width:107px" />
	                      </div>
	                      <div class="col-xs-1 col-md-1" style="margin-top: 2%;  margin-left: -1%;">
							<font color=red>*</font>
						  </div>
                     </div>
                     <div class="col-xs-12 col-md-6">
                     	<label  class="col-sm-5  col-xs-5 col-md-5 control-label" style="text-align: right" >容量电价：</label>
	                      <div class="col-sm-6 col-xs-6 col-md-6">
	                          <input class="form-control" id="capacityPriceConsume" type="text" />
	                      </div>
                     </div>
                  </div>
                  <div class="form-group">
                      <div class="col-xs-12 col-md-6">
                     	<label class="col-sm-5  col-xs-5 col-md-5 control-label" style="text-align: right;letter-spacing: 3px;" >谷电价：</label>
	                      <div class="col-sm-6 col-xs-6 col-md-6">
	                          <input class="form-control" id="valleyPriceConsume" type="text" />
	                      </div>
                     </div>
                   <div class="col-xs-12 col-md-6">
                     	<label  class="col-sm-5  col-xs-5 col-md-5 control-label" style="text-align: right;letter-spacing: 3px;" >平电价：</label>
	                      <div class="col-sm-6 col-xs-6 col-md-6">
	                          <input class="form-control" id="flatPriceConsume" type="text" />
	                      </div>
                     </div>                     
                  </div>
                  <div class="form-group">
                     <div class="col-xs-12 col-md-6">
                     	<label class="col-sm-5  col-xs-5 col-md-5 control-label" style="text-align: right;    letter-spacing: 3px;" >峰电价：</label>
	                      <div class="col-sm-6 col-xs-6 col-md-6">
	                          <input class="form-control" id="peakPriceConsume" type="text" />
	                      </div>
                     </div>
                     <div class="col-xs-12 col-md-6">
                     	<label class="col-sm-11  col-xs-11 col-md-11 control-label" style="text-align: right;    letter-spacing: 3px; color:red;font-size:6px;" >电价单位：元/千瓦时</label>	                      
                     </div>
                 
                    
                  </div>
                </form>
            </div>
        </div>
	<!-- 以下为js放置位置 --> 
	  
    <!--  引入js存放的外部脚本库  -->
	<jsp:include page="../include/mainFooter.jsp"></jsp:include>   
   	<!-- 左侧树形图加载 以及查询数据源数据js -->
   	<script type="text/javascript">
       var merchant={};
      	jQuery(document).ready(function (e) {
      		if(${organType}==2){//2为经营公司；
    			$("#btnCheck").removeClass("hide");
    		}	
      	    findSelectData();
      	    getProvince();
      	    //输入数字，并且可以是小数
      	  	$(function(){ 
	      		$(".NumText").keyup(function(){ 
	      		$(this).val($(this).val().replace(/[^0-9.]/g,'')); 
	      		}).bind("paste",function(){ 
	      		$(this).val($(this).val().replace(/[^0-9.]/g,'')); 
	      		})
      		});
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
	   });
	</script>
	<script type="text/javascript">
	//全选按钮处理
		$("#allCheckMerchant").on('click' , function(){
				var that = this;
				$(this).closest('table').find('tr > td:first-child input:checkbox')
				.each(function(){
					this.checked = that.checked;
					$(this).closest('tr').toggleClass('selected');
				});
		});
		$("#allCheckLinkMan").on('click' , function(){
				var that = this;
				$(this).closest('table').find('tr > td:first-child input:checkbox')
				.each(function(){
					this.checked = that.checked;
					$(this).closest('tr').toggleClass('selected');
				});
		});
		$("#allCheckEnergyInfo").on('click' , function(){
				var that = this;
				$(this).closest('table').find('tr > td:first-child input:checkbox')
				.each(function(){
					this.checked = that.checked;
					$(this).closest('tr').toggleClass('selected');
				});
		});
	</script>
	
	<!-- 按钮的点击操作 -->
	<script type="text/javascript">
      //点击编辑按钮
       $("#btnEdit").on('click',function(){
       		thisid=this.id;
       		if($("#organid:checked").length>1){
       			 parent.bootbox.alert("只能选择一个商户信息进行编辑");
       			 return;
       		}
       		else if($("#organid:checked").length<1){
       			parent.bootbox.alert("请先选择一个商户信息进行编辑");
       			 return;
       		}
       		merchant.organid=$("#organid:checked").val();
       		getEnergyMerchantInfo(thisid);
       });
       
       //点击查看详情按钮
       $("#btnDetail").on('click',function(){
       		thisid=this.id;
       		if($("#organid:checked").length>1){
       			 parent.bootbox.alert("只能查看一个商户信息");
       			 return;
       		}
       		else if($("#organid:checked").length<1){
       			parent.bootbox.alert("请先选择一个商户信息查看详情");
       			 return;
       		}
       		merchant.organid=$("#organid:checked").val();
       		getEnergyMerchantInfo(thisid);
       });
       //删除商户信息
		$( "#btnDelete" ).on('click', function(e) {
			thisid=this.id;
			if($("#organid:checked").length <= 0){
				parent.bootbox.alert("请先选择要删除的商户", function(){});
				return;
			}
			merchant.organid=$("#organid:checked").val();
			getEnergyMerchantInfo(thisid);
			
		});
	//点击审核按钮
		$("#btnCheck").on('click',function(){
	       		thisid=this.id;
	       		if($("#organid:checked").length>1){
	       			 parent.bootbox.alert("只能选择一个商户信息进行审核");
	       			 return;
	       		}
	       		else if($("#organid:checked").length<1){
	       			parent.bootbox.alert("请先选择一个商户信息进行审核");
	       			 return;
	       		}
	       		
	       		merchant.organid=$("#organid:checked").val();
	       		getEnergyMerchantInfo(thisid);
	       });
       //点击审核通过按钮
		$("#btnCheckPass").on('click',function(){
	       		thisid=this.id;
	       		merchant.organid=$("#organid:checked").val();
	       		//判断该商户下 的联系人等信息是否完善
				linkManParam.organid=$("#organid:checked").val();
				if(getLinkManList()==0){//联系人为空
					parent.bootbox.alert("抱歉，联系人信息尚未完善，不能审核通过！");
      			 	return;
				}
	       		//如果是发电商，则不需要判断其下的园区信息
	       		if($("#merchantType").val()!=3){
					energyParkParam.department_Id=$("#organid:checked").val();
					if(getEnergyParkList()==0){
						parent.bootbox.alert("抱歉，园区信息尚未完善，不能审核通过！");
	      			 	return;
					}
					energyConsumeParamTable.organId=$("#organid:checked").val();
					if(getEnergyConsumeList()==0){
						parent.bootbox.alert("抱歉，用能信息尚未完善，不能审核通过！");
	      			 	return;
					}
	       		}
	       		parent.bootbox.confirm("你确定要通过该商户的审核吗？", function(result) {
					if(result){
					     merchant.trade_Flag=1;//有效状态
						 merchant.check_State=1;//已审核
						 merchant.orgainid=$("#organid:checked").val();
						 merchant.flag=2;//标识是审核
						 merchant.reg_Capital=$("#regCapital").val();
						updateMerchant(merchant,thisid);
			        }
			    });
		});
         //点击取消按钮
		$("#btnCancle").on('click',function(){
	       		thisid=this.id;
	       		$("#merchantDialog").dialog("close");
		});
		//点击更新按钮 
		$("#btnUpdate").on('click',function(){
				thisid=this.id;
				merchant.check_State=2;
				if($("#merchantType").val()!=null &&$("#merchantType").val()!=""&&$("#merchantType").val()!=0){
			     	 merchant.merchant_Type=$("#merchantType  option:selected").val();
			     }else{
			     	 parent.bootbox.alert("请选择商户类别");
			     	 return;
			     } 
			     if($("#merchantName").val()!=null &&$("#merchantName").val()!=""&&$("#merchantName").val()!=0){
			     	 merchant.merchant_Name=$("#merchantName").val();
			     }else{
			     	 parent.bootbox.alert("请填写商户名称");
			     	 return;
			     }
			     if($("#energyProperty").val()!=null &&$("#energyProperty").val()!=""&&$("#energyProperty").val()!=0){
			     	   merchant.energy_Property=$("#energyProperty").val();
			     }else if($("#merchantType").val() !=2 ){
			     	 parent.bootbox.alert("请选择用电性质");
			     	 return;
			     }
			     if($("#credit").val()!=null &&$("#credit").val()!=""&&$("#credit").val()!=0){
			     	   merchant.credit=$("#credit").val();
			     }
			     if($("#legalPerson").val()!=null &&$("#legalPerson").val()!=""&&$("#legalPerson").val()!=0){
			     	 merchant.legal_Person=$("#legalPerson").val();
			     }
			     
			    if($("#depositBank").val()!=null &&$("#depositBank").val()!=""&&$("#depositBank").val()!=0){
			     	 merchant.deposit_Bank= $("#depositBank").val();
			     }/* else{
			     	 parent.bootbox.alert("请填写开户银行");
			     	 return;
			     } */
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
			    	 //var regNumberCheck=/^\d{17}[a-zA-Z]{1}$/;
				      // if(!regNumberCheck.exec($("#regNumber").val())) {
					   //  parent.bootbox.alert("三证合一号应该为17位数字加1位字母。");
					    // return;
					  // }else{
					   	merchant.reg_Number= $("#regNumber").val();
					   //}
			     }
			     if($("#phone").val()!=null &&$("#phone").val()!=""&&$("#phone").val()!=0){
			     	  merchant.phone=$("#phone").val();
			     }else{
			     	 parent.bootbox.alert("请填写联系电话");
			     	 return;
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
			    	 merchant.region_Code=$("#county option:selected").val();
			     }
			     if($("#address").val()!=null &&$("#address").val()!=""&&$("#address").val()!=0){
			     	 merchant.address=$("#province option:selected").text()+$("#city option:selected").text()+$("#county option:selected").text()+"*"+$("#address").val();
			     	
			     }	   
			     if($("#regCapital").val()=="")
			     {
			        merchant.reg_Capital=0;
			     }else{
		         	merchant.reg_Capital=$("#regCapital").val();
		         }
			     merchant.fax= $("#fax").val();
			     merchant.postcode=$("#postcode").val();
			     merchant.public_Number=$("#publicNumber").val();
		         merchant.email=$("#email").val();
			     merchant.industry_Category= $("#industryCategory").val();
			     merchant.merchant_Scale=$("#merchantScale").val();
			     merchant.reg_User_Name=$("#regName").val();
			     merchant.orgainid=$("#organid:checked").val();
			     merchant.flag=1;//标识为更新
			     updateMerchant(merchant,thisid);
		}); 
		var linkManParam={};
		//点击联系人管理
		$("#btnLinkMan").on('click',function(){
       		thisid=this.id;
       		if($("#organid:checked").length>1){
	       			 parent.bootbox.alert("只能选择一个商户管理联系人");
	       			 return;
	       	}
	       	else if($("#organid:checked").length<1){
	       			parent.bootbox.alert("请先选择一个商户管理联系人");
	       			 return;
	       	}
	       	linkManParam.organid=$("#organid:checked").val();
	       	fromEditDialog();
	       	loadLinkManTable();
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
     
     //根据选择的商户类别来选择商户规模和用电性质是否可选
 	$("#merchantType").change(function(e){
	      if($("#merchantType").val() ==2) {
	    	  $("#merchantScale").html(""); 
	       	  $("#merchantScale").append("<option value='0'>不选该项</option>");
	       	  $("#energyProperty").html(""); 
	       	  $("#energyProperty").append("<option value='0'>不选该项</option>");
	       	
	      }
	    });
     //删除联系人
     $( "#btnDeleteLinkMan" ).on('click', function(e) {
        	//不允许将联系人删除光
        	linkManParam.organid=$("#organid:checked").val();
        	if(getLinkManList()<=1){
        		parent.bootbox.alert("抱歉！不允许将联系人全部删除。");
        		return;
        	}
        	thisid = this.id;  //获取当前点击按钮的id 
        	if($("#link_Man_Id:checked").length<1){
        		parent.bootbox.alert("请选择要删除的联系人。");
        		return;
        	}
        	if($("#link_Man_Id:checked").length>=getLinkManList()){
        		parent.bootbox.alert("抱歉！不允许将联系人全部删除。");
        		return;
        	}
        	deleteLinkMan(linkManParam);
     });
     $("#searchLinkMan").on('click',function(){
     	linkManParam.organid=$("#organid:checked").val();
     	loadLinkManTable();
     });
     //点击园区信息管理
     var energyParkParam={};
		$("#btnEnergyPark").on('click',function(){
       		thisid=this.id;
       		if($("#organid:checked").length>1){
	       			 parent.bootbox.alert("只能选择一个商户进行园区信息管理");
	       			 return;
	       	}
	       	else if($("#organid:checked").length<1){
	       			parent.bootbox.alert("请先选择一个商户进行园区信息管理");
	       			 return;
	       	}
       		merchant.organid=$("#organid:checked").val();
       		getEnergyMerchantParkInfo(thisid);
	       	 /*energyParkParam.department_Id=$("#organid:checked").val();
	       	energyPark();
	       	loadEnergyParkTable();*/
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
        	//判断该园区下是否有用户用电配置信息
        	energyConsumeParamTable.park_Id=$("#park_Id:checked").val();
        	energyConsumeParamTable.organId=$("#organid:checked").val();
	        if(getEnergyConsumeList()!=0){//园区用电信息已经配置完毕
     			parent.bootbox.alert("该园区已经被引用，请先删除园区下的用户配置信息。");
	       		return;
     		}
     		energyParkParam.department_Id=$("#organid:checked").val();
     		if(getEnergyParkList()<=1){
     			parent.bootbox.alert("抱歉！不允许将园区信息全部删除。");
	       		return;
     		}
     		
        	if($("#park_Id:checked").length>=getEnergyParkList()){
        		parent.bootbox.alert("抱歉！不允许将园区信息全部删除。");
        		return;
        	}
        	deleteEnergyPark(energyParkParam);
     });
    //查询园区信息
    $( "#searchEnergy" ).on('click', function(e) {
        	energyParkParam.department_Id=$("#organid:checked").val();
     		loadEnergyParkTable();
     }); 
     //点击用能信息管理
      var energyConsumeParam={};//用户用电信息的变量
      var energyConsumeParamTable={};
		$("#btnConsumeManage").on('click',function(){
       		thisid=this.id;
       		if($("#park_Id:checked").length>1){
	       			 parent.bootbox.alert("只能选择一个园区进行用户信息管理");
	       			 return;
	       	}
	       	else if($("#park_Id:checked").length<1){
	       			parent.bootbox.alert("请先选择一个园区进行用户信息管理");
	       			 return;
	       	}
	       	if(getEnergyMerchantInfoByCheck()==1){//已审核
	       		$("#btnAddConsume").css("display","none");
	       		$("#btnEditConsume").css("display","none");
	       		$("#btnDeleteConsume").css("display","none");
	       	}
	       	else{
	       		$("#btnAddConsume").css("display","inline-block");
	       		$("#btnEditConsume").css("display","inline-block");
	       		$("#btnDeleteConsume").css("display","inline-block");
	       	}
	       	energyConsumeParamTable.park_Id=$("#park_Id:checked").val();
	       	energyConsumeParamTable.organId=$("#organid:checked").val();//getSupplyLocation
	       	energyConsume();
	       	loadEnergyConsumeTable();
	}); 
     //商户用电信息点击添加
     $( "#btnAddConsume" ).on('click', function(e) {
     	//判断该园区是否已经有用电信息配置
     		if($("#park_Id:checked").length>1){
       			 parent.bootbox.alert("只能选择一个园区进行用户信息管理");
       			 return;
	       	}
	       	else if($("#park_Id:checked").length<1){
       			parent.bootbox.alert("请先选择一个园区进行用户信息管理");
       			return;
	       	}
	       	energyConsumeParamTable.organId=$("#organid:checked").val();
	        if(getEnergyConsumeList()!=0){//园区用电信息已经配置完毕
     			parent.bootbox.alert("该园区的用电信息已经配置完毕，不可以重复配置。");
	       		return;
     		}
     		thisid = this.id;  //获取当前点击按钮的id 
        	$("#volumeConsume").val("");
        	$("#priceModeConsume").val("");
        	$("#capacityPriceConsume").val("");
        	$("#catalogPriceConsume").val("");
        	$("#peakPriceConsume").val("");
        	$("#flatPriceConsume").val("");
        	$("#valleyPriceConsume").val("");
        	consumeDialog();
        	energyConsumeParam.department_Id=$("#organid:checked").val();
        	getSupplyLocation();
     });
     //点击编辑用户用电信息
      $( "#btnEditConsume" ).on('click', function(e) {
        	thisid = this.id;  //获取当前点击按钮的id 
        	energyConsumeParam.department_Id=$("#organid:checked").val();
        	getSupplyLocation();
        	energyConsumeParam.park_Id=$("#park_Id_Consume:checked").val();
        	getEnergyConsumeInfo();
     });
     //点击删除用户用电信息
      $( "#btnDeleteConsume" ).on('click', function(e) {
      	if($("#park_Id_Consume:checked").length<1){
      		parent.bootbox.alert("请选择要删除的用户用电信息。");
        		return;
      	}
        
        energyConsumeParamTable.park_Id=$("#park_Id:checked").val();
        energyConsumeParamTable.organId=$("#organid:checked").val();
	    if(getEnergyConsumeList()<=1){
	    	parent.bootbox.alert("抱歉，不允许将用电配置信息全部删除！");
        		return;
	    }
	    energyConsumeParam.park_Id=$("#park_Id_Consume").val();
        deleteConsume();
     });
	</script>
    	<!-- 加载datables表数据js -->
    <script type="text/javascript">
            //封装请求参数
            var param = {};
    		$(function () {
    			var userId=${userId}
    			param.userId=userId;
    			loadTableData();	
    		});
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
	        	var table = $("#merchantTable").dataTable({
	        	    "dom": '<t><"col-md-4"i><"col-md-6"p><"col-md-2"l>',    //为表格元素书写css样式<t>为中间表格  在<t>右边就是在表格下边
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
		                param.rows = data.length;//页面显示记录条数，在页面显示每页显示多少项的时候
		                param.start = data.start;//开始的记录序号
		                param.page = (data.start / data.length)+1;//当前页码
		                if($("#merchantNameQuery").val()!=""){
		                	param.merchant_Name=$("#merchantNameQuery").val();
		                }
		                else{
		                	delete param.merchant_Name;
		                }
		                if($("#merchantTypeQuery").val()!=""&&$("#merchantTypeQuery").val()!=0&&$("#merchantTypeQuery").val()!=null){
		                	param.merchant_Type=$("#merchantTypeQuery").val();
		                }
		                else{
		                	delete param.merchant_Type;
		                }
		               if($("#tradeFlagQuery").val()!=""&&$("#tradeFlagQuery").val()!=0&&$("#tradeFlagQuery").val()!=null){
		                	param.trade_Flag=$("#tradeFlagQuery").val();
		                }
		                else{
		                	delete param.trade_Flag;
		                }
		                //ajax请求数据
		                $.ajax({
		                    type: "POST",
		                    url: "rest/rbac/MerchantRegistFlowController/getMerchantList",
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
					        "data": "organid", // 数据列名
					        "orderable":false,
					        "sWidth":"5px",
					        "render": function(data, type, full) { // 返回自定义内容
					       		return "<label><input type='checkbox' class='ace' id='organid' value = '" + data + "' /><span class='lbl' id='sorganid' value = '" + data + "'></span></label>";
					         }
	                    },
	                    {
	                    	"sWidth":"10%",
						  	"targets": [1], // 目标列位置，下标从0开始
						   	"data": "merchant_Name"
						   	 
	                    },
	                    {						   
						   "sWidth":"8%",
						   	"targets": [2], // 目标列位置，下标从0开始
						   	"data": "merchantTypeString" // 数据列名
						   	 
	                    },	                   
	                    {
	                    	 "sWidth":"7%",
						   	"targets": [3], // 目标列位置，下标从0开始
						   	"data": "reg_Capital" // 数据列名
	                    },
	                    {
	                    	"sWidth":"9%",
						   	"targets": [4], // 目标列位置，下标从0开始
						   	"data": "energyPropertyString" // 数据列名
	                    },
	                    {
						    "sWidth":"8%",
						   	"targets": [5], // 目标列位置，下标从0开始
						   	"data": "tradeFlagString" // 数据列名
	                    },
	                    {
						    "sWidth":"8%",
						   	"targets": [6], // 目标列位置，下标从0开始
						   	"data": "deposit_Bank" // 数据列名
	                    },
	                    {
						    "sWidth":"10%",
						   	"targets": [7], // 目标列位置，下标从0开始
						   	"data": "bank_Accout" // 数据列名
	                    },
	                    {
						    "sWidth":"14%",
						   	"targets": [8], // 目标列位置，下标从0开始
						   	"data": "address" // 数据列名
	                    },
	                    {
						    "sWidth":"10%",
						   	"targets": [9], // 目标列位置，下标从0开始
						   	"data": "reg_Number" // 数据列名
	                    },
	                    {
						    "sWidth":"7%",
						   	"targets": [10], // 目标列位置，下标从0开始
						   	"data": "checkStateString" // 数据列名
	                    },
	                    {
						    "sWidth":"9%",
						   	"targets": [11], // 目标列位置，下标从0开始
						   	"data": "regDateString" // 数据列名
	                    }
	            ]
	        }).api();
	        //此处需调用api()方法,否则返回的是JQuery对象而不是DataTables的API对象
		    }
		    $("#search").click(function(){
				loadTableData();
			});	    	
	</script>   
	
	 <script type="text/javascript">
	 	//获取下拉框的内容
	 	function findSelectData(){
	 		//获取所属经营公司
	 		$.ajax({
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
   	        });
   	        //获取商户类别
   	         $.ajax({
	            type: "POST",
	            url: "rest/rbac/MerchantRegistFlowController/getMerchantType", 
	            cache: false,  //禁用缓存
	            dataType: "json",
	            success: function (result) {
	       	   $("#merchantType").html(""); 
	       	    $("#merchantTypeQuery").html("");
	       	   $("#merchantType").append("<option value='0'>请选择</option>");	
	       	    $("#merchantTypeQuery").append("<option value='0'>全部</option>");		   	       			
	            	for(var i=0;i<result.data.length;i++){
	             		$("#merchantType").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
	             		$("#merchantTypeQuery").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
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
        	//加载交易资格
        	  $.ajax({
	            type: "POST",
	            url: "rest/rbac/MerchantRegistFlowController/getTradeFlag", 
	            cache: false,  //禁用缓存
	            dataType: "json",
	            success: function (result) {
	       	   $("#tradeFlagQuery").html(""); 
	       	   $("#tradeFlagQuery").append("<option value='0'>全部</option>");		   	       			
	            	for(var i=0;i<result.data.length;i++){
	             		$("#tradeFlagQuery").append("<option value='"+result.data[i].subid+"'>"+result.data[i].subname+"</option>");
	            	}
	           },
	            error:function(){	            	
            	}
        	});
	 	}
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
         function getCity(id){	
        	  $.ajax({
	            type: "POST",
	            url: "rest/rbac/MerchantRegistFlowController/getCity", 
	            data: 'id='+id,
	            cache: false,  //禁用缓存
	            dataType: "json",
	            async:false,
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
	            async:false,
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
         function getEnergyMerchantInfoByCheck(){
		 	var merchantType=0;
			$.ajax({
	            url: 'rest/rbac/MerchantRegistFlowController/getEnergyMerchantInfo',
	            data: merchant,
	            async: false,
	            type: 'POST',
	            dataType: 'json',
	            success: function (result) {
	            	merchantType=result.data.check_State;
	   	        },
	   	        error: function(){
	   	            parent.bootbox.alert("系统错误！获取商户信息失败。请刷新重新操作。", function(){});
	   	        }
	   	    });
	   	    return merchantType;
		} 
	 </script>
    <!-- 主页面的 数据操作处理js 增删该查 -->
    <script type="text/javascript"> 
	$.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
		_title: function(title) {
			var $title = this.options.title || '&nbsp;'
			if( ("title_html" in this.options) && this.options.title_html == true )
				title.html($title);
			else title.text($title);
		}
	}));
	var thisid = null;
	var par = {};   //声明ajax传输参数的数组变量
	//格式化编辑时加载的 时间格式
	function FormatDate (strTime) {
	    var date = new Date(strTime);
	    return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
	}
    </script> 
    
    <!-- 子页面的 数据操作处理js 增删该查 -->
    <script type="text/javascript">
		//js验证正则表达式 
		//支持15位和18位身份证号
		
    </script>
     <script type="text/javascript">
     	//商户弹出框
		    function merchantDialog(){
					var dialog = $( "#merchantDialog" ).removeClass('hide').dialog({
						modal: true,
						title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i> 商户信息管理</h4></div>",
						title_html: true,
						width:1000,
						height:580,
						position: {my: 'center',at: 'center top'},
						buttons: [ 
						]
					});
			}
			//联系人管理弹出框
			function fromEditDialog(e){
					var dialog = $( "#fromEdit" ).removeClass('hide').dialog({
						modal: true,
						title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i> 联系人管理</h4></div>",
						title_html: true,
						width:900,
						height:440,
						position: {my: 'center',at: 'center top'},
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
			//园区管理弹出框
			function energyPark(e){
				var dialog = $( "#energyPark" ).removeClass('hide').dialog({
					modal: true,
					title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i> 园区信息管理</h4></div>",
					title_html: true,
					width:900,
					height:440,
					position: {my: 'center',at: 'center top'},
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
			//用户用电配置管理弹出框
			function energyConsume(e){
					var dialog = $( "#energyConsume" ).removeClass('hide').dialog({
						modal: true,
						title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i> 用户用电信息管理</h4></div>",
						title_html: true,
						width:900,
						height:450,
						position: {my: 'center',at: 'center top'},
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
    <script type="text/javascript">
	    function getEnergyMerchantInfo(thisid){
			$.ajax({
	            url: 'rest/rbac/MerchantRegistFlowController/getEnergyMerchantInfo',
	            data: merchant,
	            async: false,
	            type: 'POST',
	            dataType: 'json',
	            success: function (result) {	            	
	            	if(result.data.check_State==1 && thisid !="btnDetail"){//审核状态为已审核
	            		parent.bootbox.alert("该商户已经审核通过！不允许再操作其基本信息。");
			     	 	return;
	            	}else{
		            	
		            	if(thisid=="btnEdit"){
		            		$("#btnUpdateDiv").css("display","block");
       						$("#btnCheckPassDiv").css("display","none ");
       						
       						$("#organId").removeAttr("readonly");
				        	$("#organId").removeAttr("disabled");
				        	$("#merchantType").removeAttr("readonly");
				        	$("#merchantType").removeAttr("disabled");
				        	$("#merchantScale").removeAttr("readonly");
				        	$("#merchantScale").removeAttr("disabled");
				        	$("#industryCategory").removeAttr("readonly");
				        	$("#industryCategory").removeAttr("disabled");
				        	$("#energyProperty").removeAttr("readonly");
				        	$("#energyProperty").removeAttr("disabled");
				        	$("#credit").removeAttr("readonly");
				        	$("#credit").removeAttr("disabled");
				        	$("#province").removeAttr("readonly");
				        	$("#province").removeAttr("disabled");
				        	$("#city").removeAttr("readonly");
				        	$("#city").removeAttr("disabled");
				        	$("#county").removeAttr("readonly");
				        	$("#county").removeAttr("disabled");
				        	$("#merchantName").removeAttr("readonly");
				        	$("#legalPerson").removeAttr("readonly");
				        	$("#regCapital").removeAttr("readonly");
				        	$("#fax").removeAttr("readonly");
				        	$("#postcode").removeAttr("readonly");
				        	$("#publicNumber").removeAttr("readonly");
				        	$("#depositBank").removeAttr("readonly");
				        	$("#bankAccount").removeAttr("readonly");
				        	$("#accountName").removeAttr("readonly");
				        	$("#regNumber").removeAttr("readonly");
				        	$("#email").removeAttr("readonly");
				        	$("#phone").removeAttr("readonly");
				        	$("#address").removeAttr("readonly");	
				        	merchantDialog();
		            	}
		            	else if(thisid=="btnCheck"||thisid=="btnDetail"){
		            		$("#organId").attr("readonly","readonly");
				        	$("#organId").attr("disabled","disabled");
				        	$("#merchantType").attr("readonly","readonly");
				        	$("#merchantType").attr("disabled","disabled");
				        	$("#merchantScale").attr("readonly","readonly");
				        	$("#merchantScale").attr("disabled","disabled");
				        	$("#industryCategory").attr("readonly","readonly");
				        	$("#industryCategory").attr("disabled","disabled");
				        	$("#energyProperty").attr("readonly","readonly");
				        	$("#energyProperty").attr("disabled","disabled");
				        	$("#credit").attr("readonly","readonly");
				        	$("#credit").attr("disabled","disabled");
				        	$("#province").attr("readonly","readonly");
				        	$("#province").attr("disabled","disabled");
				        	$("#city").attr("readonly","readonly");
				        	$("#city").attr("disabled","disabled");
				        	$("#county").attr("readonly","readonly");
				        	$("#county").attr("disabled","disabled");
				        	$("#merchantName").attr("readonly","readonly");
				        	$("#legalPerson").attr("readonly","readonly");
				        	$("#regCapital").attr("readonly","readonly");
				        	$("#fax").attr("readonly","readonly");
				        	$("#postcode").attr("readonly","readonly");
				        	$("#publicNumber").attr("readonly","readonly");
				        	$("#depositBank").attr("readonly","readonly");
				        	$("#bankAccount").attr("readonly","readonly");
				        	$("#accountName").attr("readonly","readonly");
				        	$("#regNumber").attr("readonly","readonly");
				        	$("#email").attr("readonly","readonly");
				        	$("#phone").attr("readonly","readonly");
				        	$("#address").attr("readonly","readonly");	
				        	if(thisid=="btnCheck"){
				        		$("#btnUpdateDiv").css("display","none");
				        		 $("#btnCancle").css("display","block");
       						    $("#btnCheckPassDiv").css("display","block");
				        	}else {
				        		$("#btnUpdateDiv").css("display","none");
       						    $("#btnCheckPassDiv").css("display","none");
       						     $("#btnCancle").css("display","none");
				        	}	            		
		            		
       						merchantDialog();
		            	}else if(thisid=="btnDelete"){
		            		delleteMerchant();
		            	}
		            	
		 	           // $("#organId").val(result.data.organid);///////////////////////////////////////////////重点考虑
						$("#merchantType").val(result.data.merchant_Type);
		 	           //发电商不用选择商户规模和用电性质
		 	            if(result.data.merchant_Type == 2) {
		 	            	$("#merchantScale").html(""); 
		 			       	  $("#merchantScale").append("<option value='0'>不选该项</option>");
		 			       	  $("#energyProperty").html(""); 
		 			       	  $("#energyProperty").append("<option value='0'>不选该项</option>");
		 	            }
					    $("#merchantScale").val(result.data.merchant_Scale);
						$("#merchantId").val(result.data.organid);
						$("#merchantName").val(result.data.merchant_Name);
						$("#industryCategory").val(result.data.industry_Category);
					    $("#energyProperty").val(result.data.energy_Property);
						$("#legalPerson").val(result.data.legal_Person);
						$("#regCapital").val(result.data.reg_Capital);
						
						$("#credit").val(result.data.credit);
						$("#fax").val(result.data.fax);
						$("#postcode").val(result.data.postcode);
						$("#publicNumber").val(result.data.public_Number);
					    $("#depositBank").val(result.data.deposit_Bank);
						$("#bankAccount").val(result.data.bank_Accout);
						$("#accountName").val(result.data.account_Name);
						
						$("#regNumber").val(result.data.reg_Number);
						$("#email").val(result.data.email);
						$("#phone").val(result.data.phone);
						////////////////////////////////////////////////////////重点考虑
						var addressAll=result.data.address;
						var address=[];
						address=addressAll.split("*");
						//先判断是否为空
						
						$("#province").val(result.province);
						getCity(result.province);
					    $("#city").val(result.city);
					    getCounty(result.city);
						$("#county").val(result.county);
						$("#address").val(address[1]);
						$("#regName").val(result.data.reg_User_Name);
						$("#regTime").val(result.data.regDateString);
					}
	   	        },
	   	        error: function(){
	   	            parent.bootbox.alert("系统错误！获取商户信息失败。请刷新重新操作。", function(){});
	   	        }
	   	    });
		}
	    
	    function getEnergyMerchantParkInfo(thisid){
			$.ajax({
	            url: 'rest/rbac/MerchantRegistFlowController/getEnergyMerchantInfo',
	            data: merchant,
	            async: false,
	            type: 'POST',
	            dataType: 'json',
	            success: function (result) {	            	
	            	/*if(result.data.check_State==1 && thisid !="btnDetail"){//审核状态为已审核
	            		parent.bootbox.alert("该商户已经审核通过！不允许再操作其基本信息。");
			     	 	return;
	            	}else */
	            	if( result.data.merchant_Type ==2) {
	            		parent.bootbox.alert("售电商户不需要配置园区信息！");
	            		return;
		            }else if( result.data.merchant_Type ==3) {
	            		parent.bootbox.alert("产能商户不需要配置园区信息！");
	            		return;
		            }
		             energyParkParam.department_Id=$("#organid:checked").val();
		    	    energyPark();
		    	    loadEnergyParkTable();
		            if(result.data.check_State==1){//已经审核，隐藏按钮
		            	$("#btnDeleteEnergyPark").css("display","none");
		            	$("#btnEditEnergyPark").css("display","none");
		            	$("#btnAddEnergyPark").css("display","none");
		            }else{//未审核，恢复按钮
		            	$("#btnDeleteEnergyPark").css("display","inline-block");
		            	$("#btnEditEnergyPark").css("display","inline-block");
		            	$("#btnAddEnergyPark").css("display","inline-block");
		            }
		             
	   	        },
	   	        error: function(){
	   	            parent.bootbox.alert("系统错误！获取商户信息失败。请刷新重新操作。", function(){});
	   	        }
	   	    });
		}
	    
		//更新商户
        function updateMerchant(merchant,thisid){	
			$.ajax({
   	            url:'rest/rbac/MerchantRegistFlowController/updateEnergyMerchantInfo',
   	            data:merchant,
   	            type: 'POST',
   	            dataType: 'json',
   	            async: false,
   	            success: function (result) {
	   	            if(result.result == "success"){
	   	            	if(thisid=="btnUpdate"){
	   	            		parent.bootbox.alert("更新商户信息成功！");
	   	            	}
	   	            	else if(thisid=="btnCheckPass"){
	   	            		parent.bootbox.alert("审核商户信息成功！");
	   	            	}
			            $("#merchantDialog").dialog("close");
				       	loadTableData();
		            }
		            else if(result.result == "merchantName"){
		            	parent.bootbox.alert("该商户名称已经存在，请更换商户名称。");
		            	return;
		            }else if(result.result == "regNumber"){
		            	parent.bootbox.alert("该三证合一号已经存在！请更换三证合一号。");
		            	return;
		            } 
   	            },
   	            error: function(){
   	                parent.bootbox.alert("系统错误！更新商户信息失败。请刷新重新操作。", function(){});
   	            }
   	        }); 
	    }
	     //删除商户信息
	 	function delleteMerchant(){
	 		 merchant.organIds=[];    
				parent.bootbox.confirm("你确定要删除商户信息吗？", function(result) {
				if(result){				
					for(var i=0;i<$("#organid:checked").length;i++){
		        		merchant.organIds[i]=$("#organid:checked")[i].defaultValue;
		        	}
						$.ajax({
		    	            url: 'rest/rbac/MerchantRegistFlowController/deleteMerchant',
		    	            async: false,
		    	            data:  merchant,
		    	            type: 'POST',
		    	            dataType: 'json',
		    	            success: function (result) { 
		    	            	if(result.data == "success"){
			    	            	parent.bootbox.alert("商户信息删除成功！");
			    	            	loadTableData();
			    	             }
			    	             else {
			    	             	parent.bootbox.alert("抱歉该商户已经被引用，请先删除该商户的联系人和园区信息");
			    	            	loadTableData();
			    	             }
		    	            },
		    	            error: function(){
		    	            	parent.bootbox.alert("系统错误！商户信息删除失败！请刷新重新操作", function(){});
		    	            }
			   	        });	   	       
				    }
			  });
		}
	    
	</script>
	<script type="text/javascript">
	 	//联系人管理的方法
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
		   
		   function getLinkManList(){
		   	 var linkManNum=0;
		   	 linkManParam.page=1;
		   	 linkManParam.rows=10000;
		   	 //ajax请求数据
              $.ajax({
                  type: "POST",
                  url: "rest/rbac/MerchantRegistFlowController/girdLinkMan",
                  cache: false,  //禁用缓存
                  data: linkManParam,  //传入组装的参数
                  dataType: "json",
                  async:false,
                  success: function (result) {
                      linkManNum=result.total;
                  }
              });
		     return linkManNum;
		   }
		   
		   
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
		                        par.organid=$("#organid:checked").val();
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
		                        par.organid=$("#organid:checked").val();
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
	                	linkManParam.organid=$("#organid:checked").val();
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
                		linkManParam.organid=$("#organid:checked").val();
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
			    	            	linkManParam.organid=$("#organid:checked").val();
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
	 <script type="text/javascript">
	 	//加载园区信息table
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
		   function getEnergyParkList(){
		   	 var energyParkNum=0;
		   	 energyParkParam.page=1;
		   	 energyParkParam.rows=10000;
		   	//ajax请求数据
             $.ajax({
                 type: "POST",
                 url: "rest/rbac/MerchantRegistFlowController/girdEnergyParkList",
                 cache: false,  //禁用缓存
                 data: energyParkParam,  //传入组装的参数
                 dataType: "json",
                 async:false,
                 success: function (result) {
                     energyParkNum=result.total;
                  }
             });
		   return energyParkNum;
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
		                        energyParkParam.department_Id=$("#organid:checked").val();
								energyParkParam.park_Name = $("#parkName").val();
								energyParkParam.park_Type = $("#parkType").val();
							    energyParkParam.power_Company=$("#powerCompany").val();
								energyParkParam.park_Address=$("#parkAddress").val();
		 						addEnergyPark(energyParkParam);
	                        }
	                        if (thisid == "btnEditEnergyPark") {
	                        	energyParkParam.department_Id=$("#organid:checked").val();
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
    //添加园区信息
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
	                	energyParkParam.department_Id=$("#organid:checked").val();
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
			    	            	energyParkParam.department_Id=$("#organid:checked").val();
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
		                energyConsumeParamTable.organId=$("#organid:checked").val();
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
    	//加载供电地点：实际加载该商户下所有的园区
    	function getSupplyLocation(){
    		var consumeNum=0;//没有配置用电信息的园区
	      	$.ajax({
	           type: "POST",
	           url: "rest/rbac/MerchantRegistFlowController/getSupplyLocation", 
	           data:energyConsumeParam,
	           cache: false,  //禁用缓存
	           dataType: "json",
	           async:false,
	           success: function (result) {
	      	   $("#supplyLocationConsume").html(""); 
	      	   $("#supplyLocationQuery").html(""); 
	      	   $("#supplyLocationConsume").append("<option value='0'>请选择</option>");		
	      	    $("#supplyLocationQuery").append("<option value='0'>请选择</option>");	   	       			
	           	for(var i=0;i<result.data.length;i++){
	            		$("#supplyLocationConsume").append("<option value='"+result.data[i].park_Id+"'>"+result.data[i].park_Name+"</option>");
	            		$("#supplyLocationQuery").append("<option value='"+result.data[i].park_Id+"'>"+result.data[i].park_Name+"</option>");
	           	}
	           	consumeNum=result.data.length
	          },
	           error:function(){	            	
	          	}
	      	});
	      	return consumeNum;
    	}
	    //获取用户的用电配置信息
	    function getEnergyConsumeList(){
			var consumeNum=0;
			energyConsumeParamTable.page=1;
			energyConsumeParamTable.rows=10000;
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
	                        if (thisid == "btnAddConsume") {
		                       // energyConsumeParam.park_Id=$("#supplyLocationConsume").val();
		                        energyConsumeParam.park_Id=$("#park_Id:checked").val();
								energyConsumeParam.supply_Location = $("#supplyLocationConsume").val();//parkId，根据parkId后台获取该园区的地址
								energyConsumeParam.voltage_Class = $("#voltageClassConsume").val();
							    energyConsumeParam.energy_Property=$("#energyPropertyConsume").val();
								energyConsumeParam.volume=$("#volumeConsume").val();
								energyConsumeParam.price_Mode=$("#priceModeConsume").val();
								energyConsumeParam.capacity_Price = $("#capacityPriceConsume").val();
								energyConsumeParam.catalog_Price = $("#catalogPriceConsume").val();
							    energyConsumeParam.peak_Price=$("#peakPriceConsume").val();
								energyConsumeParam.flat_Price=$("#flatPriceConsume").val();
								energyConsumeParam.valley_Price=$("#valleyPriceConsume").val();
		 						addEnergyConsume(energyConsumeParam);
	                        }
	                        if (thisid == "btnEditConsume") {
	                        	//energyConsumeParam.park_Id=$("#supplyLocationConsume").val();
	                        	 energyConsumeParam.park_Id=$("#park_Id:checked").val();
								energyConsumeParam.supply_Location = $("#supplyLocationConsume").val();//parkId，根据parkId后台获取该园区的地址
								energyConsumeParam.voltage_Class = $("#voltageClassConsume").val();
							    energyConsumeParam.energy_Property=$("#energyPropertyConsume").val();
								energyConsumeParam.volume=$("#volumeConsume").val();
								energyConsumeParam.price_Mode=$("#priceModeConsume").val();
								energyConsumeParam.capacity_Price = $("#capacityPriceConsume").val();
								energyConsumeParam.catalog_Price = $("#catalogPriceConsume").val();
							    energyConsumeParam.peak_Price=$("#peakPriceConsume").val();
								energyConsumeParam.flat_Price=$("#flatPriceConsume").val();
								energyConsumeParam.valley_Price=$("#valleyPriceConsume").val();
		 						updateEnergyConsume(energyConsumeParam);
	                        }
	                    }
	                }
	            ]
        });
    }
    //添加商户用电信息
    function addEnergyConsume(){
    	/*if(energyConsumeParam.supply_Location==""||energyConsumeParam.supply_Location==null||energyConsumeParam.supply_Location==0){
			  parent.bootbox.alert("请选择供电地点！")
			  return;
		}*/	
		if(energyConsumeParam.voltage_Class==""||energyConsumeParam.voltage_Class==0){
			  parent.bootbox.alert("请选择电压等级！")
			  return;
		}
		if(energyConsumeParam.energy_Property==""||energyConsumeParam.energy_Property==0){
			  parent.bootbox.alert("请选择用电性质！")
			  return;
		}
		if(energyConsumeParam.price_Mode==""||energyConsumeParam.price_Mode==0){
			  parent.bootbox.alert("请选择电价方式！")
			  return;
		}
		if(energyConsumeParam.catalog_Price==""){
			  parent.bootbox.alert("请填写目录电价！")
			  return;
		}		
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
	                	energyConsumeParamTable.organId=$("#organid:checked").val();
	                	loadEnergyConsumeTable();
                	}
  	            },
  	            error: function(){
  	                parent.bootbox.alert("系统错误！用电信息配置失败。请刷新重新操作。", function(){});
  	            }
  	        });	
    }
    //获取用户用电信息
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
	//更新用户用电配置信息
	function updateEnergyConsume(energyConsumeParam){	
		/*if(energyConsumeParam.supply_Location==""||energyConsumeParam.supply_Location==null||energyConsumeParam.supply_Location==0){
			  parent.bootbox.alert("请选择供电地点！")
			  return;
		}	*/
		if(energyConsumeParam.voltage_Class==""||energyConsumeParam.voltage_Class==0){
			  parent.bootbox.alert("请选择电压等级！")
			  return;
		}
		if(energyConsumeParam.energy_Property==""||energyConsumeParam.energy_Property==0){
			  parent.bootbox.alert("请选择用电性质！")
			  return;
		}
		if(energyConsumeParam.price_Mode==""||energyConsumeParam.price_Mode==0){
			  parent.bootbox.alert("请选择电价方式！")
			  return;
		}
		if(energyConsumeParam.catalog_Price==""){
			  parent.bootbox.alert("请填写目录电价！")
			  return;
		}
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
                		energyConsumeParamTable.organId=$("#organid:checked").val();
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
			    	            	energyConsumeParamTable.organId=$("#organid:checked").val();
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
	function openWin(){
		window.open ("http://api.map.baidu.com/lbsapi/getpoint/index.html", "newwindow", "height=650, width=1200, top=200, left=300,toolbar=no, menubar=no, scrollbars=no, resizable=yes, location=n o, status=no");  
	}
</script>
	</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<head>
  <meta charset="utf-8">
  <base href=" <%=basePath%>">
  <title>微信JS-SDK Demo</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=0">
  <link rel="stylesheet" href="plug-in/wechat/style.css">
</head>
<body ontouchstart="">
<div class="wxapi_container">
    
    <div class="lbox_close wxapi_form">
    
      <h3 id="menu-location">地理位置接口</h3>
      <span class="desc">获取地理位置接口</span>
      <button class="btn btn_primary" id="getLocation">签到</button>
      
      
      <h3 id="menu-location">拍照、打开相册、上传图片到微信服务器、在后台下载微信服务器图片获取二进制流接口</h3>
      <span class="desc">上传图片保存到zup服务器</span>
      <button class="btn btn_primary" id="chooseImage">拍照或上传图片</button>
      <input type="hidden" id="serverId" value="" >
	
	
    </div>
  </div>
</body>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="plug-in/ace/assets/js/jquery-2.0.3.min.js"></script>
<script type="text/javascript">
	function jssdk() {
		$.ajax({
			url : "http://jcny.unrealcore.com:9999/zup/wechatconfig/jssdk",
			type : 'post',
			dataType : 'json',
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {
				'url' : location.href.split('#')[0]
			},
			success : function(data) {
				wx.config({
					debug : true,
					appId : data.data.data.appId,
					timestamp : data.data.data.timestamp,
					nonceStr : data.data.data.nonceStr,
					signature : data.data.data.signature,
					jsApiList : [ 'checkJsApi', 'onMenuShareTimeline',
							'onMenuShareAppMessage', 'onMenuShareQQ',
							'onMenuShareWeibo', 'hideMenuItems',
							'showMenuItems', 'hideAllNonBaseMenuItem',
							'showAllNonBaseMenuItem', 'translateVoice',
							'startRecord', 'stopRecord', 'onRecordEnd',
							'playVoice', 'pauseVoice', 'stopVoice',
							'uploadVoice', 'downloadVoice', 'chooseImage',
							'previewImage', 'uploadImage', 'downloadImage',
							'getNetworkType', 'openLocation', 'getLocation',
							'hideOptionMenu', 'showOptionMenu', 'closeWindow',
							'scanQRCode', 'chooseWXPay',
							'openProductSpecificView', 'addCard', 'chooseCard',
							'openCard' ]
				});
			}
		});
	}

	function isWeiXin5() {
		var ua = window.navigator.userAgent.toLowerCase();
		var reg = /MicroMessenger\/[5-9]/i;
		return reg.test(ua);
	}


	window.onload = function() {
		if(isWeiXin5() == false) {
	 	  alert("您的微信版本低于5.0，无法使用微信支付功能，请先升级！");
		}
		jssdk();
	};

	//获取地理位置信息
	$("#getLocation").click(function(){
		  wx.getLocation({
		      success: function (res) {
		        alert(JSON.stringify(res));
		      },
		      cancel: function (res) {
		        alert('用户拒绝授权获取地理位置');
		      }
		    });
	});
	//拍照及上传
	wx.error(function(res){
	    // config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
		console.log("config验证失败");
	});
	
	var images = {
	   		localId: [],
	    	serverId: []
		};
   document.querySelector('#chooseImage').onclick = function () {
	//选择图片、打开相机接口
     wx.chooseImage({
   		count: 1, // 默认9  
        sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有  
        sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有  
     	success: function (res) {
        	images.localId = res.localIds;
        	//上传到微信服务器接口
        	wx.uploadImage({
	     	    localId: images.localId.toString(), // 需要上传的图片的本地ID，由chooseImage接口获得
	     	    isShowProgressTips: 1, // 默认为1，显示进度提示
	     	    success: function (res) {
	     	        var serverId = res.serverId; // 返回图片的服务器端ID
	     	        //alert("serverId: "+serverId);
	     	        $("#serverId").val(serverId);
	     	        //在微信服务器上下载到本地(类中调用并下载)
	     	       	var url = "http://jcny.unrealcore.com:9999/zup/wechatconfig/download?serverId="+serverId.toString();
	     			var data = "{serverId:"+serverId.toString()+"}";
	     			//alert("serverId: "+data);
	     			$.ajax({
	     				url : url,
	     				type : 'post',
	     				dataType : 'json',
	     				contentType : "application/x-www-form-urlencoded; charset=utf-8",
	     				data :data,
	     				success : function(data) {
	     					alert("上传成功，图片ID为"+serverId.toString);
	     				}
	     			});
	     	    }
	     	 });
      	}
      });
  	};
	
	wx.previewImage({
	    current: '', // 当前显示图片的http链接
	    urls: [] // 需要预览的图片http链接列表
	});

	
</script>
</html>

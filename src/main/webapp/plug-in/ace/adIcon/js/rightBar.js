
//侧边搜索结果
$(function() {
	/*//一级导航点击事件
	$(".area-one>li>a").click(function() {
		$(this).addClass('on').parent().siblings().find('a').removeClass('on');
		$(this).parent().find(".area-two").stop().slideToggle(300).parent().siblings().find(".area-two").slideUp(300);
	})
	//二级导航点击事件
	$(".area-two>li>a").click(function() {
		$(this).addClass('on').parent().siblings().find('a').removeClass('on');
		$(this).parent().find(".area-three").stop().slideToggle(300).parent().siblings().find(".area-three").slideUp(300);
	})
	//三级导航点击事件
	$(".area-three>li>a").click(function() {
		$(this).addClass('on').parent().siblings().find('a').removeClass('on');
	})*/
	var r = 0;
	var area_time = 300;  //侧边滑动时间
	$(".area-btn .right").hide();
	//点击搜索结果按钮事件
	$(".area-btn").click(function() {
		r++
		if(r % 2 == 0) {
			//关闭状态
			$(".area-btn").animate({
				right: 0,
			}, area_time);
			$('#area').animate({
				right: -220,
			}, area_time)
			$(".area-btn .left").show();
			$(".area-btn .right").hide();
		} else {
			//打开状态
			$(".area-btn").animate({
				right: 220,
			}, area_time);
			$('#area').animate({
				right: 0,
			}, area_time);
			$(".area-btn .left").hide();
			$(".area-btn .right").show();
		}
	});

})
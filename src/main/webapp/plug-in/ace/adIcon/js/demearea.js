$(function() {
	var iconIndex;
	ciconIndex = 0; //上次点击
	//底部导航按钮
	$('.icon').click(function() {
		iconIndex = $(this).index();
		dataBox1 = $('div[data-box="' + (ciconIndex + 1) + '"]')
		dataBox2 = $('div[data-box="' + (iconIndex + 1) + '"]')
		//上一个
		dataBox1.removeClass('fadeIn');
		//本次
		dataBox2.addClass('fadeIn');
		//存储上一次点击的
		ciconIndex = iconIndex;

		$(this).addClass('on').siblings().removeClass('on')
	})
	var i = 0;
	//窗口最大化
	$(".mine-query-maxin").click(function() {
		i++
		if(i % 2 == 0) {
			$('.mine-query-title .fa-window-maximize ').hide();
			$('.mine-query-title .fa-window-restore ').show();
			$('div[data-box="' + (ciconIndex + 1) + '"]').animate({
				width: '90vw',
				height: '76vh',
				'margin-left': '-45vw',
				left: '50%',
				top: '5%',
				'z-index': 0,
			}, 200)
			$('.dockposition').show();
			$('.mine-query-body').animate({
				height: '59vh',
			}, 200)
		} else {
			$('.mine-query-title .fa-window-maximize ').show();
			$('.mine-query-title .fa-window-restore ').hide();
			$('.dockposition').fadeOut(200);
			$('div[data-box="' + (ciconIndex + 1) + '"]').animate({
				width: '100vw',
				height: '100vh',
				'margin-left': 0,
				left: 0,
				top: 0,
				'z-index': 999,
			}, 200);
			$('.mine-query-body').animate({
				height: '83vh',
			}, 200)

		}

	});
});
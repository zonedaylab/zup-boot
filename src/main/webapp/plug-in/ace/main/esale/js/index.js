$(function(){
	$('.submenu').on("click","li", function() {
		$(this).addClass('nav-click-bg').siblings().removeClass('nav-click-bg');
		
	})
})
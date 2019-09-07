/*照片对比轮播*/
var ImgCarouselTools = function(){
	var j = 0, i = 0, time = 2000, a = 0, b = 0;
	ImgCarouselTools.prototype.auto = function(){
		/*
		 获取照片对比标题文字的宽度，使其居中
		 * **/
		var carspan= $('.pop-carousel-img li span').outerWidth();
		$('.pop-carousel-img li span').css('margin-left',-carspan/2);
		var carspan= $('.pop-carousel-img li b').outerWidth();
		$('.pop-carousel-img li b').css('margin-left',-carspan/2);
	}
	/*图片向右*/
	ImgCarouselTools.prototype.picP = function(){
	    var CimgLength = $('.pop-img-contrast .pop-carousel-img').children().length;
	    var CimgLirstlength = $('.pop-img-contrast .pop-carousel-img li').width();
	    $('.pop-img-contrast .pop-carousel-img').width(CimgLength * CimgLirstlength);
		j++;
		if(j == CimgLength) {
			$('.pop-img-contrast .pop-carousel-img').stop().animate({
				left: 0
			}, 500);
			j = 0;
		} else {
			$('.pop-img-contrast .pop-carousel-img').stop().animate({
				left: -j * CimgLirstlength
			}, 500);
		}
	}
	/*图片向左*/
	ImgCarouselTools.prototype.picN = function(){
		var CimgLength = $('.pop-img-contrast .pop-carousel-img').children().length;
	    var CimgLirstlength = $('.pop-img-contrast .pop-carousel-img li').width();
	    $('.pop-img-contrast .pop-carousel-img').width(CimgLength * CimgLirstlength);
		j--;
		if(j == -CimgLength) {
			$('.pop-img-contrast .pop-carousel-img').stop().animate({
				left: 0
			}, 500);
			j = 0;
		} else {
			$('.pop-img-contrast .pop-carousel-img').stop().animate({
				left: j * CimgLirstlength
			}, 500);
		}
	}
	/*视频图片向右*/
	ImgCarouselTools.prototype.videoP = function(){
		var VimgLength = $('.pop-video .pop-carousel-img').children().length;
		var VimgLirstlength = $('.pop-video .pop-carousel-img li').width();
		$('.pop-video .pop-carousel-img').width(VimgLength * VimgLirstlength);
		i++;
		if(i == VimgLength) {
			$('.pop-video .pop-carousel-img').stop().animate({
				left: 0
			}, 500);
			i = 0;
		} else {
			$('.pop-video .pop-carousel-img').stop().animate({
				left: -i * VimgLirstlength
			}, 500);
		}
	}
	/*视频图片向左*/
	ImgCarouselTools.prototype.videoN = function(){
		var VimgLength = $('.pop-video .pop-carousel-img').children().length;
		var VimgLirstlength = $('.pop-video .pop-carousel-img li').width();
		$('.pop-video .pop-carousel-img').width(VimgLength * VimgLirstlength);
		i--;
		if(i == -1) {
			$('.pop-video .pop-carousel-img').stop().animate({
				left: -(VimgLength - 1) * VimgLirstlength
			}, 500);
			i = VimgLength - 1;
		} else {
			$('.pop-video .pop-carousel-img').stop().animate({
				left: -i * VimgLirstlength
			}, 500);

		}
	}
}


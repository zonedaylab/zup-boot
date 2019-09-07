// JavaScript Document、
var scaleWdith = $(window).width() / 1920;
$('body').css({
	transform: 'scale(' + scaleWdith + ')',
	'-webkit-transform': 'scale(' + scaleWdith + ')',
});
$('html').css({
	height: scaleWdith * 1080,
	width: scaleWdith * 1920
});

$(function() {
	"use strict";
	var scaleWdith = $(window).width() / 1920;
	$('body').css({
		transform: 'scale(' + scaleWdith + ')',
		'-webkit-transform': 'scale(' + scaleWdith + ')',
	});
	$('html').css({
		height: scaleWdith * 1080,
		width: scaleWdith * 1920
	});
});

$(window).resize(function() {
	"use strict";
	var scaleWdith = $(window).width() / 1920;
	$('body').css({
		transform: 'scale(' + scaleWdith + ')',
		'-webkit-transform': 'scale(' + scaleWdith + ')',
	});
	$('html').css({
		height: scaleWdith * 1080,
		width: scaleWdith * 1920
	});
});
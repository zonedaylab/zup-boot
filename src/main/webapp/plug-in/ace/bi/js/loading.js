/**
 * Created by andot on  2018-5-31 16:48:00
 */
var Loading = function(){
	/**
	 * color:如果不填写显示白色，填入颜色值，就显示对应颜色
	 * */
	var index=0;
	Loading.prototype.start = function(color) {
		 index = layer.load(0, {
			skin: 'i-loading',
			shade: 0.1,
			content: '<div class="sk-wave"><div class="sk-rect sk-rect1"></div><div class="sk-rect sk-rect2"></div><div class="sk-rect sk-rect3"></div><div class="sk-rect sk-rect4"></div><div class="sk-rect sk-rect5"></div></div>'
		});
		if(typeof(color) != "undefined")
			$(".sk-rect").css("background-color", color);

    }
	/**
	 * index: 要关闭弹窗的实例
	 * */
	Loading.prototype.stop = function() {
    	layer.close(index);
    }
}
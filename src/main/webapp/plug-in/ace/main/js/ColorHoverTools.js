/**
 * Created by andot on 2017/5/24.
 */
var ColorHoverTools = function(parent, chind){
	$("."+parent+" ."+chind).eq(0).css("background-color", "#0575af");
    $("."+parent+" ."+chind).on("click" ,function(){
        $("."+parent).each(function(){
            $("."+chind).css("background-color", "#00a8ff");
        });
        $(this).css("background-color", "#0575af");
    });
}
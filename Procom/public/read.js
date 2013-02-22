$(function(){
	$("#procom-read").addClass("active");
	$("#myCarousel").css("display","none");
	$(".space-button-well").css("display","none");
	$("#footer").css("display","none");
	$(".select-tags a").click(function(){
		listinit();
		$($(this).parent()).addClass("active");
		$($(this).find("i")).addClass("icon-white");
	});
	$(".choose-tags a").hover(
		function() {
			$(".remove-tags").css("display","none");
			$(this).find("i[class='remove-tags icon-remove pull-right close']").css("display","block");
		},
		function() {
			$(".remove-tags").css("display","none");
		}
	);
	$(".sina-share a").die("click");
	$(".sina-share a").live('click',function(event){
		event.preventDefault();
		var id=$($($($(this).parents(".span3").siblings(".span5")[1]).find("p")[1]).find("a")).find("input[type='hidden']").val();
		var url="http://10.20.30.42:3000/read/showarticle?article_id="+id;
		var imgurl="http://edu.hcdglobal.com/download"+$(this).parents(".span3").siblings(".span3").find("img").attr("src");
		var title=$($($(this).parents(".span3").siblings(".span5")[1]).find("p")[0]).html().substring(0,150)+"..."
		var params='url='+url+'&title='+title+'&pic='+imgurl;
		window.open('http://v.t.sina.com.cn/share/share.php?'+params,'_blank','width=450,height=400');
	});
	
	$(".sina-share-qa a").die("click");
	$(".sina-share-qa a").live('click',function(event){
		event.preventDefault();
		var id=$($($($(this).parents(".span3").siblings(".span8")[2]).find("p")[1]).find("a")).find("input[type='hidden']").val();
		var url="http://10.20.30.42:3000/read/showarticle?article_id="+id;
		var title="你是否也遇到过这种问题:"+$($($(this).parents(".span3").siblings(".span8")[0]).find("p")[0]).html().substring(0,120)+"..."+"看导师如何回答";
		var params='url='+url+'&title='+title;//+'&pic='+imgurl;
		window.open('http://v.t.sina.com.cn/share/share.php?'+params,'_blank','width=450,height=400');
	});
});
function listinit(){
	$(".nav-list li").removeClass("active");
	$(".select-tags a i").removeClass("icon-white");
};
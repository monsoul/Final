var max = 0;
var count=0;
var counts=0;
var page=1;
var flag=true;
var param='?article_type=all&tag_id=all';
$(document).ready(function (){
	if(!$("#total-count").val()){
		$("#show-one-article").css("display","none");
		firstload(param);
		selectload();
	}
	else{
//		alert($("#total-count").val());
//		$("#show-articles").fadeIn(1000);
//		$("#all-articles").fadeIn(1000);
	}
	$(".select-type a").die("click");
	$(".select-type a").live('click',function(){
		var type=$(this).find("input[type='hidden']").val();
		var params="?article_type="+type+"&tag_id=all";
		firstload(params);
		selectload();
	});
	$(".choose-tags a").die("click");
	$(".choose-tags a").live('click',function(){
		var tag_id=$(this).find("input[type='hidden']").val();
		var params="?article_type=all"+"&tag_id="+tag_id;
		firstload(params);
		selectload();
	});
	$(window).scroll(function(){ 
		var params=$("#ajax-params").val();
		var loadtype=$("#load-type").val();
		if(loadtype=="load-articles"){
			if(arrivedAtBottom()){
				if(max-count>=1){
					flag=true;
					for(var i=0;i<4;i++){
						if(i==3||page==counts){
							flag=false;
							loadMore(params,page,flag);
							page++;
							count++;
							break;
						}
						else{
							loadMore(params,page,flag);
						}
						page++;
					}
				}
				else{
					//alert("没有数据了");
				}
			} 		
		}
	}); 
});
function selectload(){
	max = 0;
	count=0;
	counts=0;
	page=1;
	flag=true;
	counts=$("#total-count").val();
	param=$("#ajax-params").val();
	if(counts){
		if(counts%2==0){
			max=counts/4;
		}
		else{
			max=counts/4+1;
		}
	}
	if(counts>=4){
		for (page=1;page<=4;page++)
		{
			if(page==4){
				flag=false;
			}
			loadMore(param,page,flag);
		}
		$("#show-articles").fadeIn(1000);
		$("#all-articles").fadeIn(1000);
		$(".tags-width").fadeIn(1000);
		count+=1;
	}
	else{
		for (page=1;page<=counts;page++)
		{
			var flag=true;
			if(page==counts){
				flag=false;
			}
			loadMore(param,page,flag);
		}
		$("#show-one-article").css("display","none");
		$("#show-articles").fadeIn(1000);
		$("#all-articles").fadeIn(1000);
		$(".tags-width").fadeIn(1000);
	count+=1;
	}
}
function firstload(params){
	var time=new Date().getTime();
	time="&t="+time;
	var myurl="/read/articles"+params+time;
	$.ajax({
		type:"GET",
		url : myurl,
		async: false,
		success:function(data){
			$("#show-articles").html(data);
		}
	});
}
function arrivedAtBottom(){
    return $(document).scrollTop() + $(window).height() == $(document).height();
}
function loadMore(params,page,flag)
{
	var time=new Date().getTime();
	time="&t="+time;
	var myurl='/read/article'+params+'&page='+page+time;
	$.ajax({
		type:"GET",		
		url : myurl,
		success : function(data){
			$("#all-articles").append(data);
		}
	});
}
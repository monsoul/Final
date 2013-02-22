$(function(){
	check_user_status();
	$("#school-dialog").on('show', function () {
		$("#applicant-dialog").modal('hide');
	});
	/*
	$("#school-dialog").on('hidden', function () {
		$("#show-school").empty();
		$("#applicant-dialog").modal('show');
	});
	*/
	$("#applicant-dialog").on('show',function(){
		var applicant_schoolid=$("#applicant_schoolid").val();
		var applicant_school=$("#applicant_school").val();
		if(applicant_schoolid&&applicant_school){
			$("#show-school").empty();
			$("#school-dialog").modal('hide');
		}
	});
	$("#teacher-dialog").on('show',function(){
		$("#qa-dialog").modal('hide');
		var time=new Date().getTime();
		time="?t="+time;
		var myurl="/home/teachers"+time;
		$.ajax({
			type:"GET",
			url:myurl,
			success:function(data){
				$("#show-teacher").html(data);
			}
		});
	});
	/*
	$("#teacher-dialog").on('hidden', function () {
		$("#show-teacher").empty();
		$("#qa-dialog").modal('show');
	});
	*/
	$("#qa-dialog").on('show',function(){
		var teacher_id=$("#teacher_id").val();
		var ask_user=$("#ask_user").val();
		if(teacher_id&&ask_user){
			$("#show-teacher").empty();
			$("#teacher-dialog").modal('hide');
		}
	});
	
	$("#answerqa-dialog").on('show',function(){
		question_load();
	});	
	//头像
	$(".img-close").die("click");
	$(".img-close").live('click',function(){
		$(".img-close").removeClass("img-active");
		$(this).addClass("img-active");
	});
	$("#login-dialog").on('show',function(){
		$("#login-form").resetForm();
		$("#login-error").css("display","none");
		$('#loginbtn').button('reset');
	});
	$("#allquestion-dialog").on('show',function(){
		allquestion_load();
	});
	$(".show-citys a").click(function(event){
		event.preventDefault();
		var city = $(this).attr("title");
		var time=new Date().getTime();
		time="&t="+time;
		var myurl="/home/schools"+"?city=";
		myurl+=city;
		myurl+=time;
		$.ajax({
			type:"GET",
			url:myurl,
			success:function(data){
				$("#show-school").html(data);
				$("#applicant-dialog").modal('hide');
			}
		});	
	});	
	$(".select-teacher-ask a").die("click");
	$(".select-teacher-ask a").live('click',function(event){
		var teacherid=$($(this).find("input[type='hidden']")).val();
		$("#teacher_id").val(teacherid);
		$("#ask_user").val($(this).attr("title"));
		$("#select-teacher").css("visibility","hidden");
		$("#user-info-dialog").modal('hide');
		$("#qa-dialog").modal('show');
	});
	$(".normal-ask").click(function(){
		$("#teacher_id").val("");
		$("#ask_user").val("");
		$("#ask_title").val("");
		$("#ask_content").val("");
		$("#select-teacher").css("visibility","visible");
	});
	//不带参数的ajax
	$(".index-link a").die("click");
	$(".index-link a").live('click',function(){
		myajax(this);
	});
	
	$(".user-learn-more").die("click");
	$(".user-learn-more").live('click',function(event){
		event.preventDefault();
		var time=new Date().getTime();
		time="&t="+time;
		var id=$(this).find("input[type='hidden']").val();
		var url="/home/userinfodialog?user_id="+id;
		url+=time;
		$.ajax({
			cache:false,
			type: "GET",
			url: url,
			async: false,
			success: function (data){
				$("#user-info-dialog").html(data);
			}
		});
		$("#user-info-dialog").modal('show');
	});
	$(".space-jump a").die("click");
	$(".space-jump a").live('click',function(event){
		var num=$("#space-num").val();
		url="http://10.20.30.42:3000";
		myjump("#space-num",num,url);
	});
	$(".select-pic a").die("click");
	$(".select-pic a").live('click',function(event){
		event.preventDefault();
		var loading="<img src='http://list.image.baidu.com/t/loading_circle.gif' style='padding:100px 200px;'>";
		$("#user-info").html(loading);
		var id=$(this).find("input[type='hidden']").val();
		var myurl="/home/userinfo?user_id="+id;
		var time=new Date().getTime();
		time="&t="+time;
		myurl+=time;		
		$.ajax({
			cache:false,
			type: "GET",
			url: myurl,
			async: false,
			success: function (data) {
				$("#user-info").css("display","none");
				$("#user-info").html(data);
				$("#user-info").fadeIn(1000);
			}
		});
	});
	$("#submit-applicant").click(function(){
		var comment=$("#applicant_comment").val();
		var params=$('input').serialize();
		params+="&applicant_comment=";
		params+=comment;   
		$.ajax({
			type:"POST",
			url:"/home/applicant",
			data:params,
			datatype:"json",
			success:function(data){
				$("#applicant_schoolid").val("");
				$("#applicant-form").resetForm();
				alert(data.message);
				$("#applicant-dialog").modal('hide');
			}
		});
	});
	$("#loginbtn").click(function(event){
		$("#loginbtn").button('loading');
		event.preventDefault();
		$("#errorinfo").css("visibility","hidden");
		var params=$('input').serialize();
		$.ajax({
			type:"POST",
			url:"/home/login",
			data:params,
			datatype:"json",
			success:function(data){
				if(data.message=="success"){
					$('#loginbtn').button('complete');
					$("#login-error").fadeOut(100);
					check_user_status();
					/*
					var value=$.cookie("username");
					userid=$.cookie("userid");
					var eidtinfo_url="/home/editinfo/?user_id="+userid;
					value+="<b class='caret'></b>";
					$("#login-success-li").css("display","block");
					$("#longin-li").css("display","none");
					$("#login-nickname").html(value);
					$("#editinfo-url").val(eidtinfo_url);
					$(".article-alert").css("display","none");
					*/
					setTimeout("$('#login-dialog').modal('hide')",1000);
				}
				else{
					$("#login-error").html("用户名或者密码错误或账号处于未激活状态");
					$("#login-error").fadeIn(100);
					$('#loginbtn').button('reset');
					return;
				}
			}
		});
	});
	$("#ask-btn").click(function(event){
		event.preventDefault();
		var params=$('input').serialize();
		var content="&ask_content="+$("#ask_content").val();
		params+=content;
		params['authenticity_token'] = $('meta[name="csrf-token"]').attr('content');
		$.ajax({
			type:"POST",
			url:"/home/ask_question",
			data:params,
			datatype:"json",
			success:function(data){
				if(data.message=="need_login"){
					$("#qa-dialog").modal('hide');
					$("#login-dialog").modal('show');
					$("#login-error").html("登陆之后才能提交问题");
					$("#login-error").fadeIn(100);
				}
				else{
					alert(data.message);
				}
			}
		});
	});
	$("#answer-btn").click(function(event){
		event.preventDefault();
		var params=$('input').serialize();
		var content="&content="+$("#answer_content").val();
		params+=content;
		$.ajax({
			type:"POST",
			url:"/home/answer_question",
			data:params,
			async:true,
			datatype:"json",
			success:function(data){
				alert(data.message);
				question_load();
			}
		});
	});
});
function myajax(name){
	var realurl = $(name).find("input[type='hidden']");
	var time=new Date().getTime();
	time="?t="+time;
	var myurl = realurl.val()+time;
	$.ajax({
		cache:false,
		type: "GET",
		url: myurl,
		async: false,
		success: function (data) {
			$("#pageload").html(data);
		}
	});
};
function myajax_withid(name){
	var realurl = $(name).find("input[type='hidden']");
	var time=new Date().getTime();
	time="&t="+time;
	var myurl = realurl.val()+time;
	$.ajax({
		cache:false,
		type: "GET",
		url: myurl,
		async: false,
		success: function (data) {
			$("#pageload").html(data);
		}
	});
};
function question_load(){
	$("#all-questions").empty("");
	$("#question_content").css("display","none");
	$("#answer_id").val("");
	$("#answer_title").val("");
	$("#answer_userid").val("");
	$("#ask_user_id").val("");
	$("#answer-title").html("");
	$("#answer-content").html("");
	$("#answer_content").val("");
	var time=new Date().getTime();
	time="?t="+time;
	var myurl="/home/ask_questions"+time;
	$.ajax({
		type:"GET",
		url:myurl,
		success:function(data){
			$("#all-questions").html(data);
		}
	});
};
function move_up(name,time){
	$(name).animate({display: "none", top: "0"}, 1) 
	.animate({opacity:"0",top:"+=400"},1).delay(time)
	.animate({opacity: "1", top: "-=420"}, 1000) 
	.animate({top: "+=10"}, 200) 
	.animate({top: "+=20"}, 200) 
	.animate({top: "-=10"}, 200)
	.animate({top: "+=5"}, 200)			 
	.animate({top: "0"}, 200);
}
function closedialog(name){
	name.modal('hide');
}
function check_user_status(){
	var userid=$.cookie("userid");
	var username=$.cookie("username");
	var role=$.cookie("role");
	var role_teacher="<li class='divider'></li><li class='nav-header'>老师操作</li><li><a data-toggle='modal' href='#answerqa-dialog' data-keyboard='true' data-backdrop='true'>回答</a></li>";
	var role_admin="<li class='divider'></li><li class='nav-header'>管理员操作</li><li><a href='#'>进入后台</a></li>";
	if(userid!=null&&username!=null&&role!=null){
		var value=username;
		var eidtinfo_url="/home/editinfo/?user_id="+userid;
		value+="<b class='caret'></b>";
		$("#login-success-li").css("display","block");
		$(".article-alert").css("display","none");
		$("#longin-li").css("display","none");
		$("#login-nickname").html(value);
		$("#editinfo-url").val(eidtinfo_url);
		
		if(role=="teacher"){
			$("#special-operation").html(role_teacher);
		}
		else if(role=="admin"){
			$("#special-operation").html(role_admin);
		}
		else{
			$("#special-operation").html("");
		}
	}
	else{
		$("#login-success-li").css("display","none");
		$("#login-li").css("display","block");
	}
}
function allquestion_load(){
	var time=new Date().getTime();
	time="?t="+time;
	var myurl="/home/all_questions"+time;
	$.ajax({
		type:"GET",
		url:myurl,
		success:function(data){
			$("#show-question").html(data);
		}
	});
}
function myjump(name,count,url) {  
    window.setTimeout(function(){  
        count--;  
        if(count > 0) {  
            $(name).html(count);
            myjump(name,count,url);  
        } else {  
            location.href=url;  
        }  
    }, 1000);  
}
function loading(string){
	$("#loading-status").html(string);
	$("#loading-bar").fadeIn(500);
};
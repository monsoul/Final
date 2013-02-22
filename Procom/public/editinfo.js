$(function(){
	$("#procom-read").removeClass("active");
	$("#myCarousel").css("display","none");
	$(".space-button-well").css("display","none");
	$("#footer").css("display","block");
	$("#save-password").click(function(){
		var params=$('input').serialize();
		$.ajax({
			type:"POST",
			url:"/home/editinfo",
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
})
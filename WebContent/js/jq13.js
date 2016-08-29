$(document).ready(function() {
	$("#btn1").on("click", function() { // xml
		$("#disp").empty();
		$.ajax({
			type : "get",
			url : "jq13_1.jsp",
			dataType : "xml",
			success : function(data) {
				// $("#disp").text(data);;
				var str = "";
				$(data).find("person").each(function() {
					str += $(this).find("irum").text() + " ";
				});
				$("#disp").append(str);
				;
			},
			error : function() {
				$("#disp").text("에러 발생");
				;
			},
		/*
		 * statusCode : { 200 : function(){ alert("읽기성공"); }, 400 : function(){
		 * alert("파일찾기 실패"); }, 500 : function(){ alert("파일 오류"); } }
		 */
		});
	});

	$("#btn2").on("click", function() { // xml - para
		$("#disp").empty();
		var my = $.ajax({
			type : "post",
			url : "jq13_2.jsp",
			data : {
				"irum" : "장비"
			},
			dataType : "xml",
			success : function(data) {
				// $("#disp").text(data);;
				var str = "";
				$(data).find("person").each(function() {
					str += $(this).find("irum").text() + " ";
				});
				$("#disp").append(str);
				;
			}
		});

		my.fail(function(status) {
			$("#disp").text("처리 실패" + status);
		});
	});

	$("#btn3").click(function() { // xml
		$.ajax({
			type : "get",
			url : "jq13_1json.jsp",
			dataType : "json",
			success : function(data) {
				var str = "";
				// alert(data);
				// $("#disp").text("");
				$.each(data, function(index, entry) {
					str += entry["name"] + ", " + entry["age"];
				});
				$("#disp").append(str);
			},
			error : function() {
				$("#disp").text("에러 발생");
			},
		});
	});

	$("#btn4").on("click", function() { // josn - para
		
	});
});
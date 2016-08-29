$(document).ready(function(){
	$("#addform").hide();
	$("#delform").hide();
	$("#code_err1").hide();
	$("#code_err2").hide();
	$("#sang_err").hide();
	$("#su_err").hide();
	$("#dan_err").hide();
	$("#delcode_err").hide();
	
	$("#btn_add").on("click",function(){
		$("#addform").slideToggle("fast");	// toggle은 한번클릭시 기능활성화 한번더 클릭시 기능 해제;
		$("#txtcode").focus();
	});
	
	$("#btn_del").on("click",function(){
		$("#delform").slideToggle("fast");
		$("#delcode").focus();
	});
	
	$("#btn_all").on("click", dispall);
	$("#btn_insert").on("click", insertData);
	$("#deldata").on("click", deleteData);
	
	$("#btn_cancel").on("click", function(){
		$("#txtcode").val("");
		$("#txtsang").val("");
		$("#txtsu").val("");
		$("#txtdan").val("");
		$("#addform").slideToggle("fast");
	});
	
	$("#delcancel").on("click", function(){
		$("#delcode").val("");
		$("#delform").slideToggle("fast");
	});
});

function dispall(){
	$.getJSON("jq15all.jsp", function(data){
		$("#disp").empty();
		//alert(data);
		var str = "<table border = '1'><tr><th>코드</th><th>상품</th><th>수량</th><th>단가</th></tr>";
		$.each(data,function(index, enter){
			str += "<tr><td>" + enter.code + "</td>";
			str += "<td>" + enter.sang + "</td>";
			str += "<td>" + enter.su + "</td>";
			str += "<td>" + enter.dan + "</td></tr>";
		});
		str += "</table>";
		$("#disp").append(str);
	});
}

function insertData(){
	var code = $("#txtcode").val();
	var sang = $("#txtsang").val();
	var su = $("#txtsu").val();
	var dan = $("#txtdan").val();
	
	//code check
	if(code.length < 1){
		$("#code_err1").show();
	}else{
		$("#code_err1").hide();
	}
	
	//sang check
	if(sang.length < 1){
		$("#sang_err").show();
	}else{
		$("#sang_err").hide();
	}
	
	//su check
	
	if(isNaN(su) || su.length < 1){
		$("#su_err").show();
	}else{
		$("#su_err").hide();
	}
	
	//dan check
	if(isNaN(dan) || dan.length < 1){
		$("#dan_err").show();
	}else{
		$("#dan_err").hide();
	}
	
	//추가작업진해
	$.ajax({
		type : "post", url : "jq15insert.jsp", data : {"code" : code, "sang" : sang, "su" : su, "dan" : dan},
		success : function(data){
			if(data.trim() === "f"){
				alert("상품추가 실패!")
				return false;
			}
			alert("상품 추가 성공!")
			$("#txtcode").val("");
			$("#txtsang").val("");
			$("#txtsu").val("");
			$("#txtdan").val("");
			$("#txtcode").focus();
			dispall();
			
		},
		error : function(){
			alert("상품 추가 오류");
		}
	});
}

function deleteData(){
	var dcode = $("#delcode").val();
	if(isNaN(dcode) || dcode.length < 1){
		$("#delcode_err").show();
	}else{
		$("#delcode_err").hide();
	}
	$.ajax({
		type : "post", url : "jq15del.jsp" , data :{"dcode" : dcode},
		success : function(data){
			//alert(data);
			if(data.trim() == "f"){
				alert("상품삭제  실패");
				return false;
			}
			
			$("#delcode").val("");
			$("#delform").slideToggle("fast");
			dispall();
		},
		errpr : function(){
			alert("상품삭제오류");
		}
	});
}




















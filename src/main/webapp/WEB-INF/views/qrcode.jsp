<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.myschool.VO.StudentInfoVO"%>
<% StudentInfoVO user=(StudentInfoVO)session.getAttribute("user"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0,user-scaleable=no,maximum-scale=1,width=device-width">
<title>QRCODE</title>
<!-- 구글 폰트 -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.15.3/css/all.css"
	integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk"
	crossorigin="anonymous">
<link href="/attend/${path}/resources/css/qrcode.css" rel="stylesheet">
<!-- JQuery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<header>
			<div class="logo">
				<img src="/attend/resources/school.jpg">
			</div>
	</header>
	<div>
		<h3><%=user.getName()%>님의 출석체크 QR코드</h3>
		<div>
			<img src="/attend/resources/user/<%= user.getNum() %>_qrcode.png" style="width:100px; height:100px;">
		</div>
		<div class="notice">
			사용법
		</div>
		<div class="notice_yes">
			PC일시 오른쪽 마우스로 사진 저장하여 사용
		</div>
		<div class="notice_yes">
			핸드폰일시 꾹 눌러 사진 저장하여 사용
		</div>
	</div>
<%@ include file="/WEB-INF/views/button.jsp" %>
</body>
<script>
function change() {
    let background = document.getElementById("background");
    let btn = document.getElementById("btn_a");
    background.style.display = "block";
    btn.style.display = "flex";
}

//.modal밖에 클릭시 닫힘
$("#background").click(function (e) {
    console.log("눌림")
    if (e.target.className != "btn") {
        $('#background').css("display", "none");
        $('#btn_a').css("display", "none");

    } else {
        return false;

    }
});


$("#modal2_btn").click(function () {
    let memo = document.getElementById("textt").value;
    $.ajax({
        type: "GET",
        url: '/addmemo',
        data: { memo: memo },
        success: function (data) {
            if (data == "success")
                window.location.href = "/main";
            else {

            }
        }
    });
});

</script>
</html>
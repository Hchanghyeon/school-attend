<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.myschool.VO.StudentInfoVO"%>
<% StudentInfoVO user=(StudentInfoVO)session.getAttribute("user");%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
	content="width=device-width, initial-scale=1.0,user-scaleable=no,maximum-scale=1,width=device-width">
<title>메인페이지</title>
<!-- 구글 폰트 -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.15.3/css/all.css"
	integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk"
	crossorigin="anonymous">
    <link href="/attend/${path}/resources/css/item_info.css" rel="stylesheet">
    <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
    <div class="main">
        <header>
			<div class="logo">
				<img src="/attend/${path}/resources/school.jpg">
			</div>
            <div class="student_img">
                <img src="/attend/${path}/resources/user/${user.imgsrc}">
            </div>
            <div class="student_info">
                <div class="student_header">이름</div>
                <div class="student_section">${user.name}</div>
            </div>
            <div class="student_info">
                <div class="student_header">학번</div>
                <div class="student_section">${user.num}</div>
            </div>
            <div class="student_info">
                <div class="student_header">학과</div>
                <div class="student_section">${user.com}</div>
            </div>
            <div class="student_info">
                <div class="student_header">구분</div>
                <div class="student_section">${user.sel}</div>
            </div>
            <div class="student_info">
                <div class="student_header">월 근무</div>
                <div class="student_section">${t}</div>
            </div>
		</header>
        <section>
            <div class="section_header">
                재료/재고 정보
            </div>
            <form action="/attend/itemdelete" method="post">
            	<div class="head"><b>구분</b><input type="text" name="title" placeholder="구분" value="${com.categori}" readonly></div>
                <div class="head"><b>위치</b><input type="text" name="title" placeholder="위치" value="${com.itemloc}" readonly></div>
                <div class="head"><b>재료명</b><input id="itemname" type="text" name="title" placeholder="제목을 입력해주세요" value="${com.itemname}" readonly></div>
                <div class="head"><b>규격</b><input type="text" name="title" placeholder="규격" value="${com.itemname2}" readonly></div>
                <div class="head"><b>개수</b><input id="itemcount" type="text" name="title" placeholder="개수" value="${com.itemcount}" readonly><div class="itemcount_"><a onclick="countminus();"><i class="fas fa-minus-circle"></i></a><span id="countstar">${com.itemcount}</span><a onclick="countplus();"><i class="fas fa-plus-circle"></i></a></div></div>
                <div class="head">
                                <b>등록자</b>
 					<input type="text" name="title" placeholder="제목을 입력해주세요" value="${com.studentname}" readonly>
                </div>
                <div class="head">
                                <b>등록된 날짜</b>
 					<input type="text" name="title" placeholder="제목을 입력해주세요" value="${com.date}" readonly>
                </div>
                <input type="hidden" name="num" value="${com.num}">
                	<div class="sub_btn">
                    	<button type="button" onclick="gowhere();">돌아가기</button>
                    	<button type="button" onclick="gowhere();">수정하기</button>
						<input type="submit" value="재료삭제">
					</div>
            </form>
        </section>
    </div>
	<%@ include file="/WEB-INF/views/button.jsp" %>
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

function gowhere() {
	location.href="/attend/itemlist";
}

function countplus() {
	 let d1 = document.getElementById("itemcount");
	 let d2 = document.getElementById("countstar");
	 let num = ${com.num}
	 $.ajax({
         type: "POST",
         url: '/attend/item/plus',
         data: { text: num },
         success: function (jarray) {
        	console.log(jarray);
     		d1.value = jarray;
     		d2.innerHTML = jarray;
         }
     });	
}

function countminus() {
	 let d1 = document.getElementById("itemcount");
	 let d2 = document.getElementById("countstar");
	 let num = ${com.num}
	 $.ajax({
         type: "POST",
         url: '/attend/item/minus',
         data: { text: num },
         success: function (jarray) {
        	 console.log(jarray);
     		d1.value = jarray;
     		d2.innerHTML = jarray;
         }
     });	
}

    </script>
</body>
</html>
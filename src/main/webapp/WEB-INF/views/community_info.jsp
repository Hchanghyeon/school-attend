<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.myschool.VO.StudentInfoVO"%>
<c:set var="data" value="${com.num}" ></c:set>
<% StudentInfoVO user=(StudentInfoVO)session.getAttribute("user");
String data = (String)pageContext.getAttribute("data");%>

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
    <link href="/attend/${path}/resources/css/community_info.css" rel="stylesheet">
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
                글 정보
            </div>
            <form action="/attend/communitydelete" method="post">
            	<div class="head"><b>글번호</b><input type="text" name="title" placeholder="제목을 입력해주세요" value="${com.numb}" readonly></div>
                <div class="head"><b>제목</b><input type="text" name="title" placeholder="제목을 입력해주세요" value="${com.title}" readonly></div>
                <div class="head"><b>작성시간</b><input type="text" name="title" placeholder="제목을 입력해주세요" value="${com.date}" readonly></div>
                <div class="head">
                <b>카테고리</b>
 					<input type="text" name="title" placeholder="제목을 입력해주세요" value="${com.categori}" readonly>
                </div>
                <div class="content">
                    <b>내용</b>
                    <textarea name="content" placeholder="글의 내용을 입력해주세요" readonly>${com.content}</textarea>
                </div>
                <div class="filebox">
                    <b>첨부파일</b>
                    <div>
	                    <a href="/attend/resources/upload/${com.filesrc}">${com.filesrc}</a>
                    </div>
                  </div>
                  <input type="hidden" name="numb" value="${com.numb}">
                <div class="sub_btn">
                    <button type="button" onclick="gowhere();">돌아가기</button>
                    
                    <% if(user.getNum().equals(data)){
                     %>
                    	<input type="submit" value="글삭제"></div>
                     <% 
                    	}
                     %>
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
	location.href="/attend/community";
}

$(document).ready(function(){ 
  var fileTarget = $('#file'); 
  fileTarget.on('change', function(){ // 값이 변경되면
      var cur=$(".filebox input[type='file']").val();
    $(".upload-name").val(cur);
  }); 
}); 
    </script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0,user-scaleable=no,maximum-scale=1,width=device-width">
<title>컴퓨터 공학부 출석체크</title>
<link href="/attend/${path}/resources/css/choose.css" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet"> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
</head>
<body>
	<div id="height">
		 
		<div>
			<div id="imgdiv">
				<a href="/attend/choose"><img src="/attend/${path}/resources/school.jpg" id="school"></a>
			</div>			
			<div id="main">
				<button onclick="location.href='/attend/video?value=yes'">출근</button>
				<button onclick="location.href='/attend/video?value=no'">퇴근</button>
			</div>
			<h1 id="h11">컴퓨터공학부</h1>
			<h1>근로장학생 출석체크</h1>
					<div id="main" class="main3">금일 출근한 학생</div>
		<div id="abc">
		<c:set var="path" value="${pageContext.request.contextPath}"/>
	    <c:forEach items="${attended}" var="attended">
	    	<div>
	    		   <i class="fas fa-lightbulb"></i>
                   <b>${attended.name}</b>
             </div>
		</c:forEach>
		</div>
		</div>
	</div>
	<script>
	
	   var time = 1000 * 60 * 60 * 3;
	   var timer = setInterval(function(){
		   $.ajax({
	    		type : "post",
	    		url : "/attend/refresh",
	    		data : {data2:"hi"},
	    		success : function(data) {
	    			console.log("성공");
	    		},
	    		error : function(){
	                console.log("통신실패");
	            }
	    	});
	    }, time)
	</script>
</body>
</html>
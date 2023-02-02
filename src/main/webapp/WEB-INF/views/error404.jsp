<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- initial-scale 뒤 문구 쓰면 핸드폰에서 input 클릭시 확대 안되게함 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0,user-scaleable=no,maximum-scale=1,width=device-width">
    <title>에러페이지</title>
    <!-- fontawesome 아이콘 -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
    <!-- 구글폰트 -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
    <!-- CSS -->
    <link href="/attend/${path}/resources/css/error.css" rel="stylesheet" type="text/css">
    <!-- JQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> 
    <!-- Vue.js -->
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
</head>
<body>
	<div>
		<div>
			<div class="logo"><img src="/attend/resources/school.jpg"></div>
			<div id="error">에러페이지</div>
			<div id="errortext">페이지가 준비중이거나 없는 페이지입니다.</div>
			<div><button id="button" onclick="history.go(-1);">돌아가기</button></div>
		</div>
	</div>
	<script>
	</script>
</body>
</html>
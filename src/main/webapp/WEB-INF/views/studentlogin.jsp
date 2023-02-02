<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,user-scaleable=no,maximum-scale=1,width=device-width">
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Ropa+Sans" rel="stylesheet"> 
<title>Insert title here</title>
<link href="/attend/${path}/resources/css/studentlogin.css" rel="stylesheet"> 
</head>
<body>
	<div id="main">
	<div>
	<header>
		<img src="/attend/${path}/resources/school.jpg">
	</header>
	<header>
		<p>컴퓨터공학부 근로장학생 로그인</p>
	</header>
	<form action="" method="post">
	<div class="tt">
			<b>학번</b>  <input type="text" name="studentnum" id="num" placeholder="학번을 입력하세요">
	</div>
	<div class="tt">
			<b>패스워드</b>  <input type="password" name="studentpwd" id="pwd" placeholder="비밀번호를 입력하세요">
	</div>
	<div class="tt" id="aa">
		<span><a href="/attend/studentregister/">회원가입</a></span>
	</div>
	<div class="tt">
			<input type="button" value="로그인" onclick="checkid()">
	</div>
	</form>
	</div>
	<div id="modal2" class="modal2">
    	<div>
    		<div>
    			<div class="modaldata"></div>
    			<div><button>확인</button></div>
    		</div>
    	</div>
    </div>
    </div>
	    <script>
    	function checkid() {
            var userNum  = $('#num').val() ;
            var userPwd = $('#pwd').val() ;
            
            $.ajax({
                type : "POST",
                url: '/attend/stulogin',
                data: {userNum:userNum, userPwd:userPwd},
                success: function(data) {
                    if(data == "로그인"){
                    	window.location.href="/attend/main";
                    }
                    else if(data == "관리자로그인"){
                    	window.location.href="/attend/adminmain"
                    }
                    else {
                    		 $('.modal2').css("display","flex");
                    		 $('.modaldata').html(data);
                         
                         	//.modal안에 button을 클릭하면 .modal닫기
                         	$(".modal2 button").click(function(){
                        	 	$('.modal2').css("display","none");
                         	});
                         
                         	//.modal밖에 클릭시 닫힘
                         	$(".modal2").click(function (e) {
	                         	if (e.target.className != "modal2") {
                           			return false;
                         		} else {
                        		 	$('.modal2').css("display","none");
                         		}
                   		 
                		 	});
                		}
                }
            });
    	}
    </script>
</body>
</html>
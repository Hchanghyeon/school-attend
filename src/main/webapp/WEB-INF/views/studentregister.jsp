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
<link href="/attend/${path}/resources/css/studentregister.css" rel="stylesheet"> 
<!-- Vue.js -->
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
</head>
<body>
	<div id="main">
	<div id="app">
	<header>
		<a href="/attend/studentlogin"><img src="/attend/${path}/resources/school.jpg"></a>
	</header>
	<header>
		<p>컴퓨터공학부 사무실 회원가입</p>
	</header>
	<form action="/attend/sturegister" method="post">
	<div class="tt">
			<b>학번</b><input type="text" name="num" id="num"  placeholder="학생은 학번을 선생님은 아이디를 입력하세요">
	</div>
	
	<div class="tt">
			<b>패스워드</b><input type="password" name="pwd" id="pwd" v-model="pwd1" placeholder="비밀번호를 입력하세요">
	</div>
	<div class="pss">최소 8자리에서 최대 16자리까지 숫자, 영문, 특수문자 각 1개 이상 포함</div>
	<div class="tt">
            <b>패스워드 확인</b>
            <input type="password" id="pw2" name="pw2" placeholder="비밀번호를 확인" v-model="pwd2" pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,16}$" required>
    </div>
          <div class="tt">
                <div v-if='reversedMessage[0]==0' class="passcheck">
                	{{reversedMessage[1]}}
                </div>
               </div>
               <div class="tt">
                <div v-if='reversedMessage[0]==1' style="font-size:13px; color:blue" class="passcheck">
                	{{reversedMessage[1]}}
                </div>
                </div>
                <div class="tt">
                <div v-if='reversedMessage[0]==2' style="font-size:13px; color:red" class="passcheck">
                	{{reversedMessage[1]}}
                </div>
                </div>
	<div class="tt">
			<b>이름</b><input type="text" name="name" id="name" placeholder="이름을 입력하세요">
	</div>
	<div class="tt">
			<b>학과</b>
			<select name="com">
				<option value="컴퓨터소프트웨어공학과">컴퓨터소프트웨어공학과</option>
				<option value="컴퓨터정보공학과">컴퓨터정보공학과</option>
				<option value="인공지능소프트웨어공학과">인공지능소프트웨어공학과</option>
				<option value="컴퓨터공학과">(선생님 전용)컴퓨터공학부</option>
			</select>
	</div>
	<div class="tt">
			<b>구분</b>
			<select name="sel">
				<option value="학생">학생</option>
				<option value="선생님">선생님</option>
			</select>
	</div>
	<div class="tt">
			<input type="submit" value="회원가입">
	</div>
	
	</form>
	</div>
	</div>
	<script>
    const app = new Vue({
    	el:'#app',
    	data: {
    		pwd1:'',
    		pwd2:'',
    		pwd3:'',
    	},
        computed: {
        	reversedMessage: function () {
        	if((this.pwd1==''&&this.pwd2=='')){
        		return [0, '']
        	}
        	else if(this.pwd1==this.pwd2){
        		return [1, '비밀번호가 같습니다']
        		
        	} else {
        		return [2, '비밀번호가 다릅니다']
        	}
        	return null;
          },
          password: function(){
          	if((this.pwd1=='')){
        		return ''
        	}
        	else {
        		return '비밀번호는 특수, 영어, 숫자 포함 8글자 ~ 16글자'
        	}
          }
    	}
    })
	
	</script>
</body>
</html>
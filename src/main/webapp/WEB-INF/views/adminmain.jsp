<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ page import="com.myschool.VO.StudentInfoVO" %>
 <% StudentInfoVO user = (StudentInfoVO)session.getAttribute("user"); %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,user-scaleable=no,maximum-scale=1,width=device-width">
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Ropa+Sans" rel="stylesheet"> 
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
<title>Insert title here</title>
<link href="/attend/${path}/resources/css/main2.css" rel="stylesheet"> 
<!-- Vue.js -->
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
</head>
<body>
	<header>
		<a href="/choose"><img src="/attend/${path}/resources/school.jpg"></a>
		<div id="a"><%= user.getName() %>님</div>
	</header>
	<c:set var="path" value="${pageContext.request.contextPath}"/>
	<section>
		<div id="main" class="main3">금일 출근한 학생</div>
		<div id="abc">
	    <c:forEach items="${attending}" var="attending">
	    	<div>
	    		   <i class="fas fa-lightbulb"></i>
                   <b>${attending.name}</b>
             </div>
		</c:forEach>
		</div>
			<p></p>

<div class="h33">
<h3></h3>
</div>
<div id="main">학생 출석 수동 입력 </div>
		<div id="com">
		<div id="main2">
		<div>
		<div id="aaa">날짜는 꼭 ex) 2021/07/19/18:00 이런 식으로 맞춰주세요!</div>
		<div>
		<form action="/attend/adminattendstu" method="post">
		<select name="num">
     	<c:forEach items="${allstudent}" var="allstudent">
              <option value="${allstudent.num}">${allstudent.name}</option>
		</c:forEach>
		</select>
		<select name="attend">
			<option value="출석">출석
			</option>
			<option value="퇴근">퇴근
		</select>
		<input type="text" name="date" placeholder="ex)2021/07/19/18:00">
		<input type="submit" value="추가">
		</form>
		</div>
		</div>
		</div>
		</div>
		
	<div class="h33">
    <h3 align="center">학생 근무 달력</h3>
    </div>
    	<div>
		<form action="/attend/adminmain" method="post">
		<select name="num">
     	<c:forEach items="${allstudent}" var="allstudent">
              <option value="${allstudent.num}">${allstudent.name}</option>
		</c:forEach>
		</select>
		<input type="submit" value="보기">
		</form>
		</div>
	<table id="calendar" border="3" align="center" style="border-color:#3333FF ">
	<tbody>
    <tr class="tb"><!-- label은 마우스로 클릭을 편하게 해줌 -->
        <td><label onclick="prevCalendar()"><</label></td>
        <td align="center" id="tbCalendarYM" colspan="5">
        yyyy년 m월</td>
        <td><label onclick="nextCalendar()">>
            
        </label></td>
    </tr>
    <tr class="ta">
        <td align="center"><font color ="#F79DC2">일</td>
        <td align="center">월</td>
        <td align="center">화</td>
        <td align="center">수</td>
        <td align="center">목</td>
        <td align="center">금</td>
        <td align="center"><font color ="skyblue">토</td>
    </tr> 
    </tbody>
</table>
	</section>
<script>
	var att = document.querySelectorAll(".att");
	att.forEach(a => {
		if(a.innerHTML == '출석'){
			a.style.color = 'blue';
		} else {
			a.style.color = 'red';
		}
	})

        var today = new Date();//오늘 날짜//내 컴퓨터 로컬을 기준으로 today에 Date 객체를 넣어줌
        var date = new Date();//today의 Date를 세어주는 역할
        function prevCalendar() {
         today = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
         buildCalendar(); //달력 cell 만들어 출력 
        }
 
        function nextCalendar() {//다음 달
            // 다음 달을 today에 값을 저장하고 달력에 today 넣어줌
            //today.getFullYear() 현재 년도//today.getMonth() 월  //today.getDate() 일 
            //getMonth()는 현재 달을 받아 오므로 다음달을 출력하려면 +1을 해줘야함
             today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
             buildCalendar();//달력 cell 만들어 출력
        }
        function buildCalendar(){//현재 달 달력 만들기
            var doMonth = new Date(today.getFullYear(),today.getMonth(),1);
            //이번 달의 첫째 날,
            //new를 쓰는 이유 : new를 쓰면 이번달의 로컬 월을 정확하게 받아온다.     
            //new를 쓰지 않았을때 이번달을 받아오려면 +1을 해줘야한다. 
            //왜냐면 getMonth()는 0~11을 반환하기 때문
            var lastDate = new Date(today.getFullYear(),today.getMonth()+1,0);
            //이번 달의 마지막 날
            //new를 써주면 정확한 월을 가져옴, getMonth()+1을 해주면 다음달로 넘어가는데
            //day를 1부터 시작하는게 아니라 0부터 시작하기 때문에 
            //대로 된 다음달 시작일(1일)은 못가져오고 1 전인 0, 즉 전달 마지막일 을 가져오게 된다
            var tbCalendar = document.getElementById("calendar");
            //날짜를 찍을 테이블 변수 만듬, 일 까지 다 찍힘
            var tbCalendarYM = document.getElementById("tbCalendarYM");
            //테이블에 정확한 날짜 찍는 변수
            //innerHTML : js 언어를 HTML의 권장 표준 언어로 바꾼다
            //new를 찍지 않아서 month는 +1을 더해줘야 한다. 
             tbCalendarYM.innerHTML = today.getFullYear() + "년 " + (today.getMonth() + 1) + "월"; 
 
             /*while은 이번달이 끝나면 다음달로 넘겨주는 역할*/
            while (tbCalendar.rows.length > 2) {
            //열을 지워줌
            //기본 열 크기는 body 부분에서 2로 고정되어 있다.
                  tbCalendar.deleteRow(tbCalendar.rows.length-1);
                  //테이블의 tr 갯수 만큼의 열 묶음은 -1칸 해줘야지 
                //30일 이후로 담을달에 순서대로 열이 계속 이어진다.
             }
             var row = null;
             row = tbCalendar.insertRow();
             //테이블에 새로운 열 삽입//즉, 초기화
             var cnt = 0;// count, 셀의 갯수를 세어주는 역할
            // 1일이 시작되는 칸을 맞추어 줌
             for (i=0; i<doMonth.getDay(); i++) {
             /*이번달의 day만큼 돌림*/
                  cell = row.insertCell();//열 한칸한칸 계속 만들어주는 역할
                  cnt = cnt + 1;//열의 갯수를 계속 다음으로 위치하게 해주는 역할
             }
            /*달력 출력*/
             for (i=1; i<=lastDate.getDate(); i++) { 
             //1일부터 마지막 일까지 돌림
                  cell = row.insertCell();//열 한칸한칸 계속 만들어주는 역할
                  cell.innerHTML = i ;
                  
                  
                  
                  
                  
                  
                  cnt = cnt + 1;//열의 갯수를 계속 다음으로 위치하게 해주는 역할
              if (cnt % 7 == 1) {/*일요일 계산*/
                  //1주일이 7일 이므로 일요일 구하기
                  //월화수목금토일을 7로 나눴을때 나머지가 1이면 cnt가 1번째에 위치함을 의미한다
                cell.innerHTML = "<font color=#F79DC2>" + i
                //1번째의 cell에만 색칠
            }    
              if (cnt%7 == 0){/* 1주일이 7일 이므로 토요일 구하기*/
                  //월화수목금토일을 7로 나눴을때 나머지가 0이면 cnt가 7번째에 위치함을 의미한다
                  cell.innerHTML = "<font color=skyblue>" + i
                  //7번째의 cell에만 색칠
                   row = calendar.insertRow();
                   //토요일 다음에 올 셀을 추가
              }
              var year = today.getFullYear();
              var month = today.getMonth() + 1;
              var day = i;

              var full1 = year+"/"+month+"/"+day;
              <c:forEach items="${attend}" var="attend">
          	 
          	 var cc = `${attend.date}`;
          	 
          	
          	 var dd = cc.split("/");
          	 var ee = dd[3].split(":");
          	 
          	 
          	 
          	 var date2 = new Date(Number(dd[0]),Number(dd[1])-1,Number(dd[2]),Number(ee[0]),Number(ee[1]));
   
          	 
           	var a = date2.getFullYear();
           	var b = date2.getMonth() + 1;
           	var c = date2.getDate();

           	var full2 = a+"/"+b+"/"+c;
           	var d = date2.toString().split(" ");
           	var bb = "출석";
 
           
	              if(full1 == full2){
 	        	  if("${attend.attend}" == bb){
     	    	  	cell.innerHTML = cell.innerHTML + "<br><b style='color:blue'> ${attend.attend} </b>" + d[4];
         		  } else {
         			  cell.innerHTML = cell.innerHTML + "<br><b style='color:red'> ${attend.attend} </b>" + d[4];
         	     }
           	}
           //var d = date.getHours() + ":" + date.getMinutes();
        
           
			  </c:forEach>
              /*오늘의 날짜에 노란색 칠하기*/
              if (today.getFullYear() == date.getFullYear()
                 && today.getMonth() == date.getMonth()
                 && i == date.getDate()) {
                  //달력에 있는 년,달과 내 컴퓨터의 로컬 년,달이 같고, 일이 오늘의 일과 같으면
                cell.bgColor = "#FAF58C";//셀의 배경색을 노랑으로 
               }
  
             }
        }
        
        buildCalendar();
</script>
</body>
</html>
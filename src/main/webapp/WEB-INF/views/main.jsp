<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
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
<!-- JQuery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="/attend/${path}/resources/css/main.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://unpkg.com/swiper@7/swiper-bundle.min.css" />
</head>

<body>
	<%@ include file="/WEB-INF/views/button.jsp" %>
	<div class="align">
		<header>
			<div class="logo">
				<img src="/attend/resources/school.jpg">
			</div>
		</header>
		<section>
			<div class="main_1">
				<div class="main_1_1">
					<div class="main_header_div">
						<div class="main_header">
							<div>본인 정보</div>
						</div>
						<div class="main_1_1_section">
							<div class="main_1_1_section_img">
								<img src="/attend/resources/user/${user.imgsrc}">
							</div>
							<form action="/attend/profileimg" method="post"
								enctype="multipart/form-data">
								<label class="input-file-button" for="input-file"> 사진
									업로드 </label> <input type="file" name="imgfile" id="input-file" /> <input
									type="hidden" name="num" value="${user.num}" /> <input
									type="submit" value="사진저장">
							</form>
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

						</div>
					</div>
				</div>
				<div class="main_1_2">
					<div class="main_header_div">
						<div class="main_header">
							<div>오늘 날씨 및 학부사무실 커뮤니티</div>
						</div>
					</div>
					<div class="today_info">
						<div class="weather">
							<div class="weatherhead">오늘 날씨</div>
							<div class="CurrIcon"></div>
							<div class="CurrTemp"></div>
							<div class="City"></div>
						</div>
						<div class="corona">
							<div class="notice_1">학부사무실 커뮤니티</div>
							<c:forEach items="${communityList}" var="community" begin="0" end="3" step="1" varStatus="status">
             				<a class="section_tag_a" href="/attend/community_info?numb=${community.numb}">
             					<div class="notice">
									<div class="notice_header">${community.title}</div>
									<div class="notice_date">${community.date}</div>
									<div class="notice_name">${community.name}</div>
								</div>
 				            </a>    		
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
			<div class="main_2">
				<div>
					<div class="main_header_div">
						<div class="main_header memo_header">금일 근무 현황</div>
					</div>
					<div class="ingredient">

						<c:forEach items="${attending}" var="attending">
							<div class="now">
								<div class="now_img">
									<img
										src="/attend/resources/user/${attending.imgsrc}">
								</div>
								<div class="now_name">
									<b>${attending.name}</b>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				<div>
					<div class="main_header_div">
						<div class="main_header memo_header">
							<div>메모</div>
							<span class="memo_notice">옆으로 넘겨보세요</span>
							<span class="create" id="caa">생성</span>
						</div>
					</div>
					<div class="memo">
						<div>
							<div>
								<div class="swiper mySwiper mySwiper2">
									<div class="swiper-wrapper">
										<c:forEach items="${memo}" var="memo">
                                		  <div class="swiper-slide"><span class="side4" >${memo.date}</span><span
                                                class="side3">${memo.name}</span><b style="white-space:pre;">${memo.memo}</b></div>
                            			</c:forEach>
									</div>
									<div class="swiper-pagination name"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		<footer>
			<div class="calen">
				<div class="h33">
					<h3 align="center">나의 근무 달력</h3>
				</div>
				<table id="calendar" border="3" align="center"
					style="border-color: #3333FF">
					<tbody>
						<tr class="tb">
							<!-- label은 마우스로 클릭을 편하게 해줌 -->
							<td><label onclick="prevCalendar()"> < </label></td>
							<td align="center" id="tbCalendarYM" colspan="5">yyyy년 m월</td>
							<td><label onclick="nextCalendar()">> </label></td>
						</tr>
						<tr class="ta">
							<td align="center"><font color="#F79DC2">일 </td>
							<td align="center">월</td>
							<td align="center">화</td>
							<td align="center">수</td>
							<td align="center">목</td>
							<td align="center">금</td>
							<td align="center"><font color="skyblue">토 </td>
						</tr>
					</tbody>
				</table>
			</div>
		</footer>
		<div id="modal2" class="modal2">
			<div>
				<div>
					<button id="xbtn">
						<i id="xbutton" class="fas fa-times"></i>
					</button>
					<div>메모 작성</div>
					<div class="tt">
						<textarea id="textt"></textarea>
					</div>
					<button id="modal2_btn">작성완료</button>
				</div>
			</div>
		</div>
	</div>
	<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
	<script>
                        var swiper = new Swiper(".mySwiper", {
                            spaceBetween: 30,
                            pagination: {
                                el: ".swiper-pagination",
                                clickable: true,
                            },
                        });
                        $("#caa").click(function (e) {
                            $('.modal2').css("display", "flex");
                        });

                        //.modal안에 button을 클릭하면 .modal닫기
                        $("#xbtn").click(function () {
                            $('.modal2').css("display", "none");
                        });

                        //.modal밖에 클릭시 닫힘
                        $(".modal2").click(function (e) {
                            if (e.target.className != "modal2") {
                                return false;
                            } else {
                                $('.modal2').css("display", "none");
                            }
                        });

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
                                url: '/attend/addmemo',
                                data: { memo: memo },
                                success: function (data) {
                                    if (data == "success")
                                        window.location.href = "/attend/main";
                                    else {

                                    }
                                }
                            });
                        });
                    </script>
	<script type="text/javascript">
                        $(document).ready(function () {
                            let weatherIcon =
                            {
                                '01': 'fas fa-sun',
                                '02': 'fas fa-cloud-sun',
                                '03': 'fas fa-cloud',
                                '04': 'fas fa-cloud-meatball',
                                '09': 'fas fa-cloud-sun-rain',
                                '10': 'fas fa-cloud-showers-heavy',
                                '11': 'fas fa-poo-storm',
                                '13': 'far fa-snowflake',
                                '50': 'fas fa-smog'
                            };
                            $.ajax({
                                url: ''
                                dataType: 'json',
                                type: 'GET',
                                success: function (data) {
                                    var $Icon = (data.weather[0].icon).substr(0, 2);
                                    var $Temp = Math.floor(data.main.temp) + 'º';
                                    var $city = data.name;
                                    $('.CurrIcon').append('<i class="' + weatherIcon[$Icon] + '"></i>');
                                    $('.CurrTemp').prepend($Temp); $('.City').append($city);
                                }
                            })
                        });
                    </script>
	<script>
                        var att = document.querySelectorAll(".att");
                        att.forEach(a => {
                            if (a.innerHTML == '출석') {
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
                        function buildCalendar() {//현재 달 달력 만들기
                            var doMonth = new Date(today.getFullYear(), today.getMonth(), 1);
                            //이번 달의 첫째 날,
                            //new를 쓰는 이유 : new를 쓰면 이번달의 로컬 월을 정확하게 받아온다.     
                            //new를 쓰지 않았을때 이번달을 받아오려면 +1을 해줘야한다. 
                            //왜냐면 getMonth()는 0~11을 반환하기 때문
                            var lastDate = new Date(today.getFullYear(), today.getMonth() + 1, 0);
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
                                tbCalendar.deleteRow(tbCalendar.rows.length - 1);
                                //테이블의 tr 갯수 만큼의 열 묶음은 -1칸 해줘야지 
                                //30일 이후로 담을달에 순서대로 열이 계속 이어진다.
                            }
                            var row = null;
                            row = tbCalendar.insertRow();
                            //테이블에 새로운 열 삽입//즉, 초기화
                            var cnt = 0;// count, 셀의 갯수를 세어주는 역할
                            // 1일이 시작되는 칸을 맞추어 줌
                            for (i = 0; i < doMonth.getDay(); i++) {
                                /*이번달의 day만큼 돌림*/
                                cell = row.insertCell();//열 한칸한칸 계속 만들어주는 역할
                                cnt = cnt + 1;//열의 갯수를 계속 다음으로 위치하게 해주는 역할
                            }
                            /*달력 출력*/
                            for (i = 1; i <= lastDate.getDate(); i++) {
                                //1일부터 마지막 일까지 돌림
                                cell = row.insertCell();//열 한칸한칸 계속 만들어주는 역할
                                cell.innerHTML = i;






                                cnt = cnt + 1;//열의 갯수를 계속 다음으로 위치하게 해주는 역할
                                if (cnt % 7 == 1) {/*일요일 계산*/
                                    //1주일이 7일 이므로 일요일 구하기
                                    //월화수목금토일을 7로 나눴을때 나머지가 1이면 cnt가 1번째에 위치함을 의미한다
                                    cell.innerHTML = "<font color=#F79DC2>" + i
                                    //1번째의 cell에만 색칠
                                }
                                if (cnt % 7 == 0) {/* 1주일이 7일 이므로 토요일 구하기*/
                                    //월화수목금토일을 7로 나눴을때 나머지가 0이면 cnt가 7번째에 위치함을 의미한다
                                    cell.innerHTML = "<font color=skyblue>" + i
                                    //7번째의 cell에만 색칠
                                    row = calendar.insertRow();
                                    //토요일 다음에 올 셀을 추가
                                }
                                var year = today.getFullYear();
                                var month = today.getMonth() + 1;
                                var day = i;

                                var full1 = year + "/" + month + "/" + day;
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    <link href="/attend/${path}/resources/css/community.css" rel="stylesheet">
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
        <section id="section">
            <div class="section_header">
                커뮤니티
            </div>
            <div class="button"><button onclick="gowrite()">글쓰기</button></div>
            <div class="search_title"><input type="search" name="search" class="search" id="search" placeholder="제목 검색"></div>
                    <div class="menudetail">
                        <input type="checkbox" id="notice" name="date" value="공지" onclick="check(this)"/>
                        <label for="notice">공지</label>
                        <input type="checkbox" id="samsil" name="date" value="사무실" onclick="check(this)"/>
                        <label for="samsil">사무실</label>
                         <input type="checkbox" id="sil" name="date" value="실습실" onclick="check(this)"/>
                        <label for="sil">실습실</label>
                        <input type="checkbox" id="in" name="date" value="인수인계" onclick="check(this)"/>
                        <label for="in">인수인계</label>
               		 </div>
            <div class="section_tag_title">
                <div class="num">
                    <span>번호</span>
                </div>
                <div class="categori">
                    <span>구분</span>
                </div>
                <div class="section_title">
                    <span>제목</span>
                </div>
                <div class="section_name">
                    <span>작성자</span>
                </div>
                <div class="section_date">
                    <span>날짜</span>
                </div>
            </div>
            <div id="section_tag_main">
			<c:forEach items="${communityList}" var="community">
             <a class="section_tag_a" href="/attend/community_info?numb=${community.numb}">
            	<div class="section_tag">
                	<div class="num">
                    	<span>${community.numb}</span>
                	</div>
                	<div class="categori">
	                    <span>${community.categori}</span>
                	</div>
                	<div class="section_title">
	                    <span>${community.title}</span>
                	</div>
                	<div class="section_name">
	                    <span>${community.name}</span>
                	</div>
                	<div class="section_date">
	                    <span>${community.date}</span>
                	</div>
            	</div>
            </a>    		
            </c:forEach>
            </div>
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

function gowrite() {
	location.href="/attend/community_write";
}


function check(a){
	var obj = document.getElementsByName("date");
	for(var i=0; i<obj.length; i++){
        if(obj[i] != a){
        	obj[i].checked = false;
	    }
    }
	
	if($("input:checkbox[name=date]:checked").length <= 0){
		search.value="";
		search.readOnly=false;
		 $.ajax({
	            type: "POST",
	            url: '/attend/community/search',
	            data: { text: ""},
	            success: function (jarray) {
	            	$("#section_tag_main").empty();
	        		for(let i in jarray){
	        			makelist(i, jarray);
	        		}	
	            }
	        });	
	}else{
		if(a.value == "공지"){
			let search = document.getElementById("search");
			search.value="";
			search.readOnly=true;
   		 $.ajax({
	            type: "POST",
	            url: '/attend/community/search',
	            data: { text: "공지"},
	            success: function (jarray) {
	            	$("#section_tag_main").empty();
	        		for(let i in jarray){
	        			makelist(i, jarray);
	        		}	
	            }
	        });	
    	}else if(a.value == "사무실"){
			search.value="";
			search.readOnly=true;
   		 $.ajax({
	            type: "POST",
	            url: '/attend/community/search',
	            data: { text: "사무실"},
	            success: function (jarray) {
	            	$("#section_tag_main").empty();
	        		for(let i in jarray){
	        			makelist(i, jarray);
	        		}	
	            }
	        });	
    	}
    	else if(a.value == "실습실"){
			search.value="";
			search.readOnly=true;
			console.log("눌림");
   		 $.ajax({
	            type: "POST",
	            url: '/attend/community/search',
	            data: { text: "실습실"},
	            success: function (jarray) {
	            	$("#section_tag_main").empty();
	        		for(let i in jarray){
	        			makelist(i, jarray);
	        		}	
	            }
	        });	
    	}
    	else if(a.value == "인수인계"){
			search.value="";
			search.readOnly=true;
   		 $.ajax({
	            type: "POST",
	            url: '/attend/community/search',
	            data: { text: "인수인계"},
	            success: function (jarray) {
	            	$("#section_tag_main").empty();
	        		for(let i in jarray){
	        			makelist(i, jarray);
	        		}	
	            }
	        });	
    	}
	}
}



function makelist(i, jarray) {
	   let section = document.getElementById("section_tag_main");

		let a = document.createElement('a');
		a.setAttribute('class','section_tag_a');
		a.setAttribute('href','/attend/community_info?numb='+jarray[i].numb);
		
		
		let section_tag = document.createElement('div');
		section_tag.setAttribute('class','section_tag');
		

		let num = document.createElement('div');
		num.setAttribute('class','num');
		let num_span= document.createElement('span');
		num_span.innerHTML = jarray[i].numb;
		num.appendChild(num_span);
		
		
		let categori = document.createElement('div');
		categori.setAttribute('class','categori');
		let categori_span= document.createElement('span');
		categori_span.innerHTML = jarray[i].categori;
		categori.appendChild(categori_span);
		
		
		let section_title = document.createElement('div');
		section_title.setAttribute('class','section_title');
		let section_span= document.createElement('span');
		section_span.innerHTML = jarray[i].title;
		section_title.appendChild(section_span);
		
		
		let section_name = document.createElement('div');
		section_name.setAttribute('class','section_name');
		let name_span= document.createElement('span');
		name_span.innerHTML = jarray[i].name;
		section_name.appendChild(name_span);
		
		
		let section_date = document.createElement('div');
		section_date.setAttribute('class','section_date');
		let date_span= document.createElement('span');
		date_span.innerHTML = jarray[i].date;
		section_date.appendChild(date_span);
		
		
		section_tag.appendChild(num);
		section_tag.appendChild(categori);
		section_tag.appendChild(section_title);
		section_tag.appendChild(section_name);
		section_tag.appendChild(section_date);
		
		a.appendChild(section_tag);
		
		section.appendChild(a);
		
}

	search.oninput = function(){

    $.ajax({
        type: "POST",
        url: '/attend/community/search',
        data: { text: search.value },
        success: function (jarray) {
        	$("#section_tag_main").empty();
    		for(let i in jarray){
    			makelist(i, jarray)
    		}	
        }
    });
}
    </script>
</body>
</html>
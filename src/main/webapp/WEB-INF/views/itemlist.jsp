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
    <link href="/attend/${path}/resources/css/itemlist.css" rel="stylesheet">
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
                재료/재고 리스트
            </div>
            <div class="button"><button onclick="gowrite()">재료 등록</button></div>
            <div class="search_title"><input type="search" name="search" class="search" id="search" placeholder="재료 검색"></div>
                    <div class="menudetail">
                        <input type="checkbox" id="notice" name="date" value="준비실" onclick="check(this)"/>
                        <label for="notice">준비실</label>
                        <input type="checkbox" id="samsil" name="date" value="사무실" onclick="check(this)"/>
                        <label for="samsil">사무실</label>
               		 </div>
            <div class="section_tag_title">
                <div class="num">
                    <span>구분</span>
                </div>
                <div class="categori">
                    <span>위치</span>
                </div>
                <div class="section_title">
                    <span>재료명</span>
                </div>
                <div class="section_name">
                    <span>개수</span>
                </div>
            </div>
            <div id="section_tag_main">
			<c:forEach items="${itemList}" var="itemList">
             <a class="section_tag_a" href="/attend/item_info?num=${itemList.num}">
            	<div class="section_tag">
                	<div class="num">
                    	<span class="num_no">${itemList.categori}</span>
                	</div>
                	<div class="categori">
	                    <span>${itemList.itemloc}</span>
                	</div>
                	<div class="section_title">
	                    <span>${itemList.itemname}</span>
                	</div>
                	<div class="section_name">
	                    <span>${itemList.itemcount}</span>
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
	location.href="/attend/item_write";
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
	            url: '/attend/item/search',
	            data: { text: ""},
	            success: function (jarray) {
	            	$("#section_tag_main").empty();
	        		for(let i in jarray){
	        			makelist(i, jarray);
	        		}	
	            }
	        });	
	}else{
		if(a.value == "준비실"){
			let search = document.getElementById("search");
			search.value="";
			search.readOnly=true;
   		 $.ajax({
	            type: "POST",
	            url: '/attend/item/search',
	            data: { text: "준비실"},
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
	            url: '/attend/item/search',
	            data: { text: "사무실"},
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
		a.setAttribute('href','/attend/item_info?num='+jarray[i].num);
		
		
		let section_tag = document.createElement('div');
		section_tag.setAttribute('class','section_tag');
		

		let num = document.createElement('div');
		num.setAttribute('class','num');
		let num_span= document.createElement('span');
		num_span.innerHTML = jarray[i].categori;
		num.appendChild(num_span);
		
		
		let categori = document.createElement('div');
		categori.setAttribute('class','categori');
		let categori_span= document.createElement('span');
		categori_span.innerHTML = jarray[i].itemloc;
		categori.appendChild(categori_span);
		
		
		let section_title = document.createElement('div');
		section_title.setAttribute('class','section_title');
		let section_span= document.createElement('span');
		section_span.innerHTML = jarray[i].itemname;
		section_title.appendChild(section_span);
		
		
		let section_name = document.createElement('div');
		section_name.setAttribute('class','section_name');
		let name_span= document.createElement('span');
		name_span.innerHTML = jarray[i].itemcount;
		section_name.appendChild(name_span);
		
		
		section_tag.appendChild(num);
		section_tag.appendChild(categori);
		section_tag.appendChild(section_title);
		section_tag.appendChild(section_name);
		
		a.appendChild(section_tag);
		
		section.appendChild(a);
		

		
}

	search.oninput = function(){

    $.ajax({
        type: "POST",
        url: '/attend/item/search',
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
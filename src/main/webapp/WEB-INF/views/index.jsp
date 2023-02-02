<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
  <meta charset="utf-8">
  <title>QR출석</title>
  <script src="/attend/${path}/resources/js/jsQR.js"></script>
  <meta name="viewport" content="width=device-width, initial-scale=1.0,user-scaleable=no,maximum-scale=1,width=device-width">
  <link href="https://fonts.googleapis.com/css?family=Ropa+Sans" rel="stylesheet">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link href="/attend/${path}/resources/css/index.css" rel="stylesheet"> 
</head>
<body>
  <div class="arrow"><a onclick='history.go(-1);'><i class="fas fa-arrow-left"></i></a></div>
  <div class="main">
  	<div>
  <h1>QR출석</h1>
  <div id="loadingMessage">🎥 웹캠이 연결되지 않았습니다 (캠을 연결해주세요)</div>
  <canvas id="canvas" hidden></canvas>
  <div id="output" hidden>
    <div id="outputMessage">QR코드가 인식되지 않았습니다.</div>
    <div hidden><b>인식된 값:</b> <span id="outputData"></span></div>
  </div>
  <div class="cho"><span>메인 화면으로 돌아가기까지 </span><span id="time"> </span><span> 초 남았습니다.</span></div>
    <div id="modal2" class="modal2">
    	<div>
    		<div>
    			<div id="a"></div>
    			<div id="b"></div>
    			<div id="c"></div>
        		<button>확인</button>
        	</div>
        </div>
    </div>
    </div>
  </div>
  <script>
	var audio = new Audio("/attend/resources/beep.mp3");
	var audio2 = new Audio("/attend/resources/error.mp3");
    var video = document.createElement("video");
    var canvasElement = document.getElementById("canvas");
    var canvas = canvasElement.getContext("2d");
    var loadingMessage = document.getElementById("loadingMessage");
    var outputContainer = document.getElementById("output");
    var outputMessage = document.getElementById("outputMessage");
    var outputData = document.getElementById("outputData");
    var a = document.getElementById("a");
    var b = document.getElementById("b");
    var c = document.getElementById("c");
    var timeline = document.getElementById("time");
    var time = 20;

    function drawLine(begin, end, color) {
      canvas.beginPath();
      canvas.moveTo(begin.x, begin.y);
      canvas.lineTo(end.x, end.y);
      canvas.lineWidth = 4;
      canvas.strokeStyle = color;
      canvas.stroke();
    }

    // Use facingMode: environment to attemt to get the front camera on phones
    navigator.mediaDevices.getUserMedia({ video: true}).then(function(stream) {
      video.srcObject = stream;
      video.setAttribute("playsinline", true); // required to tell iOS safari we don't want fullscreen
      video.play();
      requestAnimationFrame(tick);
    });
    
    function sound(){
    	audio.play();
    }
    
    function errsound(){
    	audio2.play();
    }
   
    
    function sleep(ms) {
    	  const wakeUpTime = Date.now() + ms;
    	  while (Date.now() < wakeUpTime) {}
    }
    
    
    setInterval(function(){
    	console.log(time);
    	time--;
    	timeline.innerText = time;
    	
    	if(time < 10){
    		$('#time').css("color","red");
    		$('#time').css("fontSize",50);
    	}
    	
    	if(time < 0){
    		time = 30;
    		window.location.href="/attend/choose";
    	}
    }, 1000);
    
    
    
    function tick() {
      loadingMessage.innerText = "⌛ 비디오를 로딩중입니다..."
      if (video.readyState === video.HAVE_ENOUGH_DATA) {
        loadingMessage.hidden = true;
        canvasElement.hidden = false;
        outputContainer.hidden = false;

        canvasElement.height = video.videoHeight;
        canvasElement.width = video.videoWidth;
        canvas.drawImage(video, 0, 0, canvasElement.width, canvasElement.height);
        var imageData = canvas.getImageData(0, 0, canvasElement.width, canvasElement.height);
        var code = jsQR(imageData.data, imageData.width, imageData.height, {
          inversionAttempts: "dontInvert",
        });
        
        if (code) {
          
          drawLine(code.location.topLeftCorner, code.location.topRightCorner, "#FF3B58");
          drawLine(code.location.topRightCorner, code.location.bottomRightCorner, "#FF3B58");
          drawLine(code.location.bottomRightCorner, code.location.bottomLeftCorner, "#FF3B58");
          drawLine(code.location.bottomLeftCorner, code.location.topLeftCorner, "#FF3B58");
          outputMessage.hidden = true;
          outputData.parentElement.hidden = false;
          outputData.innerText = code.data;
          console.log(code.data);
          var qrcode = JSON.parse(code.data);
          $.ajax({
				type: "post",
                url: "/attend/check",
                data: {num:qrcode.num, name:qrcode.name, attend:"${value}"},
				success: function(response) {
					console.log(response);
					var response = JSON.parse(response);
					if(response.on == 'success') {
							sound();
						    $('.modal2').css("display","flex");
						    a.innerText = response.name + "님";
						    b.innerText = response.date + "에";
						    c.innerText = response.attend + "되었습니다";
						    
						    //.modal안에 button을 클릭하면 .modal닫기
						    $(".modal2 button").click(function(){
						    	window.location.href="/attend/choose";  	 
						   		$('.modal2').css("display","none");	 	
						    });
						    
						    //.modal밖에 클릭시 닫힘
						    $(".modal2").click(function (e) {
						  	  if (e.target.className != "modal2") {
						   	   return false;
						    } else {
						    	window.location.href="/attend/choose";  	 
						   	 	$('.modal2').css("display","none");	
						   	 }
						    });
					
					}
					else {
						errsound();
						$('.modal2').css("display","flex");
					    a.innerText = "잘못 입력하셨습니다."
					    b.innerText = "다시 돌아가서"
					    c.innerText = "출석체크하세요"
					    	//.modal안에 button을 클릭하면 .modal닫기
						    $(".modal2 button").click(function(){
						    	window.location.href="/attend/choose";  	 
						   		$('.modal2').css("display","none");	 	
						    });
						    
						    //.modal밖에 클릭시 닫힘
						    $(".modal2").click(function (e) {
						  	  if (e.target.className != "modal2") {
						   	   return false;
						    } else {
						    	window.location.href="/attend/choose";  	 
						   	 	$('.modal2').css("display","none");	
						   	 }
						    });
					}
					setTimeout(function(){
						window.location.href="/attend/choose";
				    }, 3000);
				},
			    error: function (xhr, ajaxOptions, thrownError) {
			    	errsound();
					$('.modal2').css("display","flex");
				    a.innerText = xhr.status + "에러 입니다.";
				    b.innerText = "근로장학생 홈페이지에 가입되있지 않은";
				    c.innerText = "학번일 수 있으니 체크 부탁드립니다.";
				    	//.modal안에 button을 클릭하면 .modal닫기
					    $(".modal2 button").click(function(){
					    	window.location.href="/attend/choose";  	 
					   		$('.modal2').css("display","none");	 	
					    });
					    
					    //.modal밖에 클릭시 닫힘
					    $(".modal2").click(function (e) {
					  	  if (e.target.className != "modal2") {
					   	   return false;
					    } else {
					    	window.location.href="/attend/choose";  	 
					   	 	$('.modal2').css("display","none");	
					   	 }
					    });
						setTimeout(function(){
							window.location.href="/attend/choose";
					    }, 6000);
			    }
			});
	   		return;
        } else {
          outputMessage.hidden = false;
          outputData.parentElement.hidden = true;
        }
          
      }
      
      requestAnimationFrame(tick);
    }
    
	
  </script>
</body>
</html>

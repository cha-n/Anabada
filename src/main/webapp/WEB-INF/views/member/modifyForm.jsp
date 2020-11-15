<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Anabada</title>


    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <link href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700,800&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Lora:400,400i,700,700i&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Amatic+SC:400,700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="${contextPath }/resources/eunji/css/open-iconic-bootstrap.min.css">
    <link rel="stylesheet" href="${contextPath }/resources/eunji/css/animate.css">
    
    <link rel="stylesheet" href="${contextPath }/resources/eunji/css/owl.carousel.min.css">
    <link rel="stylesheet" href="${contextPath }/resources/eunji/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="${contextPath }/resources/eunji/css/magnific-popup.css">

    <link rel="stylesheet" href="${contextPath }/resources/eunji/css/aos.css">

    <link rel="stylesheet" href="${contextPath }/resources/eunji/css/ionicons.min.css">

    <link rel="stylesheet" href="${contextPath }/resources/eunji/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="${contextPath }/resources/eunji/css/jquery.timepicker.css">

    
    <link rel="stylesheet" href="${contextPath }/resources/eunji/css/flaticon.css">
    <link rel="stylesheet" href="${contextPath }/resources/eunji/css/icomoon.css">
    <link rel="stylesheet" href="${contextPath }/resources/eunji/css/style.css">
<style>
	table {
		margin:2% auto 2% auto;
		width:60%;
	}
	#image {
		border-radius:100%;
	}
	.input-field {
		width:77%;
		padding:10px 0;
		margin:5px 0;
		border:none;
		border-bottom:1px solid #999;
		outline:none;
		background:transparent;
	}
</style>

<script  src="http://code.jquery.com/jquery-latest.min.js"></script> 
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	$(document).ready(function() {
		if("${member.profile}"!="") { //프로필 사진이 있다면 프로필 삭제 버튼이 보일 수 있게 함
			$('#profile_Init').css('visibility','visible');
		}
	});

	function _changeNname() { //닉네임 변경 또는 중복확인 버튼을 눌렀을 때
		var nameBtn=document.getElementById("nameBtn");
		if(nameBtn.value=="닉네임 변경") {
			var n_name=document.getElementById("_n_name");
			n_name.disabled=false;
			nameBtn.value="중복확인";
		}
		else if(nameBtn.value=="중복확인") {
		    var n_name=$("#_n_name").val();
		    if (n_name==''){
		    	alert("닉네임을 입력하세요.");
		    }
		    else {
			    $.ajax({
			       type:"post",
			       async:false,  
			       url:"${contextPath}/member/checkName",
			       data: {n_name : n_name},
			       success:function (data){
			          if(data=='false') {
			       	    alert("사용할 수 있는 닉네임입니다.");
			       	    $('#_n_name').prop("disabled", true);
			       	    $('#n_name').val(n_name);
			       	 	document.getElementById("n_warning").innerHTML="";
			       		nameBtn.value="닉네임 변경";
			          }
			          else {
			        	  alert("사용할 수 없는 닉네임입니다.");
			          }
			       },
			       error:function(data){
			          alert("오류가 발생했습니다. 다시 시도해주세요.");
			       },
			       complete:function(data){
			       }
			    });
		    }
		}
	}

	function _findAddress() { //주소 찾기
		new daum.Postcode({
			oncomplete: function(data) {
			      var roadAddr = data.roadAddress; // 도로명 주소 변수
			      var extraRoadAddr = ''; // 도로명 조합형 주소 변수
			      // 법정동명이 있을 경우 추가한다. (법정리는 제외)
			      // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
			      if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
			        extraRoadAddr += data.bname;
			      }
			      // 건물명이 있고, 공동주택일 경우 추가한다.
			      if(data.buildingName !== '' && data.apartment === 'Y'){
			        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
			      }
			      // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
			      if(extraRoadAddr !== ''){
			        extraRoadAddr = ' (' + extraRoadAddr + ')';
			      }
			      // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
			      if(roadAddr !== ''){
			        roadAddr += extraRoadAddr;
			      }
			      // 우편번호와 주소 정보를 해당 필드에 넣는다.
			      document.getElementById('_address').value = roadAddr;
			      document.getElementById('address').value = roadAddr;
			      document.getElementById("a_warning").innerHTML="";
			    }
			  }).open();
	}
	
	function _checkNAME() { //이름이 안비어있는지 확인
		var name=document.getElementById("name").value;
		if(name!="" && name!=null) {
			document.getElementById("nn_warning").innerHTML="";
		}
	}
	
	function _pwdCheck() {//비밀번호가 일치하는지 확인
		  var pwd1=document.getElementById("pwd1").value;
		  var pwd2=document.getElementById("pwd2").value;
		  if(pwd1=="" || pwd2=="") {
			  document.getElementById("p_warning").innerHTML="";
			  document.getElementById("p1_warning").innerHTML="";
			  $('#pwdCheck').val('x');
		  }

		  
		  else if(pwd1!=pwd2) {
			  document.getElementById("p_warning").innerHTML="<br><font color=#FF9090 size=2.5pt>비밀번호가 일치하지 않습니다.</font>";
			  document.getElementById("p1_warning").innerHTML="";
			  $('#pwdCheck').val('x');
		  }
		  else if(pwd1==pwd2) {
			  document.getElementById("p_warning").innerHTML="<br><font color=#487BE1 size=2.5pt>비밀번호가 일치합니다.</font>";
			  document.getElementById("p1_warning").innerHTML="";
			  $('#pwdCheck').val('o');
		  }
	  }
	
	function _send() {
		if(document.getElementById("_n_name").disabled==false) {
			$("#_n_name").focus();
			document.getElementById("n_warning").innerHTML="<font color=#FF9090 size=2.5pt>닉네임을 입력해주세요.</font>";
		}
		else if(document.getElementById("name").value=="" || document.getElementById("name").value==null) {
			$("#name").focus();
			document.getElementById("nn_warning").innerHTML="<font color=#FF9090 size=2.5pt>이름을 입력해주세요.</font>";
		}
		else if(document.getElementById("pwdCheck").value=='x') {
			if(document.getElementById("pwd1").value=='') {
				$("#pwd1").focus();
				document.getElementById("p1_warning").innerHTML="<br><font color=#FF9090 size=2.5pt>비밀번호를 입력해주세요.</font>";
			}
			else if(document.getElementById("pwd2").value=='') {
				$("#pwd2").focus();
				document.getElementById("p_warning").innerHTML="<br><font color=#FF9090 size=2.5pt>비밀번호를 입력해주세요.</font>";
			}
		}
		else {
			 document.modForm.submit();
		}
	}
	function _readFile(input) { //이미지 미리보기
		if (input.files[0]) {
			var filename=input.files[0].name;
			var ext=filename.substr(filename.length-3,filename.length);
			if(ext !="jpg" && ext !="gif" && ext !="png") { //이미지 파일이 아닐 때
				alert("이미지파일을 선택해주세요.");
				$('#imgChange').val("x");
				var file=document.getElementById("profile");
				file.value='';
				return;
			}
			
			var reader = new FileReader(); //파일을 읽기 위한 FileReader 객체 생성
			reader.onload = function (e) { //파일 읽어들이기를 성공했을 때 호출되는 이벤트 핸들러
				$('#image').attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
			$('#imgChange').val("o");
			$('#profile_Init').css('visibility','visible');
		}
	}
	function delete_Profile() {
		var file=document.getElementById("profile");
		file.value='';
		$('#image').attr('src','${contextPath}/resources/image/no_profile.png');
		$('#imgChange').val("delete");
		
	}
</script>
</head>
<body class="goto-here">

   <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
       <div class="container">
         <a class="navbar-brand" href="${contextPath }/main">Anabada</a>
         <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
           <span class="oi oi-menu"></span> Menu
         </button>

         <div class="collapse navbar-collapse" id="ftco-nav">
           <ul class="navbar-nav ml-auto">
             <li class="nav-item active"><a href="${contextPath }/main" class="nav-link">Home</a></li>
             <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="dropdown04" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Shop</a>
              <div class="dropdown-menu" aria-labelledby="dropdown04">
                 <a class="dropdown-item" href="${contextPath }/seller/listArticles">공동구매</a>
                 <a class="dropdown-item" href="${contextPath}/share/boardList">나눔</a>
                 <a class="dropdown-item" href="${contextPath }/board/boardList">판매</a>
            	 <a class="dropdown-item" href="${contextPath}/exchange/boardList">교환</a>
              </div>
            </li>
            
            <c:if test="${member ne null}">
            <li class="nav-item dropdown">
            	<a class="nav-link dropdown-toggle" href="#" id="dropdown04" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">My Page</a>
              	<div class="dropdown-menu" aria-labelledby="dropdown04">
                 	<a class="dropdown-item" href="${contextPath }/board/myBookmark">북마크</a>
                 	<a class="dropdown-item" href="${contextPath }/board/myBoardList?user=${member.n_name}">내가 쓴 글</a>
                 	<a class="dropdown-item" href="${contextPath}/listBox">메시지함</a>
            	 	  <a class="dropdown-item" href="${contextPath}/order/myOrder">내 주문</a>
                  <a class="dropdown-item" href="${contextPath}/member/myInfo">내 정보</a>
                  <a class="dropdown-item" href="${contextPath}/seller/myReview">내 리뷰</a>
              	</div>
            </li>
            </c:if>
            
             <!-- <li class="nav-item cta cta-colored"><a href="cart.html" class="nav-link"><span class="icon-shopping_cart"></span>[0]</a></li> -->
           <c:if test="${member eq null}">
           	<li class="nav-item"><a href="${contextPath }/member/loginForm" class="nav-link">Sign In</a></li> <!-- 로그인 url 링크-->
           </c:if>
           <c:if test="${member ne null}">
            <li class="nav-item"><a href="${contextPath }/cart/myCart" class="nav-link" >Cart</a></li> <!-- 회원가입 url 링크-->
           	<li class="nav-item"><a href="${contextPath }/member/logout" class="nav-link">LogOut</a></li> <!-- 로그아웃 url 링크-->
           </c:if>
           </ul>
         </div>
       </div>
     </nav>
    <!-- END nav -->
    
    <div class="hero-wrap hero-bread" style="background-image: url('${contextPath}/resources/eunji/images/bg_1.jpg');">
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate text-center">
          	<p class="breadcrumbs"><span class="mr-2"><a href="${contextPath }/main">Home</a></span></p>
            <h1 class="mb-0 bread">내 정보 수정</h1>
          </div>
        </div>
      </div>
    </div>


    <section class="ftco-section ftco-cart" style="padding:3em 0;">
  	<div class="container">
  		<div class="row">
  			<div class="col-md-12 ftco-animate">
				<form name="modForm" method="post" action="${contextPath}/member/updateMember" enctype="multipart/form-data">
				<table>
				  <tr>
				  	<td colspan="2" align="center" style="padding-bottom:2%;">
				  	  <c:if test="${member.profile eq null }">
				  		<img width="180" height="180" id="image" src="${contextPath}/resources/image/no_profile.png">
				  	  </c:if>
				  	  <c:if test="${member.profile ne null }">
				  	  	<img width="180" height="180" id="image" name="image" src="${contextPath}/member/download?profile=${member.profile}">
				  	  </c:if>
				  	  <input type="hidden" value="x" id="imgChange" name="imgChange"> <!-- 수정할 때 이미지를 변경했는지 확인하기 위한 변수 -->
				  	</td>
				  </tr>
				  <tr>
				  	<td colspan="2" align="right">
				  		<input type="file" name="profile" id="profile" value="변경" onchange="_readFile(this);" style="float:right;">
				  		<input type="button" id="profile_Init" value="프로필 삭제" onclick="delete_Profile()" style="visibility:hidden;margin-right:2%;">
				  	</td>
				  </tr>
				  <tr>
					<td width="18%"><b>아이디</b></td>
					<td><input type="text" value="${member.id }" size="50" class="input-field" disabled>
						<input type="hidden" name="id" value="${member.id}">
					</td>
				  </tr>
				  <tr>
					<td><b>이름</b></td>
					<td><input type="text" name="name" id="name" value="${member.name }" size="50" class="input-field" onkeyup="_checkNAME()"><br>
					<b id="nn_warning"></b>
					</td>
				  </tr>
				  <tr>
					<td><b>닉네임</b></td>
					<td><input type="text" id="_n_name" size="50" value="${member.n_name }" class="input-field" placeholder="닉네임 입력" disabled>
						<input type="hidden" name="n_name" id="n_name" value="${member.n_name }" class="input-field">
						<input type="button" id="nameBtn" value="닉네임 변경" class="btn btn-black py-1 px-2" onclick="_changeNname()">
						<b id="n_warning"></b>
					</td>
				  </tr>
				  <tr>
					<td><b>비밀번호</b></td>
				  	<td><input type="password" id="pwd1" name="pwd" size="50" placeholder="비밀번호 입력" class="input-field" onkeyup="_pwdCheck()">
				  	<b id="p1_warning"></b></td>
				  </tr>
				  <tr>
					<td style="padding-right:2%;"><b>비밀번호 확인</b></td>
				  	<td><input type="password" id="pwd2" size="50" placeholder="비밀번호 확인" class="input-field" onkeyup="_pwdCheck()">
				  	<b id="p_warning"></b></td>
				  </tr>
				  <tr>
				  	<td><b>주소</b></td>
				  	<td><input type="text" id="_address" value="${member.address}" placeholder="주소 입력" size="50" class="input-field" disabled style="float:left;margin-right:1.5%;">
				  	<input type="hidden" name="address" value="${member.address}" id="address">
				  	<input type="button" value="주소 찾기" class="btn btn-black py-1 px-2" onclick="_findAddress()">
				  	<b id="a_warning"></b>
				  	</td>
				  </tr>
				  <tr>
				  	<td colspan="2" align="center" style="padding-top:3%;">
				  		<input type="button" value="취소" class="btn btn-primary py-3 px-4" onclick="location.href='${contextPath}/member/myInfo'">
				  		<input type="button" value="정보 수정" class="btn btn-primary py-3 px-4" onclick="_send()">
				  	</td>
				  </tr>
				</table>
				</form>
				<input type="hidden" id="pwdCheck" value="x">
			</div>
		</div>
	</div>
   </section>
  
	<!-- footer -->
    <footer class="ftco-footer ftco-section">
		<div class="container">
			<div class="row">
				<div class="mouse" style="margin-top: 50px;">
						  <a href="#" class="mouse-icon">
							  <div class="mouse-wheel"><span class="ion-ios-arrow-up"></span></div>
						  </a>
					  </div>
			</div>
			<div class="col-md" style="margin-top: 50px;">
			  <div class="ftco-footer-widget mb-4">
				  <h2 class="ftco-heading-2">Have a Questions?</h2>
				  <div class="block-23 mb-3">
					<ul>
					  <li><span class="icon icon-map-marker"></span><span class="text">인천광역시 연수구 송도1동 아카데미로 119</span></li>
					  <li><a href="#"><span class="icon icon-phone"></span><span class="text">010.3333.1532</span></a></li>
					  <li><a href="#"><span class="icon icon-envelope"></span><span class="text">anabada@gmail.com</span></a></li>
					</ul>
				  </div>
			  </div>
			</div>
		  </div>
		  <div class="row" style="margin-top: 100px; margin-bottom: 10px;">
			<div class="col-md-12 text-center">
			  <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
							Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="icon-heart color-danger" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
							<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
						  </p>
			</div>
		  </div>
	  </footer>

 <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>


  <script src="${contextPath }/resources/eunji/js/jquery.min.js"></script>
  <script src="${contextPath }/resources/eunji/js/jquery-migrate-3.0.1.min.js"></script>
  <script src="${contextPath }/resources/eunji/js/popper.min.js"></script>
  <script src="${contextPath }/resources/eunji/js/bootstrap.min.js"></script>
  <script src="${contextPath }/resources/eunji/js/jquery.easing.1.3.js"></script>
  <script src="${contextPath }/resources/eunji/js/jquery.waypoints.min.js"></script>
  <script src="${contextPath }/resources/eunji/js/jquery.stellar.min.js"></script>
  <script src="${contextPath }/resources/eunji/js/owl.carousel.min.js"></script>
  <script src="${contextPath }/resources/eunji/js/jquery.magnific-popup.min.js"></script>
  <script src="${contextPath }/resources/eunji/js/aos.js"></script>
  <script src="${contextPath }/resources/eunji/js/jquery.animateNumber.min.js"></script>
  <script src="${contextPath }/resources/eunji/js/bootstrap-datepicker.js"></script>
  <script src="${contextPath }/resources/eunji/js/scrollax.min.js"></script>
  <script src="${contextPath }/resources/eunji/js/main.js"></script> 
</body>
</html>
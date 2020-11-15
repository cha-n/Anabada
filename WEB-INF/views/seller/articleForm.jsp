<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
  request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link href="https://fonts.googleapis.com/css?family=Amatic+SC:400,700&display=swap" rel="stylesheet">
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

<title>Anabada</title>
<style>
	#tr_file_upload {
		display: none;
	}
	#tr_btn_modify {
		display: none;
	}
	td.line {
		border-bottom-style:solid;
		border-bottom-width:1px;
	}
	td.line2 {
		border-top-style:solid;
		border-top-width:1px;
	}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
   function readURL(input) {
      if (input.files && input.files[0]) {
    	  var filename=input.files[0].name;
		  var ext=filename.substr(filename.length-3,filename.length);
		  if(ext !="jpg" && ext !="gif" && ext !="png") { //이미지 파일이 아닐 때
			  alert("이미지파일을 선택해주세요.");
			   var file=document.getElementById("imageFileName");
		       file.value='';
		      return;
		  }
	      var reader = new FileReader();
	      reader.onload = function (e) {
	    	document.getElementById("preview").style.display="block";
	        $('#preview').attr('src', e.target.result);
	        var imageCnt=parseInt($('#imageCnt').val())+1;
	        document.getElementById("imageCnt").value=imageCnt;
          }
         reader.readAsDataURL(input.files[0]);
      }
   }

   function readURL2(input,count) {
	      if (input.files && input.files[0]) {
	    	  var filename=input.files[0].name;
			  var ext=filename.substr(filename.length-3,filename.length);
			  if(ext !="jpg" && ext !="gif" && ext !="png") { //이미지 파일이 아닐 때
				  alert("이미지파일을 선택해주세요.");
				   var file=document.getElementById("imageFileName"+count);
			       file.value='';
			      return;
			  }
		      var reader = new FileReader();
		      reader.onload = function (e) {
		    	document.getElementById("preview"+count).style.display="block";
		        $('#preview'+count).attr('src', e.target.result);

		        var imageCnt=parseInt($('#imageCnt').val())+1;
		        document.getElementById("imageCnt").value=imageCnt;
	          }
	         reader.readAsDataURL(input.files[0]);
	      }
	   }

  function backToList(obj){
    obj.action="${contextPath}/seller/listArticles";
    obj.submit();
  }
  var cnt=1;
  function fn_addFile(){
	  $("#d_file").append("<br>"+"<img id='preview"+cnt+"' src='#' width=150 height=150 style='display:none;' />");
	  $("#d_file").append("<br>"+"<input type='file' class='form-control' name='file"+cnt+"' id='imageFileName"+cnt+"' onchange='readURL2(this,"+cnt+")' />");
	  cnt++;

  }

  function _popUp() { //품목 선택 popup 열기
 	 var option="width=500,height=500";
  	 window.open("${contextPath}/seller/vegatPopUp","",option);
  }

  function _getItem(result) { //vegatPopUp에서 선택한 품목 받아오기
	  document.getElementById('item').value=result;
	  document.getElementById('items').value=result;
  }

  function write_Article(obj) {
	  if(document.getElementById("item").value=="") {
		  alert("품목을 입력해주세요.");
		  return;
	  }
	  else if(document.getElementById("price").value=="") {
		  alert("가격을 입력해주세요.");
		  return;
	  }
	  else if(document.getElementById("title").value=="") {
		  alert("제목을 입력해주세요.");
		  return;
	  }
	  else if(document.getElementById("content").value=="") {
		  alert("내용을 입력해주세요.");
		  return;
	  }
	  else if(document.getElementById("imageCnt").value=="0") {
		  alert("사진을 하나 이상 첨부해주세요.");
		  return;
	  }
	  else {
		  obj.submit();
	  }
  }
  $(function(){
	  $("#price").on("keyup", function() { //가격에 숫자만 입력되도록 설정
		    $("#price").val($("#price").val().replace(/[^0-9]/g,""));
		});
  });
</script>
<title>Anabada</title>
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

	<div class="hero-wrap hero-bread"
		style="background-image: url('${contextPath}/resources/eunji/images/bg_1.jpg');">
		<div class="container">
			<div
				class="row no-gutters slider-text align-items-center justify-content-center">
				<div class="col-md-9 ftco-animate text-center">
					<p class="breadcrumbs">
						<span class="mr-2"><a href="${contextPath }/main">Home</a></span>
					</p>
					<h1 class="mb-0 bread">판매 신청</h1>
				</div>
			</div>
		</div>
	</div>

	<section class="ftco-section">
		<div class="container">
			<div class="comment-form-wrap pt-5">
				<form name="articleForm" method="post" action="${contextPath}/seller/addNewArticle" class="p-5 bg-light" enctype="multipart/form-data">
					<input type="hidden" id="imageCnt" value=0 >
					<div class="form-group">
						<label for="n_name">작성자</label>
						<input type="text" class="form-control" id="n_name" value="${member.n_name}" readonly />
					</div>
					<div class="form-group">
						<label for="items">품목</label>
						<input type="text" class="form-control" id="items" name="items" value="${article.item }" disabled />
						<input type="button" value="품목 찾기" class="btn btn-black py-3 px-5" onclick="_popUp()" style="margin-top:1.5%;">
						<input type="hidden" id="item" name="item"/>
					</div>
					<div class="form-group">
						<label for="price">가격</label>
						<input type="number" class="form-control" id="price" name="price" />
					</div>
					<div class="form-group">
						<label for="text">제목</label>
						<input type="text" class="form-control" id="title" name="title" />
					</div>
					<div class="form-group">
						<label for="content">내용</label>
						<textarea name="content" id="content" cols="30" rows="10" class="form-control"></textarea>
					</div>

					<div class="form-group">
						<label for="image">이미지</label>
						<img id="preview" src="#" width=150 height=150 style="display:none;"/>
						<input type="file" class="form-control" id="imageFileName" name="imageFileName" onchange="readURL(this);"/>
					</div>
					<div id="d_file"></div>
					<div class="form-group">
						<input type="button" value="이미지 추가" onClick="fn_addFile()" class="btn btn-black py-3 px-5"/>
					</div>

					<div class="col text-center">
						<div class="form-group">
							<input type="button" value="작성" onclick="write_Article(this.form)" class="btn py-3 px-4 btn-primary" />
							<input type="button" value="글 목록" onclick="backToList(this.form)" class="btn py-3 px-4 btn-primary" />
						</div>
					</div>
				</form>
			</div>
		</div>
	</section>

	<footer class="ftco-footer ftco-section">
		<div class="container">
			<div class="row">
				<div class="mouse" style="margin-top: 50px;">
					<a href="#" class="mouse-icon">
						<div class="mouse-wheel">
							<span class="ion-ios-arrow-up"></span>
						</div>
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
				<p>
					<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
					Copyright &copy;
					<script>
						document.write(new Date().getFullYear());
					</script>
						All rights reserved | This template is made with <i class="icon-heart color-danger" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
					<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
				</p>
			</div>
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

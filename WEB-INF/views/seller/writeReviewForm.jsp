<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
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
		width:50%;
	 	margin-left:auto;
		margin-right:auto;
		border-collapse:collapse;
	}

	td {
		text-align:center;
		padding:2% 1% 2% 1%;
		width:35%;
	}
		
	
	.starImage {
		cursor:pointer;
	}
</style>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script> 
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
	function changeStar(num) {
		var num1=parseInt(num);
		for(i=1; i<=num1; i++) {
			var image=document.getElementById("star"+i);
			image.src="${contextPath}/resources/image/star.png";
		}
		for(i=num1+1; i<=5; i++) {
			var image=document.getElementById("star"+i);
			image.src="${contextPath}/resources/image/star2.png";
		}
		$("#star").val(num);
	}

	function writeReview(obj) {
		if($("#star").val()=="") {
			alert("별점을 입력해주세요.");
			return;
		}
		else if($("#content").val()=="") {
			alert("리뷰 내용을 입력해주세요.");
			return;
		}
		else if($("#content").val().length < 10) {
			alert("리뷰 내용을 더 입력해주세요.");
			return;			
		}
		else {
			obj.submit();
		}
	}

	/** 게시판 - 상세 페이지 이동 */
	function goArticleDetail(articleNO){				
	location.href = "${contextPath}/seller/viewArticle?articleNO="+ articleNO ; 
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
            <h1 class="mb-0 bread">리뷰 작성</h1>
          </div>
        </div>
      </div>
    </div>
    
    
  <section class="ftco-section ftco-cart" style="padding:3em 0;">
  	<div class="container">
  		<div class="row">
  			<div class="col-md-12 ftco-animate">
			<div>
				<table class="p-5 bg-light">
					<tr>				
					<td width="2%"><img src="${contextPath}/download.do?articleNO=${articleNO}&imageFileName=${article.imageFileName}" id="preview" width="50" height="50" /></td>
					<td style="text-align:left;" onclick="javascript:goArticleDetail(${articleNO });">${article.title}</td>
					<%-- <td style="text-align:left;">${article.title}</td> --%>
					</tr>
				</table>
			</div>
			<br>
		
			<div>	
			<form name="reviewForm" method="post" action="${contextPath}/seller/addReview">
			<table class="p-5 bg-light" >

				<tr>
				<td >별점</td>
				<td ><img src="${contextPath }/resources/image/star2.png" width="20" height="20" id="star1" class="starImage" onclick="changeStar(1)" />
					<img src="${contextPath }/resources/image/star2.png" width="20" height="20" id="star2" class="starImage" onclick="changeStar(2)" />
					<img src="${contextPath }/resources/image/star2.png" width="20" height="20" id="star3" class="starImage" onclick="changeStar(3)" />
					<img src="${contextPath }/resources/image/star2.png" width="20" height="20" id="star4" class="starImage" onclick="changeStar(4)" />
					<img src="${contextPath }/resources/image/star2.png" width="20" height="20" id="star5" class="starImage" onclick="changeStar(5)" />
				
					<input type="hidden" value="" id="star" name="star" />
				</td>
				</tr>
				
				<tr>
					<td>리뷰</td>
					<td ><textarea name="content" id="content" rows="5" cols="40" maxlength="50" placeholder="10글자 이상 입력해주세요."></textarea></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align:center;"><a>
						<input type="button" class="btn py-3 px-4 btn-primary" value="등록" onclick="writeReview(this.form)">
					</a></td>
				</tr>
			</table>
			<input type="hidden" name="articleNO" value="${articleNO }" />
			<input type="hidden" name="orderNO" value="${orderNO }" />
			
			</form>
			</div>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false"  %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	tr.line {
		border-top-color:#d5d5d5;
		border-top-width:1.5px;
		border-top-style:solid;
	}
</style>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(document).ready(function() {
		var period="${period}";
		console.log(period+"!");
		var button;
		if(period=="1m") {
			button=document.getElementById("1mButton");
		}
		else if(period=="3m") {
			button=document.getElementById("3mButton");
		}
		else if(period=="6m") {
			button=document.getElementById("6mButton");
		}
		else if(period=="1y") {
			button=document.getElementById("1yButton");
		}
		button.style.background="#82ae46";
		
	});
	function view_Detail(articleNO) { //판매글로 이동
		location.href = "${contextPath}/seller/viewArticle?articleNO="+ articleNO;
	}
	function viewOrder(period) {
		location.href = "${contextPath}/order/myOrder?period="+ period;
	}
	function view_OrderDetail(orderNO_) { //주문 상세내역 보기
		 var form = document.createElement("form");
		 form.setAttribute("method", "post");
		 form.setAttribute("action", "${contextPath}/order/myOrderDetail");
	     var inputOrderNO_ = document.createElement("input");
	     inputOrderNO_.setAttribute("type","hidden");
	     inputOrderNO_.setAttribute("name","orderNO_");
	     inputOrderNO_.setAttribute("value", orderNO_);
	     form.appendChild(inputOrderNO_);
	     document.body.appendChild(form);
	     form.submit();
	}
	
	function writeReview(orderNO, articleNO) { //리뷰작성 form으로 이동
		 var form = document.createElement("form");
		 form.setAttribute("method", "post");
		 form.setAttribute("action", "${contextPath}/seller/writeReviewForm");
		 
	     var inputArticleNO = document.createElement("input");
	     var inputOrderNO = document.createElement("input");
	     
	     inputArticleNO.setAttribute("type","hidden");
	     inputArticleNO.setAttribute("name","articleNO");
	     inputArticleNO.setAttribute("value", articleNO);
	     
	     inputOrderNO.setAttribute("type","hidden");
	     inputOrderNO.setAttribute("name","orderNO");
	     inputOrderNO.setAttribute("value", orderNO);
	     
	     form.appendChild(inputArticleNO);
	     form.appendChild(inputOrderNO);
	     document.body.appendChild(form);
	     form.submit();
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
            <h1 class="mb-0 bread">내 주문</h1>
          </div>
        </div>
      </div>
    </div>

  <section class="ftco-section ftco-cart">
  	<div class="container">
  		<div class="row">
  			<div class="col-md-12 ftco-animate">
  				<div class="cart-list">
			  	  <div style="margin-left:auto;margin-right:auto;width:30%;">
					  <input type="button" value="1개월" id="1mButton" class="btn btn-primary py-2 px-3" style="width:22%; background:#9f9f9f; border:0;" onclick="viewOrder('1m')">
					  <input type="button" value="3개월" id="3mButton" class="btn btn-primary py-2 px-3" style="width:22%; background:#9f9f9f; border:0;" onclick="viewOrder('3m')">
					  <input type="button" value="6개월" id="6mButton" class="btn btn-primary py-2 px-3" style="width:22%; background:#9f9f9f; border:0;" onclick="viewOrder('6m')">
					  <input type="button" value="1년" id="1yButton" class="btn btn-primary py-2 px-3" style="width:22%; background:#9f9f9f; border:0;" onclick="viewOrder('1y')">
				  </div>
	 		 	  <br>
				  <table class="table">
				  	<thead class="thead-primary">
					  	<tr class="text-center">
					  		<th>주문 일자</th>
					  		<th colspan="2">&nbsp</th>
					  		<th>수량</th>
					  		<th>주문금액</th>
					  		<th>리뷰</th>
					  	</tr>
				    </thead>
				  	<c:choose>
					  	<c:when test="${empty orderList }">
					  		<tr class="text-center"><td colspan="6"><b>주문한 상품이 없습니다.</b></tr>
					  	</c:when>
					  	<c:otherwise>
					  		<c:set var="orderNO_" value="${orderList[0].orderNO_ }" />
					  		
						  	<c:forEach var="order" items="${orderList}" varStatus="num">
						  	  <c:choose>
						  			<c:when test="${num.count eq 1 || order.orderNO_ ne orderNO_ }">
						  			<tr class="line">
							  			<td><fmt:formatDate value="${order.orderDate }" pattern="yyyy.MM.dd"/><br>
							  				<b style="color:gray;text-decoration:underline;cursor:pointer;" onclick="view_OrderDetail(${order.orderNO_})">상세보기</b>
							  				<c:set var="orderNO_" value="${order.orderNO_ }" />
							  			</td>
							  			<td class="image-prod"><div class="img"><img src="${contextPath}/download.do?articleNO=${order.articleNO}&imageFileName=${order.imageVO.imageFileName}" style="width:100%;"/></div></td>
							  			<c:if test="${order.articleVO.deleted eq 0}">
							  				<td style="text-align:left;" class="product-name"><span onclick="view_Detail('${order.articleNO}')" style="cursor:pointer;">${order.articleVO.title }</span></td>
							  			</c:if>
							  			<c:if test="${order.articleVO.deleted eq 1}">
							  				<td style="text-align:left;" class="product-name"><span style="color:lightgray;">${order.articleVO.title }</span></td>
							  			</c:if>
							  			<td class="price">${order.quantity }</td>
							  			<td class="price">${order.price }원</td>
							  			<c:if test="${order.review_chk eq 'N' && order.articleVO.deleted eq 0 }">
							  				<td><input type="button" class="btn btn-primary py-3 px-4" value="리뷰작성" onclick="writeReview(${order.orderNO},${order.articleNO})"></td>
							  			</c:if>
							  			<c:if test="${order.review_chk eq 'Y'}">
							  				<td><input type="button" class="btn btn-primary py-3 px-4" value="작성완료" onclick="writeReview(${order.orderNO},${order.articleNO})" disabled></td>
							  			</c:if>
							  			<c:if test="${order.review_chk eq 'N' && order.articleVO.deleted eq 1}">
							  				<td><input type="button" class="btn btn-primary py-3 px-4" value="작성불가" onclick="writeReview(${order.orderNO},${order.articleNO})" disabled></td>
							  			</c:if>
							  		</tr>
						  			</c:when>
						  			<c:otherwise>
							  			<tr style="border:0;">
							  				<td></td>
								  			<td class="image-prod"><div class="img"><img src="${contextPath}/download.do?articleNO=${order.articleNO}&imageFileName=${order.imageVO.imageFileName}" style="width:100%;"/></div></td>
								  			<td style="text-align:left;" class="product-name"><span onclick="view_Detail('${order.articleNO}')" style="cursor:pointer;">${order.articleVO.title }</span></td>
								  			<td class="price">${order.quantity }</td>
								  			<td class="price">${order.price }원</td>
								  			<c:if test="${order.review_chk eq 'N' && order.articleVO.deleted eq 0 }">
								  				<td><input type="button" value="리뷰작성" class="btn btn-primary py-3 px-4" onclick="writeReview(${order.orderNO},${order.articleNO})"></td>
								  			</c:if>
								  			<c:if test="${order.review_chk eq 'Y'}">
								  				<td><input type="button" value="작성완료" class="btn btn-primary py-3 px-4" onclick="writeReview(${order.orderNO},${order.articleNO})" disabled></td>
								  			</c:if>
								  			<c:if test="${order.review_chk eq 'N' && order.articleVO.deleted eq 1}">
								  				<td><input type="button" value="작성불가" class="btn btn-primary py-3 px-4" onclick="writeReview(${order.orderNO},${order.articleNO})" disabled></td>
								  			</c:if>
								  		</tr>
						  			</c:otherwise>
						  	   </c:choose>
						  	</c:forEach>
					  	</c:otherwise>
				  	</c:choose>
				  </table>
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
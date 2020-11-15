<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false"  %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
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
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table {
		margin-left:auto;
		margin-right:auto;
		width:70%;
		border-collapse: collapse;
		text-align:center;
	}
	tr.line {
		border-bottom-color:gray;
		border-bottom-width:1px;
		border-bottom-style:solid;
	}
</style>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(document).ready(function() {
		$("#checkAll").click(function() {
	         if($("#checkAll").prop("checked")){
	             $("input[type=checkbox]").prop("checked",true); 
	         }else{
	             $("input[type=checkbox]").prop("checked",false); 
	         }
		});
	});

	function view_Detail(articleNO) { //판매글로 이동
		location.href = "${contextPath}/seller/viewArticle?articleNO="+ articleNO;
	}
	
	
	function check_Quantity(num) { //수량이 공백인지 확인 & 주문금액 변경
		var price_1=parseInt(document.getElementById("price_1"+num).value);
		var resultPrice=parseInt(document.getElementById("result").innerHTML); //결제금액
		const rp = document.getElementById("resultPrice");
		const totalPrice = document.getElementById("totalPrice");
		const shipPayment = 2500;
	
		
		console.log("adsffasd");
		if($("#quantity"+num).val()=='') {
			$("#quantity"+num).val(1); //수량을 1개로 변경
			document.getElementById("allPrice"+num).innerHTML=price_1+"원"; ////수량이 1개일 때의 가격으로 변경
			var tmp_allPrice=document.getElementById("tmp_allPrice"+num).value;
			resultPrice=resultPrice-parseInt(tmp_allPrice) + price_1;
			document.getElementById("result").innerHTML=resultPrice;
			const insertedHtml1 = resultPrice+shipPayment+"원";
			const insertedHtml2 = resultPrice+"원";
			totalPrice.innerHTML = insertedHtml1;
			rp.innerHTML = insertedHtml2;
			
			document.getElementById("tmp_allPrice"+num).value=price_1;
		}
		else {
			quantity=parseInt(document.getElementById("quantity"+num).value); //수량을 바꾸고 난 후의 수량 값
			var allPrice=parseInt(price_1*quantity);
			
			document.getElementById("allPrice"+num).innerHTML=allPrice+"원"; ////수량이 1개일 때의 가격으로 변경
			var tmp_allPrice=document.getElementById("tmp_allPrice"+num).value;
			resultPrice=resultPrice-parseInt(tmp_allPrice) + allPrice;
			document.getElementById("result").innerHTML=resultPrice;
			
			const insertedHtml1 = resultPrice+shipPayment+"원";
			const insertedHtml2 = resultPrice+"원";
			totalPrice.innerHTML = insertedHtml1;
			rp.innerHTML = insertedHtml2;
			document.getElementById("tmp_allPrice"+num).value=allPrice;

		}
	 }
	
	function deleteItem(articleNO) {
		if(window.confirm("장바구니에서 상품을 삭제하시겠습니까?")) {
			var n_name="${member.n_name}";
			$.ajax({
				type:"post",
				async:false,
				url:"${contextPath}/cart/deleteCart",
				data:{ articleNO : articleNO,
					   n_name : n_name
					},
				success:function(data) {
					if(data=="ok") {
						location.href="${contextPath}/cart/myCart";
					}
					else {
						alert("오류가 발생했습니다.다시 시도해주세요.");
						location.href='${contextPath}/main';
					}
				},
				error:function(data) {
					alert("오류가 발생했습니다.다시 시도해주세요.");
					location.href='${contextPath}/main';
				}
			});
		}
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
           	<li class="nav-item"><a href="${contextPath }/member/loginForm" class="nav-link">Sign In / Sign Up</a></li> <!-- 로그인 url 링크-->
           </c:if>
           <c:if test="${member ne null}">
            <li class="nav-item"><a href="${contextPath }/cart/myCart" class="nav-link" >Cart</a></li> <!-- 회원가입 url 링크-->
           	<li class="nav-item"><a href="${contextPath }/member/logout" class="nav-link">LogOut</a></li> <!-- 로그아웃 url 링크-->
           </c:if>
           </ul>
         </div>
       </div>
     </nav>

    <div class="hero-wrap hero-bread" style="background-image: url('${contextPath }/resources/eunji/images/bg_1.jpg');">
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate text-center">
          	<p class="breadcrumbs"><span class="mr-2"><a href="index.html">Home</a></span> <span>Cart</span></p>
            <h1 class="mb-0 bread">장바구니</h1>
          </div>
        </div>
      </div>
    </div>

    <section class="ftco-section ftco-cart">
			<div class="container">
				<div class="row">
    			<div class="col-md-12 ftco-animate">
    				<div class="cart-list">
	    				<table class="table">
						    <thead class="thead-primary">
						      <tr class="text-center">
						        <th>&nbsp;</th>
						        <th>상품명</th>
						        <th>가격</th>
						        <th>수량</th>
						        <th>총 금액</th>
						        <th>삭제</th>
						      </tr>
						    </thead>
						    <tbody>
						    <c:set var="resultPrice" value="0" />
	  	<c:choose>
	  		<c:when test="${empty cartList}">
	  			<tr>
	  				<td colspan="6">장바구니에 상품이 없습니다.</td>
	  			</tr>
	  		</c:when>
	  		<c:otherwise>
	  		  <c:forEach  var="cart" items="${cartList }" varStatus="num">
			  	<tr class="text-center">
			  		<!-- <td><input type="checkbox" name="itemCheck${num.count }" class="itemCheck" value="${cart.articleNO }" checked></td> -->
			  		<td><img src="${contextPath}/download.do?articleNO=${cart.articleNO}&imageFileName=${cart.imageVO.imageFileName}" id="preview${num.count}" width="50" height="50"/></td>
			  		<td style="text-align:left;"><span onclick="view_Detail('${cart.articleNO}')" style="cursor:pointer;">${cart.articleVO.title }</span></td>
			  		<td class="price">
			  			${cart.articleVO.price }원
			  			<input type="hidden" id="price_1${num.count }" value=${cart.articleVO.price } />
			  		</td>
			  		<td class="quantity">
			  			<input type="number" id="quantity${num.count}" name="quantity${num.count}" value="${cart.quantity }" min="1" max="20" onchange="check_Quantity(${num.count})">개
			  		</td>
			  		<td><span id="allPrice${num.count }">${cart.articleVO.price * cart.quantity }원</span>
			  			<input type="hidden" id="tmp_allPrice${num.count }" value=${cart.articleVO.price * cart.quantity } />
			  			<c:set var= "resultPrice" value="${resultPrice + cart.articleVO.price * cart.quantity}"/>
			  		</td>
			  		<td>
			  			<input type="button" value="삭제" onclick="deleteItem(${cart.articleNO})">
			  		</td>
			  	</tr>
			  </c:forEach>
		  	</c:otherwise>
		  </c:choose>
		  	<tr>
		  		<td colspan="6" style="text-align:end;">결제금액 : <span id="result">${resultPrice}</span>원
		  		<input type="hidden" id="len" name="len" value="${fn:length(cartList)}"/>
			</tr>
			<c:if test="${!empty cartList}">
			</c:if>
				

						    </tbody>
						  </table>
					  </div>
    			</div>
    		</div>
    		<div class="row justify-content-end">
    			<div class="col-lg-4 mt-5 cart-wrap ftco-animate">
    				<div class="cart-total mb-3">
    					<h3>Cart Totals</h3>
    					<p class="d-flex">
    						<span>장바구니 합계</span>
    						<span id="resultPrice">${resultPrice}원</span>
    					</p>
    					<p class="d-flex">
    						<span>배송료</span>
    						<span>2,500원</span>
    					</p>
    					<p class="d-flex">
    						<span>할인</span>
    						<span>0원</span>
    					</p>
    					<hr>
    					<p class="d-flex total-price">
    						<span>결제 금액</span>
    						<span id="totalPrice">${resultPrice+2500}원</span>
    					</p>
    				</div>
    				<p><a href="checkout.html" class="btn btn-primary py-3 px-4">결제</a></p>
    			</div>
    		</div>
			</div>
		</section>

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
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
  <script src="${contextPath }/resources/eunji/js/google-map.js"></script>
  <script src="${contextPath }/resources/eunji/js/main.js"></script>

  <script>
		$(document).ready(function(){

		var quantitiy=0;
		   $('.quantity-right-plus').click(function(e){
		        
		        // Stop acting like a button
		        e.preventDefault();
		        // Get the field name
		        var quantity = parseInt($('#quantity').val());
		        
		        // If is not undefined
		            
		            $('#quantity').val(quantity + 1);

		          
		            // Increment
		        
		    });

		     $('.quantity-left-minus').click(function(e){
		        // Stop acting like a button
		        e.preventDefault();
		        // Get the field name
		        var quantity = parseInt($('#quantity').val());
		        
		        // If is not undefined
		      
		            // Increment
		            if(quantity>0){
		            $('#quantity').val(quantity - 1);
		            }
		    });
		    
		});
	</script>
    
</body>
</html>
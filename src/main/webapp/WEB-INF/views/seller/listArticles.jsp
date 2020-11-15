<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<%
  request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<style>
   .cls1 {text-decoration:none;}
   .cls2{text-align:center; font-size:30px;}
</style>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Anabada</title>
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
</head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
   function fn_articleForm(isLogOn,articleForm,loginForm){
     if(isLogOn != '' && isLogOn != 'false'){
       location.href=articleForm;
       console.log(articlesList);
     }else{
       alert("로그인 후 글쓰기가 가능합니다.")
       location.href=loginForm+'?action=/seller/articleForm';
     }
   }

	function _bookmark(articleNO) {
		var image=document.getElementById("book");
		if("${log}"=='') {
			alert("로그인이 필요합니다.");
			location.href = "${contextPath}/member/loginForm?action=/board/boardList";
		}
		else { //로그인이 된 상태일 때 북마크 설정
			var n_name="${member.n_name}";
			$.ajax({
				type:"post",
				async:false,
				url:"${contextPath}/board/add_delete_Bookmark",
				data: {post_NO : articleNO,
					   n_name : n_name,
					   category : "농부"
				},
				success:function (data,textStatus){
					if(data=='exist'){
						alert("북마크를 해제했습니다.");
					}
					else if(data=="n_exist"){
						alert("북마크를 추가했습니다.");
					}
				},
				error:function(data,textStatus){
					alert("오류가 발생했습니다. 다시 시도해주세요.");
				},
				complete:function(data,textStatus){
				}

			});
		}
	}

  /* 키워드 검색 */
   function searchTitle() {
      var keyword = $('#keyword').val();
      location.href='${contextPath}/seller/listArticles?keyword='+keyword;
      console.log("keyword : "+keyword);
   }

  /* 작성자 조회 */
    function writedArticle(url, writer) {
       var form = document.createElement("form");
       form.setAttribute("method", "post");
       form.setAttribute("action", url);
       var n_nameInput = document.createElement("input");
       n_nameInput.setAttribute("type","hidden");
       n_nameInput.setAttribute("name","writer");
       n_nameInput.setAttribute("value", writer);
      form.appendChild(n_nameInput);
      document.body.appendChild(form);
      form.submit();
    }

	function _addCart(articleNO) {
		var n_name="${member.n_name}";
	    $.ajax({
	    	type:"post",
		    async:false,
		    url:"${contextPath}/cart/addCart",
		    data: {articleNO : articleNO,
		           n_name : n_name,
		           quantity : 1
		    },
		    success:function (data) {
		    	if(data=='ok'){
		    		alert("장바구니에 추가했습니다.");
		    	}
		        else {
		        	alert("장바구니에 이미 상품이 존재합니다.");
		        }
		    },
		    error:function(data) {
		    	alert("오류가 발생했습니다. 다시 시도해주세요.");ㅣ
		    },
		    complete:function(data) {
		    }
	    });
	}

	function _goPay(articleNO) {
		 var form = document.createElement("form");
		 form.setAttribute("method", "post");
		 form.setAttribute("action", "${contextPath}/order/deliveryForm");

		 var articleNO_Input = document.createElement("input");
		 var quantity_Input = document.createElement("input");

		 articleNO_Input.setAttribute("type","hidden");
		 articleNO_Input.setAttribute("name","articleNO");
		 articleNO_Input.setAttribute("value", articleNO);

		 quantity_Input.setAttribute("type","hidden");
		 quantity_Input.setAttribute("name","quantity");
		 quantity_Input.setAttribute("value", 1);

	     form.appendChild(articleNO_Input);
	     form.appendChild(quantity_Input);
		 document.body.appendChild(form);
		 form.submit();
	}
</script>
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
					<h1 class="mb-0 bread">공동구매</h1>
				</div>
			</div>
		</div>
	</div>



  <section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col text-right">
						<a href="javascript:fn_articleForm('${log}','${contextPath}/seller/articleForm', '${contextPath}/member/loginForm')" class="btn py-3 px-4 btn-primary">판매 신청</a>
				</div>
			</div>
			<br>
			<c:choose>
				<c:when test="${articlesList ==null }">
					<tr height="10">
						<td colspan="4">
							<p align="center">
								<b><span style="font-size: 9pt;">등록된 글이 없습니다.</span></b>
							</p>
						</td>
					</tr>
				</c:when>
				<c:when test="${articlesList !=null }">
					<div class="row">
						<c:forEach var="article" items="${articlesList }"
							varStatus="articleNum">
							<div class="col-md-6 col-lg-3 ftco-animate">
								<div class="product">
									<a
										href="${contextPath}/seller/viewArticle?articleNO=${article.articleNO}"
										class="img-prod"><img class="img-fluid" style="width:100%;height:260px;"
										src="${contextPath}/download.do?articleNO=${article.articleNO}&imageFileName=${article.imageFileName}"
										alt="Colorlib Template"></a>
									<div class="text py-3 pb-4 px-3 text-center">
										<h3>
											<a href="#">${article.title }</a>
										</h3>
										<div class="d-flex">
											<div class="pricing">
												<p class="price">
													<span class="price-sale">${article.price }원</span>
												</p>
											</div>
										</div>
										<div class="bottom-area d-flex px-3">
											<div class="m-auto d-flex">
												<a href="#"
													class="add-to-cart d-flex justify-content-center align-items-center text-center" onclick="_goPay(${article.articleNO})">
													<span><i class="ion-ios-menu"></i></span>
												</a> <a href="#"
													class="buy-now d-flex justify-content-center align-items-center mx-1" onclick="_addCart(${article.articleNO})">
													<span><i class="ion-ios-cart"></i></span>
												</a> <a href="#"
													class="heart d-flex justify-content-center align-items-center " onclick="_bookmark(${article.articleNO})">
													<span><i class="ion-ios-heart"></i></span>
												</a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</c:when>
			</c:choose>

			<!-- 페이징 -->
			<c:choose>
				<c:when test="${keyword == null }">
					<c:choose>
						<c:when test="${writer == null }">

							<div class="row mt-5">
								<div class="col text-center">
									<div class="block-27">
										<ul>
											<c:if test="${pageMaker.prev }">
												<li><a href="/seller/listArticles?page=${pageMaker.startPage-1 }">&lt;</a></li>
											</c:if>
											<c:forEach begin="${pageMaker.startPage }"
												end="${pageMaker.endPage }" var="pageNum">
												<li><a href='<c:url value="/seller/listArticles?page=${pageNum }"/>'><i>${pageNum }</i></a></li>
											</c:forEach>
											<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
												<li><a href="/seller/listArticles?page=${pageMaker.endPage+1 }">&gt;</a></li>
											</c:if>
										</ul>
									</div>
								</div>
							</div>

						</c:when>
						<c:otherwise>
							<div class="row mt-5">
								<div class="col text-center">
									<div class="block-27">
										<ul>
											<c:if test="${pageMaker.prev }">
												<li><a href="#" onClick="writedArticle('${contextPath}/seller/listArticles?page=${pageMaker.startPage-1 }', '${writer}')">&lt;</a></li>
											</c:if>
											<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
												<li><a href="#" onClick="writedArticle('${contextPath}/seller/listArticles?page=${pageNum }', '${writer}')">${pageNum }</a></li>
											</c:forEach>
											<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
												<li><a href="#" onClick="writedArticle('${contextPath}/seller/listArticles?page=${pageMaker.endPage+1 }', '${writer}')">&gt;</a></li>
											</c:if>
										</ul>
									</div>
								</div>
							</div>
						</c:otherwise>
					</c:choose>
				</c:when>

				<c:when test="${keyword !=null }">
					<div class="row mt-5">
						<div class="col text-center">
							<div class="block-27">
								<ul>
									<c:if test="${pageMaker.prev }">
										<li><a href="/seller/listArticles?keyword=${keyword }&page=${pageMaker.startPage-1 }">&lt;</a></li>
									</c:if>
									<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
										<li><a href='<c:url value="/seller/listArticles?keyword=${keyword }&page=${pageNum }"/>'><i>${pageNum }</i></a></li>
									</c:forEach>
									<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
										<li><a href="/seller/listArticles?keyword=${keyword }&page=${pageMaker.endPage+1 }">&gt;</a></li>
									</c:if>
								</ul>
							</div>
						</div>
					</div>
					<h3>
						<a href='<c:url value="/seller/listArticles"/>'>글 목록으로 돌아가기</a>
					</h3>
				</c:when>
			</c:choose>

			<!-- 키워드 검색 -->
      <div class="sidebar-box">
          <form action="#" class="search-form">
              <div class="form-group">
                  <span class="icon ion-ios-search" onclick="searchTitle();"></span>
                  <input type="text" id="keyword" class="form-control" placeholder="Search...">
              </div>
          </form>
      </div>
	</section>




	<footer class="ftco-footer ftco-section">
      <div class="container">
        <div class="row mb-5">
          <div class="col-md">
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
        <div class="row">
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
  <script src="${contextPath }/resources/eunji/js/main.js"></script>


</body>
</html>

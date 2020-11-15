<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<c:set var="article"  value="${articleMap.article}"  />
<c:set var="reviewList"  value="${articleMap.reviewList}"  />
<c:set var="imageFileList"  value="${articleMap.imageFileList}"  />

<%
  request.setCharacterEncoding("UTF-8");
%>

<head>
<meta charset="UTF-8">
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
<title>Anabada</title>
<style>
.image {
	border-radius:100%;
}
#tr_file_upload {
	display: none;
}
#tr_btn_modify {
	display: none;
}
#table1 {
     
    width:100%;
    border-collapse: collapse;
}
   .line1 {
      width:100px;
      border-bottom: 1px solid rgba(0, 0, 0, 0.1);
      border-bottom-width:2px;
      border-bottom-style:solid;
   }
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
     function backToList(obj){
	    obj.action="${contextPath}/seller/listArticles";
	    obj.submit();
     }
	 // 글 삭제
	 function fn_remove_article(url,articleNO){
		 var form = document.createElement("form");
		 form.setAttribute("method", "post");
		 form.setAttribute("action", url);
	     var articleNOInput = document.createElement("input");
	     articleNOInput.setAttribute("type","hidden");
	     articleNOInput.setAttribute("name","articleNO");
	     articleNOInput.setAttribute("value", articleNO);
	     form.appendChild(articleNOInput);
	     document.body.appendChild(form);
	     form.submit();
	 }
	 // 글 승인
	 function fn_accept_article(url, articleNO) {
		 var form = document.createElement("form");
		 form.setAttribute("method", "post");
		 form.setAttribute("action", url);
		 var articleNOInput = document.createElement("input");
	     articleNOInput.setAttribute("type","hidden");
	     articleNOInput.setAttribute("name","articleNO");
	     articleNOInput.setAttribute("value", articleNO);
	     form.appendChild(articleNOInput);
	     document.body.appendChild(form);
	     form.submit();
	 }
	 // 글 수정
	 function fn_modify_article(url,articleNO){
		 var form = document.createElement("form");
		 form.setAttribute("method", "post");
		 form.setAttribute("action", url);
	     var articleNOInput = document.createElement("input");
	     articleNOInput.setAttribute("type","hidden");
	     articleNOInput.setAttribute("name","articleNO");
	     articleNOInput.setAttribute("value", articleNO);
	     form.appendChild(articleNOInput);
	     document.body.appendChild(form);
	     form.submit();
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

	 /* 채팅창 이동 */
	 	 function chatBox(toID) {
	 		 	 var form = document.createElement("form");
	 		 	 form.setAttribute("method", "post");
	 			 form.setAttribute("action", "${contextPath}/chat");
	 			 var toID_Input = document.createElement("input");
	 			 toID_Input.setAttribute("type","hidden");
	 			 toID_Input.setAttribute("name","toID");
	 			 toID_Input.setAttribute("value", toID);
	 		   form.appendChild(toID_Input);
	 		   document.body.appendChild(form);
	 		   form.submit();
	 }

	 function readURL(input) {
	     if (input.files && input.files[0]) {
	         var reader = new FileReader();
	         reader.onload = function (e) {
	             $('#preview').attr('src', e.target.result);
	         }
	         reader.readAsDataURL(input.files[0]);
	     }
	 }
	 function check_Quantity() { //수량이 공백인지 확인
		 if($("#quantity").val()=='') {
			 $("#quantity").val(1);
		 }
	 }
	 function goPay(form) { //바로구매
		 var quantity=parseInt(document.getElementById("quantity").value);
		 var price=parseInt(document.getElementById("price").value);
		 $("#price").val(quantity*price);
		 form.submit();
	 }
	function _bookmark() {
		var image=document.getElementById("book");
		var articleNO = $("#articleNO").val(); //글번호
		if(image.alt=="uncheck") { //북마크 해지된 상태일 때
			if("${log}"=='') { //로그인이 안되어 있는 상태일 때
				alert("로그인이 필요합니다.");
				location.href = "${contextPath}/member/loginForm?action=/seller/viewArticle?articleNO=" + articleNO;
			}
			else { //로그인이 된 상태일 때 북마크 설정
				var n_name="${member.n_name}";
				$.ajax({
					type:"post",
				    async:false,
					url:"${contextPath}/board/addSellBookmark",
					data: {post_NO : articleNO,
						   n_name : n_name,
						   category : "농부"
						  },
					success:function (data,textStatus){
						if(data=='ok'){
							alert("북마크를 추가했습니다.");
						    image.src="${contextPath}/resources/image/bookmark2.png";
					   	    image.alt="check";
						}
						else {
							alert("오류가 발생했습니다. 다시 시도해주세요.");
						}
					},
					error:function(data,textStatus){
						alert("오류가 발생했습니다. 다시 시도해주세요.");ㅣ
					},
					complete:function(data,textStatus){
					}
				});
			}
		}
		else { //북마크 설정된 상태일 때 북마크 해지
			var n_name="${member.n_name}";
		    $.ajax({
		    	type:"post",
		   	    async:false,
				url:"${contextPath}/board/deleteSellBookmark",
				data: {post_NO : articleNO,
					   n_name : n_name,
					   category : "농부"
					  },
				success:function (data,textStatus){
					if(data=='ok'){
						alert("북마크를 해제했습니다.");
						image.src="${contextPath}/resources/image/bookmark.png";
				  	    image.alt="uncheck";
					}
					else {
						alert("오류가 발생했습니다. 다시 시도해주세요.");
					}
				},
				error:function(data,textStatus){
					alert("오류가 발생했습니다. 다시 시도해주세요.");ㅣ
				},
				complete:function(data,textStatus){
				}
		    });
		}
	}
	function addCart() {
		var n_name="${member.n_name}";
	    var articleNO=document.getElementById("articleNO").value;
	    var quantity=document.getElementById("quantity").value;
	    $.ajax({
	    	type:"post",
		    async:false,
		    url:"${contextPath}/cart/addCart",
		    data: {articleNO : articleNO,
		           n_name : n_name,
		           quantity : quantity
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
    //정은수정2
	function goBookList() {
		location.href = "${contextPath}/board/myBookmark";
	}
	/* 정은수정2 */
	function goMyFarmerList() {
		var writer= $("#board_writer").val();
		location.href = "${contextPath}/board/myFarmerList?user="+writer;
	}

	function goMyBoardList() {
		var writer= $("#board_writer").val();
		console.log("writer확인: "+writer);
		if("${log}"=='') {
			alert("로그인이 필요합니다.");
			location.href = "${contextPath}/member/loginForm?action=/board/myBoardList?user="+writer;			
		}
		else {
			location.href = "${contextPath}/board/myBoardList?user="+writer;		
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
    <!-- END nav -->

    <div class="hero-wrap hero-bread" style="background-image: url('${contextPath}/resources/eunji/images/bg_1.jpg');">
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate text-center">
          	<p class="breadcrumbs"><span class="mr-2"><a href="${contextPath }/main">Home</a></span></p>
            <h1 class="mb-0 bread">상품 상세</h1>
          </div>
        </div>
      </div>
    </div>

	<form name="frmArticle" method="post" action="${contextPath}/order/deliveryForm" enctype="multipart/form-data">
		<section class="ftco-section" style="padding:6em 0 2rem 0;">
	    	<div class="container">
		    <input type="hidden" id="board_writer" name="board_writer" value="${article.n_name}" />
		    <span style="float:right;">
				<c:if test="${result eq 'false' }">
					<img src="${contextPath }/resources/image/bookmark.png" id="book" width="43" height="43" alt="uncheck" style="cursor: pointer;" onclick="_bookmark()">
				</c:if>
				<c:if test="${result eq 'true' }">
					<img src="${contextPath }/resources/image/bookmark2.png" id="book" width="43" height="43" alt="check" style="cursor: pointer;" onclick="_bookmark()">
				</c:if>
			</span>
	    		<div class="row">
	    			<div class="col-lg-6 mb-5 ftco-animate">
	    				<input type="hidden" name="articleNO" id="articleNO" value="${article.articleNO}" />
	    				<input  type= "hidden"   name="originalFileName" value="${item.imageFileName }" />
	    				<img src="${contextPath}/download.do?articleNO=${article.articleNO}&imageFileName=${imageFileList[0].imageFileName}" height="350" width="100%" >
	    			</div>
	    			<div class="col-lg-6 product-details pl-md-5 ftco-animate">
	    				<h3>${article.title }</h3>
	    				<p class="price" style="margin-bottom:0.5%;"><span style="font-size:23px;">${article.item}</span></p>
						<p class="price"><span>${article.price }원</span></p>
						<br>
						<c:choose>
							<c:when test="${profile eq null or profile eq ''}">
			                    <img src="${contextPath}/resources/eunji/images/user.png" style="margin-right: 10px;" class="image" width="25" height="25">
							</c:when>
							<c:otherwise>
								<img src="${contextPath}/member/download?profile=${profile }" width="25" height="25" class="image" style="margin-right: 10px;">
							</c:otherwise>
						</c:choose>
						<a href="#" onClick="goMyBoardList()">${article.n_name }</a> <ui style="padding-left: 5px;padding-right: 5px;">ㆍ</ui><ui style="padding-right: 10px;">조회수</ui><ui>${article.hits }</ui><ui style="padding-left: 5px;padding-right: 5px;">ㆍ</ui><ui style="padding-right: 10px;">작성일시</ui><ui><fmt:formatDate pattern = "yyyy-MM-dd HH:mm" value="${article.writeDate}" /></ui>
	    				<p style="padding-top: 50px;">${article.content }
						<div class="row mt-4">
					  		<div class="col-md-12" style="margin-top: 20px;">
							<p style="color: #000;">인천 연수구</p>
		          			</div>
	          			</div>

			    		<c:if test="${member.n_name eq 'admin' }">
			    			<a href="#" class="btn btn-black py-3 px-4" onClick="chatBox('${article.n_name}')">연락하기</a>
			    			<a href="#" class="btn btn-black py-3 px-4" onClick="fn_accept_article('${contextPath}/seller/accept', ${article.articleNO })">승인하기</a>
			    			<a href="#" class="btn btn-black py-3 px-4" onClick="fn_remove_article('${contextPath}/seller/removeArticle', ${article.articleNO})">삭제하기</a>
						</c:if>
			    		<c:if test="${member.n_name ne 'admin' && member.n_name ne article.n_name && member ne null }">
			    				<p><input type="number" id="quantity" name="quantity" value="1" min="1" max="20" onchange="check_Quantity()">개</p>
			    				<a href="#" class="btn btn-black py-3 px-4" onClick="chatBox('${article.n_name}')">연락하기</a>
			    				<a href="#" class="btn btn-black py-3 px-4" onClick="addCart()">장바구니</a>
			    				<input type="submit" class="btn btn-black py-3 px-4" value="바로구매">
			   			</c:if>
	   				</div>
	    		</div>

	    		<hr>
	    		<br>

				<div class="col text-center">
					<div class="form-group">
						<c:if test="${not empty imageFileList && imageFileList!='null' }">
				  			<c:forEach var="item" items="${imageFileList}" varStatus="status" >
				  				<c:if test="${status.index != 0 }">
						    		<tr>
							   			<td>
							     			<input  type= "hidden"   name="originalFileName" value="${item.imageFileName }" />
											<img src="${contextPath}/download.do?articleNO=${article.articleNO}&imageFileName=${item.imageFileName}" height="350" width="450" id="preview"  /><br>
							   				<br>
							   			</td>
							  		</tr>
						 		</c:if>
							</c:forEach>
						</c:if>
					</div>
				</div>
	    	</div>
		</section>
	</form>

	<section class="ftco-section ftco-degree-bg" style="padding:0 0 2rem 0;">
      <div class="container">
      <c:if test="${member.n_name == article.n_name}">
      			<a href="#" class="btn btn-primary py-3 px-4" style="float:right;" onClick="fn_remove_article('${contextPath}/seller/removeArticle', ${article.articleNO})">삭제하기</a>
	  	<a href="#" class="btn btn-primary py-3 px-4" style="float:right;margin-right:0.5%;" onClick="fn_modify_article('${contextPath}/seller/modForm', ${article.articleNO})">수정하기</a>
	  </c:if>
	  <br>
         <div>	 
      	 <h3 class="mb-5" >Product Reviews</h3>    	 
		<table  id="table1" cellpadding="5" > 
		<c:choose>
			<c:when test="${empty reviewList }">
				<tr>
					<td colspan="2"> <h3 class="mb-5">후기가 없습니다.</h3>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach var="review" items="${reviewList}" varStatus="status" >
					<tr>
						
						<th class="line1" rowspan="3" width="12%" style="padding-top:1%;">
							<c:if test="${review.memberVO.profile eq null }">
								<p style="text-align: center;"><img src="${contextPath }/resources/image/no_profile.png" class="image" width="50" height="50"></p>
							</c:if>
							<c:if test="${review.memberVO.profile ne null }">
								<p style="text-align: center;"><img src="${contextPath}/member/download?profile=${review.memberVO.profile}" class="image" width="50" height="50"></p>
							</c:if>
						
						</th>
						<th>
							<c:if test="${review.star ==1 }">
								<img src="${contextPath }/resources/image/star.png" class="profile" width="15" height="15">
							</c:if>
							<c:if test="${review.star ==2 }">
								<img src="${contextPath }/resources/image/star.png" class="profile" width="15" height="15">
								<img src="${contextPath }/resources/image/star.png" class="profile" width="15" height="15">
							</c:if>
							<c:if test="${review.star ==3 }">
								<img src="${contextPath }/resources/image/star.png" class="profile" width="15" height="15">
								<img src="${contextPath }/resources/image/star.png" class="profile" width="15" height="15">
								<img src="${contextPath }/resources/image/star.png" class="profile" width="15" height="15">
							</c:if>
							<c:if test="${review.star ==4 }">
								<img src="${contextPath }/resources/image/star.png" class="profile" width="15" height="15">
								<img src="${contextPath }/resources/image/star.png" class="profile" width="15" height="15">
								<img src="${contextPath }/resources/image/star.png" class="profile" width="15" height="15">
								<img src="${contextPath }/resources/image/star.png" class="profile" width="15" height="15">
							</c:if>
							<c:if test="${review.star ==5 }">
								<img src="${contextPath }/resources/image/star.png" class="profile" width="15" height="15">
								<img src="${contextPath }/resources/image/star.png" class="profile" width="15" height="15">
								<img src="${contextPath }/resources/image/star.png" class="profile" width="15" height="15">
								<img src="${contextPath }/resources/image/star.png" class="profile" width="15" height="15">
								<img src="${contextPath }/resources/image/star.png" class="profile" width="15" height="15">
							</c:if>
							
							</th>
					</tr>
					<tr>
						<td><b>${review.n_name }</b>&nbsp&nbsp ${review.writedate }</td>
					</tr>
					<tr class="line">
						<td class="line1" colspan="3" >${review.content }</td>
					</tr>
					
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
	</div>
	</div>
	</section>

	<br>
	<div class="col text-center">
		<div class="form-group">
			<c:if test="${action != 'book' and active !='mylist' }">
				<input type=button value="글 목록" onClick="backToList(frmArticle)" class="btn btn-white py-3 px-5">
			</c:if>
			<c:if test="${action eq 'book' }">
				<button type="button"  onclick="javascript:goBookList();" class="btn btn-white py-3 px-5">북마크 목록</button>
			</c:if>
			<!-- 정은수정 -->
			<c:if test="${active eq 'mylist' }">
				<button type="button" onclick="javascript:goMyFarmerList();" class="btn btn-white py-3 px-5">글 조회 목록</button>
			</c:if>
		</div>
	</div>

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
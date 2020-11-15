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

<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>

	$(document).ready(function() {
		get_BoardList();
	});

	function _viewDetail1(post_NO) { //북마크한 판매글로 이동
		location.href = "${contextPath}/board/boardDetail?boardSeq="+ post_NO+"&action=book";
	}

	function _viewDetail2(post_NO) { //북마크한 농부글로 이동
		location.href = "${contextPath}/seller/viewArticle?articleNO="+ post_NO+"&action=book";
	}

	function _viewDetail3(post_NO) { //북마크한 교환글로 이동
		location.href = "${contextPath}/exchange/boardDetail?boardSeq="+ post_NO+"&action=book";
	}

	function _viewDetail4(post_NO) { //북마크한 나눔글로 이동
		location.href = "${contextPath}/share/boardDetail?boardSeq="+ post_NO+"&action=book";
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

	function get_BoardList() {
		var n_name="${member.n_name}";
		var boardPage=parseInt($("#boardPage").val());
		$.ajax({
			type:"post",
			async:false,
			url:"${contextPath}/board/listBoardBookmark",
			data: {n_name : n_name,
				   page : boardPage
			},
			success:function (obj){
				html="";
				html+="<thead class='thead-primary'>";
				html+="<tr class='text-center'>";
				html+="<th>&nbsp;</th>";
				html+="<th>찜 목록</th>";
				html+="<th>카테고리</th>";
				html+="<th>&nbsp;</th>";
				html+="<th>&nbsp;</th>";
				html+="<th>채팅하기</th></tr></thead>";
				html+="<tbody>";
				if(obj.length!=0) {
					$.each(obj, function(idx,val) {
						html+="<tr class='text-center'>";
						html+="<td class='product-remove'><a href='#' onclick=deleteBookmark('판매',"+val.post_NO+") >";
						html+="<span class='ion-ios-close'></span></a></td>";
						html+="<td class='image-prod'><div class='img'><img style='width:100%;' src='${contextPath}/board/fileDownload?fileNameKey="+encodeURI(val.boardFileForm.file_name_key)+"&fileName="+encodeURI(val.boardFileForm.file_name)+"&filePath="+encodeURI(val.boardFileForm.file_path)+"' width='90' height='90'/></div></td>";

						html+="<td class='product-name'>"+val.category+"</td>";
						html+="<td colspan='2' class='product-name'><span style='cursor:pointer;' onclick='_viewDetail1("+val.post_NO+")' >"+val.boardForm.board_subject+"</span></td>";
				        html+="<td class='quantity'> <a href='#' class='btn btn-primary py-3 px-4' onclick=chatBox('"+val.boardForm.board_writer+"') >연락하기</a></td></tr>";
					});
				}
				else {
					html+="<tr align='center'><td colspan='6'><b>북마크한 글이 없습니다.</b></td></tr>";
				}
				$("#bookTable").html(html);
				paging1();

				document.getElementById("boardButton").style.background="#82ae46";
				document.getElementById("farmerButton").style.background="#9f9f9f";
				document.getElementById("exchangeButton").style.background="#9f9f9f";
				document.getElementById("shareButton").style.background="#9f9f9f";
			},
			error:function(data,textStatus){
				alert("오류가 발생했습니다. 다시 시도해주세요.");
			},
			complete:function(data,textStatus){
			}

		});
	}

	function get_FarmerList() {
		var n_name="${member.n_name}";
		var farmerPage=parseInt($("#farmerPage").val());
		$.ajax({
			type:"post",
			async:false,
			url:"${contextPath}/seller/listFarmerBookmark",
			data: {n_name : n_name,
				   page : farmerPage
			},
			success:function (obj){
				html="";
				html+="<thead class='thead-primary'>";
				html+="<tr class='text-center'>";
				html+="<th>&nbsp;</th>";
				html+="<th>찜 목록</th>";
				html+="<th>카테고리</th>";
				html+="<th>&nbsp;</th>";
				html+="<th>&nbsp;</th>";
				html+="<th>채팅하기</th></tr></thead>";
				html+="<tbody>";
				if(obj.length!=0) {
					$.each(obj, function(idx,val) {
						html+="<tr class='text-center'>";
						html+="<td class='product-remove'><a href='#' onclick=deleteBookmark('농부',"+val.post_NO+") >";
						html+="<span class='ion-ios-close'></span></a></td>";
						html+="<td class='image-prod'><div class='img'><img style='width:100%;' src='${contextPath}/download.do?articleNO="+val.post_NO+"&imageFileName="+val.imageVO.imageFileName+"' width='90' height='90'/></div></td>";
						html+="<td class='product-name'>"+val.category+"</td>";
						html+="<td colspan='2' class='product-name'><span style='cursor:pointer;' onclick='_viewDetail2("+val.post_NO+")' >"+val.articleVO.title+"</span></td>";
				        html+="<td class='quantity'> <a href='#' class='btn btn-primary py-3 px-4' onclick=chatBox('"+val.articleVO.n_name+"') >연락하기</a></td></tr>";
				});
			}
			else {
				html+="<tr align='center'><td colspan='6'><b>북마크한 글이 없습니다.</b></td></tr>";
			}
				$("#bookTable").html(html);
				paging2();

				document.getElementById("boardButton").style.background="#9f9f9f";
				document.getElementById("farmerButton").style.background="#82ae46";
				document.getElementById("exchangeButton").style.background="#9f9f9f";
				document.getElementById("shareButton").style.background="#9f9f9f";
			},
			error:function(data,textStatus){
				alert("오류가 발생했습니다. 다시 시도해주세요.");
			},
			complete:function(data,textStatus){
			}

		});
	}

	function get_ExchangeList() {
		var n_name="${member.n_name}";
		var exchangePage=parseInt($("#exchangePage").val());
		$.ajax({
			type:"post",
			async:false,
			url:"${contextPath}/exchange/listExchangeBookmark",
			data: {n_name : n_name,
				   page : exchangePage
			},
			success:function (obj){
				html="";
				html+="<thead class='thead-primary'>";
				html+="<tr class='text-center'>";
				html+="<th>&nbsp;</th>";
				html+="<th>찜 목록</th>";
				html+="<th>카테고리</th>";
				html+="<th>&nbsp;</th>";
				html+="<th>&nbsp;</th>";
				html+="<th>채팅하기</th></tr></thead>";
				html+="<tbody>";
				if(obj.length!=0) {
					//console.log(obj);
					$.each(obj, function(idx,val) {
						var index=parseInt(idx)+1; //"<img src ='${contextPath}/board/fileDownload?fileNameKey="+encodeURI(fileNameKey)+"&fileName="+encodeURI(fileName)+"&filePath="+encodeURI(filePath)+"' width=300/>";
						html+="<tr class='text-center'>";
						html+="<td class='product-remove'><a href='#' onclick=deleteBookmark('교환',"+val.post_NO+") >";
						html+="<span class='ion-ios-close'></span></a></td>";
						html+="<td class='image-prod'><div class='img'><img style='width:100%;' src='${contextPath}/board/fileDownload?fileNameKey="+encodeURI(val.boardFileForm.file_name_key)+"&fileName="+encodeURI(val.boardFileForm.file_name)+"&filePath="+encodeURI(val.boardFileForm.file_path)+"' width='90' height='90'/></div></td>";

						html+="<td class='product-name'>"+val.category+"</td>";
						html+="<td colspan='2' class='product-name'><span style='cursor:pointer;' onclick='_viewDetail3("+val.post_NO+")' >"+val.boardForm.board_subject+"</span></td>";
						//html+="<td>&nbsp;</td>";
				        html+="<td class='quantity'> <a href='#' class='btn btn-primary py-3 px-4' onclick=chatBox('"+val.boardForm.board_writer+"') >연락하기</a></td></tr>";
					});
				}
				else {
					html+="<tr align='center'><td colspan='6'><b>북마크한 글이 없습니다.</b></td></tr>";
				}
				$("#bookTable").html(html);
				paging3();

				document.getElementById("boardButton").style.background="#9f9f9f";
				document.getElementById("farmerButton").style.background="#9f9f9f";
				document.getElementById("exchangeButton").style.background="#82ae46";
				document.getElementById("shareButton").style.background="#9f9f9f";
			},
			error:function(data,textStatus){
				alert("오류가 발생했습니다. 다시 시도해주세요.");
			},
			complete:function(data,textStatus){
			}

		});
	}

	function get_ShareList() {
		var n_name="${member.n_name}";
		var sharePage=parseInt($("#sharePage").val());
		$.ajax({
			type:"post",
			async:false,
			url:"${contextPath}/share/listShareBookmark",
			data: {n_name : n_name,
				   page : sharePage
			},
			success:function (obj){
				html="";
				html+="<thead class='thead-primary'>";
				html+="<tr class='text-center'>";
				html+="<th>&nbsp;</th>";
				html+="<th>찜 목록</th>";
				html+="<th>카테고리</th>";
				html+="<th>&nbsp;</th>";
				html+="<th>&nbsp;</th>";
				html+="<th>채팅하기</th></tr></thead>";
				html+="<tbody>";
				if(obj.length!=0) {
					//console.log(obj);
					$.each(obj, function(idx,val) {
						html+="<tr class='text-center'>";
						html+="<td class='product-remove'><a href='#' onclick=deleteBookmark('나눔',"+val.post_NO+") >";
						html+="<span class='ion-ios-close'></span></a></td>";
						html+="<td class='image-prod'><div class='img'><img style='width:100%;' src='${contextPath}/board/fileDownload?fileNameKey="+encodeURI(val.boardFileForm.file_name_key)+"&fileName="+encodeURI(val.boardFileForm.file_name)+"&filePath="+encodeURI(val.boardFileForm.file_path)+"' width='90' height='90'/></div></td>";

						html+="<td class='product-name'>"+val.category+"</td>";
						html+="<td colspan='2' class='product-name'><span style='cursor:pointer;' onclick='_viewDetail4("+val.post_NO+")' >"+val.boardForm.board_subject+"</span></td>";
				        html+="<td class='quantity'> <a href='#' class='btn btn-primary py-3 px-4' onclick=chatBox('"+val.boardForm.board_writer+"') >연락하기</a></td></tr>";
					});
				}
				else {
					html+="<tr align='center'><td colspan='6'><b>북마크한 글이 없습니다.</b></td></tr>";
				}
				$("#bookTable").html(html);
				paging4();

				document.getElementById("boardButton").style.background="#9f9f9f";
				document.getElementById("farmerButton").style.background="#9f9f9f";
				document.getElementById("exchangeButton").style.background="#9f9f9f";
				document.getElementById("shareButton").style.background="#82ae46";
			},
			error:function(data,textStatus){
				alert("오류가 발생했습니다. 다시 시도해주세요.");
			},
			complete:function(data,textStatus){
			}

		});
	}

	function paging1() { //판매 북마크 페이징
		html="";
		var cntBoard=$("#cntBoard").val();
		var end=parseInt((parseInt(cntBoard)-1)/10 +1);
		for(i=1; i<=end; i++) {
				html+="<a href='#' onclick='sendPage1("+i+")'>"+i+"</a>&nbsp;&nbsp;";
		}

		document.getElementById("paging").innerHTML=html;
	}

	function paging2() { //농부 북마크 페이징
		html="";
		var cntFarmer=$("#cntFarmer").val();
		var end=parseInt((parseInt(cntFarmer)-1)/10 +1);
		for(i=1; i<=end; i++) {
				html+="<a href='#' onclick='sendPage2("+i+")'>"+i+"</a>&nbsp;&nbsp;";
		}

		document.getElementById("paging").innerHTML=html;

	}

	function paging3() { //교환 북마크 페이징
		html="";
		var cntExchange=$("#cntExchange").val();
		var end=parseInt((parseInt(cntExchange)-1)/10 +1);
		for(i=1; i<=end; i++) {
				html+="<a href='#' onclick='sendPage3("+i+")'>"+i+"</a>&nbsp;&nbsp;";
		}

		document.getElementById("paging").innerHTML=html;

	}

	function paging4() { //나눔 북마크 페이징
		html="";
		var cntShare=$("#cntShare").val();
		var end=parseInt((parseInt(cntShare)-1)/10 +1);
		for(i=1; i<=end; i++) {
				html+="<a href='#' onclick='sendPage4("+i+")'>"+i+"</a>&nbsp;&nbsp;";
		}

		document.getElementById("paging").innerHTML=html;

	}

	function sendPage1(page) { //판매 페이지 바꾸기
		$("#boardPage").val(page);
		get_BoardList();
	}

	function sendPage2(page) { //농부 페이지 바꾸기
		$("#farmerPage").val(page);
		get_FarmerList();
	}

	function sendPage3(page) { //교환 페이지 바꾸기
		$("#exchangePage").val(page);
		get_ExchangeList();
	}

	function sendPage4(page) { //나눔 페이지 바꾸기
		$("#sharePage").val(page);
		get_ShareList();
	}

	function deleteBookmark(category,post_NO) {
		var n_name="${member.n_name}";
	    $.ajax({
	    	type:"post",
	   	    async:false,
			url:"${contextPath}/board/deleteSellBookmark",
			data: {post_NO : post_NO,
				   n_name : n_name,
				   category : category
				  },
			success:function (data,textStatus){
				if(data=='ok'){
					alert("북마크를 해제했습니다.");
					location.href="${contextPath}/board/myBookmark";
				}
				else {
					alert("오류가 발생했습니다. 다시 시도해주세요.");
					location.href="${contextPath}/board/myBookmark";
				}
			},
			error:function(data,textStatus){
				alert("오류가 발생했습니다. 다시 시도해주세요.");
				location.href="${contextPath}/board/myBookmark";
			},
			complete:function(data,textStatus){
			}
	    });
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
            <h1 class="mb-0 bread">북마크</h1>
          </div>
        </div>
      </div>
    </div>



  <!-- 현재 페이지 -->
  <input type="hidden" id="boardPage" value="1"/>
  <input type="hidden" id="farmerPage" value="1"/>
  <input type="hidden" id="exchangePage" value="1"/>
  <input type="hidden" id="sharePage" value="1"/>

  <section class="ftco-section ftco-cart">
  	<div class="container">
  		<div class="row">
  			<div class="col-md-12 ftco-animate">
  				<div class="cart-list">
 				<span>
 					<input type="button" value="판매" id="boardButton" class="btn btn-primary py-2 px-3" style="background:#82ae46;border:0;" onclick="get_BoardList()">
  					<input type="button" value="공동구매" id="farmerButton" class="btn btn-primary py-2 px-3" style="background:#9f9f9f;border:0;" onclick="get_FarmerList()">
  					<input type="button" value="교환" id="exchangeButton" class="btn btn-primary py-2 px-3" style="background:#9f9f9f;border:0;" onclick="get_ExchangeList()">
  					<input type="button" value="나눔" id="shareButton" class="btn btn-primary py-2 px-3" style="background:#9f9f9f;border:0;" onclick="get_ShareList()">
  				</span>
  				<br>
  				<br>
		  			<table class="table" id="bookTable">
		  			</table>
				    <br>

				    <!-- 글의 수 -->
				    <input type="hidden" value=${resultCntMap.cntBoard } id="cntBoard">
				    <input type="hidden" value=${resultCntMap.cntFarmer } id="cntFarmer">
				    <input type="hidden" value=${resultCntMap.cntExchange } id="cntExchange">
				    <input type="hidden" value=${resultCntMap.cntShare } id="cntShare">
			    </div>
			 </div>
	  	</div>
	 </div>
	</section>

	  <div id="paging" style="text-align:center;">
	  	<c:forEach   var="page" begin="1" end="${(resultCntMap.cntBoard-1)/10 +1}" step="1" >
	  		<a href="#" onclick="sendPage1(${page})">${page }</a>&nbsp;&nbsp;
		</c:forEach>
	  </div>



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

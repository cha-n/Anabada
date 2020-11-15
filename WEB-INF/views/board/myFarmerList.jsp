<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 정은 수정 -->
<title>Anabada</title>
<%
	String user=request.getParameter("user");
%>
<c:set var="user" value="<%=user%>"/>
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
		border-bottom-color:gray;
		border-bottom-width:1px;
		border-bottom-style:solid;
	}
	td.content {
		padding:2%;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(document).ready(function(){
		getMyFarmerList();
		//체크박스
		$(".chBox").click(function(){
			//allcheck인지 확인
			$("#allCheck").prop("checked", false);
		});


		//선택삭제
		$(".selectDelete_btn").click(function(){
				var confirm_val = confirm("정말 삭제하시겠습니까?");
				var user = $("#board_writer").val(); //글작성자
				if(confirm_val) {
					var checkArr = new Array();

					$("input[class='chBox']:checked").each(function(){
					 checkArr.push($(this).attr("value"));
					 });

			 		 $.ajax({
			  		url : "${contextPath}/board/deleteMyFarmerList?user="+ user, //전송
			  		type : "post",
			  		data : { chbox : checkArr },
			  	 	success : function(result){
				  	 	if(result==1){
			  	 		location.href = "${contextPath}/board/myFarmerList?user="+ user; //전송이 이상없으면 새로고침
				  	 	} else{
					  	 	alert("삭제 실패");
					  	 	}
						}
			 		 });
			 	}
		 });
	});

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
	/** 게시판 - 내가쓴글목록(판매 )페이지 이동 */
	function goMyBoardList() {
		var user = $("#board_writer").val(); //글작성자
		location.href = "${contextPath}/board/myBoardList?user="+ user;
	}

	/** 게시판 - 쓴글목록(교환)페이지 이동 */
	function goMyExchangeList() {
		var user = $("#board_writer").val(); //글작성자
		location.href = "${contextPath}/exchange/myExchangeList?user="+user;
	}

	/** 게시판 - 쓴글목록(나눔)페이지 이동 */
	function goMyShareList() {
		var user = $("#board_writer").val(); //글작성자
		location.href = "${contextPath}/share/myShareList?user="+user;
	}

	/** 게시판 - 상세 페이지 이동 */
	function goArticleDetail(articleNO){
	location.href = "${contextPath}/seller/viewArticle?articleNO="+ articleNO +"&active=mylist";
	}


	function getMyFarmerList(currentPageNo){

		document.getElementById("boardButton").style.background="#9f9f9f";
		document.getElementById("farmerButton").style.background="#82ae46";
		document.getElementById("exchangeButton").style.background="#9f9f9f";
		document.getElementById("shareButton").style.background="#9f9f9f";

		var user = $("#board_writer").val(); //글작성자
		if(currentPageNo ===undefined ){
			currentPageNo = "1";
		}

		$("#current_page_no").val(currentPageNo);

		$.ajax({

		    url		:"${contextPath}/board/getMyFarmerList?user="+ user,
		    data    : $("#boardForm").serialize(),
	        dataType:"JSON",
	        cache   : false,
			async   : false,
			type	:"POST",
	        success : function(obj) {
	        	getMyFarmerListCallback(obj);
	        },
	        error 	: function(xhr, status, error) {}

	     });
	}

	/** 게시판 - 목록 조회  콜백 함수 */
	function getMyFarmerListCallback(obj){
		var user = $("#board_writer").val(); //글작성자
		var state = obj.state;

		if(state == "SUCCESS"){

			var data = obj.data;
			var list = data.list;
			var listLen = list.length;
			var totalCount = data.totalCount;
			var pagination = data.pagination;
			var n_name= $("#n_name").val();
			var str = "";

			if(listLen >  0){
				for(var a=0; a<listLen; a++){

				console.log(list[a]);

					var articleNO	= list[a].articleNO;
					var title 		 =list[a].title;
					var accepted    =list[a].accepted
					var imgeFileName =list[a].imageFileName;

					str += "<tr class='text-center'>";
					if( n_name == user){
						str+= "<td class='checkBox'><input type='checkbox' name='chBox' class='chBox' value="+articleNO+" />"+ "</td>";
					}
					//정은이
					str+= "<td class='image-prod'><div class='img'><img style='width:100%;' src='${contextPath}/download.do?articleNO="+ articleNO +"&imageFileName="+ imgeFileName +"' width='90' height='90'></div></td>";
					str += "<td onclick='javascript:goArticleDetail("+ articleNO +");' style='cursor:Pointer'>"+title +"</td>";
					str+= "<td>&nbsp;</td>";
					str+= "<td>&nbsp;</td>";
					if (n_name == user){
						if(accepted=='1'){
							str += "<td>"+ "Y" +"</td>";
						}
						else {
							str += "<td>"+ "N" +"</td>";
						}
					}
					str+= "<td class='quantity'><a href='#' class='btn btn-primary py-3 px-5' onClick='chatBox(\""+user+"\");'>연락하기</a></td>";
					str += "</tr>"; //줄바꿈

				}

			} else {

				str += "<tr>";
				str += "<td colspan='8'><b>등록된 글이 존재하지 않습니다.<b></td>";
				str += "<tr>";
			}

			$("#tbody").html(str);
			$("#total_count").text(totalCount);
			$("#pagination").html(pagination);

		} else {
			alert("관리자에게 문의하세요.");
			return;
		}
	}


</script>
</head>
<body class="goto-here">
	<!-- START nav -->
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
            <h1 class="mb-0 bread">${user}'s Product List</h1>

          </div>
        </div>
      </div>
    </div>

	<form id="boardForm" name="boardForm">
		<input type="hidden" id="function_name" name="function_name" value="getMyBoardList" />
		<input type="hidden" id="current_page_no" name="current_page_no" value="1" />
		<input type="hidden" id="board_writer" name="board_writer" value="${user}" />
		<input type="hidden" id="n_name" value="${member.n_name }" >  <!-- 로그인n_name -->

		<section class="ftco-section ftco-cart">
			<div class="container">

<!-- 			<div class="sidebar-box ftco-animate">
			<div class="tagcloud">
				<a href="#" class="tag-cloud-link" onclick="getMyFarmerList()">공동구매</a>
				<a href="#" class="tag-cloud-link" onclick="goMyShareList()">나눔</a>
				<a href="#" class="tag-cloud-link" onclick="goMyBoardList()">판매</a>
				<a href="#" class="tag-cloud-link" onclick="goMyExchangeList()">교환</a>
			</div>
			</div>

			전체페이지수
			<div align="left" class="page_info">
				<span class="total_count"><strong>전체</strong> : <span id="total_count" class="t_red">0</span>개</span>
			</div> -->

			<div class="row">
    			<div class="col-md-12 ftco-animate">
    				<div class="cart-list">
     				<span>
 					<input type="button" value="판매" id="boardButton" class="btn btn-primary py-2 px-3" style="background:#82ae46;border:0;" onclick="goMyBoardList()">
  					<input type="button" value="공동구매" id="farmerButton" class="btn btn-primary py-2 px-3" style="background:#9f9f9f;border:0;" onclick="getMyFarmerList()">
  					<input type="button" value="교환" id="exchangeButton" class="btn btn-primary py-2 px-3" style="background:#9f9f9f;border:0;" onclick="goMyExchangeList()">
  					<input type="button" value="나눔" id="shareButton" class="btn btn-primary py-2 px-3" style="background:#9f9f9f;border:0;" onclick="goMyShareList()">
  					</span>
    			  	<br>
  					<br>
    					<table class="table">
    						<thead class="thead-primary">
						      <tr class="text-center">
						        <c:if  test= "${user == member.n_name}">
						        <th>&nbsp;</th>
						        </c:if>
						        <th>판매글 목록</th>
						        <th>제목</th>
								<th>&nbsp;</th>
								<th>&nbsp;</th>
								<c:if  test= "${user == member.n_name}">
								<th>승인여부</th>
						         </c:if>
						        <th>연락하기</th>
						      </tr>
						    </thead>
    							<tbody id=tbody>
    							</tbody>
    					   </table>

					</div>
					<br>
					<br>
					<!-- 본인만 삭제가능 -->
					<c:if  test= "${user == member.n_name}">
						<div class="allCheck" >
							<input type="checkbox" name="allCheck" id="allCheck" />
							<labelfor="allCheck">모두 선택</label>
							<script>
								$("#allCheck").click(function() {
									var chk = $("#allCheck").prop("checked");
									if (chk) {
									$(".chBox").prop("checked", true);
									} else {
									$(".chBox").prop("checked", false);
									}
								});
						   </script>
					   </div>

					  <div class="delBtn">
							<button type="button"class="selectDelete_btn" style="background-color:white;cursor:pointer;" >선택 삭제</button>
					 </div>
				</c:if>
				</div>
			</div>
			</div>
		</section>

		<div align="center" id="pagination"></div>
	</form>


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

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Anabada</title>

    <meta charset="utf-8">
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
<!-- <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> 
<script type="text/javascript" src="${contextPath}/js/common/jquery.js"></script>-->
<script src="${contextPath }/resources/eunji/js/jquery.min.js"></script>
<script type="text/javascript" src="${contextPath}/js/common/jquery.form.js"></script>
<script type="text/javascript">

	/**예슬 코드*/
	function _popUp1() { //장소 변경 popup 열기
		var option="width=450,height=160";
		window.open("${contextPath}/market/locatPopUp","",option);
	}
	
	function _popUp2() { //품목 선택 popup 열기
		var option="width=500,height=500";
		window.open("${contextPath}/board/vegatPopUp","",option);
	}
	
	function _getLocat(locat) { //locatPopUp에서 장소 받아오기
		document.getElementById('location').value=locat;
		document.getElementById('locat').value=locat;
	}
	
	function _getItem(result) { //vegatPopUp에서 선택한 품목 받아오기
		result=result.substring(0,result.length-1);
		document.getElementById('item').value=result;
		document.getElementById('items').value=result; 
	}
	
	function readURL(input) {
		if (input.files && input.files[0]) {
			var filename=input.files[0].name;
			var ext=filename.substr(filename.length-3,filename.length);
			if(ext !="jpg" && ext !="gif" && ext !="png") { //이미지 파일이 아닐 때
				alert("이미지파일을 선택해주세요.");
				return;
			}
			var reader = new FileReader();
			reader.onload = function (e) {
			document.getElementById("preview1").style.display="block";
			$('#preview1').attr('src', e.target.result);
			var imageCnt=parseInt($('#imageCnt').val())+1;
			document.getElementById("imageCnt").value=imageCnt;
			}
		    reader.readAsDataURL(input.files[0]);
		}
	}
	

	
	/**정은 코드*/
	$(document).ready(function() {
		
	});


	/** 게시판 - 목록 페이지 이동 */
	function goBoardList() {
		location.href = "${contextPath}/board/boardList";
	}

	/** 게시판 - 작성  */
	function insertBoard() {

		var boardSubject = $("#board_subject").val();
		var boardContent = $("#board_content").val();
		var item=$("#items").val();

		console.log(item);
		
		if (boardSubject == "") {
			alert("제목을 입력해주세요.");
			$("#board_subject").focus();
			return;
		}
		
		if(item=="") {
			alert("품목을 선택해주세요.");
			return;
		}

		if (boardContent == "") {
			alert("내용을 입력해주세요.");
			$("#board_content").focus();
			return;
		}
		
		if(document.getElementById("imageCnt").value=="0") {
			alert("사진을 첨부해주세요.");
			return;
		}

		var yn = confirm("게시글을 등록하시겠습니까?");
		if (yn) {

			var filesChk = $("input[name='files[0]']").val();
			if (filesChk == "") {
				$("input[name='files[0]']").remove();
			}

			$("#boardForm").ajaxForm({

				url : "${contextPath}/board/insertBoard",
				enctype : "multipart/form-data",
				cache : false,
				async : true,
				type : "POST",
				success : function(obj) {
					insertBoardCallback(obj);
				},
				error : function(xhr, status, error) {
				}

			}).submit();

		}
	}

	/** 게시판 - 작성 콜백 함수 */
	function insertBoardCallback(obj) {

		if (obj != null) {

			var result = obj.result;

			if (result == "SUCCESS") {
				alert("게시글 등록을 성공하였습니다.");
				goBoardList();
			} else {
				alert("게시글 등록을 실패하였습니다.");
				return;
			}
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
						<span>Anabada</span>
					</p>
					<h1 class="mb-0 bread">판매글 작성</h1>
				</div>
			</div>
		</div>
	</div>
   
   
   
   	<section class="ftco-section"> 
		<div class="container">
			<div class="comment-form-wrap pt-5">				
					<form id="boardForm" name="boardForm" action="/board/insertBoard" class="p-5 bg-light" enctype="multipart/form-data" method="post" onsubmit="return false;">
					<input type="hidden" id="imageCnt" value=0 >				
					
 
					<div id=tboay>
					
										
					<div class="form-group">
						<label for="board_writer">작성자</label>
						<input type="text" class="form-control" id="board_writer" name="board_writer1" value="${member.n_name}" disabled>
						<input id="board_writer" type="hidden" name="board_writer" value="${member.n_name}">
					</div>
					
					<div class="form-group">
						<label for="locat">장소</label>
						<br>
							<div style="float: left; width: 78%; margin-right:10px;">
								<input type="text" class="form-control" id="location" value="${member.address }" disabled>
							</div>
							<input type="hidden" id="locat" name="locat">
							<input type="button" value="장소 변경" class="btn btn-black py-3 px-5" onclick="_popUp1()">				
					</div>
					
					
					<div class="form-group">
						<label for="items">품목</label>
						<br>
						<div style="float: left; width: 78%; margin-right:10px;">
							<input type="text" class="form-control" id="items" name="items" value=""  disabled/>
						</div>
						<input type="button" value="품목 찾기" class="btn btn-black py-3 px-5" onclick="_popUp2()">
						<input type="hidden" id="item" name="item">
					</div>
					<div class="form-group">
						<label for="board_subject">제목</label>
						<input type="text" class="form-control" id="board_subject" name="board_subject" value="" />
					</div>	

					<div class="form-group">
						<label for="board_content">내용</label>
						<textarea id="board_content" name="board_content" cols="10" rows="5" class="form-control" ></textarea>
					</div>
					
					<div class="form-group">
						<label for="image">이미지</label>
						<img id="preview1" src="#" width=150 height=150 style="display:none;"/>
						<input type="file"  class="form-control" id="files[0]" name="files[0]" id="imageFileName1" onchange="readURL(this);"/>
					</div>
				</div>
																	
				<div class="col text-center">			
				<div class="form-group">	
					<button type="button"  class="btn py-3 px-4 btn-primary" onclick="javascript:goBoardList();">목록으로</button>
					<button type="button"  class="btn py-3 px-4 btn-primary" onclick="javascript:insertBoard();">등록하기</button>
				</div>
				</div>
				
				</form>
																
			</div>
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
								<li><span class="icon icon-map-marker"></span><span
									class="text">인천광역시 연수구 송도1동 아카데미로 119</span></li>
								<li><a href="#"><span class="icon icon-phone"></span><span
										class="text">010.3333.1532</span></a></li>
								<li><a href="#"><span class="icon icon-envelope"></span><span
										class="text">anabada@gmail.com</span></a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 text-center">

					<p>
						<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
						Copyright &copy;
						<script>document.write(new Date().getFullYear());</script>
						All rights reserved | This template is made with <i
							class="icon-heart color-danger" aria-hidden="true"></i> by <a
							href="https://colorlib.com" target="_blank">Colorlib</a>
						<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
					</p>
				</div>
			</div>
		</div>
	</footer>
	
<script>
	var add=document.getElementById("location").value;
	var end=add.indexOf(' ');
	var area=add.substring(0,end);
	if(area=='제주특별자치도')
		area='제주';
	else if(area=='세종특별자치시')
		area='세종';
	//동,읍,면 이름
	var start=add.indexOf('(');
	if(start!=-1) { //동일 때
	    end=add.indexOf(')');
	    dong=add.substring(start+1,end);
	}
	else { //읍,면일 때
		var tmp=add.split(" ");
		dong=tmp[2];
	}
	
	area=area+' '+dong;
	document.getElementById('location').value=area;
	document.getElementById('locat').value=area;
</script>	
	
	
	
	<!-- loader -->
	<div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>

<%-- 	<script src="${contextPath }/resources/eunji/js/jquery.min.js"></script>
 --%>	<script src="${contextPath }/resources/eunji/js/jquery-migrate-3.0.1.min.js"></script>
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
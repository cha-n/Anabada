<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html lang="en">
<head>
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
 </head>   
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){	
		getBoardList();
	});		
	
	
	function _bookmark(boardSeq) {
		var image=document.getElementById("book");
		if("${log}"=='') {
			alert("로그인이 필요합니다.");
			location.href = "${contextPath}/member/loginForm?action=/exchange/boardList";
		}
		else { //로그인이 된 상태일 때 북마크 설정
			var n_name="${member.n_name}";
			$.ajax({
				type:"post",
				async:false,
				url:"${contextPath}/board/add_delete_Bookmark",
				data: {post_NO : boardSeq,
					   n_name : n_name,
					   category : "교환"
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
	
	/** 게시판 - 상세 페이지 이동 */
	function goBoardDetail(boardSeq){				
		location.href = "${contextPath}/exchange/boardDetail?boardSeq="+ boardSeq;
	}
	
	/** 게시판 - 작성 페이지 이동 */
	function goBoardWrite(log){
		if(log==true)
			
			location.href = "${contextPath}/exchange/boardWrite";
		else {
			alert("로그인이 필요합니다.");
			location.href = "${contextPath}/member/loginForm?action=/exchange/boardWrite";
		}
	}

	/** 게시판 - 목록 조회  */
	function getBoardList(currentPageNo){
				
		if(currentPageNo ===undefined){
			currentPageNo = "1";
		}
		
		$("#current_page_no").val(currentPageNo);


		$.ajax({	
		
			url		:"${contextPath}/exchange/getBoardList?"+"searchType="+$("select option:selected").val()+ "&keyword="+encodeURIComponent($('#keywordInput').val()),
		    data    : $("#boardForm").serialize(),
	        dataType:"JSON",
	        cache   : false,
			async   : false,
			type	:"POST",	
	        success : function(obj) {
				getBoardListCallback(obj);				
	        },	       
	        error 	: function(xhr, status, error) {}
	        
	     });
	}
	
	/** 게시판 - 목록 조회  콜백 함수 */
	function getBoardListCallback(obj){

		var state = obj.state;
		
		if(state == "SUCCESS"){
			
			var data = obj.data;			
			var list = data.list;		
			var listLen = list.length;	
			var totalCount = data.totalCount;
			var pagination = data.pagination;
			
			
			
			var str = "";
			
			if(listLen >  0){
				
				for(var a=0; a<listLen; a++){
					//console.log(list[a]);	
					var boardSeq		= list[a].board_seq; 
					var boardReRef 		= list[a].board_re_ref; 
					var boardReLev 		= list[a].board_re_lev; 
					var boardReSeq 		= list[a].board_re_seq; 
					var boardWriter 	= list[a].board_writer; 
					var boardSubject 	= list[a].board_subject; 
					var boardContent 	= list[a].board_content; 
					var boardHits 		= list[a].board_hits;
					var delYn 			= list[a].del_yn; 
					var insUserId 		= list[a].ins_user_id;
					var insDate 		= list[a].ins_date; 
					var updUserId 		= list[a].upd_user_id;
					var updDate 		= list[a].upd_date;
					var imgs			=list[a].imgs;
					var locat 			=list[a].locat;
					var fileName	=imgs.file_name;
					var fileNameKey	=imgs.file_name_key;
					var filePath    =imgs.file_path; 
						
					str += "<div class='col-md-6 col-lg-3 ftco-animate fadeInUp ftco-animated' ><div class='product'><a href='javascript:goBoardDetail("+ boardSeq +");' class='img-prod'>";	
					str += "<img class='img-fluid' style='width:100%;height:260px;' src ='${contextPath}/board/fileDownload?fileNameKey="+encodeURI(fileNameKey)+"&fileName="+encodeURI(fileName)+"&filePath="+encodeURI(filePath)+"' alt="+boardSeq+">";									
					str += "<div class='overlay'></div></a>";	

					if(boardReLev > 0){						
						for(var b=0; b<boardReLev; b++){					
							str += "Re:";
						}
					}							
					str +="<div class='text py-3 pb-4 px-3 text-center'><h3>"+ boardSubject +"</h3>";
					str += "<onclick='javascript:goBoardDetail("+ boardSeq +");' style='cursor:Pointer'>";
					str += "<div class='bottom-area d-flex px-3'><div class='m-auto d-flex'>";
					//str +="<a href='javascript:goBoardDetail("+ boardSeq +");' class='add-to-cart d-flex justify-content-center align-items-center text-center'><span><i class='ion-ios-menu'></i></span></a>&nbsp";
					/* str +="<a href='#' class='buy-now d-flex justify-content-center align-items-center mx-1'><span><i class='ion-ios-cart'></i></span></a>"; */
					str +="<a href='#' class='heart d-flex justify-content-center align-items-center ' onclick='_bookmark("+boardSeq+")' ><span><i class='ion-ios-heart'></i></span></a>";
					str+= "</div></div></div></div></div>" ;


				/*	if(boardReLev > 0){						
						for(var b=0; b<boardReLev; b++){					
							str += "Re:";
						}
					}
					
					str += boardSubject +"</td>";										
					str += "<td>"+ boardHits +"</td>";
					str += "<td>"+ boardWriter +"</td>";	
					str += "<td>"+ insDate +"</td>";
					str += "<td>"+ locat +"</td>";	
					str += "</tr>"; */
					
				} 
				
			} else {
							
				str += "<h3>등록된 글이 존재하지 않습니다.</h3>";
			}
			
			$("#tbody").html(str);
			$("#total_count").text(totalCount);
			$("#pagination").html(pagination);
			
		} else {
			alert("관리자에게 문의하세요.");
			return;
		}		
	}
	
	//정은수정 키워드 검색
	function searchTitle() {
		var keyword = $('#keywordInput').val();
		var searchType= $("select option:selected").val();
		getBoardList();
		//self.href = "${contextPath}/board/boardList" + "&searchType=" + searchType + "&keyword=" + encodeURIComponent(keyword);
		console.log("keyword : "+keyword);
		console.log("searchType: "+ searchType);
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
          	<p class="breadcrumbs"><span>Anabada</span></p>
            <h1 class="mb-0 bread">교환</h1>
          </div>
        </div>
      </div>
    </div>
    
     	<section class="ftco-section">   
       <div class="container">
        
  	      <div class="row justify-content-center">
    		<div class="col-md-10 mb-1 text-center">
    			<ul class="product-category">
    				<h3>Vegetables</h3>   					
    			</ul>
    		</div>
    	  </div>
  	 	<form id="boardForm" name="boardForm">
    			<input type="hidden" id="function_name" name="function_name" value="getBoardList" />
				<input type="hidden" id="current_page_no" name="current_page_no" value="1" />
    	   		<!--전체 글 갯수-->
				<div class="page_info">
						<span class="total_count"><strong>전체</strong> : <span id="total_count" class="t_red">0</span>개</span>
				</div>
    	  
    	  <div id="tbody" class="row">									
		 </div> <!--<div  id="tbody" class="row">  --> 
			  </form>   
		
		 		
		<!--글 작성하기 버튼 -->		
		<div class="quantity"> 
			<div class="col text-right">
				<button type="button" class="btn btn-primary py-3 px-4" onclick="javascript:goBoardWrite(${log});">작성하기</button>
			</div>
		</div>
	
			<!--키워드 검색 -->
			<div class="sidebar-box">
				<form action="#" class="search-form">

					<select name="searchType" class="form-group">
						<option value="n"
							<c:out value="${searchType == null ? 'selected' : ''}"/>>선택</option>
						<option value="S"
							<c:out value="${searchType eq 'S' ? 'selected' : ''}"/>>제목</option>
						<option value="C"
							<c:out value="${searchType eq 'C' ? 'selected' : ''}"/>>내용</option>
						<option value="L"
							<c:out value="${searchType eq 'L' ? 'selected' : ''}"/>>지역</option>
						<option value="SL"
							<c:out value="${searchType eq 'SL' ? 'selected' : ''}"/>>제목+지역</option>
					</select>

					<div class="form-group">
						<span class="icon ion-ios-search" onclick="searchTitle();"></span>
						<input type="text" name="keyword" id="keywordInput"
							value="${keyword}" class="form-control" placeholder="Search..." />
					</div>
				</form>
			</div>
			
		<br>
		<div id="pagination"></div>	
		
	</div> <!-- container -->
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
  <script src="${contextPath }/resources/eunji//js/jquery.magnific-popup.min.js"></script>
  <script src="${contextPath }/resources/eunji/js/aos.js"></script>
  <script src="${contextPath }/resources/eunji/js/jquery.animateNumber.min.js"></script>
  <script src="${contextPath }/resources/eunji/js/bootstrap-datepicker.js"></script>
  <script src="${contextPath }/resources/eunji/js/scrollax.min.js"></script>
  <script src="${contextPath }/resources/eunji/js/main.js"></script>
  
  <script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
  <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>


</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Anabada</title>
<%	
	String boardSeq = request.getParameter("boardSeq");		
%>

<c:set var="boardSeq" value="<%=boardSeq%>"/> <!-- 게시글 번호 -->

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
<script type="text/javascript" src="${contextPath}/js/common/jquery.js"></script> -->
<script src="${contextPath }/resources/eunji/js/jquery.min.js"></script>
<script type="text/javascript" src="${contextPath}/js/common/jquery.form.js"></script>
<script type="text/javascript">
	
	/**예슬 코드 */
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
	/* 	document.getElementById('item').value=result; */
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
			document.getElementById("preview").style.display="block";
			$('#preview').attr('src', e.target.result);
			var imageCnt=parseInt($('#imageCnt').val())+1;
			document.getElementById("imageCnt").value=imageCnt;
			}
		    reader.readAsDataURL(input.files[0]);
		}
	}
	
	
	/**정은 코드*/
	$(document).ready(function(){		
		getBoardDetail();		
	});
	
	/** 게시판 - 목록 페이지 이동 */
    function goBoardList(){                
        location.href = "${contextPath}/exchange/boardList";
    }
    
    /** 게시판 - 상세 조회  */
    function getBoardDetail(boardSeq){
    	//양식의 값을 가져오거나 값을 설정하는 메소드
        var boardSeq = $("#board_seq").val();
 
        if(boardSeq != ""){
            
            $.ajax({    
                
                url        : "${contextPath}/exchange/getBoardDetail?boardSeq=" + boardSeq,
              //데이터를 보내기위해 form요소 집합을 문자열로 인코딩
                data    : $("#boardForm").serialize(),
                dataType: "JSON",
                cache   : false,
                async   : true,
                type    : "POST",    
                success : function(obj) {
                    getBoardDetailCallback(obj);                
                },           
                error     : function(xhr, status, error) {}
                
             });
            
        } else {
            alert("오류가 발생했습니다.\n관리자에게 문의하세요.");
        }    
    }
    
    /** 게시판 - 상세 조회  콜백 함수 */
    function getBoardDetailCallback(obj){
                
        if(obj != null){                                
                            
            var boardSeq        = obj.board_seq; 
            var boardReRef         = obj.board_re_ref; 
            var boardReLev         = obj.board_re_lev; 
            var boardReSeq         = obj.board_re_seq; 
            var boardWriter     = obj.board_writer; 
            var boardSubject     = obj.board_subject; 
            var boardContent     = obj.board_content; 
            var boardHits         = obj.board_hits;
            var delYn             = obj.del_yn; 
            var insUserId         = obj.ins_user_id;
            var insDate         = obj.ins_date; 
            var updUserId         = obj.upd_user_id;
            var updDate         = obj.upd_date;
            var files            = obj.files;        
            var filesLen        = files.length;
			var item =obj.item;
			var locat=obj.locat;
            console.log(item);
            
            $("#board_subject").val(boardSubject);            
            $("#board_content").val(boardContent);
            $("#location").val(locat);
            $("#locat").val(locat);
            $("#board_writer").text(boardWriter);
            $("#item").val(item);
            
            var fileStr = "";
            
            if(filesLen >0){
               
                for(var a=0; a<filesLen; a++){
                	fileStr+= "<p>"
                    var boardSeq    = files[a].board_seq;
                    var fileNo         = files[a].file_no;
                    var fileNameKey = files[a].file_name_key;
                    var fileName     = files[a].file_name;
                    var filePath     = files[a].file_path;
                    var fileSize     = files[a].file_size;
                    var remark         = files[a].remark;
                    var delYn         = files[a].del_yn;
                    var insUserId     = files[a].ins_user_id;
                    var insDate     = files[a].ins_date;
                    var updUserId     = files[a].upd_user_id;
                    var updDate     = files[a].upd_date;
                    
                    fileStr +="	<label for='image'>이미지</label><br>"
                	fileStr += "<img src ='${contextPath}/board/fileDownload?fileNameKey="+encodeURI(fileNameKey)+"&fileName="+encodeURI(fileName)+"&filePath="+encodeURI(filePath)+"' width=200 height=200 id='preview'/><br>";
                    fileStr += "<b>" + fileName + "</b>";
                    fileStr += "<button type='button' class='btn black ml15' style='padding:3px 5px 6px 5px;' onclick='javascript:setDeleteFile("+ boardSeq +", "+ fileNo +")'>X</button>";
                    fileStr += "</p>"
                        
                    }            
                                
            } else {
                
                fileStr += "<img id='preview' src='#' width=150 height=150 style='display:none;'/>";
                fileStr += "<p><input type='file' id='files[0]' name='files[0]' value=''></p>";
            }
            
            $("#file_td").html(fileStr);
            
        } else {            
            alert("등록된 글이 존재하지 않습니다.");
            return;
        }        
    }
    
    /** 게시판 - 수정  */
    function updateBoard(){
 
        var boardSubject = $("#board_subject").val();
        var boardContent = $("#board_content").val();
	/* 	var item=$("#items").val();
		
		 console.log("updateboard: "+item); */

	     if (boardSubject == ""){            
            alert("제목을 입력해주세요.");
            $("#board_subject").focus();
            console.log("제목")
            return;
        }
	        
	    if(item=="") {
			alert("품목을 선택해주세요.");
			return;
		}
		
        if (boardContent == ""){            
            alert("내용을 입력해주세요.");
            $("#board_content").focus();
            return;
        }

		if(document.getElementById("imageCnt").value=="0") {
			alert("사진을 첨부해주세요.");
			return;
		}
        
        var yn = confirm("게시글을 수정하시겠습니까?");        
        if(yn){
                
            var filesChk = $("input[name='files[0]']").val();
            if(filesChk == ""){
                $("input[name='files[0]']").remove();

            }
            
            $("#boardForm").ajaxForm({
            
                url        : "${contextPath}/exchange/updateBoard",
                enctype    : "multipart/form-data",
                cache   : false,
                async   : true,
                type    : "POST",                         
                success : function(obj) {
                    updateBoardCallback(obj);                
                },           
                error     : function(xhr, status, error) {}
                
            }).submit(); 
        }
    }
    
    /** 게시판 - 수정 콜백 함수 */
    function updateBoardCallback(obj){
    
        if(obj != null){        
            
            var result = obj.result;
            
            if(result == "SUCCESS"){                
                alert("게시글 수정을 성공하였습니다.");                
                goBoardList();                 
            } else {                
                alert("게시글 수정을 실패하였습니다.");    
                return;
            }
        }
    }
    
    /** 게시판 - 삭제할 첨부파일 정보 */
    function setDeleteFile(boardSeq, fileSeq){

        
        var fileStr="";    	
        var deleteFile = boardSeq + "!" + fileSeq; 
	
        $("#delete_file").val(deleteFile);  
        fileStr +="	<label for='image'>이미지</label><br>"
        fileStr += "<img id='preview' src='#' width=150 height=150 style='display:none;'/>";
		fileStr += "<p><input type='file'  class='form-control' id='files[0]' name='files[0]' value='' onchange='readURL(this);'></p>";	 
        
        $("#file_td").html(fileStr);
        document.getElementById("imageCnt").value="0";
        

 
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
					<h1 class="mb-0 bread">교환글 수정</h1>
				</div>
			</div>
		</div>
	</div>
	
	
   	<section class="ftco-section"> 
		<div class="container">
			<div class="comment-form-wrap pt-5">
            <form id="boardForm" name="boardForm" action="/exchange/updateBoard"  class="p-5 bg-light" enctype="multipart/form-d
            ata" method="post" onsubmit="return false;">    
             <input type="hidden" id="imageCnt" value=1 >
           
                    <div id="tbody">
                    
                    <div class="form-group">
						<label for="board_writer">작성자</label>
						<input type="text" class="form-control" id="board_writer" name="board_writer1" value="${member.n_name}" disabled>
						<input id="board_writer" type="hidden" name="board_writer" value="${member.n_name}">
					</div>
					<div class="form-group">
						<label for="locat">장소</label>
						<br>
						<div style="float: left; width: 78%; margin-right:10px;">
							<input type="text" class="form-control" id="location" value="${member.address }" disabled/>
						</div>
						<input type="hidden" id="locat" name="locat">
						<input type="button" value="장소 변경" class="btn btn-black py-3 px-5" onclick="_popUp1()">				
					</div>
					
					<div class="form-group">
						<label for="items">품목</label>
						<br>
						<div style="float: left; width: 78%; margin-right:10px;">
							<input id="item" name="item" value="" class="form-control" readonly/>
						</div>
						<input type="button" value="품목 찾기" class="btn btn-black py-3 px-5"  onclick="_popUp2()">		
					</div>
					<div class="form-group">
						<label for="board_subject">제목</label>
						<input id="board_subject" name="board_subject" value="" class="form-control"/>
					</div>
										
					<div class="form-group">
						<label for="board_content">내용</label>
						<textarea id="board_content" name="board_content" cols="50" rows="5" class="form-control"></textarea>					
					</div>
					
					
					<div class="form-group" id="file_td">
						<input type="file"  id="files[0]" name="files[0]" value="">
					</div>
					
                    </div>
                 
               	 	<input type="hidden" id="board_seq"        name="board_seq"    value="${boardSeq}"/> <!-- 게시글 번호 -->
               		<input type="hidden" id="search_type"    name="search_type"    value="U"/> <!-- 조회 타입 - 상세(S)/수정(U) -->
                	<input type="hidden" id="delete_file"    name="delete_file"    value=""/> <!-- 삭제할 첨부파일 -->
             	
          			<div class="col text-center">			
					<div class="form-group">	
          		      <button type="button" class="btn py-3 px-4 btn-primary" onclick="javascript:goBoardList();">목록으로</button>
                	<button type="button" class="btn py-3 px-4 btn-primary" onclick="javascript:updateBoard();">수정하기</button>
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

<%-- 	<script src="${contextPath }/resources/eunji/js/jquery.min.js"></script> --%>
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
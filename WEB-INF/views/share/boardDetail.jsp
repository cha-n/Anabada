<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<!DOCTYPE html>
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
<style>

	#table1 {
		width:100%;
		border-collapse: collapse;
	}
	
	.line {
		border-bottom:#b5b5b5;
		border-bottom-width:1px;
		border-bottom-style:solid;
	}
	
	.div1 {
		margin:2% auto 2% auto;
		width:70%;
	}
	
	#image {
		border-radius:100%;
	}
	
</style>


<%
	String boardSeq = request.getParameter("boardSeq");
%>
<c:set var="boardSeq" value="<%=boardSeq%>" />

<!-- 게시글 번호 -->

 </head> 
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">

/** 예슬이 짠 코드    */
	$(function(){
		$('#content').bind('focus',function(event){
			if($('#log').val()=='') { //로그인이 안되어 있다면
				$('#content').blur();
				var post_NO=$('#post_NO').val();
				alert("로그인이 필요합니다.");
				location.href='${contextPath}/member/loginForm'+'?action=/share/boardDetail?boardSeq='+post_NO;
			}
		});
	});
	
	function _openReply(comment_NO) { //답글창 열기
		if($('#log').val()!='') { //로그인이 되어 있다면
			$('#tbody'+comment_NO).empty(); //답글을 누를 때마다 답글창이 계속 생기는 것을 방지
			var row=document.all("tbody"+comment_NO).insertRow();
		  	var cell=row.insertCell();
		  	var contents='';
	        contents+='<tr><td>';
	           contents+='<textarea id="content'+comment_NO+'" style="width:98%; height:100px;"></textarea><br>';
	           contents+='<input type="checkbox" name="secret'+comment_NO+'" >비밀글&nbsp&nbsp';
	           contents+='<a href="#" class="tag-cloud-link" onclick="_cancelReply('+comment_NO+')">취소&nbsp&nbsp</a>';
	           contents+='<a href="#" class="tag-cloud-link" onclick="_write('+comment_NO+')">작성</a>';
	        contents+='</td></tr>';
		  	cell.innerHTML=contents;
		  	var tbody1=document.getElementById("tbody"+comment_NO);
		  	tbody1.style.borderBottom="1px solid #b5b5b5";
		}
		else { //로그인이 안되어 있다면
			var post_NO=$('#post_NO').val();
			alert("로그인이 필요합니다.");
			location.href='${contextPath}/member/loginForm'+'?action=/share/boardDetail?boardSeq='+post_NO;
		}
	
	}
	
	function _cancelReply(comment_NO) { //답글창 닫기
		$('#tbody'+comment_NO).empty();
	}
	
	function _write(num) { //댓글,대댓글 작성
		var post_NO=$('#post_NO').val();
		var n_name=$('#n_name').val();
		if(num==0) { //댓글
			var check_Secret=document.getElementsByName("secret");
			var secret;
			if(check_Secret[0].checked==true)
				secret='y';
			else
				secret='n';
			var content=$('#content').val();
			$.ajax({
				type:"post",
				async:false,
				url:"${contextPath}/share/addComment",
				data:{
					seq:1,
					post_NO:post_NO,
					n_name:n_name,
					content:content,
					secret:secret,
					re_name:n_name
				},
				success:function (data){
					if(data=='ok'){
						alert("댓글을 작성했습니다.");
						location.href='${contextPath}/share/boardDetail?boardSeq='+post_NO;
					}
				},
				error:function(data){
					alert("오류가 발생했습니다.다시 시도해주세요.");
				},
				complete:function(data){
				}
			});
		}
		else { //대댓글
			var check_Secret=document.getElementsByName("secret"+num);
			var secret;
			if(check_Secret[0].checked==true)
				secret='y';
			else
				secret='n';
			var content=$('#content'+num).val();
			$.ajax({
				type:"post",
				async:false,
				url:"${contextPath}/share/addComment",
				data:{
					parent_NO:num,
					post_NO:post_NO,
					n_name:n_name,
					content:content,
					secret:secret
				},
				success:function (data){
					if(data=='ok'){
						alert("댓글을 작성했습니다.");
						location.href='${contextPath}/share/boardDetail?boardSeq='+post_NO;
					}
				},
				error:function(data){
					alert("오류가 발생했습니다.다시 시도해주세요.");
				},
				complete:function(data){
				}
			});
		}
	}
	function _openUpdate(comment_NO,seq) { //댓글 수정창 열기
		var comment=$('#m'+comment_NO).val();
		var contents='';
	     contents+='<textarea id="new_content'+comment_NO+'" style="width:98%; height:100px;">'+comment+'</textarea><br>';
	      contents+='<input type="checkbox" name="secret'+comment_NO+'" />비밀글 &nbsp&nbsp';     
	      contents+='<a href="#" class="tag-cloud-link" onclick="_cancelUpdate('+comment_NO+','+seq+')">취소&nbsp&nbsp</a>';
	 	  contents+='<a href="#" class="tag-cloud-link" onclick="_update('+comment_NO+')">등록</a>'; 
		contents+='<input type="hidden" value='+comment+' id="m'+comment_NO+'">';
		$('#modify'+comment_NO).html(contents);	
	}
	
	function _cancelUpdate(comment_NO,seq) { //댓글 수정창 닫기
		var comment=$('#m'+comment_NO).val();
		var contents='';
		if(seq==1) {
			contents+=comment;
			contents+='<input type="hidden" value='+comment+' id="m'+comment_NO+'">';
		}
		else {
			contents+='<span style="padding-left:3%;">  </span>'+comment;
			contents+='<input type="hidden" value='+comment+' id="m'+comment_NO+'">';
		}
		$('#modify'+comment_NO).html(contents);
		
	}
	
	function _update(comment_NO) { //댓글 수정
		var check_Secret=document.getElementsByName("secret"+comment_NO);
		var secret;
		if(check_Secret[0].checked==true)
			secret='y';
		else
			secret='n';
		
		var content=$('#new_content'+comment_NO).val();
		var post_NO=$('#post_NO').val();
		$.ajax({
			type:"post",
			async:false,
			url:"${contextPath}/share/updateComment",
			data:{
				comment_NO:comment_NO,
				content:content,
				secret:secret
			},
			success:function (data){
				if(data=='ok'){
					alert("댓글을 수정했습니다.");
					location.href='${contextPath}/share/boardDetail?boardSeq='+post_NO;
				}
			},
			error:function(data){
				alert("오류가 발생했습니다.다시 시도해주세요.");
			},
			complete:function(data){
			}
		});
	}
	
	function _delete(comment_NO) { //댓글 삭제
		var post_NO=$('#post_NO').val();
		if(confirm("댓글을 삭제하시겠습니까?")==true) {
			$.ajax({
				type:"post",
				async:false,
				url:"${contextPath}/share/deleteComment",
				data: { comment_NO : comment_NO },  
				success:function (data){
					  if(data=='ok'){
						  alert("댓글을 삭제했습니다.");
						  location.href='${contextPath}/share/boardDetail?boardSeq='+post_NO;
					  }
				},
				error:function(data){
					  alert("오류가 발생했습니다. 다시 시도해주세요.");
				},
				complete:function(data,textStatus){
				}
			  });
		  }
	}
	
	function _bookmark() {
		var image=document.getElementById("book");
		var boardSeq = $("#board_seq").val(); //글번호
		if(image.alt=="uncheck") { //북마크 해지된 상태일 때
			if("${log}"=='') { //로그인이 안되어 있는 상태일 때
				alert("로그인이 필요합니다.");
				location.href = "${contextPath}/member/loginForm?action=/share/boardDetail?boardSeq=" + boardSeq;
			}
			else { //로그인이 된 상태일 때 북마크 설정
				var n_name="${member.n_name}";
				  $.ajax({
					  type:"post",
					  async:false,
					  url:"${contextPath}/share/addShareBookmark",
					  data: {post_NO : boardSeq,
						     n_name : n_name,
						     category : "나눔"
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
				  url:"${contextPath}/share/deleteShareBookmark",
				  data: {post_NO : boardSeq,
					     n_name : n_name,
					     category : "나눔"
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
	
	function changeSell_YN(sell_YN) { //판매여부  전환
		if(sell_YN==0)
			sell_YN="N";
		else
			sell_YN="Y";
		
		var boardSeq = $("#board_seq").val(); //글번호
		  $.ajax({
			  type:"post",
			  async:false,
			  url:"${contextPath}/share/updateSell_YN",
			  data: {board_seq : boardSeq,
				  	 sell_YN : sell_YN
			  },
			  success:function (data,textStatus){
				  if(data=='ok'){
					  if(sell_YN=='N') {
						  alert("나눔완료로 전환했습니다.");
						  location.href='${contextPath}/share/boardDetail?boardSeq='+boardSeq;
					  }
					  else {
						  alert("나눔중으로 전환했습니다.");
						  location.href='${contextPath}/share/boardDetail?boardSeq='+boardSeq;
					  }
				  }
				  else {
					  alert("오류가 발생했습니다.");
				  }
			  },
		      error:function(data,textStatus){
			      alert("오류가 발생했습니다.");
			  },
			  complete:function(data,textStatus){
			  }
			
		  });
		
	}
	function goBookList() {
		location.href = "${contextPath}/board/myBookmark";
	}
	

	function goMyBoardList() {
		var writer= $("#board_writer").val();
		if("${log}"=='') {
			alert("로그인이 필요합니다.");
			location.href = "${contextPath}/member/loginForm?action=/board/myBoardList?user="+writer;			
		}
		else {
			location.href = "${contextPath}/board/myBoardList?user="+writer;
		}
	}
	
	$(document).ready(function() {
		getBoardDetail();
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
	
	/** 게시판 - 목록 페이지 이동 */
	function goBoardList() {
		location.href = "${contextPath}/share/boardList";
	}

	/** 게시판 - 수정 페이지 이동 */
	function goBoardUpdate() {

		var boardSeq = $("#board_seq").val();

		location.href = "${contextPath}/share/boardUpdate?boardSeq=" + boardSeq;
	}

	/** 게시판 - 답글 페이지 이동 */
	function goBoardReply() {
		var boardSeq = $("#board_seq").val();
		if("${log}"==true) {
			location.href = "${contextPath}/share/boardReply?boardSeq=" + boardSeq;
		}
		else {
			alert("로그인이 필요합니다.");
			location.href = "${contextPath}/member/loginForm?action=/share/boardReply?boardSeq=" + boardSeq;
		}
	}

	/** 게시판 - 첨부파일 다운로드 */
	function fileDownload(fileNameKey, fileName, filePath) {

		location.href = "/board/fileDownload?fileNameKey=" + fileNameKey
				+ "&fileName=" + fileName + "&filePath=" + filePath;
	}

	/** 이미지 로드해오는 url  */
	function readURL(input) {
	     if (input.files && input.files[0]) {
	         var reader = new FileReader();
	         reader.onload = function (e) {
	             $('#preview').attr('src', e.target.result).width(500);
	         }
	         reader.readAsDataURL(input.files[0]);
	     }
	 }  
	
	/** 게시판 - 상세 조회  */
	function getBoardDetail(boardSeq) {

 		var boardSeq = $("#board_seq").val();
 	
		if (boardSeq != "") {
					
			var paramData=$("#boardForm").serialize();
			$.ajax({

				url : "${contextPath }/share/getBoardDetail?boardSeq=" + boardSeq,
				//seriallize = 데이터를 보내기위해 폼요소 집합을 문자열로 인코딩
				data : paramData,
				dataType : "JSON",
				cache : false,
				async : false, //동기식 
				//post가 성공하면 boarddetailcallback 함수 작동
				type : "POST",
				success : function(obj) {
					getBoardDetailCallback(obj);
				},
				error : function(xhr, status, error) {
				}

			});

		} else {
			alert("오류가 발생했습니다.\n관리자에게 문의하세요.");
		}
		
	} 

	/** 게시판 - 상세 조회  콜백 함수 */
	function getBoardDetailCallback(obj) {

		var str = "";
		var boardWriter;

		if (obj != null) {
			var boardSeq = obj.board_seq;
			var boardReRef = obj.board_re_ref;
			var boardReLev = obj.board_re_lev;
			var boardReSeq = obj.board_re_seq;
			boardWriter = obj.board_writer;
			var boardSubject = obj.board_subject;
			var boardContent = obj.board_content;
			var boardHits = obj.board_hits;
			var delYn = obj.del_yn;
			var insUserId = obj.ins_user_id;
			var insDate = obj.ins_date;
			var updUserId = obj.upd_user_id;
			var updDate = obj.upd_date;
			var files = obj.files;
			var filesLen = files.length;
			var item =obj.item;
			var sell_yn =obj.sell_YN;
			if(sell_yn=='Y')
				sell_yn="나눔중";
			else
				sell_yn="나눔완료";
			var locat=obj.locat;
			str += "<div class='col-lg-6 mb-5 ftco-animate fadeInUp ftco-animated' >";
			if (filesLen > 0) {

					for (var a = 0; a < filesLen; a++) {

						var boardSeq = files[a].board_seq;
						var fileNo = files[a].file_no;
						var fileNameKey = files[a].file_name_key;
						var fileName = files[a].file_name;
						var filePath = files[a].file_path;
						var fileSize = files[a].file_size;
						var remark = files[a].remark;
						var delYn = files[a].del_yn;
						var insUserId = files[a].ins_user_id;
						//var insDate = files[a].ins_date;
						var updUserId = files[a].upd_user_id;
						var updDate = files[a].upd_date;

						console.log("fileName : " + fileName);

	 						//이미지 넣을 부분   
	 							
							str += "<a href ='#' class='image-popup' >";	    				    	    
							str += "<img src ='${contextPath}/board/fileDownload?fileNameKey="+encodeURI(fileNameKey)+"&fileName="+encodeURI(fileName)+"&filePath="+encodeURI(filePath)+"'  class='img-fluid' alt='Colorlib Template'></a>";
	 						}
			}	
			
			str += "</div>";
			str+= "<div class='col-lg-6 product-details pl-md-5 ftco-animate fadeInUp ftco-animated'> ";
			str += "<h3>" + boardSubject +"</h3>";
			str+= "<p class='price'><span style='font-size:23px;'>"+item+"</span></p>";
			str += "<input type='hidden' value="+item+" id='item' ></td>";
			if(!obj.memberVO) { //프로필이 없다면
				str +="<img width='25' height='25' id='image' name='image' src='${contextPath}/resources/image/no_profile.png'  style='margin-right: 10px;'>";
			}
			else { //프로필이 있다면
				str += "<img width='25' height='25' id='image' name='image' src='${contextPath}/member/download?profile="+obj.memberVO.profile+"' style='margin-right: 10px;'>";
			}
			str += "<a href='#' onclick='goMyBoardList()' >"+boardWriter+"</a>";  		
			str += "<input type='hidden' value="+boardWriter+" id='boardWriter' >";			
			str += "<ui style='padding-left: 5px;padding-right: 5px;'>ㆍ</ui><ui style='padding-right: 10px;'>조회수</ui><ui>" + boardHits + "</ui><ui style='padding-left: 5px;padding-right: 5px;'>ㆍ</ui><ui style='padding-right: 10px;'>작성일시</ui><ui>" + insDate + "</ui>";
			//판매여부 
			str +="<p><ui style='padding-left: 5px;padding-right: 5px;'></ui><ui style='padding-right: 10px;'>" + sell_yn + "</ui>";
			if("${member.n_name}"==boardWriter) {
 				if(sell_yn=="나눔중") {
 					str += "<button type='button' onclick='changeSell_YN(0)' style='margin-left:3%;'>나눔완료로 전환</button>";
 				}
 				else {
 					str += "<button type='button' onclick='changeSell_YN(1)' style='margin-left:3%;'>나눔중으로 전환</button>";
 				}
 				
 			} 
 			str+= "</p>";
			str += "<p style='padding-top: 50px;'>" + boardContent + "</p>";
			str+= "<div class='row mt-4'>";
			str+= "<div class='col-md-12' style='margin-top: 20px;'>";
			str+= "<p style='color: #000;'>" + locat + "</p>";					
			str+= "</div></div>";
			//연락하기 
          	str+= "<p style='margin-top: 20px;'><a href='#' class='btn btn-black py-3 px-4'  onClick='chatBox(\""+boardWriter+"\");'>연락하기</a></p>";
			str+= "</div></div>";

		} else {

			alert("등록된 글이 존재하지 않습니다.");
			return;
		}

		$("#tbody").html(str);
	}

	
	/** 게시판 - 삭제  */
	function deleteBoard() {

		var boardSeq = $("#board_seq").val();

		var yn = confirm("게시글을 삭제하시겠습니까?");
		if (yn) {

			$.ajax({

				url : "${contextPath}/share/deleteBoard",
				data : $("#boardForm").serialize(),
				dataType : "JSON",
				cache : false,
				async : true,
				type : "POST",
				success : function(obj) {
					deleteBoardCallback(obj);
				},
				error : function(xhr, status, error) {
				}

			});
		}
	}

	/** 게시판 - 삭제 콜백 함수 */
	function deleteBoardCallback(obj) {

		if (obj != null) {

			var result = obj.result;

			if (result == "SUCCESS") {
				alert("게시글 삭제를 성공하였습니다.");
				goBoardList();
			} else {
				alert("게시글 삭제를 실패하였습니다.");
				return;
			}
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
            <h1 class="mb-0 bread">상품 설명</h1>
          </div>
        </div>
      </div>
    </div>
  
  
   	<section class="ftco-section">   
       <div class="container">
    	
    	<form id="boardForm" name="boardForm">	
    		<!-- 게시글 번호 -->
    		<input type="hidden" id="board_seq" name="board_seq" value="${boardSeq}" />
					<span style="float:right;">
					  <c:if test="${result eq 'false' }">
						<img src="${contextPath }/resources/image/bookmark.png" id="book" width="43" height="43" alt="uncheck" style="cursor:pointer;" onclick="_bookmark()">
					  </c:if>
					  <c:if test="${result eq 'true' }">
						<img src="${contextPath }/resources/image/bookmark2.png" id="book" width="43" height="43" alt="check" style="cursor:pointer;" onclick="_bookmark()">
					  </c:if>					  
					</span>	
								
    				<div id="tbody" class="row" >
      		 		</div>
      							
		</form>
      
      </div>   <!-- <div class="container"> -->
    </section>  <!-- 상품detail  -->
  
       
       
	<section class="ftco-section img" style="background-image: url('${contextPath}/resources/eunji/images/nutrient.jpg'); height: 400px;">
		<div class="col-md-12 heading-section text-center ftco-animate">
		  <h2 class="mb-4">Nutrients</h2>
		  <div style="color:#000;margin-left:auto;margin-right:auto;width:50%;">
			  <table style="width:100%;">
				  <tr>
					  <td style="width:10%;">식품</td>
					  <td style="width:10%;">칼로리</td>
					  <td style="width:10%;">탄수화물</td>
					  <td style="width:10%;">단백질</td>
					  <td style="width:10%;">지방</td>
					  <td style="width:10%;">나트륨</td>
					  <td style="width:10%;">칼륨</td>
					  <td style="width:10%;">총 당류</td>
				  </tr>
		  
				<c:forEach var="item" items="${itemArr}">
				  <c:forEach var="vegat" items="${vegats}" >                                                                         
					 <c:if test="${item eq vegat.name }">      
					   <tr>
						   <td>${vegat.name}</td>
						   <td>${vegat.cal}</td>
						   <td>${vegat.carbon}</td>
						   <td>${vegat.protein}</td>
						   <td>${vegat.fat}</td>
						   <td>${vegat.na}</td>
						   <td>${vegat.k}</td>
						   <td>${vegat.totalSugar}</td>
					   </tr>
					   </c:if>    
					</c:forEach>
				</c:forEach>
			  </table>
		  </div>
		</div>
	 </section>
       
  	<section class="ftco-section ftco-degree-bg">
      <div class="container">
         <form id="boardForm" name="boardForm">

            <div class="inner">
               <div class="quantity" id="buttons">
                  <div class="col text-right">
                     <c:if test="${member.n_name eq writer }">
                        <button type="button" class="btn btn-primary py-3 px-4"
                           onclick="javascript:goBoardUpdate();">수정하기</button>
                        <button type="button" class="btn btn-primary py-3 px-4"
                           onclick="javascript:deleteBoard();">삭제하기</button>
                     </c:if>
                     <!-- <button type="button" class="btn btn-primary py-3 px-4" onclick="javascript:goBoardReply();" >답글쓰기</button> -->
                  </div>
               </div>
            </div>
            <br>

            <!-- 댓글 목록 -->
            <div class="p-5 bg-light">
               <h3 class="mb-5">Comments</h3>
               <input type="hidden" value="${log }" id="log">                           
               <table  id="table1" cellpadding="5" >               
                  <c:choose>
                     <c:when test="${empty comments }">
                        <tr>
                               <td><b>댓글이 없습니다.</b></td>
                           </tr>                     
                     </c:when>
                     <c:otherwise>                     
                        <c:forEach var="comment" items="${comments }">                                                      
                              <!-- 부모글일 때 -->
                              <c:if test="${comment.seq == 1 }">                                                                                      
                                 <tr>
                                    <td>
                                       <c:if test="${comment.memberVO.profile == null }">
                                          <img src="${contextPath}/resources/image/no_profile.png" id="image" name="image" width="50" height="50" />
                                       </c:if>
                                       <c:if test="${comment.memberVO.profile != null }">
                                          <img width="50" height="50" id="image" name="image" src="${contextPath}/member/download?profile=${comment.memberVO.profile}" />
                                       </c:if>
                                                                          
                                       <b>${comment.n_name }</b>                                        
                                       <c:if test="${member.n_name==comment.n_name}">                     
                                          <a href="javascript:void(0);" class="tag-cloud-link" onclick="_openUpdate(${comment.comment_NO },${comment.seq })">수정</a>
                                          <a href="javascript:void(0);" class="tag-cloud-link" onclick="_delete(${comment.comment_NO })">삭제</a>
                                       </c:if>                                       
                                  </td>
                                 </tr>
                                 
                                 <!-- 비밀 댓글이 아닐 때 -->
                                 <c:if test="${comment.secret.toString() == 'n'}">                                          
                                       <tr>
                                           <td id="modify${comment.comment_NO }"> ${comment.content }
                                            <input type="hidden" value="${comment.content }" id="m${comment.comment_NO }">
                                            </td>
                                      </tr>
                                 </c:if>
                                 <!-- 비밀 댓글일 때 -->
                                 <c:if test="${comment.secret.toString() == 'y'}">
                                    <!-- 글쓴이가 로그인한 사람일 때, 또는 댓글을 쓴사람이 로그인한 사람일 때 -->
                                    <c:if test="${writer == member.n_name || comment.n_name == member.n_name}">                                    
                                       <tr>
                                                <td id="modify${comment.comment_NO }"><img src="${contextPath}/resources/image/lock1.png" width="14" height="14"/>${comment.content }
                                                 <input type="hidden" value="${comment.content }" id="m${comment.comment_NO }">
                                                </td>
                                             </tr>
                                    </c:if>
                                    <!-- 글쓴이가 로그인한 사람이 아니고, 댓글을 쓴사람이 로그인한 사람이 아닐 떄 -->
                                          <c:if test="${writer != member.n_name && comment.n_name != member.n_name}">
                                              <tr>
        						                  <td id="modify${comment.comment_NO }"><img src="${contextPath}/resources/image/lock1.png" width="14" height="14"/>비밀댓글입니다.
              						              <input type="hidden" value="${comment.content }" id="m${comment.comment_NO }">
                                                </td>
                                             </tr>
                                       </c:if>
                                     </c:if>
                                     <tr>
                                           <td class="line">${comment.writedate }
                                          <a href="javascript:void(0);" class="reply" style="cursor:pointer;" onclick="_openReply(${comment.comment_NO });" >Reply </a>                                        
                                       	  </td>
                                    </tr>
                                        
                                       <tbody id="tbody${comment.comment_NO }"></tbody>  
                                    <%--  <p><a href="javascript:_openReply(${comment.comment_NO });" class="reply" style="cursor:pointer;" onclick="return false;">Reply </a></p> --%>                                                                                                                
                                     
                                  <!--  <td class="comment-body"> -->
                                  </c:if>
                              <!--end 부모글일 때 -->
                        
                              </tbody>  <!-- <li class="comment"> -->
                              
                              <!-- 부모글이 아닐 때 -->
                              <c:if test="${comment.seq != 1 }">
                                 <tr>
                                    <td>
                                    <span style="padding-left: 3%;">ㄴ</span> 
                                    <c:if test="${comment.memberVO.profile == null }">
                                          <img src="${contextPath}/resources/image/no_profile.png" id="image" name="image" width="50" height="50" />
                                    </c:if> 
                                    <c:if test="${comment.memberVO.profile != null }">
                                          <img width="50" height="50" id="image" name="image" src="${contextPath}/member/download?profile=${comment.memberVO.profile}" />
                                    </c:if>                                                                                     
                                    <b>${comment.n_name }</b>
                                    <c:if test="${member.n_name==comment.n_name}">
                                       <a href="javascript:void(0);" class="tag-cloud-link" onclick="_openUpdate(${comment.comment_NO },${comment.seq })">수정</a>
                                       <a href="javascript:void(0);" class="tag-cloud-link" onclick="_delete(${comment.comment_NO })">삭제</a>
                                    </c:if>
                                    
                                    <!-- 비밀 댓글이 아닐 때 -->
                                    <c:if test="${comment.secret.toString() == 'n'}">   
                                       <tr>                           
                                          <td id="modify${comment.comment_NO }"><span style="padding-left: 5%;"> </span>${comment.content } 
                                          <input type="hidden" value="${comment.content }" id="m${comment.comment_NO }">
                                          </td>
                                       </tr>
                                    </c:if>

                                    <!-- 비밀 댓글일 때 -->
                                    <c:if test="${comment.secret.toString() == 'y'}">
                                       <!-- 글쓴이가 로그인한 사람일 때, 또는 댓글을 쓴사람이 로그인한 사람일 때, 또는 re_name이 로그인한 사람일 때-->
                                       <c:if test="${writer == member.n_name || comment.n_name == member.n_name || comment.re_name == member.n_name}">   
                                          <tr>
                                          <td id="modify${comment.comment_NO }"><span style="padding-left: 5%;"> </span><img src="${contextPath}/resources/image/lock1.png" width="14" height="14" />${comment.content } 
                                          <input type="hidden" value="${comment.content }" id="m${comment.comment_NO }"></td>   
                                          </tr>                              
                                       </c:if>
                                    <!-- 글쓴이가 로그인한 사람이 아니고, 댓글을 쓴사람이 로그인한 사람이 아니고, re_name이 로그인한 사람이 아닐 때 -->
                                    <c:if test="${writer != member.n_name && comment.n_name != member.n_name && comment.re_name != member.n_name}">                        
                                       <tr>
                                       <td id="modify${comment.comment_NO }"><span style="padding-left: 5%;"> </span><img src="${contextPath}/resources/image/lock1.png" width="14" height="14" />비밀댓글입니다. 
                                       <input type="hidden" value="${comment.content }" id="m${comment.comment_NO }"></td>                                       
                                       </tr>
                                    </c:if>
                                 </c:if>   
                                  <tr>
                                     <td class="line"><span style="padding-left: 5%;"></span>${comment.writedate } 
                                     <a href="javascript:void(0)" class="reply" style="cursor:pointer;" onclick="_openReply(${comment.comment_NO });" >Reply </a>
                                     </td>
                                  </tr>
                                    <tbody id="tbody${comment.comment_NO }"></tbody>                            
                              </c:if>                           
                        </c:forEach>                        
                     </c:otherwise>
                  </c:choose>
               </table>
            
               
               <!-- 댓글 작성 -->

               <div class="comment-form-wrap pt-5">
                  <h3 class="mb-5">Leave a comment</h3>
                  <div class="form-group">
                     <label for="board_content">message</label>
                     <textarea id="content" name="content" cols="10" rows="5" class="form-control"></textarea>
                  </div>
                  <input type="checkbox" name="secret">비밀글 <input type="button" class="btn py-3 px-4 btn-primary" value="등록" onclick="_write(0)" style="float: right;">
               </div>
               <input type="hidden" value=${boardSeq } id="post_NO"> <input type="hidden" value="${member.n_name }" id="n_name">
               <input type="hidden" id="board_writer" name="board_writer" value="${writer}" />
            
            </div>
            <!-- <div class="pt-5 mt-5"> -->
         
         </form>
      </div>
 	</section>

 	<div class="col text-center">
		<div class="form-group">
        	<c:if test="${action != 'book' and active !='mylist'}">
            	<button type="button" class="btn btn-primary py-3 px-4"
                onclick="javascript:goBoardList();">목록</button>
            </c:if>
            <c:if test="${action eq 'book' }">
            	<button type="button" class="btn btn-primary py-3 px-4"
                onclick="javascript:goBookList();">북마크 목록</button>
            </c:if>
            <c:if test="${active eq 'mylist' }">
            	<button type="button" class="btn btn-primary py-3 px-4"
                onclick="javascript:goMyBoardList();">글 조회 목록</button>
            </c:if>
        </div>
    </div>
	
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
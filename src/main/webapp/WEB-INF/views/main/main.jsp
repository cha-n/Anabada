<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false"  %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
 <%@page import="java.util.ArrayList"%>
 <%@page import="java.util.Map.Entry"%>
 <%@page import="java.util.Map.Entry"%>
 <%@page import="java.util.Iterator"%>
 <%@page import="java.util.HashMap"%>
 <%@page import="java.util.Map"%>
 <%@page import="java.io.InputStream"%>
 <%@page import="java.net.URLEncoder"%>
 <%@page import="org.w3c.dom.NodeList"%>
 <%@page import="org.w3c.dom.Node"%>
 <%@page import="org.w3c.dom.Element"%>
 <%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
 <%@page import="org.w3c.dom.Document"%>
 <%@page import="java.net.URL"%>
 <%@page import="java.util.Calendar"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
  <head>
    <title>Anabada</title>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <link href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700,800&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Lora:400,400i,700,700i&display=swap" rel="stylesheet">
   <link href="https://fonts.googleapis.com/css?family=Amatic+SC:400,700&display=swap" rel="stylesheet">

    <link href="<c:url value="resources/eunji/css/open-iconic-bootstrap.min.css" />" rel="stylesheet">
    <link href="<c:url value="resources/eunji/css/animate.css" />" rel="stylesheet">
    
    <link rel="stylesheet" href="${contextPath }/resources/eunji/css/owl.carousel.min.css">
    <link rel="stylesheet" href="${contextPath }/resources/eunji/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="${contextPath }/resources/eunji/css/magnific-popup.css">

    <link rel="stylesheet" href="${contextPath }/resources/eunji/css/aos.css" >

    <link rel="stylesheet" href="${contextPath }/resources/eunji/css/ionicons.min.css" >

    <link rel="stylesheet" href="${contextPath }/resources/eunji/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="${contextPath }/resources/eunji/css/jquery.timepicker.css">

    
    <link rel="stylesheet" href="${contextPath }/resources/eunji/css/flaticon.css">
    <link rel="stylesheet" href="${contextPath }/resources/eunji/css/icomoon.css">
    <link rel="stylesheet" href="${contextPath }/resources/eunji/css/style.css">
  </head>
  <script src="http://code.jquery.com/jquery-latest.min.js"></script>
  <script type="text/javascript">
  
	function _bookmark(articleNO) { //북마크 추가 및 해제
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
	
	function _addCart(articleNO) { //카트에 상품 추가
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
	
	function _goPay(articleNO) { //바로구매
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

    <section id="home-section" class="hero">
        <div class="home-slider owl-carousel">
         <div class="slider-item" style="background-image: url(${contextPath }/resources/eunji/images/bg_1.jpg);">
            <div class="overlay"></div>
           <div class="container">
             <div class="row slider-text justify-content-center align-items-center" data-scrollax-parent="true">

               <div class="col-md-12 ftco-animate text-center">
                 <h1 class="mb-2">We serve Fresh Vegestables &amp; Fruits</h1>
                 <h2 class="subheading mb-4">We deliver organic vegetables &amp; fruits</h2>
                 <p><a href="${contextPath }/seller/listArticles" class="btn btn-primary">상품 보기</a></p>
               </div>

             </div>
           </div>
         </div>

         <div class="slider-item" style="background-image: url(${contextPath }/resources/eunji/images/bg_2.jpg);">
            <div class="overlay"></div>
           <div class="container">
             <div class="row slider-text justify-content-center align-items-center" data-scrollax-parent="true">

               <div class="col-sm-12 ftco-animate text-center">
                 <h1 class="mb-2">100% Fresh &amp; Organic Foods</h1>
                 <h2 class="subheading mb-4">We deliver organic vegetables &amp; fruits</h2>
                 <p><a href="${contextPath }/seller/listArticles" class="btn btn-primary">상품 보기</a></p>
               </div>

             </div>
           </div>
         </div>
       </div>
    </section>

    <section class="ftco-section">
       <div class="container">
            <div class="row justify-content-center mb-3 pb-3">
          <div class="col-md-12 heading-section text-center ftco-animate">
            <h2 class="mb-4">Recommended Products</h2>
          </div>
        </div>         
       </div>
       <div class="container">
          <div class="row">
          <c:forEach var="recom" items="${recomList }">
             <div class="col-md-6 col-lg-3 ftco-animate">
                <div class="product">
                   <a href="${contextPath }/seller/viewArticle?articleNO=${recom.articleNO}" class="img-prod"><img class="img-fluid" src="${contextPath}/download.do?articleNO=${recom.articleNO}&imageFileName=${recom.imageVO.imageFileName}" alt="Colorlib Template" style="width:100%;height:260px;">
                   </a>
                   <div class="text py-3 pb-4 px-3 text-center">
                      <h3><a href="#">${recom.articleVO.title }</a></h3>
                      <div class="d-flex">
                         <div class="pricing">
                            <p class="price"><span>${recom.articleVO.price }원</span></p>
                         </div>
                      </div>
                      <div class="bottom-area d-flex px-3">
                         <div class="m-auto d-flex">
                            <a href="#" class="add-to-cart d-flex justify-content-center align-items-center text-center" onclick="_goPay(${recom.articleNO})">
                               <span><i class="ion-ios-menu"></i></span>
                            </a>
                            <a href="#" class="buy-now d-flex justify-content-center align-items-center mx-1"  onclick="_addCart(${recom.articleNO})">
                               <span><i class="ion-ios-cart"></i></span>
                            </a>
                            <a href="#" class="heart d-flex justify-content-center align-items-center " onclick="_bookmark(${recom.articleNO})">
                               <span><i class="ion-ios-heart"></i></span>
                            </a>
                         </div>
                      </div>
                   </div>
                </div>
             </div>
            </c:forEach>
          </div>
       </div>
    </section>
      
    <section class="ftco-section img" style="background-image: url(${contextPath }/resources/eunji/images/back.jpeg);padding:4em 0; padding-top:6em">
    <div class="container">
	<%
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String apiKey="apiKey";
	
	//서비스 명
	String serviceName="monthFd";
	Calendar aCalendar = Calendar.getInstance();
	
	//선택년도
	String thisYear = "";
	aCalendar = Calendar.getInstance();
	thisYear = String.valueOf(aCalendar.get(Calendar.YEAR)-1);
	
	//선택월
	String thisMonth = "";
	aCalendar = Calendar.getInstance();
	int month = aCalendar.get(Calendar.MONTH) + 1;
	thisMonth = String.format("%02d", month);
	
	//기관 코드
	if(true){
		//오퍼레이션 명
		String operationName="monthFdYearLst";
	
		//XML 받을 URL 생성
		String parameter = "/"+serviceName+"/"+operationName;
		parameter += "?apiKey="+ apiKey;
	
		//서버와 통신
		URL apiUrl = new URL("http://api.nongsaro.go.kr/service"+parameter);
		InputStream apiStream = apiUrl.openStream();
	
		Document doc = null;
		try{
			//xml document
			doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(apiStream);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			apiStream.close();
		}
	
		int size = 0;
	
		NodeList items = null;
		NodeList codeNms = null;
	
		items = doc.getElementsByTagName("item");
		size = doc.getElementsByTagName("item").getLength();
		codeNms = doc.getElementsByTagName("year");
	
		if(size==0){
	%>
		<h3>조회한 정보가 없습니다.</h3>
	<%
		}else{
	%>
		<form name="searchYearForm">
		<input type="hidden" name="cntntsNo"/>
		</form>
	<%
		}
	}
	%>
	
	<%
		//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
		apiKey="apiKey"; //apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
		//서비스 명
		//오퍼레이션 명
		String operationName="monthFdmtLst";
	
		//XML 받을 URL 생성
		String parameter = "/"+serviceName+"/"+operationName;
		parameter += "?apiKey="+ apiKey;
		parameter += "&thisYear="+thisYear;
		parameter += "&thisMonth="+thisMonth;
	
	
		//서버와 통신
		URL apiUrl = new URL("http://api.nongsaro.go.kr/service"+parameter);
	
		InputStream apiStream = apiUrl.openStream();
	
		Document doc = null;
		try{
			//xml document
			doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(apiStream);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			apiStream.close();
		}
	
		int size = 0;
	
		NodeList items = null;
		NodeList cntntsNos = null;
		NodeList rtnImgSeCodes = null;
		NodeList rtnFileCourss = null;
		NodeList rtnStreFileNms = null;
		NodeList fdmtNms = null;
	
	
		items = doc.getElementsByTagName("item");
		size = doc.getElementsByTagName("item").getLength();
		cntntsNos = doc.getElementsByTagName("cntntsNo");
		rtnImgSeCodes = doc.getElementsByTagName("rtnImgSeCode");
		rtnFileCourss = doc.getElementsByTagName("rtnFileCours");
		rtnStreFileNms = doc.getElementsByTagName("rtnStreFileNm");
		fdmtNms = doc.getElementsByTagName("fdmtNm");
	
	
		if(size==0){ %>
		<h3>조회한 정보가 없습니다.</h3>
	<%	}else{ %>
	
	<%
			for(int i=0; i<size; i++){
				//키값
				String cntntsNo = cntntsNos.item(i).getFirstChild() == null ? "" : cntntsNos.item(i).getFirstChild().getNodeValue();
				//파일구분코드
				String rtnImgSeCode = rtnImgSeCodes.item(i).getFirstChild() == null ? "" : rtnImgSeCodes.item(i).getFirstChild().getNodeValue();
				//파일경로
				String rtnFileCours = rtnFileCourss.item(i).getFirstChild() == null ? "" : rtnFileCourss.item(i).getFirstChild().getNodeValue();
				//파일명
				String rtnStreFileNm = rtnStreFileNms.item(i).getFirstChild() == null ? "" : rtnStreFileNms.item(i).getFirstChild().getNodeValue();
				//파일제목
				String fdmtNm = fdmtNms.item(i).getFirstChild() == null ? "" : fdmtNms.item(i).getFirstChild().getNodeValue();
	
				int imgCnt =-1;
				String[] rtnImgSeCodeArr= rtnImgSeCode.split("\\|");
				for(int k=0; k < rtnImgSeCodeArr.length; k++){
					if("209006".equals(rtnImgSeCodeArr[k])){
						imgCnt = k;
					}
				}
				String imgUrl ="http://www.nongsaro.go.kr/ps/img/common/anvil_img.jpg";
				if(imgCnt > -1){
					String[] rtnFileCoursArr = rtnFileCours.split("\\|");
					String[] rtnStreFileNmArr = rtnStreFileNm.split("\\|");
					imgUrl = "http://www.nongsaro.go.kr/"+ rtnFileCoursArr[imgCnt] +"/"+ rtnStreFileNmArr[imgCnt];
				}
				%>
				<div class="row justify-content-end">
				<%
				if(!fdmtNm.equals("닭가슴살/닭안심")) {
				%>
				<img src="<%=imgUrl%>" alt="<%=fdmtNm%>"  title="<%=fdmtNm%>" style="width: 48%;float:left;margin-right:1%;"/>
				<%
				}
				%>
		
	<%
	//이달의음식 상세조회
		operationName="monthFdmtDtl";
	
		//XML 받을 URL 생성
		parameter = "/"+serviceName+"/"+operationName;
		parameter += "?apiKey="+ apiKey;
		parameter += "&cntntsNo="+ cntntsNo;
	
		//서버와 통신
		apiUrl = new URL("http://api.nongsaro.go.kr/service"+parameter);
		apiStream = apiUrl.openStream();
	
		doc = null;
		try{
			//xml document
			doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(apiStream);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			apiStream.close();
		}
		//식재료명
		fdmtNm = null;
		//영양성분효능
		String ntrIrdntEfcyDtl = null;
		String[] textArray;
	
		try{cntntsNo = doc.getElementsByTagName("cntntsNo").item(0).getFirstChild().getNodeValue();}catch(Exception e){cntntsNo = "";}
		try{fdmtNm = doc.getElementsByTagName("fdmtNm").item(0).getFirstChild().getNodeValue();}catch(Exception e){fdmtNm = "";}
		try{ntrIrdntEfcyDtl = doc.getElementsByTagName("ntrIrdntEfcyDtl").item(0).getFirstChild().getNodeValue();}catch(Exception e){ntrIrdntEfcyDtl = "";}
		ntrIrdntEfcyDtl=ntrIrdntEfcyDtl.replaceAll("\n", "<br/>");
		ntrIrdntEfcyDtl=ntrIrdntEfcyDtl.replaceAll("■", "●");
		
		textArray=ntrIrdntEfcyDtl.split(""); //String을 String배열에 저장
		
		int cnt=0; //"-"의 개수를 카운트하기 위한 변수
		int idx=-1;
		
		for(int j=0;j<ntrIrdntEfcyDtl.length();j++) {
			if(cnt!=4 && textArray[j].equals("●")) { //영양성분효능을 3가지만 표시되도록 하기 위함.
				cnt=cnt+1;
				idx=j; //인덱스 저장
			}
			else if(cnt==4)
				break;
		}
		if(idx!=-1 && cnt==4) {
			ntrIrdntEfcyDtl=ntrIrdntEfcyDtl.substring(0,idx);
		}
	%>
	
	<%
	if(!fdmtNm.equals("닭가슴살/닭안심")) {
	%>
		<div class="col-md-6 heading-section ftco-animate deal-of-the-day ftco-animate">
		<span class="subheading">Seasonal vegetables</span>
			 <h2 class="mb-2" style="font-size:22px;"><%=fdmtNm%></h2>
			 <p><%=ntrIrdntEfcyDtl%></p>
		</div>
		</div>
		<br>
	<%
			}
		}
	}
	%>
	<br>
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
  <script src="${contextPath }/resources/eunji/js/main.js"></script>
    
  </body>
</html>